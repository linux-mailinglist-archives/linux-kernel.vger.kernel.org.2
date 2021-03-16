Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBC133DBAF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbhCPR5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:57:21 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:33481 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239421AbhCPR4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:56:02 -0400
Received: by mail-ed1-f50.google.com with SMTP id w18so22636640edc.0;
        Tue, 16 Mar 2021 10:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dhzMvhiTeUNm1PtC49X5tx+hF0dpKCDPQdt6GK/mu68=;
        b=P3mT30tQgW4yJbZmSLDhH3SAF7KoykyysC+dbmKwHgSTU7saPQHZVvYMDK5GoVrAdN
         ve9jZg/pfCfc8CvWvaoq+MCVd1lpNQpbFhMNZo5Dcw0eJH6Rs0VXAVrCx2ZqspdNoPEv
         0n/7WaBed9Kc9SmUnGboZ+dIZV/HXEhY6a+2QjRyD3Wb+2Yfc6YwQlYuXcz1230f2wrK
         EchGggjYcrHWHoT64ygMpiStJIz73/iEOXFWP3B8Sb4RnKRvZf8IG2+MKS38uDmIDHXW
         5CC6Z8q3PTMxqg5pOLSuYFRu9rg4kdRgGDkCgvqUC7+ypffw+4PxEPoA6t4pjxa/N7fP
         HPYQ==
X-Gm-Message-State: AOAM533KwmK7yxmMxXM0L36lfLaE4F7Z9W8AUXMik182BWOREAjDqAKN
        btkj7/Ejy+VX9TS++CrMgKjpQIGCRB3579xS
X-Google-Smtp-Source: ABdhPJxXJOr1skPYOBW1yTHna0zlwFs5nnPutmIZWuhvhDZibqhXJ9lVIiYL7k059Wz5+4aH5KOpwA==
X-Received: by 2002:a05:6402:35c8:: with SMTP id z8mr37488035edc.341.1615917360910;
        Tue, 16 Mar 2021 10:56:00 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id h8sm5154982ede.25.2021.03.16.10.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 10:56:00 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] hwmon: (max31790) Show 0 RPM/fault when input disabled
Date:   Tue, 16 Mar 2021 18:55:00 +0100
Message-Id: <20210316175503.1003051-3-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316175503.1003051-1-kubernat@cesnet.cz>
References: <20210316175503.1003051-1-kubernat@cesnet.cz>
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
 drivers/hwmon/max31790.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index d16b77472cc1..7b47797db471 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -168,6 +168,13 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 
 	switch (attr) {
 	case hwmon_fan_input:
+		cfg = read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(channel));
+		if (cfg < 0)
+			return cfg;
+
+		if (!(cfg & MAX31790_FAN_CFG_TACH_INPUT_EN))
+			return -ENODATA;
+
 		dynamics = read_reg_byte(regmap, MAX31790_REG_FAN_DYNAMICS(channel));
 		if (dynamics < 0)
 			return dynamics;
@@ -192,6 +199,15 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 		*val = rpm;
 		return 0;
 	case hwmon_fan_fault:
+		cfg = read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(channel));
+		if (cfg < 0)
+			return cfg;
+
+		if (!(cfg & MAX31790_FAN_CFG_TACH_INPUT_EN)) {
+			*val = 0;
+			return 0;
+		}
+
 		if (channel > 6)
 			fault = read_reg_byte(regmap, MAX31790_REG_FAN_FAULT_STATUS2);
 		else
-- 
2.30.2

