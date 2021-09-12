Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B411407CFE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 13:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhILLHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 07:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbhILLHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 07:07:34 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0B0C061574;
        Sun, 12 Sep 2021 04:06:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bt14so14302847ejb.3;
        Sun, 12 Sep 2021 04:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tcrt2vTdi/TiU87GGXlT7ZwjrKmJjWziTIutSG17u3Q=;
        b=PuG4RrEsh+iBG7mWLV8JXiss/ImNpiIJkvPmDF3po1nawY+3iQSJgHZU9YJEd/8ac4
         idls7kfP8x+4t9kppYnbP9l3BQYi01mTG1ccG9/FLKA7l+gaUKqPAFcNHqIu9aUmfxrv
         +GvIeJXOHMzpC+/AThIqCKCaAfMVvEvgf7BRv7GbTQaZoIlowwA2TTvqJFb6j4TwPVJA
         JTLZHpRQamz3+sUn/WK3AbovBxhERQFapBhBLcn6Y2oXHLwWPLTBtzaSzJBQOC691QjR
         gXNKSPcX0ugp+Ds8vRoVaLHLaajTMaHtJveYUti7xaBWBA5ZU8FevK4jy2HQkUVeTbRo
         1GAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tcrt2vTdi/TiU87GGXlT7ZwjrKmJjWziTIutSG17u3Q=;
        b=Q8BGQ1sDUAvS/qCPbL9zvGpGDhjg3HTpJY+PpnAuRyaVTLZwNwXsHj2iEaoxzHzXKW
         3co8nHvCBCIJbl3oO0NqHwRzCf4q2lheBiis7hRbVg9deUzFUg+0JpsQOOs35v3gMryb
         tiDWocMmubS5BjbZYQSFdPCslwjK9NHocJxRWEU/GZW1T1sgp6jEotybh/lAGohxL8iX
         flZ4OAPC9zRAgUBfmHG6zAiwAHepiYEK6eSqIIqx8gNnn4S6MxX0bpO3y6mKGC0lsjpt
         YUHzH43Vfgv0qIOBbJva2kHeyTvaeXvgMK451ntkC5SEsRnzieQS7Kbv9wtuwC01sm7O
         POuA==
X-Gm-Message-State: AOAM533LLIoSJe4bSqZUT/foNTpCvg8pdbGQzIYpCPVRzirUEukLeijX
        xrr1DAOhJEPsCskbftGd2Cc=
X-Google-Smtp-Source: ABdhPJyRDYscIfZw368jy3+MJpzN5u1CmxSFzpT1bOCqrLlgvvkQPOxib/r60vIjd11ws7HS7NCppQ==
X-Received: by 2002:a17:906:86d4:: with SMTP id j20mr6929123ejy.563.1631444778402;
        Sun, 12 Sep 2021 04:06:18 -0700 (PDT)
Received: from localhost.localdomain (151-22-179-94.pool.ukrtel.net. [94.179.22.151])
        by smtp.gmail.com with ESMTPSA id qx18sm1896216ejb.75.2021.09.12.04.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 04:06:18 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com, Bernhard Seibold <mail@bernhard-seibold.de>,
        =?UTF-8?q?P=C3=A4r=20Ekholm?= <pehlm@pekholm.org>,
        to.eivind@gmail.com, "Artem S . Tashkinov" <aros@gmx.com>,
        Vittorio Roberto Alfieri <me@rebtoor.com>,
        Sahan Fernando <sahan.h.fernando@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] hwmon: (nct6775) Support access via Asus WMI
Date:   Sun, 12 Sep 2021 14:05:57 +0300
Message-Id: <20210912110557.41346-3-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210912110557.41346-1-pauk.denis@gmail.com>
References: <20210912110557.41346-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support accessing the NCT677x via Asus WMI functions.

On mainboards that support this way of accessing the chip, the driver will
usually not work without this option since in these mainboards, ACPI will 
mark the I/O port as used.

