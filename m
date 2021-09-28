Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F369D41B74D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242333AbhI1TRQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Sep 2021 15:17:16 -0400
Received: from mail1.shanghaitech.edu.cn ([119.78.254.90]:45446 "EHLO
        mail.shanghaitech.edu.cn" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229678AbhI1TRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:17:14 -0400
Received: from [10.15.44.215] by mail.shanghaitech.edu.cn with MESSAGESEC ESMTP id 456892014380931;
        Wed, 29 Sep 2021 03:15:28 +0800 (CST)
Received: from DESKTOP-FOJ6ELG.localdomain (10.15.44.220) by
 smtp.shanghaitech.edu.cn (10.15.44.215) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Wed, 29 Sep 2021 03:15:28 +0800
From:   Mianhan Liu <liumh1@shanghaitech.edu.cn>
To:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Mianhan Liu <liumh1@shanghaitech.edu.cn>
Subject: [PATCH -next] drivers/auxdisplay/ht16k33.c: remove superfluous header files from ht16k33.c
Date:   Wed, 29 Sep 2021 03:15:09 +0800
Message-ID: <20210928191509.3806-1-liumh1@shanghaitech.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.15.44.220]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ht16k33.c hasn't use any macro or function declared in linux/slab.h.
Thus, these files can be removed from ht16k33.c safely without
affecting the compilation of the drivers/auxdisplay/ module

Signed-off-by: Mianhan Liu <liumh1@shanghaitech.edu.cn>

---
 drivers/auxdisplay/ht16k33.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index 1e69cc6d2..6502bc00e 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -13,7 +13,6 @@
 #include <linux/i2c.h>
 #include <linux/of.h>
 #include <linux/fb.h>
-#include <linux/slab.h>
 #include <linux/backlight.h>
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
-- 
2.25.1


