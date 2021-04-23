Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D533A368EBA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241356AbhDWISD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:18:03 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87]:41782 "EHLO
        esa7.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229456AbhDWISC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:18:02 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2021 04:18:02 EDT
IronPort-SDR: xtF3qfTLSQgcXKS7r++r2OcZorwC4ANEMTH3lrbcNZlmTvlpyaYk0oebP1HCWvEavV4xdyXc+E
 D85rumgKCf5Wnbwc74BzrlmxTUaGijOI3eZHda/ctqtWNpIlYBlZ4mWGUFtLr021MTzSz7Q4mk
 qsdL+Agkvdmcr5rDzB19xUMEhr0oJ46J9ZDg3t6YVLS4l/CzuwuSFY0+FBS60GLuzu665fOWt9
 w8JADO8jBsaGy/PTtoMbk8gy+JWd1ko1a4Nm/KL9FLwQunn09B+nRrwS5DNmz9CQsbx4u9kNMh
 ewQ=
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="30217996"
X-IronPort-AV: E=Sophos;i="5.82,245,1613401200"; 
   d="scan'208";a="30217996"
Received: from mail-os2jpn01lp2055.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 17:10:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXijLJsAgndp3l0JYxZ/Dvm9LkXJIN4t+cjHD+p1qMdkvj32vlFkEl5LqLtgWB7V18NLtCM7rA2OJontBGJkpSkcHuPAHhWlkp+l1Xmq6OSipGELQB4pQhghu3sekoHV99WAoCvQ7VkgaHV34PYJWNdL4gnHLaUr0bs2rSMQ6pQ5lFUBq7GHn6fUQP4XsfDkXScGr/yoEDlOsL4/e/m12s5WBkXaXh43WvtUM3KmgfJh0HCAHb3zDQQO/ScQIzIY2cofPHLcgNEVXsSrp8OaSTbYf/IKo0XZLKBubX4DtkuqaaJm5pEuGYTNN6AMp2Vbd5oUhhe4hfOJY1mh7x1pLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN7vaWZRRMeiPkMoHeYbQfDz0hW5ejPqHsOlEjW1B7I=;
 b=C+zZsA90zZaqB/nf1YBTsUpI8ViwJiFrHanJ1VxDa5d2siYKKomG4HoOcWpt4oVN7qnz0Gst9P6SohSCOkZBq+iAnitXWs/6nEaTvrjfyGfWHX+IbBfPjJebFvMNtkbOYLIUDhQyeAmMA6e4fL0R3tLXlb+IO+FZ2srtw5pNg4uj8zx3ivWc0QUU7aGU0YIPf9vZAwFTBA1hCB5HQU8k2yz84oYOCfk0Apn9OGS9FpPR1Aype0I5qKlZjCf24bAC6b3ZEq+ypnwXWYrILIqVpyZQxr5JF1hwrZHYqywhbojvRAjwMwFqx2tPPuZ8uAbX2TE6Q7xBWxtrurTf+qLmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN7vaWZRRMeiPkMoHeYbQfDz0hW5ejPqHsOlEjW1B7I=;
 b=dUsP1LNg3/ZcE2AwEeNNiZYd2MZ/jbF468MPc9nf7or9geZR+pDLMjdHMg8Ra7MZFpjiwsQYWvdrdnnwza5fKnyUXj5D6VqSV+JJPs10vBhQc+5J4teJ3mRCM7VxWeR1tZsQtGMIzDdAVELvEFrwvQLDyxr75LSnvptUu3g5FMU=
