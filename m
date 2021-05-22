Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A77238D5CE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 14:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhEVMbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 08:31:52 -0400
Received: from mail-eopbgr00059.outbound.protection.outlook.com ([40.107.0.59]:19952
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230466AbhEVMbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 08:31:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILTxrFbSV2ZY1sBuPpetlw2imZr53nZYt+Hh3UDFRhjfI2qwOgqjuGkrybSmhLlJZ/MK/Jlm2Dd5Ou3psfL4pfj5niMS/c4uYC+ciy5GmWUocuf42JjXq9gd+SvR8TfZ3yqRkF/t79NX3stWpumZV9AaY+TtIwPM6Vt5E/iyOZPDvfhJbXBOjcbRodh0X9Os0C8iRVzquVGAMj0VNDsvcoRtbRbcqttolhRXb6LrA2BFDzvxHzjN+mKS249Cdq5XkhSpCC7Etb5FJHtLpW+qrxbstEU7cDLVHAt7ZUpSe2KnsPj1XHivBvGdFgM+bcHLV2ROGBBFG0BsHLFx1pw0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDx+0EAHNAHTgElj9noX8aREPg5s11cOIhmqFnGUYPI=;
 b=Dk4TITjSlPXN0jcIjsxpUfZnce8cuFi6WF+BOjXXbCjP9clFXJpyTjx5cn4sCX+8tfixjr8p8hus3d+In6DcGrCJ9sBvTuzqR7FCEiEhYoQX3OgZNME4pmXz+Q3QNHUEPG3rCJFe2HY362XFH2PdzI5efQF4qJjaUZwF+7xT2A4nTS4a/OjmUOrXqNIoQeYpiik6UWH8xetMTMs5faeCzNEXA05Ujp3aaXh9FgMimS11wi3Wt1nXZej/6ybYm/1kz8lWwNLHmjvfStzgNmsbi2qpyvcn8Qmm3JiIByZlj2jNvk5NAkWWX0Hk0SA/9+n08rycgd2rv9L+7uIk0QFAEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDx+0EAHNAHTgElj9noX8aREPg5s11cOIhmqFnGUYPI=;
 b=VR941bT4s4a1HdNVFA7LwkQeKg58TYUaU3GQb/3ElfmzP8AoF+C8Kc+3kmuQWI7uCeH0+WYFDg/7hU3v6hpjILTFKKO56YaQ3JcOh83xQ95qI+ynqEA+pdZNaIOGTkwL4IcYXsa93ELp6xHYs3+0Va7vK1oSN2fZwkLLUkj60As=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5083.eurprd04.prod.outlook.com (2603:10a6:10:15::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Sat, 22 May
 2021 12:30:23 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4150.027; Sat, 22 May 2021
 12:30:23 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     Adam Ford <aford173@gmail.com>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
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
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH V5 0/4] soc: imx: add i.MX BLK-CTL support
Thread-Topic: [PATCH V5 0/4] soc: imx: add i.MX BLK-CTL support
Thread-Index: AQHXTivYvjigSv6Ln0ykHSUT474sdqruEhmAgACa4hCAABwLAIAApodQ
Date:   Sat, 22 May 2021 12:30:22 +0000
Message-ID: <DB6PR0402MB27608458A400B05D6A536AAE88289@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210521105919.20167-1-peng.fan@oss.nxp.com>
 <CAHCN7xJRN3W8pu+eALrv35rsQEDe9We9T5Ej=M0Et_ZuFe7vng@mail.gmail.com>
 <DB6PR0402MB276010E5B7C2318C8DC2685188289@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <CAHCN7xLTjE82EnzRXW84e_Lm63+hxfOeFXSdoZmVe6ujs3F2Pw@mail.gmail.com>
In-Reply-To: <CAHCN7xLTjE82EnzRXW84e_Lm63+hxfOeFXSdoZmVe6ujs3F2Pw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 719f034e-651f-49ca-cf33-08d91d1d5ebc
x-ms-traffictypediagnostic: DB7PR04MB5083:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5083CF3B44227FBE0CB5DA8AC9289@DB7PR04MB5083.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZTce5Hq7WO5Ip9Aoyfqz4GskrIuX6rioMTgMmPJrr5N3donhLLuVm40qgq4WdzLVfOewSAEBG4cmfnCFTIDQp8IS0DbeeMQKHnB6C7WKmYYJVcDWJCewrTTIKrbQS71TKArEReUHE4BKRYmSFqfAJQmXkHP71Zl0QSpkvVRr/7f1UfyHuMMMZeLuOGFyJEKhqAggvkAqmi2tjWCEEvk8vf2wvGSS3tSTJrZ71NJZ6y64eg+8aBAC6wLchZ64dzpx11C8nYVWKDjWmbuW1ZP7isV+RDjKWq1hIHecy9QVkfcGpRhFj70TGdgmiZE8tIdXpUfBpiPq2ZEA46G3qlFDmhMSTTvpFzGs/21XybdR4uqCWUi0rCY6AWOcxRmCV1ENhW6tXwFKL8PK7txfUBaLQVcHllS8y6mPvSv9jKl937gGMTWevy+FNa5jH+AKD0RJZxN3mX6KoydqIfcFa8/Sx6DJFBiLHCne222ZESF3q/8smmEwGSJRLic/SGMj99r0oU0ALWiqQaO53Yl29/JU1ssUJV+9v5dafTRNrY1ln/0TSUrWGm8dESgoWN7nDo2HeItJG5kE3p9LqEMKX3gZ7oYI2KIxMAUW8WjvNIlTt3chkAaWb0nxaLnqyxwcvnBhse47rTWtYteaR5ivDmAvF2gdWoNNUp8Yp3hxSx4xz190BbLATGG/Ghs1xzMyNwfd/SA1awvVJV9Ud8sYafzk6dC9jIKTHhRQs+Uc2H8W25A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(66476007)(38100700002)(66556008)(71200400001)(7416002)(122000001)(5660300002)(9686003)(4326008)(64756008)(66446008)(52536014)(76116006)(6916009)(316002)(33656002)(186003)(6506007)(55016002)(26005)(83380400001)(45080400002)(8676002)(7696005)(2906002)(966005)(53546011)(86362001)(8936002)(66946007)(478600001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?0ImvRNJg0x1vWFWekAw2+D245VhfaZXQrC8jU3TkQ04uFzvAj1sECB0cMp?=
 =?iso-8859-1?Q?8Ae32k2T7u6kOuKigro+51q1iO10tXVQhLg9eNzBZ7y8TNGo34DnLa0aWl?=
 =?iso-8859-1?Q?65P4B1fd1yuKmwMNOhdtAzjlRv62RrpHEFL2gXQa5xCZ3bKVGZ4AYFIDoC?=
 =?iso-8859-1?Q?EAPxOfKrR5SxEO3PyVReP/W5lVtLxIrCmPEdzivqMZRzZ5gQM+qIPB7yfK?=
 =?iso-8859-1?Q?i5yZp5PwJBqUaY9JCyRft5Kr49OsJYfrvyuRqIyFebiE19pNvGjAAzN2xv?=
 =?iso-8859-1?Q?4NP/1ccZe1ZdKcplAt/oSlKZySyjOS75EVEUXVEZHi5Ho0XAuUMYXzuT8Z?=
 =?iso-8859-1?Q?ykD5BANIcuCqiheFqzir8CCv+oOU6/dR9FQ6h+y5YpoRcPQH1Dz2tlFj/X?=
 =?iso-8859-1?Q?88ubCBMsnKbuqJdpnIq/gt1nJA/HBbhcseXDuRWVdT3gQ5a0I/+4cIh6Yu?=
 =?iso-8859-1?Q?2KGQilWUSJv2zH7i6uz7T1GYKxlaBwgEUAfxzPtAmP7GUR6cOXSjwuAZEg?=
 =?iso-8859-1?Q?WdUo4t2teY5jyHcCGjjKfwyACzKAi3QtOuMsD3Nan31mizC4SI7Iw0C/ck?=
 =?iso-8859-1?Q?ldABlFWJhi6DSRDSrDUKLLp2ARlWn+Ir7AyG26Gnt9zZzUV/ZWdF9JXeQx?=
 =?iso-8859-1?Q?paDZBSLepn13x7nEhF0wZUlkqHs6GKwOeyKyCA4eRVJ7NO8ctS8fpirMcD?=
 =?iso-8859-1?Q?Mu8MtK5UwjDHiZelueje8XZuJlcynuCsxil5XafECf3z91SZMzR4Q8HDNK?=
 =?iso-8859-1?Q?YZy2VpICnxJYc//LNAhsnEelue8MlqAIO8uhnXC3bd0qxFpiAbbmwqK5DV?=
 =?iso-8859-1?Q?Z8X61BJqPw10BDFdLDH/Izp75+hvVFTZ9PI32HEynocbttTbFvgDZPLxBa?=
 =?iso-8859-1?Q?jVWTYZ+U3Eq2RNE6u8yucFIvD06c+MgkFaBWbuj9V8SWlFdIedyTscNgxE?=
 =?iso-8859-1?Q?UmlEkZUI4bdo1VWKShK5jdUX6S9m524uTuCB1xELb0FSwebMfNXw3MxXf5?=
 =?iso-8859-1?Q?90DtSImNHGcVe4HnIzeEe8JyKsYDj42RPa3ultPyWL8lW5t9WOO8uUBsWJ?=
 =?iso-8859-1?Q?DpCMiNMfcb+iXFz4Y4dHLvuCLYT40HkuDhEN7rUfXKiFlzEub3r521QCDl?=
 =?iso-8859-1?Q?jfv07Lo3l20KQdKH+Oc4p0Hiix58OjaZ/c2Kn5lB9pdfnHPurxAgdYKqVg?=
 =?iso-8859-1?Q?qLFKEZ0w2oW71w4huBtA7B4u1UcurtLIZwsoss35H34EQ3M27fSgQv9kpl?=
 =?iso-8859-1?Q?X+YCGPssc9c9/7PpQmeyC/NCqQvJRLZRKX4Ej/MDKovJXsVbGwNfUZ61ya?=
 =?iso-8859-1?Q?A2Y5MWSZLnG/+nqPDC4TSKnKz7Vwm2WQgEzjapD4Mk5tH2rZfLX/xdabJ9?=
 =?iso-8859-1?Q?2meXU6l6Dc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719f034e-651f-49ca-cf33-08d91d1d5ebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2021 12:30:22.8485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oH0if4DkDl8oSf7fHQwyzmja4ezwKSlZT6dR7uGzmpaBhM4i+LK+8C1S2ROekVG4cIQvNZwKWTr6HAYYDEf2Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V5 0/4] soc: imx: add i.MX BLK-CTL support
>=20
> On Fri, May 21, 2021 at 7:54 PM Peng Fan <peng.fan@nxp.com> wrote:
> >
> > > Subject: Re: [PATCH V5 0/4] soc: imx: add i.MX BLK-CTL support
> > >
> > > On Fri, May 21, 2021 at 5:27 AM Peng Fan (OSS)
> > > <peng.fan@oss.nxp.com>
> > > wrote:
> > > >
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > V5:
> > > >  Rework the blk-ctl driver to let sub-PGC use blk-ctl as parent
> > > > power domain to fix the potential handshake issue.
> > > >  I still keep R-b/A-b tag for Patch 1,2,4, since very minor
> > > > changes  I only drop R-b tag for Patch 3, since it has big change.
> > > >  An example, the pgc_mipi not take pgc_dispmix as parent:
> > > >
> > > >         pgc_dispmix: power-domain@10 {
> > > >                 #power-domain-cells =3D <0>;
> > > >                 reg =3D <IMX8MM_POWER_DOMAIN_DISPMIX>;
> > > >                 clocks =3D <&clk IMX8MM_CLK_DISP_ROOT>,
> > > >                          <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
> > > >                          <&clk
> IMX8MM_CLK_DISP_APB_ROOT>;
> > > >         };
> > > >
> > > >         pgc_mipi: power-domain@11 {
> > > >                 #power-domain-cells =3D <0>;
> > > >                 reg =3D <IMX8MM_POWER_DOMAIN_MIPI>;
> > > >                 power-domains =3D <&dispmix_blk_ctl
> > > > IMX8MM_BLK_CTL_PD_DISPMIX_BUS>;
> > >
> > > With this change, I get a bunch of errors on boot.  The list of
> > > power-domains appear correct on the surface, but it also has trouble
> waking from sleep.
> > >
> > > [    0.695947] imx8mm-blk-ctl imx-dispmix-blk-ctl.0: invalid resource
> > > [    0.702849] imx8mm-blk-ctl: probe of imx-dispmix-blk-ctl.0 failed
> > > with error -22
> > > [    0.711259] imx8mm-blk-ctl imx-dispmix-blk-ctl.1: invalid resource
> > > [    0.716451] imx8mm-blk-ctl: probe of imx-dispmix-blk-ctl.1 failed
> > > with error -22
> > > [    0.724856] imx8mm-blk-ctl imx-dispmix-blk-ctl.2: invalid resource
> > > [    0.730097] imx8mm-blk-ctl: probe of imx-dispmix-blk-ctl.2 failed
> > > with error -22
> > > [    0.738398] imx8mm-blk-ctl imx-dispmix-blk-ctl.3: invalid resource
> > > [    0.743747] imx8mm-blk-ctl: probe of imx-dispmix-blk-ctl.3 failed
> > > with error -22
> >
> > It is just the imx8mm-blk-ctl driver matches with the new created
> > child device, because the child device points the of_node of the
> > parent device.
> > But this error will not affect functionality.
> > I'll resolve this issue and send out v6.
> > >
> > > If I have a wrong device tree configuration, can you please post an
> > > updated device tree?  I don't think an official patch for original
> > > pgc's were pushed as part of either series. I used this e-mail as the=
 patch
> to enable the blk-ctl.
> >
> > Do you have an device tree, I could give a look.
>=20
> I have a git repo where I've been collecting the various power domain pat=
ches.
> I have updated the imx8mn blk-ctl and device trees as well in that same r=
epo.

I put my dts diff here:
https://gist.github.com/MrVan/d73888d8273c43ea4a3b28fa668ca1d0
Not include vpu, lcdif, mipi, just gpc and blk-ctl.

Your dts has error, the vpu-g1/g2/h1 should use vpu-blk as parent power dom=
ain.
And the vpu-blk-ctl power domain changes as below:
power-domain-names =3D "vpumix", "vpu-g1", "vpu-g2", "vpu-h1";

Regards,
Peng.

>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.
> com%2Faford173%2Flinux%2Fblob%2Flinux-5.13.y-aford%2Farch%2Farm64%
> 2Fboot%2Fdts%2Ffreescale%2Fimx8mm.dtsi&amp;data=3D04%7C01%7Cpeng.f
> an%40nxp.com%7Ca5c04b8b13514290944008d91cc9d95f%7C686ea1d3bc2
> b4c6fa92cd99c5c301635%7C0%7C0%7C637572475532314749%7CUnknown
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DNjxeojlrUc5t1tmrpZrhmYL1jaGB
> QNHv8QVh2OcgMpA%3D&amp;reserved=3D0
>=20
> thanks for looking at this.
>=20
> adam
> >
> > Regards,
> > Peng.
> >
> > >
> > > thanks,
> > >
> > > adam
> > >
> > > >         };
> > > >
> > > >         dispmix_blk_ctl: clock-controller@32e28000 {
> > > >                 compatible =3D "fsl,imx8mm-dispmix-blk-ctl",
> "syscon";
> > > >                 reg =3D <0x32e28000 0x100>;
> > > >                 #power-domain-cells =3D <1>;
> > > >                 power-domains =3D <&pgc_dispmix>, <&pgc_mipi>;
> > > >                 power-domain-names =3D "dispmix", "mipi";
> > > >                 clocks =3D <&clk IMX8MM_CLK_DISP_ROOT>, <&clk
> > > IMX8MM_CLK_DISP_AXI_ROOT>,
> > > >                          <&clk
> IMX8MM_CLK_DISP_APB_ROOT>;
> > > >         };
> > > >
> > > > V4:
> > > >  Add R-b tag
> > > >  Typo fix
> > > >  Update the power domain macro names Per Abel and Frieder
> > > >
> > > > V3:
> > > >  Add explaination for not listing items in patch 2 commit log Per R=
ob.
> > > >  Addressed comments from Lucas and Frieder on patch [3,4].
> > > >  A few comments from Jacky was ignored, because following gpcv2
> > > > coding style.
> > > >
> > > > V2:
> > > >  Fix yaml check failure.
> > > >
> > > > Previously there is an effort from Abel that take BLK-CTL as clock
> > > > provider, but it turns out that there is A/B lock issue and we are
> > > > not able resolve that.
> > > >
> > > > Per discuss with Lucas and Jacky, we made an agreement that take
> > > > BLK-CTL as a power domain provider and use GPC's domain as parent,
> > > > the consumer node take BLK-CTL as power domain input.
> > > >
> > > > This patchset has been tested on i.MX8MM EVK board, but one hack
> > > > is not included in the patchset is that the DISPMIX BLK-CTL
> > > > MIPI_M/S_RESET not implemented. Per Lucas, we will finally have a
> > > > MIPI DPHY driver, so fine to leave it.
> > > >
> > > > Thanks for Lucas's suggestion, Frieder Schrempf for collecting all
> > > > the patches, Abel's previous BLK-CTL work, Jacky Bai on help debug
> issues.
> > > >
> > > >
> > > > Peng Fan (4):
> > > >   dt-bindings: power: Add defines for i.MX8MM BLK-CTL power
> domains
> > > >   Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
> > > >   soc: imx: Add generic blk-ctl driver
> > > >   soc: imx: Add blk-ctl driver for i.MX8MM
> > > >
> > > >  .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     |  66 ++++
> > > >  drivers/soc/imx/Makefile                      |   2 +-
> > > >  drivers/soc/imx/blk-ctl-imx8mm.c              | 139 ++++++++
> > > >  drivers/soc/imx/blk-ctl.c                     | 311
> > > ++++++++++++++++++
> > > >  drivers/soc/imx/blk-ctl.h                     |  85 +++++
> > > >  include/dt-bindings/power/imx8mm-power.h      |  13 +
> > > >  6 files changed, 615 insertions(+), 1 deletion(-)  create mode
> > > > 100644
> > > > Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
> > > >  create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c  create
> mode
> > > > 100644 drivers/soc/imx/blk-ctl.c  create mode 100644
> > > > drivers/soc/imx/blk-ctl.h
> > > >
> > > > --
> > > > 2.30.0
> > > >
