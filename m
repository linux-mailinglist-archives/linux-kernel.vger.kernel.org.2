Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5517D42B08D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 01:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbhJLXsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 19:48:32 -0400
Received: from mail-vi1eur05on2074.outbound.protection.outlook.com ([40.107.21.74]:1856
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233903AbhJLXsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 19:48:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIqBkS+h10ogWZ0f26Cimh10K5xEdAt5b8cKITinalbEvDl19wJA90+aV7cD2RuICjWLvBBLY581XGP0Buhz0S2mtv354QqlnBe1g7KrQcPDJNKWTl0No1i+Ev3W5NxrS6qVkbiFP08ULgEd0mF8AV1mkB0NtbRRI1hPlesoawCEvfI7CyFVJzF6O7kuYwJHo8mAIuzIN4DTKMTQCSAXBvKnDr6HcTJIRjPubPuhf1gk9WIkvrMspHU6U2QwnBz5AAeQbe+eNAFpk+zsRTf1EADe6+TIsa1pS4e6zBGN5EmMUO+ds4wR/Vtx+Mw5Niw4YugJjy+CY3dQZm2mpkadvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jDEZQDBUPoxzHEi8JPfp83BHuUzC+djE1x/+y9DumI=;
 b=VlIqU2zsQiZOZciwqcrSs4lm5WcJIuLnfBBy4f74mqLstme2o/G95WICdPzYlPQL6/rb9SR6PIU/Ns23dg2hqSkPpwmbdUMN+jCgUoqrd/28DFzigBDMKJ9WIXJHrVM0yiqti94f3ICK8ZBpRfAMBE3nMXpVPj5GCjjKwAdvu/8wq3ocZJaFzkJLQDWnB0Cu3PaKxt8BKWTJcnn7z+46sNdYUYi1CYXXKHMiK6T0PBKSdyaCc6HJSg6f4swKnVx3zKdQy5oN9xLKacaSy5XFu4jngQAqCy3iPP1MYLsdGDrAmP6h4W3W63Dk2q/ABCwugA+InTI/SSll/guuhO8akg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jDEZQDBUPoxzHEi8JPfp83BHuUzC+djE1x/+y9DumI=;
 b=QUwRyR76oxhfzOiDUHahbNWl2mo925ZJ/pV4OKqgz/BsjyCEj2mq7lu9naXuNH6BfFbq/516s/LfsBq9VKMXjbJY9TC65C/SbQnrcbSD8wgIDTIDbjHQTYhx2QWtBNUCI9fQlGSE9i+PuVr/VYy8cU898eyfK8NY0daMPOvHhSU=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Tue, 12 Oct
 2021 23:46:25 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::551d:cc86:4d67:587]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::551d:cc86:4d67:587%3]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 23:46:25 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "kishon@ti.com" <kishon@ti.com>, dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>
Subject: RE: [PATCH v3 2/9] dt-bindings: phy: add imx8 pcie phy driver support
Thread-Topic: [PATCH v3 2/9] dt-bindings: phy: add imx8 pcie phy driver
 support
Thread-Index: AQHXv0hlrBQmJmSLUUWUdasqgJ4mX6vPWLqAgACu40A=
Date:   Tue, 12 Oct 2021 23:46:25 +0000
Message-ID: <AS8PR04MB867657DBC4C2576930647EEE8CB69@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
 <1634028078-2387-3-git-send-email-hongxing.zhu@nxp.com>
 <1634044709.029189.2661233.nullmailer@robh.at.kernel.org>
