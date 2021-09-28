Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E091641B77E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242537AbhI1TXm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Sep 2021 15:23:42 -0400
Received: from mail.shanghaitech.edu.cn ([119.78.254.11]:7764 "EHLO
        mail.shanghaitech.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240589AbhI1TXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:23:41 -0400
Received: from [10.15.44.215] by mail.shanghaitech.edu.cn with MESSAGESEC ESMTP id 480401368080845;
        Wed, 29 Sep 2021 03:21:54 +0800 (CST)
Received: from DESKTOP-FOJ6ELG.localdomain (10.15.44.220) by
 smtp.shanghaitech.edu.cn (10.15.44.215) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Wed, 29 Sep 2021 03:21:50 +0800
From:   Mianhan Liu <liumh1@shanghaitech.edu.cn>
To:     Miguel Ojeda <ojeda@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Mianhan Liu <liumh1@shanghaitech.edu.cn>
Subject: [PATCH -next] drivers/auxdisplay/cfag12864bfb.c: remove superfluous header files from cfag12864bfb.c
Date:   Wed, 29 Sep 2021 03:21:42 +0800
Message-ID: <20210928192142.5525-1-liumh1@shanghaitech.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.15.44.220]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cfag12864bfb.c hasn't use any macro or function declared in linux/delay.h,
linux/string.h and linux/uaccess.h.
Thus, these files can be removed from cfag12864bfb.c safely without
affecting the compilation of the drivers/auxdisplay/ module

Signed-off-by: Mianhan Liu <liumh1@shanghaitech.edu.cn>

---
 drivers/auxdisplay/cfag12864bfb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/auxdisplay/cfag12864bfb.c b/drivers/auxdisplay/cfag12864bfb.c
index d66821adf..9e6681f19 100644
--- a/drivers/auxdisplay/cfag12864bfb.c
+++ b/drivers/auxdisplay/cfag12864bfb.c
@@ -12,13 +12,10 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/fb.h>
 #include <linux/mm.h>
 #include <linux/platform_device.h>
-#include <linux/string.h>
-#include <linux/uaccess.h>
 #include <linux/cfag12864b.h>
 
 #define CFAG12864BFB_NAME "cfag12864bfb"
-- 
2.25.1


