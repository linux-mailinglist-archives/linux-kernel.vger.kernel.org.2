Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D50389951
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 00:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhESWbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 18:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhESWbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 18:31:01 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B29C061574;
        Wed, 19 May 2021 15:29:41 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x8so14410742qkl.2;
        Wed, 19 May 2021 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MZVVGzNYcMxmtISNSUfUMnz2s444oX5WOS+3c0FDAUg=;
        b=gWAQMdYNEjYNw/toQDW4V17Hc8ny2MhkOSqKv830YzkQVBhnuQyz7YsisI1gMgtKVl
         3gV82Mp/y0gHobZSABosOgTJp1r2TNfQjGP1ZDvBdj7Y+lg16vB/gLeMz9MqQtzdFL1d
         HCE/pl/b+8wlj+UhLJV8cYiCVMWw7eAT1clahB9IV2RAaW3k385LkPkgxl3SW1XEU2rE
         UtBVhQIC5CpLjX4S0TEt0qcNWFv/vPw07ZU7F1HWsaxfOM7CAn+ITDtaAVu2kmRxrcel
         VrTiuqvFSHp6ZuQOaLZSNxWXKJzjswtaKFpZziRRGJ/BafEbyQCbpohuTUGIQqrIaJio
         dLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZVVGzNYcMxmtISNSUfUMnz2s444oX5WOS+3c0FDAUg=;
        b=X6XWBd5p994z/J5Jl2SXJE5+pn/YpnrLvlfi6e5jSPwUh9zV9aZ8lOGn/yl3CROFB0
         Q5xtUMDTPQOxPUP44BDFUt3IZQBRX7OwNR5ukE6kRY6HL1bfSrFL7TH3+NVtAmk51lSY
         VksyMdlU53jyKTzslYovvX59Bhly+reiNSU4w3fdWlacbyYb/0Wa1qKXvywUvKjGlejs
         p4/E8TfIg4M9jZ4R4AaoY/lXFkYo4S8D5CCTE85CvdQAGxBRBUL3TaI0vHsJr96HIrFS
         26L7++F1MUpXNxfs+NPpoEmfVnb02jTpjRIY+SDstAjjY6QU7Z7FcF5lpJ0Wn95bnERN
         5RAg==
X-Gm-Message-State: AOAM53159nEGmaK/QmvBK4cV8WqWsXQW3si5f8VJO0jpzYTFcD5QNZH+
        czupfbNv4UW3HcDuMBvykzo=
X-Google-Smtp-Source: ABdhPJx1iTa0spGnki/h7BSjBDW5YoI2ZJrpb6PfHUoNYOjwvLya/VA6enGnPGSP57ibqN91g7letQ==
X-Received: by 2002:a05:620a:2114:: with SMTP id l20mr1784291qkl.51.1621463380495;
        Wed, 19 May 2021 15:29:40 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:214:8175:da27:c352:bf96:2102:fa64])
        by smtp.gmail.com with ESMTPSA id d18sm823716qkc.28.2021.05.19.15.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 15:29:40 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v8 2/6] w1: ds2438: fixed if brackets coding style issue
Date:   Wed, 19 May 2021 19:30:42 -0300
Message-Id: <20210519223046.13798-3-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210519223046.13798-1-sampaio.ime@gmail.com>
References: <20210409031533.442123-1-sampaio.ime@gmail.com>
 <20210519223046.13798-1-sampaio.ime@gmail.com>
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

