Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D698B38C7B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhEUNUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:20:37 -0400
Received: from mail-mw2nam12on2061.outbound.protection.outlook.com ([40.107.244.61]:30203
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233394AbhEUNUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:20:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A11MCrAh6AEN/GFvX3yd49fDoLWqw8WjAkmpnj+U9pSa0e3t9JwH0x4w33HUquTwsGepzT1tBT1sT61RRhoyoOVsI8R4lbVYYV7AMqQHJl7xQ2tqGEJwpTwpnW35N2zWBQnwHmQ8Glx0ZMLUobVVbOAfhVQi6VY776W/0o4IJ1LWBcUaWSDoWn5fZjTZyaYx2a2A2K3Ow457GM3HfRKx4P3iLmYdw0SuAMo4yLExAW7Mj5r8Plok2T6bnBoPDoQNnK2svZCAUrtoh1ajpI/0cI63y/ktV48CmKpbsjsYKyVV5L5YfGiEbGMYn0bH47eZwpkJGQIPrQfnIu42e1kLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krBc2RlBUKIIx1K+ckzeGswy4vLHS+XiiBkI7EdDorM=;
 b=DtY1bHLzRCdIs3adNktXKRgWKz4HwgG+tOqBEolp1o49GFyDarGjHpvyXs33S2i/aZgaCgM2UrF7HbIge7dWu4BHqLa9I0T2GfuVaIou2mWrBe1gBthIiZK4KQx3J7GdpTjyNrL3zDHZnKnqSmL3+0Hznra7nJFdNrVDkJkmH5dpeYNGAUCuS7TJBRMe55lT1R/9BWMBl6sXRRDCTpSDQuRM8wD5K117SoYojBM5m1PvJWS0/BN3jb7OcOsQYF0t2UPhcbpvjVyMKQmrn6wOSU3VfrgBrlcoAMD8Nn+c97gxBoUZWPF7tJogIlZsvBfr+ysbnBRy9BzUNOv5qmk62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krBc2RlBUKIIx1K+ckzeGswy4vLHS+XiiBkI7EdDorM=;
 b=RpfxwL2z3scLWJvtHNrnHMZ66xM8APo6AipzHgvLyaTD426jUR4bytTdDHfyCf57i0uF62uD/JW1iuS408BqbJmPnMb0Tl2jCc8C/xyYic4GL3yMdl4kyJQoHJaD4jXWP+FWUV1cVAXeDrecV3KKu9OjT3wqQ0elqRKlYUHmSlwwy++C8m5Z9p65F7FIKYGLfxdHc8gG3L4Vkr6y9iFl/dOwr6eu/dbovN52Mo1HJLs8JOwQipHCj+9djVm9eolVetmK+hqgXG8Fkw+Yf2WRSQOQTsf76BGGu8UWcrOtdIRDaS0IkmamBkZa24R5GFrngCLwlb2Gu48UBw+DOCJdkg==
Received: from BN0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:408:ee::31)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 13:19:01 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::ac) by BN0PR04CA0026.outlook.office365.com
 (2603:10b6:408:ee::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Fri, 21 May 2021 13:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 13:19:00 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 21 May
 2021 13:19:00 +0000
Date:   Fri, 21 May 2021 15:20:23 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 3/3] Revert "usb: common: usb-conn-gpio: Make VBUS
 supply optional"
Message-ID: <YKezl0nlWFQhLyf/@orome.fritz.box>
References: <1621406386-18838-1-git-send-email-chunfeng.yun@mediatek.com>
 <1621406386-18838-3-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kQXU9/aA1QNb88Xm"
