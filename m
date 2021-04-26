Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2C036AA4F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 03:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhDZB3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 21:29:20 -0400
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:21318
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231530AbhDZB3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 21:29:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUwKasYGKRpAvLO5Oe2lKpY/ytZYJsaI+biYDENq+2mmZ/Bpe9cshQZoC4h8uEPXaWuRqnPqpzU8oTejFGUFe4vODhah9gmTDa+VzRi8umYFssE5VMP5ETlBlBjuIWcbx9hjrpPq/DhK/51EH7h5zy40B3jVgeb7c8Of+bepxHgY3mduMyOEAq3SDR1EhCRGbbN4jbxuil97Efg7XwniMoMMnKr7BHJD2YUAZP+OsayGEtKzeiUZYtE4VQJ08IajVyqRi3OyHJezbOlkfgXrkPJEHvXZSHrrj8Zvc/R5056tNgC1Iu6VX57rRRMAHEg/jhYvIdhjxBffVCfTb3atwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InSHWYNyQvNG4MKgoQFKckaiyNMp4YyI9AdT0EYjnww=;
 b=OlwbqnDwHYYN0AKqCHst90JaOoBILL75ltD6zxqnlrbb6RDwJW7H64eXyfH5/pB2mhUwyUVj+7apNl/1y+Kze6xiQxrLzrc5GGS1567K1VeFH3TlVjjGVJ3zROE3jX39kAprDTej6f9edpYQfKM6VAE30JdSg5aXW2U4Agi6U9DsR2lqmwTtcfVfrq589vPxw/Q/KUWan7ewhDRWrDFmT7SYpgLITWNvZ/lnX1cFpGDePFFyLyOg1kcopEAIRNO5DTkZPNUWxvJwzERFmZ/D2bw0vqGHbcg+arspyAwNWTCqho8eiczSyAoZGY1i5GA7hJYVvR7WOAWekllOF33ZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InSHWYNyQvNG4MKgoQFKckaiyNMp4YyI9AdT0EYjnww=;
 b=ToVEf/4Wu47G6ylbcuTt1Vmnx6E9ZCksmg41hD4dYmH+EHVPP+L/3EstcBge9D9gZp0gu+FLT4CU5XTe1NJaLj6MPiFiLwzjr4dU+mve5BMWJtHf5cTYJhGJCU8Xq+4zBILj5z6sHf8DydczlYAEjmur1AgcJ7gBMlQQG4HJSBM=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR0401MB2303.eurprd04.prod.outlook.com (2603:10a6:800:28::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Mon, 26 Apr
 2021 01:28:34 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7%6]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 01:28:34 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE:  Re: [PATCH] arm64: dts: imx8mq-evk: add one regulator used to
 power up pcie phy
Thread-Topic: Re: [PATCH] arm64: dts: imx8mq-evk: add one regulator used to
 power up pcie phy
