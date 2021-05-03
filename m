Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D804E3718C6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhECP7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhECP7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:59:50 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146DFC06174A;
        Mon,  3 May 2021 08:58:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n205so2752538wmf.1;
        Mon, 03 May 2021 08:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=iub6Xj5pTW14nrFThvnrim86SrZ/rWRt2j81/3U780Q=;
        b=fiVnWpiu2nPKN5wdj6Mftj6flCCohMp4lSHrP6Qe+HRtHvRl5ZOm+FbaZa8SClXbzy
         shNuntVMr7XUh19e+FM0aDprGHmjXqaAEnUZcRsqqNP1g9xsrS3DkQ1omNbGzlqac81N
         uudBj9OVuM8I/B8UsoRMXHAD1a2Vg6MHWNlFv92WL1q0ULXxI8NF/QwYBrFm/fRsqKz9
         qlQWkF/42pX8pYaRF3nn5HZ3RCkflJiQijNDJVumUe2FojmyrNi8L8tZ74/f4f2skvA3
         FoE5vr/jISfRFy15c3r/dsi3kTHo1MNyMvJOdcw4lDM54CEA70DqE7vzVMmy0FVLopU+
         x2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=iub6Xj5pTW14nrFThvnrim86SrZ/rWRt2j81/3U780Q=;
        b=SlbjPygwYXhV77wZUxcAHSwuPfBY0++lKlkBEi56Y5fQKpaaGenZZ4QLYs8LamKzU2
         eSkOaPN/wPynhLi/y/W/DDhRtCOCjmsCikyKQ1jTGiNAYCciwHzm1xqYrojZrbcqwDfq
         kiByXIjeoFBDgrKPt1wusas0AJYDCy46bhbSIMVprnEqb4MZsuEJb8cPRlG+oR0OPjbG
         6Rp20JG/PKjMPuEDwVBlbnFf1We5juH3B9Ig3z/t8oDOMpdR5Pl3Df7WNpCCTCtHKOKS
         rsIQsFcFdF6DYoTQKTl9O4RV3Ja2obplw6cbmWE2gZSaudEnk2Kr5JiUG5wytBpShyBl
         OxWg==
X-Gm-Message-State: AOAM533ECnD8dMJMc/UxMmF24BmFq+aQPTgdMz/rEPkiEp00oe/Masf4
        vC7+tDk+pmgM/LTHdYpXV53XOSkmUf7I5zMj
X-Google-Smtp-Source: ABdhPJw4glafBXb++Mu+eLgGT65wIzWWIuF7m4NBM6PUo1llXegkRIe9HRCyZi8f9/0RXDqfRJ4u7w==
X-Received: by 2002:a05:600c:243:: with SMTP id 3mr22346571wmj.58.1620057534730;
        Mon, 03 May 2021 08:58:54 -0700 (PDT)
Received: from corsair.sunwire.eu (159-205-138-105.adsl.inetia.pl. [159.205.138.105])
        by smtp.gmail.com with ESMTPSA id l13sm22118637wmj.3.2021.05.03.08.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 08:58:54 -0700 (PDT)
From:   =?UTF-8?Q?Pawe=c5=82_Marciniak?= <sunwire@gmail.com>
Subject: [PATCH] Add ASRock HDD Saver support
To:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <a83f15e3-ac09-abf2-d8da-7b1ac86efc70@gmail.com>
Date:   Mon, 3 May 2021 17:58:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the asrock motherboards are equipped with hdd saver technology.
It is implemented via a special power connector on the motherboard and a =
corresponding custom made power cable with two SATA power ports.
The control is via the gpio10 pin of the nct6791d chip.
When this technology is available the module creates the hddsaver_enable =
file.
Reading the file returns the current status, while writing turns off or o=
n the power of the SATA connectors.

Supported motheboards:
ASRock Z97 Extreme4 - works 100% tested.
ASRock Z97 Extreme6 - Based on boardview/schematic should works, not test=
ed.
Other ASRock motherboards supporting this technology - status unknown.

