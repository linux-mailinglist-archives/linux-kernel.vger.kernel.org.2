Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7AC32D164
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbhCDLBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:01:20 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:51115 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239233AbhCDLAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:00:47 -0500
Received: by mail-wm1-f44.google.com with SMTP id i9so7644239wml.0;
        Thu, 04 Mar 2021 03:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D2TtDMxqLNkT1Ekg9r6IgrQnZtb/5fla5rvVsmZNlkY=;
        b=Pylp4eNyEHIucKCg4wyHdRHdirj20/MHCuzRejewU8ny2E/PqgRZ6+UFQp+qc/6dK+
         X2RIlp6QUBbaMn/YLy2kOSdXoPR29eCWMlyqwNdZat9VAshrYSguAbAFykuZUsVk8zYC
         8N/VKZnMigfFAUFWYyzHf/WPVm4YAe9q5P6vy+pYmWLuOVTDv9aXeaVGjkDY01V1l7Mk
         2ERUrjyZiQEdw4cHr8HFljGe7HiCd5m4XJpQ3z5uFeQJ6cRcKuYLhXAIamEeKNdHagWL
         ERDQYj4bDmgecH1KieWJpPMa1yVYF1aBJTQAcQ6XOakiOmVKAR9ANh8NJx8fJaIegUIU
         tLNg==
X-Gm-Message-State: AOAM531Ya2oNywpdK+HLml4bXPyeyMFbHqVce6zXWRyPA2Ba7ry+POek
        dvw8479YTfp7564KLgl6Jhk=
X-Google-Smtp-Source: ABdhPJyVLnjJzinKf5VF4NBZXhSFuEkEmSqRw2GcmBEHY7Q5pQe8sTujfmkbHqGRQeTx2DXhjbGpSg==
X-Received: by 2002:a1c:e383:: with SMTP id a125mr3320217wmh.125.1614855606143;
        Thu, 04 Mar 2021 03:00:06 -0800 (PST)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id a3sm35811711wrt.68.2021.03.04.03.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 03:00:05 -0800 (PST)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] hwmon: (max31790) Show 0 RPM/fault when input disabled
Date:   Thu,  4 Mar 2021 11:58:27 +0100
Message-Id: <20210304105830.507176-4-kubernat@cesnet.cz>
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

When fan speed input is disabled, it makes no sense to show values in
fan*_input and fan*_fault.

Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
---
 drivers/hwmon/max31790.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index 74a81e5e3383..fde08c95d942 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -219,6 +219,11 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 
 	switch (attr) {
 	case hwmon_fan_input:
+		if (!(data->fan_config[channel] &
+		      MAX31790_FAN_CFG_TACH_INPUT_EN)) {
+			*val = 0;
+			return 0;
+		}
 		sr = get_tach_period(data->fan_dynamics[channel]);
 		rpm = RPM_FROM_REG(data->tach[channel],
 				   sr,
@@ -233,6 +238,11 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 		*val = rpm;
 		return 0;
 	case hwmon_fan_fault:
+		if (!(data->fan_config[channel] &
+		      MAX31790_FAN_CFG_TACH_INPUT_EN)) {
+			*val = 0;
+			return 0;
+		}
 		*val = !!(data->fault_status & (1 << channel));
 		return 0;
 	case hwmon_fan_enable:
-- 
2.30.1

