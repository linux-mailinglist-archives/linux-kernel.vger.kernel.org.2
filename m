Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD4243B811
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbhJZRVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:21:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:57207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237595AbhJZRVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635268708;
        bh=qs8Q90SzXGTMkts0gGrD1mEBUmw1GFg0y9AOxweTFWA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=eDTlk7t/gRlRNdCTWQ4CwmtbpN3OyduFaqbqU3Jljn7BpzidyWN6S3+vSHlIXNlPC
         xyJUT7xL82dgGdqFt/1aD9oApYB9IeOMDKawSonLgsI6NjK+/F7Yn3lclSyiN+OkT8
         Pz4p465g4Eh+be58HocVHXAtCllfHsnXZbwfWqGg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MvsEx-1mz9pj0PI7-00swYd; Tue, 26 Oct 2021 19:18:28 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC] hwmon: (dell-smm) Allow for specifying fan control commands as module params
Date:   Tue, 26 Oct 2021 19:18:21 +0200
Message-Id: <20211026171821.25944-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LcFeyJLoEfIyKklp5oc8jsRMx/tyTt1uMy9Fs8Nc9Nom+mKpEly
 CNpa5QVztMzAuHMS/wuqB7KkCAH8vEpJb+W46Gd4JtHKCsH1lhj0Hg9MTV13pwkoTymkHoQ
 A3WwOy01/0BHmbRFL/3GmtvXRbrj+VGc4fDvIL1loW2DZuPcVRmudKzkWLXR6syNHsHha5F
 W5AkelWA3Y+dXjNWlfm1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YrO0hZMciPM=:emA/KVoDlGlKkSmfkzpyc1
 HQ2K35fC9Nrji6IjelQE2WuXwtaOdsXKtanRNoLdHSjtjkAbOw6a4atkjrj1dykob+jmvKJCF
 +mtbPIdER8L6PuAs6CCovNJWOQb9wvRxugLxfBLYUQk3uqkiSNpWmxhxnNKavmCa5yaf9A3uY
 O31O+OtTFH+9rKzaYj7qBAK40EnquKCMtOu0CcCBIoEdQQTIORd9I++gn/KH4tsI9hsf9SmWI
 fCqxX7jtPyfgYrqtK31oN6ZonsH4y6cxRa5/TJ+v4RR44gPwxfJa/0LYCtXBaWoJwymR6HpUv
 QBCeOB/E1F1/yo6RMgS06dxSEVbaUT7/Yt57V+7e5f1hF3JThFA9GnHEGGpbaY5OwiJBvUzZ6
 I9KHehoMc2EGXuXRVro/5m7+4gx9fVtF+zdUeczEPR9BsfC2JeaiAv5KWAImLSwQvfqd7Knny
 UgGT/chl59ZXQBz5/nmhsFIksnljCGVux+f4aFfNmp+KCXf2lcYinNk9p0EEVPhInIIrrwtmH
 f5B2xCUYYUIN+00ErfYRAfS+L0sYr+CZr7ttkQIzJT4S+R1eOX/79f213vr1Dw2o3uBUHy+ie
 bAIy+Lv9MZcrRiuVnaYGHr4cgjFds1M7MJh5DWB2MOWUz2E4mkNbY2w6SwknIhkKW9reyzQZv
 wf7ZaFzfss4dGvBB2JfksWK63QSP+Ys/nakUW7ZyZsmJFbTQtsissC4ZscoXSzEFL+QLsWbfz
 eHS4BBN0mBI8H4gwXXi2k3AYW8kiDOXEWHcADQzG3imVBwRWLTF370JWYls+XEPW1gmuY+CQe
 FmnEQD8N/NHEZAu3JX4UgyP2V97qvpuKC51kkAIzaNk1nXT5lLbc5MhRcHsfdZur1aQkuXuZO
 Nevuqir4eml5EzAgXjdMmclTVjxqAzyn6U/KQld43vS38XUuKQ5uY8xWm+m9MjUiwAi3YOVPV
 PsHa8cBXfMAV8Zy0dSVQvJbfQ4hbJyRhPOxyqMZNMYd+uA+VeRVxl/KKnMNmLPMl793M0tO8A
 Psx30fdqO3U1VzDEeeevaSnWDaC0poooA0rqIw3FU49Dre0GcOGXTWoSFuaIu+SDLeI/ILhZY
 cxGPXrIzgKUtLk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, the only way to test if setting manual/auto fan control works
is to edit and recompile the module, which might not be possible for
everyone. Allow for specifying the necessary SMM commands when loading
the module, but taint the kernel if so since those commands might
cause strange side effects. Also update kernel-parameters.txt
accordingly.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 .../admin-guide/kernel-parameters.txt         | 45 ++++++++++++++-----
 Documentation/hwmon/dell-smm-hwmon.rst        | 27 ++++++++---
 drivers/hwmon/dell-smm-hwmon.c                | 22 +++++++--
 3 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentati=
on/admin-guide/kernel-parameters.txt
index 91ba391f9b32..7025f5bf625f 100644
=2D-- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -940,6 +940,40 @@
 			dump out devices still on the deferred probe list after
 			retrying.

