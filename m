Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFA6365A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhDTNpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:45:47 -0400
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:14368
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230479AbhDTNpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:45:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTK9FOBHoSM1IWQlHfXF43VjDTv+KyZ0ix1Kapp9pOnk+T7m1QDwBxiLk6lwSmZ9jWTgSzrqbE3YCkY/0V+5g2iuWJpHDIyijgAf5vEUiKqDSOr0zXn+xsOG5amdh2XgtxZQygHY2h4BykNgDqTCXmzDGQHC1pt+iLBkEYgtqdrEIy257LwuKe6IfASbXqj2D1CJEW5WcRQc46NCv/Vjhr/e5n6PrKZG+TmiqZgMtzSs46/QBcv1OxJlfJrhrvj8gSDkhA6tbnT2Uuha0n4EXjB4HOZM7j65ml1AbrhjoBbU8PLYKQudk7xRHEdKsr1JHq+4MhRcjq9UVqSk/smY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/vED/fqhGDPG5rGpCrF9DbKxLkq4Ld0heVT/s1BQ48=;
 b=covIJJxQKtckiJIz09yZO9JreCl0PruKRME233ea6r1zd3X5yRg9V7YgPsOAiXuFXAiS0ymepq6Woe7X5fMlQYeCaHTWrfJETOWykNbwoupD2nubwC9cdDADIAcZtlpJkq+HXK64bicTJoLmKU9qbR02RKPUVR8PjudFYdmaFRbW48q2+tlCjyVu3CVcnFRKay+yaY0PuSurNAyDIbUfI+XgSgkT/sDsArnruqVsLNH7C7JJ+6KN/kENHKwvqHuHBaS8lND41gYQTArszaJUGzgS6HFBHz1cmZHRVR4hrxcPjzjCVuw7wTdFWQcBjTC4YKCCnBpCfGZGz4/hVT7XlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/vED/fqhGDPG5rGpCrF9DbKxLkq4Ld0heVT/s1BQ48=;
 b=mTaZi2vJHISLz6YcN5gyAmwk2OhrvLbO0AF2V1l074hptLoWRdnE7uMa2DReTbh1InAf/Iofsyh8OqS2dLMUswN+ybs6FaJGkLiEYJwgctFtbm2aU80AtQeGP6guZcObAmTxtIRd1+X0zfWj8+YpdQnNXNwYMsgs7vcZBF1PKJw=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by CO6PR02MB7697.namprd02.prod.outlook.com (2603:10b6:303:ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 13:45:08 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26%9]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 13:45:08 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Dragan Cvetic <draganc@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Rajan Vaja <RAJANV@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        Amit Sunil Dhamne <amitsuni@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        git <git@xilinx.com>
Subject: RE: [PATCH 5/5] misc: zynqmp: Add afi config driver
Thread-Topic: [PATCH 5/5] misc: zynqmp: Add afi config driver
Thread-Index: AQHXNb4YA+92oo6dgkaPdwzLOSQ8W6q9GD0AgABSIaA=
Date:   Tue, 20 Apr 2021 13:45:08 +0000
Message-ID: <MWHPR02MB2623C9BAFBA0CB47449E8724C2489@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210420081153.17020-1-nava.manne@xilinx.com>
 <20210420081153.17020-6-nava.manne@xilinx.com> <YH6VPt6qfxdFhFEB@kroah.com>