Content-Disposition: inline
In-Reply-To: <1621406386-18838-3-git-send-email-chunfeng.yun@mediatek.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d545a81b-5827-46a5-bbed-08d91c5aff8f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4370:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4370025E165D648DDC7A80EACF299@DM6PR12MB4370.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+gcJ3lctOIJ9MdI0H+voWnRTHM5sj9Ca+4ooNYQx0tfVXINN3WelIrYMy5IDRuVOp1kBcBEbCQ0C6/V//IBzKKcfp8Yjc8/Ri2TzuwIHvZPnasVGEwJ15JTPUFeWxVPjPN7Nczy1Q8LakKGqwx73xdI8/44kUVCNkDtnHX7YkBHqx7BrAhK1c36RjCSmZ6Yd8ynLGqOBfwA+ODp1mzy2Kcy+WPOMPZm1Vjx/W04oSJ5GprLX3uel4PJ0k4UEnXEFpy+TtFaJR8+XO4bD3GbAIeC+petVki4a+GJLJxeXN0LczocTcIrLxljNbNFNaNoTHXko1ktW/ERbKHxA5FFHS8oOeO/qNzY02goufr/0NzSttX/o8L7O2R/ucm/BD/XZrWxo6P4gRf11gghE3uPeb7TyPk41B6Y9KZ0re1LIjUwSZGekDdFBHrafFGNj7whALIsVCulyPsHCgPJfXm6JooUWo5mKZB5dC1sceQV+laID6D/GVQarvo54b0rbuAR6fTiKVfP69c7urkhn7v3kPgQAxK5Pevpl720lP72LqqDHDt4blUbbCKtkR0SlgsFSuSn3gemhms80Ihj6spieabx0OvOjCekTAtj4XhssBMZRxAIea8XoGKTLS4og0xootJnwP6Pu9x45YRs3t+NU1QOQ+QyqgzWOtjghXrmYiC1XMvukL1owhO5sWrTxqXU
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(36840700001)(46966006)(16526019)(8676002)(356005)(6666004)(2906002)(70206006)(70586007)(478600001)(26005)(426003)(5660300002)(186003)(8936002)(86362001)(336012)(7636003)(47076005)(6916009)(9686003)(7416002)(36906005)(36860700001)(21480400003)(82310400003)(316002)(4326008)(44144004)(83380400001)(54906003)(82740400003)(2700100001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 13:19:00.8001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d545a81b-5827-46a5-bbed-08d91c5aff8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--kQXU9/aA1QNb88Xm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 19, 2021 at 02:39:46PM +0800, Chunfeng Yun wrote:
> Vbus is already an optional supply, if the vbus-supply is not
> provided in DTS, will use a dummy regulator,

That statement is not entirely correct. The dummy regulator is
substituted only if the supply is in fact not optional. The idea behind
that is to allow DTS files that don't specify all required regulators to
get away with it, based on the assumption that the supply is one of
those always-on supplies that are often not described in DTS.

> the warning log is as below:
> "supply vbus not found, using dummy regulator"

And the reason why we get that warning is to point out that the DTS has
a bug and that it should be fixed (by adding a proper regulator to take
the place of the dummy).

> This reverts commit 4ddf1ac79e5f082451cd549283d2eb7559ab6ca9.

But if you read the description of that commit, the purpose of that
patch was in fact to make the supply completely optional in the case
where we already have the VBUS supply specified for the USB port that
the connector is parented to.

So in that case the DTS doesn't have the bug because the VBUS supply is
already specified for the USB port and therefore it doesn't have to be
specified in the USB connector again. In fact, specifying it twice can
lead to a situation where the USB port may not be able to switch the
VBUS supply on or off because the setting might conflict with that of
the USB connector.

So unless there's a real reason why this is needed, I don't think this
should be applied.

Thierry

> Cc: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: remove unused variable "need_vbus"
> ---
>  drivers/usb/common/usb-conn-gpio.c | 30 ++++++------------------------
>  1 file changed, 6 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-=
conn-gpio.c
> index dfbbc4f51ed6..65d89140cd19 100644
> --- a/drivers/usb/common/usb-conn-gpio.c
> +++ b/drivers/usb/common/usb-conn-gpio.c
> @@ -91,14 +91,14 @@ static void usb_conn_detect_cable(struct work_struct =
*work)
>  		return;
>  	}
> =20
> -	if (info->last_role =3D=3D USB_ROLE_HOST && info->vbus)
> +	if (info->last_role =3D=3D USB_ROLE_HOST)
>  		regulator_disable(info->vbus);
> =20
>  	ret =3D usb_role_switch_set_role(info->role_sw, role);
>  	if (ret)
>  		dev_err(info->dev, "failed to set role: %d\n", ret);
> =20
> -	if (role =3D=3D USB_ROLE_HOST && info->vbus) {
> +	if (role =3D=3D USB_ROLE_HOST) {
>  		ret =3D regulator_enable(info->vbus);
>  		if (ret)
>  			dev_err(info->dev, "enable vbus regulator failed\n");
> @@ -106,9 +106,8 @@ static void usb_conn_detect_cable(struct work_struct =
*work)
> =20
>  	info->last_role =3D role;
> =20
> -	if (info->vbus)
> -		dev_dbg(info->dev, "vbus regulator is %s\n",
> -			regulator_is_enabled(info->vbus) ? "enabled" : "disabled");
> +	dev_dbg(info->dev, "vbus regulator is %s\n",
> +		regulator_is_enabled(info->vbus) ? "enabled" : "disabled");
> =20
>  	power_supply_changed(info->charger);
>  }
> @@ -175,7 +174,6 @@ static int usb_conn_probe(struct platform_device *pde=
v)
>  {
>  	struct device *dev =3D &pdev->dev;
>  	struct usb_conn_info *info;
> -	bool need_vbus =3D true;
>  	int ret =3D 0;
> =20
>  	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> @@ -205,23 +203,7 @@ static int usb_conn_probe(struct platform_device *pd=
ev)
> =20
>  	INIT_DELAYED_WORK(&info->dw_det, usb_conn_detect_cable);
> =20
> -	/*
> -	 * If the USB connector is a child of a USB port and that port already =
provides the VBUS
> -	 * supply, there's no need for the USB connector to provide it again.
> -	 */
> -	if (dev->parent && dev->parent->of_node) {
> -		if (of_find_property(dev->parent->of_node, "vbus-supply", NULL))
> -			need_vbus =3D false;
> -	}
> -
> -	if (!need_vbus) {
> -		info->vbus =3D devm_regulator_get_optional(dev, "vbus");
> -		if (PTR_ERR(info->vbus) =3D=3D -ENODEV)
> -			info->vbus =3D NULL;
> -	} else {
> -		info->vbus =3D devm_regulator_get(dev, "vbus");
> -	}
> -
> +	info->vbus =3D devm_regulator_get(dev, "vbus");
>  	if (IS_ERR(info->vbus)) {
>  		ret =3D PTR_ERR(info->vbus);
>  		return dev_err_probe(dev, ret, "failed to get vbus :%d\n", ret);
> @@ -288,7 +270,7 @@ static int usb_conn_remove(struct platform_device *pd=
ev)
> =20
>  	cancel_delayed_work_sync(&info->dw_det);
> =20
> -	if (info->last_role =3D=3D USB_ROLE_HOST && info->vbus)
> +	if (info->last_role =3D=3D USB_ROLE_HOST)
>  		regulator_disable(info->vbus);
> =20
>  	usb_role_switch_put(info->role_sw);
> --=20
> 2.18.0
>=20

--kQXU9/aA1QNb88Xm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCns5UACgkQ3SOs138+
s6Fq/xAAv63EPKwniK/lIdbUsG5t8rk8ZYgR1AtNxsz0TAPCycoc29luOzcWm2q6
mKhBG1LFeRZp9KQxLvdqreMs4bieRZzuMIJQ7UPvb4yBz2KKPnkQTmxh1JCRUX3t
RieuG15mTmC8RHME3nU6GSXsGHWavKkvzeIIWXSJbO+/EZbbG3XhUPPQ451wPkcL
DXRfCzVKOcur4e0Y2dxmL8P9qlMOqz+hGiBU4GYGIau4lJ5uoarR05LSe+kxTQum
5Kd+w6c8/74YS6R5xan1O/HB314fQs+6/ZeghceMVbo4rdlcKlMVNlQee5oRFwAH
EA038vdd3qmaFCoxgJn/KMntSBrrpYwL3nkeE/3CAp4yIq/DsgJmQ/t1oX9bA6Im
yMHnReLkzPCaW5UqLmE8de6EZk2lAvnsRTO26q7VCZMkDLco6kjYbXN9zJVXWHLg
J3gaFXAXd5j+auni7BLKfekZ5shX83RNZmYXBk5Getsw6qrNEcJ52kCNYDVCT2RM
A9utCz41kwzeImRSbbSUmNcPy9oo3gonEorh3uW3BWr0f84Iy0HWesWiDm1v3O91
l+wGC2yDLNSWzUByJinqXAB3zpaEOCdS3W29AY+Fz79CRPs2lRlpy1UPxyY1FOhq
sTgIAeeGWrD63eRbJIs2UMFu//Sx0IXTCLbSpad3fz8Co/k694w=
=A/ZV
-----END PGP SIGNATURE-----

--kQXU9/aA1QNb88Xm--
