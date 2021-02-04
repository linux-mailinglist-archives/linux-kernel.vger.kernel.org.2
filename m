Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4EA30F751
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbhBDQLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:11:08 -0500
Received: from mail-eopbgr50066.outbound.protection.outlook.com ([40.107.5.66]:31088
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237805AbhBDQKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:10:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OG8x5H8BIUxmOfQVCuriDxenTf9v1ZVvZkGDAbg+EwwCNdSo0zvA5CpnS0loktAUsowJSMqgJ95NueaFGMPx8v8QsSwzQoCzAwoXcbj1SeKW9mCMw+n6hoHTUbX6ogqOtkYxo3N3i8US/H3SrElLZraAuTFBJYzS3gC7A02xeM+wwXXvhkAqcerRum8j66yUjrF5zPkKDoaZWjwpv/wnoITrBUwp3IZzE1+mWO42uHJ6Egpzqz7EOTwLeLRjFQBYKdjUg14Wkp+PNDIH9tP4/c2+YYd0YBaCK3Q0mQk1m/czCB939GuV+nFxUyL1b1HRfM2EnbR6ktwz8XONr8Lr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i+AkwWCCg29Lw5FWP7ChJ0mT4l1UCeKyZkzChJ4TPg=;
 b=Y47ZglH7hlX6xOOkwMRQFMvRfKePStHxAErSEBeys6kPGa3uLFots5GTb715yWBKj1WS12bJ6xx6s1Yz9sTzSSLmHQM3mw4lbrDN+k+bRaFZW/Xbu4peDo1/49el0BJotagMUoSmsg0RQ7aYY7Y3Ts12/145egKhFPuRNDB30v40xrOa+8EgDVjnSvowc+hpLy8AatyIiNJhLjixUywPdSvnyFCiz82et83PXiDFkayveY2EdnFUBtloKuXYXnFLq98PKNNvO/A73U/JAMYry6AkkGIRK1+knDiTAlo23Z62ldPQgM1owKQIeFyNsM8FUXa1ZCQdr12KTO3fsBU19Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i+AkwWCCg29Lw5FWP7ChJ0mT4l1UCeKyZkzChJ4TPg=;
 b=qj1JybQFO6QXD/TrqAMvZKOcTrj4K6Qxa5VEW1K/do1chxX5iwIkJQxscX471GfEG2JoYpyDjypPqHcYt/IfogAn9K1TZD1lr7Cx0bEvinEh9HeKCZiFeRknTrd8qatbML4bAKaPNABiZBU/+xY7BsfjKTZJcsbgpJ0ws74Tfmw=
Received: from PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ac::5)
 by PR3PR10MB3817.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:42::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.28; Thu, 4 Feb
 2021 16:09:28 +0000
Received: from PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9d4e:b196:aa2b:8890]) by PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9d4e:b196:aa2b:8890%7]) with mapi id 15.20.3805.028; Thu, 4 Feb 2021
 16:09:28 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Mark Jonas <mark.jonas@de.bosch.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "tingquan.ruan@cn.bosch.com" <tingquan.ruan@cn.bosch.com>,
        "hubert.streidl@de.bosch.com" <hubert.streidl@de.bosch.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: RE: [PATCH v2] mfd: da9063: Support SMBus and I2C mode