Received: from OSAPR01MB2146.jpnprd01.prod.outlook.com (2603:1096:603:15::15)
 by OSBPR01MB2373.jpnprd01.prod.outlook.com (2603:1096:604:13::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 23 Apr
 2021 08:10:11 +0000
Received: from OSAPR01MB2146.jpnprd01.prod.outlook.com
 ([fe80::db4:dfac:6caf:d7c1]) by OSAPR01MB2146.jpnprd01.prod.outlook.com
 ([fe80::db4:dfac:6caf:d7c1%7]) with mapi id 15.20.4065.021; Fri, 23 Apr 2021
 08:10:10 +0000
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
Thread-Index: AdctARUohIvM7pb1S52qTlM+pjp6RAJht/AAABE+WYAAUfQI4A==
Date:   Fri, 23 Apr 2021 08:10:10 +0000
Message-ID: <OSAPR01MB21467099EAA9B25F0A992BD88B459@OSAPR01MB2146.jpnprd01.prod.outlook.com>
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
x-originating-ip: [210.162.30.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddaf17cb-3ff3-4f6e-6e3e-08d9062f373d
x-ms-traffictypediagnostic: OSBPR01MB2373:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB2373265442A66399176378828B459@OSBPR01MB2373.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ziASNdv7ZJnvzFwRnnHq/CFnh5DQmQjQO1vpoS+AtgTPXx3ygE0h/56VQvxKlJOueAB/8GEkqut52TZ4asAZ4rutrfPMpH599oxUQYIPExB/5OFPE+8CXaguQRRBwXYceLZR6s3jrF1na1mFOui8QPJ8DOeIzPRyEDn0wnOguKCYjR2mtEeYeNz62Y8DfS8ZWNNLzJqsrIB72hD9j2kV1WvNdpnNcIUL6D28Hb0s3b36scgPIoi05ppVWZL0TXwP7zwIZyXojm9PaQgvqzGpYfiSY1Zcof2oDbbWVQkgdvmBo61WGQLLb7aaaUutwPPlbxkuj15mDK+5pUfKYiapBaNlUIuStTC2WG/dPgNui/t9Eazdv1S5VRw9RUyjwzyURkaC4iVqhNbeooIz20UzFibnnxcCWWcCFbawq2CMjRR9TX249bJbHDmf0R8KkPj4hop7WcP2V8AnGwief5l06fH9vjIhIOWnCB4U4uqx5ukIF2fzZompeDeT1MzRf1uAQMBinSUbVYRgRGH5lMdXS/dIC5uh3gZk0lTCUC1+5twq+K4zvnrRQtll48KcCvgqaG4IJU2gXObgxHjo4ZfRV3ESdaV/L5pzl2OpfQdAmQnRNbRYTFP0syZe/mAv8BDiQ5dOc/0TWwTcbwEE+AVYUSemrJ7skb2O8We3rjQ29UaTTcTUZMe3LERPhqaGUq0z+TP6TOpTjApfx6tofV/fVRfsudyz3YpWU3A1ZaCxDfA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2146.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(83380400001)(316002)(478600001)(9686003)(52536014)(5660300002)(54906003)(4326008)(186003)(76116006)(71200400001)(110136005)(55016002)(86362001)(2906002)(7696005)(38100700002)(26005)(8676002)(107886003)(85182001)(122000001)(64756008)(66946007)(66446008)(53546011)(66476007)(8936002)(66556008)(33656002)(6506007)(966005)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?YzNOQUhCY0dTUFJ5QlBiRSt2bFBYbnpGWUxWemhPNis0SG1abWsyNHk3?=
 =?iso-2022-jp?B?bEZpcW9rNlFyLzMveHR2bVZkaXEvK1laWEQxMnJGSzIxaVYxTzFwNmlZ?=
 =?iso-2022-jp?B?WDNMR1ZtSDZRblJ5UzdSa1Z6cXZUN1FIazg3WWYxS0xOYkk1SWdvT3M2?=
 =?iso-2022-jp?B?ZkZiN05uNEVWYlR5SEZUbnhMWE5WcTBTdUlTS01tT2tCbHh1OXp0ZWtL?=
 =?iso-2022-jp?B?N0REWmhMc3FsN3VxN2F6TVZleWhacVhhZFg3RFRzZGMzcXdnSWk0R3pp?=
 =?iso-2022-jp?B?RExaSWZycXhNL3VORStpUHRUNHFubGoxZW5wb0crQ3d3SWlocE9qK1ZX?=
 =?iso-2022-jp?B?cG9hL0JBckgyOXcveCtuUnFMRU1GTlRkeXdzM05SZGEyWEwxL3ozZVZy?=
 =?iso-2022-jp?B?dVYxOUpsdnZCYlBmeExVWUdLUUhxZ2Jud0Q4Y2pIN2hrNEphWXJjaHE2?=
 =?iso-2022-jp?B?aHdJQmNsNlhTSHdqaTZlQmJlMGFNS0JXSTFaZzd0OTBYQXRXTm1KQjQr?=
 =?iso-2022-jp?B?Q0dPampFWUczYTB1bUNQNGpMM1liZWgxVnByMGhZZXRsalQ5RzUwSHBw?=
 =?iso-2022-jp?B?azBPZGI5aHJnT2hkeU9Fa0NLdk91UlNpUkJLZ282SVlyM1ZSQzcyeitq?=
 =?iso-2022-jp?B?K3plOGYyVlE4b3hNMC9IMy85R3FNa3lYNE83TnFXR21xWXpJNElWV3pt?=
 =?iso-2022-jp?B?R3pqTFQ4RmZhcHBxTE96b1h4bDBOR1NhZG1DMzBYSDRTc21FaXYxL2k1?=
 =?iso-2022-jp?B?S29QQ0xVK1NDL0hoa0FUNTNHRXBPVXFmTEUwVFVLVzJVQzNEdWpyNm84?=
 =?iso-2022-jp?B?Ukh3azduREpxT01GNkNaVW14aXo5QzhrVGY2MTFWZTBSSjV0ZXcvV1pZ?=
 =?iso-2022-jp?B?TTRZRHV4alNpS3Zoa3EzVlVDMFRmbnY0bUdRRnNuK3k0SnRWbCtoZVMz?=
 =?iso-2022-jp?B?dDlwaFI5VEt0TDlEcXpRMnhGYjJHM3FHWTVJUWIrTXFObVUxOHdUbGE5?=
 =?iso-2022-jp?B?V3FlWVZWanpxYlRma0t5ZG9TcUo4djl5NUdpTHJpcnlOMkREZ0Frbnk2?=
 =?iso-2022-jp?B?WTB3b05oejhiaCtmeG4zYndnYzM5akVGbEd4SVp2M1VvazVvS0Z5WGRW?=
 =?iso-2022-jp?B?bDR6VHNlTFZTRTd6ZjRFaVdBaDJBeVJNaVFjWTFNcTlDRWlCczBXYThS?=
 =?iso-2022-jp?B?b05NanNlUzFqV3REREptdU5XOW10YXkySmhWRFljYzJ1QjV6NjIxM1Rv?=
 =?iso-2022-jp?B?Y2RCelE2UUtBM0pvci9KZnJWM1cwT1QwRnVMKzlPa3RrZWxuZXJGRnNU?=
 =?iso-2022-jp?B?R3doLzJiMEJOSk5qWlN1VitUc1MxbVFlbDd4RTZuaFlPY2VXaXpvRHFh?=
 =?iso-2022-jp?B?ek9sMWxEMXpTSFp0aTQxUTVWb1NkVjlSMXNBS3E1SHZNdEc3VmZYOE9q?=
 =?iso-2022-jp?B?bUV2MWlucU1nRHRwVWtPeDZFYitjTXpHbjRrMWM2R2RXZ2krQTRHVnhF?=
 =?iso-2022-jp?B?OGhmT3lPRld6WkxSWFpzQkdqMUJvMVpSUnlUMXRLd2kvRlJ6cndnZ21w?=
 =?iso-2022-jp?B?UC96RzE5MjgyeEtPZFZLVmVKaHRURUNydnF2a2d1YXY3Z0UvUTVZTkhR?=
 =?iso-2022-jp?B?anhZQ1pQalNvR3Z2VTYvZVlsN3FEQ2dneWRSMVBqM1J1WXl4QWc3bUts?=
 =?iso-2022-jp?B?ejNPYWMrWEw4MEtIVWh0K0s0blQwNTZHa2RSL2R2SjNzamJNWTFaWjhk?=
 =?iso-2022-jp?B?bWVQRThaazBsNG5pZVFjNDEvY3hWNk9iU2ppYy9PcThPd1IvZVdxeDJr?=
 =?iso-2022-jp?B?c2tNZ2RwNFlJQWM0eUQ2T3VJUDEzYlJDSWpkTEdBWFhZMnBYMjVJQnNU?=
 =?iso-2022-jp?B?NjM3UjhPbXc3T1VYemkxbFgwMmpIeENzcThiQmlWeXdWT0p6ZXFqRnhP?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2146.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaf17cb-3ff3-4f6e-6e3e-08d9062f373d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 08:10:10.9308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gvL5cHJ0TQvT+Cep3esISqnR6VQ9gDfDYsxxjqcbXSEq65bsregH00nPKM7KnEuWb+wCDzjqKysgfq71C3PpdnbEPN2fw/p5NCWO6wwprPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2373
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

Thanks for your comment.=20

I am sorry that the description about the sector cache function was
difficult to understand. Since all public specifications were shown
in the URL, please give me some time, I will organize the contents of
64FX cache control function.=20

Best regards,=20
Tan Shaopeng
