Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D99D420111
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 11:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhJCJWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 05:22:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:36433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhJCJWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 05:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633252810;
        bh=vxxpT/p3A2WkiaOwwsToQ3x7kSXkc5nXpTnSC/GadsA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=GzPow3k/hdcrABf7wEavjBVvVLGYU82CjTg5En4VYXihYscIdfJEFaLmIdSGC0THE
         NiZbfQ7Kd7akxydFpBinXIlAp7fH6p0AnwdE8EHOVHR5CtwhfXffkARz3+VRes7xTY
         S9K6xD1X3mgkdIuCD4ivTUBt3u5Ev4b5o95HMkDE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MDywu-1mgp2L45wa-009yby; Sun, 03 Oct 2021 11:20:10 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] platform/x86: thinkpad_acpi: Convert platform driver to use dev_groups
Date:   Sun,  3 Oct 2021 11:19:49 +0200
Message-Id: <20211003091949.7339-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qisCq2fCCnPmUvK4l0VZe+WQ32dsJLilL4BN20qPsGoM2sMr6pb
 CI+Bys7R4B9u3YisN+Qn++2P+4HUOm/S0MENXK24bbiKKwKSb+F8aeQ/g7AKMoyZI9/bxQv
 hYWo//B7UDLSALexvEvz+PFDLvf3zEsPCaCK5KOJFjG/72MQEtbrWkGbWRC/z0O6GNxxTzW
 /5qoWLUDmhVYFFlAYlEqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vu3sp2CtUnM=:i8WIgynb5v48+ZR1c7lnJ5
 OA51pDfM7N56lv1qYGXLaWHjCK9ds4XZm85JLyKlk5w5SM+deqVPPqqCWf24KTi9hpSK1Erip
 m0dfNGSeOy+AiboMEVnYW3NbgwiBkCYeYrwoS5kzx+oZgCGQ4586lgOcW140YBO94Z1dWLFC4
 Ce/K0o6+JXkqvTzPVzya7CCDfXbk6e9+HXXBoOAX3yDD/W1ozXRyefT6FHh33P34UFIVPSB+r
 Z3MwBegr0Y2c7q6HBx535ONZEoTpAr1804S1qKVR2F0Nsj/1snT8hkPwUTXRzQd70tW7MjqOh
 1zcYEErJGZcDXwIl/ZNvO6y1Bm5EjTwRR7qnq/+RU4siroRcnYHeVKxTep+Ap4R480c3bN+/T
 Yhf5tJMI/DuKKlRNNQYiBp8K5ZgKuPQPz6N9fTlNNs33Ex+5DC/ZaccRpqF24XBiBqm7UFdGF
 IX471lDEi3A6PuEEcgCYmQiw2soC2vCF8GWW6/tLWixsne+eZ9Zb2uK606tugRen8AuJM+hUQ
 8znw2kutDfiUH5fJ3wOTLt+uwbKAGZVBpaigKMgU5IrlNQQZTaIiwp2XthZUeFF5NgSvd5QSf
 3wkf90+ItIM7Hi2/KzDNGjvPq4bAM8GYnc0S4HzGmoa5jNToWFi2aOC6CYi0RtihSB4hNkHzu
 yX+KtM72ArXWoBxkE/A8OvEXhLz2+tqfC/xyB3QZAjsOxQvlFdj5wYQNKJDzfPW33fg2dx5rZ
 kZptJOOxREiMafkIzgJFXNQYLJs8kiWC4zC8604Q0oRoqPBcx3LyrYrtKTBHfxOUNc6+mUoDu
 dekKgTz4xe9cZtfxSVZPZniQzamwdy2ocUdirT4fONksPCSNh0J0tai7Y5J5GVMt7Kvmmk4p5
 lPaDsQCEM1iJWqBZ8L/s2dV7M1qV7KSskaWKUZnHR2UKfGrbHT1jEd3ONdUCkqKcJ6bW2FqiH
 W5lZWDGKU7N/F2Yw5lgrNXxbCMIlC6wmjg25bQpsD8KMEUz4I42I4XIqFOp831j/T1rOPRsUh
 W42gC3eWn/M8H4FJfmizj0tTGAyVeakjkq4fwovvupjzw9a90o+XY9x/5Vc96KYnRtcaHThdv
 Zuk1zgg81ohwqo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform drivers have the option of having the platform core create and
remove any needed sysfs attribute files. So take advantage of that and
refactor the attributes management to avoid to register them "by hand".

