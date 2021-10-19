Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458FB4336D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbhJSNUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbhJSNT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:19:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C55C061745
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:17:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g10so12718510edj.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5YnSV2WmSpYW3PQc/jQwM9rWHR/XNd6B5D4ZvC4oHuY=;
        b=rNAcoTay7AsnMHiPkpaF40XiXzzMBw2UKeG92UNqJV9iv99TRyiiGVGejWyrLeM9xP
         KvUINaMYNxMJcrpA2AtQ3nE7JuVfpSVIvy3zxKvV04AG4bU8QUEpXdS5e9uOr9Fsg9Qu
         tQeymZ0sroVPHIoLucrfkVgS77cawo7aGWXj6hvlx6SxqjWQXP/+AzKtQ381eOCOSxLk
         NEV57dz+pfpjojXeUvGZnkQpqJYir03EIVkG1eTInT036JmcIxdMV6ShfMfun9D33jCU
         yH2V6R1JzilLNuh/2PA9ZfQIYF9Unltcesv3S3QefDDnY8L2dZcskXf/dUHuRXDgg+HE
         m08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5YnSV2WmSpYW3PQc/jQwM9rWHR/XNd6B5D4ZvC4oHuY=;
        b=S69AmcoPjwOf3GL3M5EyRVUl12asKvEiAY6vVv9BuwC8L+/esGTluhSW6iUSS3U1Ka
         zBX6Hos22U+78dP9FEsJ1GUy/j984UrUU6cXj3nO+sHpo2vXqzDHvT2sAIZxRXs0Uvhp
         vqlTEkhz4/3XLPhjVdd1mekIaHmFNuUqFJiHFdempkGcq0q71WZn9ZlwfsfoFs85mNfW
         sdLYwTqvF3Kdgcxz9ok6h+C2DxfUsP1AX/Leml1D7PT+sG/ifM+wgwEOOmuXQWVQU2rO
         pLRW0XSgPGEV8ZuYxP7/+vXBaxbNE+myeympup5m1tBPv3mEWaHkjar3+i7nXPLPSwJg
         8aPA==
X-Gm-Message-State: AOAM5302inX0DGgHkRqUtIGtDvuZ/UcrDob4hsokCZulTLfmu8D3AEbE
        5cvIZet130KqCEGcVwaNsHxm1A==
X-Google-Smtp-Source: ABdhPJyBARKHQoOqkXzfsy2YP5Fvk8FuxRLrNXgccGNZtj9uAo035bbgTDknejv/E9Dh0IJD3ju9PA==
X-Received: by 2002:a17:906:4fd6:: with SMTP id i22mr37353674ejw.92.1634649451800;
        Tue, 19 Oct 2021 06:17:31 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id o25sm11271775edq.40.2021.10.19.06.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:17:31 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] rtc: s3c: Extract read/write IO into separate functions
Date:   Tue, 19 Oct 2021 16:17:23 +0300
Message-Id: <20211019131724.3109-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019131724.3109-1-semen.protsenko@linaro.org>
References: <20211019131724.3109-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create dedicated functions for I/O operations and BCD conversion. It can
be useful to separete those from representation conversion and other
stuff found in RTC callbacks, e.g. for initializing RTC registers.

This patch does not introduce any functional changes, it's merely
refactoring change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/rtc/rtc-s3c.c | 98 +++++++++++++++++++++++++++----------------
 1 file changed, 61 insertions(+), 37 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index d9994efd70ef..238928e29fbc 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -127,10 +127,9 @@ static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
 	return ret;
 }
 
