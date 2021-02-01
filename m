Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDDE30A292
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhBAHTx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Feb 2021 02:19:53 -0500
Received: from mail-eopbgr1310120.outbound.protection.outlook.com ([40.107.131.120]:11906
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232075AbhBAHTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:19:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSiXhSWDXa80XiKKJ7488w2AQyUIGEb4wAt57408EucHGfcUA8qAjKpNnfSTnoY9V09nd3Uj83hP+cmnB3oWI+3hB9k0lsOkmui/0HKHgTI53VOMunznXaJo1+NDQ9T54hDTZV6+ydyuuk2OtAK/eiZf1mDdFBt5uRCP0MZ+MGfsfdqMAPZiAMN6rROQWEKr8MU6waLMerMyyR7cZPGMKRJw3Tv7hxCRPXsbNf/aXHuAQS/l0kMveYAI2pooYFRQUDirlh6syoy0/DI5W3vowp8rs+CHyd4KmPkWhJW3ElOhio9MqCRBwU9lFrNBv9AQT+547I3qStNl4oen6RkVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mIsDc4Zsy6RLoqU0au1TDLLNgRqrBHFay0Wkw1VAB4=;
 b=JxZpGEElGkhxRaoxGQDcpYRmHzUyT3FXqsP4I0HWKMtEEJSncGjQVl4HFt4DPt/h3DaZdtDdm0w8YHuZM2hOY5dHJNE9cPxf4L+xcm1HVS5pv8HbX+Uc1fXhpYRt9adMf6HgmX11pl1V08PnaE4x/0BJp+RzkDVl73gca2gyaufSWCxtWSwhyUgdYNnT5lalYgxFhssR+cAdDSY8LWsWXUzpwy2GCsESwJkvqxqn/RyEUilHEjZ4RUJwR/86FaowqYO39ZwdgC4V3dWEgllAuBI6QuG/aDBgRkb7TIHk5i4UH0tbCLMWpL0fbOb48EWYzpzkIDcFLIIcNmQdbmONgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK0PR06MB2706.apcprd06.prod.outlook.com (2603:1096:203:58::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Mon, 1 Feb
 2021 07:16:37 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::116:1437:5d9a:16e9]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::116:1437:5d9a:16e9%6]) with mapi id 15.20.3805.024; Mon, 1 Feb 2021
 07:16:37 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>
CC:     BMC-SW <BMC-SW@aspeedtech.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/1] clk: aspeed: modify some default clks are critical
Thread-Topic: [PATCH 1/1] clk: aspeed: modify some default clks are critical
Thread-Index: AQHW8rO2P68MqUiJ10e4e7ob+JK4oapC7pCw
Date:   Mon, 1 Feb 2021 07:16:37 +0000
Message-ID: <HK0PR06MB33809710CB2D6300137BF92BF2B69@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20200928070108.14040-1-ryan_chen@aspeedtech.com>
 <20200928070108.14040-2-ryan_chen@aspeedtech.com>
 <160264382296.310579.9835482254268204873@swboyd.mtv.corp.google.com>
 <CACPK8Xe-_hTey7hTJjG2-EcDsTN0qOw3bWBcrZZohEK3QOJuvg@mail.gmail.com>
 <160269577311.884498.8429245140509326318@swboyd.mtv.corp.google.com>
 <adadc9ef-32ab-0a79-327c-c499c1c04093@sholland.org>
 <HK0PR06MB338049BAE1D1DAE7567F620DF2A00@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <57a20436-5d12-4f7c-b413-0cd1908acf02@www.fastmail.com>
In-Reply-To: <57a20436-5d12-4f7c-b413-0cd1908acf02@www.fastmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: aj.id.au; dkim=none (message not signed)
 header.d=none;aj.id.au; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2d42ceb-cdde-4a5e-52a7-08d8c681503f
