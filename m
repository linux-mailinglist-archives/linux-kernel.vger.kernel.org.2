Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B18D3AA134
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbhFPQ1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:27:06 -0400
Received: from mail-eopbgr1400125.outbound.protection.outlook.com ([40.107.140.125]:38509
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231511AbhFPQ1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:27:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZbhZfBQCHsJ/uHE1IO0Z646tjjoPrJuWD2YtiOMd1UbLUuQkRIJhAf2LvF+bRZbhnM0HrgX1UL2qgEdzplni+t5gt3F3Z5Tqeo05/Y2x7TDsVNKtsLyq6BtvmhRI6ip7k1frxhOXaViwMUaHII1NzwohhMkSpsasDg4+qeDyfIJrI4J36wTrtQtuV7knDsZ8z90BmcpKiSUI42aMoFqAEHu4D6Ji0YbYuFZ1vtRjtrgn4ouWumZpeUgi9wM2z/O/iq4D8sINtbcDv6ZFZutjQCnWzZ9b1JtpOkx3kAFeokEzsDcMri28V7F8J2r4K8Jwwacu907WsnyyE1ZC3Yv3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIfc0vnjW5/YLjs/2kg2U9W/XlNhLhTi9FtwNfpLmmM=;
 b=Gx8MAEVp2FKly7fkRTpOBZ4FAT9Fc/WfFJPVCeiaUsphe0vWovU2hH/STCAsfQbnB2P4VMlAJ9R1zyqBuqR74tRK583B0SllJn0j3WGLeLSCyj6mM+0AVTxFqp/gjKnVg0SX7NFiiyfiNmUin35jlpWF2sUlq66H/UDEdsBXzggi/ht9kjQRgKcul+Ih6WXAhcAUO1R26v4Wk+OtraNyoB2UC2H0N3yagHR6eGyQppx/Gp8/Y4QYarYpKH5uHq8npCueW4v+p3YtIMU2EOp0liAhAR3z7tNjrGmB+7XZMkV4pUs0Az3P0QTd7YzKfxrs23YI331JYRmjVm4qQkjEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIfc0vnjW5/YLjs/2kg2U9W/XlNhLhTi9FtwNfpLmmM=;
 b=TKHENmaXf2ERWJLddOj2yrY2xnt4HE1AmY4/gSr8bX7LWJy7I79fcnyour/8p2JIQ8n726nji1Qp1IMKrn4ZMHWRiUEfcFyEJrMwav+I70Dn8/C69Oq4ImsyDkk2munZ1spDpdNSqO9z86q3ragnLYLmtUF7gm7EtWjFgeavrRs=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OS3PR01MB6520.jpnprd01.prod.outlook.com (2603:1096:604:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Wed, 16 Jun
 2021 16:24:56 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::a53c:198f:9145:903b]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::a53c:198f:9145:903b%7]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 16:24:56 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH mfd v2] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Topic: [PATCH mfd v2] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Index: AQHXV86EpPNANrzU4UCJO/Td0zuOkKsVKxiAgAG8URA=
Date:   Wed, 16 Jun 2021 16:24:56 +0000
Message-ID: <OS3PR01MB65937F621F5A7B6C855D3627BA0F9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <1622652224-19103-1-git-send-email-min.li.xe@renesas.com>
 <YMiwEYLkbKocs8ux@dell>