Also, due to some attributes are optionals, refactor the code and move
the logic inside the "is_visible" callbacks of the attribute_group
structures.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/platform/x86/thinkpad_acpi.c | 536 ++++++++++++---------------
 1 file changed, 236 insertions(+), 300 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/t=
hinkpad_acpi.c
index 07b9710d500e..270eb4f373c9 100644
=2D-- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -332,9 +332,7 @@ static struct {
 	u32 battery_force_primary:1;
 	u32 input_device_registered:1;
 	u32 platform_drv_registered:1;
-	u32 platform_drv_attrs_registered:1;
 	u32 sensors_pdrv_registered:1;
-	u32 sensors_pdrv_attrs_registered:1;
 	u32 sensors_pdev_attrs_registered:1;
 	u32 hotkey_poll_active:1;
 	u32 has_adaptive_kbd:1;
@@ -983,20 +981,6 @@ static void tpacpi_shutdown_handler(struct platform_d=
evice *pdev)
 	}
 }

-static struct platform_driver tpacpi_pdriver =3D {
-	.driver =3D {
-		.name =3D TPACPI_DRVR_NAME,
-		.pm =3D &tpacpi_pm,
-	},
-	.shutdown =3D tpacpi_shutdown_handler,
-};
-
-static struct platform_driver tpacpi_hwmon_pdriver =3D {
-	.driver =3D {
-		.name =3D TPACPI_HWMON_DRVR_NAME,
-	},
-};
-
 /************************************************************************=
*
  * sysfs support helpers
  */
@@ -1488,53 +1472,6 @@ static ssize_t uwb_emulstate_store(struct device_dr=
iver *drv, const char *buf,
 static DRIVER_ATTR_RW(uwb_emulstate);
 #endif

-/* --------------------------------------------------------------------- =
*/
-
-static struct driver_attribute *tpacpi_driver_attributes[] =3D {
-	&driver_attr_debug_level, &driver_attr_version,
-	&driver_attr_interface_version,
-};
-
-static int __init tpacpi_create_driver_attributes(struct device_driver *d=
rv)
-{
-	int i, res;
-
-	i =3D 0;
-	res =3D 0;
-	while (!res && i < ARRAY_SIZE(tpacpi_driver_attributes)) {
-		res =3D driver_create_file(drv, tpacpi_driver_attributes[i]);
-		i++;
-	}
-
-#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
-	if (!res && dbg_wlswemul)
-		res =3D driver_create_file(drv, &driver_attr_wlsw_emulstate);
-	if (!res && dbg_bluetoothemul)
-		res =3D driver_create_file(drv, &driver_attr_bluetooth_emulstate);
-	if (!res && dbg_wwanemul)
-		res =3D driver_create_file(drv, &driver_attr_wwan_emulstate);
-	if (!res && dbg_uwbemul)
-		res =3D driver_create_file(drv, &driver_attr_uwb_emulstate);
-#endif
-
-	return res;
-}
-
-static void tpacpi_remove_driver_attributes(struct device_driver *drv)
-{
-	int i;
-
-	for (i =3D 0; i < ARRAY_SIZE(tpacpi_driver_attributes); i++)
-		driver_remove_file(drv, tpacpi_driver_attributes[i]);
-
-#ifdef THINKPAD_ACPI_DEBUGFACILITIES
-	driver_remove_file(drv, &driver_attr_wlsw_emulstate);
-	driver_remove_file(drv, &driver_attr_bluetooth_emulstate);
-	driver_remove_file(drv, &driver_attr_wwan_emulstate);
-	driver_remove_file(drv, &driver_attr_uwb_emulstate);
-#endif
-}
-
 /************************************************************************=
*
  * Firmware Data
  */
@@ -3008,7 +2945,14 @@ static struct attribute *adaptive_kbd_attributes[] =
=3D {
 	NULL
 };

+static umode_t hadaptive_kbd_attr_is_visible(struct kobject *kobj,
+					     struct attribute *attr, int n)
+{
+	return tp_features.has_adaptive_kbd ? attr->mode : 0;
+}
+
 static const struct attribute_group adaptive_kbd_attr_group =3D {
+	.is_visible =3D hadaptive_kbd_attr_is_visible,
 	.attrs =3D adaptive_kbd_attributes,
 };

@@ -3106,8 +3050,6 @@ static void hotkey_exit(void)
 	hotkey_poll_stop_sync();
 	mutex_unlock(&hotkey_mutex);
 #endif
-	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &hotkey_attr_group);
-
 	dbg_printk(TPACPI_DBG_EXIT | TPACPI_DBG_HKEY,
 		   "restoring original HKEY status and mask\n");
 	/* yes, there is a bitwise or below, we want the
@@ -3502,14 +3444,8 @@ static int __init hotkey_init(struct ibm_init_struc=
t *iibm)
 			 */
 			if (acpi_evalf(hkey_handle, &hotkey_adaptive_all_mask,
 				       "MHKA", "dd", 2)) {
-				if (hotkey_adaptive_all_mask !=3D 0) {
+				if (hotkey_adaptive_all_mask !=3D 0)
 					tp_features.has_adaptive_kbd =3D true;
-					res =3D sysfs_create_group(
-						&tpacpi_pdev->dev.kobj,
-						&adaptive_kbd_attr_group);
-					if (res)
-						goto err_exit;
-				}
 			} else {
 				tp_features.has_adaptive_kbd =3D false;
 				hotkey_adaptive_all_mask =3D 0x0U;
@@ -3563,9 +3499,6 @@ static int __init hotkey_init(struct ibm_init_struct=
 *iibm)
 	}

 	tabletsw_state =3D hotkey_init_tablet_mode();