Code uses ACPI firmware interface to commucate with sensors with ASUS
motherboards:
* PRIME B460-PLUS,
* ROG CROSSHAIR VIII IMPACT,
* ROG STRIX B550-E GAMING,
* ROG STRIX B550-F GAMING,
* ROG STRIX B550-F GAMING (WI-FI),
* ROG STRIX Z490-I GAMING,
* TUF GAMING B550M-PLUS,
* TUF GAMING B550M-PLUS (WI-FI),
* TUF GAMING B550-PLUS,
* TUF GAMING X570-PLUS,
* TUF GAMING X570-PRO (WI-FI).

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Co-developed-by: Bernhard Seibold <mail@bernhard-seibold.de>
Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
Tested-by: Pär Ekholm <pehlm@pekholm.org>
Tested-by: <to.eivind@gmail.com>
Tested-by: Artem S. Tashkinov <aros@gmx.com>
Tested-by: Vittorio Roberto Alfieri <me@rebtoor.com>
Tested-by: Sahan Fernando <sahan.h.fernando@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>

---
Changes in v3:
  - Remove unrequired type conversions.
  - save result of match_string before check.

Changes in v2:
  - Split changes to separate patches.
  - Limit WMI usage by DMI_BOARD_NAME in checked ASUS motherboards.
---
 drivers/hwmon/nct6775.c | 230 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 207 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index a3adfce8dbb8..2bf9ca6e6ff9 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -55,6 +55,7 @@
 #include <linux/dmi.h>
 #include <linux/io.h>
 #include <linux/nospec.h>
+#include <linux/wmi.h>
 #include "lm75.h"
 
 #define USE_ALTERNATE
@@ -132,10 +133,13 @@ MODULE_PARM_DESC(fan_debounce, "Enable debouncing for fan RPM signal");
 #define SIO_ID_MASK		0xFFF8
 
 enum pwm_enable { off, manual, thermal_cruise, speed_cruise, sf3, sf4 };
