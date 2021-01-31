Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57B6309CCE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhAaOUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:20:36 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:55532 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232490AbhAaNfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 08:35:55 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10VDUbvQ000701;
        Sun, 31 Jan 2021 05:34:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=EbWhhubkpNIfN9/Jm5GXvZrsOBD8E7uKUmjm+FCy3io=;
 b=TVpVHP6VrShbr5lAF4FhEwzkpC17p4Y5DIc009Lu+bN204YrvNji4UjIkQ4LGqVZSm4l
 1UYqmF2nRnWFGNsnXh60BXph4171CW8U9zet21oln5hrp3URKI1mP4cGgAG7HdhywBkw
 H7mpdZqo5HgbIYovO15aNS4pmAAvKovzr+yTOh5NLYseW6ONKeRO1+zxW4yh2DShSc45
 QqoEjVwWypEGdjtmVSrmXIxVualST5hgV5DPP6tIHSojtC76BUr+W2yGKsBw/WVloWVm
 PmNUV3UZRRMM1zOLBS8OkagLdvq/rJBwYElkAj+L6xXInrt1yS6LgJEJi9ACXAHtlRbG Pg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 36d5psst24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 05:34:50 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 31 Jan
 2021 05:34:48 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Sun, 31 Jan 2021 05:34:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDiCKoOtmTf+TFlvbne548jv9MhDy0ZhLvFTTqLkBXsM9TTX0XbBcr2hWY1dQ3u8uS37m8Clt4fH+lNiQy7IiPgyqQEYcIqZ7LhoI4sP2ufjLay5ZRdmLrH2qeFVruLKmZxOHDBwD0fUyA8SmPyViSutHWteTebieScnzvCh+AEIi3eKufVqzd0TZ8xRCC/rF9oIHo8gVCiuX8duzVRfSjr4nCg/JUCdeA3y8IE6tsl689SRkPoOlWcJpGK9gzeJ5SUBIEKLKEs25SlsKtRh1FTF3ne/HZhl3L4qPRBFFawyGZL2oYFZBE7Mh4dBsHUWFoNqymEKe2hZD70l6AuDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbWhhubkpNIfN9/Jm5GXvZrsOBD8E7uKUmjm+FCy3io=;
 b=Hh7SphVEblGA0zzolPJmCDtNygZaR92nAoj76hUFsvfr0JuoVth07OmQo5qxSfeHRGf2lTicrH4ieZZeyNB2/9MIh18EQDV8lv4IVEUSvtmsq2YyOOookfIZfl5M2xQJJUlbJvUcs52icjHNoTaPNVuE9DnLurNWKdD3tcXRHsGfZF8v7vkObsf6mIeW9feAPbb0HbCrW4l/6x8T0QbVY9yxVtRHMnfp+tSEBC+rW22iQzihxLq2ipsQLW5Tdy0DRlchM02k7PfHYfpgTOiBKjXzP7j+01wM+zZ0Zzfei7oCUXo9a2UfOstAqFqFgXGwkJTPFkQNoTzGRvsxzPuuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbWhhubkpNIfN9/Jm5GXvZrsOBD8E7uKUmjm+FCy3io=;
 b=hl4ITUYy0SkLGwVneSN9igcFl3YRhdFx+9g1M1rwoHSxd3au/ItQ6vx3IQ/y1n2kbbfNV2NyhtvHIXsJTDin2tOO440JJDkhhUZOZVjx+DBbOB752lkOSXs9A88xdJpBLU9v4y2tcZWuKeDgXfSYgp+sgxAxwdTmgaHVdZJhhwA=
Received: from DM5PR18MB1452.namprd18.prod.outlook.com (2603:10b6:3:be::12) by
 DM6PR18MB3787.namprd18.prod.outlook.com (2603:10b6:5:16f::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.15; Sun, 31 Jan 2021 13:34:47 +0000
Received: from DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57]) by DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57%4]) with mapi id 15.20.3805.024; Sun, 31 Jan 2021
 13:34:47 +0000
From:   Kostya Porotchkin <kostap@marvell.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Nadav Haklai <nadavh@marvell.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Stefan Chulski <stefanc@marvell.com>,
        "kishon@ti.com" <kishon@ti.com>, Ben Peled <bpeled@marvell.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>
Subject: RE: [PATCH 1/4] drivers: phy: add support for Armada CP110 UTMI PHY
Thread-Topic: [PATCH 1/4] drivers: phy: add support for Armada CP110 UTMI PHY
Thread-Index: AQHW9J93B3nKRGWjs0uG+nVOGIW6zKo+WQ2AgANiheA=
Date:   Sun, 31 Jan 2021 13:34:46 +0000
Message-ID: <DM5PR18MB1452B34AC0C36693C6CE294DCAB79@DM5PR18MB1452.namprd18.prod.outlook.com>
References: <20210127112719.30632-1-kostap@marvell.com>
 <20210127112719.30632-2-kostap@marvell.com>
 <20210129092849.GA68955@demiurge.local>
