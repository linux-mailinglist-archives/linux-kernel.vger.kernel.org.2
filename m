Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F707362AF4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbhDPWRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbhDPWRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:17:18 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4C8C061574;
        Fri, 16 Apr 2021 15:16:53 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d6so3661543qtx.13;
        Fri, 16 Apr 2021 15:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MZVVGzNYcMxmtISNSUfUMnz2s444oX5WOS+3c0FDAUg=;
        b=QYHZo5DKgnR7fEsqf/pzsSNMzqWsjQfpT6W8k9ugoUmyaWcl4JfR4jc4GkFeqE0b0g
         NfnfyccX/4bvqsAEHK9aaygrTXpj+IdT+dZE+7GxpAOy9YNfDUIEbtXqxCcalkHiIglu
         UsHYbQzfdVuP2i6178VKHF2yMyYmMPxOmUhPrn6f/k306CmrWl79S1LygIgs9aVcvo/U
         puONKQVzRwOqaoJRFByGibhYPaousAmt4oBKUyGaik+aex+OGcCI0PBrX5fvhph2lkbJ
         F+II4Wunh3UtF21Uu0cpDkbHmgGe/fy1Z8R+VU4Rbs4ct0HkIuDkD+AdPJlT1zXKwJKP
         OEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZVVGzNYcMxmtISNSUfUMnz2s444oX5WOS+3c0FDAUg=;
        b=kersh5N/glIdphxbebN+wsTMdWKWdSW+NcSn/hS2G2LymTvX0RJ8yYcQ5s+BWYrLHi
         YdmiUgiq2uhC6F3K5QZ7Hc+vv63O9ANTemtAXdN1GWMrIoWpi1gdAtu3YBrbEnVjtH8T
         B/cFhyamejpmAZl3kE4wmu2k4Xw4fa6/OvpQ6lM2rY+4w7SmvJQXmODgJg+p8Lx83fMv
         fZHD1JwKDcYzq4J8PWQCLL8m/Zkrflf6ei1ZP1JXAr2q+uBsGK0QWWw/FdddekclJqS4
         pZClXScTGye76wwkKStT66MUJDli/VHa4Fg8YM2WCKMdFld0qeCLFn4czXai/dJsqpZ2
         GmZg==
X-Gm-Message-State: AOAM531WHfquIeVy+xAWfDWzI+J21YU7IQ1VvO+erNix2KxHrv2M0b1x
        rAu9AgJ6OfwSM+ikF0R8P0s=
X-Google-Smtp-Source: ABdhPJxQSDe8onu08AIgMPi4a9SE5g+LOBxC/I0odt+bYcamTbQ37U1HJpL2VyUeQ2CjinbvyRbFjg==
X-Received: by 2002:ac8:468e:: with SMTP id g14mr345130qto.91.1618611412319;
        Fri, 16 Apr 2021 15:16:52 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5c21:af45:3b27:576c:7dde:37f1])
        by smtp.gmail.com with ESMTPSA id y6sm5131166qkd.106.2021.04.16.15.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:16:52 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v7 2/6] w1: ds2438: fixed if brackets coding style issue
Date:   Fri, 16 Apr 2021 19:17:35 -0300
Message-Id: <20210416221739.501090-3-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210416221739.501090-1-sampaio.ime@gmail.com>
References: <20210409031533.442123-1-sampaio.ime@gmail.com>
 <20210416221739.501090-1-sampaio.ime@gmail.com>
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

