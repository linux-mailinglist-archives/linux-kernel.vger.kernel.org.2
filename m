Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF0136B33C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhDZMi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:38:58 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:42806 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbhDZMip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:38:45 -0400
Received: by mail-wr1-f54.google.com with SMTP id l2so3375917wrm.9;
        Mon, 26 Apr 2021 05:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TUoG7L9NRi/SrNm6t93dPTpiPCd3zE8vKcQKovWm0n8=;
        b=crqL+WQio/n5+iX6uSjKME+an2JEsGHffx5fpy4hZy+PeRsZqWuUwQwmaOUOxYm1E5
         glUNE2Bvhg60YCVTSeRZPoWL7+Q+3a1fMEQiuhcIr2sChyzvQRl2xOYqj+NkCuT3w1z1
         dWMdVEYuDC6n7F7Holfq0+YQlVamHan/tS9rHuRgGCiWAJ5an8eHNV+uT97R82BkKBiq
         kL8qHCsAs/vB2VWumu2Dy8GC66p2OHbLyNF9p7Ldb3XnA/m3YvX/nEYlyuFZHmhsjpv7
         z4giqR1trJB55ZtsRs92EfRQjLoUVNsDJifV8pB4VnPIqM+pm/+xNRncDT9PAQWDKCJR
         B/cA==
X-Gm-Message-State: AOAM530RvPO8t8OHflgQZieKGH4tRFMJQHG1wljU3q375ZmLA2ZlZfKe
        H6AUxAZ9nrwppna90XZue8Y=
X-Google-Smtp-Source: ABdhPJy0ed0cLEV+PBU+E36nIWH3igbEdmmn8/eSEDjLOZCgN+CDzOODtkPddocXiV1py3s3VtI9Bg==
X-Received: by 2002:adf:c587:: with SMTP id m7mr22442560wrg.369.1619440683194;
        Mon, 26 Apr 2021 05:38:03 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id z66sm22111834wmc.4.2021.04.26.05.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 05:38:02 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] hwmon: (max31790) Show 0 RPM/fault when input disabled
Date:   Mon, 26 Apr 2021 14:37:47 +0200
Message-Id: <20210426123749.899654-3-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426123749.899654-1-kubernat@cesnet.cz>
References: <20210413025948.901867-1-kubernat@cesnet.cz>
 <20210426123749.899654-1-kubernat@cesnet.cz>
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
 drivers/hwmon/max31790.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index 82d7b8518743..842749482ba4 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -167,6 +167,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 
 	switch (attr) {
 	case hwmon_fan_input:
+		if (!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN))
+			return -ENODATA;
+
 		tach = read_reg_word(regmap, MAX31790_REG_TACH_COUNT(channel));
 		if (tach < 0)
 			return tach;
@@ -181,6 +184,11 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 		*val = RPM_FROM_REG(tach, get_tach_period(data->fan_dynamics[channel]));
 		return 0;
 	case hwmon_fan_fault:
+		if (!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN)) {
+			*val = 0;
+			return 0;
+		}
+
 		if (channel > 6)
 			fault = read_reg_byte(regmap, MAX31790_REG_FAN_FAULT_STATUS2);
 		else
-- 
2.31.1

