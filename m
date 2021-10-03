Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70BC420199
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 14:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhJCMtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 08:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhJCMsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 08:48:54 -0400
X-Greylist: delayed 3407 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 03 Oct 2021 05:47:06 PDT
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3781C0613EC;
        Sun,  3 Oct 2021 05:47:06 -0700 (PDT)
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 76801C1D1F1;
        Sun,  3 Oct 2021 14:47:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1633265224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fygd70jXSRg1mCbjFPT93DvbycgIrRZivvAhVKZf8eg=;
        b=WzuWpS3OzLk8lyDa9fMWufzl6Afmw29HrYP1Kh96bD7p0yvYASbNbrieLtrzugmVqe9Yyd
        2TT6N04LNp/uNPpUS8/BJAMjQBARW7CJMo46Z9U2QKZkS7jLLQr1UdEK414rvwBHzrESoP
        fe5KuJ6MzoYTzRDhTrB9SF/y2yJfd7w=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com, Eugene Shalygin <eugene.shalygin@gmail.com>,
        matt-testalltheway <sefoci9222@rerunway.com>,
        Kamil Dudka <kdudka@redhat.com>,
        Robert Swiecki <robert@swiecki.net>,
        Kamil Pietrzak <kpietrzak@disroot.org>, Igor <igor@svelig.com>,
        Tor Vic <torvic9@mailbox.org>, Poezevara <nephartyz@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 0/3] Update ASUS WMI supported boards.
Date:   Sun, 03 Oct 2021 14:47:03 +0200
Message-ID: <3507481.XNmkIPAYGC@natalenko.name>
In-Reply-To: <6096864.rdmfHhMOLH@natalenko.name>
References: <20211002210857.709956-1-pauk.denis@gmail.com> <6096864.rdmfHhMOLH@natalenko.name>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On ned=C4=9Ble 3. =C5=99=C3=ADjna 2021 13:50:12 CEST Oleksandr Natalenko wr=
ote:
> On sobota 2. =C5=99=C3=ADjna 2021 23:08:53 CEST Denis Pauk wrote:
> > Add support to nct6775:
> > * PRIME B360-PLUS
> > * PRIME X570-PRO
> > * ROG CROSSHAIR VIII FORMULA
> > * ROG STRIX B550-I GAMING
> > * ROG STRIX X570-F GAMING
> > * ROG STRIX Z390-E GAMING
> > * TUF GAMING B550-PRO
> > * TUF GAMING Z490-PLUS
> > * TUF GAMING Z490-PLUS (WI-FI)
>=20
> Thank you for this submission.
>=20
> Do you happen to know whether it can be extended with another ASUS board
> which is:
>=20
> ```
> Manufacturer: ASUSTeK COMPUTER INC.
> Product Name: Pro WS X570-ACE
> ```
>=20
> ?
>=20
> I've got one, and in case any info or testing is needed, I'd be happy to
> contribute.
>=20
> Currently, this board is kinda working after adding
> `acpi_enforce_resources=3Dlax`, but I assume a proper support is needed
> instead.

Partially answering to myself, but still need some clarification.

I did this on top of your recent submissions:

```
diff --git a/drivers/hwmon/asus_wmi_sensors.c b/drivers/hwmon/
asus_wmi_sensors.c
index 6b04fad18891..f6817ec9de29 100644
=2D-- a/drivers/hwmon/asus_wmi_sensors.c
+++ b/drivers/hwmon/asus_wmi_sensors.c
@@ -35,6 +35,7 @@
 #define ASUS_EC_KNOWN_EC_REGISTERS 14
=20
 enum asus_wmi_ec_board {
+	BOARD_PW_X570_A, // Pro WS X570-ACE
 	BOARD_R_C8H, // ROG Crosshair VIII Hero
 	BOARD_R_C8DH, // ROG Crosshair VIII Dark Hero
 	BOARD_R_C8F, // ROG Crosshair VIII Formula
@@ -44,6 +45,7 @@ enum asus_wmi_ec_board {
=20
 /* boards with EC support */
 static const char *const asus_wmi_ec_boards_names[] =3D {
+	[BOARD_PW_X570_A] =3D "Pro WS X570-ACE",
 	[BOARD_R_C8H] =3D "ROG CROSSHAIR VIII HERO",
 	[BOARD_R_C8DH] =3D "ROG CROSSHAIR VIII DARK HERO",
 	[BOARD_R_C8F] =3D "ROG CROSSHAIR VIII FORMULA",
@@ -130,6 +132,7 @@ static void asus_wmi_ec_fill_board_sensors(struct=20
asus_wmi_ec_info *ec, int boar
 	ec->nr_registers =3D 0;
=20
 	switch (board) {
+	case BOARD_PW_X570_A:
 	case BOARD_RS_B550_E_G:
 	case BOARD_RS_X570_E_G:
 	case BOARD_R_C8H:
@@ -153,6 +156,7 @@ static void asus_wmi_ec_fill_board_sensors(struct=20
asus_wmi_ec_info *ec, int boar
 	}
=20
 	switch (board) {
+	case BOARD_PW_X570_A:
 	case BOARD_RS_X570_E_G:
 	case BOARD_R_C8H:
 	case BOARD_R_C8DH:
@@ -166,6 +170,7 @@ static void asus_wmi_ec_fill_board_sensors(struct=20
asus_wmi_ec_info *ec, int boar
 	}
=20
 	switch (board) {
+	case BOARD_PW_X570_A:
 	case BOARD_RS_X570_E_G:
 	case BOARD_R_C8H:
 	case BOARD_R_C8F:
diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index ba18c1cbf572..ff28ba70a8b3 100644
=2D-- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -5000,6 +5000,7 @@ static int __init nct6775_find(int sioaddr, struct=20
nct6775_sio_data *sio_data)
 static struct platform_device *pdev[2];
=20
 static const char * const asus_wmi_boards[] =3D {
+	"Pro WS X570-ACE",
 	"PRIME B360-PLUS",
 	"PRIME B460-PLUS",
 	"PRIME X570-PRO",
```