-	res =3D sysfs_create_group(&tpacpi_pdev->dev.kobj, &hotkey_attr_group);
-	if (res)
-		goto err_exit;

 	/* Set up key map */
 	keymap_id =3D tpacpi_check_quirks(tpacpi_keymap_qtable,
@@ -3662,9 +3595,6 @@ static int __init hotkey_init(struct ibm_init_struct=
 *iibm)
 	return 0;

 err_exit:
-	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &hotkey_attr_group);
-	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &adaptive_kbd_attr_group);
-
 	return (res < 0) ? res : 1;
 }

@@ -4396,7 +4326,14 @@ static struct attribute *bluetooth_attributes[] =3D=
 {
 	NULL
 };

+static umode_t bluetooth_attr_is_visible(struct kobject *kobj,
+					 struct attribute *attr, int n)
+{
+	return tp_features.bluetooth ? attr->mode : 0;
+}
+
 static const struct attribute_group bluetooth_attr_group =3D {
+	.is_visible =3D bluetooth_attr_is_visible,
 	.attrs =3D bluetooth_attributes,
 };

@@ -4418,11 +4355,7 @@ static void bluetooth_shutdown(void)

 static void bluetooth_exit(void)
 {
-	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
-			&bluetooth_attr_group);
-
 	tpacpi_destroy_rfkill(TPACPI_RFK_BLUETOOTH_SW_ID);
-
 	bluetooth_shutdown();
 }

@@ -4536,17 +4469,7 @@ static int __init bluetooth_init(struct ibm_init_st=
ruct *iibm)
 				RFKILL_TYPE_BLUETOOTH,
 				TPACPI_RFK_BLUETOOTH_SW_NAME,
 				true);
-	if (res)
-		return res;
-
-	res =3D sysfs_create_group(&tpacpi_pdev->dev.kobj,
-				&bluetooth_attr_group);
-	if (res) {
-		tpacpi_destroy_rfkill(TPACPI_RFK_BLUETOOTH_SW_ID);
-		return res;
-	}
-
-	return 0;
+	return res;
 }

 /* procfs -------------------------------------------------------------- =
*/
@@ -4653,7 +4576,14 @@ static struct attribute *wan_attributes[] =3D {
 	NULL
 };

+static umode_t wan_attr_is_visible(struct kobject *kobj, struct attribute=
 *attr,
+				   int n)
+{
+	return tp_features.wan ? attr->mode : 0;
+}
+
 static const struct attribute_group wan_attr_group =3D {
+	.is_visible =3D wan_attr_is_visible,
 	.attrs =3D wan_attributes,
 };

@@ -4675,11 +4605,7 @@ static void wan_shutdown(void)

 static void wan_exit(void)
 {
-	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
-		&wan_attr_group);
-
 	tpacpi_destroy_rfkill(TPACPI_RFK_WWAN_SW_ID);
-
 	wan_shutdown();
 }

@@ -4723,18 +4649,7 @@ static int __init wan_init(struct ibm_init_struct *=
iibm)
 				RFKILL_TYPE_WWAN,
 				TPACPI_RFK_WWAN_SW_NAME,
 				true);
