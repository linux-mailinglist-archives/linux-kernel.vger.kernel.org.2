Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D8534559E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhCWCmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCWCla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:41:30 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9897C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 19:41:29 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id j7so13962604qtx.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 19:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BYz4Xbr29cMuSZutvDWf9P0CsWIcBkC52Quo2GveTFY=;
        b=Uhvdt16fOyFCqpIogUllYNbKH2lC25O2Tma5ttNHOdzpxnZAHd8xiF6pgFCHmKIVZ6
         Md1xofztzMh2zpW3NqvGU2TS6+CG/vq482/TPgW0OmcO5gB1BFiPI5O/3uqfZIBGGSFh
         C+hfbfR9kkmnEiso+2nO57x9v6mACIhJW4q+PNcKBks//ffGswA19gd82rVj9q20fIJa
         jLwRKwzyyfsnJLz5jUfWUHto5w2FyQwVLRidNJZ/yldtMHcQPTIvi9misfyAUKtBhOh2
         xx+bkOaRxm6C4kDdUnxfdylC/qRhc0UCEM0R2AlSIjZNVw0EMdz4spLBweNTnGfA8jWn
         2BRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BYz4Xbr29cMuSZutvDWf9P0CsWIcBkC52Quo2GveTFY=;
        b=IYUkjo/QpT89FB3UgQYli8vlJraIipk0RRD6sNUd73ai825nJMNs/tmFAIxshqf70E
         hgP5i8ChXlDpICf9LKUyW8DJ5j1TuJ7Vu9EACWg52IjcZehXbOfomUiW/huRkDW/4NOd
         2fIXHxqJSAydlTh/nIZXNYbAZGy2B/DWvebjUsKKyxwBakqcpa5KAVuIau8qHloCB3rR
         oqhXet1gqWIfREfKnWkdnAe+QimlJF9PH7rYyGtuIS+iVjlYGjqQWwHQCtN1dCXN7vYH
         t9/RV5e1Eyq1oMB0a5zhHOoHiT+OzFxGCC/KutBtTMwrylUSbTAJLSkSbZPn1mpwj1nr
         ngjA==
X-Gm-Message-State: AOAM5324GZvvit87pZMNVMZEid+XlO+7J3p6g3UjzwjA2J7yIRpWhYT4
        3uJRnjgiEegqsBwzZErY0Sg=
X-Google-Smtp-Source: ABdhPJwRpisAImTwr1naIN0HjmipcAi+cIO4mdbRtfwg/iQgyUBXNaatj1otJWYtkBk34pUgGVVdVw==
X-Received: by 2002:a05:622a:1647:: with SMTP id y7mr2609300qtj.210.1616467289140;
        Mon, 22 Mar 2021 19:41:29 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:5155:3abd:5705:9236])
        by smtp.gmail.com with ESMTPSA id h8sm5036391qta.53.2021.03.22.19.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 19:41:28 -0700 (PDT)
Date:   Mon, 22 Mar 2021 23:42:09 -0300
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     rikard.falkeborn@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] w1: ds2438: fixed a coding style issues
Message-ID: <20210323024209.nhf7dgrdooca363g@LuizSampaio-PC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed coding style issues.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 5cfb0ae23e91..a9884fc8c726 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -154,11 +154,9 @@ static int w1_ds2438_change_config_bit(struct w1_slave *sl, u8 mask, u8 value)
 
 		if ((status & mask) == value)
 			return 0;	/* already set as requested */
-		else {
-			/* changing bit */
-			status ^= mask;
-			perform_write = 1;
-		}
+		/* changing bit */
+		status ^= mask;
+		perform_write = 1;
 		break;
 	}
 
@@ -287,9 +285,9 @@ static ssize_t iad_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_current(sl, &voltage) == 0) {
+	if (w1_ds2438_get_current(sl, &voltage) == 0)
 		ret = snprintf(buf, count, "%i\n", voltage);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
@@ -338,9 +336,9 @@ static ssize_t temperature_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_temperature(sl, &temp) == 0) {
+	if (w1_ds2438_get_temperature(sl, &temp) == 0)
 		ret = snprintf(buf, count, "%i\n", temp);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
@@ -359,9 +357,9 @@ static ssize_t vad_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VAD, &voltage) == 0) {
+	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VAD, &voltage) == 0)
 		ret = snprintf(buf, count, "%u\n", voltage);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
@@ -380,15 +378,15 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VDD, &voltage) == 0) {
+	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VDD, &voltage) == 0)
 		ret = snprintf(buf, count, "%u\n", voltage);
-	} else
+	else
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