Now, with nct6775 I do not need `acpi_enforce_resources=3Dlax` any more, an=
d it=20
works straight away:

```
nct6798-isa-0290
Adapter: ISA adapter
in0:                        1.06 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:                        1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  A=
LARM
in2:                        3.38 V  (min =3D  +0.00 V, max =3D  +0.00 V)  A=
LARM
in3:                        3.36 V  (min =3D  +0.00 V, max =3D  +0.00 V)  A=
LARM
in4:                        1.74 V  (min =3D  +0.00 V, max =3D  +0.00 V)  A=
LARM
in5:                      592.00 mV (min =3D  +0.00 V, max =3D  +0.00 V)  A=
LARM
in6:                        1.09 V  (min =3D  +0.00 V, max =3D  +0.00 V)  A=
LARM
in7:                        3.38 V  (min =3D  +0.00 V, max =3D  +0.00 V)  A=
LARM
in8:                        3.25 V  (min =3D  +0.00 V, max =3D  +0.00 V)  A=
LARM
in9:                      888.00 mV (min =3D  +0.00 V, max =3D  +0.00 V)  A=
LARM
in10:                       8.00 mV (min =3D  +0.00 V, max =3D  +0.00 V)  A=
LARM
in11:                      80.00 mV (min =3D  +0.00 V, max =3D  +0.00 V)  A=
LARM
in12:                       1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  A=
LARM
in13:                       1.35 V  (min =3D  +0.00 V, max =3D  +0.00 V)  A=
LARM
in14:                     888.00 mV (min =3D  +0.00 V, max =3D  +0.00 V)  A=
LARM
fan1:                      743 RPM  (min =3D    0 RPM)
fan2:                      366 RPM  (min =3D    0 RPM)
fan3:                      724 RPM  (min =3D    0 RPM)
fan4:                        0 RPM  (min =3D    0 RPM)
fan7:                        0 RPM  (min =3D    0 RPM)
SYSTIN:                    +35.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +=
75.0=C2=B0C)  sensor =3D=20
thermistor
CPUTIN:                    +43.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +=
75.0=C2=B0C)  sensor =3D=20
thermistor
AUXTIN0:                   +22.0=C2=B0C    sensor =3D thermistor
AUXTIN1:                  +127.0=C2=B0C    sensor =3D thermistor
AUXTIN2:                  +109.0=C2=B0C    sensor =3D thermistor
AUXTIN3:                   +32.0=C2=B0C    sensor =3D thermistor
PECI Agent 0 Calibration:  +44.5=C2=B0C
PCH_CHIP_CPU_MAX_TEMP:      +0.0=C2=B0C
PCH_CHIP_TEMP:              +0.0=C2=B0C
PCH_CPU_TEMP:               +0.0=C2=B0C
intrusion0:               ALARM
intrusion1:               OK
beep_enable:              disabled
```

With asus_wmi_sensors I get this:

```
asuswmiecsensors-isa-0000
Adapter: ISA adapter
CPU_Opt:        0 RPM
Chipset:     1733 RPM
Chipset:      +58.0=C2=B0C =20
CPU:          +45.0=C2=B0C =20
Motherboard:  +35.0=C2=B0C =20
T_Sensor:    +216.0=C2=B0C =20
VRM:          +34.0=C2=B0C =20
CPU:           7.00 A
```

Everything seems to be good except that `T_Sensor`. Probably, I should excl=
ude=20
it on this board?

If you are fine with the approach above, I'll post 2 patches for this board.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


