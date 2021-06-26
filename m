Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF3A3B4DF0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 12:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFZKSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 06:18:20 -0400
Received: from smtpbgbr2.qq.com ([54.207.22.56]:55475 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhFZKST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 06:18:19 -0400
X-Greylist: delayed 11826 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Jun 2021 06:18:18 EDT
X-QQ-mid: bizesmtp38t1624702549t9uw3y6i
Received: from localhost.localdomain (unknown [182.148.13.245])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 26 Jun 2021 18:15:45 +0800 (CST)
X-QQ-SSF: 0100000000200060B000C00A0000000
X-QQ-FEAT: bQsUcYFpAAaLX94YKyEuOPU7EfIyqYW6ZFv3fcb1Mv/Uw+EZ+9OOvwRVhMxK0
        a9KePdllB2GWpbskM4BH1Uwzpb0x5+40O7frjBuhlLca6Z7+PRq965UPXQa2OCk6R/P78aN
        huGppsSm8UJjEcukzcqlbRBnpWuXHRLzGHdWh4icBdo8gToIZuCLsg9Wz18h92htd3LI6G4
        XnWi6i2LW6xN9zD6MTO+eoiOL3EUD6amQq2OaVJHxp5JbgTDe2NcBSIZqBRwRfAImkEpRwn
        RG7fdD2cM26/cHYpKgkJOejnNxTkWbNhty4v2odbvihGFkltR+NDKlTs/+tkhsJFslFtq4/
        BZIjltRCEiOjPcbACE=
X-QQ-GoodBg: 0
From:   Jinchao Wang <wjc@cdjrlc.com>
To:     ojeda@kernel.org
Cc:     linux-kernel@vger.kernel.org, wjc@cdjrlc.com
Subject: [PATCH] auxdisplay: Replace symbolic permissions with octal permissions
Date:   Sat, 26 Jun 2021 18:15:38 +0800
Message-Id: <20210626101538.54482-1-wjc@cdjrlc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolve following checkpatch issue,
Replace symbolic permissions with octal permissions

Signed-off-by: Jinchao Wang <wjc@cdjrlc.com>
---
 drivers/auxdisplay/cfag12864b.c | 2 +-
 drivers/auxdisplay/ks0108.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/cfag12864b.c b/drivers/auxdisplay/cfag12864b.c
index fd430e6866a1..6526aa51fb1d 100644
--- a/drivers/auxdisplay/cfag12864b.c
+++ b/drivers/auxdisplay/cfag12864b.c
@@ -33,7 +33,7 @@
  */
 
 static unsigned int cfag12864b_rate = CONFIG_CFAG12864B_RATE;
-module_param(cfag12864b_rate, uint, S_IRUGO);
+module_param(cfag12864b_rate, uint, 0444);
 MODULE_PARM_DESC(cfag12864b_rate,
 	"Refresh rate (hertz)");
 
diff --git a/drivers/auxdisplay/ks0108.c b/drivers/auxdisplay/ks0108.c
index 03c95ad4216c..313c5305416a 100644
--- a/drivers/auxdisplay/ks0108.c
+++ b/drivers/auxdisplay/ks0108.c
@@ -28,11 +28,11 @@
  */
 
 static unsigned int ks0108_port = CONFIG_KS0108_PORT;
-module_param(ks0108_port, uint, S_IRUGO);
+module_param(ks0108_port, uint, 0444);
 MODULE_PARM_DESC(ks0108_port, "Parallel port where the LCD is connected");
 
 static unsigned int ks0108_delay = CONFIG_KS0108_DELAY;
-module_param(ks0108_delay, uint, S_IRUGO);
+module_param(ks0108_delay, uint, 0444);
 MODULE_PARM_DESC(ks0108_delay, "Delay between each control writing (microseconds)");
 
 /*
-- 
2.31.1



