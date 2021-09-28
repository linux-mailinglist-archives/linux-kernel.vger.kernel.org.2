Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E585741A593
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 04:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbhI1CjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 22:39:06 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:64386
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238564AbhI1CjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 22:39:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXydBCJNy9jHv38n8pQQ2CiVNeEzPtr86tMzmspCf8BA/vk22IE9xLR3F+WWFVtw66zLm4woRFdJfSJYptKi2dZI6vpxrUtDtWGbLP/6ut4apx3UwPHrn5GCisFr3A0vfmTUZ97mrbJTlsewiAYGEyX86TTnisUNsNOieh3AQY/gy4B8DJ4yjcGBA2zv5CYjcv+aRtBAH2jMDoNbRq5qRU3bcpntEcxhnJbPZwqZs/XQo6N8GcPQcB5h6lvXTf6Er9wMqnBXEQIh/JoVIg6uc88ETkLcgV2jxZwMOj5SOfLsf/xjipzPw+SYL6a3MZ0iJ8XkbAyEXMJv8S3ZHCsmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5TIrEuAyYwge0X4IbM4DyNThSucmaAWQuRn+f+LCO/g=;
 b=aItYP457bdsAK/SCHYQcpj0RA0r1Cn+wUdC11iKqGit+hKBK1dC/U4Ki5XV7r9mrwwIUH+g4oTe7jQGc9yG6ZqczApt3y8EW/Uj8YYLAajVQxtL771gQYT3UtpMh5SRZRwWENIfYH8Ya6UjCQ4ml3J9i8grARKGMijCBC395k6pXSRQl4j5addXYtAsZ1anCIy4KPkhRqW12ik7Slf86WAfzjX+rNDvciWj8Cckoc1UkOydHTohrkYofWWIovwivGh4cndCZ4Iqm/UnKpQIxD9vEC1/MFN/08x68/IXvm5oLVvoPsctaMeJrTAnaFzxEfB4zt6dxzd7MgwMI9iUKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TIrEuAyYwge0X4IbM4DyNThSucmaAWQuRn+f+LCO/g=;
 b=Jt1CL3k4ulNE17AfhaRsoKFnd9UbRAjwRd9z8EeRYLo6ZFVwWOKXK2IA9OU8ixYxjHojP4eGutusMTvOHkkbGZktsu4z9bL4S0tNgKz78S5bkC4lofnpjnwB6DNDuhFw8n1IXfuwI/zpL+q/PB6iUCMkWU9b1Slj3+PhyhmqP2s=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8546.eurprd04.prod.outlook.com (2603:10a6:20b:421::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 02:37:23 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::c5ef:f538:c3e0:c4c2]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::c5ef:f538:c3e0:c4c2%9]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 02:37:23 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2 2/4] dt-bindings: phy: add imx8 pcie phy driver support
Thread-Topic: [PATCH v2 2/4] dt-bindings: phy: add imx8 pcie phy driver
 support
Thread-Index: AQHXsq0EmVlO04zC/EmA/a1gOvUYm6u3jxyAgAEtCyA=
Date:   Tue, 28 Sep 2021 02:37:23 +0000
Message-ID: <AS8PR04MB86762E7C98765D1DB0F0D7408CA89@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1632641983-1455-1-git-send-email-hongxing.zhu@nxp.com>
         <1632641983-1455-3-git-send-email-hongxing.zhu@nxp.com>
 <f421d1c8079d6c6694972af04ec95318d3399152.camel@pengutronix.de>
