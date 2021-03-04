Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F7232D168
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbhCDLBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:01:22 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:43088 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239241AbhCDLAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:00:50 -0500
Received: by mail-wr1-f42.google.com with SMTP id w11so27100203wrr.10;
        Thu, 04 Mar 2021 03:00:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IQ2tQGgAEXKRhsWFbmI1TfLpFlPfR41QCn14sTysJrw=;
        b=H5oUom8uq3voXGFQ8Xq/32pyK3SbqJxSPt9LCXqulnhcYRF9ntfuWd9suV+PLD0K7T
         t1KPNa9MGj+E+wfDZSeJtT9gbeHZVAIak3ZhTilbFoP/Twh3UV0FkBD9Dlk/i6o7gmTR
         gq2wvVOIHV6xkUWXLl+7HG4L3oPLBzYYg7XthF9Oa5dSikl22PmcTsfzfeXR1dn24KWQ
         g86swu68g+59j66OUfsOTVtCTj1RVnRjPcdPFSoR8skJQeunJo5nWcPxKER7vo6XLjen
         yR79Za9YkcR/l4ydw/xBURRpMOTbYzv1MOejpiQdcRGoRrmMfgZ1o92QTXeMUx836tE8
         BnJg==
X-Gm-Message-State: AOAM533Yn+aX6jGLA/UhqTkU/D0jkFnL3oIbcZa4aMeIn5zSw9yGhLKW
        mJ2jDP/6I7UX9oJBGlBSHxvqrSZkBr7CMA==
X-Google-Smtp-Source: ABdhPJw9bQspoohOvwpDIhVmFsonXtzC3kfulY0Gx33t3k5ocY2y8FNLx3D0WUEU7HURJzhrn1GKEg==
X-Received: by 2002:adf:e409:: with SMTP id g9mr3250789wrm.423.1614855608516;
        Thu, 04 Mar 2021 03:00:08 -0800 (PST)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id f2sm33717045wrq.34.2021.03.04.03.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 03:00:08 -0800 (PST)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] hwmon: (max31790) Refactor HWMON_CHANNEL_INFO
Date:   Thu,  4 Mar 2021 11:58:28 +0100
Message-Id: <20210304105830.507176-5-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210304105830.507176-1-kubernat@cesnet.cz>
References: <20210304105830.507176-1-kubernat@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The line was starting to get a little long.

Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
---
 drivers/hwmon/max31790.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index fde08c95d942..d4f259dd4e19 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -56,6 +56,19 @@
 #define U16_MSB(num)			(((num) & 0xFF00) >> 8)
 #define U16_LSB(num)			((num) & 0x00FF)
 
+#define FAN_INFO_1_TO_6 \
+	(HWMON_F_PULSES | \
+	HWMON_F_ENABLE | \
+	HWMON_F_INPUT | \
+	HWMON_F_TARGET | \
+	HWMON_F_FAULT)
+
+#define FAN_INFO_7_TO_12 \
+	(HWMON_F_PULSES | \
+	HWMON_F_ENABLE | \
+	HWMON_F_INPUT | \
+	HWMON_F_FAULT)
+
 static const struct regmap_range max31790_ro_range = {
 	.range_min = MAX31790_REG_TACH_COUNT(0),
 	.range_max = MAX31790_REG_PWMOUT(0) - 1,
@@ -513,18 +526,18 @@ static umode_t max31790_is_visible(const void *data,
 
 static const struct hwmon_channel_info *max31790_info[] = {
 	HWMON_CHANNEL_INFO(fan,
-		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
-		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
-		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
-		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
-		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
-		HWMON_F_PULSES | HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT),
+		FAN_INFO_1_TO_6,
+		FAN_INFO_1_TO_6,
+		FAN_INFO_1_TO_6,
+		FAN_INFO_1_TO_6,
+		FAN_INFO_1_TO_6,
+		FAN_INFO_1_TO_6,
+		FAN_INFO_7_TO_12,
+		FAN_INFO_7_TO_12,
+		FAN_INFO_7_TO_12,
+		FAN_INFO_7_TO_12,
+		FAN_INFO_7_TO_12,
+		FAN_INFO_7_TO_12),
 	HWMON_CHANNEL_INFO(pwm,
 		HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
 		HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-- 
2.30.1