x-ms-traffictypediagnostic: HK0PR06MB2706:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB2706D110F38DBADFF9E54C2CF2B69@HK0PR06MB2706.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RlDeSja2XR/gxqXcb13seHYf/s9/wEYxqztlvUMx4TnL2fphCxZhNUZ3nxCqohG3vlc/eiyUqimk2dtFjuEvtqLNKKYy27T1m0foRuoMmLEcA8c4Ye1lnoJ7ym5M40O6eYRQeWV/2ybohb2JjT7wvaFvr6LUBtoEpO2E16GugAwbLhK9FYQQlW7Qr14nrlBGu2zRDqy4jAKlbPkga/ooYR1bNkAZKKEdBMFUprR+0H8myftsW+HgXGvU9sr5amy3vl85GjFQLxQpdJdGxWLeebIxwQGtbIV00D5mYKDPKbQCU+fTTdya+8XmxDmnLKNVtmB5U1oOwOeoBWbmS0RTy9sJ/hTIesaMEwGARQbbJ4KHxElLAypbkq0DQjP1fSdrko0+I7Vb1BwG+11wHCN+1vk0/opwcBc6txwRoPnh9ndnLiBzE3ZHDLbTUyvZ1tzAQ6kvCM+ItfhjBj6U0qKma8mF6Pd9RrEcbi6vDyGwvv3bkMhSw8+ldHcW9nUu9Tc3midZGzPm6kKQ4UPUD7TqpbTG+Co1bAAl5AnQ8jDPNVc4lEgutgU7+CULTy+kL4FezJ9qP27jP/dvUapeCvd362LdyzAPgiV7ZV/LT+lXFAc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(9686003)(8676002)(33656002)(55016002)(26005)(54906003)(8936002)(7696005)(53546011)(86362001)(186003)(55236004)(6506007)(71200400001)(110136005)(316002)(52536014)(5660300002)(66946007)(4001150100001)(66476007)(66556008)(64756008)(66446008)(2906002)(4326008)(478600001)(83380400001)(76116006)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+7uEGrY9XSzxlMFJd17WskT9KyDc0KMbqTr2komdoskGUr+1sbFSRu+2xL8i?=
 =?us-ascii?Q?xz43Yg3jgXtY4FE1JPzXZCG9iSUw27ifRArtv2QZ6imO/1l/kOw2ODNtuuTk?=
 =?us-ascii?Q?e51kiRm1UE7di115XZUpkj2ahyFQ82yZegXiVgzEtWnfoxOjxgInh3Pdj0cY?=
 =?us-ascii?Q?ubo8GcThkb4Tkmd5i9Pt04VfbuAtQgapOuJTzkf50lSiSYDf6nFf9gV46t7S?=
 =?us-ascii?Q?yXZGjzqidmSThvV1xFFAYegumLjaMXEkbHtVVxRmQUq+EJiKqdHxYGv69EjT?=
 =?us-ascii?Q?DvvG0J/hYGITl81YenY1PtT1n76P5WXvZp9M81+7Qmv1ndy8dAS7vlGTjXsA?=
 =?us-ascii?Q?rUV5HKP/J2POAnFvcaPS9pb/7//sl1XGwuUNnbFL693l0jMxtncpcaNCqlqe?=
 =?us-ascii?Q?yfcQ0GYYujFvkdKtooGCDW6QxZE/gHXb2VKQui9mS6ZK7D//tJEazxKpIXme?=
 =?us-ascii?Q?s/KU3czhbgCzJTNfzTbXkumH37jBEQ7CuTRazTLIEXISeLuu2ZyJdYMdJZao?=
 =?us-ascii?Q?ggn2eQW1FWH0xH533r1dcvdnf+O3VgNxEa+sK9I6w+br73awH+8ts/+Kr9lb?=
 =?us-ascii?Q?MzciJgRjLWBN9/EEUbnd1lnWhb5yFaFzcC5G8jVztMzqD9MEZwsZbUGBElr8?=
 =?us-ascii?Q?aZv3Krg4t08FU2RcfpPiiy9CqOpbZDeN0ZC6iEWytxSivcyRYYZ7NTgscIrw?=
 =?us-ascii?Q?9TrUOe3vkuhKffJBC+t+GIvAWlzFF4VPuJ1OzT1p5pOBq4be3d9UbO89colc?=
 =?us-ascii?Q?+KDRmpUhE5X2KNOP8Fh5zSwRh0lSHRHLcPMBe053RufTvW/1SxneZIZc5XSw?=
 =?us-ascii?Q?37XlM2DD+ubs9CH1jSpBh+iuPYBza868xb/Mc8QXSufwfuyHkc1M8W+arfNI?=
 =?us-ascii?Q?kHecR06A7Fu5k6c1gweOUkxEXNyHAG8L2y1xE4a9dhLoqogckzfT7N+EKjB8?=
 =?us-ascii?Q?EzvOkCTiPU/jMyMu/6Z42dGRW4EXXF1kETVav9jpo4R/ykVaQmXjB8MrkKT/?=
 =?us-ascii?Q?kWugX1lbeRAfCYU0QF4wf3s4gyc4sk77a48YNqX+pi7uLRM9Ar+T/7mVciHR?=
 =?us-ascii?Q?+mEyIR7J?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d42ceb-cdde-4a5e-52a7-08d8c681503f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 07:16:37.0684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OddEaGJza5lOXDWPD7nZnqgLHN6Lh/BggChRkUbGntDmzCYs5iyk0R8aUogLFIGZ8qqpGbaYZqLB2S+IFsYfGp1fRB9ArE+Pk9kbHiQOgYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2706
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andrew Jeffery <andrew@aj.id.au>
> Sent: Monday, January 25, 2021 8:47 AM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; Samuel Holland
> <samuel@sholland.org>; Stephen Boyd <sboyd@kernel.org>; Joel Stanley
> <joel@jms.id.au>
> Cc: BMC-SW <BMC-SW@aspeedtech.com>; linux-aspeed
> <linux-aspeed@lists.ozlabs.org>; Michael Turquette
> <mturquette@baylibre.com>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; linux-clk@vger.kernel.org; Linux ARM
> <linux-arm-kernel@lists.infradead.org>
> Subject: Re: [PATCH 1/1] clk: aspeed: modify some default clks are critical
> 
> 
> 
> On Fri, 22 Jan 2021, at 18:45, Ryan Chen wrote:
> > Hello,
> > 	How about this patch progress?
> > 	It does impact a lot of machine that when BMC boot at u-boot.
> > 	SUART is work for Host. But after boot into kernel, due to the clk disabled.
> > 	The SUART is not work for Host anymore.
> 
> Maybe it's worth taking Ryan's patch for now, and when the protected-clocks
> binding gets merged we can rip out the CLK_IS_CRITICAL flags and convert the
> Aspeed devicetrees to use protected-clocks instead?
> 
> The only issue I see with that plan is it becomes ambiguous as to which clock
> each platform considers crititical/in-need-of-protection.
> 
Hello Joel,
	Will you take this patch? Or you have another approach I may modify for it. 

