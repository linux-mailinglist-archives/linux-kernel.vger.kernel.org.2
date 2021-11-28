Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3A146091A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 19:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359190AbhK1Svn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 13:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbhK1Stc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 13:49:32 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5DEC061756;
        Sun, 28 Nov 2021 10:46:15 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t5so62676007edd.0;
        Sun, 28 Nov 2021 10:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zper/oRWwE3imxn/cLlSmDdkvNOi7B9bVzq3y2Trn0=;
        b=hx28hZoGiVOwxCKi9x1RfD68kvtKvyGKt3ZxkcRBPPXtrlBfaPTL903plk+oWL4FZj
         gD49PdWTR4QG8EzAfLVSexh8hpyYKIAownDf/YHeMAPaxkNwMf4awAWVP6Thah4a1ryt
         Vy9BNVq5orlRf/lajAQiFi/7loksmTNvag61nWhCKQGwLperEYF1P/HI1QtqeDvtK1+m
         Xm8DSvKrBhJ02pRiwLngpTrC7+UnjWlTpEVD03se+QjfF/pgnv3ivVFczMZomD2zU6Mx
         SzuGbbEtd13eOkLLCdhVqtNUFYiDG3BPNu+DBy2CPUk6k1ce/2Krsh1AgOrtwVahzHcz
         muZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zper/oRWwE3imxn/cLlSmDdkvNOi7B9bVzq3y2Trn0=;
        b=4wkEc0ON4f8WRPZmr//9J7N1kZ+5yk7g2OFlVVDSQ8HAyKgGdyGs0z0j55WC5YkRdd
         FIhV7YnpSesISxmFXPVfAaYxWOtbcXc5Y33r0V/WRNjgW70SVNutbJiQ4IhuMAXT8psU
         NgWLg6JdZ20kAPCp18J2czZvRgQ3TY4qX0jV8p1hiBO50Ble/bw/7RfVZ/b1QAmKRFh7
         ubBJYD8lFYlDOsZm08b1xvGnQUlx7fKkJC54/2yKtJ8VHWY2hX1ZfRSBpVrJnXv77f2k
         Ld7VhzQ8S67rX9DmabvfNYrl/LrA86pPS03XMvrH5rQ1vVyzB6g3Vl1vzedOYcAT4QyL
         /HJg==
X-Gm-Message-State: AOAM5323l4RkTJAwuev2jQgTKJ/LllkGx9Q67+/IIfUyKWifBel6u1xq
        N6Gh8xBPnOSGEtFgr8Ie/MQ=
X-Google-Smtp-Source: ABdhPJwZgncrx6pWXJ1ilrZrryFxIRYG7hKEgMB2maYBQjExZcNqjKRO/TExpO+QJ4rF/Wb8lKQgdg==
X-Received: by 2002:a05:6402:4413:: with SMTP id y19mr66464941eda.26.1638125173913;
        Sun, 28 Nov 2021 10:46:13 -0800 (PST)
Received: from localhost.localdomain ([94.179.32.10])
        by smtp.gmail.com with ESMTPSA id g1sm6072900eje.105.2021.11.28.10.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 10:46:13 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        Olli Asikainen <olli.asikainen@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] hwmon: (nct6775) add MAXIMUS VII HERO
Date:   Sun, 28 Nov 2021 20:45:48 +0200
Message-Id: <20211128184549.9161-4-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211128184549.9161-1-pauk.denis@gmail.com>
References: <20211128184549.9161-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS MAXIMUS VII HERO board has got a nct6775 chip, but by default
there's no use of it because of resource conflict with WMI method.

This commit adds MAXIMUS VII HERO to the list of boards and provides
ACPI mutex name that can be used as shared lock with ASUS WMI.

Logic checks that mutex is available. If mutex is not available
tries to get a chip ID by ACPI WMI interface.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Tested-by: Olli Asikainen <olli.asikainen@gmail.com>

---
Changes in v2:
- Fix commit message.
- Remove default acpi_board_ANY and use NULL instead.
- Use chip ID everywhere.
---
 drivers/hwmon/nct6775.c | 118 ++++++++++++++++++++++++++--------------
 1 file changed, 76 insertions(+), 42 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 206c20a1ae9b..ea99f68b9146 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -5109,34 +5109,59 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
  */
 static struct platform_device *pdev[2];
 