-/* Time read/write */
-static int s3c_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
+/* Read time from RTC and convert it from BCD */
+static int s3c_rtc_read_time(struct s3c_rtc *info, struct rtc_time *tm)
 {
-	struct s3c_rtc *info = dev_get_drvdata(dev);
 	unsigned int have_retried = 0;
 	int ret;
 
@@ -139,54 +138,40 @@ static int s3c_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 		return ret;
 
 retry_get_time:
-	rtc_tm->tm_min  = readb(info->base + S3C2410_RTCMIN);
-	rtc_tm->tm_hour = readb(info->base + S3C2410_RTCHOUR);
-	rtc_tm->tm_mday = readb(info->base + S3C2410_RTCDATE);
-	rtc_tm->tm_mon  = readb(info->base + S3C2410_RTCMON);
-	rtc_tm->tm_year = readb(info->base + S3C2410_RTCYEAR);
-	rtc_tm->tm_sec  = readb(info->base + S3C2410_RTCSEC);
-
-	/* the only way to work out whether the system was mid-update
+	tm->tm_min  = readb(info->base + S3C2410_RTCMIN);
+	tm->tm_hour = readb(info->base + S3C2410_RTCHOUR);
+	tm->tm_mday = readb(info->base + S3C2410_RTCDATE);
+	tm->tm_mon  = readb(info->base + S3C2410_RTCMON);
+	tm->tm_year = readb(info->base + S3C2410_RTCYEAR);
+	tm->tm_sec  = readb(info->base + S3C2410_RTCSEC);
+
+	/*
+	 * The only way to work out whether the system was mid-update
 	 * when we read it is to check the second counter, and if it
 	 * is zero, then we re-try the entire read
 	 */
-
-	if (rtc_tm->tm_sec == 0 && !have_retried) {
+	if (tm->tm_sec == 0 && !have_retried) {
 		have_retried = 1;
 		goto retry_get_time;
 	}
 
-	rtc_tm->tm_sec = bcd2bin(rtc_tm->tm_sec);
-	rtc_tm->tm_min = bcd2bin(rtc_tm->tm_min);
-	rtc_tm->tm_hour = bcd2bin(rtc_tm->tm_hour);
-	rtc_tm->tm_mday = bcd2bin(rtc_tm->tm_mday);
-	rtc_tm->tm_mon = bcd2bin(rtc_tm->tm_mon);
-	rtc_tm->tm_year = bcd2bin(rtc_tm->tm_year);
-
 	s3c_rtc_disable_clk(info);
 
-	rtc_tm->tm_year += 100;
-	rtc_tm->tm_mon -= 1;
+	tm->tm_sec  = bcd2bin(tm->tm_sec);
+	tm->tm_min  = bcd2bin(tm->tm_min);
+	tm->tm_hour = bcd2bin(tm->tm_hour);
+	tm->tm_mday = bcd2bin(tm->tm_mday);
+	tm->tm_mon  = bcd2bin(tm->tm_mon);
+	tm->tm_year = bcd2bin(tm->tm_year);
 
-	dev_dbg(dev, "read time %ptR\n", rtc_tm);
 	return 0;
 }
 
-static int s3c_rtc_settime(struct device *dev, struct rtc_time *tm)
+/* Convert time to BCD and write it to RTC */
+static int s3c_rtc_write_time(struct s3c_rtc *info, const struct rtc_time *tm)
 {
-	struct s3c_rtc *info = dev_get_drvdata(dev);
-	int year = tm->tm_year - 100;
 	int ret;
 
-	dev_dbg(dev, "set time %ptR\n", tm);
-
-	/* we get around y2k by simply not supporting it */
-
-	if (year < 0 || year >= 100) {
-		dev_err(dev, "rtc only supports 100 years\n");
-		return -EINVAL;
-	}
-
 	ret = s3c_rtc_enable_clk(info);
 	if (ret)
 		return ret;
@@ -195,14 +180,53 @@ static int s3c_rtc_settime(struct device *dev, struct rtc_time *tm)
 	writeb(bin2bcd(tm->tm_min),  info->base + S3C2410_RTCMIN);
 	writeb(bin2bcd(tm->tm_hour), info->base + S3C2410_RTCHOUR);
 	writeb(bin2bcd(tm->tm_mday), info->base + S3C2410_RTCDATE);
-	writeb(bin2bcd(tm->tm_mon + 1), info->base + S3C2410_RTCMON);
-	writeb(bin2bcd(year), info->base + S3C2410_RTCYEAR);
+	writeb(bin2bcd(tm->tm_mon),  info->base + S3C2410_RTCMON);
+	writeb(bin2bcd(tm->tm_year), info->base + S3C2410_RTCYEAR);
 
 	s3c_rtc_disable_clk(info);
 
 	return 0;
 }
 
+static int s3c_rtc_gettime(struct device *dev, struct rtc_time *tm)
+{
+	struct s3c_rtc *info = dev_get_drvdata(dev);
+	int ret;
+
+	ret = s3c_rtc_read_time(info, tm);
+	if (ret)
+		return ret;
+
+	/* Convert internal representation to actual date/time */
+	tm->tm_year += 100;
+	tm->tm_mon -= 1;
+
+	dev_dbg(dev, "read time %ptR\n", tm);
+	return 0;
+}
+
+static int s3c_rtc_settime(struct device *dev, struct rtc_time *tm)
+{
+	struct s3c_rtc *info = dev_get_drvdata(dev);
+	struct rtc_time rtc_tm = *tm;
+
+	dev_dbg(dev, "set time %ptR\n", tm);
+
+	/*
+	 * Convert actual date/time to internal representation.
+	 * We get around Y2K by simply not supporting it.
+	 */
+	rtc_tm.tm_year -= 100;
+	rtc_tm.tm_mon += 1;
+
+	if (rtc_tm.tm_year < 0 || rtc_tm.tm_year >= 100) {
+		dev_err(dev, "rtc only supports 100 years\n");
+		return -EINVAL;
+	}
+
+	return s3c_rtc_write_time(info, &rtc_tm);
+}
+
 static int s3c_rtc_getalarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct s3c_rtc *info = dev_get_drvdata(dev);
-- 
2.30.2

