Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D2E36D3C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbhD1IRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:17:39 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com ([68.232.159.83]:65124 "EHLO
        esa6.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229643AbhD1IRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:17:38 -0400
IronPort-SDR: 0YzRwzUL+FRv3EojSYJtBKKQi0o0SIm48/5o5siVmQLXhQlT0l3WPXz+RsV+h12VBXkLeDmfKX
 /MyBE83wGUI+Am5FwqSnrsm879y1jO+f3rllhzzXcVK+jJ0udSV+a8MLRBCEpwowOoTHRtxb4b
 hdCdEAbFgL6SBzhkWjtCyxoMGO+Pa96V8w/4briE5LzRAaqckUhzV4IVJ5Xvoy6IcNGW3kNd/2
 8ebsh12netyJlMvgApS1Cqgi1egigAJ5dKYa35wj+eK1Cl7aEyGweIp67KawW8zb8a9CB2XPww
 /Pk=
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="30661028"
X-IronPort-AV: E=Sophos;i="5.82,257,1613401200"; 
   d="scan'208";a="30661028"
Received: from mail-os2jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 17:16:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsOsnGtzocVyQXvnZYf0peYiS+RHor/fBOvPG6NMrTa2UeDWOP7ESvJmj5iXvhzwNrvmJobiHynpRPovdKFzKiVCZk6LKNW4wPnAOx/Y6lBxXrCaeB2z7xIjtJZ6/tul3P5IsvHPjmzh7z9RR9lp3BAqgq2NuI75WsCoCvXPk6d33CEMAEQMXFj4BK95KrWbDu6emotb33HtdJXlK5UF7mqmmk3Eo0FrMi1kBjwnfiQuQvE1wX/Lla895MW11ZLTlqFu8WdO1OjzLGSpDqDFwmzebI4ArIeoRNjfu3/L9j29h7uedUSdC1eaMteTlotGt9riDjnBMDj7JOlg1BBa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIXpif2eG9S/Mxo65wIi+8KMZgyt5dA/OrEd6jlpVGA=;
 b=HUkMrITLiuZY6gzEDk3vekQL/HAJsa+e4UgjLKA5mt4mFPYtkuoLoLpNlOA7LLkoH1mcDEOKwWR4E4/WOTOlGSINeXQ+merA6IW5oHm4avgn1gH2RFvrzm+wyonNV6L1XqKYpwbBxz36j8mbC9/wZ2wfvcV4CPq3kYC0KXxkeo74EY43dPcQgDwoUcLR7pKLTSiIf583yqsSv7y3G1TD1NTiLanmU6vWvHgjdQoURGD7uFUmyja0qS9fqOL56mLSwI2evzq/OcGHy6Kw4yLN1pUeZTkBsroPnYIv6bwIUvp2Y5yBx80M9MeZaNb6zAV0nSt1POyCx81lX7rylFdJfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIXpif2eG9S/Mxo65wIi+8KMZgyt5dA/OrEd6jlpVGA=;
 b=Mq6aVMuvfTY+iECQ27f7gL6SdHvqrvMcQRMd/hLI2PhFHZZHBdlMhYrW46xKJjhhlqvCzYaYjztWJmoQcYtA9nFyuLTwkzzt/TnQldGbb7GSNHHB5aytkQwl6wDsxP+BV4+Lx+JN3sNNTTOh4vmWseK6gPOgNjDWtjlp9vPp5Kg=
Received: from OSAPR01MB2146.jpnprd01.prod.outlook.com (2603:1096:603:15::15)
 by OSAPR01MB5092.jpnprd01.prod.outlook.com (2603:1096:604:6b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 08:16:48 +0000
Received: from OSAPR01MB2146.jpnprd01.prod.outlook.com
 ([fe80::db4:dfac:6caf:d7c1]) by OSAPR01MB2146.jpnprd01.prod.outlook.com
 ([fe80::db4:dfac:6caf:d7c1%7]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 08:16:48 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        'James Morse' <james.morse@arm.com>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Subject: RE: About add an A64FX cache control function into resctrl
Thread-Topic: About add an A64FX cache control function into resctrl
Thread-Index: AdctARUohIvM7pb1S52qTlM+pjp6RAJht/AAABE+WYABTmUCMA==
Date:   Wed, 28 Apr 2021 08:16:48 +0000
Message-ID: <OSAPR01MB2146D42FC04779268BA231878B409@OSAPR01MB2146.jpnprd01.prod.outlook.com>
References: <OSAPR01MB214600C7923AEF7C35B02E648B739@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <OSAPR01MB214657641D532FB8D112DD528B479@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <bb0967c0-5b88-c6c2-0242-1e3928189a04@intel.com>
In-Reply-To: <bb0967c0-5b88-c6c2-0242-1e3928189a04@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.162.30.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 226604e0-a675-4798-e7e5-08d90a1df82b
x-ms-traffictypediagnostic: OSAPR01MB5092:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB509208A4EF93E64BE997B9308B409@OSAPR01MB5092.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i/igp2GBLSsFwiCH/Ocr8anq7lEZ2izu5n1OrHtg1rBx0mivK38zRux19Nsqcl3x/FkXLLQDgSdjqeQptjN90kn+hj8r5tVmwBsU/1QtmZ82sqqarSl0qtLgud9Zgp5NjmoDLeFRpoAvEVAJ4Gf3U4SfCc+kAVr8d2YOX6UhfWTKtnmcRbx2PlUYtJtpQUsP0oqIjymav7GMSr/sa78WqdGo/Re2zw5/5I1pr/HCYdm9sMwEiBjbAzVg07mj3w4xsWx0V7aRdceU61xGofMsbIqzXbqS+YIfGV40eOTgJDOrh6eisgISshfUwZiyc/1WjB+RUpTkgs8wK3lpnyjBtMBe//iO2d+tGdA50VEwTGrpIIUP/+KyAoszlyTGbdzupgRLMZng1VWnEBRQhu80V13HZ8bxIAk4HyG+i4hQaW5VdRlTwXtWCDLSXNU1b/21OVg/p4sxUNklLn2KbsRPaHQTXH/yI03vJ+tO3hN62yuLl7jhINV1qwRXtsYpE9yMU7XTTANgDOv4k3bGjGyKniN1VG5XUTCKIH6CpXWsljG7LGyH9hPmNkJSS7wNBM44e2z/klUTY7bYuce1i1a4z+LjeGM7Md4e1JVuaI1juUKyAbiFieDqsH2UdIlAcVBE3ECzKnxS/0hkGMu0IikpLaxU+plLpzesaPS6NG/lM13Th9Zito/IloLellf0H2B6Z+CL4K24lx9eO9YqXlyQz1bTYGRj6e50Xq3zzsRaJh4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2146.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(316002)(5660300002)(107886003)(53546011)(966005)(26005)(85182001)(55016002)(38100700002)(6506007)(8676002)(7696005)(54906003)(122000001)(2906002)(9686003)(186003)(86362001)(66446008)(66556008)(4326008)(52536014)(71200400001)(64756008)(33656002)(110136005)(83380400001)(8936002)(66476007)(66946007)(76116006)(478600001)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?OHFYQ3QzL0F1N0tDYWROMVhDSFA3ejBib0ExVmRtY21wSlBuaFROUzRH?=
 =?iso-2022-jp?B?OGRNSDhxQm1JUlFNemxoNkZsQjFuVW1TMTdTcGxLdmtHZThqdmlkdDBO?=
 =?iso-2022-jp?B?aGFZL2lnWkR3bVc5UVJqTEFrT0UxUEhKNzlib3RzMjBxRDhjOWEveGR1?=
 =?iso-2022-jp?B?SGlyWmszM0hkYnNOYU00RHhaWnYzckZPTE1FQkdzMXpaWmNFV2tidFhS?=
 =?iso-2022-jp?B?b29SMkR1bGtWdlhxVkFBSTc5cW92YW96cmErSnlZVUlQU2tZcW1Gdml5?=
 =?iso-2022-jp?B?dlFZSXd3NEhaSUlZZDF5ZVcwZEt3ellnb2hsOUJFUkJNVEdaZzN2ZGtt?=
 =?iso-2022-jp?B?ZlNSS2ZGOXp5SGMzQmtsbGw5S29xZ2lGV3ZFc1JvYjJHNWhmTlc5VHpI?=
 =?iso-2022-jp?B?YVFnVEsvWTJBNzgrYkszRldLQUIxbW1ncExKVWMrMmRHRG40T3N2elQy?=
 =?iso-2022-jp?B?bHJpbjQ2V1o1YjM0alU0b1Uvdmh6bko3NmxtUnd4dWlLejJ0MElBMlhn?=
 =?iso-2022-jp?B?d3FlOTJFeWJ0NHA0aGVHUnAwR21TaUwxSWhxNW9aZS9PUDNwVWJhYkhr?=
 =?iso-2022-jp?B?SncwZi9DOER1cDhzM1NQc0dueG9PR0VwZVIvNXljRloxS20wTE1EdnI4?=
 =?iso-2022-jp?B?ZVNsY1hZdUp0K1N2WFVsdm5XcytXbkFFTENyekx6WE9hTC9Gb1lHNUZT?=
 =?iso-2022-jp?B?ZUVwRC9Venpyb0hwczNRL3VhSk5OVi9mRUdhVnZ5UUFndXpHRG1HdzJS?=
 =?iso-2022-jp?B?ZG5jN3lDbGxNbFRnN3dSOUlNWFJXWUZoR25tMTh2RnhiUXI4SUV6aE5q?=
 =?iso-2022-jp?B?NmtsNjl5N042bHhOcGJacDcxVWZZY3R0MHQrM1dNSEI0bUhQNmRiblkv?=
 =?iso-2022-jp?B?V1l1elp6ZGhhVVprcHZQem9WKzEyN05LVS9DdGNaWXlRZWtBWDBjc2U1?=
 =?iso-2022-jp?B?RHdOd1pQa25uQUR3czlSNGhHM1pXYll2WWwvMGRMaUpKM29UYWRDUWtm?=
 =?iso-2022-jp?B?emttU2F2V0lBSGtkUVAxd0VQclNzK2tVRE5VaFRLa25kNjdIQWJFdEI4?=
 =?iso-2022-jp?B?SE1FOHh2U3I2bmRCRForbHZaQUdBWGpBajZzM2dVbFNpUkQreHJpck1I?=
 =?iso-2022-jp?B?M094QUdSTnJqa293Rm9raWFHYThzRlNBZ0ZmN2JXYzFmWnptTVZOTDFi?=
 =?iso-2022-jp?B?VTJpQ2Z1cE5kSTlkam9xQnJmWkVRLzg5R2xsVWs3L08wYkRFbGt2MTdI?=
 =?iso-2022-jp?B?NS9STU1oZ1FvVVRXTVI5VFRtcXNvbnNnd0xQTlIrQXA1VjV3OGdYVXpG?=
 =?iso-2022-jp?B?dEJ4K1VOSVZUUkFOTXFzRnAxRUxvRjlRVjJqL29zQzdtMmlRdWJSK0ox?=
 =?iso-2022-jp?B?bkF4ZGVPR1F5RlA5aUQ1SGVDMUtOVHZOdUVjRmZqU0hvNm5JMWV2YXVW?=
 =?iso-2022-jp?B?QW5nQmM2ekZFNVlyUklHZTZiY1o0VlVETjlsSW9zZ2tqTDhhdTRHT0Fu?=
 =?iso-2022-jp?B?R1NmaVdlYUlSV3lSMGxPdE0va0cxWEZON25VdFJYdjFNeXJRejc1bk15?=
 =?iso-2022-jp?B?RUlzVnYxMm9UVVpudUIyVkFGMnBxbzZSQ0JMTm5pUU9sN2l0YWFyQVUy?=
 =?iso-2022-jp?B?cUNCeXZsTmRMMEVXc0FrQy9zaFV3MVQvQWRVeVdzZW5hYWxnclQzQ25k?=
 =?iso-2022-jp?B?Z1luL20xWSt2TDQ3T3d6TXMvRlozVzNFNmplTVpOV0ZOcXV5bExoeEZ0?=
 =?iso-2022-jp?B?Z0xVR3l4WnlnaGFheVNpd0MzalJHZlB6RHd6di9jY2JnempqR2g0Wmts?=
 =?iso-2022-jp?B?NUZZM2k1cW9TeFE1amtMSWFKM2NNbzBncXlkNUpLakhUZWJCRDlpZHRT?=
 =?iso-2022-jp?B?RzNtZGhGeEZjbVJ6WTNGRTZBR2l3b05YWkdqODEwN1duYU5adFBVYXMx?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2146.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226604e0-a675-4798-e7e5-08d90a1df82b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 08:16:48.3002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqg7foWiO6vBu9gj6VDLIamF0GTmoiL0ME59oAJvC7h3SAzPimtZSpGZ3bKd1dfkFmHjuzsqLDWcOpiPz2hqtJAiDkIyIeldAcSeHIcjXh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

> On 4/21/2021 1:37 AM, tan.shaopeng@fujitsu.com wrote:
> > Hi,
> >
> > Ping... any comments&advice about add an A64FX cache control function
> into resctrl?
>=20
> My apologies for the delay.
>=20
> >
> > Best regards
> > Tan Shaopeng
> >
> >> Hello
> >>
> >>
> >> I'm Tan Shaopeng from Fujitsu Limited.
> >>
> >> I=1B$B!G=1B(Bm trying to implement Fujitsu A64FX=1B$B!G=1B(Bs cache re=
lated features.
> >> It is a cache partitioning function we called sector cache function
> >> that using the value of the tag that is upper 8 bits of the 64bit
> >> address and the value of the sector cache register to control virtual =
cache
> capacity of the L1D&L2 cache.
> >>
> >> A few days ago, when I sent a driver that realizes this function to
> >> ARM64 kernel community, Will Deacon and Arnd Bergmann suggested an
> >> idea to add the sector cache function of A64FX into resctrl.
> >>
> https://lore.kernel.org/linux-arm-kernel/CAK8P3a2pFcNTw9NpRtQfYr7A5Oc
> >> Z=3DAs2kM0D_sbfFcGQ_J2Q+Q@mail.gmail.com/
> >>
> >> Based on my study, I think the sector cache function of A64FX can be
> >> added into the allocation features of resctrl after James' resctrl rew=
ork has
> finished.
> >> But, in order to implement this function, more interfaces for resctrl =
are
> need.
> >> The details are as follow, and could you give me some advice?
> >>
> >> [Sector cache function]
> >> The sector cache function split cache into multiple sectors and
> >> control them separately. It is implemented on the L1D cache and
> >> L2 cache in the A64FX processor and can be controlled individually
> >> for L1D cache and L2 cache. A64FX has no L3 cache. Each L1D cache and
> >> L2 cache has 4 sectors. Which L1D sector is used is specified by the
> >> value of [57:56] bits of address, how many ways of sector are
> >> specified by the value of register (IMP_SCCR_L1_EL0).
> >> Which L2 sector is used is specified by the value of [56] bits of
> >> address, and how many ways of sector are specified by value of
> >> register (IMP_SCCR_ASSIGN_EL1, IMP_SCCR_SET0_L2_EL1,
> >> IMP_SCCR_SET1_L2_EL1).
> >>
> >> For more details of sector cache function, see A64FX HPC extension
> >> specification (1.2. Sector cache) in https://github.com/fujitsu/A64FX
>=20
> The overview in section 12 was informative but very high level.

I'm considering how to answer your questions from your email which=20
I received before, when I check the email again, I am sorry that=20
the information I provided before are insufficient. =20

To understand the sector cache function of A64FX, could you please see =20
A64FX_Microarchitecture_Manual - section 12. Sector Cache=20
https://github.com/fujitsu/A64FX/blob/master/doc/A64FX_Microarchitecture_Ma=
nual_en_1.4.pdf =20
and,=20
A64FX_Specification_HPC_Extension ? section 1.2. Sector Cache =20
https://github.com/fujitsu/A64FX/blob/master/doc/A64FX_Specification_HPC_Ex=
tension_v1_EN.pdf =20

In addition, Japan will be on a long holiday about one week from=20
April 29th, I will answer your other questions after the holidays. =20

> I was not able to find any instance of "IMP_SCCR" in this document to exp=
lore
> how this cache allocation works.
>=20
> Are these cache sectors exposed to the OS in any way? For example, when t=
he
> OS discovers the cache, does it learn about these sectors and expose the
> details to user space (/sys/devices/system/cpuX/cache)?
>=20
> The overview of Sector Cache in that document provides details of how the=
 size
> of the sector itself is dynamically adjusted to usage. That description i=
s quite
> cryptic but it seems like a sector, since the number of ways associated w=
ith it
> can dynamically change, is more equivalent to a class of service or resou=
rce
> group in the resctrl environment.
>=20
> I really may be interpreting things wrong here, could you perhaps point m=
e to
> where I can obtain more details?
>=20
>=20
> >> [Difference between resctrl(CAT) and this sector cache function]
> >> L2/L3 CAT (Cache Allocation Technology) enables the user to specify
> >> some physical partition of cache space that an application can fill.
> >> A64FX's L1D/L2 cache has 4 sectors and 16ways. This sector function
> >> enables a user to specify number of ways each sector uses.
> >> Therefore, for CAT it is enough to specify a cache portion for each
> >> cache_id (socket). On the other hand, sector cache needs to specify
> >> cache portion of each sector for each cache_id, and following
> >> extension to resctrl interface is needed to support sector cache.
> >>
> >> [Idear for A64FX sector cache function control interface (schemata
> >> file details)]
> >>
> L1:<cache_id0>=3D<cwbm>,<cwbm>,<cwbm>,<cwbm>;<cache_id1>=3D<cw
> >> bm>,<cwbm>,<cwbm>,<cwbm>;=1B$B!D=1B(B
> >>
> L2:<cache_id0>=3D>=3D<cwbm>,<cwbm>,<cwbm>,<cwbm>;<cache_id1>=3D
> >> <cwbm>,<cwbm>,<cwbm>,<cwbm>;=1B$B!D=1B(B
> >>
> >> =1B$B!&=1B(BL1: Add a new interface to control the L1D cache.
> >> =1B$B!&=1B(B<cwbm>,<cwbm>,<cwbm>,<cwbm>=1B$B!'=1B(BSpecify the number =
of ways for
> each
> >> sector.
> >> =1B$B!&=1B(Bcwbm=1B$B!'=1B(BSpecify the number of ways in each sector =
as a bitmap
> (percentage),
> >>    but the bitmap does not indicate the location of the cache.
> >> * In the sector cache function, L2 sector cache way setting register i=
s
> >>    shared among PEs (Processor Element) in shared domain. If two PEs
> >>    which share L2 cache belongs to different resource groups, one
> resource
> >>    group's L2 setting will affect to other resource group's L2 setting=
.
>=20
> In resctrl a "resource group" can be viewed as a class of service.
>=20
> >> * Since A64FX does not support MPAM, it is not necessary to consider
> >>    how to switch between MPAM and sector cache function now.
> >>
> >> Some questions:
> >> 1.I'm still studying about RDT, could you tell me whether RDT has
> >>    the similar mechanism with sector cache function?
>=20
> This is not clear to me yet. One thing to keep in mind is that a bit in t=
he capacity
> bitmask could correspond to some number of ways in a cache, but it does n=
ot
> have to. It is essentially a hint to hardware on how much cache space nee=
ds to
> be allocated while also indicating overlap and isolation from other alloc=
ations.
>=20
> resctrl already supports the bitmask being interpreted differently betwee=
n
> architectures and with the MPAM support there will be even more support f=
or
> different interpretations.
>=20
> >> 2.In RDT, L3 cache is shared among cores in socket. If two cores which
> >>    share L3 cache belongs to different resource groups, one resource
> >>    group's L3 setting will affect to other resource group's L3 setting=
?
>=20
> This question is not entirely clear to me. Are you referring to the hardw=
are layout
> or configuration changes via the resctrl "cpus" file?
>=20
> Each resource group is a class of service (CLOS) that is supported by all=
 cache
> instances. By default each resource group would thus contain all cache
> instances on the system (even if some cache instances do not support the
> same number of CLOS resctrl would only support the CLOS supported by all
> resources).

Best regards=20
Tan Shaopeng