-static const char * const asus_wmi_boards[] = {
-	"ProArt X570-CREATOR WIFI",
-	"Pro WS X570-ACE",
-	"PRIME B360-PLUS",
-	"PRIME B460-PLUS",
-	"PRIME X570-PRO",
-	"ROG CROSSHAIR VIII DARK HERO",
-	"ROG CROSSHAIR VIII FORMULA",
-	"ROG CROSSHAIR VIII HERO",
-	"ROG CROSSHAIR VIII IMPACT",
-	"ROG STRIX B550-E GAMING",
-	"ROG STRIX B550-F GAMING",
-	"ROG STRIX B550-F GAMING (WI-FI)",
-	"ROG STRIX B550-I GAMING",
-	"ROG STRIX X570-F GAMING",
-	"ROG STRIX Z390-E GAMING",
-	"ROG STRIX Z490-I GAMING",
-	"TUF GAMING B550M-PLUS",
-	"TUF GAMING B550M-PLUS (WI-FI)",
-	"TUF GAMING B550-PLUS",
-	"TUF GAMING B550-PRO",
-	"TUF GAMING X570-PLUS",
-	"TUF GAMING X570-PLUS (WI-FI)",
-	"TUF GAMING X570-PRO (WI-FI)",
-	"TUF GAMING Z490-PLUS",
-	"TUF GAMING Z490-PLUS (WI-FI)",
+struct acpi_board_info {
+	char *acpi_mutex_path;
 };
 
+#define DMI_ASUS_BOARD_INFO(name, mutex_path)			\
+static struct acpi_board_info name = {				\
+	.acpi_mutex_path = mutex_path,				\
+}
+
+DMI_ASUS_BOARD_INFO(acpi_board_MAXIMUS_VII_HERO, "\\_SB_.PCI0.LPCB.SIO1.MUT0");
+DMI_ASUS_BOARD_INFO(acpi_board_ROG_STRIX_B550_E_GAMING, "\\_SB.PCI0.SBRG.SIO1.MUT0");
+
+#define DMI_EXACT_MATCH_ASUS_BOARD_NAME(name, info) {			\
+	.matches = {								\
+		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),	\
+		DMI_EXACT_MATCH(DMI_BOARD_NAME, name),				\
+	},									\
+	.driver_data = info,							\
+}
+
+static const struct dmi_system_id asus_wmi_info_table[] = {
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("MAXIMUS VII HERO", &acpi_board_MAXIMUS_VII_HERO),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME B360-PLUS", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME B460-PLUS", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME B550M-A (WI-FI)", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X570-PRO", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("Pro WS X570-ACE", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt X570-CREATOR WIFI", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII DARK HERO", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII FORMULA", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII HERO", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII IMPACT", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-E GAMING",
+					&acpi_board_ROG_STRIX_B550_E_GAMING),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-F GAMING", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-F GAMING (WI-FI)", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-I GAMING", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X570-F GAMING", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z390-E GAMING", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z490-I GAMING", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING B550-PLUS", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING B550-PRO", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING B550M-PLUS", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING B550M-PLUS (WI-FI)", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X570-PLUS", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X570-PLUS (WI-FI)", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X570-PRO (WI-FI)", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING Z490-PLUS", NULL),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING Z490-PLUS (WI-FI)", NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(dmi, asus_wmi_info_table);
+
 static int __init sensors_nct6775_init(void)
 {
 	int i, err;
@@ -5146,28 +5171,37 @@ static int __init sensors_nct6775_init(void)
 	struct nct6775_sio_data sio_data;
 	int sioaddr[2] = { 0x2e, 0x4e };
 	enum sensor_access access = access_direct;
-	const char *board_vendor, *board_name;
+	const struct dmi_system_id *dmi_id;
+	struct acpi_board_info *board_info;
 	acpi_handle acpi_wmi_mutex = NULL;
-	u8 tmp;
+	acpi_status status;
+	u8 tmp = 0;
 
 	err = platform_driver_register(&nct6775_driver);
 	if (err)
 		return err;
 
-	board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
-	board_name = dmi_get_system_info(DMI_BOARD_NAME);
-
-	if (board_name && board_vendor &&
-	    !strcmp(board_vendor, "ASUSTeK COMPUTER INC.")) {
-		err = match_string(asus_wmi_boards, ARRAY_SIZE(asus_wmi_boards),
-				   board_name);
-		if (err >= 0) {
-			/* if reading chip id via WMI succeeds, use WMI */
-			if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp)) {
-				pr_info("Using Asus WMI to access %#x chip.\n", tmp);
-				access = access_asuswmi;
-			} else {
-				pr_err("Can't read ChipID by Asus WMI.\n");
+	dmi_id = dmi_first_match(asus_wmi_info_table);
+	if (dmi_id) {
+		/* if reading chip ID via WMI succeeds, use WMI */
+		if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp) &&
+		    tmp) {
+			pr_info("Using Asus WMI to access %#x chip.\n", tmp);
+			access = access_asuswmi;
+		} else {
+			pr_err("Can't read chip ID by Asus WMI.\n");
+		}
+
+		if (dmi_id->driver_data) {
+			board_info = dmi_id->driver_data;
+			if (board_info->acpi_mutex_path) {
+				status = acpi_get_handle(NULL, board_info->acpi_mutex_path,
+							 &acpi_wmi_mutex);
+				if (!ACPI_FAILURE(status)) {
+					pr_info("Using Asus WMI mutex: %s\n",
+						board_info->acpi_mutex_path);
+					access = access_direct;
+				}
 			}
 		}
 	}
-- 
2.33.0