-	if (res)
-		return res;
-
-	res =3D sysfs_create_group(&tpacpi_pdev->dev.kobj,
-				&wan_attr_group);
-
-	if (res) {
-		tpacpi_destroy_rfkill(TPACPI_RFK_WWAN_SW_ID);
-		return res;
-	}
-
-	return 0;
+	return res;
 }

 /* procfs -------------------------------------------------------------- =
*/
@@ -5635,30 +5550,35 @@ static ssize_t cmos_command_store(struct device *d=
ev,

 static DEVICE_ATTR_WO(cmos_command);

+static struct attribute *cmos_attributes[] =3D {
+	&dev_attr_cmos_command.attr,
+	NULL
+};
+
+static umode_t cmos_attr_is_visible(struct kobject *kobj,
+				    struct attribute *attr, int n)
+{
+	return cmos_handle ? attr->mode : 0;
+}
+
+static const struct attribute_group cmos_attr_group =3D {
+	.is_visible =3D cmos_attr_is_visible,
+	.attrs =3D cmos_attributes,
+};
+
 /* --------------------------------------------------------------------- =
*/

 static int __init cmos_init(struct ibm_init_struct *iibm)
 {
-	int res;
-
 	vdbg_printk(TPACPI_DBG_INIT,
-		"initializing cmos commands subdriver\n");
+		    "initializing cmos commands subdriver\n");

 	TPACPI_ACPIHANDLE_INIT(cmos);

 	vdbg_printk(TPACPI_DBG_INIT, "cmos commands are %s\n",
-		str_supported(cmos_handle !=3D NULL));
-
-	res =3D device_create_file(&tpacpi_pdev->dev, &dev_attr_cmos_command);
-	if (res)
-		return res;
+		    str_supported(cmos_handle !=3D NULL));

-	return (cmos_handle) ? 0 : 1;
-}
-
-static void cmos_exit(void)
-{
-	device_remove_file(&tpacpi_pdev->dev, &dev_attr_cmos_command);
+	return cmos_handle ? 0 : 1;
 }

 static int cmos_read(struct seq_file *m)
@@ -5699,7 +5619,6 @@ static struct ibm_struct cmos_driver_data =3D {
 	.name =3D "cmos",
 	.read =3D cmos_read,
 	.write =3D cmos_write,
-	.exit =3D cmos_exit,
 };

 /************************************************************************=
*
@@ -6210,7 +6129,6 @@ struct ibm_thermal_sensors_struct {
 };

 static enum thermal_access_mode thermal_read_mode;
-static const struct attribute_group *thermal_attr_group;
 static bool thermal_use_labels;

 /* idx is zero-based */
@@ -6383,12 +6301,26 @@ static struct attribute *thermal_temp_input_attr[]=
 =3D {
 	NULL
 };

-static const struct attribute_group thermal_temp_input16_group =3D {
-	.attrs =3D thermal_temp_input_attr
-};
+static umode_t thermal_attr_is_visible(struct kobject *kobj,
+				       struct attribute *attr, int n)
+{
+	if (thermal_read_mode =3D=3D TPACPI_THERMAL_NONE)
+		return 0;
+
+	if (attr =3D=3D THERMAL_ATTRS(8) || attr =3D=3D THERMAL_ATTRS(9) ||
+	    attr =3D=3D THERMAL_ATTRS(10) || attr =3D=3D THERMAL_ATTRS(11) ||
+	    attr =3D=3D THERMAL_ATTRS(12) || attr =3D=3D THERMAL_ATTRS(13) ||
+	    attr =3D=3D THERMAL_ATTRS(14) || attr =3D=3D THERMAL_ATTRS(15)) {
+		if (thermal_read_mode !=3D TPACPI_THERMAL_TPEC_16)
+			return 0;
+	}

-static const struct attribute_group thermal_temp_input8_group =3D {
-	.attrs =3D &thermal_temp_input_attr[8]
+	return attr->mode;
+}
+
+static const struct attribute_group thermal_attr_group =3D {
+	.is_visible =3D thermal_attr_is_visible,
+	.attrs =3D thermal_temp_input_attr,
 };

 #undef THERMAL_SENSOR_ATTR_TEMP
@@ -6412,7 +6344,14 @@ static struct attribute *temp_label_attributes[] =
=3D {
 	NULL
 };

+static umode_t temp_label_attr_is_visible(struct kobject *kobj,
+					  struct attribute *attr, int n)
+{
+	return thermal_use_labels ? attr->mode : 0;
+}
+
 static const struct attribute_group temp_label_attr_group =3D {
+	.is_visible =3D temp_label_attr_is_visible,
 	.attrs =3D temp_label_attributes,
 };

@@ -6423,7 +6362,6 @@ static int __init thermal_init(struct ibm_init_struc=
t *iibm)
 	u8 t, ta1, ta2, ver =3D 0;
 	int i;
 	int acpi_tmp7;
-	int res;

 	vdbg_printk(TPACPI_DBG_INIT, "initializing thermal subdriver\n");

@@ -6498,42 +6436,7 @@ static int __init thermal_init(struct ibm_init_stru=
ct *iibm)
 		str_supported(thermal_read_mode !=3D TPACPI_THERMAL_NONE),
 		thermal_read_mode);

