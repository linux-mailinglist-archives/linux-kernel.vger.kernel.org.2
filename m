Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66DF3278FD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 09:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhCAIOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 03:14:51 -0500
Received: from mail-mw2nam12on2084.outbound.protection.outlook.com ([40.107.244.84]:5345
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232832AbhCAIOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 03:14:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDwIaLpKaaGI0tnhc9Qzy3KlGLzfkjMTf2xsX67FpI1jEWxXpN0VSGD/9fJva0XxIPGHp46DDjUG0ohZ0qkICMjYlP+moMqi3LZtvXWP3XVn6VHUoacLqucKrAXhRoQ9R8n8Xr22DXPVDUzcPzd6n1o7e3Jigqq2gqrAjGSh8ETRaTt+s+IeLR9CE4CCdvuHLdFrc5J9//R8KQLKCiBk/gVYZ/NzJkX3fWNUs/4ELtKphFaTkvsVZw7muhsZ/EX91wg00jOFbMaM/zNC7ma/hOvOwZa8I0nGjHOtg1A0rEKgu8igM4VAdHtTfeiCsQFcO12G2ILJNlw6H2GYUf1TyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7+fsTXrXthyxZQBso4kmxb3O6Mb9FyLzN3e57tBeLY=;
 b=FnqqDfkmaL3EtpfSxVWfMvlzLL2pbP0ix5vWtRdlhWZ2E669/QLBPFKjsjEhtMb8tFs9HI+0bqFQkBxAtc993SPctTyoAqteL/Si9mo0JIfq3Fzwf9eii4XR9sk3ghuHa+LZgFsp2QOMBiLKYbfHbM+H+qbCqNl7YkgqWxTQOQxoHUyjQ4ILZt9G1Mbn7jQ1yI7b2A39m85CY2EKEbbVNh9m/7B5fmC+cq9ZBXi4qd2fsYb1b87hx0/jqi6jA8rStmAVIrek0eo0PKIBU+5HqV8mSIOuuNMYOcNGqUfgBMLaGrCJbn6rq7/1zaDt7rbeu0trL5O1yQ4BFLvitnXVnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7+fsTXrXthyxZQBso4kmxb3O6Mb9FyLzN3e57tBeLY=;
 b=Z38hYUxu7vne610JXrUcXu83+8MYfXVDYPGa58XSnkU0e7FISIGExSgSxTODQb5YDMFcGrRvz+FijhKvOcOM2yvWt6AbTSy4j3STSdDjcWCA0i31Zt9Ne7ttMtd7DQYJzSu6muPR9GM69k1eK4bYPENTSpBdyk8OuONfBjPBhKI=
Received: from DM6PR11MB4441.namprd11.prod.outlook.com (2603:10b6:5:200::11)
 by DM6PR11MB2811.namprd11.prod.outlook.com (2603:10b6:5:c8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Mon, 1 Mar
 2021 08:13:46 +0000
Received: from DM6PR11MB4441.namprd11.prod.outlook.com
 ([fe80::c98a:b143:dd74:1989]) by DM6PR11MB4441.namprd11.prod.outlook.com
 ([fe80::c98a:b143:dd74:1989%7]) with mapi id 15.20.3890.026; Mon, 1 Mar 2021
 08:13:46 +0000
From:   Pho Tran <Pho.Tran@silabs.com>
To:     "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>
Subject: [PATCH] USB: serial: cp210x: Make the CP210x driver work with GPIOs
  of CP2108
Thread-Topic: [PATCH] USB: serial: cp210x: Make the CP210x driver work with
 GPIOs  of CP2108
Thread-Index: AQHXDnLNFJOJkgJz/UuCUSNw6NGAvA==
Date:   Mon, 1 Mar 2021 08:13:46 +0000
Message-ID: <5F0FCC57-86C5-4FF2-AE75-C2DDC748901A@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.40.0.2.31)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silabs.com;
x-originating-ip: [58.187.6.148]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 963c0ca4-12f8-451e-86b7-08d8dc89efc4
x-ms-traffictypediagnostic: DM6PR11MB2811:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB28114D1167D269F2B9CA6663E39A9@DM6PR11MB2811.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nsl7FATpR5piH7PB6ta4CsxLvD5lvWCQ7qA+yuYIH8cySthRpsPQyPnOZ8OIjmuzU2jfQHzELqjr9aev1KyZcxprRak27pP5GMfVfBlFnf39FddyMb3zmEQBexwWo2B1MN7E7x149YSjH+mQnzz1oX+U1J6qRh4bFfXiqCWW5T/GpyX27CG472OSxc3NTdwm2GXfLU1KBhO+AsXshVm6aWOXXqGXhqmhYy5SdVBYOw2WYJiU659RNWKQbRnO1hpJHinaQ39NrFTUN9dxHE8SrubSxVM1OvP16udNJpU6TAfZQa+z0F5l8htBJWAf12Kb84+cFbsyuvLk3tZ6IHNI3bysAYdk4f/BFMRYpRSMVy4ScFPn9aWFx9KpRTWYHSfzypySiRUSpJPCFGpE9GV9l+Dh/2gON/6mbo9MMIG+jjmANCecV41YBTUcBdE2uUl53nnvO4Zn0aq21xYauS+g1hliNPE8ehe8Gkg4D7fjSbc8ecmeAuIkqJF49u0ldqyaQPxrk3LjTdLj7YFFbUkYcITO1aGEVeIsoyGS/BxXRiwYb5Sy5bHniWbG7PK8EJQU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4441.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(396003)(39850400004)(91956017)(186003)(2906002)(66946007)(83380400001)(8936002)(66476007)(64756008)(6506007)(76116006)(6486002)(2616005)(71200400001)(54906003)(5660300002)(316002)(6512007)(4326008)(66556008)(36756003)(26005)(107886003)(33656002)(8676002)(478600001)(66446008)(110136005)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YkpHelLP4NbQoKfy6Fy7PVgHIhloaklYD1g/Hui6j3Vi1Jbv9nLAwa1jWvj7?=
 =?us-ascii?Q?J1V59fLYgVHWL5BE1xgt19rayWhO76isI/xMImW3Y4MvEE2HZCcUx+SSMVnn?=
 =?us-ascii?Q?ZH4xxvPTa5C7Xfvx+ptgjN6B8AYJFkH83zMn92VL+LnB/BspOr76hvHW4AP/?=
 =?us-ascii?Q?73VVanq+mTM+A5b9mVuvV2C1/CyW+xBkWxPHyz2syua7+S8Q5iRXWqBd0O6c?=
 =?us-ascii?Q?F/+G6ou+EVbWfYTMYTTNcBLCxV35GqC1DAKIq49x1Wbuiw0jysxCiOPyIsex?=
 =?us-ascii?Q?kKHH6qAqrPqbfFi2o4f/B+nDAJmVjCmSJ1frb4x8SlPgStIjIzmxzHW5ZFho?=
 =?us-ascii?Q?9hdcjHqPj21cnngkXf6IF7CCFIJ8jBG6w86UVGO7hYMKG0MobGFH9/N6y6NG?=
 =?us-ascii?Q?a2K3mJZexMNZDW7qbSi7X5kbNMe6uatKxHt4K4qn6QeIX/AlvPtlHPlOuccs?=
 =?us-ascii?Q?r+7zWmEXPXwGCK+cEE5NUeM9cddZBU5bfN1THmsaFmAbHGA/4ZW0o56KeF79?=
 =?us-ascii?Q?COTb4dRBFo/FJbKRo11Uq7sxGYoBl1hhEVru41YCbP5HgYjeSQFOo2/yX7ur?=
 =?us-ascii?Q?PWuQwkPsWWrtDYQUXnfQV8pDji/tZ9HoInCNPCwhdJZIFxdjkYcBLt3eaBe+?=
 =?us-ascii?Q?t2izkmSZGpEuya8XbIgkF5MJlfoCmJCe+2oiFIbGYwiXYwLybetAvuKUt95+?=
 =?us-ascii?Q?C8MW1YZ+fobKboOAWdW7wFG9hR6p70/OyJhnHN5xhLx5kXBPR4K1g4s7GHmk?=
 =?us-ascii?Q?65+vAseMiuKKHMe81pB0DXEMAuP8oWpeid2g2aAT6Uc5c2hOL/3yO6p52XxU?=
 =?us-ascii?Q?bINSoXoHebprlzLON85ZgC39OIu2m4RjVPBTg4N0I54jW1aNxNP/e7zhaZGr?=
 =?us-ascii?Q?KCmDOyU616H6ZktBWAD1AhN7PtcWb+GZc/UeQdbkhCFEW1SKKBnAGjMTVoid?=
 =?us-ascii?Q?1dQM2lcG9QMM5Ge3AKHCBrkbI8sz1x/FZzznSh9kYwLv9cfhx826AH74FGbJ?=
 =?us-ascii?Q?dSIEfmLB+9elEMspWt2G+2tPlK8U4u51hf3+66WnTdpS3tW89pREUmumtN//?=
 =?us-ascii?Q?cG2LroFUlHIVZ110/3GfZzb6MMABeBBRYu/CK7dR5efN167B1SDxT76GbfoK?=
 =?us-ascii?Q?AEg/PIXOvUujlZ3TeFiVT4uf6BpNBR5HS+aTNhEe0sUWY9EYcCyGIxg+Dbci?=
 =?us-ascii?Q?qHczpLA8eijLtmxWNucN6IsvgW+l2+zdvJuLiA3wdzMtiO6sHzq3c+T0yFY8?=
 =?us-ascii?Q?ZofnduWv6WEgvjZkunx7JfVa4TDr85xUtUAr86x89vKSR7rRQzri7gXvHBvj?=
 =?us-ascii?Q?BH6k6hm8DHqIrynDEdrtaxgy?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F2CC8F06C833D44DA0F692C47CDEEA6B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4441.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963c0ca4-12f8-451e-86b7-08d8dc89efc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 08:13:46.2890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NotMiZ0Uwvpt9mrLlExu7EsnNd9uGnR5wP5nXfuYh0MW9vFJAEqsFdQpCaah3TBGR72GyiyUIVofZoZgHCKkfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2811
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to other CP210x devices, GPIO interfaces (gpiochip) should be suppo=
rted for CP2108.

CP2108 has 4 serial interfaces but only 1 set of GPIO pins are shared to al=
l of those interfaces.
So, just need to initialize GPIOs of CP2108 with only one interface (I use =
interface 0).
It means just only 1 gpiochip device file will be created for CP2108.

CP2108 has 16 GPIOs, So data types of several variables need to be is u16
instead of u8(in struct cp210x_serial_private). This doesn't affect other C=
P210x devices.

Because CP2108 has 16 GPIO pins, the parameter which is passed by cp210x fu=
nctions
will be different from other CP210x devices. So need to check part number o=
f the device to use correct data format  before sending commands to devices=
.

Like CP2104, CP2108 have GPIO pins with configurable options. Therefore, in=
 cp2108_gpio_init() function,
Should be mask all pins which are not in GPIO mode.

Signed-off-by: Pho Tran <pho.tran@silabs.com>
---
 drivers/usb/serial/cp210x.c | 199 +++++++++++++++++++++++++++++++-----
 1 file changed, 172 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 7bec1e730b20..6bad65b3a971 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -245,9 +245,9 @@ struct cp210x_serial_private {
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip	gc;
 	bool			gpio_registered;
-	u8			gpio_pushpull;
-	u8			gpio_altfunc;
-	u8			gpio_input;
+	u16			gpio_pushpull;
+	u16			gpio_altfunc;
+	u16			gpio_input;
 #endif
 	u8			partnum;
 	speed_t			min_speed;
@@ -500,6 +500,25 @@ struct cp210x_single_port_config {
 	u8	device_cfg;
 } __packed;
=20
+/*
+ * CP210X_VENDOR_SPECIFIC, CP210X_GET_PORTCONFIG call reads these 0x49 byt=
es
+ * on a CP2108 chip. Structure needs padding due to unused/unspecified byt=
es.
+ */
+struct cp210x_quad_port_state {
+	uint16_t Mode_PB[5];
+	uint16_t LowPower_PB[5];
+	uint16_t Latch_PB[5];
+} __packed;
+
+struct cp210x_quad_port_config {
+	struct cp210x_quad_port_state reset_state;
+	struct cp210x_quad_port_state suspend_state;
+    uint8_t IPDelay_IFC[4];
+	uint8_t EnhancedFxn_IFC[4];
+	uint8_t EnhancedFxn_Device;
+    uint8_t ExtClkFreq[4];
+} __packed;
+
 /* GPIO modes */
 #define CP210X_SCI_GPIO_MODE_OFFSET	9
 #define CP210X_SCI_GPIO_MODE_MASK	GENMASK(11, 9)
@@ -510,6 +529,27 @@ struct cp210x_single_port_config {
 #define CP210X_GPIO_MODE_OFFSET		8
 #define CP210X_GPIO_MODE_MASK		GENMASK(11, 8)
=20
+#define CP2108_GPIO_MODE_OFFSET		0
+#define CP2108_GPIO_MODE_MASK		GENMASK(15, 0)
+
+/* CP2108 port configuration values */
+#define CP2108_GPIO0_ALTERNATE_FUNC		BIT(0)
+#define CP2108_GPIO1_ALTERNATE_FUNC		BIT(1)
+#define CP2108_GPIO2_ALTERNATE_FUNC		BIT(2)
+#define CP2108_GPIO3_ALTERNATE_FUNC		BIT(3)
+#define CP2108_GPIO4_ALTERNATE_FUNC		BIT(4)
+#define CP2108_GPIO5_ALTERNATE_FUNC		BIT(5)
+#define CP2108_GPIO6_ALTERNATE_FUNC		BIT(6)
+#define CP2108_GPIO7_ALTERNATE_FUNC		BIT(7)
+#define CP2108_GPIO8_ALTERNATE_FUNC		BIT(8)
+#define CP2108_GPIO9_ALTERNATE_FUNC		BIT(9)
+#define CP2108_GPIO10_ALTERNATE_FUNC	BIT(10)
+#define CP2108_GPIO11_ALTERNATE_FUNC	BIT(11)
+#define CP2108_GPIO12_ALTERNATE_FUNC	BIT(12)
+#define CP2108_GPIO13_ALTERNATE_FUNC	BIT(13)
+#define CP2108_GPIO14_ALTERNATE_FUNC	BIT(14)
+#define CP2108_GPIO15_ALTERNATE_FUNC 	BIT(15)
+
 /* CP2105 port configuration values */
 #define CP2105_GPIO0_TXLED_MODE		BIT(0)
 #define CP2105_GPIO1_RXLED_MODE		BIT(1)
@@ -532,6 +572,12 @@ struct cp210x_gpio_write {
 	u8	state;
 };
=20
+/* CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these 0x4 bytes =
on CP2108. */
+struct cp2108_gpio_write {
+	u16	mask;
+	u16	state;
+} __packed;
+
 /*
  * Helper to get interface number when we only have struct usb_serial.
  */
@@ -1298,50 +1344,73 @@ static int cp210x_gpio_get(struct gpio_chip *gc, un=
signed int gpio)
 	struct cp210x_serial_private *priv =3D usb_get_serial_data(serial);
 	u8 req_type =3D REQTYPE_DEVICE_TO_HOST;
 	int result;
-	u8 buf;
-
-	if (priv->partnum =3D=3D CP210X_PARTNUM_CP2105)
-		req_type =3D REQTYPE_INTERFACE_TO_HOST;
=20
-	result =3D usb_autopm_get_interface(serial->interface);
-	if (result)
-		return result;
+	if (priv->partnum =3D=3D CP210X_PARTNUM_CP2108) {
+		u16 buf;
=20
-	result =3D cp210x_read_vendor_block(serial, req_type,
-					  CP210X_READ_LATCH, &buf, sizeof(buf));
-	usb_autopm_put_interface(serial->interface);
-	if (result < 0)
-		return result;
-
-	return !!(buf & BIT(gpio));
+		req_type =3D REQTYPE_INTERFACE_TO_HOST;
+		result =3D usb_autopm_get_interface(serial->interface);
+		if (result)
+			return result;
+		result =3D cp210x_read_vendor_block(serial, req_type,
+						CP210X_READ_LATCH, &buf, sizeof(buf));
+		usb_autopm_put_interface(serial->interface);
+		if (result < 0)
+			return result;
+		return !!(buf & BIT(gpio));
+	} else {
+		u8 buf;
+
+		if (priv->partnum =3D=3D CP210X_PARTNUM_CP2105)
+			req_type =3D REQTYPE_INTERFACE_TO_HOST;
+		result =3D usb_autopm_get_interface(serial->interface);
+		if (result)
+			return result;
+		result =3D cp210x_read_vendor_block(serial, req_type,
+						CP210X_READ_LATCH, &buf, sizeof(buf));
+		usb_autopm_put_interface(serial->interface);
+		if (result < 0)
+			return result;
+		return !!(buf & BIT(gpio));
+	}
 }
=20
 static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int v=
alue)
 {
 	struct usb_serial *serial =3D gpiochip_get_data(gc);
 	struct cp210x_serial_private *priv =3D usb_get_serial_data(serial);
-	struct cp210x_gpio_write buf;
+	struct cp210x_gpio_write u8_buf;
+	struct cp2108_gpio_write u16_buf;
 	int result;
=20
 	if (value =3D=3D 1)
-		buf.state =3D BIT(gpio);
+		u8_buf.state =3D BIT(gpio);
 	else
-		buf.state =3D 0;
+		u8_buf.state =3D 0;
=20
-	buf.mask =3D BIT(gpio);
+	u8_buf.mask =3D BIT(gpio);
=20
 	result =3D usb_autopm_get_interface(serial->interface);
 	if (result)
 		goto out;
=20
-	if (priv->partnum =3D=3D CP210X_PARTNUM_CP2105) {
+	if (priv->partnum =3D=3D CP210X_PARTNUM_CP2105)
 		result =3D cp210x_write_vendor_block(serial,
 						   REQTYPE_HOST_TO_INTERFACE,
-						   CP210X_WRITE_LATCH, &buf,
-						   sizeof(buf));
+						   CP210X_WRITE_LATCH, &u8_buf,
+						   sizeof(u8_buf));
+	else if (priv->partnum =3D=3D CP210X_PARTNUM_CP2108) {
+		if (value =3D=3D 1)
+			u16_buf.state =3D cpu_to_le16(BIT(gpio));
+		else
+			u16_buf.state =3D 0;
+		u16_buf.mask =3D cpu_to_le16(BIT(gpio));
+		result =3D cp210x_write_vendor_block(serial,
+						   REQTYPE_HOST_TO_INTERFACE,
+						   CP210X_WRITE_LATCH, &u16_buf,
+						   sizeof(u16_buf));
 	} else {
-		u16 wIndex =3D buf.state << 8 | buf.mask;
-
+		u16 wIndex =3D u8_buf.state << 8 | u8_buf.mask;
 		result =3D usb_control_msg(serial->dev,
 					 usb_sndctrlpipe(serial->dev, 0),
 					 CP210X_VENDOR_SPECIFIC,
@@ -1350,7 +1419,6 @@ static void cp210x_gpio_set(struct gpio_chip *gc, uns=
igned int gpio, int value)
 					 wIndex,
 					 NULL, 0, USB_CTRL_SET_TIMEOUT);
 	}
-
 	usb_autopm_put_interface(serial->interface);
 out:
 	if (result < 0) {
@@ -1420,6 +1488,75 @@ static int cp210x_gpio_set_config(struct gpio_chip *=
gc, unsigned int gpio,
 	return -ENOTSUPP;
 }
=20
+static int cp2108_gpio_init(struct usb_serial *serial)
+{
+	struct cp210x_serial_private *priv =3D usb_get_serial_data(serial);
+	struct cp210x_quad_port_config config;
+	u16 iface_config;
+	u16 gpio_latch;
+	int result;
+	u16 i;
+
+	result =3D cp210x_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,
+					  CP210X_GET_PORTCONFIG, &config,
+					  sizeof(config));
+	if (result < 0) {
+		dev_warn(&serial->interface->dev,
+			 "querying port config on cp2108 failed\n");
+		return result;
+	}
+	priv->gc.ngpio =3D 16;
+	iface_config =3D config.EnhancedFxn_IFC[0];
+	priv->gpio_pushpull =3D (u16)((le16_to_cpu(config.reset_state.Mode_PB[1])=
 &
+								CP2108_GPIO_MODE_MASK) >>
+								CP2108_GPIO_MODE_OFFSET);
+	gpio_latch =3D (u16)((le16_to_cpu(config.reset_state.Latch_PB[1]) &
+						CP2108_GPIO_MODE_MASK) >>
+						CP2108_GPIO_MODE_OFFSET);
+
+	/* mark all pins which are not in GPIO mode */
+	if (iface_config & CP2108_GPIO0_ALTERNATE_FUNC)		/* GPIO 0 */
+		priv->gpio_altfunc |=3D BIT(0);
+	if (iface_config & CP2108_GPIO1_ALTERNATE_FUNC)		/* GPIO 1 */
+		priv->gpio_altfunc |=3D BIT(1);
+	if (iface_config & CP2108_GPIO2_ALTERNATE_FUNC)		/* GPIO 2 */
+		priv->gpio_altfunc |=3D BIT(2);
+	if (iface_config & CP2108_GPIO3_ALTERNATE_FUNC)		/* GPIO 3 */
+		priv->gpio_altfunc |=3D BIT(3);
+	if (iface_config & CP2108_GPIO4_ALTERNATE_FUNC)		/* GPIO 4 */
+		priv->gpio_altfunc |=3D BIT(4);
+	if (iface_config & CP2108_GPIO5_ALTERNATE_FUNC)		/* GPIO 5 */
+		priv->gpio_altfunc |=3D BIT(5);
+	if (iface_config & CP2108_GPIO6_ALTERNATE_FUNC)		/* GPIO 6 */
+		priv->gpio_altfunc |=3D BIT(6);
+	if (iface_config & CP2108_GPIO7_ALTERNATE_FUNC)		/* GPIO 7 */
+		priv->gpio_altfunc |=3D BIT(7);
+	if (iface_config & CP2108_GPIO8_ALTERNATE_FUNC)		/* GPIO 8 */
+		priv->gpio_altfunc |=3D BIT(8);
+	if (iface_config & CP2108_GPIO9_ALTERNATE_FUNC)		/* GPIO 9 */
+		priv->gpio_altfunc |=3D BIT(9);
+	if (iface_config & CP2108_GPIO10_ALTERNATE_FUNC)	/* GPIO 10 */
+		priv->gpio_altfunc |=3D BIT(10);
+	if (iface_config & CP2108_GPIO11_ALTERNATE_FUNC)	/* GPIO 11 */
+		priv->gpio_altfunc |=3D BIT(11);
+	if (iface_config & CP2108_GPIO12_ALTERNATE_FUNC)	/* GPIO 12 */
+		priv->gpio_altfunc |=3D BIT(12);
+	if (iface_config & CP2108_GPIO13_ALTERNATE_FUNC)	/* GPIO 13 */
+		priv->gpio_altfunc |=3D BIT(13);
+	if (iface_config & CP2108_GPIO14_ALTERNATE_FUNC)	/* GPIO 14 */
+		priv->gpio_altfunc |=3D BIT(14);
+	if (iface_config & CP2108_GPIO15_ALTERNATE_FUNC)	/* GPIO 15 */
+		priv->gpio_altfunc |=3D BIT(15);
+
+	for (i =3D 0; i < priv->gc.ngpio; ++i) {
+		/* Set direction to "input" if pin is open-drain and reset value is 1 */
+		if (!(priv->gpio_pushpull & BIT(i)) && (gpio_latch & BIT(i)))
+			priv->gpio_input |=3D BIT(i);
+	}
+
+	return 0;
+}
+
 /*
  * This function is for configuring GPIO using shared pins, where other si=
gnals
  * are made unavailable by configuring the use of GPIO. This is believed t=
o be
@@ -1649,6 +1786,14 @@ static int cp210x_gpio_init(struct usb_serial *seria=
l)
 	case CP210X_PARTNUM_CP2102N_QFN20:
 		result =3D cp2102n_gpioconf_init(serial);
 		break;
+	case CP210X_PARTNUM_CP2108:
+		/*
+		 * CP2108 has 4 interfaces, but GPIOs at 4 interfaces are the same and s=
hared.
+		 * So just need init GPIO chip for 1 interface.
+		 */
+		if (cp210x_interface_num(serial) =3D=3D 0)
+			result =3D cp2108_gpio_init(serial);
+		break;
 	default:
 		return 0;
 	}
--=20
2.17.1

