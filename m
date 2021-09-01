Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B067B3FE636
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbhIBAAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 20:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242504AbhIBAAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 20:00:39 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0CFC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 16:59:42 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 17so73319pgp.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 16:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VVEKpVhauYNJ1ILO18GzLhj0cTIWBln8xn/kIaFE4Zk=;
        b=a0U/g5gMiauvSfdJA24Q9gAMJsJpAAv3wbzNJjANEkTSQ6ZcazygfvPjXmDvJbfJRN
         MKOqYJNao/5bmFsusyOH6gziaJLDYcQMlgNIZtCu5osijNKqKn215xzzE2Sv8VKhjhBd
         6AYwdWpJt+iBBr/bklXqDqTOCrybNX62uH2vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VVEKpVhauYNJ1ILO18GzLhj0cTIWBln8xn/kIaFE4Zk=;
        b=EE15pxgg420dSPwq8+lNuTst0pCkxyBbaCbgkCRtCJ5miHV4htF4hSzZ/4W1K6oKO2
         tqiZb936xHIs3lDAvgOtlHK7I6TZ99X75uUfnLGkykpwMRj7kRmF9tEJV4QuGBYZ5BM8
         syHKBfU8uVktmHqfv8izuhjR/20RsfLdJIdCPMuzKefIH5k08c/TEcLecg/upojnhZ/F
         C8IiusQA6wg4ICPWAUajquzeG719+SYn8Bb/JmmDDDC8xm2QbjEbRaZxaznpKadj61r7
         3YtCDYUj6e80kyQ81cJku5fBiyqsYi7Kjy6dHjqIhXtpYVYBd12ws3kf9NL5aJB7QQOi
         mq6A==
X-Gm-Message-State: AOAM533JpEvcsdIN4mTo86c/lKvrtzS/xsyYnnlv7wLfPoRGuOahnoxz
        u2Ed/8164vF15hFQWkuG6rj/KHoouwMecw==
X-Google-Smtp-Source: ABdhPJwDBjoTuTHaB/WX510aqdaeHu3oym+8oKmcYBmdvcvaxzfghosuICAisrlkBSlyr3Mk0uJRFQ==
X-Received: by 2002:a62:1888:0:b029:3c9:7957:519b with SMTP id 130-20020a6218880000b02903c97957519bmr410778pfy.17.1630540781790;
        Wed, 01 Sep 2021 16:59:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:fbd:3633:cc64:337d])
        by smtp.gmail.com with UTF8SMTPSA id g2sm104681pfr.35.2021.09.01.16.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 16:59:41 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] power: supply: core: Add psy_has_property()
Date:   Wed,  1 Sep 2021 16:59:36 -0700
Message-Id: <20210901165911.1.I61edd8453dd683a125623b4173988b438033c0af@changeid>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the helper psy_has_property() to check whether a power supply
has a given property and use it instead of ad hoc iterations over
the property list in multiple locations.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/power/supply/power_supply_core.c | 65 ++++++++++++++----------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index d99e2f11c183..9309b33ed3ec 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -956,26 +956,41 @@ static struct thermal_zone_device_ops psy_tzd_ops = {
 	.get_temp = power_supply_read_temp,
 };
 
+static bool psy_has_property(const struct power_supply_desc *psy_desc,
+			     enum power_supply_property psp)
+{
+	bool found = false;
+	int i;
+
+	for (i = 0; i < psy_desc->num_properties; i++) {
+		if (psy_desc->properties[i] == psp) {
+			found = true;
+			break;
+		}
+	}
+
+	return found;
+}
+
 static int psy_register_thermal(struct power_supply *psy)
 {
-	int i, ret;
+	int ret;
 
 	if (psy->desc->no_thermal)
 		return 0;
 
 	/* Register battery zone device psy reports temperature */
-	for (i = 0; i < psy->desc->num_properties; i++) {
-		if (psy->desc->properties[i] == POWER_SUPPLY_PROP_TEMP) {
-			psy->tzd = thermal_zone_device_register(psy->desc->name,
-					0, 0, psy, &psy_tzd_ops, NULL, 0, 0);
-			if (IS_ERR(psy->tzd))
-				return PTR_ERR(psy->tzd);
-			ret = thermal_zone_device_enable(psy->tzd);
-			if (ret)
-				thermal_zone_device_unregister(psy->tzd);
-			return ret;
-		}
+	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
+		psy->tzd = thermal_zone_device_register(psy->desc->name,
+				0, 0, psy, &psy_tzd_ops, NULL, 0, 0);
+		if (IS_ERR(psy->tzd))
+			return PTR_ERR(psy->tzd);
+		ret = thermal_zone_device_enable(psy->tzd);
+		if (ret)
+			thermal_zone_device_unregister(psy->tzd);
+		return ret;
 	}
+
 	return 0;
 }
 
@@ -1046,18 +1061,14 @@ static const struct thermal_cooling_device_ops psy_tcd_ops = {
 
 static int psy_register_cooler(struct power_supply *psy)
 {
-	int i;
-
 	/* Register for cooling device if psy can control charging */
-	for (i = 0; i < psy->desc->num_properties; i++) {
-		if (psy->desc->properties[i] ==
-				POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT) {
-			psy->tcd = thermal_cooling_device_register(
-							(char *)psy->desc->name,
-							psy, &psy_tcd_ops);
-			return PTR_ERR_OR_ZERO(psy->tcd);
-		}
+	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT)) {
+		psy->tcd = thermal_cooling_device_register(
+			(char *)psy->desc->name,
+			psy, &psy_tcd_ops);
+		return PTR_ERR_OR_ZERO(psy->tcd);
 	}
+
 	return 0;
 }
 
@@ -1095,7 +1106,7 @@ __power_supply_register(struct device *parent,
 {
 	struct device *dev;
 	struct power_supply *psy;
-	int i, rc;
+	int rc;
 
 	if (!parent)
 		pr_warn("%s: Expected proper parent device for '%s'\n",
@@ -1104,11 +1115,9 @@ __power_supply_register(struct device *parent,
 	if (!desc || !desc->name || !desc->properties || !desc->num_properties)
 		return ERR_PTR(-EINVAL);
 
-	for (i = 0; i < desc->num_properties; ++i) {
-		if ((desc->properties[i] == POWER_SUPPLY_PROP_USB_TYPE) &&
-		    (!desc->usb_types || !desc->num_usb_types))
-			return ERR_PTR(-EINVAL);
-	}
+	if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
+	    (!desc->usb_types || !desc->num_usb_types))
+		return ERR_PTR(-EINVAL);
 
 	psy = kzalloc(sizeof(*psy), GFP_KERNEL);
 	if (!psy)
-- 
2.33.0.153.gba50c8fa24-goog

