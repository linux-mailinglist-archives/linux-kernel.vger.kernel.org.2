Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D663078C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhA1OyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:54:11 -0500
Received: from mail-am6eur05on2060.outbound.protection.outlook.com ([40.107.22.60]:25985
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231966AbhA1Ovt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:51:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iqo0rTIQ061G2s1tDKiu0zKDEJleA3QxMoNHPJTP1oYOVafknZRSn6Tcs9HQ5wv08trGQOE3roJddg/bRE7ERY5oFsSJrkj4ikbScy6SUVuSoG4MStRddWW7/MeRXDi+xjA4W5LIMJof9bxO2li+AUNJT1Zr4yUG8XBuwlr+1MIfAxB0Kk1dvQcEDiTIk3LdMcGd0qXL4bfV61H5lTdA1bIMQ35h6utvku7PYlEbAFA7xlR5be6nkHKhMHj2cvVwg5upZyslvGMESDu4Lx5IKm5ydQpGzCQ8qAvV6dpIRJtL2aqmDY9JisJ3BQI8L3rmC3ALTTwOZl+oHFAEzSLdPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhIZUFFwzKod7yKM/MO6OyFwLEwMeuC9Zvpu1yKWU0c=;
 b=T4JRwWnbZe3xrGI1aMuEQvL79xRx+qEsx32Kl1AK27YwJ/igWpDAiR6UtkaqgXioDPWekCybr84PILuIOWXP9NOfNySbwX5bhOLjR3yRO+nUXJEn9Rjfq/cZnT9PhPEsGclVt24EB2fdNU3Kyocoln1pAD30KXXIe3ydpLkk6qyCa7keKSwJJ7ajZ/Q/0BUawTrhemCin4KhtjUmu8ZxS03WpaxkDIR7rrrA6qq9ulTxzVTbh6E4wwLvB2GfrFwHOAZhbKbhd/ZVmXV49uuVAF3zQORPrx7pzF06ksttdSQ9HpWxTAtcR13QsfT/Jw3FgQYaaWusIFbB1WfFwB3N0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhIZUFFwzKod7yKM/MO6OyFwLEwMeuC9Zvpu1yKWU0c=;
 b=TvVoa3a7+srvqcJqCBCVAaOQQdDDxpdrHp06SPZs2Lyt0HV/v8dmdXYpdl7Eh+hR5jjYVx30ZphONEXvfFMcGdTmQ6Vl3z28uuk+FvfhUiafX1v5UMfrbRuGkbgcEuesK/UInLuVSPI56WqRnxF+Janp8deydoyUwY0auTKgF9I=
Received: from PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ac::5)
 by PR3PR10MB4302.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Thu, 28 Jan
 2021 14:50:59 +0000
Received: from PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9d4e:b196:aa2b:8890]) by PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9d4e:b196:aa2b:8890%7]) with mapi id 15.20.3784.020; Thu, 28 Jan 2021
 14:50:58 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Mark Jonas <mark.jonas@de.bosch.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "tingquan.ruan@cn.bosch.com" <tingquan.ruan@cn.bosch.com>,
        "hubert.streidl@de.bosch.com" <hubert.streidl@de.bosch.com>
Subject: RE: [PATCH 1/1] mfd: da9063: Support SMBus and I2C mode
Thread-Topic: [PATCH 1/1] mfd: da9063: Support SMBus and I2C mode
Thread-Index: AQHW8xlV5deXERFmek6E9wvu0NUui6o9InQw
Date:   Thu, 28 Jan 2021 14:50:58 +0000
Message-ID: <PR3PR10MB41420E24A1303DA91175593E80BA9@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
References: <20210125125458.1302525-1-mark.jonas@de.bosch.com>
 <20210125125458.1302525-2-mark.jonas@de.bosch.com>