Thread-Index: Adc6O0IfUxBVtLjcTraazlbE6Esn/A==
Date:   Mon, 26 Apr 2021 01:28:34 +0000
Message-ID: <VI1PR04MB5853CB1B4E6C07C2DC3BC8D88C429@VI1PR04MB5853.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37e43f1d-a5e1-4a1a-5cea-08d908529c1b
x-ms-traffictypediagnostic: VI1PR0401MB2303:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB2303D14F7D0CF5346515430C8C429@VI1PR0401MB2303.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oiIMYDcEgnOy5QU9bU9aiPCm3B5kHQO8mb1x17Qk0er5hPXh5KNTnJ9tlNR1erPNRLwFmyFm2lDy2OnANKEh4YZ7PuBi7h7RR0FNJpRoyNmDwipZ70Ms8NztCfxLfPYsUdRjmOMs/Mz1XRjeNEc7kqt2aSV0EYiEKV2vUbXPA83qQfHTCXeIhjPK9/A6vpJFVjUE8BJlfgn4wSNLc8Drrc2l8dLOGDD5wqSl8pBDjE7a2CB3g2XOy3t4P3/1A9QqNamIgF5iRmZ6NrReVuRv3ZdYwWX+X0FcgvmtYfX8F3x1ALhRWrY49U6DlXldZiq+YFiRGF1EHDG0ElslEZC3Ql6ST7MFjB/evLVCCczCdRgW5uKApW/JxrYLOxdsTRRh9XoUWykBnO1m2EbMH8f8biXIK6SeOSUq+HyqaYIzp8FHtuMZHS7e7oQR2J0Zkcjb+nBdDqCM2MI3RSeFJsGiD2KbH908MvdC/dt8kWZGZZiAHzNay37MwmVK6LTVS0kzGIccDp6FwiKnbZwNAfQ5lF63Mbq6OLx6kyFM/lZ+9Ml8s/J/AhKkGiVmjdl2BlFs19k3msCD078QTMYI0KKa6K4rvtipXrOlui1D8GNdE3r1zPOv4cnXUNBT+GIm4tFd4UlyPsRmsNysCAiZGmD2ABowZ7sbxVaxkZO2LyS69TWpxck+hw70UvpPghwAlKo02bNulbzoUw0D5ICT6YYRtgU8gcI+h50b62iiXKXu0Ic=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(6506007)(5660300002)(4326008)(26005)(186003)(8676002)(8936002)(55016002)(9686003)(6916009)(2906002)(83380400001)(86362001)(71200400001)(33656002)(52536014)(54906003)(38100700002)(122000001)(966005)(316002)(66476007)(76116006)(66556008)(66946007)(66446008)(64756008)(7696005)(478600001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YAjImYygEpVhugLbOHYmfyJv+5MXGf2eO3GUrweowyukHnuRNE8bcYeAUTe5?=
 =?us-ascii?Q?Uq9vHQCWHSvTnWgHd+JxBRIbsVsbsNtnZXofdpZdtRe2ws649Hnu+K3fNkDp?=
 =?us-ascii?Q?csPqCCNtC3VOIKmKCxZb8S+kYb1BsbCEXvSzk8B8SPWtlDzJd/L/ESd72jNH?=
 =?us-ascii?Q?UioY/pLwLX+oZxPcUzc26vgzRuG63ayuHSy5yB5UBjtjaSthSoqIADTO/Efz?=
 =?us-ascii?Q?sx540Bwt4h5JAaqkMFrGPuHILSDXD03uNF6JDN3HKcXY4y8gsrcY9//HidTZ?=
 =?us-ascii?Q?M+mzIFLYrxPhHBrOXNJ4C3gJI+LDXun1vRwyM8HrlN9nFiwb6L86Teesh/PI?=
 =?us-ascii?Q?TojoQ+JR67666AdZiWl+rabVjLLcxYRwATHpSN+g/CquoQeRW3sa981ItnM0?=
 =?us-ascii?Q?qcFmXde1uA67ZEcjHC0Bz1V4Tlgxa6QXj/189/R6s+ok7RvqqJyO/QUMOBEf?=
 =?us-ascii?Q?e9v0G49g2o8yG5HopGrQN1j3B2P6E54oGQXBpwHGT31ATLwsPFoq9MBLscVF?=
 =?us-ascii?Q?ZJaHlkDTxj8HjqNf54RAnMf052GnECkhpFn371SE/HSIhQmg9zcqnvspGjbz?=
 =?us-ascii?Q?fLf79IpVhQLdUSGrk6yHOYuN9k3EsnaF8XeZmDdhbJBKufM30wL6iXNtTvf/?=
 =?us-ascii?Q?CfdhvPNS9GQ/VrfaFDEWv0FrwJHz0M1qU9wyZ3gDjyDclm4fM3fZNHhCreA/?=
 =?us-ascii?Q?EUE8k1yYlSmJCrblxKmZtugYkaYXNjx1VEcnB0KHSt0V8rzVziEJT74340aP?=
 =?us-ascii?Q?Ln/iW3SnVQPuAkBZ38VqGKaF93dgXbJRNf81Vzcy0ygJ8Nb8w8PenqpKxW1K?=
 =?us-ascii?Q?lel/XizanamjXMDMpiMcjr9+gqNJjFJ0NS69qSvMa4jvv3Q64uF6upIEJA7R?=
 =?us-ascii?Q?Zvk8buHGnERl04NAeIllFlbNbdz7DZfACPGk+xTIZmsKrNFFo+hO4DaTdyL4?=
 =?us-ascii?Q?OrepsUoukgAcvSxON9Xk7BjdAIx/F28asVqgRG3p/2H447w98h1OxBfCDHVA?=
 =?us-ascii?Q?MK+VQ04cFNdHmaPVqiXoIikSb7lWEDYmSI4Pz7FKJYQva1zbQA5q/Gy+osaX?=
 =?us-ascii?Q?vCthhnxBu6/0gL+vPlXvbWHHDttijLN/pfsfU+YS4ShN1khFhKTWs8Bmk6Vs?=
 =?us-ascii?Q?RDmgKWi4oleIZURsQfbCvDRM67N53nGzTVdrIRAnaBsyTU3VsfYQ2jSqYU74?=
 =?us-ascii?Q?LXRkrFXL9a++7Hb76sKy/kKLwU75CYxHrd588AVxckzMO8Z1KvcDDyy/xjyL?=
 =?us-ascii?Q?fZgkw/DTQw6emXfoGGkXMIgFtaM75grzlcbKXO3rofE+a3CwBB8j77Hqr5zt?=
 =?us-ascii?Q?gD3x2YGFfJiCbzRmpxseORuL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e43f1d-a5e1-4a1a-5cea-08d908529c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 01:28:34.7426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RsvaWs3tumDaX2/CbVQhxO8D6Cwtw+bxDT/iCPkAa1M6knS6syOo1qYHL3Wc62pUucEMreHCNQDTYxl383HLrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2303
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
<snipped>
> Subject: Re: [PATCH] arm64: dts: imx8mq-evk: add one regulator used
> to power up pcie phy
> On Mon, Mar 29, 2021 at 04:06:03PM +0800, Richard Zhu wrote:
> > Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
> > In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
> > sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design,
> > the VREG_BYPASS bits of GPR registers should be cleared from default
> > value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8 translator would be
> > turned on.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > index 85b045253a0e..4d2035e3dd7c 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > @@ -318,6 +318,7 @@
> >                <&clk IMX8MQ_CLK_PCIE1_PHY>,
> >                <&pcie0_refclk>;
> >       clock-names =3D "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> > +     vph-supply =3D <&vgen5_reg>;
>=20
> Hmm, I do not see this in the bindings doc.
[Richard Zhu] Hi Shawn:
The binding document changes are going to PCI tree by the following patch.

https://patchwork.kernel.org/project/linux-pci/patch/1617091701-6444-2-git-=
send-email-hongxing.zhu@nxp.com/

Best Regards
Richard Zhu

>=20
> Shawn
>=20
> >       status =3D "okay";
> >  };
> >
> > --
> > 2.17.1
> >
