Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCAC43840D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 17:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhJWPnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 11:43:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:39347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229901AbhJWPnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 11:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635003662;
        bh=K6fSFt2EXI00Nl9PwzbF1YzhreJBXYwv8mjgQrGj4a4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=DHEOogXUlTcFkOftcJ43t9QTE0zhxL/48n2wgF/kCefBYfz8kf1TiZVirG9ebd9RC
         fFfE0p9h707iskiXdwJE/3goOQpUt7/i9FlCB11CHK3apyqFXdTOUpYWjW9RksqowJ
         Wo9lNXRFKwlrruHOXUks+YIxRRwPcThfV7JVkEc0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1M8ygY-1mZNCC174A-0064kk; Sat, 23 Oct 2021 17:41:02 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2][next] platform/x86: thinkpad_acpi: Convert platform driver to use dev_groups
Date:   Sat, 23 Oct 2021 17:40:36 +0200
Message-Id: <20211023154036.6800-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xFDYE3VgbpcPwXR7bM0CRqRTVYdsAS02I96Ek9s7Za2+4YfYwzZ
 EOerDwoFX9bgR8OHH1ShyA2HKXyEDhTN+mZO+A8bajQwiIv9JMzXnPUwuPugRO0QT3AAVDi
 aQ3u10eufqMve7kmI4lJ7IYPzDLw6Q25oCSPLcG8E3hoPj+mwySVEDX6xN0/cTSNxJheBq9
 F3/7+k4HhKyvqhzmR1qhg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QTjWt0Mo5Kw=:iLlFi/fyvxyZC/jjBiPjUx
 FYPnZXe5HH/eCcjAYJ0yK0FQqz8CIoay8OI8Nf00AMuI8pjCCnLraMZnnrrEqobrRfHM4LhB8
 zj8QRfl48fKTvDqSFcqvNi1IgqTE2GkyrxYXpAkhG0tXa/anQdV/qXj1GaVasAjypS1hn+1hu
 2o8719UAJ0DE2iJOZj6Vi0wah27bFfroN1FLX8q88p1+KXng7eDPpPT2uv9I8lX7t801RjEcj
 bqkARRrrqZPG485cm0ijtk/tXrMjxKLqoABCv+SIxFVRpo8zYTksGm8OLl8VH0922WOnN7nft
 u0qXY6aEX5jFflAHXmOmW88rEfAky7TGRZor/GJEsg6zhfjMV5qsFRfV1UjdXLZdFGMHV+mdt
 PFUKrb3sqk7PyJmDuuZSILef/gEIK8qmgrC4lT9LzOycI5rK48+LZYD/41bjBG9vF6ggv/bo8
 gsSX7XTfViLxoRWVbeayabwFsicozqsqakH46/JfqBw+YiGbo+5umDtmTdjoEjgG9hBCVdHAM
 pVy+yGz7s+l9Y8NueHRsPB8Hn01Qi/SNP4w/3ZVXcKyevIgw2QP1W9pmxFqKNqbgrnCNgLGqD
 gc33tCKuF45pXWtVsgBBuc0jHRJZcuqw3tHQZe61/tBfrIB5hE3RtH5nup35vOryN/nW5rwfH
 FgEp/0lF7DU/A3OvUC6XubgOryItszVADcOyQDkatXq1yJs2UZNYAVJ7LwFJREpbqR18yf1G6
 p1LNWI8qpearBfnA0Kr6xJf27dU9eDL9NfO7KFu04ZK8yG2xFxign6Mo6B0LN4PTNoN+0fMyh
 qla1EIpSvODGvmD8iya2WgJSZbHu3vq0+cQeflzKJFocDkOksk3P2qxiOfhGEORFNlAsV1Bmb
 Hyf5M25dqwSDQibuGiEhj5i/bZL1IOPdkhSOFBzF30S26ELz1eqvuhiYYthZmpIKdDukL2dhi
 aq332PBSBJZ8l+PFB4ctGHCA2oBAVKd01Fv3jMNORK3mQvxWOuR/Y0HxCp/NicFGGvcNd+zRK
 Slmpp1GCSmcbVYTV3yUlLeIlR/scK/0oad9AVh8y7KrkTbYqyArNTt8eY5tp11cJP+E2PxPcX
 UNkwNUpOsAdVAM=
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
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
Changelog v1 -> v2
- Add the "Acked-by" tag.
- Refactor the "fan_attr_is_visible" function to use the same code
  pattern used in all the "*_is_visible" functions (Hans de Goede).
- Keep the proxsensor_driver_data struct and the dprc_driver_data
  struct (Hans de Goede).
- Keep "kbdlang_init" function and set a new flag inside it. Then,
  use this flag inside the "kbdlang_attr_is_visible" function (Hans
  de Goede).

The previous version can be found here [1]

[1] https://lore.kernel.org/platform-driver-x86/20211003091949.7339-1-len.=
baker@gmx.com/

 drivers/platform/x86/thinkpad_acpi.c | 526 +++++++++++++--------------
 1 file changed, 243 insertions(+), 283 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/t=