-	switch (thermal_read_mode) {
-	case TPACPI_THERMAL_TPEC_16:
-		thermal_attr_group =3D &thermal_temp_input16_group;
-		break;
-	case TPACPI_THERMAL_TPEC_8:
-	case TPACPI_THERMAL_ACPI_TMP07:
-	case TPACPI_THERMAL_ACPI_UPDT:
-		thermal_attr_group =3D &thermal_temp_input8_group;
-		break;
-	case TPACPI_THERMAL_NONE:
-	default:
-		return 1;
-	}
-
-	res =3D sysfs_create_group(&tpacpi_hwmon->kobj, thermal_attr_group);
-	if (res)
-		return res;
-
-	if (thermal_use_labels) {
-		res =3D sysfs_create_group(&tpacpi_hwmon->kobj, &temp_label_attr_group)=
;
-		if (res) {
-			sysfs_remove_group(&tpacpi_hwmon->kobj, thermal_attr_group);
-			return res;
-		}
-	}
-
-	return 0;
-}
-
-static void thermal_exit(void)
-{
-	if (thermal_attr_group)
-		sysfs_remove_group(&tpacpi_hwmon->kobj, thermal_attr_group);
-
-	if (thermal_use_labels)
-		sysfs_remove_group(&tpacpi_hwmon->kobj, &temp_label_attr_group);
+	return thermal_read_mode =3D=3D TPACPI_THERMAL_NONE ? 1 : 0;
 }

 static int thermal_read(struct seq_file *m)
@@ -6560,7 +6463,6 @@ static int thermal_read(struct seq_file *m)
 static struct ibm_struct thermal_driver_data =3D {
 	.name =3D "thermal",
 	.read =3D thermal_read,
-	.exit =3D thermal_exit,
 };

 /************************************************************************=
*
@@ -8735,14 +8637,34 @@ static ssize_t fan_watchdog_store(struct device_dr=
iver *drv, const char *buf,
 static DRIVER_ATTR_RW(fan_watchdog);

 /* --------------------------------------------------------------------- =
*/
+
 static struct attribute *fan_attributes[] =3D {
-	&dev_attr_pwm1_enable.attr, &dev_attr_pwm1.attr,
+	&dev_attr_pwm1_enable.attr,
+	&dev_attr_pwm1.attr,
 	&dev_attr_fan1_input.attr,
-	NULL, /* for fan2_input */
+	&dev_attr_fan2_input.attr,
+	&driver_attr_fan_watchdog.attr,
 	NULL
 };

+static umode_t fan_attr_is_visible(struct kobject *kobj, struct attribute=
 *attr,
+				   int n)
+{
+	if (fan_status_access_mode !=3D TPACPI_FAN_NONE ||
+	    fan_control_access_mode !=3D TPACPI_FAN_WR_NONE) {
+		if (attr =3D=3D &dev_attr_fan2_input.attr) {
+			if (!tp_features.second_fan)
+				return 0;
+		}
+
+		return attr->mode;
+	}
+
+	return 0;
+}
+
 static const struct attribute_group fan_attr_group =3D {
+	.is_visible =3D fan_attr_is_visible,
 	.attrs =3D fan_attributes,
 };

@@ -8772,7 +8694,6 @@ static const struct tpacpi_quirk fan_quirk_table[] _=
_initconst =3D {

 static int __init fan_init(struct ibm_init_struct *iibm)
 {
-	int rc;
 	unsigned long quirks;

 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_FAN,
@@ -8869,27 +8790,10 @@ static int __init fan_init(struct ibm_init_struct =
*iibm)
 		fan_get_status_safe(NULL);

 	if (fan_status_access_mode !=3D TPACPI_FAN_NONE ||
-	    fan_control_access_mode !=3D TPACPI_FAN_WR_NONE) {
-		if (tp_features.second_fan) {
-			/* attach second fan tachometer */
-			fan_attributes[ARRAY_SIZE(fan_attributes)-2] =3D
-					&dev_attr_fan2_input.attr;
-		}
-		rc =3D sysfs_create_group(&tpacpi_hwmon->kobj,
-					 &fan_attr_group);
-		if (rc < 0)
-			return rc;
-
-		rc =3D driver_create_file(&tpacpi_hwmon_pdriver.driver,
-					&driver_attr_fan_watchdog);
-		if (rc < 0) {
-			sysfs_remove_group(&tpacpi_hwmon->kobj,
-					&fan_attr_group);
-			return rc;
-		}
+	    fan_control_access_mode !=3D TPACPI_FAN_WR_NONE)
 		return 0;
-	} else
-		return 1;
+
+	return 1;
 }

 static void fan_exit(void)