In-Reply-To: <f421d1c8079d6c6694972af04ec95318d3399152.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f8a20a4-4ae6-4eca-69da-08d98228e727
x-ms-traffictypediagnostic: AS8PR04MB8546:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB8546B1738EAA04768E6B4D878CA89@AS8PR04MB8546.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2m+w4Jedkwp9ONzatfHZl3X8YeO+PVsTLVilruGJnynlY71dYny3oY6mR7p/rRWBSjBhiT4/+nCrUoZfB/4KnVB57Ab8VwgBg60aJTN9xvf7EbtR7SXH63Dk5fPWoiMgNvodoZ3NimR9I4ERxNr4yiavCXYdzCBQPJw8h0g9tiOwvXvP9f0iNfzPXN34lGAXGoEcqFoe08XoQ4/4Wmqr4iPEZl+n29nD/tKZNUoK9H/uG1we1DY62A+z7uCyj6FPgGcYGF+gsWs7nNChHbNtz24fGwnuTLZF1qeeBDHwgtbYcwzU4vdEfxJuyF1TBaq/JzhAbQkv1C5T7VV9FUbUHf4UHe07WPe1nIurw8HjJpxmech5kQwbL19GJcIPKbRxdooqCl7ytG2TKw/1GuSAMc3OiCNRk2HW1B3Hndj1Ns+/lCLGgFY63+BZDp6XWrHWvXaexMGTbnQcevkr0MrJiWIsPsaWSnjLxxqaHpcy+zyONx7dcuYqus+VOCCmisfFM4L7olzkxMwrA2Ax3djQ4+c4sPEC0Vud2RGobgzEADInggo9j3CGj/T3CAvAwBvhtS/jlohNTBdpMi6ET7930uLcOPenj1by1XYYU7svwUoFQYQoFGdasPfDOT4qwwDGPfB93jeWtI2SX2Aw7A9ThPHo6Py0HyJUFS0C36ENb4GBpv9vnuczLRfNNdlE1T6VZP4WcOrZrkCNK7qci/9dkNIEEmJIeK7eL/B7rB0VROxLuGEHzoWmwmIq7GI6WpAG04iIo+7XuNCApOalEcVrPQHNOLojHt/TlKAhFNTLBWk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(53546011)(52536014)(9686003)(6506007)(55016002)(66946007)(4326008)(66476007)(66446008)(316002)(64756008)(66556008)(8676002)(2906002)(7416002)(7696005)(33656002)(38100700002)(122000001)(5660300002)(86362001)(110136005)(54906003)(45080400002)(26005)(186003)(83380400001)(71200400001)(38070700005)(508600001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xeyxYxHCDvHMqdFhCjMQsg13rke2P0Jur5NmFy12H34dKStbp7QeFPcMujfB?=
 =?us-ascii?Q?rQjGxbNlxKHn2Vz9EP+7qf2CZpO3tmnmFeABFmqmQ0x82BygTMkvnBc2cbR7?=
 =?us-ascii?Q?xoNLoFPmNNLGPtL2Ps4LmcTBOZoq/Kmot57kZsmpDlQbhwOluCMSvEUdqjN6?=
 =?us-ascii?Q?90fhT1s0C4JT3x2R8WRMbLUOdM/glHwXMaAxcb4Rvk0ALpeqAn2GMvYHqTzM?=
 =?us-ascii?Q?1VlQZsLUSVd8JA6Nj/J8rxifd4hm4pxbv0+qfWKCJVpnUTX9JaIvlMCf5pca?=
 =?us-ascii?Q?0ZvF/RQ8xhr7Y3BZa534hL5FZVEN7J1VoIOHogwDGiR9C5fQLKqy2pujhcmX?=
 =?us-ascii?Q?JWoLZPf0fHUquvEa9NfUJm2jexiyWmNOGdclTgp6TjY6k4rgpvTqcLT0rnzh?=
 =?us-ascii?Q?hHnDTDxhz7nQn2LPbBynYjTTDeSjT+hyHTDmBoFWdA/0cGfXc8wdTj+2OFaX?=
 =?us-ascii?Q?POZBF1qNhB1eBLfL0/63rK//S28g5VfhFJsaqCOhj1eo9bB0EzdGt5X30BjD?=
 =?us-ascii?Q?Yeh8FOuIpfjTk1mhHGzxBb86aDSh5ZEboDjg3MbuzJinbZvDjr0vnDzcUqNM?=
 =?us-ascii?Q?ofFC0di7uBJ+NOobGz3D44eYB5Xbrw12CHYMIwLkFJ95FUOIg9fKF4BRx5DE?=
 =?us-ascii?Q?4cjJXDJdcP3yjujY5W25z3BjivU7bSuW6CEbSmER7fPd74vHHE4eFQPxFzR5?=
 =?us-ascii?Q?0EFxafr/GP08zQfaIMEBfwSrZLsrIDRNdGxw4NDOpx8rpbhLjnbgm+fqB9UE?=
 =?us-ascii?Q?EwQynZnU4FMn5Gy/DQ3ySXmoviDaJdxDDZKSNbKnX9tB/LRcEMaA839WH0Mt?=
 =?us-ascii?Q?6QJvaw9tRkcDntJTZKTjI/0N8qmYF6ffOjOm/1btXmrY7Omq3STh74mlhMgh?=
 =?us-ascii?Q?FDZRkQ+Kxkp/ZcBFEdNGcQUhbLvWYXDylsBIj7uH/dgT1J3ZFNBNaFRJeuh3?=
 =?us-ascii?Q?s7z+piVEwI0ETWUALpmhnBuQBarW8B1YApOJ2QuxtRG/8y6XeJH4fXYuKaxu?=
 =?us-ascii?Q?2NwglCehfv+UC4eK5c+uWlFRiX/f/i76HXzOD1Ty6A+VNYmebSTH0+b44VZE?=
 =?us-ascii?Q?o65UChtvj0NWRT+Wn5nnECefun7dVP7NcqsX1JYjroQQZCGa3D2GtcQ55CMX?=
 =?us-ascii?Q?1dCjbKSA5Gw4RJxCfIhiV8WkB0B/4gcllI7p47WdbaElOHO02WyOfxWZdP9Z?=
 =?us-ascii?Q?Xv//RFml5ZMgFN7n4wKEyZSPoITx7ooDKHlylh7Qcpbh15oiaCpAWQ9KHxe2?=
 =?us-ascii?Q?v8z++Ugo++sSnHHrj8R4deBgB1mX5hThyCrpX/bfCZygZ83Eu2Yy2UAX4WZg?=
 =?us-ascii?Q?EjCMRGRvse/Taw7ZsQYXlfkh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8a20a4-4ae6-4eca-69da-08d98228e727
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 02:37:23.6724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UI3p5V35uSoxceoOnoY8mYo8qV7sXuEJfiimqFjgu8p8pMFBUGQKSc+BvxN4Nrk3q25CUqV3QtIglyvrcwKFFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8546
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Lucas Stach <l.stach@pengutronix.de>
> Sent: Monday, September 27, 2021 4:33 PM
> To: Richard Zhu <hongxing.zhu@nxp.com>; kishon@ti.com; vkoul@kernel.org;
> robh@kernel.org; galak@kernel.crashing.org; shawnguo@kernel.org
> Cc: linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v2 2/4] dt-bindings: phy: add imx8 pcie phy driver su=
pport
>=20
> Am Sonntag, dem 26.09.2021 um 15:39 +0800 schrieb Richard Zhu:
> > Add dt-binding for the standalone i.MX8 PCIe PHY driver.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  .../bindings/phy/fsl,imx8-pcie-phy.yaml       | 67
> +++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> > b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> > new file mode 100644
> > index 000000000000..fd08897fef82
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> > @@ -0,0 +1,67 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> >
> +cetree.org%2Fschemas%2Fphy%2Ffsl%2Cimx8-pcie-phy.yaml%23&amp;dat
> a=3D04%
> >
> +7C01%7Chongxing.zhu%40nxp.com%7C7c5f7203447a4c259d9f08d981915ef
> 3%7C68
> >
> +6ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637683283637916778%
> 7CUnknown
> >
> +%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLC
> >
> +JXVCI6Mn0%3D%7C1000&amp;sdata=3Dm1S7Si0nL4zveL76S%2FvpKbFFrWhJa
> mFNgcVld
> > +Rxx82I%3D&amp;reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> >
> +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D04%7C01%7Cho
> ngxing.
> >
> +zhu%40nxp.com%7C7c5f7203447a4c259d9f08d981915ef3%7C686ea1d3bc
> 2b4c6fa9
> >
> +2cd99c5c301635%7C0%7C0%7C637683283637916778%7CUnknown%7CT
> WFpbGZsb3d8e
> >
> +yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C1
> >
> +000&amp;sdata=3DS2uWTI603YkF68zqySbkcK32XaPEwU4%2BHuntwR%2Bkx7
> g%3D&amp;
> > +reserved=3D0
> > +
> > +title: Freescale i.MX8 SoC series PCIe PHY Device Tree Bindings
> > +
> > +maintainers:
> > +  - Richard Zhu <hongxing.zhu@nxp.com>
> > +
> > +properties:
> > +  "#phy-cells":
> > +    const: 0
> > +
> > +  compatible:
> > +    enum:
> > +      - fsl,imx8mm-pcie-phy
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: PHY module clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: phy
>=20
> The clock name should describe what it is used for in the hardware block
> described by the DT node. So I would think this should be called "ref" or
> something like this, as I believe this clock is really only used as the r=
eference
> clock and can be disabled when the refclock is supplied via the pad, righ=
t?
>=20
[Richard Zhu] That's right. "ref" is better. Thanks.

