Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3102C3C5AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhGLKp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:45:26 -0400
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:26546
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233692AbhGLKpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:45:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bipnlK0MiBzoiArpTWyLzSqw/NWAQBTFimZFra386AkEFuToVeNmYcmpxcbrhtOYEu46TxeZk2Wqxg5fZLIkZZVaf8WCJe03nUn+X5tDoFSXVojs74+jbu/fjXf87YeKd+NeHtZ0oKZFVL9OLW76sbwXOw1amlgBugUq7uRdVPQByTkB4RQLBShN0Id0e5cuq2FjLoAfl4unRmS/7rTHpgY+FjcKrJamg+ZUVS6Nc2FciamusVIVYCuXeT3fcIkczU7mf92LGFb5SFk978qWFjSIVO+iLdCyV6syC1Bxx3RaMKphsCBDO/GNiKgwWAuqsUTDuVSGEjjC50GLhQeFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usiXhnyFQtxHVH+Gv3N/uXmX3t3N4GsR4Wr3i9xbjv8=;
 b=cmFKi4qd+wrdjxXYG0wcERadK9IzoJVE+4uzuC6PJuPLc5FfqO5kYZ2wvTmpok3K2I6c3iz6JF29GIGV69CHU1H6ntrNMa2xtISzsL/TL3mL40T2cWD9ONDRxoHvZXof8rr+OcSsqSQq6LHZorTPVHuX7uW4UwH/Dm7d0UXOrcEsjqAjyPnDt63B4KnHyN7iOkp5AwN4BJAibjf9CYicPSd84YBW4bNdBb6ANj0k6snNCm40lRr36cm0zEATjSEUg1VN30fmbC+ERaQEkvZgg+H/5rNWA4T+dWmi9mZic76FgEWJdhRiXXYllAWhxQFNpMCbYPpC1p3vX1j7SZT/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usiXhnyFQtxHVH+Gv3N/uXmX3t3N4GsR4Wr3i9xbjv8=;
 b=iIhmxZ86H7hq9wGsa/IcSFgZKvDFrsn3rnKtJ/Z68PNKZwB4MjRJwF+TLwXjoUW3ulNtFlYehB9NVJE+zpTwSnP675lRwiBx7YWDUUo56S5GOVG7JThXsu1CNWbjZFfzNa3+8/z1kQVc23nAkuaeMRdA/TR8BuyhhJBG/YzWg7U=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB8PR10MB3831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Mon, 12 Jul
 2021 10:42:26 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2832:8aec:2f16:aed5]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2832:8aec:2f16:aed5%7]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 10:42:26 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Vincent Pelletier <plr.vincent@gmail.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5] regulator: da9063: Add support for full-current mode.