Regards,
Ryan
> > > -----Original Message-----
> > > From: Samuel Holland <samuel@sholland.org>
> > > Sent: Thursday, October 29, 2020 10:25 AM
> > > To: Stephen Boyd <sboyd@kernel.org>; Joel Stanley <joel@jms.id.au>
> > > Cc: Andrew Jeffery <andrew@aj.id.au>; Michael Turquette
> > > <mturquette@baylibre.com>; Ryan Chen <ryan_chen@aspeedtech.com>;
> > > BMC-SW <BMC-SW@aspeedtech.com>; Linux ARM
> > > <linux-arm-kernel@lists.infradead.org>; linux-aspeed
> > > <linux-aspeed@lists.ozlabs.org>; linux-clk@vger.kernel.org; Linux
> > > Kernel Mailing List <linux-kernel@vger.kernel.org>
> > > Subject: Re: Re: [PATCH 1/1] clk: aspeed: modify some default clks
> > > are critical
> > >
> > > Stephen,
> > >
> > > On 10/14/20 12:16 PM, Stephen Boyd wrote:
> > > > Quoting Joel Stanley (2020-10-13 22:28:00)
> > > >> On Wed, 14 Oct 2020 at 02:50, Stephen Boyd <sboyd@kernel.org>
> wrote:
> > > >>>
> > > >>> Quoting Ryan Chen (2020-09-28 00:01:08)
> > > >>>> In ASPEED SoC LCLK is LPC clock for all SuperIO device,
> > > >>>> UART1/UART2 are default for Host SuperIO UART device, eSPI clk
> > > >>>> for Host eSPI bus access eSPI slave channel, those clks can't
> > > >>>> be disable should keep default, otherwise will affect Host side
> > > >>>> access SuperIO and SPI slave
> > > device.
> > > >>>>
> > > >>>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > > >>>> ---
> > > >>>
> > > >>> Is there resolution on this thread?
> > > >>
> > > >> Not yet.
> > > >>
> > > >> We have a system where the BMC (management controller) controls
> > > >> some clocks, but the peripherals that it's clocking are outside
> > > >> the BMC's control. In this case, the host processor us using some
> > > >> UARTs and what not independent of any code running on the BMC.
> > > >>
> > > >> Ryan wants to have them marked as critical so the BMC never
> > > >> powers them
> > > down.
> > > >>
> > > >> However, there are systems that don't use this part of the soc,
> > > >> so for those implementations they are not critical and Linux on
> > > >> the BMC can turn them off.
> > > >>
> > > >> Do you have any thoughts? Has anyone solved a similar problem
> already?
> > > >>
> > > >
> > > > Is this critical clocks in DT? Where we want to have different DT
> > > > for different device configurations to indicate that some clks
> > > > should be marked critical so they're never turned off and other
> > > > times they aren't so they're turned off?
> > > >
> > > > It also sounds sort of like the protected-clocks binding. Where
> > > > you don't want to touch certain clks depending on the usage
> > > > configuration of the SoC. There is a patch to make that generic
> > > > that I haven't applied because it looks wrong at first glance[1].
> > > > Maybe not registering those clks to the framework on the
> > > > configuration that Ryan has is
> > > good enough?
> > >
> > > Could you please be more specific than the patch "looks wrong"? I'm
> > > more than happy to update the patch to address your concerns, but I
> > > cannot do that unless I know what your concerns are.
> > >
> > > Regards,
> > > Samuel
> > >
> > > > [1]
> > > > https://lore.kernel.org/r/20200903040015.5627-2-samuel@sholland.or
> > > > g
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