In-Reply-To: <1634044709.029189.2661233.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 420dfdff-a4f9-48ce-f329-08d98dda8111
x-ms-traffictypediagnostic: AS8PR04MB8436:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB843642BCEB56417F2F9733DD8CB69@AS8PR04MB8436.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5t4PDkR0KIJr4k/bDwkCz7KMrWz3W+zuYU62PeHF+ge0UNV/9Y4Yl+eQETNhUtCIgQ0aejZ1xC1RXH8RQO9wOspE3q3ydGCVDFFm1MLw8qNB7idU225S52cs5kb5KG71R3XJJHUExVyW/Dlz6naY+wWlDofqZ5qSbc7wiS1+UKEgRbE7BkbtyjsHwWS2/7muyaNFg04ipdw+aagK+WnnrEBI6760FaBSlvsggGCRH3JTDImrtbnThJiUUI08cg+/RN1sryaXEr4I8F2qWPGkBHNZ1yJ9w932gn7kwPG7GXTMfdz7T+5YW7KysdWcVWIi7PgVBBrfc6Qq06Z6z+QMFR9e/QKcTHvzEAiiXSQi75PBtiscQ4QIQp11vlLhIJjHU+lhpTyah7g347mbvaA52gPhRr32N5y6BjWIKaGHs/Tpmh5bvGFnnPrUg7EUzWevEnnzCuEMiuGkNMRCTOvt8NffYzcbzFISW55YdgfN5lj1eiy/7G1DRGdNYZUD3nZqg7Tz1RzyFdX0S0G2+VSvsEJhxaowfkKzCI0DLAYDYZUJLyR7nzczRzs11xktYYfAl7f66T3kwuw0rIguh//O4IbzdeTtdtt9DF1KBBgeHCF8tfcZseyXEGN2WeNfnMVg4D0+2C/31cULRAPHIo0yIiWx5l8XYRlHkSlyZwO84HnnRcxNlmZEugoaB+VeVj0wRK/iWutilHQ+e7XrRwwSNnxC82P60QQ1ioT2wvNpLMoU6hB8U9N7kuFUA66ByiyLGIMPmWoEkXlFy2c02B6T0ONAEQjwcNJF3nJu3a1UJTA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(66556008)(5660300002)(966005)(66446008)(6916009)(52536014)(45080400002)(26005)(316002)(7696005)(2906002)(9686003)(7416002)(86362001)(71200400001)(33656002)(54906003)(76116006)(186003)(508600001)(66476007)(53546011)(4326008)(8936002)(83380400001)(122000001)(38070700005)(6506007)(8676002)(66946007)(55016002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?evTR5BDXX9EDJf45pakTTFJiCQlwaor1ebL7lhllY4tjrR6l9HviXLmA9ckT?=
 =?us-ascii?Q?Scix4r5Ehp3Lhjmc+lL1WMfQjPy1hxrWoHAlK9LDmHE0ImF6C5Pe2Y6QF5XK?=
 =?us-ascii?Q?iHJ02z8znG4ZbGvZweEJK90nF75W3kw2xAiENgS+EjJCpBADj2SzaG/VqRg/?=
 =?us-ascii?Q?4xg/ptZG7gVPul4kVMdqe/b/02kwvoSxSl8osn97/TmZTsQ9ZDKLKlegphqo?=
 =?us-ascii?Q?w1RRW0s7/iX5DWEwgCsY74Q70cvcPLnwTGMBKkRG0GMgm34eSpx7sHrbF7Eg?=
 =?us-ascii?Q?ztOqH9P92GOiiGlyceFFtMrj+sNtbDX6S60+Q/BhZM8v4oRw6jz8DByTxHEG?=
 =?us-ascii?Q?G1TtjO8SsS0pfcbPe1RvBnDJNLTE+V3sxtwqsI2OsnfLUtWbfxtBDCT554IO?=
 =?us-ascii?Q?sYtASEqMH7lhUglleQrj4Jay/gbWXMl2zaNdLRDWNbiDCi5k6SuwIceNH5gb?=
 =?us-ascii?Q?eXkPQ9+Aw6Y/LHsaNyL+/wnplRhchnoFackfGqHE9JGWeJZztdGJ8fbwzH75?=
 =?us-ascii?Q?Ru0EUFVqfb900F7k7QBJU2MCnQ1Jv8F5iBUik5TIja1zKnZQVD4pWsTX9Xfj?=
 =?us-ascii?Q?vAjEn1/iN8Z35xoU6z8JDZwDOeRuB68HeBRPz2stCNlRfyengJ1AhQPNgYpM?=
 =?us-ascii?Q?G7Xcik1Adlom5NtRMY5ckv4iTW6zKZK9RWD0j9ajGkeSt6mOYiWVGXXzwoub?=
 =?us-ascii?Q?a6Ecg1QJ7W8P0uQsrzi3+jX6u+UZgaxCNhzYqqB6PkXD1pEqqOkQkl5m42qt?=
 =?us-ascii?Q?PJlbbjCJKpmQ4oN/Zh0FgiWSwDVhx3lqvjjz4owMw+04WPQ0XV3AnDNCf4rR?=
 =?us-ascii?Q?uulLp7IIDS4/TPM2gOVlmr3YcwDlKhdmAy+Ru74LoqlVOhqapYUmuuC4MBwi?=
 =?us-ascii?Q?Xw/KSm3pVCmn/MwxdrGwTtqdfYZszWO1JDppjqn+0aU29fGtjujMwrHzMSXA?=
 =?us-ascii?Q?8R9Qmp13E+4kXhgzK3lhBOhJ1OLO3wewAdAK7GnOYoeFt60ZlNDs/IElaAf2?=
 =?us-ascii?Q?jprOJO1Onw0Er9jnC0jbglZ+712l2/RSFDo0GH8IkoUfB0k6O0+servvT2FM?=
 =?us-ascii?Q?fyLidO4IfmTppDzF5Txc03zs52T5uQk8BRLn/ElBaV/1ihgnD/ceVLu3heIc?=
 =?us-ascii?Q?XfdLOmxGnEOvvKLiisd3uG76NM6GmGfn1Ff+LKeTMRNV46RuPA1nC3DXSHgV?=
 =?us-ascii?Q?Vt3shIHuNEYih1gjfNUmBxMjVltOGBYVZp2oY/Su2Ag2vaUMnfwXNYhXpL6m?=
 =?us-ascii?Q?qzL75y02pXCZCq4yy6xkiW1H83lRP2d9815Ue0i0FKotdozF44fU+xRdcE4j?=
 =?us-ascii?Q?xDyhPSgQklehGA4I/i8FSIYK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420dfdff-a4f9-48ce-f329-08d98dda8111
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 23:46:25.6394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gzv6Uo0HmnGs66X2ZxpENdPHrgUwLnxC7hku113mfSgCn0va6VjARiEUCBGnejve7C8RQ9S2YNx4NTgWrmGfyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, October 12, 2021 9:18 PM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: shawnguo@kernel.org; linux-phy@lists.infradead.org;
> galak@kernel.crashing.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; kernel@pengutronix.de;
> linux-kernel@vger.kernel.org; tharvey@gateworks.com; kishon@ti.com;
> dl-linux-imx <linux-imx@nxp.com>; l.stach@pengutronix.de;
> vkoul@kernel.org
> Subject: Re: [PATCH v3 2/9] dt-bindings: phy: add imx8 pcie phy driver su=
pport
>=20
> On Tue, 12 Oct 2021 16:41:11 +0800, Richard Zhu wrote:
> > Add dt-binding for the standalone i.MX8 PCIe PHY driver.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  .../bindings/phy/fsl,imx8-pcie-phy.yaml       | 79
> +++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> >
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Error:
> Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.example.dts:30.3
> 2-33 syntax error FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:385:
> Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.example.dt.yaml]
> Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1441: dt_binding_check] Error 2
>=20
[Richard Zhu] I forget to merge to add the "#include <dt-bindings/reset/imx=
8mq-reset.h>" after add the reset property.
Sorry about that, would add it later.


Best Regards
Richard Zhu
> doc reference errors (make refcheckdocs):
>=20
> See
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch
> work.ozlabs.org%2Fpatch%2F1539660&amp;data=3D04%7C01%7Chongxing.zhu
> %40nxp.com%7C64619a3cd64446cf204008d98d82ca07%7C686ea1d3bc2b4c
> 6fa92cd99c5c301635%7C0%7C0%7C637696415146711570%7CUnknown%7
> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> LCJXVCI6Mn0%3D%7C1000&amp;sdata=3Djt2nbxfbKTBm1izvsYvsHEkMfSHqa6t
> 24B1sJICAtXE%3D&amp;reserved=3D0
>=20
> This check can fail if there are any dependencies. The base for a patch s=
eries
> is generally the most recent rc1.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.