@@ -8897,11 +8801,6 @@ static void fan_exit(void)
 	vdbg_printk(TPACPI_DBG_EXIT | TPACPI_DBG_FAN,
 		    "cancelling any pending fan watchdog tasks\n");

-	/* FIXME: can we really do this unconditionally? */
-	sysfs_remove_group(&tpacpi_hwmon->kobj, &fan_attr_group);
-	driver_remove_file(&tpacpi_hwmon_pdriver.driver,
-			   &driver_attr_fan_watchdog);
-
 	cancel_delayed_work(&fan_watchdog_task);
 	flush_workqueue(tpacpi_wq);
 }
@@ -9963,6 +9862,35 @@ static ssize_t palmsensor_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(palmsensor);

+static struct attribute *proxsensor_attributes[] =3D {
+	&dev_attr_dytc_lapmode.attr,
+	&dev_attr_palmsensor.attr,
+	NULL
+};
+
+static umode_t proxsensor_attr_is_visible(struct kobject *kobj,
+					  struct attribute *attr, int n)
+{
+	if (attr =3D=3D &dev_attr_dytc_lapmode.attr) {
+		/*
+		 * Platforms before DYTC version 5 claim to have a lap sensor,
+		 * but it doesn't work, so we ignore them.
+		 */
+		if (!has_lapsensor ||  dytc_version < 5)
+			return 0;
+	} else if (attr =3D=3D &dev_attr_palmsensor.attr) {
+		if (!has_palmsensor)
+			return 0;
+	}
+
+	return attr->mode;
+}
+
+static const struct attribute_group proxsensor_attr_group =3D {
+	.is_visible =3D proxsensor_attr_is_visible,
+	.attrs =3D proxsensor_attributes,
+};
+
 static int tpacpi_proxsensor_init(struct ibm_init_struct *iibm)
 {
 	int palm_err, lap_err, err;
@@ -9981,43 +9909,16 @@ static int tpacpi_proxsensor_init(struct ibm_init_=
struct *iibm)
 	if (lap_err && (lap_err !=3D -ENODEV))
 		return lap_err;

-	if (has_palmsensor) {
-		err =3D sysfs_create_file(&tpacpi_pdev->dev.kobj, &dev_attr_palmsensor.=
attr);
-		if (err)
-			return err;
-	}
-
 	/* Check if we know the DYTC version, if we don't then get it */
 	if (!dytc_version) {
 		err =3D dytc_get_version();
 		if (err)
 			return err;
 	}
-	/*
-	 * Platforms before DYTC version 5 claim to have a lap sensor, but it do=
esn't work, so we
-	 * ignore them
-	 */
-	if (has_lapsensor && (dytc_version >=3D 5)) {
-		err =3D sysfs_create_file(&tpacpi_pdev->dev.kobj, &dev_attr_dytc_lapmod=
e.attr);
-		if (err)
-			return err;
-	}
-	return 0;
-}

-static void proxsensor_exit(void)
-{
-	if (has_lapsensor)
-		sysfs_remove_file(&tpacpi_pdev->dev.kobj, &dev_attr_dytc_lapmode.attr);
-	if (has_palmsensor)
-		sysfs_remove_file(&tpacpi_pdev->dev.kobj, &dev_attr_palmsensor.attr);
+	return 0;
 }

-static struct ibm_struct proxsensor_driver_data =3D {
-	.name =3D "proximity-sensor",
-	.exit =3D proxsensor_exit,
-};
-
 /************************************************************************=
*
  * DYTC Platform Profile interface
  */
@@ -10432,37 +10333,18 @@ static struct attribute *kbdlang_attributes[] =
=3D {
 	NULL
 };