In-Reply-To: <20210125125458.1302525-2-mark.jonas@de.bosch.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: de.bosch.com; dkim=none (message not signed)
 header.d=none;de.bosch.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [147.161.166.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca1aecd9-8355-47d3-fbf2-08d8c39c1fd5
x-ms-traffictypediagnostic: PR3PR10MB4302:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PR3PR10MB4302E497437995FB3577B64FA7BA9@PR3PR10MB4302.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fOYyR7fGdpF54USRdB7/2IVIPq3InAPeRcv6OquFdj17uWtwNTPULnkPlxDLxIofILuHXkIVwYjoLrF172YGKsU3i9fU7NoaX7VoIw0JgwGat1eq5QGZDh/KjG+JrcvueCAukVz6CuzvwbP0JoZdGJDdrNfmbjY7K6GItaJjrlRSjduxI/c82U+SmbMz4xVC5+3bh6ctjM/ZvwOKyQerXyVfEoOKFpgwvbcQaSQasyZcaPXECXA1oRMR9J9gCdbBdU8TKd6y2pulZGV7HR+4EroeP5HseAxE8K8s3ouRwuTYrJVdlJjSEDo8Uc6OEeXGVNkEskfp9ceQIFyCtsAJKkZEdfHlUUnz5rry1BJBQJE6uFShb/+QfN2bseaV1HNtoGvH52igRK2lU6pvF/+kKEACYopIYkWxuaLX/h7uFM0Fk0DsF6XMqi6NoH+jJB9BnhWBvumPOSC5mEzXjlDvoTZBGBrntMldaU7hYr5UsUJ9Zgx0pWL/aqVXszp0UDuP0fOGDlz4aSXw8qNydUmTbQ7YojXhcTW5LbyF0/zOYmsSDkcNisgQeUMBunBR5mrLD+LSbhHCYbSkc9kXKv2NGGQfIxntXpkd9DHmiDX1gnU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(55016002)(966005)(2906002)(9686003)(53546011)(8936002)(498600001)(54906003)(8676002)(4326008)(86362001)(33656002)(66946007)(66476007)(26005)(64756008)(66556008)(186003)(6506007)(66446008)(83380400001)(7696005)(110136005)(76116006)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Dmw3RvLMFWJLY8Qn4DIQpHPQ2QVyDt/1zWI4LxOOpgAMZwYRmCR0+QxiEgw0?=
 =?us-ascii?Q?X5MoGcXEZwGx7GKLq6qTdI2dDE6NMY9ZyaUA2EL0ThNmUlBJOu7/byHwU0eL?=
 =?us-ascii?Q?1wVn4Irl/OMmM0/gxMnXBjE7TcWS9KT8Us0mSGSEGD5Rid5xs6EH2EXlEWGm?=
 =?us-ascii?Q?u3SNvDRmWC3bsIZg61/hyTludRGzpANLWVAYBgdgX0oykV5WAeL8s8EY4Gc5?=
 =?us-ascii?Q?82q2inEstcAOROwmPWulUjdUW1gxhRTWYs/BLRVma04dD2FAVsdMLCuLZov0?=
 =?us-ascii?Q?msdqtoNhTqaPzQrZhfgObYMnCdbnoqLDa1r/Cr4lsETULetDVrl2y68sy3zc?=
 =?us-ascii?Q?bnuFhQ9I9D6xM/QH+cin97waEcXVFYwRmjgp1GNJC9hFIOhv5Euf9QIUun/Q?=
 =?us-ascii?Q?DxRc+mbvJjqzXmffysXl4yHiz/kPEbLucKjOC0TFtXcq0T6W6Of5zMyQaptL?=
 =?us-ascii?Q?NHO+JU1QUbodxHIkB6fSWG61ZW1CBeo4YvSElknzboUKsPtDqE7LNl4WaKqe?=
 =?us-ascii?Q?AvPmIHFacQVgep7RChSBTq5cckWgIrGO2oP4guUm369QT+9Ae71YwYZk7PG3?=
 =?us-ascii?Q?SAF13AHIy3S3Pehtmf5GjgE9BpF1d6hA0v0pg2g5UcwIRhDQMnYyPwB7azIm?=
 =?us-ascii?Q?gMIFj73+dGAKeg7bEH1cZeId+CW6QN36R797QpKYPI4cEjUlPyJjFKrzndOU?=
 =?us-ascii?Q?gnUfsUoSE6SV+osRRn7ZXMOaLvV5+lCtpa2HWmhvvlg/Oj+pcnl3/mAOW2Ag?=
 =?us-ascii?Q?IS9UQznmQ3tgGv0m0EvRNfsH5EgCbhKo/cf3ukqLepclf9ed6FLJJjFSb2fC?=
 =?us-ascii?Q?Gn0zykM9iOFdgv3InptKUiQvfjeEfriR5qSzRNbQ9Bep/3Mya1Mwf57P/84T?=
 =?us-ascii?Q?hVF/nFMPfrrYQoJVUDcCRzksXnrXjHpYdvfKihZAi4Exg0Z3IUp0vnRX8/09?=
 =?us-ascii?Q?k+4K1Rx3RuUanWW/g+FgjawAtjKoZx4awAAEpiJW1GBA5Q2MrRb0oA43gg/f?=
 =?us-ascii?Q?j5EbyyhCy/8x7qyK7mcmGmBBzN9T+4cV6d2aWcBWWtQ/X3L6BIA5/kfFv9YY?=
 =?us-ascii?Q?TRDLowQl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1aecd9-8355-47d3-fbf2-08d8c39c1fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 14:50:58.7764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XvoxzbHSm36eoiD+119zWDrRA1cXlc7AbZXm817d2lYWKtQHAuHBnRcsiFrlv6nwfkO4ty1rKbl0P3zhnUs/MThK3rXykpg6l7sYeoHyDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4302
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 January 2021 12:55, Mark Jonas wrote:

> From: Hubert Streidl <hubert.streidl@de.bosch.com>
>=20
> By default the PMIC DA9063 2-wire interface is SMBus compliant. This
> means the PMIC will automatically reset the interface when the clock
> signal ceases for more than the SMBus timeout of 35 ms.
>=20
> If the I2C driver / device is not capable of creating atomic I2C
> transactions, a context change can cause a ceasing of the the clock
> signal. This can happen if for example a real-time thread is scheduled.
> Then the DA9063 in SMBus mode will reset the 2-wire interface.
> Subsequently a write message could end up in the wrong register. This
> could cause unpredictable system behavior.
>=20
> The DA9063 PMIC also supports an I2C compliant mode for the 2-wire
> interface. This mode does not reset the interface when the clock
> signal ceases. Thus the problem depicted above does not occur.
>=20
> This patch makes the I2C mode configurable by device tree. The SMBus
> compliant mode is kept as the default.

Could we not just check the bus' functionality flags and set this according=
ly?
Something like this is already done in regmap-i2c to determine how to acces=
s=20
the device:

 https://elixir.bootlin.com/linux/latest/source/drivers/base/regmap/regmap-=
i2c.c#L309

This seems cleaner than a new DT property, or will this not work in this
situation?

>=20
> Signed-off-by: Hubert Streidl <hubert.streidl@de.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> ---
>  Documentation/devicetree/bindings/mfd/da9063.txt |  7 +++++++
>  drivers/mfd/da9063-core.c                        |  9 +++++++++
>  drivers/mfd/da9063-i2c.c                         | 13 +++++++++++++
>  include/linux/mfd/da9063/core.h                  |  1 +
>  include/linux/mfd/da9063/registers.h             |  3 +++
>  5 files changed, 33 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/da9063.txt
> b/Documentation/devicetree/bindings/mfd/da9063.txt
> index 8da879935c59..256f2a25fe0a 100644
> --- a/Documentation/devicetree/bindings/mfd/da9063.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9063.txt
> @@ -19,6 +19,12 @@ Required properties:
>  - interrupts : IRQ line information.
>  - interrupt-controller
>=20
> +Optional properties:
> +
> +- i2c-mode : Switch serial 2-wire interface into I2C mode. Without this
> +  property the PMIC uses the SMBus mode (resets the interface if the clo=
ck
> +  ceases for a longer time than the SMBus timeout).
> +
>  Sub-nodes:
>=20
>  - regulators : This node defines the settings for the LDOs and BUCKs.
> @@ -77,6 +83,7 @@ Example:
>  		interrupt-parent =3D <&gpio6>;
>  		interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
>  		interrupt-controller;
> +		i2c-mode;
>=20
>  		rtc {
>  			compatible =3D "dlg,da9063-rtc";
> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> index df407c3afce3..baa1e4310c8c 100644
> --- a/drivers/mfd/da9063-core.c
> +++ b/drivers/mfd/da9063-core.c
> @@ -162,6 +162,15 @@ int da9063_device_init(struct da9063 *da9063, unsign=
ed
> int irq)
>  {
>  	int ret;
>=20
> +	if (da9063->i2cmode) {
> +		ret =3D regmap_update_bits(da9063->regmap,
> DA9063_REG_CONFIG_J,
> +				DA9063_TWOWIRE_TO, 0);
> +		if (ret < 0) {
> +			dev_err(da9063->dev, "Cannot enable I2C mode.\n");
> +			return -EIO;
> +		}
> +	}
> +
>  	ret =3D da9063_clear_fault_log(da9063);
>  	if (ret < 0)
>  		dev_err(da9063->dev, "Cannot clear fault log\n");
> diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
> index 3781d0bb7786..af0bf13ab43e 100644
> --- a/drivers/mfd/da9063-i2c.c
> +++ b/drivers/mfd/da9063-i2c.c
> @@ -351,6 +351,17 @@ static const struct of_device_id da9063_dt_ids[] =3D=
 {
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, da9063_dt_ids);
> +
> +static void da9063_i2c_parse_dt(struct i2c_client *client, struct da9063=
 *da9063)
> +{
> +	struct device_node *np =3D client->dev.of_node;
> +
> +	if (of_property_read_bool(np, "i2c-mode"))
> +		da9063->i2cmode =3D true;
> +	else
> +		da9063->i2cmode =3D false;
> +}
> +
>  static int da9063_i2c_probe(struct i2c_client *i2c,
>  			    const struct i2c_device_id *id)
>  {
> @@ -366,6 +377,8 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
>  	da9063->chip_irq =3D i2c->irq;
>  	da9063->type =3D id->driver_data;
>=20
> +	da9063_i2c_parse_dt(i2c, da9063);
> +
>  	ret =3D da9063_get_device_type(i2c, da9063);
>  	if (ret)
>  		return ret;
> diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/c=
ore.h
> index fa7a43f02f27..866864c50f78 100644
> --- a/include/linux/mfd/da9063/core.h
> +++ b/include/linux/mfd/da9063/core.h
> @@ -77,6 +77,7 @@ struct da9063 {
>  	enum da9063_type type;
>  	unsigned char	variant_code;
>  	unsigned int	flags;
> +	bool	i2cmode;
>=20
>  	/* Control interface */
>  	struct regmap	*regmap;
> diff --git a/include/linux/mfd/da9063/registers.h
> b/include/linux/mfd/da9063/registers.h
> index 1dbabf1b3cb8..6e0f66a2e727 100644
> --- a/include/linux/mfd/da9063/registers.h
> +++ b/include/linux/mfd/da9063/registers.h
> @@ -1037,6 +1037,9 @@
>  #define		DA9063_NONKEY_PIN_AUTODOWN	0x02
>  #define		DA9063_NONKEY_PIN_AUTOFLPRT	0x03
>=20
> +/* DA9063_REG_CONFIG_J (addr=3D0x10F) */
> +#define DA9063_TWOWIRE_TO			0x40
> +
>  /* DA9063_REG_MON_REG_5 (addr=3D0x116) */
>  #define DA9063_MON_A8_IDX_MASK			0x07
>  #define		DA9063_MON_A8_IDX_NONE		0x00
> --
> 2.25.1

