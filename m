Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C4F3BE516
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhGGJI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:08:27 -0400
Received: from mail-am6eur05on2040.outbound.protection.outlook.com ([40.107.22.40]:23521
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230219AbhGGJI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:08:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9zooMxkRJ6w4JWJ0CwPqr9+uCmpKyAh3MgE+N2uvnNoJOkHI3SyzXvB1ll+fZS6XBY4i7F4fKuk+58Onuokh/iRa1SI1QFSqMQNlhpzodiP7KbWEHm7wsRgHGWI0rCMf4MttE9iv74sIb1OyC0CfzTSy1sK4Y+R5RFZZ1mbwDOY0CqNoiMC23cF+ZNKrddynNve1dpaicKurXEXU/qKkPoSPFWjxEgr/YsRIltC/eW4/61DuOW43ou51E/0nqxNJGL1mlwzhTLcPPDxKIMJYQlKSpPs/Ug3Vh/cW++zcL7GMYvpwrngGXlfQ5AqFQv+HCOq7PJhMbS2S6Qv6vOBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBVIxkfScnge6SYKFGc6MLMSipP2rQVV8iGZCoDNGYo=;
 b=AqnWh0+jOt5xVGli4V78ASxYnYhyaqPnHYIkM7wRiZXDrzndZm3k/cHAPQcPAd3HhNRZJV5c2UGeipBmIOUYhR9zRtTtF3DlFg8wxzLRj23/5pu3BEyJvL6ThpIQC4jgle3QvELwJKYsJu6ZHwiCUDqqTRBoywnKDe6SX0o94l1y1LLbfJBoJND1S4R4CZQD0UIwA7KOG1FifrgYtWtXX+5zRkgiCs5aKptWqdVYcFqFb+CFGq14Qu8ixaAbVcuiZGEWUMb1DSlqFLo+naenydmHbLIDxetZG5vJq1tnamWQEV/TXcVM68O1ZgDsC7t2vrvUp91Vq4gwPBbK6p2f0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBVIxkfScnge6SYKFGc6MLMSipP2rQVV8iGZCoDNGYo=;
 b=guXE5C29z5eHQgev4jshoP4MkzDosz1/R1d1VBL1yL96/ew8HDnZSIsyO8GRItV3WWm5RLYm3vO8TyrOXTZbQyql5eocCsQvxsZ6UdPhYz3oKvbbCRg7RCO2jfhJkb/8IFQbvi7bCltPQd5NFdZ+eRRHWbBkaLttnbJS6oPgmjo=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB8PR10MB3848.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:160::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Wed, 7 Jul
 2021 09:05:44 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec61:e9c8:51d1:a30c]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec61:e9c8:51d1:a30c%7]) with mapi id 15.20.4264.026; Wed, 7 Jul 2021
 09:05:44 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Vincent Pelletier <plr.vincent@gmail.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] regulator: da9063: Add support for full-current mode.