-static const struct attribute_group kbdlang_attr_group =3D {
-	.attrs =3D kbdlang_attributes,
-};
-
-static int tpacpi_kbdlang_init(struct ibm_init_struct *iibm)
+static umode_t kbdlang_attr_is_visible(struct kobject *kobj,
+				       struct attribute *attr, int n)
 {
 	int err, output;

 	err =3D get_keyboard_lang(&output);
-	/*
-	 * If support isn't available (ENODEV) then don't return an error
-	 * just don't create the sysfs group.
-	 */
-	if (err =3D=3D -ENODEV)
-		return 0;
-
-	if (err)
-		return err;
-
-	/* Platform supports this feature - create the sysfs file */
-	return sysfs_create_group(&tpacpi_pdev->dev.kobj, &kbdlang_attr_group);
+	return err ? 0 : attr->mode;
 }

-static void kbdlang_exit(void)
-{
-	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &kbdlang_attr_group);
-}
-
-static struct ibm_struct kbdlang_driver_data =3D {
-	.name =3D "kbdlang",
-	.exit =3D kbdlang_exit,
+static const struct attribute_group kbdlang_attr_group =3D {
+	.is_visible =3D kbdlang_attr_is_visible,
+	.attrs =3D kbdlang_attributes,
 };

 /************************************************************************=
*
@@ -10533,41 +10415,127 @@ static ssize_t wwan_antenna_type_show(struct de=
vice *dev,
 }
 static DEVICE_ATTR_RO(wwan_antenna_type);

+static struct attribute *dprc_attributes[] =3D {
+	&dev_attr_wwan_antenna_type.attr,
+	NULL
+};
+
+static umode_t dprc_attr_is_visible(struct kobject *kobj,
+				    struct attribute *attr, int n)
+{
+	return has_antennatype ? attr->mode : 0;
+}
+
+static const struct attribute_group dprc_attr_group =3D {
+	.is_visible =3D dprc_attr_is_visible,
+	.attrs =3D dprc_attributes,
+};
+
 static int tpacpi_dprc_init(struct ibm_init_struct *iibm)
 {
-	int wwanantenna_err, err;
+	int err =3D get_wwan_antenna(&wwan_antennatype);

-	wwanantenna_err =3D get_wwan_antenna(&wwan_antennatype);
 	/*
 	 * If support isn't available (ENODEV) then quit, but don't
 	 * return an error.
 	 */
-	if (wwanantenna_err =3D=3D -ENODEV)
+	if (err =3D=3D -ENODEV)
 		return 0;

-	/* if there was an error return it */
-	if (wwanantenna_err && (wwanantenna_err !=3D -ENODEV))
-		return wwanantenna_err;
-	else if (!wwanantenna_err)
-		has_antennatype =3D true;
+	/* If there was an error return it */
+	if (err)
+		return err;

-	if (has_antennatype) {
-		err =3D sysfs_create_file(&tpacpi_pdev->dev.kobj, &dev_attr_wwan_antenn=
a_type.attr);
-		if (err)
-			return err;
-	}
+	has_antennatype =3D true;
 	return 0;
 }

-static void dprc_exit(void)
+/* --------------------------------------------------------------------- =
*/
+
+static struct attribute *tpacpi_attributes[] =3D {
+	&driver_attr_debug_level.attr,
+	&driver_attr_version.attr,
+	&driver_attr_interface_version.attr,
+#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
+	&driver_attr_wlsw_emulstate.attr,
+	&driver_attr_bluetooth_emulstate.attr,
+	&driver_attr_wwan_emulstate.attr,
+	&driver_attr_uwb_emulstate.attr,
+#endif
+	NULL
+};
+
+#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
+static umode_t tpacpi_attr_is_visible(struct kobject *kobj,
+				      struct attribute *attr, int n)
 {
-	if (has_antennatype)
-		sysfs_remove_file(&tpacpi_pdev->dev.kobj, &dev_attr_wwan_antenna_type.a=
ttr);
+	if (attr =3D=3D &driver_attr_wlsw_emulstate.attr) {
+		if (!dbg_wlswemul)
+			return 0;
+	} else if (attr =3D=3D &driver_attr_bluetooth_emulstate.attr) {
+		if (!dbg_bluetoothemul)
+			return 0;
+	} else if (attr =3D=3D &driver_attr_wwan_emulstate.attr) {
+		if (!dbg_wwanemul)
+			return 0;
+	} else if (attr =3D=3D &driver_attr_uwb_emulstate.attr) {
+		if (!dbg_uwbemul)
+			return 0;
+	}
+
+	return attr->mode;
 }
+#endif

