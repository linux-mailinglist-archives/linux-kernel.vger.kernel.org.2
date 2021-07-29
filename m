Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A55D3D9DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 08:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhG2Gqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 02:46:48 -0400
Received: from smtpbg587.qq.com ([113.96.223.105]:41589 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234079AbhG2Gqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 02:46:46 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Jul 2021 02:46:45 EDT
X-QQ-mid: bizesmtp48t1627540765tzn7ojqz
Received: from ubuntu.localdomain (unknown [125.70.163.57])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 29 Jul 2021 14:39:20 +0800 (CST)
X-QQ-SSF: 01000000007000002000B00A0000000
X-QQ-FEAT: oPf+tCeE8zEPcylxTudXumjqzXwv07oRNg+GgOpGSNKn2gdkrd6rWwot4RoLs
        /nSgbzYScE3IrvlV6CnZf7hMDjIvglD7fxbJvxDlzv2BvC2c+gzCE1/As8wO0qbN9zq86z/
        Q2KxbRvqC6moFWJ94RsahrjVwl2uuELc3FJvkENJ1lKPXz0Mbnn5FrbdpthRW9qJHuLxAJd
        fCTZ3R32dVy2bBCG1grDclU8jGT+PP0YGY/mtszQG4sCEx7bS2zUU/OyebpWcdxQPdKXfJF
        Tau6kE/47d5u2ft16z7a+x+kFlUaqLsmPw/ajxLiZ08G/IY/qlgZKKHA4=
X-QQ-GoodBg: 0
From:   Huiquan Deng <denghuiquan@cdjrlc.com>
To:     ojeda@kernel.org
Cc:     linux-kernel@vger.kernel.org, Huiquan Deng <denghuiquan@cdjrlc.com>
Subject: [PATCH] auxdisplay: code indent should use tabs where possible
Date:   Wed, 28 Jul 2021 23:39:10 -0700
Message-Id: <20210729063910.63984-1-denghuiquan@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolves the checkpatch error.

Signed-off-by: Huiquan Deng <denghuiquan@cdjrlc.com>
---
 drivers/auxdisplay/cfag12864bfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/cfag12864bfb.c b/drivers/auxdisplay/cfag12864bfb.c
index d66821adf453..1e040e83d1c1 100644
--- a/drivers/auxdisplay/cfag12864bfb.c
+++ b/drivers/auxdisplay/cfag12864bfb.c
@@ -41,8 +41,8 @@ static const struct fb_var_screeninfo cfag12864bfb_var = {
 	.yres_virtual = CFAG12864B_HEIGHT,
 	.bits_per_pixel = 1,
 	.red = { 0, 1, 0 },
-      	.green = { 0, 1, 0 },
-      	.blue = { 0, 1, 0 },
+	.green = { 0, 1, 0 },
+	.blue = { 0, 1, 0 },
 	.left_margin = 0,
 	.right_margin = 0,
 	.upper_margin = 0,
@@ -69,8 +69,8 @@ static const struct fb_ops cfag12864bfb_ops = {
 
 static int cfag12864bfb_probe(struct platform_device *device)
 {
+	struct fb_info *info = framebuffer_alloc(0, &device->dev);
 	int ret = -EINVAL;
- 	struct fb_info *info = framebuffer_alloc(0, &device->dev);
 
 	if (!info)
 		goto none;
-- 
2.17.1