Thread-Topic: [PATCH v5] regulator: da9063: Add support for full-current mode.
Thread-Index: AQHXc+SYZQ8Rqj3Pv0ykB/bR+DFe8qs/LTMA
Date:   Mon, 12 Jul 2021 10:42:26 +0000
Message-ID: <DB9PR10MB46522678869990E32D9F00EB80159@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <9d5decc6d5b15702d0e1039f8c9bda51d9a4d630.1625740324.git.plr.vincent@gmail.com>
In-Reply-To: <9d5decc6d5b15702d0e1039f8c9bda51d9a4d630.1625740324.git.plr.vincent@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b601630b-30c7-4538-0cde-08d94521bd94
x-ms-traffictypediagnostic: DB8PR10MB3831:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB3831038655501BBA4694FE87A7159@DB8PR10MB3831.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7spiR9cZm+N5sQjadbwh7kA2ejyNtLfMi7A2mjPzzGJruMYwB47ACmXUBqPKUFHl1f79ue4clI9iaRZDF6KNR590BIobWUSW8fvNBTOByW3mTuJtL7B0h5+vVG8mHqFadw2Zkjyhda3reEkY/kHUMc1MF7oiHmaB47UBjDjf0H0KPlDZvJEgFE36vhEj/drm4OvT70WE2/EABHB0fG0pxk8GCe5+EKqTu3WSmLGvjfZAp9Z6Kj7f8jCwDNxlmqFxef9v4nVpIr6vpYA1TC5eeY5q6Szskh3G8A3fI/J1D8hl63NppddGT1C/A7Tfhh3ISFhWG5S1K/5nCHJMLnOZ3+AbIZFDniexSJ2fn57casirfdvqyTJ596IUexfsGrMA21BIUQl6cUishrlR0wsBOpMq6J7sETbDVsZeh+jXDNn25CK+ufBaIFjR9YR+muCnSzWy7zvXe32tUqPI5xhP4W00/zNGnwdabms86AtdlfH1W1dPpL2AsoT4ORukJ5C0nzBWv1RbZ8zFL9nTIp0niAufsCK2U0us8euY5JjmvQznu13RjEWKoKPDxpsFgCJbAV/j9Y3A7Kf7RbcuM+FkcTHS/nAEOJabyWSA5K6kN3PEgC65JHoKG6l8ac4uObNzR3BkBvQx8ys9eV37RHVcn3vfvy96RNUf0CZBRfGujMCgwVGit54Li07ogpWRlvbZD5Ax/84GWpOO0R73QbUU4nGX4sZHNb01pxeHm8SNgto=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(136003)(376002)(396003)(366004)(71200400001)(66946007)(53546011)(83380400001)(52536014)(8936002)(966005)(110136005)(2906002)(33656002)(9686003)(6506007)(38100700002)(7696005)(316002)(186003)(26005)(122000001)(76116006)(64756008)(478600001)(66446008)(66476007)(5660300002)(55016002)(86362001)(8676002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KPMrdmZJ5ODu4wMZjSq3kfQxPCMRqHT7FL76t7Y5PHD5cGyLiAl26o6lpGwd?=
 =?us-ascii?Q?kJSH4W2mrZXTp7B+nwv5phhbTtQ5AizNlwciTBtS3UBYxIh7ipH0/YPX5AIg?=
 =?us-ascii?Q?CmmPUb42QxjmcOL/4B+58IDTMj9vvdief+2bA3BlWKvtJr8nkRzrd8iTtB8/?=
 =?us-ascii?Q?UDOdU7LTQ/GRVMtJ3v+1320rfcau6Hpm7/2c31/0oU7+vso1FwIuLHz/Nw7l?=
 =?us-ascii?Q?0mqotflPNCG1PU8pOXR9q2Etm60KaylvVjx6PzJHxnkPPC2jhPlR+x1wzfMq?=
 =?us-ascii?Q?yihSrkBpwfmozrxW7RsuUV847GDwc70mbLkzZl5ZyhC1tvUqdpywFmKAZpEC?=
 =?us-ascii?Q?z/wOdhYEEy3N0+mz4Xz0W5FzS8NJGQn455cI5IbJmZTiEfO3Vid7g8P2r6yx?=
 =?us-ascii?Q?VkgWSepqCYVSTFH0mfE37BCsIJ2zASpWLx8A8Tx17jEt3fzi1gas6ZVedXWy?=
 =?us-ascii?Q?O6lGNd6kqbEz/XQ6CsQdVUnc67gf7qB/XRPw+EU65YtZdgCIEb9wN5+0kDs2?=
 =?us-ascii?Q?X4momQmcwqJapRBU4eFoSoYrLrgfg9GRjj7w/PvIeYw0ZuThZIa5lNrEAivr?=
 =?us-ascii?Q?savV0XEgV9zSE2Ec8wFB+7drtvY/Z4WV2DSy5NAq5aW0s7b2K2+Sjfl+EJf8?=
 =?us-ascii?Q?2YO6zgmlC6AcB7fbjl8Gbp+6KEte0eQt5GJhwD3w9iXs7fTbAbMwotjPQUcq?=
 =?us-ascii?Q?8vdsSNOCywrMGXZMW/l1Ybql3VdgZN738MtGF7tWfKGV8Uau3mIIIPGC6rNQ?=
 =?us-ascii?Q?mqUE5eMAWSVMHemkrlKHCmuuZiMj61ZWRZfOri7BgbwOQf5by7MV8eKRY0td?=
 =?us-ascii?Q?92Su8akQJjhJOhH/XmitBVxscx1aK56MYTajdqcz5t/HptRVYpp4GsiOjzgE?=
 =?us-ascii?Q?Ku/zvgawv2ebjCNwDCRFxVI20CTMihiCxyYp8Rp+cFGePIQRqRmbz+5Q0DYt?=
 =?us-ascii?Q?SjJsYMGPFHgl28nd0jXfkbZSji1gS4W16bjIeiBNaLKMrwAyDqq0n1sWVnXv?=
 =?us-ascii?Q?wcCRIb+3rENQ19y5BeD7lxbhfNL51b8NhNbUwGsAyyMuyhbTFGahsAus3+Cn?=
 =?us-ascii?Q?+sCSN2DaEJ7gnikRQw4dWgzvQrszztw4EOk1qu8+6Gfm+sQ/2fVSBFqARt0v?=
 =?us-ascii?Q?aFxU+nBUVN/b9lsu4cjZ52Ayg5R+xF2dA9f+0KPIVCnVtDGksCNn2i3+rYID?=
 =?us-ascii?Q?NCt/zVRxSPxE74uH3SzE0Gib2Awa5+GNBVvL+rZvAh/IUYVz9+YZJ3wtjtcH?=
 =?us-ascii?Q?X9vSfN/Nq4DG9jAkzaT7iTZioLJBePnsGeI5coWlcGkocySqn7d5YzvM6JmG?=
 =?us-ascii?Q?DYfnsdJbgom6V4477HPmv9vd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b601630b-30c7-4538-0cde-08d94521bd94
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 10:42:26.5882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JRhVnvb2vw0D+tOHBXVUbn4SgICIxDW1r4P6P93PnTxe8tTeD+3HOtPKr6KgUxZsPTWHZ0ULv2mhi2E5KabUai9jeLguk+gfgXGDMpCFAXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3831
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 July 2021 11:33, Vincent Pelletier wrote:

> In addition to the ability of merging some power outputs, this chip has
> an overdrive mode.
> BCORE1, BCORE2 and BPRO have this ability, in which case the legal
> current draw is increased from 2 amps to 2.5 amps (at the expense of
> a quiescent current increase), and the configurable current limits
> are doubled.
> If a current higher than maximum half-current mode is requested, enable
> overdrive, and scale the current limit down.
> Symmetrically, scale the current limit up when querying a overdrive-enabl=
ed
> regulator.
>
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> ---
> V4 -> V5:
> - when disabling overdrive, adjust current limit first
> - remove forgotten development comment
> V3 -> V4:
> - complete logic change: my original approach was backwards: the driver
>   should take full control the overdrive bit, and not depend on the state
>   it finds the hardware in.
> V2 -> V3:
> - ACTUALLY skip DA9063_ID_BCORES_MERGED_OD when not full-current, and
>   vice-versa.
> - head put in brown paper bag
> V1 -> V2:
> - skip DA9063_ID_BCORES_MERGED_OD when not full-current, and vice-versa
> - cc linux-kernel ML
> - fix subject prefix
> ---
>  drivers/regulator/da9063-regulator.c | 115 ++++++++++++++++++++++++++-
>  1 file changed, 113 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9=
063-
> regulator.c
> index cf7d5341750e..d595f88a00fc 100644
> --- a/drivers/regulator/da9063-regulator.c
> +++ b/drivers/regulator/da9063-regulator.c
> @@ -412,6 +412,117 @@ static int da9063_ldo_set_suspend_mode(struct
> regulator_dev *rdev,
>  	return regmap_field_write(regl->suspend_sleep, val);
>  }
>
> +static unsigned int da9063_get_overdrive_mask(const struct regulator_des=
c
> *desc)
> +{
> +	switch (desc->id) {
> +	case DA9063_ID_BCORES_MERGED:
> +	case DA9063_ID_BCORE1:
> +		return DA9063_BCORE1_OD;
> +	case DA9063_ID_BCORE2:
> +		return DA9063_BCORE2_OD;
> +	case DA9063_ID_BPRO:
> +		return DA9063_BPRO_OD;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int da9063_buck_set_limit_set_overdrive(struct regulator_dev *rde=
v,
> +					       int min_uA, int max_uA,
> +					       unsigned int overdrive_mask)
> +{
> +	/* When enabling overdrive, do it before changing the current limit to
> +	 * ensure sufficient supply throughout the switch.
> +	 */

Have a look at the kernel documentation on coding style:

 https://www.kernel.org/doc/html/v4.10/process/coding-style.html

There's a general preference for multi-line comment blocks in the following
format:

 /*
  * First line
  * Second line
  */


> +	struct da9063_regulator *regl =3D rdev_get_drvdata(rdev);
> +	int ret;
> +	unsigned int orig_overdrive;
> +
> +	ret =3D regmap_read(regl->hw->regmap, DA9063_REG_CONFIG_H,
> +			  &orig_overdrive);
> +	if (ret < 0)
> +		return ret;

Newline? Code all feels clumped together IMHO and might be easier to read i=
f
it's split a little more. Also if over-drive is already set, we don't need =
to do
the following I2C transaction, or the roll-back at the end of the function.

> +	ret =3D regmap_set_bits(regl->hw->regmap, DA9063_REG_CONFIG_H,
> +			      overdrive_mask);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D regulator_set_current_limit_regmap(rdev, min_uA / 2, max_uA /
> 2);
> +	if (ret < 0)
> +		/* attempt to restore original overdrive state, ignore failure-
> +		 * on-failure
> +		 */
> +		regmap_update_bits(regl->hw->regmap,
> DA9063_REG_CONFIG_H,
> +				   overdrive_mask, orig_overdrive);

If I2C is failing here I'm not sure this is going to go through and you hav=
e
bigger problems. Not sure if it's really worth trying to roll-back at this =
point
but maybe Mark has another view. Personally I'd be tempted to just ditch th=
is
and just always set the OD bit in this function, rather than trying an roll=
-back.
Will be much simpler code.

> +	return ret;
> +}
> +
> +static int da9063_buck_set_limit_clear_overdrive(struct regulator_dev *r=
dev,
> +						 int min_uA, int max_uA,
> +						 unsigned int overdrive_mask)
> +{
> +	/* When disabling overdrive, do it after changing the current limit to
> +	 * ensure sufficient supply throughout the switch.
> +	 */
> +	struct da9063_regulator *regl =3D rdev_get_drvdata(rdev);
> +	int ret, orig_limit;
> +
> +	ret =3D regmap_read(rdev->regmap, rdev->desc->csel_reg, &orig_limit);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D regulator_set_current_limit_regmap(rdev, min_uA, max_uA);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D regmap_clear_bits(regl->hw->regmap, DA9063_REG_CONFIG_H,
> +				overdrive_mask);
> +	if (ret < 0)
> +		/* attempt to restore original current limit, ignore failure-
> +		 * on-failure
> +		 */
> +		regmap_write(rdev->regmap, rdev->desc->csel_reg, orig_limit);

Similar comments apply here.

> +	return ret;
> +}
> +
> +static int da9063_buck_set_current_limit(struct regulator_dev *rdev,
> +					 int min_uA, int max_uA)
> +{
> +	unsigned int overdrive_mask, n_currents;
> +
> +	overdrive_mask =3D da9063_get_overdrive_mask(rdev->desc);
> +	if (overdrive_mask) {
> +		n_currents =3D rdev->desc->n_current_limits;
> +		if (n_currents =3D=3D 0)
> +			return -EINVAL;
> +		if (max_uA > rdev->desc->curr_table[n_currents - 1])
> +			return da9063_buck_set_limit_set_overdrive(rdev,
> min_uA,
> +								   max_uA,
> +
> overdrive_mask);
> +		return da9063_buck_set_limit_clear_overdrive(rdev, min_uA,
> +							     max_uA,
> +							     overdrive_mask);
> +	}
> +	return regulator_set_current_limit_regmap(rdev, min_uA, max_uA);
> +}
> +
> +static int da9063_buck_get_current_limit(struct regulator_dev *rdev)
> +{
> +	struct da9063_regulator *regl =3D rdev_get_drvdata(rdev);
> +	int val, ret, limit;
> +	unsigned int mask;
> +
> +	limit =3D regulator_get_current_limit_regmap(rdev);
> +	if (limit < 0)
> +		return limit;
> +	mask =3D da9063_get_overdrive_mask(rdev->desc);
> +	if (mask) {
> +		ret =3D regmap_read(regl->hw->regmap, DA9063_REG_CONFIG_H,
> &val);
> +		if (ret < 0)
> +			return ret;
> +		if (val & mask)
> +			limit *=3D 2;
> +	}
> +	return limit;
> +}
> +
>  static const struct regulator_ops da9063_buck_ops =3D {
>  	.enable			=3D regulator_enable_regmap,
>  	.disable		=3D regulator_disable_regmap,
> @@ -419,8 +530,8 @@ static const struct regulator_ops da9063_buck_ops =3D=
 {
>  	.get_voltage_sel	=3D regulator_get_voltage_sel_regmap,
>  	.set_voltage_sel	=3D regulator_set_voltage_sel_regmap,
>  	.list_voltage		=3D regulator_list_voltage_linear,
> -	.set_current_limit	=3D regulator_set_current_limit_regmap,
> -	.get_current_limit	=3D regulator_get_current_limit_regmap,
> +	.set_current_limit	=3D da9063_buck_set_current_limit,
> +	.get_current_limit	=3D da9063_buck_get_current_limit,
>  	.set_mode		=3D da9063_buck_set_mode,
>  	.get_mode		=3D da9063_buck_get_mode,
>  	.get_status		=3D da9063_buck_get_status,
> --
> 2.32.0

