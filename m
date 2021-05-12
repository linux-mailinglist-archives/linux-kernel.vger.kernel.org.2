Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14DA37B387
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 03:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhELBcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 21:32:16 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:43969 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhELBcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 21:32:11 -0400
Received: by mail-ej1-f48.google.com with SMTP id l4so32535398ejc.10;
        Tue, 11 May 2021 18:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=utrWOu42FjJA8Nbe/rYRDIaHKdb4rk7dPi0KGMnX07w=;
        b=VCRDcJmIWWYwZ35CKOC5ZrldQpXdEQDn/dTbv2FlpY1OyRu9CQh8HAq70xFVWityBy
         vnIt788xIsH0y9k2ShxOGGbJsxaL8i3IdP/cOVG6nKmL7zG7xjCx7rsPNTfs6UahOzAp
         Fgoc0Jvj5+Faf7Z4GX+dDs/WrO570cB6nCJo0fUN3AXWu9toZkaUIKzEsD1oan8Jv8uH
         LKETtobugH6NNhU4/Yo7P9ahybeKXxhKP29StmBcrhGVStpDVE1+b6F3LEhvK6joOINS
         DxQbfsmegFV2RhhXZLw2ij/sipb/aFr1Ru5T3OvLKRQDvPthGz/CQ+6rH68ECe/DZ6fP
         Wq/A==
X-Gm-Message-State: AOAM5324Wtz4GlTID81rI8iSIxTvFaEy74HNKRdvVXeH8XTN7yi92Jxj
        D9HBvgo/HzW6zX2mLqQe5JE=
X-Google-Smtp-Source: ABdhPJwQoNZvtD9Bf4lGU4rP6qs+F+DXYHt1XeKq8a7reswJSBfb22wjxF4iopf7TA+z6DFdPPicgg==
X-Received: by 2002:a17:906:33da:: with SMTP id w26mr35348167eja.472.1620783062958;
        Tue, 11 May 2021 18:31:02 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id c3sm2276855edn.16.2021.05.11.18.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 18:31:02 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Subject: [PATCH v5 3/5] hwmon: (max31790) Show 0 RPM/fault when input disabled
Date:   Wed, 12 May 2021 03:30:49 +0200
Message-Id: <20210512013052.903297-3-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512013052.903297-1-kubernat@cesnet.cz>
References: <20210512013052.903297-1-kubernat@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
index 5d4c551df010..6e0ffbcf0d28 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -165,6 +165,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 
 	switch (attr) {
 	case hwmon_fan_input:
+		if (!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN))
+			return -ENODATA;
+
 		tach = read_reg_word(regmap, MAX31790_REG_TACH_COUNT(channel));
 		if (tach < 0)
 			return tach;
@@ -179,6 +182,11 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
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