In-Reply-To: <YH6VPt6qfxdFhFEB@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cdee38e-f422-4972-a218-08d9040282f8
x-ms-traffictypediagnostic: CO6PR02MB7697:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR02MB7697DD405386D092C64DD070C2489@CO6PR02MB7697.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3yKRwB+6pVP36TR1cLAqeTGsbvdv36tlfMn4Mg6VhSLP4HKAZLC1AhWv+lFZNrJJRDi09lMgHuApDkhLseVno58wEoifMaYhhBePVxhtvaOaP3hJXrXljz/EWQRwRXndBzge+qjJROgDt7ZZmpnSmT7gpPEWOOHDcWeoC87kIFTsOrBrpUpRTD6Wo7JTFepRi5i5cO/deOJ027vIyQVLOIexnIpc1RMBdYu21nZ1Lz9VItdN05uvOPHxmGi4YezyuwRzk+a+RhRU3nZAktyZBCfvC2XfsSQ8bhCBnZaqw9CGkSHkGCJ24C81Zsvqc5ZvtmLeZMoWzh5kzmsbh1bIWtDzL9BbLcxSu74JaMWZ4+KsvF/niSNMQHdo0NK7Hkg5hv3/JswzSdLm7xNiG8784KGTwXmZFuLPtxh895TLuua7jLz3cxyTkGKILfcCellur2XOVopaTdWzh3OMXce4ze1mK1IaWyTrbnQ7Q/WXtHyQ32AvuNTsFOTZN8o85nyii9OMo3BJY9tZPC/Lu5qDRu3INBp0Mc6mKCoHTCLuPxNWZwlCdDSq5lkSioLftP8NqKOWDfJvXMKrNYFdI7QqrrFpfF77CBvLi7Wjfuy+3U0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(83380400001)(54906003)(86362001)(4326008)(71200400001)(6916009)(52536014)(33656002)(76116006)(53546011)(26005)(478600001)(5660300002)(316002)(66446008)(186003)(8936002)(9686003)(2906002)(64756008)(66946007)(7696005)(66556008)(107886003)(38100700002)(66476007)(55016002)(6506007)(122000001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?q2iQCDTyJ3fTPpkyn1GuXQH0o/3Y8fEgu6f4W5vO5TgPhg4RWPVdbvpTwqVH?=
 =?us-ascii?Q?TUnWyS6oQfF0/UWP1fXFXH53sP0W9ZSbDmobue10X3uZZgk7FIMJ/2zkC8a4?=
 =?us-ascii?Q?j/n+G/vgPP7t+qUwZ8FTzyt4UoaIUHH6W6FlxyGBhMa6PvR2tjp9ieMAnSuV?=
 =?us-ascii?Q?qoFP0+hUX9CqduA9GGrrk00PVdna2h1rXzZMJA+1+psL+RZuJrhRw5sljXNB?=
 =?us-ascii?Q?jof8HGmLIY4/BMfGzsZlbjoYBgS2LH5KGYg65yV+XxcbQDmmZazIrqs1+wz5?=
 =?us-ascii?Q?3kgYwiXejqtB7p2EUqaDChbSQntIvMqHAo789BR1kcYu4zBhoflog1GzqBOm?=
 =?us-ascii?Q?CipyiQ1I1wmZc8b++KxLyVdoLxcIgiDYH0r4qd3D8PRO7YXNHN/UpHvcxWpi?=
 =?us-ascii?Q?99V4wjod8ULG/Xqn330tqO4/gM8I9VQz/nwceQ8EUxxDdzlcwCc0nSn+6ibb?=
 =?us-ascii?Q?QlO0NZ+b7bPF317paeYrfWtyLBeBIgk3ez/xNj05lSsT0hPPgbviXmTgMU/d?=
 =?us-ascii?Q?6e97EmS61FPZPB2883Oxw8pac/nR78vt9Ph9eWn04a8o2cQjq+KzJOug+NTE?=
 =?us-ascii?Q?XUx3o505iDeH83rfz1kJPHJ4Di/rgFFpy4Mk3TLgT9QuVsu1Ps7fXaJbaSN+?=
 =?us-ascii?Q?O+PLnfG5dZCkNeTMhfox+g2pM+DXqVs2BJumB8DulIVGafHNtdqkgpAAwdoz?=
 =?us-ascii?Q?rrHFyYjqYmGv/L9+jZm81tcZBvhuf9WLsxhKtsi0Puyv7rfxfWN58Q4mu7jl?=
 =?us-ascii?Q?dkZtGwessJZg9Ye4TWlDBScMqyYlX7i+YFxfg1MTNg4I8mVMsH0R1ABlfABW?=
 =?us-ascii?Q?sFQtyFC7cAnSzvoIeW27f4PN0t6Ah6qBdW3rBkLAvsKyhpnlHnPVYOCHTzv3?=
 =?us-ascii?Q?yZUYGn0pJnV7irCyMYm/KFSo+dS90lub7hJv2SKjKV55pMkP58q5ah1CQqDx?=
 =?us-ascii?Q?ddWtC8EkRk5T1T9jgq79lILahltzpeXknQ0hctuXAquXKnFIZjly6XjvjCXE?=
 =?us-ascii?Q?wBdaPzV6Jbl6ct6t+JjSQfZQqFLlecsFlpQd4u61KNVJlcIzPzr8BKCZNRWX?=
 =?us-ascii?Q?slWGILdFaoXfWGVNqqSXcPGjDSR3E2iN1Whq6FcU8C8mXfibvIRPDwJj1LGw?=
 =?us-ascii?Q?o+upa86OV3WSnKpysWP6+FOPvzCKPSRriKugswVEg7fxSfw3/c44f1dlHt/3?=
 =?us-ascii?Q?SzmXDK2e+lpukqfzqzIdjzqeM82Aa/osWaQjUhzH9TOHnFGir7DtLw1jIXXD?=
 =?us-ascii?Q?BEehRpfq+4qX8JGCiLodnD3lcqeDvQaT/gl/Cl3LTDKsv/5bfis5cIUaBo6f?=
 =?us-ascii?Q?+cjURQsz/HFdRkss+kvWl+0R?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdee38e-f422-4972-a218-08d9040282f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 13:45:08.2024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0nrIOGoo8Xx0PKUv4qiCtT75kQT+uYM9izyg2plmuuU0dSiR6MfjVkvUE2phuYgdSkJwaUGhCp5ptwNRfVshg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7697
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

	Please find my response inline.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, April 20, 2021 2:18 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: robh+dt@kernel.org; Michal Simek <michals@xilinx.com>; Derek Kiernan
> <dkiernan@xilinx.com>; Dragan Cvetic <draganc@xilinx.com>;
> arnd@arndb.de; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> <JOLLYS@xilinx.com>; Tejas Patel <tejasp@xlnx.xilinx.com>; Amit Sunil
> Dhamne <amitsuni@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> chinnikishore369@gmail.com; git <git@xilinx.com>
> Subject: Re: [PATCH 5/5] misc: zynqmp: Add afi config driver
>=20
> On Tue, Apr 20, 2021 at 01:41:53PM +0530, Nava kishore Manne wrote:
> > This patch adds zynqmp afi config driver.This is useful for the
> > configuration of the PS-PL interface on Zynq US+ MPSoC platform.
>=20
> Again, please spell out what those terms mean, as I have no idea :(
>=20

Will fix in v2

> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> >  drivers/misc/Kconfig      | 11 ++++++
> >  drivers/misc/Makefile     |  1 +
> >  drivers/misc/zynqmp-afi.c | 83
> > +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 95 insertions(+)
> >  create mode 100644 drivers/misc/zynqmp-afi.c
> >
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index
> > 877b43b3377d..d1ea1eeb3ac1 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -456,6 +456,17 @@ config ZYNQ_AFI
> >  	  between PS and PL, the AXI port data path should be configured
> >  	  with the proper Bus-width values
> >
> > +config ZYNQMP_AFI
> > +        tristate "Xilinx ZYNQMP AFI support"
> > +        help
> > +	  ZynqMP AFI driver support for writing to the AFI registers for
> > +	  configuring PS_PL Bus-width. Xilinx Zynq US+ MPSoC connect the
> > +	  PS to the programmable logic (PL) through the AXI port. This AXI
> > +	  port helps to establish the data path between the PS and PL.
> > +	  In-order to establish the proper communication path between
> > +	  PS and PL, the AXI port data path should be configured with
> > +	  the proper Bus-width values
>=20
> Please use tabs properly, you mix them above, checkpatch should have
> caught that.
>=20
Yes, Ideally check patch should report this issue but it's failed to report=
.
Will fix this issue in v2.

Regards,
Navakishore.
