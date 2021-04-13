Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A1635DC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243782AbhDMKVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 06:21:18 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21362 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241611AbhDMKVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:21:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1618309251; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ODcPpqHNFa6nSHdLSluGPXsM+qbnDv344uJSwsE3XE0vvpNv5a01KIMvV7rkXF8aUD9l4P5G0+BCvNimDgTqle8d6B8VCTR5lbI8UjEA1DuNtQpgnRKR0u8OWHCbd3P7LQWsmDZDyvbFGmASUHe4PwwVNsBIHnIX3CQd9pXlA8I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1618309251; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=70LOhFP4xJsLfGUJFDZwNxh3gUlmcq/n+gv9JegQTlA=; 
        b=LsTwK90yAZY6mjAZM6H36SXYwnNEBq3QvW5EWIhJgSps4woT6uHsof3vUCKX/l/vOxQnrk0/T6iKlq0+6230KQD+pQn9zoArJWLsxF1hyd7vrsh8caiOw4OEqzEOsLbi6Se3wUeR6K9Tytwr0qmO7TwHrajZAyPPP/WxNNSfGLo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1618309251;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=70LOhFP4xJsLfGUJFDZwNxh3gUlmcq/n+gv9JegQTlA=;
        b=pQa4zxgK/JKHhny6xaW+5hWAKXzWf7aku8djSWwvAlg10eBAJU3agFn+nZAionza
        wElIH18avLkU7Mdn36A20rDjXuotrcHa/K8BzEJbINodMLEULzdria62Vbw8fczsthn
        ZNQ2azCSD8UfGBLW/nmXw1eprKyJdU4jp5fpKuJ8=
Received: from localhost.localdomain (49.207.222.140 [49.207.222.140]) by mx.zohomail.com
        with SMTPS id 161830924786833.2106187151885; Tue, 13 Apr 2021 03:20:47 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Junyong Sun <sunjy516@gmail.com>
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware_loader: fix use-after-free in firmware_fallback_sysfs
Date:   Tue, 13 Apr 2021 15:49:25 +0530
Message-Id: <20210413101925.30612-1-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use-after-free happens when a fw_priv object has been freed but
hasn't been removed from the pending list (pending_fw_head). The next
time fw_load_sysfs_fallback tries to insert into the list, it ends up
accessing the pending_list member of the previoiusly freed fw_priv.

In bcfbd3523f3c ("firmware: fix a double abort case with
fw_load_sysfs_fallback"), fw_load_abort() is skipped if
fw_sysfs_wait_timeout() returns -ENOENT. This causes the fw_priv to
not be removed from the pending list.

To fix this, delete the fw_priv from the pending list when retval
is -ENOENT instead of skipping the entire block.

Fixes: bcfbd3523f3c ("firmware: fix a double abort case with fw_load_sysfs_fallback")
Reported-and-tested-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
---
 drivers/base/firmware_loader/fallback.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 91899d185e31..56ae4ab3199d 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -526,9 +526,14 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
 	}
 
 	retval = fw_sysfs_wait_timeout(fw_priv, timeout);
-	if (retval < 0 && retval != -ENOENT) {
+	if (retval < 0) {
 		mutex_lock(&fw_lock);
-		fw_load_abort(fw_sysfs);
+
+		if (retval != -ENOENT)
+			fw_load_abort(fw_sysfs);
+		else
+			list_del_init(&fw_priv->pending_list);
+
 		mutex_unlock(&fw_lock);
 	}
 
-- 
2.26.2

