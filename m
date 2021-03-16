Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2390233E240
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 00:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCPXji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 19:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhCPXjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 19:39:33 -0400
X-Greylist: delayed 459 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 Mar 2021 16:39:30 PDT
Received: from mail.sampaio.xyz (unknown [IPv6:2001:19f0:5:59a9:5400:2ff:fed9:71af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471F8C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 16:39:30 -0700 (PDT)
Received: from [IPv6:2804:14d:5cd3:8f4f:2b42:c6:c1a5:6693] (unknown [IPv6:2804:14d:5cd3:8f4f:2b42:c6:c1a5:6693])
        by mail.sampaio.xyz (Postfix) with ESMTPSA id 1D10D38670;
        Tue, 16 Mar 2021 23:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sampaio.xyz; s=mail;
        t=1615937506; bh=Au/1p1a+NOvX1efl1sFf8+kAK4nVouA2n2GbCcDyONQ=;
        h=To:Cc:From:Subject:Date:From;
        b=DwhQBIyxvmloGqIE7jWyODi2EcpgZzG8Kal3ONNy6gbsGfpXTlYPoxV/qVDX5C/P1
         xk/HPaRTlHKueld3Wom/HwrNDxeN36pkP3cMSSfAyuYkxNbuBNjWmz9RihdRgZ8wMn
         tuNiktYYZtUqCIn2XnSV9qRo7jy2CrW+heS/oAHAmZQOZaFRGNas0K1Ga8QXH1W3s2
         pMuWvzIXUEZINNZVVKs78Kgpv1XovRsR6PALFZCC2PGwsP9qbOzLgh3ztiQ+PqVwqu
         EZfyNb4KHqj0dqNUOepemAOb595lVVaoSeBhjeEk6EuX9lRcByLSQFvGSALDOLw2AS
         tEYv8bk/W8ksg==
To:     zbr@ioremap.net
Cc:     linux-kernel@vger.kernel.org
From:   Luiz Sampaio <luiz@sampaio.xyz>
Subject: [PATCH] w1: ds2438: fixing bug in get_page function
Message-ID: <212a5f51-11d6-c1e7-fb98-fdb755efdf9d@sampaio.xyz>
Date:   Tue, 16 Mar 2021 20:32:28 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the w1_ds2438_get_page function, there is an argument to change the page
number you want to read from the chip. But this was always getting the page
0, not the pageno page. Fixed it.

Also fixed coding style issue.

Signed-off-by: Luiz Sampaio <luiz@sampaio.xyz>
---
 drivers/w1/slaves/w1_ds2438.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 5cfb0ae23e91..0eb667f0cf6e 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -62,13 +62,13 @@ static int w1_ds2438_get_page(struct w1_slave *sl, int pageno, u8 *buf)
         if (w1_reset_select_slave(sl))
             continue;
         w1_buf[0] = W1_DS2438_RECALL_MEMORY;
-        w1_buf[1] = 0x00;
+        w1_buf[1] = pageno;
         w1_write_block(sl->master, w1_buf, 2);
 
         if (w1_reset_select_slave(sl))
             continue;
         w1_buf[0] = W1_DS2438_READ_SCRATCH;
-        w1_buf[1] = 0x00;
+        w1_buf[1] = pageno;
         w1_write_block(sl->master, w1_buf, 2);
 
         count = w1_read_block(sl->master, buf, DS2438_PAGE_SIZE + 1);
@@ -154,11 +154,10 @@ static int w1_ds2438_change_config_bit(struct w1_slave *sl, u8 mask, u8 value)
 
         if ((status & mask) == value)
             return 0;    /* already set as requested */
-        else {
-            /* changing bit */
-            status ^= mask;
-            perform_write = 1;
-        }
+
+        /* changing bit */
+        status ^= mask;
+        perform_write = 1;
         break;
     }
 
@@ -287,9 +286,9 @@ static ssize_t iad_read(struct file *filp, struct kobject *kobj,
     if (!buf)
         return -EINVAL;
 
-    if (w1_ds2438_get_current(sl, &voltage) == 0) {
+    if (w1_ds2438_get_current(sl, &voltage) == 0)
         ret = snprintf(buf, count, "%i\n", voltage);
-    } else
+    else
         ret = -EIO;
 
     return ret;
@@ -338,9 +337,9 @@ static ssize_t temperature_read(struct file *filp, struct kobject *kobj,
     if (!buf)
         return -EINVAL;
 
-    if (w1_ds2438_get_temperature(sl, &temp) == 0) {
+    if (w1_ds2438_get_temperature(sl, &temp) == 0)
         ret = snprintf(buf, count, "%i\n", temp);
-    } else
+    else
         ret = -EIO;
 
     return ret;
@@ -359,9 +358,9 @@ static ssize_t vad_read(struct file *filp, struct kobject *kobj,
     if (!buf)
         return -EINVAL;
 
-    if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VAD, &voltage) == 0) {
+    if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VAD, &voltage) == 0)
         ret = snprintf(buf, count, "%u\n", voltage);
-    } else
+    else
         ret = -EIO;
 
     return ret;
@@ -380,15 +379,15 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
     if (!buf)
         return -EINVAL;
 
-    if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VDD, &voltage) == 0) {
+    if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VDD, &voltage) == 0)
         ret = snprintf(buf, count, "%u\n", voltage);
-    } else
+    else
         ret = -EIO;
 
     return ret;
 }
 
-static BIN_ATTR(iad, S_IRUGO | S_IWUSR | S_IWGRP, iad_read, iad_write, 0);
+static BIN_ATTR(iad, 0664, iad_read, iad_write, 0);
 static BIN_ATTR_RO(page0, DS2438_PAGE_SIZE);
 static BIN_ATTR_RO(temperature, 0/* real length varies */);
 static BIN_ATTR_RO(vad, 0/* real length varies */);
-- 
2.30.1

