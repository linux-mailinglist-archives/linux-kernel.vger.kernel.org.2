Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2B83705C4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 07:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhEAFv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 01:51:26 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21342 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhEAFvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 01:51:25 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1619848231; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=MEuaBE865UaMq2cEXsOrNCuINnEI2NKO5mtAPluD0Xm16H/M9yx/NSyBCvB6WiHIKqZr1QK4JK7OLSqbRJlJ/OWays7iMGF5mMAMHk9YC8Pfu0DT0XfYJirahZ7IulVJ/FYNgfd/+C9r8SeUbHCkyJKRUK3ONZSpL5gQF0KVHT0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1619848231; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=6A9yXCsgHIpBF4gz2/JnwOLwuTHlW112ZF9OkzGdxaU=; 
        b=BAtEHIRvtgzrf75FxzoFbTDT7s1XehXHDry/yN1AcLcl5YLVHmwtJSlBDAYmwpXY+1rANDM5p7KichOnT7+vgqUQzSWEi8ss0mPj0sqZumCF3jeVC6UeDShQLTwhd+I2iPNZJSdjJsw7VjP43wScKfuXeeOTm6uZMYIUol1/J90=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1619848231;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=6A9yXCsgHIpBF4gz2/JnwOLwuTHlW112ZF9OkzGdxaU=;
        b=qsNTF+jjZ695CrjqHkWwIVmWCFbdW0L0fPwzoUh2ZD79N7ogD028wV063HI9JjPs
        m9Johr7bvhGhJpMaZlmhXj4R1rReH/rV9vqNQnRA3/uZfNy5/VUREk90bgxgGIbrb5M
        nb+Sqc0LwxbUMgGXcsYimTfnzuY1Gf1WfLfb1Dq4=
Received: from localhost.localdomain (49.207.211.62 [49.207.211.62]) by mx.zohomail.com
        with SMTPS id 1619848228732115.49195201466569; Fri, 30 Apr 2021 22:50:28 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Cc:     gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Anirudh Rayabharam <mail@anirudhrb.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rapidio: remove unused variable in rio_cm.c
Date:   Sat,  1 May 2021 11:20:17 +0530
Message-Id: <20210501055018.9244-1-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable 'rc' to fix gcc warning:

	drivers/rapidio/rio_cm.c: In function ‘rio_txcq_handler’:
	drivers/rapidio/rio_cm.c:673:7: warning: variable ‘rc’ set but
	not used [-Wunused-but-set-variable]

Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
---
 drivers/rapidio/rio_cm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index 50ec53d67a4c..545693bd86a3 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -670,12 +670,11 @@ static void rio_txcq_handler(struct cm_dev *cm, int slot)
 	 */
 	if (!list_empty(&cm->tx_reqs) && (cm->tx_cnt < RIOCM_TX_RING_SIZE)) {
 		struct tx_req *req, *_req;
-		int rc;
 
 		list_for_each_entry_safe(req, _req, &cm->tx_reqs, node) {
 			list_del(&req->node);
 			cm->tx_buf[cm->tx_slot] = req->buffer;
-			rc = rio_add_outb_message(cm->mport, req->rdev, cmbox,
+			rio_add_outb_message(cm->mport, req->rdev, cmbox,
 						  req->buffer, req->len);
 			kfree(req->buffer);
 			kfree(req);
-- 
2.26.2

