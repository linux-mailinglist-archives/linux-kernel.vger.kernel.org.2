Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3CC375A13
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 20:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhEFSUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 14:20:19 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21313 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhEFSUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 14:20:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620325155; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=KXH6ODj9YZy7EfbkPcfjkM+XlsXfwz397wyKPn9GPHskq/9XSgXxLvskAh7b3IuNp5BqWQEkoF4I/t7OL+TlxVlcjilx9Th88F6LdlJcmd7EXPsfUviIf7YrfWwz2tGzUMflzUguq7t0hRs/0vJgNAKEzCVoqfzUKT+kEpdKPmI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1620325155; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=6DDF2B6OrMM0QxGNsdtFui4c6DfEyuwe9HcAxJ1ve7M=; 
        b=PUCjhE+eFwCtUUjTN/rtTnyQ7FxPmXF7d/N+lNlmfryd8L5Jz2fNcMzSKaH4LV3zqYG34co5g0OqIjw7MjZb4Gyw6h8+rvIs6HTEu6sfLXtX9P3/i9KvGr5X/Ive84FOM0z2p9UYvdAd7sbFvub8wgxwZO9vLCs8dPgurutCBNQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1620325155;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=6DDF2B6OrMM0QxGNsdtFui4c6DfEyuwe9HcAxJ1ve7M=;
        b=MIDzm1rtNT6eSuKiaT8tBDlIfhXPuM2GqIjk3hiech6UoIkTP7VFnfw6AdbgKkqm
        QuXqS72qjniH5CaWVJmQYOLE1rf/dcd5rB5veGYyM5hoo07JdqhjTq/t2JCIEPvtcxE
        BXHZBpyY/2TR/2tCoUmHJLZhWsoPKgDyQS9kq8y8=
Received: from localhost.localdomain (49.207.210.243 [49.207.210.243]) by mx.zohomail.com
        with SMTPS id 1620325151474625.7325176070485; Thu, 6 May 2021 11:19:11 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Cc:     gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Anirudh Rayabharam <mail@anirudhrb.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] rapidio: fix unused variable warning in rio_cm.c
Date:   Thu,  6 May 2021 23:48:36 +0530
Message-Id: <20210506181837.4758-1-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC produces an unused variable warning for 'rc':

	drivers/rapidio/rio_cm.c: In function ‘rio_txcq_handler’:
	drivers/rapidio/rio_cm.c:673:7: warning: variable ‘rc’ set but
	not used [-Wunused-but-set-variable]

The return value of rio_add_outb_message() is assigned to 'rc' but it
is never used. Fix this warning by logging an error if 'rc' is non-zero.

Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
---

Changes in v2:
Log an error instead of just removing 'rc'.

v1: https://lore.kernel.org/lkml/20210501055018.9244-1-mail@anirudhrb.com/

---
 drivers/rapidio/rio_cm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index 50ec53d67a4c..971a36f1a23a 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -677,6 +677,11 @@ static void rio_txcq_handler(struct cm_dev *cm, int slot)
 			cm->tx_buf[cm->tx_slot] = req->buffer;
 			rc = rio_add_outb_message(cm->mport, req->rdev, cmbox,
 						  req->buffer, req->len);
+			if (rc) {
+				riocm_error("Failed to add msg to tx queue (err=%d)",
+						rc);
+			}
+
 			kfree(req->buffer);
 			kfree(req);
 
-- 
2.26.2