-static struct ibm_struct dprc_driver_data =3D {
-	.name =3D "dprc",
-	.exit =3D dprc_exit,
+static const struct attribute_group tpacpi_attr_group =3D {
+#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
+	.is_visible =3D tpacpi_attr_is_visible,
+#endif
+	.attrs =3D tpacpi_attributes,
+};
+
+static const struct attribute_group *tpacpi_groups[] =3D {
+	&adaptive_kbd_attr_group,
+	&hotkey_attr_group,
+	&bluetooth_attr_group,
+	&wan_attr_group,
+	&proxsensor_attr_group,
+	&kbdlang_attr_group,
+	&dprc_attr_group,
+	&tpacpi_attr_group,
+	NULL,
+};
+
+static const struct attribute_group *tpacpi_hwmon_groups[] =3D {
+	&thermal_attr_group,
+	&temp_label_attr_group,
+	&fan_attr_group,
+	&tpacpi_attr_group,
+	NULL,
+};
+
+/************************************************************************=
****
+ ************************************************************************=
****
+ *
+ * Platform drivers
+ *
+ ************************************************************************=
****
+ ************************************************************************=
****/
+
+static struct platform_driver tpacpi_pdriver =3D {
+	.driver =3D {
+		.name =3D TPACPI_DRVR_NAME,
+		.pm =3D &tpacpi_pm,
+		.dev_groups =3D tpacpi_groups,
+	},
+	.shutdown =3D tpacpi_shutdown_handler,
+};
+
+static struct platform_driver tpacpi_hwmon_pdriver =3D {
+	.driver =3D {
+		.name =3D TPACPI_HWMON_DRVR_NAME,
+		.dev_groups =3D tpacpi_hwmon_groups,
+	},
 };

 /************************************************************************=
****
@@ -11064,19 +11032,13 @@ static struct ibm_init_struct ibms_init[] __init=
data =3D {
 	},
 	{
 		.init =3D tpacpi_proxsensor_init,
-		.data =3D &proxsensor_driver_data,
 	},
 	{
 		.init =3D tpacpi_dytc_profile_init,
 		.data =3D &dytc_profile_driver_data,
 	},
-	{
-		.init =3D tpacpi_kbdlang_init,
-		.data =3D &kbdlang_driver_data,
-	},
 	{
 		.init =3D tpacpi_dprc_init,
-		.data =3D &dprc_driver_data,
 	},
 };

@@ -11090,8 +11052,6 @@ static int __init set_ibm_param(const char *val, c=
onst struct kernel_param *kp)

 	for (i =3D 0; i < ARRAY_SIZE(ibms_init); i++) {
 		ibm =3D ibms_init[i].data;
-		WARN_ON(ibm =3D=3D NULL);
-
 		if (!ibm || !ibm->name)
 			continue;

@@ -11221,26 +11181,16 @@ static void thinkpad_acpi_module_exit(void)

 	if (tpacpi_hwmon)
 		hwmon_device_unregister(tpacpi_hwmon);
-
 	if (tpacpi_sensors_pdev)
 		platform_device_unregister(tpacpi_sensors_pdev);
 	if (tpacpi_pdev)
 		platform_device_unregister(tpacpi_pdev);
-
-	if (tp_features.sensors_pdrv_attrs_registered)
-		tpacpi_remove_driver_attributes(&tpacpi_hwmon_pdriver.driver);
-	if (tp_features.platform_drv_attrs_registered)
-		tpacpi_remove_driver_attributes(&tpacpi_pdriver.driver);
-
 	if (tp_features.sensors_pdrv_registered)
 		platform_driver_unregister(&tpacpi_hwmon_pdriver);
-
 	if (tp_features.platform_drv_registered)
 		platform_driver_unregister(&tpacpi_pdriver);
-
 	if (proc_dir)
 		remove_proc_entry(TPACPI_PROC_DIR, acpi_root_dir);
-
 	if (tpacpi_wq)
 		destroy_workqueue(tpacpi_wq);

@@ -11308,20 +11258,6 @@ static int __init thinkpad_acpi_module_init(void)
 	}
 	tp_features.sensors_pdrv_registered =3D 1;

-	ret =3D tpacpi_create_driver_attributes(&tpacpi_pdriver.driver);
-	if (!ret) {
-		tp_features.platform_drv_attrs_registered =3D 1;
-		ret =3D tpacpi_create_driver_attributes(
-					&tpacpi_hwmon_pdriver.driver);
-	}
-	if (ret) {
-		pr_err("unable to create sysfs driver attributes\n");
-		thinkpad_acpi_module_exit();
-		return ret;
-	}
-	tp_features.sensors_pdrv_attrs_registered =3D 1;
-
-
 	/* Device initialization */
 	tpacpi_pdev =3D platform_device_register_simple(TPACPI_DRVR_NAME, -1,
 							NULL, 0);
=2D-
2.25.1

