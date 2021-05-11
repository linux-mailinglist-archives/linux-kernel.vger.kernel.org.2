Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5892A37A400
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhEKJtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:49:32 -0400
Received: from mail-vi1eur05on2053.outbound.protection.outlook.com ([40.107.21.53]:46209
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230434AbhEKJta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:49:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTr9XFNwQVQbbVEQ9vJg/gUTPzsip48Y82tTcfNW5NoCnEvie5tRAmQUKVXyXXPPvNtPpyMV9mhjf+ti3MYBIOTJnZa4Tx6cljB4Cvn2TZPtvyjwZMH8+ppziZb5csqFa5/xxlx3hWOnyHey4zY6+bIbBbTZA/E9SI7mKOuUY4bH3jbujpf5aJ+fe49UVogL8m4A/4BfkoAtIeudIz9nYH/1ZBmk7QspzoIQMvcQ1+VDYgig6C2eOEn3a37i9frmSteEf8lxLpajSBJcxmnKBRGUCGfoaHqFifSM7KYqvHboIAb2z2Wap60PWxbITHzzJ7mrR3cciAsE/EWYO61ksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Rc+YEmutddPOoUCpbN64bHAQvXupsvln9chwC9KFqI=;
 b=jV7lktmSZQubfO2l6DWegJvmDMRVyJYq9mQsLUzGnXF+Wwa41U3a4/Fv/h9mHhMMOb4m73oRazI++DvxMmlz2TOU1Mr0aiTb3CkbwWmq5POrrFrsO9FJ60+TSRA9z3P8jfmI5k7nmVuvgMqsL5WxDxzZnIWuoqocePdf4hXxcjAuQ29U/hcG9nAjHmjKUO4Rl9tPaSinpLgkKz5rymMGDo59ru5lxyHyPAexng8KgHAhMvedczYK++8nSRoExdfpPoxQetCT28T0P8h88o2MTXmHW3J9B+MO/lql3r3BO5BCGej85UenocEQu7c1VsPrJRbBGOS+/ysJutY7H9ApWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Rc+YEmutddPOoUCpbN64bHAQvXupsvln9chwC9KFqI=;
 b=p0ClnAavfyn0DlLFfR+qX3qW5XulmiTUYIw4u+OBxFPIV5Sjl7ct3ApS5mIuaa9VxxIA3RDrggPnnIToO8HfZJjPRR1Gk3XZzl8S1K+lH46mq6BVUo3AzWpGwEGT9WQXmILe+tAvxSlbBfeKd7SBTG4XW50zMcZUmp9jNH792x8=
Received: from AM0PR04MB6754.eurprd04.prod.outlook.com (2603:10a6:208:170::28)
 by AM9PR04MB7585.eurprd04.prod.outlook.com (2603:10a6:20b:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Tue, 11 May
 2021 09:48:22 +0000
Received: from AM0PR04MB6754.eurprd04.prod.outlook.com
 ([fe80::f12c:54bd:ccfc:819a]) by AM0PR04MB6754.eurprd04.prod.outlook.com
 ([fe80::f12c:54bd:ccfc:819a%7]) with mapi id 15.20.4129.025; Tue, 11 May 2021
 09:48:22 +0000
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Kornel Duleba <mindal@semihalf.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "upstream@semihalf.com" <upstream@semihalf.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>
Subject: RE: [PATCH] arm64: dts: fsl-ls1028a: Correct ECAM PCIE window ranges
Thread-Topic: [PATCH] arm64: dts: fsl-ls1028a: Correct ECAM PCIE window ranges
Thread-Index: AQHXRhK6wSxUwtoqZkenOXHlDRJ4r6reBtQA
Date:   Tue, 11 May 2021 09:48:22 +0000
Message-ID: <AM0PR04MB67542D30A9424D455DB3ADD496539@AM0PR04MB6754.eurprd04.prod.outlook.com>
References: <20210407123438.224551-1-mindal@semihalf.com>
 <20210511030658.GG3425@dragon>
In-Reply-To: <20210511030658.GG3425@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [188.25.217.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8586b2fb-d6c6-40ca-b7ab-08d91461ea68
x-ms-traffictypediagnostic: AM9PR04MB7585:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR04MB758571921AD5F53C1A9BE71596539@AM9PR04MB7585.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xWKTdFCEk91BKvIVvV2u0GT42alWOHNLmR9ss0g9MqaJRdX/UJbAYt5mO1PdbKTgjAbCt49R0xVoWpuK5r4koo7mW66lPLTmAR8tQUVicRwKUYekBxTIsoFZrnCD8Cbn5feUh5hSlSN/Z8W91ff40cd8YUmza6JUoWt+HUA08P4BZLbmphuOkkqzDB9w0CPSY3ra0+6sc2PG6aAYp7kqvbIHMjqmUpqeeswAygpWr2LHtZpq4FX1NS+e3nVlcccvOuZv3e/o4xUQwpRjEVQpSZEAOHQJ49Q7H5W7dxowKi+NT12nexTXJXNh+5Lx32pp9YV5TtlupbM+Hudi4IQj7mLtIJrxipsfMugtcJn4AErfEZNYANA+2lDiqFwPOENBRuljAQleh1uZ1qOeVK7KhmIqbdN9VYEfNngAuSwsswNqTHRGWkRwMm2BwZe5k5fRlaF2HolDTx1oOrRwmIn1b0VqobCJkzhs512IjXNEFw1puAdUrXJJnHJsv6LN/KybWF1auY3AaMyRfff1VYj7r6aZxOZB0fxuo6ecHcxVI8WeR+DtOm8GjN26QHA/T8ylBgHHvnYcYCMdl9KEYIqU8RxJ3jfgJv5KCrvktbb/Jcc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6754.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(136003)(396003)(366004)(33656002)(26005)(5660300002)(8676002)(2906002)(83380400001)(8936002)(86362001)(44832011)(71200400001)(122000001)(66446008)(38100700002)(110136005)(55016002)(186003)(54906003)(52536014)(4326008)(478600001)(76116006)(66556008)(9686003)(66946007)(66476007)(64756008)(6506007)(7696005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?N0S6oD6Z1EEHzPRM/flEchT1fsLJRgsQNt4FriE0dUN+se3swGyUkv3UePnp?=
 =?us-ascii?Q?J1iXWz3oKU24F3H5c9JQVw0ho229laWlgIYk8tMN6+PMKAVVW90nBMIK3VU5?=
 =?us-ascii?Q?/6X84act/xcomZh9y8LHV4F8xRSS0PxzBphmTidGM4hMAoz3E02UHcEE6f39?=
 =?us-ascii?Q?xbCb/YYN0pfg7JAomjMZouQxsDEGpu3yrFeLOpT50ou5VGQhgPP5LsDuUefR?=
 =?us-ascii?Q?ZxcZsWsKPA0MAi8FmL5cXzxXTV7bzdqOKZp+j51aEkRyj7Wg/Wzc9XLuEuWn?=
 =?us-ascii?Q?1uQq9SCLA3+kmUa3+QtXGsDikJr+atXs3PnYukpAonVOdBUCCeK3DYhIg435?=
 =?us-ascii?Q?sFHJ1GIUdYyuqYbPRPw6QivpF2FLwGSq8Iv0HtCUhDPTdGo4E5C0r8mAs/YU?=
 =?us-ascii?Q?dQ4dhwtGm8Gh6dxPqBX/sFY0e0r1J+eALvfmBLX/Zh8a5/3D9PDo6PDgmere?=
 =?us-ascii?Q?wJUOSqK3AFKTwpFcykLPMRAeaTmnx/N87xXOUl/Z6aOgDmOlZp0kWSqvlWSn?=
 =?us-ascii?Q?vfTiwwCfxPVApbz9XmVRdNaAjcpTNAgfKtFmt7T6VaDqaf2wFBaISvyWtmei?=
 =?us-ascii?Q?bbpdhKd5ZwiPKKFWu73Iz4uA4kDHvJ1qXveT/zUqClxqaQ1GkHh2d5nQNH/b?=
 =?us-ascii?Q?cFzK35q9J44NV9k7aZKPZAvOn0rS0ZBGHUI4efw2NZfsbOJZVTIQvJQGBK1r?=
 =?us-ascii?Q?z/cWaQy/Y2Wj0ZWndHe9midbguRrOfxKWbpJ+jLEmD/iz+/JJbo8pFpYu1ZD?=
 =?us-ascii?Q?M2+1etbNC+BstU3SKlRzEp52nPx05nUAYJIHtKb7x3c3WqtVMqBND859vX/s?=
 =?us-ascii?Q?8xhwIVs2m7ZpY476VncrbW8PsSS2IF+IHu7CGAtYkPj8m8AtPh6SEv9yYNxz?=
 =?us-ascii?Q?qweQHdCB8PwwPZAoLHIsqRxSsysbMjtFwiUXqv5ShmQ5NdBOpCnuxENJQx2H?=
 =?us-ascii?Q?V8PETYWbY9VNLRzovsRWQIEacaq8C830LgyiAZSQ+ijotRC2ySrzytmegtBk?=
 =?us-ascii?Q?gVBg3vc9T1zrQvYIBcBCBQyefRveMXrMcfBZ9/TF5x8rX2pzuu9Xyfz4HJKE?=
 =?us-ascii?Q?Y/6tJFh5JPAy9wH1Y4vwwwikaw41y0icx/df8g9hOvuwzFZyY1ovoJdF9GiY?=
 =?us-ascii?Q?c7WDPO8Prcr2VBp+XcdM3AKhH3A39Lhsk2uWk8I5d0gUIsyRk6jVgUn9PcUR?=
 =?us-ascii?Q?ySF9eWnRfoCPHYz19stq81Qex/rAIAE+wt5upNho2LQhQc/OyA2zNzYK/hIg?=
 =?us-ascii?Q?NE4Af5mcBeS+s69cB6jOb53OAxc0bz2XJkgVw6tFYCPy8rjo//cW4morKIGm?=
 =?us-ascii?Q?OdklXsBGii0vYysGt0udl76h?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6754.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8586b2fb-d6c6-40ca-b7ab-08d91461ea68
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 09:48:22.5740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9lAZTQvtJLkUtjzdPUn2nbakEp2iotNkIGvIaggZvOJ17oJgLKYaux3ix8o0JYCB6AUKgzJhYCm02IG+CK4RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7585
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Shawn Guo <shawnguo@kernel.org>
>Sent: Tuesday, May 11, 2021 6:07 AM
[...]
>Subject: Re: [PATCH] arm64: dts: fsl-ls1028a: Correct ECAM PCIE window
>ranges
>
>+ Claudiu
>
>On Wed, Apr 07, 2021 at 02:34:38PM +0200, Kornel Duleba wrote:
>> Currently all PCIE windows point to bus address 0x0, which does not matc=
h
>> the values obtained from hardware during EA.
>> Replace those values with CPU addresses, since in reality we
>> have a 1:1 mapping between the two.
>>
>> Signed-off-by: Kornel Duleba <mindal@semihalf.com>
>
>Claudiu,
>
>Do you have any comment on this?
>

Well, probing is still working with this change, I've just tested it.

PCI listing at boot time changes from:

pci-host-generic 1f0000000.pcie: host bridge /soc/pcie@1f0000000 ranges:
pci-host-generic 1f0000000.pcie:      MEM 0x01f8000000..0x01f815ffff -> 0x0=
000000000
pci-host-generic 1f0000000.pcie:      MEM 0x01f8160000..0x01f81cffff -> 0x0=
000000000

to:

pci-host-generic 1f0000000.pcie: host bridge /soc/pcie@1f0000000 ranges:
pci-host-generic 1f0000000.pcie:      MEM 0x01f8000000..0x01f815ffff -> 0x0=
1f8000000
pci-host-generic 1f0000000.pcie:      MEM 0x01f8160000..0x01f81cffff -> 0x0=
1f8160000

and looks reasonable.
Adding Vladimir and Alex just in case.

Acked-by: Claudiu Manoil <claudiu.manoil@nxp.com>

>Shawn
>
>> ---
>>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64=
/boot/dts/freescale/fsl-ls1028a.dtsi
>> index 262fbad8f0ec..85c62a6fabb6 100644
>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> @@ -994,19 +994,19 @@ pcie@1f0000000 { /* Integrated Endpoint Root Compl=
ex */
>>  			msi-map =3D <0 &its 0x17 0xe>;
>>  			iommu-map =3D <0 &smmu 0x17 0xe>;
>>  				  /* PF0-6 BAR0 - non-prefetchable memory */
>> -			ranges =3D <0x82000000 0x0 0x00000000  0x1 0xf8000000 0x0 0x160000
>> +			ranges =3D <0x82000000 0x1 0xf8000000  0x1 0xf8000000 0x0 0x160000
>>  				  /* PF0-6 BAR2 - prefetchable memory */
>> -				  0xc2000000 0x0 0x00000000  0x1 0xf8160000 0x0 0x070000
>> +				  0xc2000000 0x1 0xf8160000  0x1 0xf8160000 0x0 0x070000
>>  				  /* PF0: VF0-1 BAR0 - non-prefetchable memory */
>> -				  0x82000000 0x0 0x00000000  0x1 0xf81d0000 0x0 0x020000
>> +				  0x82000000 0x1 0xf81d0000  0x1 0xf81d0000 0x0 0x020000
>>  				  /* PF0: VF0-1 BAR2 - prefetchable memory */
>> -				  0xc2000000 0x0 0x00000000  0x1 0xf81f0000 0x0 0x020000
>> +				  0xc2000000 0x1 0xf81f0000  0x1 0xf81f0000 0x0 0x020000
>>  				  /* PF1: VF0-1 BAR0 - non-prefetchable memory */
>> -				  0x82000000 0x0 0x00000000  0x1 0xf8210000 0x0 0x020000
>> +				  0x82000000 0x1 0xf8210000  0x1 0xf8210000 0x0 0x020000
>>  				  /* PF1: VF0-1 BAR2 - prefetchable memory */
>> -				  0xc2000000 0x0 0x00000000  0x1 0xf8230000 0x0 0x020000
>> +				  0xc2000000 0x1 0xf8230000  0x1 0xf8230000 0x0 0x020000
>>  				  /* BAR4 (PF5) - non-prefetchable memory */
>> -				  0x82000000 0x0 0x00000000  0x1 0xfc000000 0x0 0x400000>;
>> +				  0x82000000 0x1 0xfc000000  0x1 0xfc000000 0x0 0x400000>;
>>
>>  			enetc_port0: ethernet@0,0 {
>>  				compatible =3D "fsl,enetc";
>> --
>> 2.31.1
>>