hinkpad_acpi.c
index b39dbc2fe45b..87dc7c802219 100644
=2D-- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -334,12 +334,11 @@ static struct {
 	u32 battery_force_primary:1;
 	u32 input_device_registered:1;
 	u32 platform_drv_registered:1;
-	u32 platform_drv_attrs_registered:1;
 	u32 sensors_pdrv_registered:1;
-	u32 sensors_pdrv_attrs_registered:1;
 	u32 sensors_pdev_attrs_registered:1;
 	u32 hotkey_poll_active:1;
 	u32 has_adaptive_kbd:1;
+	u32 kbd_lang:1;
 } tp_features;

 static struct {
@@ -985,20 +984,6 @@ static void tpacpi_shutdown_handler(struct platform_d=
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
@@ -1490,53 +1475,6 @@ static ssize_t uwb_emulstate_store(struct device_dr=
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
@@ -3010,7 +2948,14 @@ static struct attribute *adaptive_kbd_attributes[] =
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

@@ -3108,8 +3053,6 @@ static void hotkey_exit(void)
 	hotkey_poll_stop_sync();
 	mutex_unlock(&hotkey_mutex);
 #endif
-	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &hotkey_attr_group);
-
 	dbg_printk(TPACPI_DBG_EXIT | TPACPI_DBG_HKEY,
 		   "restoring original HKEY status and mask\n");
 	/* yes, there is a bitwise or below, we want the
@@ -3504,14 +3447,8 @@ static int __init hotkey_init(struct ibm_init_struc=
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
@@ -3565,9 +3502,6 @@ static int __init hotkey_init(struct ibm_init_struct=
 *iibm)
 	}

 	tabletsw_state =3D hotkey_init_tablet_mode();
-	res =3D sysfs_create_group(&tpacpi_pdev->dev.kobj, &hotkey_attr_group);
-	if (res)
-		goto err_exit;

 	/* Set up key map */
 	keymap_id =3D tpacpi_check_quirks(tpacpi_keymap_qtable,
@@ -3664,9 +3598,6 @@ static int __init hotkey_init(struct ibm_init_struct=
 *iibm)
 	return 0;

 err_exit:
-	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &hotkey_attr_group);
-	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &adaptive_kbd_attr_group);
-
 	return (res < 0) ? res : 1;
 }

@@ -4412,7 +4343,14 @@ static struct attribute *bluetooth_attributes[] =3D=
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

@@ -4434,11 +4372,7 @@ static void bluetooth_shutdown(void)

 static void bluetooth_exit(void)
 {
-	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
-			&bluetooth_attr_group);
-
 	tpacpi_destroy_rfkill(TPACPI_RFK_BLUETOOTH_SW_ID);
-
 	bluetooth_shutdown();
 }