+	dell_smm_hwmon.ignore_dmi=3D
+			[HW] Continue probing hardware even if DMI data
+                        indicates that the driver is running on unsupport=
ed
+                        hardware.
+
+        dell_smm_hwmon.force=3D
+			[HW] Activate driver even if SMM BIOS signature does
+			not match list of supported models or certain
+			features are disabled.
+
+        dell_smm_hwmon.power_status=3D
+                        [HW] Report power status in /proc/i8k
+                        (disabled by default).
+
+        dell_smm_hwmon.restricted=3D
+			[HW] Allow controlling fans only if SYS_ADMIN
+                        capability is set.
+
+	dell_smm_hwmon.fan_mult=3D
+			[HW] Factor to multiply fan speed with.
+
+	dell_smm_hwmon.fan_max=3D
+			[HW] Maximum configurable fan speed.
+
+	dell_smm_hwmon.manual_fan=3D
+			[HW] SMM command to disable BIOS fan control, must be
+			set together with dell_smm_hwmon.auto_fan to work.
+			This can be dangerous, yet let us know if a certain
+			command combination worked.
+
+	dell_smm_hwmon.auto_fan=3D
+			[HW] SMM command to enable BIOS fan control, see
+			dell_smm_hwmon.manual_fan for further explaination.
+
 	dfltcc=3D		[HW,S390]
 			Format: { on | off | def_only | inf_only | always }
 			on:       s390 zlib hardware support for compression on
@@ -1693,17 +1727,6 @@

 	i810=3D		[HW,DRM]

-	i8k.ignore_dmi	[HW] Continue probing hardware even if DMI data
-			indicates that the driver is running on unsupported
-			hardware.
-	i8k.force	[HW] Activate i8k driver even if SMM BIOS signature
-			does not match list of supported models.
-	i8k.power_status
-			[HW] Report power status in /proc/i8k
-			(disabled by default)
-	i8k.restricted	[HW] Allow controlling fans only if SYS_ADMIN
-			capability is set.
-
 	i915.invert_brightness=3D
 			[DRM] Invert the sense of the variable that is used to
 			set the brightness of the panel backlight. Normally a
diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/=
dell-smm-hwmon.rst
index beec88491171..df12dce7b02e 100644
=2D-- a/Documentation/hwmon/dell-smm-hwmon.rst
+++ b/Documentation/hwmon/dell-smm-hwmon.rst
@@ -67,13 +67,13 @@ for your hardware. It is possible that codes that work=
 for other
 laptops actually work for yours as well, or that you have to discover
 new codes.

-Check the list ``i8k_whitelist_fan_control`` in file
-``drivers/hwmon/dell-smm-hwmon.c`` in the kernel tree: as a first
-attempt you can try to add your machine and use an already-known code
-pair. If, after recompiling the kernel, you see that ``pwm1_enable``
-is present and works (i.e., you can manually control the fan speed),
-then please submit your finding as a kernel patch, so that other users
-can benefit from it. Please see
+Check the list ``i8k_fan_control_data`` in file
+``drivers/hwmon/dell-smm-hwmon.c`` inside the kernel tree:
+as a first attempt you can load the module with ``manual_fan`` and
+``auto_fan`` set to an already-known code pair. If you see that
+``pwm1_enable`` is present and works (i.e., you can manually control
+the fan speed), then please submit your finding as a kernel patch,
+so that other users can benefit from it. Please see
 :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
 for information on submitting patches.

@@ -120,6 +120,19 @@ Module parameters
                    Maximum configurable fan speed. (default:
                    autodetect)

+* manual_fan:uint
+                   SMM code to disable BIOS fan control, must
+                   be set together with auto_fan to work.
+                   Please note that this parameter is unsafe and
+                   will taint your kernel when set, use only for
+                   testing codes on your hardware!
+                   (default: retrieved from whitelist)
+
+* auto_fan:uint
+                   SMM command to enable BIOS fan control, see
+                   manual_fan for further explaination.
+                   (default: retrieved from whitelist)
+
 Legacy ``/proc`` interface
 --------------------------

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index eaace478f508..4257aa297d7a 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -111,6 +111,14 @@ static uint fan_max;
 module_param(fan_max, uint, 0);
 MODULE_PARM_DESC(fan_max, "Maximum configurable fan speed (default: autod=
etect)");

+static uint manual_fan;
+module_param_unsafe(manual_fan, uint, 0);
+MODULE_PARM_DESC(manual_fan, "SMM command to disable BIOS fan control (de=
fault: disabled)");
+
+static uint auto_fan;
+module_param_unsafe(auto_fan, uint, 0);
+MODULE_PARM_DESC(auto_fan, "SMM command to enable BIOS fan control (defau=
lt: disabled)");
+
 struct smm_regs {
 	unsigned int eax;
 	unsigned int ebx __packed;
@@ -700,7 +708,7 @@ static umode_t dell_smm_is_visible(const void *drvdata=
, enum hwmon_sensor_types

 			break;
 		case hwmon_pwm_enable:
-			if (data->auto_fan)
+			if (data->auto_fan && data->manual_fan)
 				/*
 				 * There is no command for retrieve the current status
 				 * from BIOS, and userspace/firmware itself can change
@@ -1305,12 +1313,20 @@ static int __init dell_smm_probe(struct platform_d=
evice *pdev)
 	data->i8k_fan_max =3D fan_max ? : I8K_FAN_HIGH;	/* Must not be 0 */
 	data->i8k_pwm_mult =3D DIV_ROUND_UP(255, data->i8k_fan_max);

+	/* Values specified in module parameters override values from dmi */
 	fan_control =3D dmi_first_match(i8k_whitelist_fan_control);
 	if (fan_control && fan_control->driver_data) {
 		const struct i8k_fan_control_data *control =3D fan_control->driver_data=
;

-		data->manual_fan =3D control->manual_fan;
-		data->auto_fan =3D control->auto_fan;
+		if (!manual_fan)
+			manual_fan =3D control->manual_fan;
+
+		if (!auto_fan)
+			auto_fan =3D control->auto_fan;
+	}
+	if (manual_fan && auto_fan) {
+		data->manual_fan =3D manual_fan;
+		data->auto_fan =3D auto_fan;
 		dev_info(&pdev->dev, "enabling support for setting automatic/manual fan=
 control\n");
 	}

=2D-
2.30.2

