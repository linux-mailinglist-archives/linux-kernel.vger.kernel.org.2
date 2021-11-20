Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5347A457FBD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 18:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbhKTRGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 12:06:50 -0500
Received: from mout.gmx.net ([212.227.17.20]:38195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237819AbhKTRGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 12:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637427806;
        bh=EYfEMrk6FsNbDB0MKrrO2bE3ZkeSX7mCYY+70C6IG34=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MoyBFrWTCn/dQ2QKja696lykUMrVAg45ZucJ13oo9dR+CJxjMZJ/do6gsI6sVUkTk
         hWPAfX3fqkGKLPFLy1v7LgqOT28KR0j60MItIP2b4jFl48vLbOvgfjEqbbqCL+L/yT
         HpO1hb7RaIkIBajqLUOYmZfzM4cynYi0YDGWA/mo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MPXdC-1n2JOG0uQc-00Maoy; Sat, 20 Nov 2021 18:03:26 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (dell-smm) Unify i8k_ioctl() and i8k_ioctl_unlocked()
Date:   Sat, 20 Nov 2021 18:03:19 +0100
Message-Id: <20211120170319.72369-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211120170319.72369-1-W_Armin@gmx.de>
References: <20211120170319.72369-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mnGJiAayc4IJ+mvaKCDms9QUo27anElwf2injXu0aXQcwi/w1Ic
 JF6kCnkQb5AuFspLQ7+oWt6fBGY0C8QrLIKtUTtjJAeMbDjQEB3rFYfp7CZNP+dT1gqiOG1
 n/9Ri694x+UvUWseO8UJgKmzn9pG2x0waITtuarae20eByq8pJJ9qJhm7HpAEQx55DvQfyW
 95Jf6ICdoh7srSVvdsI6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IbJUxj9j7HM=:81MgOGrsvyms3s3JTWYz8U
 7/4yxeBXEbFkMnrLcZQpVpMc2/aDzEPNEbZ6o4xcKXn87Ui3YgyDMGPwEDvcnP3oPOc5Q9kk/
 KRu+jUjR9bwvWaoUFd7Nchn0+DasjuDpY1YuYIBY1x5CRYlvXPDCLvLaDIes6JULj6usW+zU3
 R5hZ5PjIF6pal36Z65PQGjnSlil3jZjTL9rrWzi2AoHOJNlmmWlXR0yooq3zxgbdYrLPJwfKo
 K3b4Sq0bOt9Qe+FplyoRKqo+o1fCV/JcFE5g5Db3zQIKz07vnKDkF3P5ZMDtrYaJhiMSYFdaC
 NHFWPsCxb4x7yEewG6Rjrup+dINpqkdtKTfClyA7LWKO/8bEzauCPxLywtPxYiku8u1igxNTg
 YiijNMKzxfCugqOmKT1WjDyVH1RlrP+FrVDpvZc6VzQUm2cAJpiqyjJoDUz3g3MpjrUUxa1Lg
 NxBOYpZJ6ZsDGyQCRD7zz0fg8TCIhCmzPapTbAsFy5fgKURjrNec7fbc1fAOiZlESctJDYJJ1
 Domj13XYDealU4njm1fsS8sBhvUPVSzRJ5Tc1RgelmW2bvP/m9AYKt/qlNmLuGkwxl+8zpTdQ
 7ozK35uY05pjmcGn37aSpoo0ds1Y8T/nNUzTFAamciys1cULzSLSTOcvosQ2CeiZMvOqefe0r
 UncC12sx+F76AbX7Jyl1xTbX551bkiq0YvLiT1vGGrZnv/8/H2tI9VfDFJKVNX1grOc1GPl7Y
 wTjX4JIjuY6wiTC4OlSC6SNZO11oSPZdaLjJXbOChZBzUzwU3cdRdZdUusNyXgSBnfZNwV3W3
 hH0Zyl8DsdJoxpcu2rvfgUYVbSVZ4OBpsuXEwoEvGqgt/8U+26HPGo/OxEI8FyHGhDJ+QdObT
 Y6/6JMFT59aoQkNZDKn6rmQuvTO3neDK714Ub50mH0gUTrqNcjqjvJu1Vz2XyynNryNL8BUQ0
 qs80dAHfNI2UoCGjCSLXwmv4JoWWyojcfr1QBNN0PbfkFz/IoRwO0lNIDt/UpJKcQgW4vczs3
 3kCD4Krn9nZxdWiBps4ckCRAdoEAYwOnPUaz1SQ7a206RFxbyOw0Qanf7DtyoiwNi6xn5jJjD
 1yoQqkAmB5/Bmg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only purpose of i8k_ioctl() is to call i8k_ioctl_unlocked()
with i8k_mutex held. Judging from the hwmon code, this mutex
only needs to be held when setting the fan speed/mode.
Unify both functions and reduce the locking of i8k_mutex
to I8K_SET_FAN.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index b5d1703faa62..e2d388f7360e 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -449,12 +449,12 @@ static int i8k_get_power_status(void)
  * Procfs interface
  */

-static int
-i8k_ioctl_unlocked(struct file *fp, struct dell_smm_data *data, unsigned =
int cmd, unsigned long arg)
+static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long ar=
g)
 {
-	int val =3D 0;
-	int speed, err;
+	struct dell_smm_data *data =3D PDE_DATA(file_inode(fp));
 	int __user *argp =3D (int __user *)arg;
+	int speed, err;
+	int val =3D 0;

 	if (!argp)
 		return -EINVAL;
@@ -516,11 +516,14 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_=
data *data, unsigned int cmd
 		if (copy_from_user(&speed, argp + 1, sizeof(int)))
 			return -EFAULT;

+		mutex_lock(&data->i8k_mutex);
 		err =3D i8k_set_fan(data, val, speed);
-		if (err < 0)
+		if (err < 0) {
+			mutex_unlock(&data->i8k_mutex);
 			return err;
-
+		}
 		val =3D i8k_get_fan_status(data, val);
+		mutex_unlock(&data->i8k_mutex);
 		break;

 	default:
@@ -536,18 +539,6 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_d=
ata *data, unsigned int cmd
 	return 0;
 }

-static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long ar=
g)
-{
-	struct dell_smm_data *data =3D PDE_DATA(file_inode(fp));
-	long ret;
-
-	mutex_lock(&data->i8k_mutex);
-	ret =3D i8k_ioctl_unlocked(fp, data, cmd, arg);
-	mutex_unlock(&data->i8k_mutex);
-
-	return ret;
-}
-
 /*
  * Print the information for /proc/i8k.
  */
=2D-
2.30.2

