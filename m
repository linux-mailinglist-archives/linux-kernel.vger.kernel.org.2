Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E2D3B8011
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 11:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbhF3Jg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 05:36:56 -0400
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:33966
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233696AbhF3Jgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 05:36:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzHgeTFeufRWD+Cu8rtJjeik1+197c/fbp/RrEuxlUkHHGwd7Dw1iKMEEbg8vBl/gWswrfHUJBbw63iEpum/HHeIKAV23Yj28WfzTZevxq9a9EyANuuT5in5d6FOYv++pYCYoKHnqhkzhicCuXTPRavEFSSjPws2fsVfubUFg2G0CS9Ca+muCw3YTQ6oqjUCa5L2MWfh8VFJojqxGyPwSIsM/kMR8Nmp6XiENbnBQCAFW4FqM+ElWDBWXaILILlKEOhaxvGARowgu/KedIjLOahgj9tUrvqajL6TbEddiC6r8nPI4il7SzsDWSrhNpZ17OpX9pWtYDjuWq5ieRahNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igr9JDkF4kZ3EHTWjh87PkuIhKopblAp7kmq/4c63cs=;
 b=jP4AWtB0o4XEennHzD3IiJWQ5iBEl0XtcODCDusizgGgij/2dtyEeX9N/wCv5oNXc7iPWZAm9Yumduze9WUldrSQf/OIwTCiCpklwKNn1ySQdNKJJ/58/rUmK8mZVWKFKyxekKlY7GJrBHqi73FLCMNpB8ek9NJEc3r8AoqgMTSQlvwnH/opWkDdacrg1Vg6vKB4VPgJQaPwF151gSrgiqS8WHShOOx80dK8Ev7ov98X+5hAUv3/JjPyE5u01OCVovu1ukRQ7NWLczcJECrPkX20FtdwVzlrmvpDTOW3c5yM4vlOMEaLize5t+UoPvtZAjfvLx9OybNv9/TmSTXM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igr9JDkF4kZ3EHTWjh87PkuIhKopblAp7kmq/4c63cs=;
 b=V00S/LXHDx/vSVWQfPS1eY1v66IhZnvt7Tu+s7hxSJLtYyPOGTYsk3zNY+DxQFK3wjdNtR4L6ksyOVlSlQcOaWhbnGWH8duym2dn6QNlGpy/g2tSnNXJg5riuUlcPj1a5/uZu6OJCYYdbLozmuzqdk8IJc6r2sMcZ9TDririJ6U=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4492.eurprd04.prod.outlook.com (2603:10a6:5:39::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 30 Jun
 2021 09:34:19 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 09:34:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     Adam Ford <aford173@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?iso-8859-1?Q?Guido_G=FCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: RE: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
Thread-Topic: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
Thread-Index: AQHXbLPhaqB7oWkKdU+X3YAn8YaA5Ksq+0kAgAFQ7QA=
Date:   Wed, 30 Jun 2021 09:34:19 +0000
Message-ID: <DB6PR0402MB2760B05081D54D775B8949CA88019@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210629072941.7980-1-peng.fan@oss.nxp.com>
 <CAHCN7xJgqRfg1sHNbcpdEFaLHUwhYxe7_r5SEMDqSaCPFXX7UQ@mail.gmail.com>
In-Reply-To: <CAHCN7xJgqRfg1sHNbcpdEFaLHUwhYxe7_r5SEMDqSaCPFXX7UQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0559e119-4928-4415-cb0a-08d93baa3c77
x-ms-traffictypediagnostic: DB7PR04MB4492:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB449297C7324C72DA3CACEC85C9019@DB7PR04MB4492.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JISrZPtEJcLQC3H3//PJjV2DkCNOy7cTBkkXRzeYqiUmVBrC3uaOgTT0g8WnMjnxCIB/aeS3FGh8e+zfmzz6d/HCMExaRaVosIGvGGBfbfMRmNM9J1E+bGFHFfCNsrljZhcosF35DtMNE0oPLJ1pXc8Yw26UFt+K5rFdkb4a6iKzzwEQK5qaQzlhI/uZKYkJ//FdAkxnsU6KzAzcCYupqes8ZrdW/gQA7ueh2qT8iBIgaca1DFtfMVPiOIjmu1CgJX9cy9M0GgrY1OamaIXE+/pydxVkaePD+58qBMeGpzlO1FHmeIhGiyLJ4ABS4bG5FFeewqnY7Lof+yq9xSalUdpZ9EHQhYsi5ntM+kgvzbvFSE2Q77M8PwxnNiTlyMK7CRVLZBC9kmYiaqVfu4PxlwVfiiK48hQMbatfEa8y9Hl7NuQmy5KzBFf0owZSjOXNPc4WiYkC0qnZF3oB1BS28j/dSr0R10AdCOkKPgrhu6Lsm2UrclHMkKa1LFh4ka4X48trPwvmu2b+LM1eAZHxtEl9hEOo9+6qD1iWYj9oKK4NwRi0yPom1Sngj+54KnQBvt2xgvDbHlmexPuKKOjdbXevz4YVXIm25PMnnxb6dFuRvjM7zNNo2RA5hqqvgbM/3XV+OdCH9ygGpHpiW6Pc8L/3JBatCKwdaXhsstL5zi4mtOYy6mpkNVQFbP4YGic9KTugLnQfktoUbFFCW6zyWWYvT6etXvUk523WMq+biJF9gJAS4Q/v4C78uXPQXgKzXgUCNO982f7rFcJ1zizKc9kRj1AemsSzA6BpXh4FZuFOhG3xsB2iUM+xBrfHNUWa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(7416002)(966005)(55016002)(71200400001)(316002)(76116006)(66946007)(45080400002)(83380400001)(52536014)(5660300002)(2906002)(4326008)(66556008)(64756008)(66446008)(66476007)(33656002)(9686003)(478600001)(110136005)(186003)(7696005)(122000001)(8676002)(38100700002)(54906003)(8936002)(6506007)(86362001)(53546011)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?L7yj08i5muzo+6laUkHFc2bYetoF+YN4A0spXGyZA7RBR3cdV9MpRwl+ay?=
 =?iso-8859-1?Q?wAsWLVWfGN7jWenSNaOYjycfv8qL1sQvatuA7GfUdxDmHtG/w99MFbeoXQ?=
 =?iso-8859-1?Q?V1Wk4A/6oSEZDt5NagCA7mApxSC1K0hnqqRJ4plTpFnjmQX2TJhNv+Lw6F?=
 =?iso-8859-1?Q?IyjNGJqA1hShLXGjW5SUXQhEKAs2xHebrgvYMJwnmryF3Ziu6lafWjy5tO?=
 =?iso-8859-1?Q?CDKMIlPnuqYj0NUoIri6E2wbL1ztNqeS7XkoucszXR15B0NIGSY+c6hwKM?=
 =?iso-8859-1?Q?9qEz4ke/PuHUAwxJdzsEwkTdWUs5isZnZR2VHcASCn/VAi+8y/5q6cFLYd?=
 =?iso-8859-1?Q?N1DDAT7IIL6QEUUJIH4CasIivdnVopUfXkaHryFPnFjYw/jnACU51BMKa3?=
 =?iso-8859-1?Q?R6QAE5tnCxWjqF2Pk8dd90pYNEINSt1E5fivJ235HcF3ivi7N9HtvsHHDd?=
 =?iso-8859-1?Q?3q5R5yWmTMiczRwH63Y3t9YJDkR0nIa/IrCBaNGqWG8AsWZZ+K2jtiFdAo?=
 =?iso-8859-1?Q?uFQaacxxPYy9o7eC2IkoVrzHB/3krjxz2GAhF3lPGoXD0oH/h3CPHsqQoJ?=
 =?iso-8859-1?Q?PqKIrAb4LvJ3FsS5V6rEpLeem4ajLPzuOYPGYUYKm/BFpP9rRQR+eohypm?=
 =?iso-8859-1?Q?bLRNMXEBhuQvloubV4rFpUJg0Xallg9K8DUqkxxQ8dwjSXW+WJlVQ6qjOt?=
 =?iso-8859-1?Q?iHinS/A8IZ0zLqmuqLz7cfcg0+1JNKvERek/rVp03Jll8CXQKfyk/lZjw4?=
 =?iso-8859-1?Q?lsPM0ThH8aL+aUnUEaD90ZwNEM179IecGEILGShB3jkD6yZw57WVxyhR0n?=
 =?iso-8859-1?Q?T2e1Teo+7zdTAgl+Iu2uHd1w1yx+7l2bMZ7qVJqVZKhF2+aIX31/tkGasU?=
 =?iso-8859-1?Q?KOEFvZgUOO9F1RkBEIHFpIKg9Zr8+2MxS07XdkwU5BTypSpH8fvFgN1FbT?=
 =?iso-8859-1?Q?qWK6n+OMoMp9W1syLvyAPsmWlkOmQ33rSNdKIZThb5cm3wdZbJ+BuwXaCt?=
 =?iso-8859-1?Q?faBriei7+TmYfEUzWg77o6ph8MBrRmJHyq62dy4YSd4Jv4iZ7sx17RvWN5?=
 =?iso-8859-1?Q?oNAckgnSfhEsCP5tBXh72YkCQs5IOcjaRDE7cOQyMA9ZXErH35F3f9xVPH?=
 =?iso-8859-1?Q?GUXnqcB8v4fr2DbyZlg1lnMyGG2XOte0qkTWOqUVpt4HJ3e8ZaJrkOFzFe?=
 =?iso-8859-1?Q?QYGyOIvj2T5EgF2pFCl8uzygfQ3mjbXec8RJgLZojRi+SikPCR//aoZjeE?=
 =?iso-8859-1?Q?UcwzXYgGBfMKJMpVn9tKJPme39hYkrSjeEiQ6kZKTXTB9ac3NHht/76Yzg?=
 =?iso-8859-1?Q?KpBo9TAIJJKPtaxJAmXx7UoT2Syx+h4slEMYRIFYjz0H40rtrzkU6aZQf6?=
 =?iso-8859-1?Q?fRrca9bI8x?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0559e119-4928-4415-cb0a-08d93baa3c77
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 09:34:19.3239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +M/rOliCKhk7194HmAXqYR3gz5IMl27sIvzrB7ZHTMKfTuG67Y6fVI6zUaeISGGPg1HjB7LhH3PPUIvWlEyW5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4492
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
>=20
> On Tue, Jun 29, 2021 at 1:56 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> wrote:
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > V8:
> > Revert one change in v7, force goto disable_clk for handshake when
> > power on in patch 3 One minor update to use if{} else {}, not if{};
> > if{}; in patch 3 Typo Hankshake->Handshake
> >
> I am using ATF, branch lf_v2.4, from the NXP code aurora repo with U-Boot
> v2021.07-rc5
>=20
> I applied this patch against linux-next, I applied the pgc patches [1], a=
nd the
> suggested power-domains to the otg1 and otg2 nodes.
> I am able to boot the device and use USB, but with this applied, I cannot=
 wake
> from sleep.  If I revert this, the system wakes from sleep again.

I just tried linux-next without this patch on iMX8MM EVK, suspend/resume
not work. Per my last test, it works before. Not sure what changed in kerne=
l.

Which kernel are you using, any commit or git repo? I could try on imx8mm
evk and debug the issue you see.

Thanks,
Peng.

>=20
> [1] -
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch
> work.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F202106041110
> 05.6804-1-peng.fan%40oss.nxp.com%2F&amp;data=3D04%7C01%7Cpeng.fan%
> 40nxp.com%7Caccded5458c049d67fa308d93b0182d9%7C686ea1d3bc2b4c6
> fa92cd99c5c301635%7C0%7C0%7C637605699944911752%7CUnknown%7C
> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> CJXVCI6Mn0%3D%7C1000&amp;sdata=3DKf6orRXmScWHDTgD2FOV8OBsgG0p
> GVs1byVZTHT0gVI%3D&amp;reserved=3D0
>=20
> I have not enabled video, GPU, VPU nor CSI.
>=20
> Just in case there might be a power-domain dependency missing, here is my
> power-domain dump:
>=20
> root@beacon-imx8mm-kit:~# cat
> /sys/kernel/debug/pm_genpd/pm_genpd_summary
> domain                          status          children
>             performance
>     /device                                             runtime
> status
> -------------------------------------------------------------------------=
--------------------
> -
> vpu-h1                          off-0
>             0
>=20
> VPU_BLK_CTL_H1
>     /devices/genpd:3:imx-vpumix-blk-ctl.2               suspended
>             0
> vpu-g2                          off-0
>             0
>=20
> VPU_BLK_CTL_G2
>     /devices/genpd:2:imx-vpumix-blk-ctl.0               suspended
>             0
> vpu-g1                          off-0
>             0
>=20
> VPU_BLK_CTL_G1
>     /devices/genpd:1:imx-vpumix-blk-ctl.1               suspended
>             0
> mipi                            off-0
>             0
>                                                 MIPI_DSI,
> MIPI_CSI
>     /devices/genpd:1:imx-dispmix-blk-ctl.2              suspended
>             0
>     /devices/genpd:1:imx-dispmix-blk-ctl.3              suspended
>             0
> vpumix                          off-0
>             0
>=20
> VPU_BLK_CTL_BUS
>     /devices/genpd:0:imx-vpumix-blk-ctl.3               suspended
>             0
> gpu                             off-0
>             0
> VPU_BLK_CTL_BUS                 off-0
>             0
>=20
> /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.7
>  suspended                  0
>=20
> /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.8
>  suspended                  0
>=20
> /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.9
>  suspended                  0
> VPU_BLK_CTL_H1                  off-0
>             0
> VPU_BLK_CTL_G1                  off-0
>             0
> VPU_BLK_CTL_G2                  off-0
>             0
> DISPMIX_BUS                     off-0
>             0
>                                                 CSI_BRIDGE,
> LCDIF
>=20
> /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.11
>  suspended                  0
> MIPI_CSI                        off-0
>             0
> MIPI_DSI                        off-0
>             0
> LCDIF                           off-0
>             0
> CSI_BRIDGE                      off-0
>             0
> dispmix                         off-0
>             0
>                                                 DISPMIX_BUS
>     /devices/genpd:0:imx-dispmix-blk-ctl.4              suspended
>             0
> gpumix                          off-0
>             0
>=20
> /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.5
>  suspended                  0
> usb-otg2                        on
>             0
>     /devices/platform/soc@0/32c00000.bus/32e50000.usb   active
>             0
> usb-otg1                        on
>             0
>     /devices/platform/soc@0/32c00000.bus/32e40000.usb   active
>             0
> pcie                            off-0
>             0
> hsiomix                         on
>             0
>=20
> /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.1
>  suspended                  0
>=20
> /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.2
>  active                     0
>=20
> /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.3
>  active                     0
>=20
>=20
>=20
> > V7:
> >  patch 2: update patch title per Shawn  Patch 3: Addressed several
> > comments from Shawn
> >
> > V6:
> >  Thanks for Adam's report on V5.
> >  Resolve the error message dump, it is the child device reuse  the
> > parent device node and matches the parent driver.
> >  Filled the remove function for child device.
> >  A diff dts file for upstream:
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgis=
t
> > .github.com%2FMrVan%2Fd73888d8273c43ea4a3b28fa668ca1d0&amp;dat
> a=3D04%7C0
> >
> 1%7Cpeng.fan%40nxp.com%7Caccded5458c049d67fa308d93b0182d9%7C68
> 6ea1d3bc
> >
> 2b4c6fa92cd99c5c301635%7C0%7C0%7C637605699944911752%7CUnknow
> n%7CTWFpbG
> >
> Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%
> >
> 3D%7C1000&amp;sdata=3D9FcnPd4nwmdjOqrQCTz0YNgUmVQ9UzTHpfh33LKI
> 7cs%3D&amp
> > ;reserved=3D0
> >
> > V5:
> >  Rework the blk-ctl driver to let sub-PGC use blk-ctl as parent power
> > domain to fix the potential handshake issue.
> >  I still keep R-b/A-b tag for Patch 1,2,4, since very minor changes  I
> > only drop R-b tag for Patch 3, since it has big change.
> >  An example, the pgc_mipi not take pgc_dispmix as parent:
> >
> >         pgc_dispmix: power-domain@10 {
> >                 #power-domain-cells =3D <0>;
> >                 reg =3D <IMX8MM_POWER_DOMAIN_DISPMIX>;
> >                 clocks =3D <&clk IMX8MM_CLK_DISP_ROOT>,
> >                          <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
> >                          <&clk IMX8MM_CLK_DISP_APB_ROOT>;
> >         };
> >
> >         pgc_mipi: power-domain@11 {
> >                 #power-domain-cells =3D <0>;
> >                 reg =3D <IMX8MM_POWER_DOMAIN_MIPI>;
> >                 power-domains =3D <&dispmix_blk_ctl
> IMX8MM_BLK_CTL_PD_DISPMIX_BUS>;
> >         };
> >
> >         dispmix_blk_ctl: clock-controller@32e28000 {
> >                 compatible =3D "fsl,imx8mm-dispmix-blk-ctl", "syscon";
> >                 reg =3D <0x32e28000 0x100>;
> >                 #power-domain-cells =3D <1>;
> >                 power-domains =3D <&pgc_dispmix>, <&pgc_mipi>;
> >                 power-domain-names =3D "dispmix", "mipi";
> >                 clocks =3D <&clk IMX8MM_CLK_DISP_ROOT>, <&clk
> IMX8MM_CLK_DISP_AXI_ROOT>,
> >                          <&clk IMX8MM_CLK_DISP_APB_ROOT>;
> >         };
> >
> > V4:
> >  Add R-b tag
> >  Typo fix
> >  Update the power domain macro names Per Abel and Frieder
> >
> > V3:
> >  Add explaination for not listing items in patch 2 commit log Per Rob.
> >  Addressed comments from Lucas and Frieder on patch [3,4].
> >  A few comments from Jacky was ignored, because following gpcv2
> > coding style.
> >
> > V2:
> >  Fix yaml check failure.
> >
> > Previously there is an effort from Abel that take BLK-CTL as clock
> > provider, but it turns out that there is A/B lock issue and we are not
> > able resolve that.
> >
> > Per discuss with Lucas and Jacky, we made an agreement that take
> > BLK-CTL as a power domain provider and use GPC's domain as parent, the
> > consumer node take BLK-CTL as power domain input.
> >
> > This patchset has been tested on i.MX8MM EVK board, but one hack is
> > not included in the patchset is that the DISPMIX BLK-CTL
> > MIPI_M/S_RESET not implemented. Per Lucas, we will finally have a MIPI
> > DPHY driver, so fine to leave it.
> >
> > Thanks for Lucas's suggestion, Frieder Schrempf for collecting all the
> > patches, Abel's previous BLK-CTL work, Jacky Bai on help debug issues.
> >
> >
> > Peng Fan (4):
> >   dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
> >   dt-bindings: soc: imx: Add bindings for i.MX BLK_CTL
> >   soc: imx: Add generic blk-ctl driver
> >   soc: imx: Add blk-ctl driver for i.MX8MM
> >
> >  .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     |  66 ++++
> >  drivers/soc/imx/Makefile                      |   2 +-
> >  drivers/soc/imx/blk-ctl-imx8mm.c              | 139 ++++++++
> >  drivers/soc/imx/blk-ctl.c                     | 324
> ++++++++++++++++++
> >  drivers/soc/imx/blk-ctl.h                     |  85 +++++
> >  include/dt-bindings/power/imx8mm-power.h      |  13 +
> >  6 files changed, 628 insertions(+), 1 deletion(-)  create mode 100644
> > Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
> >  create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c  create mode
> > 100644 drivers/soc/imx/blk-ctl.c  create mode 100644
> > drivers/soc/imx/blk-ctl.h
> >
> > --
> > 2.30.0
> >