Thread-Topic: [PATCH v4] regulator: da9063: Add support for full-current mode.
Thread-Index: AQHXcaBxHyZkftvM6E2VSdLye2tZ6as3OumA
Date:   Wed, 7 Jul 2021 09:05:44 +0000
Message-ID: <DB9PR10MB4652D92830AEC1D63B4ECBB7801A9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <58a4ef0f70b227a5da820ea51c7b3b60fa453b1e.1625490856.git.plr.vincent@gmail.com>
In-Reply-To: <58a4ef0f70b227a5da820ea51c7b3b60fa453b1e.1625490856.git.plr.vincent@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ced064f-b5bc-443c-fd8a-08d9412666fe
x-ms-traffictypediagnostic: DB8PR10MB3848:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB3848DD9FA916F1D810A309D5A71A9@DB8PR10MB3848.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BeecluKh/TlLvv29I2fO8FLl3lXzmoh6/yMFVwTzW0HRiPtlLqYriVLhPuM9jQgbGs8KVkRqG9xMIXLy8t7plH07HkZC0pWu8CRlU6z5MMExXJ/a2/mmd43U8k6ds+Ffz8tOXC19f5UkTxVEo/udwLqTYiU7JLnQt9sfUiUyAcOG0LlXuPwRGrWhJUG2+ImA9TCA3yp4xVVZY04ijHXCTV1aqTWQjYrYv+p4bQHZqs9rB9XbKNEdz8tPCthMdDt/URAz4aYu5Q/Hw4Ui7/UuMa16qPGoqzeCH2gzkFngGxV6Y1kL57prg0WqFleT+ryV3DpICYVkWr+/KuQ9W+Nchf2fTTWQ0ehKcL5nPNHRTbInj+iaEs895LYGa5/XTvg7vv+owrN2RPrY6/RPTT5ahK8RWdn2bR+MmpbLsgxGYkWgvUyL+VVDw29BPIKqL6tE5Ewk98RpymkWFZ39++ZMbzrk3/qsig22JAtMvJAz8N49ysaVEEhj8kemj4OcP+EeuV4Rz0N/+DrkWD6McoHbWYpbBDVip54pdxIQBtJBHesU2acQyxO9BDVY55Dv/ew38d5j476TZowsORFf0uJwNDxQfMvy4bBJTVlWA52+Mdm8KF/m801MZPsxrDh04kgATHVnRJ86Y1dXGTfVQo45kC56HO1qV7iSb6bIkbDqHVQedgDg0lv8R/07sRGV8BwEkd4qCv6JIFdXksZp/cubBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(39850400004)(346002)(396003)(7696005)(6506007)(53546011)(33656002)(186003)(110136005)(55016002)(66476007)(86362001)(83380400001)(52536014)(5660300002)(71200400001)(9686003)(316002)(66946007)(2906002)(26005)(66556008)(76116006)(8936002)(8676002)(122000001)(38100700002)(64756008)(478600001)(66446008)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3/yXcNA9zwkkzfA3SSY8qRoAMZj+Edwu1VC87p1u539BMNaXz/YUJVdBgo4I?=
 =?us-ascii?Q?86bovCGsi7xLO+CzLa5y1S9327a14K8dhFC6RcS83pk5aE4PHWjZpI+kEThp?=
 =?us-ascii?Q?1lh2P3dgWZ9jRp26gU8/AUTblV+GpcR7ZRbsaaP0Wb+2r2r5r4NhQLrxRM76?=
 =?us-ascii?Q?ylbzK08iAoeJ7LOLN+FS2JQs8TRVldu0DNfy0sU8Ly4qISr6mtpIBFRsnRg3?=
 =?us-ascii?Q?sroozaqWS+t6WB21uRZXc6UyPnNFokDDKvGQV8BDbV1YZVPkrMlp9o8kaWy0?=
 =?us-ascii?Q?CN9PWKDzaSYNVFa+U+e8fosUI90D3+UXE40KGkafp9mOV4sM2sRa0FR7t+7H?=
 =?us-ascii?Q?2zqdT5qIAy3Pe5KdjJKGn0rhTxaXHVS9cbEcMD125LHSXwUwJOSOcXxniMi8?=
 =?us-ascii?Q?eiz06bvpgT0mai3ypKxaQgQIApF1nwFN7QQABTf3rKn6tJzZm//OGxIjqFU1?=
 =?us-ascii?Q?6aeVqH+N9hXa9PxghCXcLqE3DoP8lNN/LPLAeawX3WYZmt8W7BeJIlpSOtlG?=
 =?us-ascii?Q?ZiEAirn5mhxYZmWaRTu/LvKqZaPorhL5iy3Z+jOmEioJCidxZ5rDvi598nFG?=
 =?us-ascii?Q?LqM+Ofsh7kzIgXTvIElfe97PHC5BJ8qhOziRNcWk4ifGAAx1XtmhIXuP6oAA?=
 =?us-ascii?Q?+/9P+veEFzbxIC/O+Uym6FCtNuPImtZEFCcnvP2u3mfuztE1Lc6TA38tLy/c?=
 =?us-ascii?Q?iqqQfan7Bh4smh+LS/ntKj2LTh0343IWf42NYdYgW9syjHlXxPR+iihm5VNG?=
 =?us-ascii?Q?fK5DwzDzRrDhAK5ymPvq5XBs2+hbJ24yvpHRX5rWrQeC1Fa3HLNeP4vzhN7A?=
 =?us-ascii?Q?GxqTZuA2Lsbv8IJSVxcaBelNfTKU5Qar4VayRmFe6th/Wl4oOUn8nbgA4ORb?=
 =?us-ascii?Q?+jYUuhd/qyCooMiuec2ItEbfrMRzXwoaBwqvT6iVNhFsa8neQWnOZQEe5AYU?=
 =?us-ascii?Q?TlW4XdyhGhPjCZ9l9M0MFBjohQpyZ7Np/o8XIhNsh8twPVOvWXNGUIJdD2Au?=
 =?us-ascii?Q?i8XAD8exxIVu/TF9zlBZ+Vuj4YRZSwBUTordOEvX9Fz1eoUqwD20h7E/YK9z?=
 =?us-ascii?Q?22Nol/78XCZo1H5WElg69PkCiw/GQ/eOLy2XHMSEXQuhYK/ibQdbnxuOq45k?=
 =?us-ascii?Q?718FToAHVROt4GBdFpo1kGpTwkkJHxNBBzyXQBjGS2iqVE3909Zu78hloXiu?=
 =?us-ascii?Q?MNvhQMU/Mh+nupBB7NwzY5KJc8lZKshQfnRj65OdMnz7Tz2nFlsBo+4Mnkiw?=
 =?us-ascii?Q?mNoGnBefI0SNV88YbuICznpDA9bUSOUWnHDzDGQ4W/X2Hfm6pRBIHp+dw5/w?=
 =?us-ascii?Q?071S892ymUpT2Jk4BrKb4bIp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ced064f-b5bc-443c-fd8a-08d9412666fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 09:05:44.1438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YuyBmteaTwOiUJbVV2UmkmjHOfZTdAc1rb7eJUP1a0+GakHXOmclgDxDrqZbnfxCMzbdBXZjget3/pU4g7JBpXUUzCFSI3wx7gzXpwihbfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3848
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 July 2021 14:20, Vincent Pelletier wrote:

> In addition to the ability of merging some power outputs, this chip has
> an overdrive mode.
> BCORE1, BCORE2 and BPRO have this ability, in which case the legal
> current draw is increased from 2 amps to 2.5 amps (at the expense of
> a quiescent current increase), and the configurable current limits
> are doubled.
> If a current higher than maximum half-current mode is requested, enable
> overdrive, and scale the current limit down.
> Symetrically, scale the current limit up when querying a overdrive-enable=
d
> regulator.
>=20
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> ---
> V3 -> V4:
> - complete logic change: my original approach was backwards: the driver
>   should take full control the overdrive bit, and not depend on the state
>   it find the hardware in.
> V2 -> V3:
> - ACTUALLY skip DA9063_ID_BCORES_MERGED_OD when not full-current, and
>   vice-versa.
> - head put in brown paper bag
> V1 -> V2:
> - skip DA9063_ID_BCORES_MERGED_OD when not full-current, and vice-versa
> - cc linux-kernel ML
> - fix subject prefix
>=20
>=20
>  drivers/regulator/da9063-regulator.c | 75 +++++++++++++++++++++++++++-
>  1 file changed, 73 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9=
063-
> regulator.c
> index cf7d5341750e..4be7cfd06cd4 100644
> --- a/drivers/regulator/da9063-regulator.c
> +++ b/drivers/regulator/da9063-regulator.c
> @@ -412,6 +412,77 @@ static int da9063_ldo_set_suspend_mode(struct
> regulator_dev *rdev,
>  	return regmap_field_write(regl->suspend_sleep, val);
>  }
>=20
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
> +static int da9063_buck_set_current_limit(struct regulator_dev *rdev,
> +					 int min_uA, int max_uA)
> +{
> +	struct da9063_regulator *regl =3D rdev_get_drvdata(rdev);
> +	unsigned int mask, n_currents;
> +	int ret, overdrive;
> +	bool overdrive_changed =3D false;
> +
> +	mask =3D da9063_get_overdrive_mask(rdev->desc);
> +	if (mask) {
> +		n_currents =3D rdev->desc->n_current_limits;
> +		if (n_currents =3D=3D 0)
> +			return -EINVAL;
> +		if (max_uA > rdev->desc->curr_table[n_currents - 1]) {
> +			overdrive =3D mask;
> +			min_uA /=3D 2; // XXX: rounding ?
> +			max_uA /=3D 2;
> +		} else {
> +			overdrive =3D 0;
> +		}
> +		ret =3D regmap_update_bits_check(regl->hw->regmap,
> +					       DA9063_REG_CONFIG_H, mask,
> +					       overdrive, &overdrive_changed);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	ret =3D regulator_set_current_limit_regmap(rdev, min_uA, max_uA);
> +	if (ret < 0 && overdrive_changed)
> +		/* attempt to restore original overdrive state, ignore failure-
> +		 * on-failure
> +		 */
> +		regmap_update_bits(regl->hw->regmap,
> DA9063_REG_CONFIG_H,
> +				   mask, ~overdrive);
> +	return ret;
> +}

Thinking about this further, the one concern I have here is stepping down t=
he
current limit. If we just set the OD bit first before setting the current l=
imit,
say we were running at 3A in OD and we wanted to drop to 1.8A which falls i=
n to
the lower range, setting OD bit first would set us to 1.5A before we then s=
tep
up to 1.8A again with the call to regulator_set_current_limit_regmap(). We
could in theory starve whatever is being supplied. Might need to set curren=
t
limit higher first before then setting the OD bit to halve it in that case =
so
we don't undershoot the current limit.

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
> @@ -419,8 +490,8 @@ static const struct regulator_ops da9063_buck_ops =3D=
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