> > +
> > +  fsl,refclk-pad-mode:
> > +    description: |
> > +      Specifies the mode of the refclk pad used. It can be NO_USED(PHY
> > +      refclock is derived from SoC internal source), INPUT(PHY refcloc=
k
> > +      is provided externally via the refclk pad) or OUTPUT(PHY refcloc=
k
> > +      is derived from SoC internal source and provided on the refclk p=
ad).
> > +      Refer include/dt-bindings/phy/phy-imx8-pcie.h for the constants
> > +      to be used.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [ 0, 1, 2 ]
> > +
> > +required:
> > +  - "#phy-cells"
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - fsl,refclk-pad-mode
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/imx8mm-clock.h>
> > +
> > +    pcie_phy: pcie-phy@32f00000 {
> > +            compatible =3D "fsl,imx8mm-pcie-phy";
> > +            reg =3D <0x32f00000 0x10000>;
> > +            clocks =3D <&clk IMX8MM_CLK_PCIE1_PHY>;
> > +            clock-names =3D "phy";
> > +            assigned-clocks =3D <&clk IMX8MM_CLK_PCIE1_PHY>;
> > +            assigned-clock-rates =3D <100000000>;
> > +            assigned-clock-parents =3D <&clk
> IMX8MM_SYS_PLL2_100M>;
> > +            fsl,refclk-pad-mode =3D <1>;
>=20
> Include the new header added in patch 1 and use the enum.
[Richard Zhu] Got that, would changed in next version. Thanks.
>=20
> > +            #phy-cells =3D <0>;
> > +    };
> > +...
>=20