+enum sensor_access { access_direct, access_asuswmi };
 
 struct nct6775_sio_data {
 	int sioreg;
+	int ld;
 	enum kinds kind;
+	enum sensor_access access;
 
 	/* superio_() callbacks  */
 	void (*outb)(struct nct6775_sio_data *sio_data, int reg, int val);
@@ -145,6 +149,84 @@ struct nct6775_sio_data {
 	void (*exit)(struct nct6775_sio_data *sio_data);
 };
 
+#define ASUSWMI_MGMT2_GUID		"466747A0-70EC-11DE-8A39-0800200C9A66"
+#define ASUSWMI_METHODID_RSIO		0x5253494F
+#define ASUSWMI_METHODID_WSIO		0x5753494F
+#define ASUSWMI_METHODID_RHWM		0x5248574D
+#define ASUSWMI_METHODID_WHWM		0x5748574D
+#define ASUSWMI_UNSUPPORTED_METHOD	0xFFFFFFFE
+
+static int asuswmi_evaluate_method(u32 method_id, u8 bank, u8 reg, u8 val, u32 *retval)
+{
+	u32 args = bank | (reg << 8) | (val << 16);
+	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
+	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_status status;
+	union acpi_object *obj;
+	u32 tmp = 0;
+
+	status = wmi_evaluate_method(ASUSWMI_MGMT2_GUID, 0, method_id,
+				     &input, &output);
+
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	obj = output.pointer;
+	if (obj && obj->type == ACPI_TYPE_INTEGER)
+		tmp = obj->integer.value;
+
+	if (retval)
+		*retval = tmp;
+
+	kfree(obj);
+
+	if (tmp == ASUSWMI_UNSUPPORTED_METHOD)
+		return -ENODEV;
+	return 0;
+}
+
+static inline int nct6775_asuswmi_write(u8 bank, u8 reg, u8 val)
+{
+	return asuswmi_evaluate_method(ASUSWMI_METHODID_WHWM, bank, reg, val, 0);
+}
+
+static inline int nct6775_asuswmi_read(u8 bank, u8 reg, u8 *val)
+{
+	u32 tmp;
+	int ret = asuswmi_evaluate_method(ASUSWMI_METHODID_RHWM, bank, reg, 0, &tmp);
+	*val = tmp;
+	return ret;
+}
+
+static int superio_wmi_inb(struct nct6775_sio_data *sio_data, int reg)
+{
+	int tmp;
+
+	asuswmi_evaluate_method(ASUSWMI_METHODID_RSIO,
+			sio_data->ld, reg, 0, &tmp);
+	return tmp;
+}
+
+static void superio_wmi_outb(struct nct6775_sio_data *sio_data, int reg, int val)
+{
+	asuswmi_evaluate_method(ASUSWMI_METHODID_WSIO,
+			sio_data->ld, reg, val, 0);
+}
+
+static void superio_wmi_select(struct nct6775_sio_data *sio_data, int ld)
+{
+	sio_data->ld = ld;
+}
+
+static int superio_wmi_enter(struct nct6775_sio_data *sio_data)
+{
+	return 0;
+}
+
+static void superio_wmi_exit(struct nct6775_sio_data *sio_data)
+{
+}
+
 static void superio_outb(struct nct6775_sio_data *sio_data, int reg, int val)
 {
 	int ioreg = sio_data->sioreg;
@@ -1423,6 +1505,49 @@ static bool is_word_sized(struct nct6775_data *data, u16 reg)
 	return false;
 }
 
+static inline void nct6775_wmi_set_bank(struct nct6775_data *data, u16 reg)
+{
+	u8 bank = reg >> 8;
+
+	data->bank = bank;
+}
+
+static u16 nct6775_wmi_read_value(struct nct6775_data *data, u16 reg)
+{
+	int res, word_sized = is_word_sized(data, reg);
+	u8 tmp;
+
+	nct6775_wmi_set_bank(data, reg);
+
+	nct6775_asuswmi_read(data->bank, reg, &tmp);
+	res = (tmp & 0xff);
+	if (word_sized) {
+		nct6775_asuswmi_read(data->bank,
+				(reg & 0xff) + 1, &tmp);
+		res = (res << 8) + (tmp & 0xff);
+	}
+	return res;
+}
+
+static int nct6775_wmi_write_value(struct nct6775_data *data, u16 reg, u16 value)
+{
+	int word_sized = is_word_sized(data, reg);
+
+	nct6775_wmi_set_bank(data, reg);
+
+	if (word_sized) {
+		nct6775_asuswmi_write(data->bank, (reg & 0xff),
+				(value >> 8) & 0xff);
+		nct6775_asuswmi_write(data->bank, (reg & 0xff) + 1,
+				value & 0xff);
+	} else {
+		nct6775_asuswmi_write(data->bank, (reg & 0xff),
+				value);
+	}
+
+	return 0;
+}
+
 /*
  * On older chips, only registers 0x50-0x5f are banked.
  * On more recent chips, all registers are banked.
@@ -3822,13 +3947,15 @@ static int nct6775_probe(struct platform_device *pdev)
 	struct device *hwmon_dev;
 	int num_attr_groups = 0;
 
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!res)
-		return -EBUSY;
+	if (sio_data->access == access_direct) {
+		res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+		if (!res)
+			return -EBUSY;
 
-	if (!devm_request_region(&pdev->dev, res->start, IOREGION_LENGTH,
-				 DRVNAME))
-		return -EBUSY;
+		if (!devm_request_region(&pdev->dev, res->start, IOREGION_LENGTH,
+					 DRVNAME))
+			return -EBUSY;
+	}
 
 	data = devm_kzalloc(&pdev->dev, sizeof(struct nct6775_data),
 			    GFP_KERNEL);
@@ -3837,9 +3964,17 @@ static int nct6775_probe(struct platform_device *pdev)
 
 	data->kind = sio_data->kind;
 	data->sioreg = sio_data->sioreg;
-	data->addr = res->start;
-	data->read_value = nct6775_read_value;
-	data->write_value = nct6775_write_value;
+
+	if (sio_data->access == access_direct) {
+		data->addr = res->start;
+		data->read_value = nct6775_read_value;
+		data->write_value = nct6775_write_value;
+	} else {
+		data->addr = 0;
+		data->read_value = nct6775_wmi_read_value;
+		data->write_value = nct6775_wmi_write_value;
+	}
+
 	mutex_init(&data->update_lock);
 	data->name = nct6775_device_names[data->kind];
 	data->bank = 0xff;		/* Force initial bank selection */
@@ -4750,6 +4885,7 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 	int err;
 	int addr;
 
+	sio_data->access = access_direct;
 	sio_data->sioreg = sioaddr;
 
 	err = sio_data->enter(sio_data);
@@ -4844,6 +4980,22 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
  */
 static struct platform_device *pdev[2];
 
+#define NCT6775_REG_CHIPID 0x58
+
+static const char * const asus_wmi_boards[] = {
+	"PRIME B460-PLUS",
+	"ROG CROSSHAIR VIII IMPACT",
+	"ROG STRIX B550-E GAMING",
+	"ROG STRIX B550-F GAMING",
+	"ROG STRIX B550-F GAMING (WI-FI)",
+	"ROG STRIX Z490-I GAMING",
+	"TUF GAMING B550M-PLUS",
+	"TUF GAMING B550M-PLUS (WI-FI)",
+	"TUF GAMING B550-PLUS",
+	"TUF GAMING X570-PLUS",
+	"TUF GAMING X570-PRO (WI-FI)",
+};
+
 static int __init sensors_nct6775_init(void)
 {
 	int i, err;
@@ -4852,11 +5004,30 @@ static int __init sensors_nct6775_init(void)
 	struct resource res;
 	struct nct6775_sio_data sio_data;
 	int sioaddr[2] = { 0x2e, 0x4e };
+	const char *board_vendor, *board_name;
+	enum sensor_access access = access_direct;
+	u8 tmp;
 
 	err = platform_driver_register(&nct6775_driver);
 	if (err)
 		return err;
 
+	board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
+	board_name = dmi_get_system_info(DMI_BOARD_NAME);
+
+	if (board_name && board_vendor &&
+	    !strcmp(board_vendor, "ASUSTeK COMPUTER INC.")) {
+		err = match_string(asus_wmi_boards,
+					ARRAY_SIZE(asus_wmi_boards), board_name);
+		if (err != -EINVAL) {
+			/* if reading chip id via WMI succeeds, use WMI */
+			if (!nct6775_asuswmi_read(0, NCT6775_REG_CHIPID, &tmp)) {
+				pr_info("Using Asus WMI to access chip\n");
+				access = access_asuswmi;
+			}
+		}
+	}
+
 	/*
 	 * initialize sio_data->kind and sio_data->sioreg.
 	 *
@@ -4877,6 +5048,17 @@ static int __init sensors_nct6775_init(void)
 
 		found = true;
 
+		/* Update access method */
+		sio_data.access = access;
+
+		if (access == access_asuswmi) {
+			sio_data.outb = superio_wmi_outb;
+			sio_data.inb = superio_wmi_inb;
+			sio_data.select = superio_wmi_select;
+			sio_data.enter = superio_wmi_enter;
+			sio_data.exit = superio_wmi_exit;
+		}
+
 		pdev[i] = platform_device_alloc(DRVNAME, address);
 		if (!pdev[i]) {
 			err = -ENOMEM;
@@ -4888,23 +5070,25 @@ static int __init sensors_nct6775_init(void)
 		if (err)
 			goto exit_device_put;
 
-		memset(&res, 0, sizeof(res));
-		res.name = DRVNAME;
-		res.start = address + IOREGION_OFFSET;
-		res.end = address + IOREGION_OFFSET + IOREGION_LENGTH - 1;
-		res.flags = IORESOURCE_IO;
+		if (sio_data.access == access_direct) {
+			memset(&res, 0, sizeof(res));
+			res.name = DRVNAME;
+			res.start = address + IOREGION_OFFSET;
+			res.end = address + IOREGION_OFFSET + IOREGION_LENGTH - 1;
+			res.flags = IORESOURCE_IO;
+
+			err = acpi_check_resource_conflict(&res);
+			if (err) {
+				platform_device_put(pdev[i]);
+				pdev[i] = NULL;
+				continue;
+			}
 
-		err = acpi_check_resource_conflict(&res);
-		if (err) {
-			platform_device_put(pdev[i]);
-			pdev[i] = NULL;
-			continue;
+			err = platform_device_add_resources(pdev[i], &res, 1);
+			if (err)
+				goto exit_device_put;
 		}
 
-		err = platform_device_add_resources(pdev[i], &res, 1);
-		if (err)
-			goto exit_device_put;
-
 		/* platform_device_add calls probe() */
 		err = platform_device_add(pdev[i]);
 		if (err)
-- 
2.33.0

