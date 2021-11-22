Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699504596B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 22:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhKVVcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 16:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbhKVVcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 16:32:18 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04413C06173E;
        Mon, 22 Nov 2021 13:29:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id c4so35155073wrd.9;
        Mon, 22 Nov 2021 13:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uHA+ux3swvBTxfcn8wnIHh5PqKgcC1OD4v495nCC3Mw=;
        b=f4OIKr36E/CoKJoiqG6NrbP5qzGR+5SCfdUaCMDy56AiA+BA3W9kVlLOq2PVnuDsVe
         GzlnF90simaKpE+j7uH7DIColD1p8ApcYXbqW9ed0FAMt0DeKtprqUA1k9ronl4EfjYd
         f942OyMrJPcWvvwrxotySZIElTna+HPzFFtYQ/dvYXLHNqOghFZRsWF8fajuFAX43DQM
         JYbtE7k0fhXDk1/cS+ykI+FKK1/bibUt7mQXUa7vEmN+FS0FNMZ7ndhntbp5e4DIsb/6
         UA53vbyYlC47FvdXpTJq0VV+4AmHB9bJGbLetP6IYgnjKwJhwbkDhGdxeL25+D1FQhAY
         h3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uHA+ux3swvBTxfcn8wnIHh5PqKgcC1OD4v495nCC3Mw=;
        b=Y1yReV1PRrw05NQ5trEC1RuEYAyoP400M9u9ghOCxTOUDjVALshx1WOp5jL4wiD0Lz
         KmEsFDV0qRtSpBM6Cqerm5J+Ui16AUck7xLdTLCya5LLBWmaZH0KVBYH/AfdOvgXg0Hk
         CJlLI8gaUDgZdPRlXJH/HrUlu52e3KoNvE5rjTt0a3qyzZi4fxiNS8hFBD9iQ9xCmspO
         qDSu+97iFtqIioMs9HKQGPv+vfKJVwvahzBotW6GzTziJ64Hcw4kVBNaeCqE/rIJIdiC
         8jAz357FNlwGU8rqpDDAAr54AnWUitBYDDs7Xh+4Z0EVKcPPsFf5515PokKzam792dtQ
         vc7Q==
X-Gm-Message-State: AOAM532iHfoCttizKYiKmTzac8VI0FSzO+uojFw/B38yfUuav2wl/Clv
        iMBSZTeogCCb9A9OZxVi0ei4OdEz2+/0Dw==
X-Google-Smtp-Source: ABdhPJzbAvf8eYIFancpdP1GgqgBiTzcJmZLM4bPFHzGLWfh5XxkjsS0SPnG/ABwNyzTwu3kwqSzkg==
X-Received: by 2002:a5d:64c4:: with SMTP id f4mr514877wri.6.1637616549531;
        Mon, 22 Nov 2021 13:29:09 -0800 (PST)
Received: from localhost.localdomain (149-45-179-94.pool.ukrtel.net. [94.179.45.149])
        by smtp.gmail.com with ESMTPSA id k8sm9767928wrn.91.2021.11.22.13.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 13:29:09 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        thomas@weissschuh.net, Olli Asikainen <olli.asikainen@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] hwmon: (nct6775) add MAXIMUS VII HERO.
Date:   Mon, 22 Nov 2021 23:28:50 +0200
Message-Id: <20211122212850.321542-4-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211122212850.321542-1-pauk.denis@gmail.com>
References: <20211122212850.321542-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS MAXIMUS VII HERO board has got an nct6775 chip, but by default
there's no use of it because of resource conflict with WMI method.

This commit adds MAXIMUS VII HERO to the list of boards and provides
ACPI mutex name that can be used as shared lock with ASUS WMI.

Logic checks that mutex is available. If mutex is not available
tries to get chip version by ACPI WMI interface.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Tested-by: Olli Asikainen <olli.asikainen@gmail.com>
---
 drivers/hwmon/nct6775.c | 121 +++++++++++++++++++++++++++-------------
 1 file changed, 81 insertions(+), 40 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 3aeb32093c35..c7a476bc4693 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -5100,34 +5100,60 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
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
+	char *acpi_mutex_name;
 };
 
+#define DMI_ASUS_BOARD_INFO(name, mutex_name)			\
+static struct acpi_board_info name = {				\
+	.acpi_mutex_name = mutex_name,				\
+}
+
+DMI_ASUS_BOARD_INFO(acpi_board_ANY, NULL);
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
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME B360-PLUS", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME B460-PLUS", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME B550M-A (WI-FI)", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X570-PRO", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("Pro WS X570-ACE", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt X570-CREATOR WIFI", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII DARK HERO", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII FORMULA", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII HERO", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII IMPACT", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-E GAMING",
+					&acpi_board_ROG_STRIX_B550_E_GAMING),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-F GAMING", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-F GAMING (WI-FI)", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-I GAMING", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X570-F GAMING", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z390-E GAMING", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z490-I GAMING", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING B550-PLUS", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING B550-PRO", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING B550M-PLUS", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING B550M-PLUS (WI-FI)", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X570-PLUS", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X570-PLUS (WI-FI)", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X570-PRO (WI-FI)", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING Z490-PLUS", &acpi_board_ANY),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING Z490-PLUS (WI-FI)", &acpi_board_ANY),
+	{}
+};
+MODULE_DEVICE_TABLE(dmi, asus_wmi_info_table);
+
 static int __init sensors_nct6775_init(void)
 {
 	int i, err;
@@ -5137,30 +5163,45 @@ static int __init sensors_nct6775_init(void)
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
+	dmi_id = dmi_first_match(asus_wmi_info_table);
+	if (dmi_id && dmi_id->driver_data) {
+		board_info = dmi_id->driver_data;
+		access = access_asuswmi;
 
-	if (board_name && board_vendor &&
-	    !strcmp(board_vendor, "ASUSTeK COMPUTER INC.")) {
-		err = match_string(asus_wmi_boards, ARRAY_SIZE(asus_wmi_boards),
-				   board_name);
-		if (err >= 0) {
-			/* if reading chip id via WMI succeeds, use WMI */
-			if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp)) {
-				pr_info("Using Asus WMI to access %#x chip.\n", tmp);
-				access = access_asuswmi;
+		if (board_info->acpi_mutex_name) {
+			status = acpi_get_handle(NULL, board_info->acpi_mutex_name,
+						 &acpi_wmi_mutex);
+			if (ACPI_FAILURE(status)) {
+				pr_err("Could not get hardware access guard mutex.\n");
 			} else {
-				pr_err("Can't read ChipID by Asus WMI.\n");
+				pr_info("Using Asus WMI mutex: %s\n", board_info->acpi_mutex_name);
+				access = access_direct;
 			}
 		}
+
+		/* if reading chip id via WMI succeeds, use WMI */
+		if (access == access_asuswmi &&
+		    nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp)) {
+			access = access_direct;
+			pr_err("Can't read ChipID by Asus WMI.\n");
+		}
+
+		if (access == access_asuswmi) {
+			if (tmp)
+				pr_info("Using Asus WMI to access %#x chip.\n", tmp);
+			else
+				access = access_direct;
+		}
 	}
 
 	/*
-- 
2.33.0

