Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8423DDD96
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 18:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhHBQZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 12:25:39 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:45686 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhHBQZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 12:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1627921523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZvCDcqb1v2qBAOPyLH/TmAcLBVklhgYMQcY4XA3Blkg=;
        b=eMN/70cSZPBt+8Qvekj8w701A9aY3Z2MEdBvzEV29BDx0cltHurjoJzdf90qs3L+hfE+WY
        0bR3ZnINqalJRC7HZyzxRyEF1pdC+jqHMOcGskvAF8IdFFp94A8SL8DO5DfZU7mRv6ImGP
        G66WbNeUwSQbrvrRRmDCswoWnbEg8jU=
From:   Sven Eckelmann <sven@narfation.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Taehee Yoo <ap420073@gmail.com>, linux-kernel@vger.kernel.org,
        Sven Eckelmann <sven@narfation.org>,
        =?UTF-8?q?M=C3=A1rio=20Lopes?= <ml@simonwunderlich.de>
Subject: [PATCH] debugfs: Return error during {full/open}_proxy_open() on rmmod
Date:   Mon,  2 Aug 2021 18:24:44 +0200
Message-Id: <20210802162444.7848-1-sven@narfation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a kernel module gets unloaded then it printed report about a leak before
commit 275678e7a9be ("debugfs: Check module state before warning in
{full/open}_proxy_open()"). An additional check was added in this commit to
avoid this printing. But it was forgotten that the function must return an
error in this case because it was not actually opened.

As result, the systems started to crash or to hang when a module was
unloaded while something was trying to open a file.

Fixes: 275678e7a9be ("debugfs: Check module state before warning in {full/open}_proxy_open()")
Reported-by: Mário Lopes <ml@simonwunderlich.de>
Cc: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 fs/debugfs/file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index df00231d3ecc..7d162b0efbf0 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -179,8 +179,10 @@ static int open_proxy_open(struct inode *inode, struct file *filp)
 	if (!fops_get(real_fops)) {
 #ifdef CONFIG_MODULES
 		if (real_fops->owner &&
-		    real_fops->owner->state == MODULE_STATE_GOING)
+		    real_fops->owner->state == MODULE_STATE_GOING) {
+			r = -ENXIO;
 			goto out;
+		}
 #endif
 
 		/* Huh? Module did not clean up after itself at exit? */
@@ -314,8 +316,10 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
 	if (!fops_get(real_fops)) {
 #ifdef CONFIG_MODULES
 		if (real_fops->owner &&
-		    real_fops->owner->state == MODULE_STATE_GOING)
+		    real_fops->owner->state == MODULE_STATE_GOING) {
+			r = -ENXIO;
 			goto out;
+		}
 #endif
 
 		/* Huh? Module did not cleanup after itself at exit? */
-- 
2.30.2

