Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995B141B6E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242368AbhI1TIl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Sep 2021 15:08:41 -0400
Received: from mail.shanghaitech.edu.cn ([119.78.254.11]:4740 "EHLO
        mail.shanghaitech.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242248AbhI1TIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:08:40 -0400
Received: from [10.15.44.215] by mail.shanghaitech.edu.cn with MESSAGESEC ESMTP id 480401368080845;
        Wed, 29 Sep 2021 03:06:53 +0800 (CST)
Received: from DESKTOP-FOJ6ELG.localdomain (10.15.44.220) by
 smtp.shanghaitech.edu.cn (10.15.44.215) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Wed, 29 Sep 2021 03:06:51 +0800
From:   Mianhan Liu <liumh1@shanghaitech.edu.cn>
To:     Miguel Ojeda <ojeda@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Mianhan Liu <liumh1@shanghaitech.edu.cn>
Subject: [PATCH -next] drivers/auxdisplay//ks0108.c: remove superfluous header files from ks0108.c
Date:   Wed, 29 Sep 2021 03:06:44 +0800
Message-ID: <20210928190644.25503-1-liumh1@shanghaitech.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.15.44.220]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ks0108.c hasn't use any macro or function declared in linux/fs.h,
linux/io.h and linux/uaccess.h.
Thus, these files can be removed from ks0108.c safely without
affecting the compilation of the drivers/auxdisplay/ module

Signed-off-by: Mianhan Liu <liumh1@shanghaitech.edu.cn>

---
 drivers/auxdisplay/ks0108.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/auxdisplay/ks0108.c b/drivers/auxdisplay/ks0108.c
index e871b94a1..234f9dbe6 100644
--- a/drivers/auxdisplay/ks0108.c
+++ b/drivers/auxdisplay/ks0108.c
@@ -15,10 +15,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
-#include <linux/fs.h>
-#include <linux/io.h>
 #include <linux/parport.h>
-#include <linux/uaccess.h>
 #include <linux/ks0108.h>
 
 #define KS0108_NAME "ks0108"
-- 
2.25.1