Thread-Topic: [PATCH v2] mfd: da9063: Support SMBus and I2C mode
Thread-Index: AQHW+w24ZU/6e3azTE+fNRV9kINR/KpIJ6CQ
Date:   Thu, 4 Feb 2021 16:09:28 +0000
Message-ID: <PR3PR10MB41426B0114614DED4C2687F880B39@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
References: <20210204155201.120524-1-mark.jonas@de.bosch.com>
In-Reply-To: <20210204155201.120524-1-mark.jonas@de.bosch.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: de.bosch.com; dkim=none (message not signed)
 header.d=none;de.bosch.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [147.161.166.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b161b4c-cc79-4e60-d580-08d8c9273fd3
x-ms-traffictypediagnostic: PR3PR10MB3817:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PR3PR10MB38177BA79C0D1C8281E54322A7B39@PR3PR10MB3817.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cLmalrSx/8qRsyv8C/O+NdRsSzkPENjBtRhak1X+/QQtjNnKL0+nlj5P8+blRFYquUeXFxcTYK7a3sK+8l33bqQD784BnaYF9nTzZiHjXAtAER8R1ay96O/Q+X1O2Vck3EtD/MaAHbJ1TNsLOV619IfyA1+scud2I+SkfA8gzHWo5mDf24AHUaLYdMi4Z/2K39LhQHF4EkcxkgXvG7IPDiY7zAHBAkp6WBBO1DdIabmsyiEHWiB8OLVvyVekzdvhi0sdbzplib+nBJ0fLYE/LNVFCJ56xQyJe7fTeeExet2r0z9rTJ3lcdIrIPuOU8nOMaT2bKsmi99GnxnNzqGbbZRM0a0oVWzwIEM9iyeN/IVbfmHwt2lFk4fwSkDo7akisXETtqCubTihGvzQj3onj1b38QjeDJjd3Hj4mmnIa58iigU78YqjpqoDN8hp4XfPuSoL2hyRdFWRWpxR1SfaSGkNtYaaknSZlHqHoG/EUSU7R0AKyI+sha09g4kaulhYJjpwWDlx9avfF6wrg+J+6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(39840400004)(136003)(346002)(396003)(366004)(54906003)(110136005)(2906002)(316002)(4326008)(8936002)(8676002)(5660300002)(26005)(7696005)(33656002)(6506007)(64756008)(478600001)(66446008)(53546011)(71200400001)(66946007)(9686003)(55016002)(66556008)(66476007)(76116006)(186003)(83380400001)(86362001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bivM9qp+PYdFpb1bFSmn/byjluV0sgepsOF47Z6Uj8Wy1senvCUyCjVSU5HB?=
 =?us-ascii?Q?66XW4jOCFRwPJiqsLSWqc+feg/mBjNgKlGN9yZiu5yhrCH3s3cirW8qiZcnj?=
 =?us-ascii?Q?i8lcHzf9W8gDmncRvYsJXQSlZPQ55II1NU9gjtSIBY6RPDZEJ9DeaObJXnVX?=
 =?us-ascii?Q?IixXWSeVNkwZE6YhjNbCyeA4WOPza0KhqFWMp1HvZIARUXKvIWfzwVD/Au9u?=
 =?us-ascii?Q?uP2YRh9XwrFBIpBmVYpnzFzwIA36faY5lJTfFSxDbKrSzTc0jBXLsB6f/ByX?=
 =?us-ascii?Q?a2Ah4MLkxixg06EZDvS+lzAfWv/5LUWQsnwXliwV1teLgZTiPPBx1CawNM85?=
 =?us-ascii?Q?u0iROfUQNnDmUcqr3VfydfTqXZn1YYY2WKkRbghFgjuNYdHbF7JHgWDFE33Q?=
 =?us-ascii?Q?82BMHRkwTY4DAqOttSmHj5KQsetYtT+F+VwdcfyAtaKJzGIOG7Ts1asqa5sK?=
 =?us-ascii?Q?LgGfKZ28SL9wNqdBkVSKosRa7W2D+LwUhLRxMU7mvAhTX5VDbmXF3oSBIW6/?=
 =?us-ascii?Q?9rgII8RSLNVjdit4mLxMJsbzzxwkYVh4o2Tgn2+Qx16s3DUafis6gkSVGw8n?=
 =?us-ascii?Q?0r8WBLKBOYeehUVkKkwHxl7GIQNIMjre7alQPQw5SVEiKTRf9rgn4W41hyYz?=
 =?us-ascii?Q?rKBVz+01rBLdjc01MTnWv0X3TiqpBVfHSDncJ1KPaOFGzmCyy8QrHi1of+u1?=
 =?us-ascii?Q?pA5cqAzqrAsKyrESHFSG8HgKN3OxyDZlPf5GvjRQlAalfHla+h0O2ZLLEuFl?=
 =?us-ascii?Q?sbVO/HV/K/gm0ep5p5oK//C/Eg13ZqJ1HOC6H+dnY9Ars2NFtXCTjnAsc43R?=
 =?us-ascii?Q?uEAxx1BDKX9/70WuhmFfq1dgmeKmQazXYgalWugMG63gC/U+W+nvqIgNv1hg?=
 =?us-ascii?Q?0YanpHZIHDnhTgDrWVbuRtkLNfBbIpXJTomildyKHKPjt+HADW+9Fblee9E8?=
 =?us-ascii?Q?gNnBUjE+snOUICadUE4RjgHcMRc1OSd8MvXfpXqSjdfR0kg9Aa8yTbi3kl66?=
 =?us-ascii?Q?h3vMY6kSF0Jni13Nv7rc9IpMnP3Y65ObV7/t4ncgmWlLeRx0z1E1LiPeQnS8?=
 =?us-ascii?Q?r2JStw9U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b161b4c-cc79-4e60-d580-08d8c9273fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 16:09:28.3724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fNFSn1CuWoIpyisANkVcNXS3dGm1Bt5u9e1Cht6mBgz3xJNDEYDPGIhtVT2pMl5fVHASaFBIlBR1yilVwvnBzBbIuU5m975ZeHHUTLG14Zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3817
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 February 2021 15:52, Mark Jonas wrote:

> From: Hubert Streidl <hubert.streidl@de.bosch.com>
>=20
> By default the PMIC DA9063 2-wire interface is SMBus compliant. This
> means the PMIC will automatically reset the interface when the clock
> signal ceases for more than the SMBus timeout of 35 ms.
>=20
> If the I2C driver / device is not capable of creating atomic I2C
> transactions, a context change can cause a ceasing of the clock signal.
> This can happen if for example a real-time thread is scheduled. Then
> the DA9063 in SMBus mode will reset the 2-wire interface. Subsequently
> a write message could end up in the wrong register. This could cause
> unpredictable system behavior.
>=20
> The DA9063 PMIC also supports an I2C compliant mode for the 2-wire
> interface. This mode does not reset the interface when the clock
> signal ceases. Thus the problem depicted above does not occur.
>=20
> This patch tests for the bus functionality "I2C_FUNC_I2C". It can
> reasonably be assumed that the bus cannot obey SMBus timings if
> this functionality is set. SMBus commands most probably are emulated
> in this case which is prone to the latency issue described above.
>=20
> This patch enables the I2C bus mode if I2C_FUNC_I2C is set or
> otherwise enables the SMBus mode for a native SMBus controller
> which doesn't have I2C_FUNC_I2C set.
>=20
> Signed-off-by: Hubert Streidl <hubert.streidl@de.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> ---
> Changes in v2:
>   - Implement proposal by Adam Thomson and Wolfram Sang to check for
>     functionality I2C_FUNC_I2C instead of introducing a new DT property.
>=20
>  drivers/mfd/da9063-i2c.c             | 15 +++++++++++++++
>  include/linux/mfd/da9063/registers.h |  3 +++
>  2 files changed, 18 insertions(+)
>=20
> diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
> index 3781d0bb7786..a2245253f039 100644
> --- a/drivers/mfd/da9063-i2c.c
> +++ b/drivers/mfd/da9063-i2c.c
> @@ -355,6 +355,7 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
>  			    const struct i2c_device_id *id)
>  {
>  	struct da9063 *da9063;
> +	unsigned int busmode;
>  	int ret;
>=20
>  	da9063 =3D devm_kzalloc(&i2c->dev, sizeof(struct da9063), GFP_KERNEL);
> @@ -442,6 +443,20 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
>  		return ret;
>  	}
>=20
> +	if (i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C)) {
> +		dev_info(da9063->dev, "I2C mode");
> +		busmode =3D 0;
> +	} else {
> +		dev_info(da9063->dev, "SMBus mode");
> +		busmode =3D 1;

I think this should be 'DA9063_TWOWIRE_TO' rather than '1' otherwise I thin=
k
you'll be setting 0 still here as it doesn't match up with the mask.

> +	}
> +	ret =3D regmap_update_bits(da9063->regmap, DA9063_REG_CONFIG_J,
> +		DA9063_TWOWIRE_TO, busmode);
> +	if (ret < 0) {
> +		dev_err(da9063->dev, "Failed to set 2-wire bus mode.\n");
> +		return -EIO;
> +	}
> +
>  	return da9063_device_init(da9063, i2c->irq);
>  }
>=20
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

