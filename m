Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2514541B256
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241384AbhI1Ord (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 10:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241295AbhI1Orc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632840352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UXVxRzoO+stk1jCVHn72msXq/bQWSgfleFnZZjGNuf0=;
        b=CIqr/JwgkjATBiRPNlvxkizfNf1hnu8ffA8vd+4c5vMBPUtKIzHDLxhEs+4x8UC45JKYka
        cqCXrx0UnmGJ2u/sNmvoCA96kFnY0sjLd/kWQgIaZRGcmO/EJwjgnmSaTA/bv3LhPskiG6
        g+NDQJaJduCZUc5hEG8rfy6J7b0qmH0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-UmGplCKyNWKNTgQmuusQBQ-1; Tue, 28 Sep 2021 10:45:50 -0400
X-MC-Unique: UmGplCKyNWKNTgQmuusQBQ-1
Received: by mail-oo1-f72.google.com with SMTP id k1-20020a4a8501000000b0029ac7b9dc82so24359092ooh.17
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UXVxRzoO+stk1jCVHn72msXq/bQWSgfleFnZZjGNuf0=;
        b=k8wmol+8jAgzsbSAjSf1gh0fDdoqPj6ExlXaZLkK/OvaI53SoqDEbv87KdM0P5FhKd
         WS+RMT/Prgj/zjG06QQy9hCqsTXTegq9UkpPhppWrjK/DanyJDBYu1Ju79dk1o84Xkj5
         LaVdB+xDhSFLeCgPUR2ONz9lp/8Ffpfb7Skqq9q563SimYIZ3f9un7DOcOj1doWmnOnb
         boND1brl32dBsyRlUJ5D0lH2RojuG1KZB5+hVuiFfqQwuMoj+4KF1pANJt3fPhcgNlzx
         2amHjfSLsIcFnE7Iyan+vyuwGpOp+ZPd1QTupxbYCU45b1b9A1WsiYjmeSuYY8toa9rT
         eBJg==
X-Gm-Message-State: AOAM531B9B7OrkqEF6W5q9WM4pK59RCoH/mrx/dbaWIF7wiYgunt0Kbo
        iPMDHBETqjLaMK+KiyCmGl31DVVZsNnbAVw1CQ6j/1PvbsZfDbJwKPMqq2zwOsIMWaZwCunGY8C
        ERFexm//wCvWoWDA2PRg2ThHl
X-Received: by 2002:a05:6808:f:: with SMTP id u15mr3979709oic.86.1632840350276;
        Tue, 28 Sep 2021 07:45:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT5M0vZ9fvSxavrXKTrGoMLFoK8XR6Fl2E8vuT+l+KtGGJmMkl0jhm0bne/f0nQklxY0IE3g==
X-Received: by 2002:a05:6808:f:: with SMTP id u15mr3979695oic.86.1632840350113;
        Tue, 28 Sep 2021 07:45:50 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j4sm4524081oia.56.2021.09.28.07.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 07:45:49 -0700 (PDT)
From:   trix@redhat.com
To:     sre@kernel.org, mka@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] power: supply: core: move psy_has_property()
Date:   Tue, 28 Sep 2021 07:40:46 -0700
Message-Id: <20210928144046.272926-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A ranconfig produces this error
power_supply_core.c:1137:6: error: implicit declaration
  of function 'psy_has_property'
 1137 |  if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&

psy_has_property() compiling is conditional on THERMAL.  It is used
in __power_supply_register() to check a non thermal property.
So move psy_has_property() out of the THERMAL conditional.

Fixes: 9ba533eb99bb ("power: supply: core: Add psy_has_property()")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/power/supply/power_supply_core.c | 32 ++++++++++++------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 75575ea45f21dd..fc12a4f407f431 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -951,6 +951,22 @@ void power_supply_unreg_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(power_supply_unreg_notifier);
 
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
 #ifdef CONFIG_THERMAL
 static int power_supply_read_temp(struct thermal_zone_device *tzd,
 		int *temp)
@@ -975,22 +991,6 @@ static struct thermal_zone_device_ops psy_tzd_ops = {
 	.get_temp = power_supply_read_temp,
 };
 
-static bool psy_has_property(const struct power_supply_desc *psy_desc,
-			     enum power_supply_property psp)
-{
-	bool found = false;
-	int i;
-
-	for (i = 0; i < psy_desc->num_properties; i++) {
-		if (psy_desc->properties[i] == psp) {
-			found = true;
-			break;
-		}
-	}
-
-	return found;
-}
-
 static int psy_register_thermal(struct power_supply *psy)
 {
 	int ret;
-- 
2.26.3

