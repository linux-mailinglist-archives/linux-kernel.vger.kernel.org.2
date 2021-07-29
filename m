Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326573D9E66
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 09:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhG2H1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 03:27:19 -0400
Received: from smtpbg587.qq.com ([113.96.223.105]:38932 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234317AbhG2H1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 03:27:18 -0400
X-QQ-mid: bizesmtp44t1627543632tsgbcds7
Received: from ubuntu.localdomain (unknown [125.70.163.57])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 29 Jul 2021 15:26:38 +0800 (CST)
X-QQ-SSF: 01000000007000202000000A0000000
X-QQ-FEAT: A5awU/F+CWMsgPFi95NBZH77qYd0xK4VSIwuLgcZ12QhCOH1FLRrDNH52x5CJ
        8u9+LjBLWC3J9SlM/dS9U8bD8zdRPXyCCmS4i5KU/ilcbHQZ7bkEKWlV/jg1SAwdh+TnX4d
        W0WEJ2tbTwyR8ZBg5Wt3St8VJi8RQ1gEcGDd1H0frg9PU/L0kgtfjpEiF7vJMDNbdnHnFWJ
        1zMxHx5HsRKxwptdqfIHT29Gv7EVWKTX1K2SaBIRnc5Ny9djvpcP8WP2gdRoi7bHxEpZx8S
        ctEXTPq7KdYhPhPUBe5RZTbWs20w41j9seFdVOTSmANLfFzVsHvPGsM/1Gn8mXM5wswA==
X-QQ-GoodBg: 0
From:   Huiquan Deng <denghuiquan@cdjrlc.com>
To:     linux-kernel@vger.kernel.org
Cc:     ojeda@kernel.org, Huiquan Deng <denghuiquan@cdjrlc.com>
Subject: [PATCH] auxdisplay: code indent should use tabs where possible
Date:   Thu, 29 Jul 2021 00:26:28 -0700
Message-Id: <20210729072628.68838-1-denghuiquan@cdjrlc.com>
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