In-Reply-To: <YMiwEYLkbKocs8ux@dell>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e173bfd3-7ba3-4d9e-3a24-08d930e34789
x-ms-traffictypediagnostic: OS3PR01MB6520:
x-microsoft-antispam-prvs: <OS3PR01MB6520EAB89393A4A243997922BA0F9@OS3PR01MB6520.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V1GyrlUChbQwLb52ovf01g0jo2na+exesGzuwmSSNQMgfHZPsvIQYwLKd2Ehq1l1XKN42hqJJpJ806p7htHF6hMbuL7+qmnFScBC9fiUGqY/JqCu+A0rwwicFcGtGHkbGzgv1YlVkrpIb76tZX65kiF5jmwLUw0G0/pbwMPDO5RO54EXG+P9Ou1VZ7Y9QfemZ+pnezhKtm3YwnO3WuY/lAHV+beCw+W/q+W3qjFAqQoH1cKqzzmrCIT0L+rdhgxluCRNI8LcS+hf54HIb0rswRkjFlAGRE5HOW1hZkOOAlh9TNtclQMixHGA+6wEG5PyWYbTKB9lfMStJo7bbPQo9Q+ky6TvcyX4DEeVMTj6MOiqwrMdX/U2vM1AvSvJjiz9XkeUT9mn3sQyA89PeK42mgydNcBZPWo/IZ8NP6hYJLgiP6nFv2fmE5PHDoVjhhgrgsiMHE/quJ4k4VJwcXggRyd/EubYC9lz72zr5w0ZYuSolLwbaC88XzfJ55YdXsi6zDoqrCilRneKIDJOhEN1t2hia+6R5W3R7t+MGwtRg7W+tmovGORH9Bd6jTI1s2hrZaiOwhwfTwvGuhuKefQuYfWGNFJRHZQP+XspSXw2MRQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(136003)(396003)(366004)(346002)(64756008)(4326008)(6916009)(122000001)(66946007)(66446008)(38100700002)(7696005)(66476007)(9686003)(66556008)(76116006)(6506007)(8936002)(55016002)(86362001)(19627235002)(478600001)(52536014)(316002)(33656002)(71200400001)(26005)(186003)(54906003)(2906002)(5660300002)(8676002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kRz5zhdZ+SS6IwmKCG20myfYgcQ8yZK3OHYbnv91rwkcy03rh/8waxBUM6ET?=
 =?us-ascii?Q?BDi9/37TPcelMZYLtWlfVvFeWLebto/hwVQ+j8XPrnAyjWdaR6GM+o0NYlT9?=
 =?us-ascii?Q?fuI1Yz26VjaQd0kGCvAKWEgBi6j2bezHn9yfJcpjw0bSwGjvJCi1R9v2zENG?=
 =?us-ascii?Q?zlrFziwHAHSwercsJIJdfO1FljPybborOA/u8d2MeYjt/q6IYxQLr8ObQewU?=
 =?us-ascii?Q?FIlrsYIXQdPycmHPcBW/itB0Ct7/3wAmbffDAAVteMIRh/HGreQFGM9O95Bu?=
 =?us-ascii?Q?ChRa9K3l880Oz6nrKHUjtm+88OhBF23WuL97gKkUfJeqNZTWRC5Q8Oa66kwJ?=
 =?us-ascii?Q?ZfKcxlHNqVGo3EaUOrzjCYc04fah414X2d3u5g3XhhvdSoH69LIreqF6LYn0?=
 =?us-ascii?Q?asR7n76GHzXIcciBZPrPilFlYU+I4RgP/2/LDYL8smZBTiX6WfSN042BLfqv?=
 =?us-ascii?Q?yZ7z046LXTuLUoO7l/DRI5C9pt1u7TlR0VyUwgEZMfKhNP+R5eDZM3rCLRG8?=
 =?us-ascii?Q?mXzG19fwXLgQzOnSb/q11im0s4h0oDWaafzG621y71ZM8jmAynLp8lhvIFtr?=
 =?us-ascii?Q?bHWJWiKU6+nnoIuahCC9tPy38AyEDVqSU2wUuyOblcT/E+oBoJDMLCXxsfC5?=
 =?us-ascii?Q?JJ5LSEa9U7vrmZSI/I1BYlfCeCSARuT5XqNSxteDHjfblgsuNzw5pmx5NQxJ?=
 =?us-ascii?Q?/78b8mJa3dIaZiuNK98TBquRQtre/j1Z+15lMByh5fkHvB4A70yrk6NYlCMB?=
 =?us-ascii?Q?fpkk4YLwz2yTacS2iDUA1sjVJPtfh4ORdVSj0/lIQQuDBl0CdWal6Tufz0eG?=
 =?us-ascii?Q?wKUZokMbyrd/IgT89wYxcK4BimwluF2JpLp3R6R4gqjKSz8bAvW94qvRAQ/F?=
 =?us-ascii?Q?q2WhIR3XtptBg1+b7aIhK/ST+iez1+7ws6Yuxu3A4hs7CDTcoepqEiu7nZyN?=
 =?us-ascii?Q?8dshXRyozwueH66gjKFxSm7nzm5nGFNUXO7t9XDSawrwQZ54XzJo2W8dK5+4?=
 =?us-ascii?Q?OmV7r1hWIMX+nnWeS3RkL9B/X0PDJ/epQPGsDsWExxCYd8bsZ1SO0ymsvzJM?=
 =?us-ascii?Q?6x36S2EHPzehuXr720MVRRprP1gD07OfDZBIG8DNL0An4VMS/TpcM9VntQ0N?=
 =?us-ascii?Q?NdxEu6ddfVoFM48f9va6I7tqDSoaaLCRau9P3PKLDURCSFGnpF6Tykma1/5R?=
 =?us-ascii?Q?SpQJ8G0DvJzrDxd1u+yToWaXURz/a+wKH2Q2cXU2v5QA6WM2WCTZSMows4vl?=
 =?us-ascii?Q?w/K045V509JSSZvTA29M+VzzsQaFbWCDDhtMssZRaUP9vcXF5xOSm2onF11J?=
 =?us-ascii?Q?iJ8G8I3bOgncv36HODkeTUmj?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e173bfd3-7ba3-4d9e-3a24-08d930e34789
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 16:24:56.2096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mGFfL9LS9/3ZUmxRWD/5SsJYSkqZ8ovbP/QNT+MmGJLY2/ffNBhZEaT/Yi9P4tJtt6AhCSXte+flOKHU3UJAfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6520
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/drivers/mfd/rsmu_spi.c b/drivers/mfd/rsmu_spi.c
> > new file mode 100644
> > index 0000000..f3a087b
> > --- /dev/null
> > +++ b/drivers/mfd/rsmu_spi.c
> > @@ -0,0 +1,265 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * SPI driver for the IDT ClockMatrix(TM) and 82P33xxx families of
> > + * timing and synchronization devices.
> > + *
> > + * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas
> Company.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/slab.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/regmap.h>
> > +#include <linux/of.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/rsmu.h>
> > +#include "rsmu_private.h"
> > +
> > +/*
> > + * 16-bit register address: the lower 7 bits of the register address c=
ome
> > + * from the offset addr byte and the upper 9 bits come from the page
> register.
> > + */
> > +#define	RSMU_CM_PAGE_ADDR		0x7C
> > +#define	RSMU_SABRE_PAGE_ADDR		0x7F
> > +#define	RSMU_HIGHER_ADDR_MASK		0xFF80
> > +#define	RSMU_HIGHER_ADDR_SHIFT		7
> > +#define	RSMU_LOWER_ADDR_MASK		0x7F
> > +
> > +static int rsmu_read_device(struct rsmu_dev *rsmu, u8 reg, u8 *buf,
> u16 bytes)
> > +{
> > +	struct spi_device *client =3D to_spi_device(rsmu->dev);
> > +	struct spi_transfer xfer =3D {0};
> > +	struct spi_message msg;
> > +	u8 cmd[256] =3D {0};
> > +	u8 rsp[256] =3D {0};
> > +	int ret;
> > +
> > +	cmd[0] =3D reg | 0x80;
> > +	xfer.rx_buf =3D rsp;
> > +	xfer.len =3D bytes + 1;
> > +	xfer.tx_buf =3D cmd;
> > +	xfer.bits_per_word =3D client->bits_per_word;
> > +	xfer.speed_hz =3D client->max_speed_hz;
> > +
> > +	spi_message_init(&msg);
> > +	spi_message_add_tail(&xfer, &msg);
> > +
> > +	ret =3D spi_sync(client, &msg);
> > +	if (ret >=3D 0)
> > +		memcpy(buf, &rsp[1], xfer.len-1);
>=20
> What's at rsp[0]?  Worth a comment?
>=20

I don't really know. This code is being used as is and tested working.
Can I find out and add the comment later?

>=20
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/mfd/idt82p33_reg.h
> b/include/linux/mfd/idt82p33_reg.h
> > new file mode 100644
> > index 0000000..fb41ab0
> > --- /dev/null
> > +++ b/include/linux/mfd/idt82p33_reg.h
> > @@ -0,0 +1,112 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/* idt82p33_reg.h
>=20
> Remove the filename, they have a habit of becoming out of date.
>=20
> > + *
> > + * Register Map - AN888_SMUforIEEE_SynchEther_82P33xxx_RevH.pdf
> > + *
> > + */
>=20
> Copyright.
>=20

Sorry, what do you mean by this?
