Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AD235D594
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbhDMDCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:02:32 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:41645 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343787AbhDMDCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:02:30 -0400
Received: by mail-wr1-f45.google.com with SMTP id a6so14891161wrw.8;
        Mon, 12 Apr 2021 20:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EDxhY0Ys8imy9A9JLsFR7HZkS40yCtPUJX4W8JYXyBY=;
        b=hNR3k7YE9sa0hQjYQnU2hUtk4oImSVt/2bQDEwDNgwHKTr4h2UK/7qiixu2xydVDNi
         LqEGGaaR/51BUT461II33QfTUwNOwIgX2kq+UR3bXDnbEXvZNM3gOjVxBloy2MjC8r+6
         8K9VHWAwmbYnpjIE5dXCqW8zTYN7FEdyklzXYf7/G4oPCmW+f0Dml0rSZlnCU9wUIX52
         ESipFu+M0mh0zcs+Eu8PkI3rvOtbuIbt/7Goi02fF3lnEUYj4ndGXg82EdpE9gc738gd
         sPGDJtbqMhfYrc9O7LFlWgDtYBE4qVOyYqT/2UjX8FunoPgx64QVzWyJef5vXLZQmuGe
         Eh5Q==
X-Gm-Message-State: AOAM5315aY6M93I6Ycg1ECkLoRNamLldpmrden1YoafNiapi+pP0I7Ra
        vjikgxHA1OIWRlT4e1PRnvs=
X-Google-Smtp-Source: ABdhPJzikcWHkQ1lhb/xlrR3l0lJWOmSDPL7EoUp3BZgqf2bC+nlZ6Er4qje7G99uYq7v5KxAWGP7Q==
X-Received: by 2002:a5d:5047:: with SMTP id h7mr35327491wrt.111.1618282930216;
        Mon, 12 Apr 2021 20:02:10 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id c12sm19593014wro.6.2021.04.12.20.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 20:02:09 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] hwmon: (max31790) Show 0 RPM/fault when input disabled
Date:   Tue, 13 Apr 2021 04:59:46 +0200
Message-Id: <20210413025948.901867-3-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210413025948.901867-1-kubernat@cesnet.cz>
References: <20210413025948.901867-1-kubernat@cesnet.cz>
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
index ecdd55e12ffe..4fea32ff63bb 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -166,6 +166,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 
 	switch (attr) {
 	case hwmon_fan_input:
+		if (!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN))
+			return -ENODATA;
+
 		tach = read_reg_word(regmap, MAX31790_REG_TACH_COUNT(channel));
 		if (tach < 0)
 			return tach;
@@ -180,6 +183,11 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
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

