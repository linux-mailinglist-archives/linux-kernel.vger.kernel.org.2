Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4471736C76C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbhD0N7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:59:07 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:47093 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbhD0N7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:59:03 -0400
Received: by mail-wr1-f46.google.com with SMTP id x5so9290435wrv.13;
        Tue, 27 Apr 2021 06:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S2lTJms3fUo/8xp/VoVwZC84TyrPj5vfvnW94ifoAs4=;
        b=U3mjO8Z4VsBD+wch9CoNWrL8cs+8ceX4Q4GbbqcRgJgBf0aXg4OWMMvA1Xtqmkf0/C
         72VdGfrajMRhPakLS22Zww7yO2PmPNg+qjRToXQk5hVu7p/qdgioJPeQVFTIkcRofsOg
         kZfJl55+Iae/57C3pgico73NsWYuit6bKy7ngK5ndMNW9SpseVlXwVV616DP2P8u+j4g
         LxtSMLnuyU4V6i5fsOE157EC2Jl1k7V9SLHDdrQ+bHCuB928uQQVxXGWhhf4kJeZBIxE
         eFRihnDT1rGSwrClrGnVe95VQKQPU9jQXuwG1nV+uNi6HxibQoHpgKstZP87WraBWQ/U
         WKnw==
X-Gm-Message-State: AOAM530uR/3pjjBD5gUY3LWN7GZScZaTIpN6TU/BHC2Wa9r1UXte35tv
        f/QuYzP+olY/7hkBhHIQ9gUuytvDqLSUdA==
X-Google-Smtp-Source: ABdhPJxQXPWwziCCrDGdDLTPCsxuXEZOXUdbP/8F1K1IFPeuW+XVRDHeBW8M6tZfktQhqM/JCYXnuQ==
X-Received: by 2002:adf:ec02:: with SMTP id x2mr19743094wrn.35.1619531898305;
        Tue, 27 Apr 2021 06:58:18 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id e12sm915266wrt.51.2021.04.27.06.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 06:58:17 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Subject: [PATCH] Fix FSP-3Y YH-5151E non-compliant vout encoding
Date:   Tue, 27 Apr 2021 15:58:06 +0200
Message-Id: <20210427135807.2414331-1-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't properly test the driver for the PDU, so it was completely
broken. Firstly, the log/real mapping was incorrect in one case.
Secondly, PMBus specifies that output voltages should be in the linear16
encoding. However, the PDU is non-compliant and uses linear11. The PSU
isn't affected by this.

pmbus_core didn't allow forcing linear11 format for output voltages, so
I added a way to force that.

Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
---
 drivers/hwmon/pmbus/fsp-3y.c     | 3 ++-
 drivers/hwmon/pmbus/pmbus.h      | 6 +++++-
 drivers/hwmon/pmbus/pmbus_core.c | 3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/fsp-3y.c b/drivers/hwmon/pmbus/fsp-3y.c
index 564649e87e34..b4ea1e63272e 100644
--- a/drivers/hwmon/pmbus/fsp-3y.c
+++ b/drivers/hwmon/pmbus/fsp-3y.c
@@ -57,7 +57,7 @@ static int page_log_to_page_real(int page_log, enum chips chip)
 		case YH5151E_PAGE_12V_LOG:
 			return YH5151E_PAGE_12V_REAL;
 		case YH5151E_PAGE_5V_LOG:
-			return YH5151E_PAGE_5V_LOG;
+			return YH5151E_PAGE_5V_REAL;
 		case YH5151E_PAGE_3V3_LOG:
 			return YH5151E_PAGE_3V3_REAL;
 		}
@@ -164,6 +164,7 @@ struct pmbus_driver_info fsp3y_info[] = {
 	},
 	[yh5151e] = {
 		.pages = 3,
+		.format[PSC_VOLTAGE_OUT] = force_linear11,
 		.func[YH5151E_PAGE_12V_LOG] =
 			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
 			PMBUS_HAVE_POUT  |
diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 4c30ec89f5bf..4d79a43fc965 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -405,7 +405,11 @@ enum pmbus_sensor_classes {
 #define PMBUS_PHASE_VIRTUAL	BIT(30)	/* Phases on this page are virtual */
 #define PMBUS_PAGE_VIRTUAL	BIT(31)	/* Page is virtual */
 
-enum pmbus_data_format { linear = 0, direct, vid };
+/*
+ * force_linear11 is for non-compliant devices that output VOUT in linear11
+ * instead of linear16.
+ */
+enum pmbus_data_format { linear = 0, force_linear11, direct, vid };
 enum vrm_version { vr11 = 0, vr12, vr13, imvp9, amd625mv };
 
 struct pmbus_driver_info {
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 192442b3b7a2..45a0d0303c19 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -589,7 +589,8 @@ static s64 pmbus_reg2data_linear(struct pmbus_data *data,
 	s32 mantissa;
 	s64 val;
 
-	if (sensor->class == PSC_VOLTAGE_OUT) {	/* LINEAR16 */
+	if (sensor->class == PSC_VOLTAGE_OUT &&	/* LINEAR16 */
+	    data->info->format[sensor->class] != force_linear11) {
 		exponent = data->exponent[sensor->page];
 		mantissa = (u16) sensor->data;
 	} else {				/* LINEAR11 */
-- 
2.31.1