@@ -4552,17 +4486,7 @@ static int __init bluetooth_init(struct ibm_init_st=
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
@@ -4669,7 +4593,14 @@ static struct attribute *wan_attributes[] =3D {
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

@@ -4691,11 +4622,7 @@ static void wan_shutdown(void)

 static void wan_exit(void)
 {
-	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
-		&wan_attr_group);
-
 	tpacpi_destroy_rfkill(TPACPI_RFK_WWAN_SW_ID);
-
 	wan_shutdown();
 }

@@ -4739,18 +4666,7 @@ static int __init wan_init(struct ibm_init_struct *=
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
@@ -5651,30 +5567,35 @@ static ssize_t cmos_command_store(struct device *d=
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
+		    str_supported(cmos_handle !=3D NULL));

-	res =3D device_create_file(&tpacpi_pdev->dev, &dev_attr_cmos_command);
-	if (res)
-		return res;
-
-	return (cmos_handle) ? 0 : 1;
-}
-
-static void cmos_exit(void)
-{
-	device_remove_file(&tpacpi_pdev->dev, &dev_attr_cmos_command);
+	return cmos_handle ? 0 : 1;
 }

 static int cmos_read(struct seq_file *m)
@@ -5715,7 +5636,6 @@ static struct ibm_struct cmos_driver_data =3D {
 	.name =3D "cmos",
 	.read =3D cmos_read,
 	.write =3D cmos_write,
-	.exit =3D cmos_exit,
 };

 /************************************************************************=
*
@@ -6226,7 +6146,6 @@ struct ibm_thermal_sensors_struct {
 };

 static enum thermal_access_mode thermal_read_mode;
-static const struct attribute_group *thermal_attr_group;
 static bool thermal_use_labels;

 /* idx is zero-based */
@@ -6399,12 +6318,26 @@ static struct attribute *thermal_temp_input_attr[]=
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

-static const struct attribute_group thermal_temp_input8_group =3D {
-	.attrs =3D &thermal_temp_input_attr[8]
+	if (attr =3D=3D THERMAL_ATTRS(8) || attr =3D=3D THERMAL_ATTRS(9) ||
+	    attr =3D=3D THERMAL_ATTRS(10) || attr =3D=3D THERMAL_ATTRS(11) ||
+	    attr =3D=3D THERMAL_ATTRS(12) || attr =3D=3D THERMAL_ATTRS(13) ||
+	    attr =3D=3D THERMAL_ATTRS(14) || attr =3D=3D THERMAL_ATTRS(15)) {
+		if (thermal_read_mode !=3D TPACPI_THERMAL_TPEC_16)
+			return 0;
+	}
+
+	return attr->mode;
+}
+
+static const struct attribute_group thermal_attr_group =3D {
+	.is_visible =3D thermal_attr_is_visible,
+	.attrs =3D thermal_temp_input_attr,
 };

 #undef THERMAL_SENSOR_ATTR_TEMP
@@ -6428,7 +6361,14 @@ static struct attribute *temp_label_attributes[] =
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

@@ -6439,7 +6379,6 @@ static int __init thermal_init(struct ibm_init_struc=
t *iibm)
 	u8 t, ta1, ta2, ver =3D 0;
 	int i;
 	int acpi_tmp7;
-	int res;

 	vdbg_printk(TPACPI_DBG_INIT, "initializing thermal subdriver\n");

@@ -6514,42 +6453,7 @@ static int __init thermal_init(struct ibm_init_stru=
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
@@ -6576,7 +6480,6 @@ static int thermal_read(struct seq_file *m)
 static struct ibm_struct thermal_driver_data =3D {
 	.name =3D "thermal",
 	.read =3D thermal_read,
-	.exit =3D thermal_exit,
 };

 /************************************************************************=
*
@@ -8751,14 +8654,33 @@ static ssize_t fan_watchdog_store(struct device_dr=
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
+	if (fan_status_access_mode =3D=3D TPACPI_FAN_NONE &&
+	    fan_control_access_mode =3D=3D TPACPI_FAN_WR_NONE)
+		return 0;
+
+	if (attr =3D=3D &dev_attr_fan2_input.attr) {
+		if (!tp_features.second_fan)
+			return 0;
+	}
+
+	return attr->mode;
+}
+
 static const struct attribute_group fan_attr_group =3D {
+	.is_visible =3D fan_attr_is_visible,
 	.attrs =3D fan_attributes,
 };

@@ -8788,7 +8710,6 @@ static const struct tpacpi_quirk fan_quirk_table[] _=
_initconst =3D {

 static int __init fan_init(struct ibm_init_struct *iibm)
 {
-	int rc;
 	unsigned long quirks;

 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_FAN,
@@ -8885,27 +8806,10 @@ static int __init fan_init(struct ibm_init_struct =
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
@@ -8913,11 +8817,6 @@ static void fan_exit(void)
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
@@ -10002,6 +9901,35 @@ static ssize_t palmsensor_show(struct device *dev,
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
@@ -10020,41 +9948,18 @@ static int tpacpi_proxsensor_init(struct ibm_init=
_struct *iibm)
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

 static struct ibm_struct proxsensor_driver_data =3D {
 	.name =3D "proximity-sensor",
-	.exit =3D proxsensor_exit,
 };

 /************************************************************************=
*
@@ -10471,7 +10376,14 @@ static struct attribute *kbdlang_attributes[] =3D=
 {
 	NULL
 };

+static umode_t kbdlang_attr_is_visible(struct kobject *kobj,
+				       struct attribute *attr, int n)
+{
+	return tp_features.kbd_lang ? attr->mode : 0;
+}
+
 static const struct attribute_group kbdlang_attr_group =3D {
+	.is_visible =3D kbdlang_attr_is_visible,
 	.attrs =3D kbdlang_attributes,
 };

@@ -10480,28 +10392,12 @@ static int tpacpi_kbdlang_init(struct ibm_init_s=
truct *iibm)
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
-}
-
-static void kbdlang_exit(void)
-{
-	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &kbdlang_attr_group);
+	tp_features.kbd_lang =3D !err;
+	return err;
 }

 static struct ibm_struct kbdlang_driver_data =3D {
 	.name =3D "kbdlang",
-	.exit =3D kbdlang_exit,
 };

 /************************************************************************=
*
@@ -10572,41 +10468,131 @@ static ssize_t wwan_antenna_type_show(struct de=
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
+static struct ibm_struct dprc_driver_data =3D {
+	.name =3D "dprc",
+};
+
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
@@ -11143,8 +11129,6 @@ static int __init set_ibm_param(const char *val, c=
onst struct kernel_param *kp)

 	for (i =3D 0; i < ARRAY_SIZE(ibms_init); i++) {
 		ibm =3D ibms_init[i].data;
-		WARN_ON(ibm =3D=3D NULL);
-
 		if (!ibm || !ibm->name)
 			continue;

@@ -11274,26 +11258,16 @@ static void thinkpad_acpi_module_exit(void)

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

@@ -11361,20 +11335,6 @@ static int __init thinkpad_acpi_module_init(void)
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