Signed-off-by: Pawe=B3 Marciniak <sunwire@gmail.com>
---
  drivers/hwmon/nct6775.c | 80 +++++++++++++++++++++++++++++++++++++++++
  1 file changed, 80 insertions(+)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 5bd1562..17b70f3 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -110,6 +110,7 @@ MODULE_PARM_DESC(fan_debounce, "Enable debouncing for=
fan RPM signal");
  #define NCT6775_LD_ACPI		0x0a
  #define NCT6775_LD_HWM		0x0b
  #define NCT6775_LD_VID		0x0d
+#define NCT6775_LD_GPIO_DATA		0x08
  #define NCT6775_LD_12		0x12

  #define SIO_REG_LDSEL		0x07	/* Logical device select */
@@ -229,6 +230,7 @@ static const u16 NCT6775_REG_IN[] =3D {
  #define NCT6775_REG_FANDIV2		0x507

  #define NCT6775_REG_CR_FAN_DEBOUNCE	0xf0
+#define NCT6775_REG_CR_GPIO1_DATA	0xf1

  static const u16 NCT6775_REG_ALARM[NUM_REG_ALARM] =3D { 0x459, 0x45A, 0=
x45B };

@@ -1205,6 +1207,8 @@ struct nct6775_data {
  	u8 vrm;

  	bool have_vid;
+	bool have_hddsaver; /* True if hdd saver is supported */
+	bool hddsaver_status; /* True if enabled */

  	u16 have_temp;
  	u16 have_temp_fixed;
@@ -1987,6 +1991,48 @@ store_beep(struct device *dev, struct device_attri=
bute *attr, const char *buf,
  	return count;
  }

+static ssize_t
+show_hddsaver(struct device *dev, struct device_attribute *attr, char *b=
uf)
+{
+	struct nct6775_data *data =3D nct6775_update_device(dev);
+
+	return sprintf(buf, "%s\n", (data->hddsaver_status ? "On" : "Off"));
+}
+
+static ssize_t
+store_hddsaver(struct device *dev, struct device_attribute *attr, const =
char *buf,
+	       size_t count)
+{
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	bool val;
+	int err, ret;
+	u8 tmp;
+
+	err =3D kstrtobool(buf, &val);
+	if (err =3D=3D -EINVAL)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	ret =3D superio_enter(data->sioreg);
+	if (ret) {
+		count =3D ret;
+		goto error;
+	}
+
+	if (val !=3D data->hddsaver_status) {
+		superio_select(data->sioreg, NCT6775_LD_GPIO_DATA); /* Logical Device =
8 */
+		tmp =3D superio_inb(data->sioreg,
+				  NCT6775_REG_CR_GPIO1_DATA); /* GPIO1 date reg */
+		superio_outb(data->sioreg, NCT6775_REG_CR_GPIO1_DATA, tmp ^ (1<<0));
+		data->hddsaver_status =3D val;
+		pr_info("HDD Saver is %s\n", val ? "On" : "Off");
+	}
+	superio_exit(data->sioreg);
+error:
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
  static ssize_t
  show_temp_beep(struct device *dev, struct device_attribute *attr, char =
*buf)
  {
@@ -3455,6 +3501,8 @@ static SENSOR_DEVICE_ATTR(intrusion1_beep, S_IWUSR =
| S_IRUGO, show_beep,
  			  store_beep, INTRUSION_ALARM_BASE + 1);
  static SENSOR_DEVICE_ATTR(beep_enable, S_IWUSR | S_IRUGO, show_beep,
  			  store_beep, BEEP_ENABLE_BASE);
+static SENSOR_DEVICE_ATTR(hddsaver_enable, S_IWUSR | S_IRUGO, show_hddsa=
ver,
+			  store_hddsaver, 0);

  static umode_t nct6775_other_is_visible(struct kobject *kobj,
  					struct attribute *attr, int index)
@@ -3475,6 +3523,9 @@ static umode_t nct6775_other_is_visible(struct kobj=
ect *kobj,
  			return 0;
  	}

+	if (index =3D=3D 6 && !data->have_hddsaver)
+		return 0;
+
  	return attr->mode;
  }

@@ -3490,6 +3541,7 @@ static struct attribute *nct6775_attributes_other[]=
=3D {
  	&sensor_dev_attr_intrusion0_beep.dev_attr.attr,		/* 3 */
  	&sensor_dev_attr_intrusion1_beep.dev_attr.attr,		/* 4 */
  	&sensor_dev_attr_beep_enable.dev_attr.attr,		/* 5 */
+	&sensor_dev_attr_hddsaver_enable.dev_attr.attr,		/* 6 */

  	NULL
  };
@@ -3805,6 +3857,8 @@ static int nct6775_probe(struct platform_device *pd=
ev)
  	struct device *hwmon_dev;
  	int num_attr_groups =3D 0;

+	const char *board_vendor, *board_name;
+
  	res =3D platform_get_resource(pdev, IORESOURCE_IO, 0);
  	if (!devm_request_region(&pdev->dev, res->start, IOREGION_LENGTH,
  				 DRVNAME))
@@ -4502,6 +4556,9 @@ static int nct6775_probe(struct platform_device *pd=
ev)
  	/* Initialize the chip */
  	nct6775_init_device(data);

+	board_vendor =3D dmi_get_system_info(DMI_BOARD_VENDOR);
+	board_name =3D dmi_get_system_info(DMI_BOARD_NAME);
+
  	err =3D superio_enter(sio_data->sioreg);
  	if (err)
  		return err;
@@ -4518,6 +4575,15 @@ static int nct6775_probe(struct platform_device *p=
dev)
  	case nct6116:
  	case nct6779:
  	case nct6791:
+		if (board_name && board_vendor &&
+		    !strcmp(board_vendor, "ASRock")) {
+            /* Z97 Extreme6 should also work (the same GPIO10 pin is use=
d) */
+            /* but it needs testing!!! */
+			if (!strcmp(board_name, "Z97 Extreme4") || !strcmp(board_name, "Z97 E=
xtreme6")) {
+                data->have_hddsaver =3D (cr2a & (1<<6));
+            }
+        }
+        break;
  	case nct6792:
  	case nct6793:
  	case nct6795:
@@ -4527,6 +4593,20 @@ static int nct6775_probe(struct platform_device *p=
dev)
  		break;
  	}

+	if (data->have_hddsaver) {
+		u8 tmp;
+
+		pr_notice("HDD Saver found\n");
+		superio_select(sio_data->sioreg, NCT6775_LD_GPIO_DATA); /* Logical Dev=
ice 8 */
+		tmp =3D superio_inb(sio_data->sioreg, NCT6775_REG_CR_GPIO1_DATA); /* G=
PIO1 date reg */
+		data->hddsaver_status =3D tmp & (1<<0); /* check bit0 */
+		if (data->hddsaver_status) {
+			pr_warn("HDD Saver is disabled\n");
+		} else {
+			pr_warn("HDD Saver is enabled\n");
+		}
+	}
+
  	/*
  	 * Read VID value
  	 * We can get the VID input values directly at logical device D 0xe3.
--=20
2.31.1


