Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4F53A4E9E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 14:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhFLMWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 08:22:20 -0400
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:14336
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230191AbhFLMWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 08:22:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRCmx/o5UJEPWxv6J0ZOLoTKoZcR5YYsRsofD2G7B0kYvyrQidNBWrgFnOmwO0HGOz6rsdNb492qQczZ4m0IN8F8EsClMiDzP6AbpNpcDU+IQ6q87rQfxfcOm4FMrAIVcoArY22SUwd7J5uFEXY2u2VeB6WHNDnznDvokBCibjOG3zqv9CPDWd/ybIo1QelhknJMnhJWkmwIBAuZ6gv0J1KcpnTRwDlBLZzwbZheddwB1snxourr9C9UQPZbknYmPlRZP7EhRc/kFY/oY4vQhbF0pc6H4XuCacT9Jrs50FdXBerlQVbJy8iWSdwLhaMbo8Tu1/hjRt/kZWT9+ZiZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLF7kxiUfI8HuKwAFlR5yAXgRoSOOagIpYh/1FHSTpc=;
 b=Jl1+HsHtcPy9DCtDFDioDBMFFhEJKxm7vWZ+werM+dDiXRMYsq5gpEqPZVM406bWoxoTzCkwn7C5uOfcx8bkVPPrzUHURzWK9CpfPvr7yfgRpvyCCcS4+dQFIZw7LT6lo5Tj11VXgxjoKBAKJ7HUQNGd6qs1omqKaK6N+PIAqDeSM+eYUpUN332hyPDNtnj1PE7o3UtVbdl3i8YhnDjOo48Gan+HYffNKXb2DLCny/SWY2W/oqfgA9IbPlziOVHtOFf3oO+XPhoo3gj6FJbT7D50RORM60P94FE47Rys+eVYpMtAcSSk/LnrFDpmZuXSkflIzCJM4ozd6s3YxBIpRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLF7kxiUfI8HuKwAFlR5yAXgRoSOOagIpYh/1FHSTpc=;
 b=NpsrkuuYFeQ1x/7P4VWQIbN61g2aNUqvU0sYHqrvPuUGDckOKYi3q1sKZqP7isfdKuJlyCJXw1hEZzH/gFG4EjT5m6kaIencTwkcS+2dICqJWZZNyYpwyd/q67QnCUF3hWi79Yypg4ZwpJZfvzPq0nswRpBTnzvNwNorwoUuyTA=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB3PR0402MB3913.eurprd04.prod.outlook.com (2603:10a6:8:3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Sat, 12 Jun
 2021 12:20:13 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4219.022; Sat, 12 Jun 2021
 12:20:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "marex@denx.de" <marex@denx.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>
Subject: RE: [PATCH V6 2/4] Documentation: bindings: clk: Add bindings for
 i.MX BLK_CTL
Thread-Topic: [PATCH V6 2/4] Documentation: bindings: clk: Add bindings for
 i.MX BLK_CTL
Thread-Index: AQHXTwvTHCgmK+UCy0qWVIaZbeH5CqsPqnwAgADB4HA=
Date:   Sat, 12 Jun 2021 12:20:13 +0000
Message-ID: <DB6PR0402MB27600201A17238D3D022A80F88339@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210522134249.15322-1-peng.fan@oss.nxp.com>
 <20210522134249.15322-3-peng.fan@oss.nxp.com> <20210612004550.GC29138@dragon>
In-Reply-To: <20210612004550.GC29138@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [121.228.180.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff923568-e2c3-4b6f-bf8e-08d92d9c6e00
x-ms-traffictypediagnostic: DB3PR0402MB3913:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB391396A3938885EE08B60AFAC9339@DB3PR0402MB3913.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mctHu4ctXjuBXB0qf4CwmvFO88M8qachZe//a41h76CuTDM56tALYzD9FWixDvs7lNhXm4FAHZ309BPy9xaWsu+64devScNGuPRpIfeKNGqNzUuvhHcBrJUDYJ6Xzx/Ps+kYjofmZZOPgMQjLEsJP0xbhSnHDH3GJXLsXfMgJYts06T+8xwWiabyfZH3ekSNL45p6oNloWP/aHjSOo4zeJl0ZN/GKE4t9fyzPz0e8/rIkTW70ycoPEff8AjR8kksbwNHKXr0um42qAK8QB0cwbK1H9/vlZFJdPpFibZghrFMsiY+73Hu9K2JPGpADHlpnyA2rM3t5NOb0H0JS2puR9kkGlmSpd3LRgVZHLly5uvchOOB3QCeoDfj3z8u516/abMEP2iWluSo13kpCcTOAotpM2CujrwXsndSUqvaDyIxZ/bPQ0VZFK49TiKnrWCGS6lmRvPM4MXeSQjnFpOm3jBFXtsTpLG0o1phZrrutIy6AzWCHZ6XaDQ4T0GIv33wQXUiDqxDZLbz5K+y2urmgvTuuHtyp4VOMEOwlOicItRgcgcxXMwspHH9L6ncsTgNg+AQtJ4FGYaR+AeE77E5X4MwUjHa433F2AIJbQuQV1Jx0wCLqssowcAIcmczrhsBvrX27tsJ1VPKQlDfzKYiRLHpxY2IK7XyJ8ObDZa7M0EgSw2aVNH61vwKJCApjS7f0HvZcEMBzD2oySGc8rFTaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(38100700002)(4326008)(33656002)(9686003)(66476007)(8936002)(86362001)(71200400001)(8676002)(76116006)(83380400001)(6506007)(186003)(26005)(45080400002)(498600001)(122000001)(55016002)(66446008)(7416002)(2906002)(66946007)(54906003)(52536014)(64756008)(5660300002)(110136005)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0APTLEWFMj10yuDe9OfrhTiTJK057trG6jhQvlBcMAGzeWkK0aNUlSrHG3Uf?=
 =?us-ascii?Q?yNw9Qsvbi/RmYTIYFM49Q3ipCugWNMK/mLeJ9oy0B6klVvFs/T4OWrCcBUjh?=
 =?us-ascii?Q?Cjkg4ZYTYC4kb3jMXfUWUOWg5GaqtZE20jHksGyA+IAsAo4xJryGrca9927O?=
 =?us-ascii?Q?SJHuZUV2zPAiRSx6bcMRwNAimSEvin8vcHUN5WQQDke7obQFACEBarClFPmV?=
 =?us-ascii?Q?B04rQDk42zONDX1Yt3T+NNou0f90Ct2ZgPURkIQj1YRjGhtYTYzsgxlpcdxO?=
 =?us-ascii?Q?WZFlHNgMplPiXUBUsdsApfsE8lTWhRPwFIQ6JYNF52n8NN7z29DjljGinfhm?=
 =?us-ascii?Q?8FsQN1CqyZt0a7scI719bPQhZaScD64Ipm0V5YdKPIhzj/Tx1J8A4PjXYI9U?=
 =?us-ascii?Q?1Elcp3PU4HJEXXtka17yWqKp/u/kWasRFE1j/xssCfYDK2c6+ygU4/NnrJ88?=
 =?us-ascii?Q?Hm9HM92hAJT3fpwNCR8yxW50L15N9QlrHXF+GfFtdcwAq/o1yBXxbp2knHAr?=
 =?us-ascii?Q?8lMWg25pPQbqXUIqocUWIf6ft4Vs8n1MFZB3q0I98mVa1sPa5aUPokctZ4PL?=
 =?us-ascii?Q?NtDnVRYvHRMNNsE8FD2PEamTGe1LhYbYKHUfrV3sujNEks0CBZ5+m5kx8T4Z?=
 =?us-ascii?Q?iACKpBNXglycx/FukoRotGvukjuSlVgORUOskhFiND3F9bv6l9K3oMJMwhnr?=
 =?us-ascii?Q?uJxLi/ZfqU9qJYh57PMDO9Kig68Nf1N27mD80Web0+u6mjny0a6hOVkk+wnP?=
 =?us-ascii?Q?p39xpzBppGmUBBuMWrrHfnDYl5tqedwgvu8+buGKKRVO+PCw++F4otPpsirV?=
 =?us-ascii?Q?htb9Td9XAKmBZOQvjmA6ZIKsdKsLgght6d8WQmaZTRaPT06pUZ7LAAUa4HNn?=
 =?us-ascii?Q?9OM5/ZkeLD99nbBIwRHA7dSdElNkYAGjWYPkSUxTT4YfyZhCHlvk72Bi3rzV?=
 =?us-ascii?Q?BWF1lkcQNk3hiWX+J0lYqalApColrfpcAZ1xrgWdwDFc326I7AiMgp1n4Kfp?=
 =?us-ascii?Q?5gltqSg/Fi/SD2YHMxZJZL5HDuoM+LgMoPV24DRLPjFK7EoeRQdQTAbeI0jZ?=
 =?us-ascii?Q?Udq1ZIMmvA+gFq7cLWqBIJXgQGrqpNSo4TxZlRBy9s+eRAz2JWG/luKQcZp9?=
 =?us-ascii?Q?BQa/VC53yBFaku45q66nUPPTzPnFHGVxzsVBLQbsVHmsNteM/HhVqZkkylz2?=
 =?us-ascii?Q?hbPo5mz9hmcSNRqEguhv4hH85/LQh8DDnbpvvvDR6TpZaIaMaFyxUH+e2iSs?=
 =?us-ascii?Q?mTUZ/2SiKYiCW3Ka+9kGVAj+4jKpThICzvu9141PdqXfIXK8h5ScLUXjQlG3?=
 =?us-ascii?Q?smjLwIuCmMZpMxaWuIQBOpiP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff923568-e2c3-4b6f-bf8e-08d92d9c6e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2021 12:20:13.1637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0oeVL/GMMg0DVWi/g1OhRqy4H7F0IYuw2KTnPx3e0Kp/uQIs4AeS1g1ziCiP9/eeEq8x7Q4NKa8WAduODuOYdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3913
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V6 2/4] Documentation: bindings: clk: Add bindings fo=
r
> i.MX BLK_CTL
>=20
> On Sat, May 22, 2021 at 09:42:47PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Document the i.MX BLK_CTL with its devicetree properties.
> >
> > Each BLK CTL have different power domain inputs and they have
> > different names, so we are not able to list all the power domain names
> > for each BLK CTL here.
> >
> > For example:
> > i.MX8MM dispmix BLK CTL, it has
> > 	power-domains =3D <&pgc_dispmix>, <&pgc_mipi>;
> > 	power-domain-names =3D "dispmix", "mipi";
> >
> > vpumix BLK CTL, it has
> > 	power-domains =3D <&vpumix_pd>, <&vpu_g1_pd>, <&vpu_g2_pd>,
> > 			<&vpu_h1_pd>;
> > 	power-domain-names =3D "vpumix", "g1", "g2", "h1";
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> Can we be consistent in using 'dt-bindings: ...' as prefix?

Yes. Fix in v7.

Thanks,
Peng.

>=20
> Shawn
>=20
> > ---
> >  .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     | 66
> +++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
> > b/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
> > new file mode 100644
> > index 000000000000..a66f11acc6b4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
> > @@ -0,0 +1,66 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> >
> +cetree.org%2Fschemas%2Fsoc%2Fimx%2Ffsl%2Cimx-blk-ctl.yaml%23&amp;
> data
> >
> +=3D04%7C01%7Cpeng.fan%40nxp.com%7C8ef49946599c41046e5308d92d3b7
> 2df%7C68
> >
> +6ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637590555623663011%
> 7CUnknown
> >
> +%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLC
> >
> +JXVCI6Mn0%3D%7C1000&amp;sdata=3D%2FvyX8r5Dc0nWjRaLASXKvs7JGKuP
> 4iwMQPMNa
> > +u93SH4%3D&amp;reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> >
> +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D04%7C01%7Cpe
> ng.fan%
> >
> +40nxp.com%7C8ef49946599c41046e5308d92d3b72df%7C686ea1d3bc2b4c
> 6fa92cd9
> >
> +9c5c301635%7C0%7C0%7C637590555623663011%7CUnknown%7CTWFpb
> GZsb3d8eyJWI
> >
> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C1000&
> >
> +amp;sdata=3Dj25%2F6NIDdiN3weLr0xMDM5z91P9KXDLEzIRlf7A4OPs%3D&a
> mp;reserv
> > +ed=3D0
> > +
> > +title: NXP i.MX BLK_CTL
> > +
> > +maintainers:
> > +  - Peng Fan <peng.fan@nxp.com>
> > +
> > +description:
> > +  i.MX BLK_CTL is a conglomerate of different GPRs that are
> > +  dedicated to a specific subsystem. It usually contains
> > +  clocks and resets amongst other things. Here we take the clocks
> > +  and resets as virtual PDs, the reason we could not take it as
> > +  clock provider is there is A/B lock issue between power domain
> > +  and clock.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - fsl,imx8mm-dispmix-blk-ctl
> > +          - fsl,imx8mm-vpumix-blk-ctl
> > +      - const: syscon
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#power-domain-cells":
> > +    const: 1
> > +
> > +  power-domains:
> > +    minItems: 1
> > +    maxItems: 32
> > +
> > +  power-domain-names:
> > +    minItems: 1
> > +    maxItems: 32
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 32
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - power-domains
> > +  - power-domain-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/imx8mm-clock.h>
> > +
> > +    dispmix_blk_ctl: blk-ctl@32e28000 {
> > +      compatible =3D "fsl,imx8mm-dispmix-blk-ctl", "syscon";
> > +      reg =3D <0x32e28000 0x100>;
> > +      #power-domain-cells =3D <1>;
> > +      power-domains =3D <&pgc_dispmix>, <&pgc_mipi>;
> > +      power-domain-names =3D "dispmix", "mipi";
> > +      clocks =3D <&clk IMX8MM_CLK_DISP_ROOT>, <&clk
> IMX8MM_CLK_DISP_AXI_ROOT>,
> > +               <&clk IMX8MM_CLK_DISP_APB_ROOT>;
> > +    };
> > --
> > 2.30.0
> >
