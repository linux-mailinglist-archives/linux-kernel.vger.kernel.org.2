Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475FA32D01B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbhCDJwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:52:02 -0500
Received: from mail-dm6nam11on2058.outbound.protection.outlook.com ([40.107.223.58]:17151
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233392AbhCDJvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:51:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pdn44ktiHwO1YX/24VI1W8njqLLxqb3z/5Q4Cv7+bmIdHVsDFm2z5ZxW+WJMDHQWyp7kzEUxXiMPAyQiR5GGcDRKDuSjuI3EWgswtXRMJ3p3QDu/pn454YutZR8QIUHNNrtNgtsW+Aj0b9o9V5dULvI6rbpbSdgHM+Ygej60kOhKRs82RkbZkWVyKn5lTEV5RtXpjdbwFcEqsMVn1NDgU26Un9JJlAzsG81wwMaCA+7TiHtJi0KmsDmAoQV7fPGoYw7+Yz6yt5wPM9nhu8evHu3x5OX1eMsKW8zULNHY/gzvcRth7FmHYG33mk2MlDcN4I6nPvn42UhGn0UzhBJwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWVyH0PQC/NsqAf9VzBJoFYkZsxIPVnBFLknIHpAiH0=;
 b=Vdwy56IACyBZ9bcz7xEhuoGJS2Qn/OKdNjD0S/x6TRT28Mcsh8Q/nzlgqIDFTIK+k1aq8i6f9cvuwxE+bo9nlWEfkM7H3KhOD7JNZ5NwM1XuMUQhPbTQUt5yJWUaXqcWWmXchxPAiZq6JetJS6kuDIo2AuMEbg9lNh+LJb+ZNgsmJFRdihaSD8qjHHlvMFLnP85YD1nz8Y0IAsTi1Kfi4+IvQ3hwzk6CJbqKv8+K7v9kUmTNSKPQG1yiO6/BGcpLUdy2PFtxeDnIwuL0B3+7avREHBUVPJ+f5vkSCV4Mh3T/m3M1QvZcUyU5qAjB+YpZltCKUvDP8ub8moefLQWfBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWVyH0PQC/NsqAf9VzBJoFYkZsxIPVnBFLknIHpAiH0=;
 b=cTepYT0PYF6GJQyK1gCJkESVid+xOCMw+pchQO8pt18S0R9kpHHbbU5FePvUANDAMUz1vW13WCABN9o69E67ErU3272WdBrWCTYDVti8HAK+seMfhTihWXPyDF9G1ZWLVsycG2lyt5Kh6HdU1XTZcXIM/XusLcJwQBe+5davl7Q=
Received: from DM6PR11MB4441.namprd11.prod.outlook.com (2603:10b6:5:200::11)
 by DM6PR11MB4492.namprd11.prod.outlook.com (2603:10b6:5:201::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Thu, 4 Mar
 2021 09:50:49 +0000
Received: from DM6PR11MB4441.namprd11.prod.outlook.com
 ([fe80::c98a:b143:dd74:1989]) by DM6PR11MB4441.namprd11.prod.outlook.com
 ([fe80::c98a:b143:dd74:1989%7]) with mapi id 15.20.3890.031; Thu, 4 Mar 2021
 09:50:48 +0000
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
Thread-Index: AQHXDnLNoMFOQBlFpUi0ty4vM08UB6pzmZqA
Date:   Thu, 4 Mar 2021 09:50:47 +0000
Message-ID: <3734B8C1-9AFA-494E-9C5B-433219D1F55A@silabs.com>
References: <5F0FCC57-86C5-4FF2-AE75-C2DDC748901A@silabs.com>
In-Reply-To: <5F0FCC57-86C5-4FF2-AE75-C2DDC748901A@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.40.0.2.31)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silabs.com;
x-originating-ip: [14.238.29.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa16ed24-dab2-4808-bcd0-08d8def2fd58
x-ms-traffictypediagnostic: DM6PR11MB4492:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4492565FC9104F307167052AE3979@DM6PR11MB4492.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cYGJHQaoE2xAAjQLfWrTzTIUkj0kxLbg3xSqQmLkCBlH8DzD2TUvwsQfoVl18JE/OQnK1ZPOTTeRuxLlA4W6QPweU4nU45kFTInUpp9XjyDbvqGBJTORb+Lb+cj+g/t/FuzCet/HaHg2TB4cYGHOiAGAj6Xyobv8rJSxnCgtvfD/xHSKPtzedz88AuO+bVsJmv2ZZq6+a3ivBqVOvtuCJfQfbaUJuksbgiQdRDGe9gmbsh/0kcNEjNvwOlHN0Qk97ko6rxsw1xdHcXR/oJwRt1KVZtIV0AaO/vhzxisoDWOjK5jUdFE0/iSNCu9kdt3kBNCfjM4YwdfGBZG33azEAIwSThaLGlbqxW/kxcSwy75oavsHjC0fUcCxYHVAfvuKhmxv8nfOAttzkwYZQhn4kiUNIRChqiOHfPX/d3E3Wnf+oVE2pU1ZXRuPSbNHkEWC0glg4MVSyoOqZoJnS4bkD6kQUAFKTDJsr36oOaHaZy4Wo5Xq4I/0fAeCs6FcIsUpciURHFyhutxevEeuMNq77QH3uEa7/YFWSZrQsc9jcWE4ztgXhT+n4qPNsL4+9tE0YKo5AwrKTUQ3iGiGLqp3Qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4441.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39850400004)(376002)(396003)(110136005)(478600001)(316002)(107886003)(54906003)(86362001)(36756003)(4326008)(6486002)(66556008)(26005)(6512007)(186003)(33656002)(8936002)(8676002)(91956017)(66476007)(5660300002)(6506007)(66446008)(76116006)(2906002)(64756008)(71200400001)(83380400001)(2616005)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qQDricA0qHRcb1PaUGN/c62HxNqD3pWtQaKpaq37Zc/XrG8KkBjQTqL5kYE1?=
 =?us-ascii?Q?K8HAVV0hofy/malva/i5JUKvakjmI+e74jKSV1Zd8zYUg+YStQCc6HH1LEI2?=
 =?us-ascii?Q?8drr3R7Rc2mi/Gy4UcTuKVGIxNFkDBzkAaw6zjgj0DjIRCpKqoQtPkxlmhqv?=
 =?us-ascii?Q?OcOLvE/Bd0ks0fIYDiFzpRjtM78PC5Hi8kbboQHZIW7y4RoI9MJOqf/Ij5hV?=
 =?us-ascii?Q?9YCNCbalR+Imxlfmpc1lXn0PRMZQ/cGe8MeiQKFeDn0cqtzC531zF+RP+W7/?=
 =?us-ascii?Q?LGJQ8ZuaMhKSlCs1CPInXn6nNLr2HcmZ/r0KwFHtTrQvaEZa1UDwwYxvuWaY?=
 =?us-ascii?Q?BLc/PFoz8SNBGLLvD0UQXJDNsP1RLJqBh2ffrlvn3z+UlNa6CnkWoGnSABRm?=
 =?us-ascii?Q?U4ZM6yv7x8L3t2K0iWrL1ZWWvO6RFMa4+U+y/tCHgnt0QN/uYCqf8hKj8Z4D?=
 =?us-ascii?Q?blOKB9gl7IGyU//bcPt6kBKtAdCc3y82XKQiGlH39o9slPw/NEM4J24NqSib?=
 =?us-ascii?Q?9Yve8muGclmpt+p5s94i7IlI9w5Vl66/LIThsM38QhjiuHDh+s+sH01oMvku?=
 =?us-ascii?Q?YWElrBQWih7CZ5wdfPmWcGnI3ZRpl+yfufhtU1oqBjlGsf5mndrrNIqCAkkn?=
 =?us-ascii?Q?NO7nB96twmcDK1DY4/IIY6UJM4BfBOR7iLV1B4SLcNUlqlp9UUtkO096leD8?=
 =?us-ascii?Q?TYyKdjFdy/lIM+POq/3DzmLQ0o0/eC/qXctDgAgMNRsZbv4qkihQEOuXNZ0k?=
 =?us-ascii?Q?VHOYEOomqU4acDPNkphD+j9Oi9x6lhwvX2dGW3PgHGFP2W/Y9sp/Hq/uN2vb?=
 =?us-ascii?Q?UktpwYRIyl1tcdBXEyicwSWrcNmruAV8W4k9r4yp2DZ3PakVhD5XopFV5CNY?=
 =?us-ascii?Q?jSWWngcCdvNjF4n23e4BuDywqPCl54oj2hRNElzjdg9EPbKiJ/f7Cic7sPHL?=
 =?us-ascii?Q?Yj8/qcagzdK2P0pDij/ML23whnIIQERJzOyJ8WKVLyQo+9Dz/+dV9cBuBKsj?=
 =?us-ascii?Q?ldaL1kfrOzphENDGpEBVLq1K0fFyPCLuiXKN73OPKhz49NImL9bKzgbfujSe?=
 =?us-ascii?Q?bYGB1PtfdXAQcZWoQI/ZJ7SqlyyZQ+25fk5sJr4MTwPh8WUuZTlSRYCjKfAD?=
 =?us-ascii?Q?7LguWaCFCg183+yQ/syCNNJSaABlP71j0/Nv1Nd/VthaAJdv1Rnz8pajYTvZ?=
 =?us-ascii?Q?Kl+w/YN6nwbo1hUFDI/AbkNKvFpbIPw86yLp0vtvETQ4zUPxuEWSETSash36?=
 =?us-ascii?Q?IbVxbsbeNgJKLV3Sw8kUb7K+l5kLCznJpJRTsimO4Cy+8uJs02ZBDSWUJtIu?=
 =?us-ascii?Q?lYpldhZwDOOQJZv8zEoKct8Z?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <50DC7939070A3A4B8CDD64BAAD7E2B3D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4441.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa16ed24-dab2-4808-bcd0-08d8def2fd58
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 09:50:48.3100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KH4npZi7YjvuZLuq0m5oD9+RQtQjo+M+lcRHhPa33GzAYwzjZDKKzNKEtiKCS1nuCXNLJzLHYIfXzpd8Bzyo9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4492
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to other CP210x devices, GPIO interfaces (gpiochip) should be
supported for CP2108.

CP2108 has 4 serial interfaces but only 1 set of GPIO pins are shared
to all of those interfaces. So, just need to initialize GPIOs of CP2108
with only one interface (I use interface 0). It means just only 1 gpiochip
device file will be created for CP2108.

CP2108 has 16 GPIOs, So data types of several variables need to be is u16
instead of u8(in struct cp210x_serial_private). This doesn't affect other
CP210x devices.

Because CP2108 has 16 GPIO pins, the parameter passed by cp210x functions
will be different from other CP210x devices. So need to check part number
of the device to use correct data format  before sending commands to
devices.

Like CP2104, CP2108 have GPIO pins with configurable options. Therefore,
should be mask all pins which are not in GPIO mode in cp2108_gpio_init()
function.

Signed-off-by: Pho Tran <pho.tran@silabs.com>
---
 drivers/usb/serial/cp210x.c | 199 +++++++++++++++++++++++++++++++-----
 1 file changed, 172 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 7bec1e730b20..0e92e41bacc5 100644
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
+	__le16 Mode_PB[5];
+	__le16 LowPower_PB[5];
+	__le16 Latch_PB[5];
+} __packed;
+
+struct cp210x_quad_port_config {
+	struct cp210x_quad_port_state reset_state;
+	struct cp210x_quad_port_state suspend_state;
+	u8 IPDelay_IFC[4];
+	u8 EnhancedFxn_IFC[4];
+	u8 EnhancedFxn_Device;
+	u8 ExtClkFreq[4];
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
+#define CP2108_GPIO15_ALTERNATE_FUNC	BIT(15)
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