In-Reply-To: <20210129092849.GA68955@demiurge.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: v3.sk; dkim=none (message not signed)
 header.d=none;v3.sk; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [77.137.153.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcb275e1-0575-4c0f-ae13-08d8c5ecfa15
x-ms-traffictypediagnostic: DM6PR18MB3787:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR18MB3787573C65F6817673DBD819CAB79@DM6PR18MB3787.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jNfE+ysWuVq/JkfQYyLiF6ZRTatfUt9aQN5VJawuHSV4fBUgEfdZCEre7XcvR2YlQjtG2XkiMK35CHPjt9A8GDZwpDa0WzgbahYSIur4raWfBlSlKZniD3kJ8x+WgW00D+dBIoF+158Ca0VOp7eW1epsok6qk+YtHqtgcnNx/73gvgLsBFiur2OE6BkIdQ1kUSLqXFPuJ0fNYutWunAfUZsqkb2SM53UtKsdBAK2Cag0VyPqesUNN7LuziR5Uu5CHSxaC2ViA7Qy+H60tQOV2dFE0eO8iltocebe/b7uxj6NToro7zWgZFsX30D/Tfz+7gKU1O0lj29EjvIw0AY/PRfZcRl0M1eJs1KxHC6Uw/wrR9X34YxAqtUn4s1Niw1EIVy4BX6fKfP7jM/zsd+mkJ9wIhf+Fa6Di+9b6yY62BYNXNgx8HiwnmGIj27UFNRCCHP4UGL63cWLaeYIAgi3fSkIVjBRHBG5ShFl0u687B0SorUddPA4AlkN77bCJVt0jcGSx0LNUQeQq6FsRbp2MLb5LmYZzO+G9AOGovbfA/2UqJqhwYEXHxzsMtXyAXnJ7rPeh1mSY1w94GhlVq66+nPgQKf8xnPVyVCBLLCyaug=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR18MB1452.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(396003)(346002)(136003)(366004)(66446008)(7696005)(66946007)(83380400001)(186003)(6916009)(8676002)(316002)(8936002)(66476007)(86362001)(55016002)(64756008)(6506007)(4326008)(71200400001)(33656002)(7416002)(26005)(5660300002)(76116006)(54906003)(52536014)(2906002)(9686003)(966005)(478600001)(66556008)(19627235002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fIGH3W2FG8z+/gnV0RttbPq3Sx24oA9piJ9pu9O+a8eoVQgADGlrdBtzcQxl?=
 =?us-ascii?Q?auV01qL/V613u6leITJIqV6TxOCJCrb8MnT2TqWTpw0oFCwqpA+1bnWTwchn?=
 =?us-ascii?Q?XQ3N84IyafuLwAPRjDEYre7VMDX5ovi5p6hNAAainSxQsrcWVt+hIlW7kOiS?=
 =?us-ascii?Q?8HgPxAGzCkOxON1gUDOi1tObM62+tl0jHJbba5RDEpRDbnLpPLa2tzT1VgDP?=
 =?us-ascii?Q?07lYG4qO6wrkeVu7vYs2vDle/BPNREuhv9tMKEvPvF3OJCA6D3AZRnXd/jX1?=
 =?us-ascii?Q?KxkAklkC5UAvlHrsm7gtxCy+LT/6MfskC0cdApe/vmOzxCNF+fsZhLW5WvBt?=
 =?us-ascii?Q?9yoV8v/Kn43C5ynqWoPI9buS/oUXqdYY+DE+cWtqO8ecG5V74K8VL7rI2C8J?=
 =?us-ascii?Q?+iR2w5RF3djtOY4u8jaz2oQnSUyXsFMfJd9eBkQHiDxBR9pq7rkj3RYOH/xh?=
 =?us-ascii?Q?aCcUeA/42IRAxXHHlsnoPaqni6VVeXJfu5G+VLuBHwZXlbntozGn5EaBVw0b?=
 =?us-ascii?Q?T38dB5kNxcTOQVSjd2aLbCBgoHrd17T16/qqXkNS4bx1Voz5ksCQYHclljbF?=
 =?us-ascii?Q?nX7tiH+NrwOhncDpL0oRdntxfmGJfb0EpGXSb8ZzoLAKEb8qqaihS5w2Baar?=
 =?us-ascii?Q?XqahKPja9c6pa0mATlAT2fhyYXTjK5tiIB6Uvgu9u6r/vazA32RVLiS5QhF8?=
 =?us-ascii?Q?UNuQit7eTlM73ZT3ej8pnYGu+DLaxqya9d77GBJxzLkHDOwZLYpYhhvnYxjD?=
 =?us-ascii?Q?G63Y7XtzDctdwMIz/spoHuzqTnMZ+9IZlhIBYO1cCsTErrhEL5z2XQHq+Xqw?=
 =?us-ascii?Q?nx1NOfZ5QmAaXXlqDxtrnbM+s1A/Yvpdw+fdENMA2Jc3bqeQzN4ZdRETC17s?=
 =?us-ascii?Q?smRl0NfXk7vaFkrkwKjNrOyy1PozHcMcvGvBIBb7FnK6J7HpoITkSBzBS8tb?=
 =?us-ascii?Q?R6GM6frZBXXmvOKfjj0EdmlXbkkuppzQ0DMDR32bTl6oqHYCUW8ZwHgqTL/9?=
 =?us-ascii?Q?imRX6j/gAsymuI17a+1ppYlY9THPPx7y9jckgl5NVVYQvmoEzdYkLCmm08O9?=
 =?us-ascii?Q?Oaao4q3r?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR18MB1452.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb275e1-0575-4c0f-ae13-08d8c5ecfa15
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2021 13:34:47.0204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z4XMxDJQpub3RWOx8Ovlkz5SIUUwP5H9ujqzcTQ7BqRNXk27r2ZyshPoSueyktGGeYjQy4NosJ/2xA5+4S2eGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3787
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-01-31_04:2021-01-29,2021-01-31 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Lubomir,

Thank you for your review!

> > +static void mvebu_cp110_utmi_port_setup(struct mvebu_cp110_utmi_port
> > +*port) {
> > +	u32 reg;
> > +
> > +	/*
> > +	 * Setup PLL. 40MHz clock used to be the default, being 25MHz now.
> > +	 * See the functional specification for details.
>=20
> I tried to, couldn't find it. Perhaps you could elaborate more here, or i=
nclude a
> link in the header.
[KP] This is the frequency of a quartz resonator connected to REFCLK_XIN/RE=
FCLK_XOUT SoC pins.
The default crystal frequency used now at all Marvell reference platforms i=
s 25MHz.
The default out of reset state register values are however have settings fo=
r 40MHz crystal used at the time of RTL code freeze.
I will mention this fact in the second patch version.

>=20
> > +	/* PLL Power down if all UTMI PHYs are down */
> > +	regmap_clear_bits(utmi->syscon, SYSCON_USB_CFG_REG,
> > +USB_CFG_PLL_MASK);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mvebu_cp110_utmi_phy_power_on(struct phy *phy) {
> > +	struct mvebu_cp110_utmi_port *port =3D phy_get_drvdata(phy);
> > +	struct mvebu_cp110_utmi *utmi =3D port->priv;
> > +	struct device *dev =3D &phy->dev;
> > +	int ret;
> > +	u32 reg;
> > +
> > +	/* It is necessary to power off UTMI before configuration */
> > +	ret =3D mvebu_cp110_utmi_phy_power_off(phy);
>=20
> mvebu_cp110_utmi_phy_power_off() also sometimes, but not always, shuts
> down the PLL. Is that necessary? I guess all you care about is the bit in
> UTMI_PHY_CFG_PU_MASK?
[KP] Not sure I fully understand the question. Both UTMI PHYs are using the=
 same dedicated PLL source.
I am trying to save the power to shutting down this PLL when both PHY ports=
 are down.

>=20
> > +
> > +		ret =3D of_property_read_u32(child, "reg", &val);
> > +		if (ret < 0) {
> > +			dev_err(dev, "missing 'reg' property (%d)\n", ret);
>=20
> A nit: the property is not necessarily missing -- it could be malformed (=
with ret
> of -ENODATA or -EOVERFLOW).
>=20
> Also, perhaps you want to log the name of node that has problems ("%pOF",
> child); also in the error messages below.
[KP] OK, will do it in the second patch version.=20

>=20
> > +			continue;
> > +		}
> > +
> > +		if (val >=3D UTMI_PHY_PORTS) {
> > +			dev_err(dev, "invalid 'reg' property\n");
> > +			continue;
> > +		}
>=20
> Perhaps you could just squelch those two warnings together:
>=20
>=20
> 	if (ret || val >=3D UTMI_PHY_PORTS) {
> 		dev_err(dev, "invalid 'reg' property on %pOF\n", child);
> 		continue;
> 	}
>=20
[KP] Yes, it will definitely be better, thank you.

> > --
> > 2.17.1
> >
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-
> 3A__lists.infradead.org_mailman_listinfo_linux-2Darm-
> 2Dkernel&d=3DDwICAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D-
> N9sN4p5NSr0JGQoQ_2UCOgAqajG99W1EbSOww0WU8o&m=3DYFT4I6c34R7m8
> 6d4PlkWJFgC3qPXYkofB_VPJDgQVSA&s=3DHf5wCKTcwKa3Mx-
> L7ZXEX4MPsfaMtPDu87RltnvXa90&e=3D
