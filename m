Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C86D44F141
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 05:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbhKMEna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 23:43:30 -0500
Received: from smtpbg604.qq.com ([59.36.128.82]:36216 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232329AbhKMEn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 23:43:28 -0500
X-QQ-mid: bizesmtp41t1636778421tkvo9okg
Received: from localhost.localdomain (unknown [125.69.41.88])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 13 Nov 2021 12:40:20 +0800 (CST)
X-QQ-SSF: 01000000000000C0F000C00A0000000
X-QQ-FEAT: FXvDfBZI5O4ZPSh7w95J4xYXfclSDsGXKPecStb0FuWMtQfjyoscsC5z5WinO
        umbYfA61YWKdGgpiBBmiedBniwB+lCgl8na3yUuzDGhVjcOy4GA9JFfRKO/Y5WBc/ODX9pb
        XJuHfcCAEpyRoBZl4GgUqWphQKOwwtQYi56K6hzis3TEGy3x7ta9TSnnmIP1uYI61j71WVw
        Vw8ql8us1UXgRMeWxRUGXsXfKkjOc5P0SH2GmWomPzN+1/Wdaio8eSnv2FYIj/TIwGru1f3
        qoFBTDJqRJqxeXEajHfrpoxYprzUQOH1HOlH/8o7QM/K6A4iH5bp9SLvZYVmLckDD0leYmd
        zG/4UV7wbUuqmP1PSiSfazf9D7jmdQGgj8oU1Wy
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     benh@kernel.crashing.org
Cc:     wangborong@cdjrlc.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Remove a repeated word in a comment
Date:   Sat, 13 Nov 2021 12:40:18 +0800
Message-Id: <20211113044018.130835-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double word `up' in a comment is repeated, thus one of
them should be removed.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/macintosh/mediabay.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
index eab7e83c11c4..ec23094263e7 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -129,7 +129,7 @@ enum {
 /*
  * Functions for polling content of media bay
  */
- 
+
 static u8
 ohare_mb_content(struct media_bay_info *bay)
 {
@@ -331,12 +331,12 @@ static void keylargo_mb_un_reset_ide(struct media_bay_info* bay)
 
 static inline void set_mb_power(struct media_bay_info* bay, int onoff)
 {
-	/* Power up up and assert the bay reset line */
+	/* Power up and assert the bay reset line */
 	if (onoff) {
 		bay->ops->power(bay, 1);
 		bay->state = mb_powering_up;
 		pr_debug("mediabay%d: powering up\n", bay->index);
-	} else { 
+	} else {
 		/* Make sure everything is powered down & disabled */
 		bay->ops->power(bay, 0);
 		bay->state = mb_powering_down;
@@ -577,7 +577,7 @@ static int media_bay_attach(struct macio_dev *mdev,
 		macio_release_resources(mdev);
 		return -ENOMEM;
 	}
-	
+
 	i = media_bay_count++;
 	bay = &media_bays[i];
 	bay->mdev = mdev;
@@ -745,7 +745,7 @@ static int __init media_bay_init(void)
 	if (!machine_is(powermac))
 		return 0;
 
-	macio_register_driver(&media_bay_driver);	
+	macio_register_driver(&media_bay_driver);
 
 	return 0;
 }
-- 
2.33.0

