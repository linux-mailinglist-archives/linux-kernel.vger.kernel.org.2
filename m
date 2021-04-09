Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8513592DC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhDIDPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbhDIDPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:15:04 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869CEC061762;
        Thu,  8 Apr 2021 20:14:52 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id h3so1233900qve.13;
        Thu, 08 Apr 2021 20:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MZVVGzNYcMxmtISNSUfUMnz2s444oX5WOS+3c0FDAUg=;
        b=nQ6a6moNbQ+DcpgT1m9g70qQjy89DfNqx0liE6U4Y9bbZLy5ckkPi/Loy82BiMUyqK
         hw44MehYX3mauAQAekXMpqbZgIkm7vrYTeAlX3L3gf0BRyo/+tN5E8CzYAanHwXMhe9T
         oVD01MXeRdKj0tuiKg9208Pzdy9dWXolETKNdwqBlL7GGY8I8RcXHktNsiHk0F3WeBtt
         YVCq5uzM/LIxkP++a5bvp80DqkhQLJp6UGagXpKLZ5LZmc0No5KxSV967Zq1PEV5BB6V
         HcJfb+r2ZcjBJtGD/gPa+cwICY4AaCPAsVOsMqsI+VmZvj1q78pe4ruxYDpNbhe7N+sm
         VIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZVVGzNYcMxmtISNSUfUMnz2s444oX5WOS+3c0FDAUg=;
        b=LmqmBvKKsTCSFcgJSh0Bit9Szm36QVLuD7dwe4LJAg+CTGK/nunOb/HtsmBZrT2GBn
         pOLbexAGu8ca743kBF7/PLsNOaRaa3/Ckos78laIvdKYI/nLijRDF3duO092nOZDLA07
         sHg7w/Rxx/WRZoW4ZXrFrF0rDGorCf/0I3yX8FoJqTrqCnsqvLPSGrMCO0W+OuwXdv9r
         N1fQrZmERLDU3n9QxPHcTeetSwr4pCRbEl4utFQSSD4Evp6Kb3h9L/zD/nrH9wycF/JD
         E1lyNsgcmvlyXo7EWJWCQeJ8w1q78H1SP5dtaZVhMpEy+o1v9ZE+Wv8mnmJdETA4pNep
         oDyw==
X-Gm-Message-State: AOAM531qntfOSfL4ACEy8O3Z667YwAn509pc4fuyi1BK/mBNSMex/0xW
        lURMCFlsHCt3R9+kEc4Ug+Y=
X-Google-Smtp-Source: ABdhPJylv2PkcYs1iEg8u4er9Qb7mkiwgk0xlSRkDAF+6l9kNvRiCJoYzFzfdTUV/u6w4MB7i6U54A==
X-Received: by 2002:a05:6214:19c4:: with SMTP id j4mr11912579qvc.27.1617938091309;
        Thu, 08 Apr 2021 20:14:51 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5c21:af45:3b27:576c:7dde:37f1])
        by smtp.gmail.com with ESMTPSA id x1sm1003167qtr.97.2021.04.08.20.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:14:51 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v6 2/6] w1: ds2438: fixed if brackets coding style issue
Date:   Fri,  9 Apr 2021 00:15:29 -0300
Message-Id: <20210409031533.442123-3-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210409031533.442123-1-sampaio.ime@gmail.com>
References: <20210409030942.441830-1-sampaio.ime@gmail.com>
 <20210409031533.442123-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is only one statement inside the if clause, no brackets are
required.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 148921fb9702..56e53a748059 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -287,9 +287,9 @@ static ssize_t iad_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_current(sl, &voltage) == 0) {
+	if (w1_ds2438_get_current(sl, &voltage) == 0)
 		ret = snprintf(buf, count, "%i\n", voltage);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
@@ -338,9 +338,9 @@ static ssize_t temperature_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_temperature(sl, &temp) == 0) {
+	if (w1_ds2438_get_temperature(sl, &temp) == 0)
 		ret = snprintf(buf, count, "%i\n", temp);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
@@ -359,9 +359,9 @@ static ssize_t vad_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VAD, &voltage) == 0) {
+	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VAD, &voltage) == 0)
 		ret = snprintf(buf, count, "%u\n", voltage);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
@@ -380,9 +380,9 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VDD, &voltage) == 0) {
+	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VDD, &voltage) == 0)
 		ret = snprintf(buf, count, "%u\n", voltage);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
-- 
2.30.1

