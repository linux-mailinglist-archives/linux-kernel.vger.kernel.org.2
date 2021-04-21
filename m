Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6821536670F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbhDUIhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:37:51 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:44198 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230250AbhDUIhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:37:50 -0400
IronPort-SDR: lB8NWLRZB9tgM/jn4ZvFHq+2vpR18jT/62KCs6eRv42I5LNbLEm40ksLT0gG013rt69Z2Vseaf
 gZiMtsogwnqqNSia5vNP6hXTJ+PWs7I3yLe6twvLQwBs4GCAbd8IVw/eAY8XKEzZyt/SCR3LQs
 DpC3G/zrNu+TrboGu7InOj0wFE/rVOXAt2j4qxZJfEUr5ujVhLu+mxlXSHhHpnK6rEmoMSqKRL
 VdeiUFghLyXiO+3QEdpKK8rWW46IF2IOHqLyMrIl7gyRHVy0Nquq7Pe39FpW49/OS5B9Z0ESXy
 /yA=
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="30541782"
X-IronPort-AV: E=Sophos;i="5.82,238,1613401200"; 
   d="scan'208";a="30541782"
Received: from mail-ty1jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 17:37:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsO2o1VNFaIFcZnNujyX4h4zIxKgZzfjUPQ/D3HfIsQ2RxzL5GksLMXaNxQMBedpulm5xpi3AJnBLqDrCM+WRtIU58Wy17W/PBtm9YlnR8Hf/VeLZYMGr1L20U0mvqismUmvlmsVmCPCsMMTWSjLiDyPJb9lBjTs/MjNakjN6/mF8I0SGR+XntSQddPLKDeM4/sLl4J5EPPozSr5TLKoQrhx11OLq1xssxHQ4iRDQWSaBw5uSk949izQBDGXKMTPoVDGGboWzgEaTL8U9BXuPZ0NmjI5NrBx1iqnSunVv94FYBxbDl7Gukcx1UU6pD+aEVUmj7OugKS+YKBwCYAjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1HlSStYa9YOgNA7NNOQzD9OIT/I+9MuWb2Y0UKzNso=;
 b=nz9dZg92NkGsbIK7Af3ctprMBiKuuyqLXAl1b9BRybWoZy4oKxLl30fm26xFsQe26fSq5lj0KZKydU8qHALh23YHN8ALz8PYl1zU6NtI/YYa8PLkHg2cIuTqLMgsejC+S0YR5D9Ly3G6Y0o67YSOGFhns7Ox5eIqMJj7ZHxsgMEUL/QitiZShPDjUOWtYdPsjfG40PLLbouL28xgpdijfWWOsDnK3/yFZnWccZ6xD5ve+BHk1x0mVVo2KJUq+luYQthcsddTG6zyl5L84Jhs14ycTj2E9OooXq/gwCLcrh5qQjaQcOts7yTZ3ub8Z6L+vGIoBwIrAYAJ6w8uA7PIMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1HlSStYa9YOgNA7NNOQzD9OIT/I+9MuWb2Y0UKzNso=;
 b=Ijj3fGPxJz7J5R+mrFFRyiVHvBxN9VX1HVyloxcPolNKJZ6k+bgopkYWRtda+ecWrgIAF/X4CFmTn36xH0PcckbImtAR47aoP6/ycjVDKnS1vvh2chU2/sQWomXxvboU/WLTQD7AWXHsRiH30ZrSj0qhOme8Z9EFAcDCNqH4v1M=
Received: from OSAPR01MB2146.jpnprd01.prod.outlook.com (2603:1096:603:15::15)
 by OSAPR01MB2948.jpnprd01.prod.outlook.com (2603:1096:604:4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Wed, 21 Apr
 2021 08:37:10 +0000
Received: from OSAPR01MB2146.jpnprd01.prod.outlook.com
 ([fe80::db4:dfac:6caf:d7c1]) by OSAPR01MB2146.jpnprd01.prod.outlook.com
 ([fe80::db4:dfac:6caf:d7c1%7]) with mapi id 15.20.4065.021; Wed, 21 Apr 2021
 08:37:10 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>,
        "'reinette.chatre@intel.com'" <reinette.chatre@intel.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        'James Morse' <james.morse@arm.com>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Subject: RE: About add an A64FX cache control function into resctrl
Thread-Topic: About add an A64FX cache control function into resctrl
Thread-Index: AdctARUohIvM7pb1S52qTlM+pjp6RAJht/AA
Date:   Wed, 21 Apr 2021 08:37:10 +0000
Message-ID: <OSAPR01MB214657641D532FB8D112DD528B479@OSAPR01MB2146.jpnprd01.prod.outlook.com>
References: <OSAPR01MB214600C7923AEF7C35B02E648B739@OSAPR01MB2146.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB214600C7923AEF7C35B02E648B739@OSAPR01MB2146.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.162.30.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a4170e9-ab58-4c6d-d268-08d904a0a77d
x-ms-traffictypediagnostic: OSAPR01MB2948:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB29481EB62C48808C4995BD078B479@OSAPR01MB2948.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D0fZVQFZj8sevXZ3mti0ywClATmKSKm5gU4tPSz8Z0G21ETk4RI6mnyu3BiomWd7EIJJTT7iox/CiDqs30L/KrzZ+9NiCCZUNilhtkg8K4nu+s4gINfAUDtpOy4jfuaWN3Kc4rSZYkdjvEybeoa3EgH03oZQcc9Qk9CdfFU14yVt/QWeq5pJinv3eRnaBeOcayitTl3w7iF9O+aegA4q4HCKErmGDHamK8DKbosuGXQURGtJSDnZz572MxHEVQFosrVzqupqTYUENXlvrLRZFUCBkvQj/QRnS7Nw2r+Epcay53YYbsFWVqXu6JFd+G55hk7S3EZ1Km1V+2GSDeZMOK8X7PC7uOY07R3hFJu0qKWEjOLdKf2KFCGrlXXEhHaLPxi09rF0wJwDhf3e6BjbAbyYAWwIpg5EqETZ3pMlVEkLFDAwtmmAxeuXnVn7gy1WeFiX/DP6Mt/+cxJPHNpaHvyC6ifWydSo93rgVCcoLV4qFq1Ku/hsMxvL7z1lVOT6vafAvlIQGfaV7kieDuYUEQPdTjRAebEIscyIwwlC0iPN+CUiPTqI8csPbwR9pMsY/97ZRQDJsdZa6n27czi2nWFvYpe+54RDMsDpjk8TGUZxBFXiSlAdsTYNQAhdZTnzZ0p5DVXXuJS9+RrvCYTTAsKpcOvx0wqeU918pWd30Zaqaqk7wGiyR/XIcZAga+6dc+xcdE6QjBOgeImVycEWRHQnpCWvxiorLMvEEVaaitA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2146.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(478600001)(7696005)(6506007)(26005)(186003)(8936002)(2906002)(316002)(4326008)(64756008)(66556008)(966005)(66446008)(110136005)(83380400001)(66946007)(76116006)(86362001)(38100700002)(9686003)(5660300002)(8676002)(55016002)(52536014)(54906003)(85182001)(33656002)(107886003)(122000001)(66476007)(71200400001)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?Q0tXSG5sQllBTm1kT3A1bGx4c3dnOTllRis3V2ZTeTVNbVFnV295VWRz?=
 =?iso-2022-jp?B?eDdjNWdXRmdzb3g5N2tscTBiSTdLNTlLSnp4bjFBdnYxbmhhUjNEVjM1?=
 =?iso-2022-jp?B?YmlCZ2xraDZXK0hBVmJJK0hDNE5BRGswV2J0MWV6QjIwblF4dm4xL0Zy?=
 =?iso-2022-jp?B?emdKSHFPYmVRT1ROcmxpYTVKNStmMXFFTkFQWXNVZC9ScmxldzhHd3NW?=
 =?iso-2022-jp?B?VjJnbmdsemljZFZGQThabjFDTkI2bUpzNThUK1p1M3BaejIwM0k0cXdv?=
 =?iso-2022-jp?B?UWZ0OW9UN0pZaktTV2JPMGsvQmRCdjZUY0UwSWZpVnNLMWJGWXk1eEZl?=
 =?iso-2022-jp?B?ZDR5NDZNN1pieGQrL3FMYVA5VnJiTkdRZDNVTTNDN2hJOUYyeTZBTG1T?=
 =?iso-2022-jp?B?MlB0dS9vd1NkelVlQXBHQ29YRVlzZDVMM2Y2cElIM0plY294cVBOWkRn?=
 =?iso-2022-jp?B?WUZYVW4wMmxZa3p3SWxUUzhnc1dINXlkaGNlSDBMMWE3NHY1TTZKcjkx?=
 =?iso-2022-jp?B?ZzFhNU9pbnVvS3kzaUREMjMzVW82TXg5bDFvTGdXMmcwK1RubU1TNXFG?=
 =?iso-2022-jp?B?WmxXeUJqbkN3SWVBeHVUSHdqL25PVXNnQ05jSHZkeVdURWxvQkpLUXZy?=
 =?iso-2022-jp?B?SEQwNm92WjVyOWF6TzIvRXhhcklkNWhFWk9BN3RaSjV1aE1ZRXhPYlRh?=
 =?iso-2022-jp?B?RlFVOHBpRHRVNGNHUEpHZE1xaHR1MHFyUXZCenJhd0Q1Qm9ranp0WnZV?=
 =?iso-2022-jp?B?NGFlMFk2eFV1WW5NMVlhWGIwODBjTXBaRHNXMG93bXlsUHd2Z3hzVmhy?=
 =?iso-2022-jp?B?Z2wvZGFTbENmUXk3aEJKQnRUZkdhbFJYWUM3NWEyZGVpWlBDN3BCd3Z6?=
 =?iso-2022-jp?B?T1FWcjl2Z21BK096bnpON2MxOHZlTnA1ZWhoMExyS2g3czVuZzBMdzZE?=
 =?iso-2022-jp?B?WlpWUERqSll3OU4ySHF0STFoWXF5VWppcENLR2I2WkcxcVBFUEx0OGtJ?=
 =?iso-2022-jp?B?aStzRDVQbGl5cTNqTlVXNEp1cGlGZUV2WVdRY3NIbEtURy8wVkVtVGlX?=
 =?iso-2022-jp?B?Q0tRditwaEtwcDkrajZTSDFNVVNydTFxaEtpTW1nSjRBbXFMRHZnUHlh?=
 =?iso-2022-jp?B?cmh1K2hKbTdHbjdWaTlyUFJPb3dYaXBpU0lGNmF4eTQ3RGR0YzBKYWZz?=
 =?iso-2022-jp?B?UkZKYW9hUXc2SjJ0bSt0ckJWcGlqUDhqakRJT1F6OUQwdGd0NTE4UWV3?=
 =?iso-2022-jp?B?YmRJOU5ZZzl5NGtqWVNyRWdCWEVaRDlBbGZFSUNmdXdacHZEbkxzZHJh?=
 =?iso-2022-jp?B?MGNYZ09HNERLNUFiL0JLWDdPdDVaWldod3lnZG5xdmxmSVVjRmRjUnJz?=
 =?iso-2022-jp?B?bStaNURzU01EcTBqT09KRFNJdW11dkJGdWV1Tm5ndkd5WXFhTzBhS2ll?=
 =?iso-2022-jp?B?L0w4SjJLd2xxT25LRFZGSWlrRVpRNlgxL003MnNtb2JRdU5VUmJCa0tr?=
 =?iso-2022-jp?B?NDNKcWZOSmdmeGMwNFVqczBLR2VteXNjY0lOR1hxT0lTcXFMTTBRdGZu?=
 =?iso-2022-jp?B?ejZJYlhIMUNPYXVkaWFQY3cxdllGdWZIZEVlWWY3YUQwMnd0S3FVSVg4?=
 =?iso-2022-jp?B?d0xvYlNVQUlMbElxQWozY2RQZTlrNkJ5RmxrYnJ3U1dvOWdsNkdLMisz?=
 =?iso-2022-jp?B?U2wrRERqTnpkc2M2WFQ1N0ZuTmlwNEg4VkZmcmxHSytqUFJYa1RoQ3Rl?=
 =?iso-2022-jp?B?Vlh5cTFPMndTVVczTUw1RnFyb040dkxrS1ZPMU9XbmR1Zy8zbVNEMHBq?=
 =?iso-2022-jp?B?V3JXaXIybkFrdlpLRlhMWFIweE14czBaMTBZazM5a1hqNFhuamtQOFpT?=
 =?iso-2022-jp?B?T1pFSmVnL0FONE1VUjNpTGxLdGZnPQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2146.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4170e9-ab58-4c6d-d268-08d904a0a77d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 08:37:10.0605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYqkTb1SIhqCaMf/6bP9uYGVA1SwleuRYQNJZfIQ8e8UN7+k1FbxV8zYJYrA1UwUBQijgn1+isjpMtNbiNAC4XkXhoPs67Wn1IjkS32rXVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2948
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ping... any comments&advice about add an A64FX cache control function into =
resctrl?

Best regards
Tan Shaopeng

> Hello
>=20
>=20
> I'm Tan Shaopeng from Fujitsu Limited.
>=20
> I=1B$B!G=1B(Bm trying to implement Fujitsu A64FX=1B$B!G=1B(Bs cache relat=
ed features.
> It is a cache partitioning function we called sector cache function that =
using
> the value of the tag that is upper 8 bits of the 64bit address and the va=
lue of the
> sector cache register to control virtual cache capacity of the L1D&L2 cac=
he.
>=20
> A few days ago, when I sent a driver that realizes this function to
> ARM64 kernel community, Will Deacon and Arnd Bergmann suggested an idea
> to add the sector cache function of A64FX into resctrl.
> https://lore.kernel.org/linux-arm-kernel/CAK8P3a2pFcNTw9NpRtQfYr7A5Oc
> Z=3DAs2kM0D_sbfFcGQ_J2Q+Q@mail.gmail.com/
>=20
> Based on my study, I think the sector cache function of A64FX can be adde=
d
> into the allocation features of resctrl after James' resctrl rework has f=
inished.
> But, in order to implement this function, more interfaces for resctrl are=
 need.
> The details are as follow, and could you give me some advice?
>=20
> [Sector cache function]
> The sector cache function split cache into multiple sectors and control t=
hem
> separately. It is implemented on the L1D cache and
> L2 cache in the A64FX processor and can be controlled individually for L1=
D
> cache and L2 cache. A64FX has no L3 cache. Each L1D cache and L2 cache
> has 4 sectors. Which L1D sector is used is specified by the value of [57:=
56] bits
> of address, how many ways of sector are specified by the value of registe=
r
> (IMP_SCCR_L1_EL0).
> Which L2 sector is used is specified by the value of [56] bits of address=
, and
> how many ways of sector are specified by value of register
> (IMP_SCCR_ASSIGN_EL1, IMP_SCCR_SET0_L2_EL1,
> IMP_SCCR_SET1_L2_EL1).
>=20
> For more details of sector cache function, see A64FX HPC extension
> specification (1.2. Sector cache) in https://github.com/fujitsu/A64FX
>=20
> [Difference between resctrl(CAT) and this sector cache function]
> L2/L3 CAT (Cache Allocation Technology) enables the user to specify some
> physical partition of cache space that an application can fill.
> A64FX's L1D/L2 cache has 4 sectors and 16ways. This sector function enabl=
es
> a user to specify number of ways each sector uses.
> Therefore, for CAT it is enough to specify a cache portion for each cache=
_id
> (socket). On the other hand, sector cache needs to specify cache portion =
of
> each sector for each cache_id, and following extension to resctrl interfa=
ce is
> needed to support sector cache.
>=20
> [Idear for A64FX sector cache function control interface (schemata file
> details)]
> L1:<cache_id0>=3D<cwbm>,<cwbm>,<cwbm>,<cwbm>;<cache_id1>=3D<cw
> bm>,<cwbm>,<cwbm>,<cwbm>;=1B$B!D=1B(B
> L2:<cache_id0>=3D>=3D<cwbm>,<cwbm>,<cwbm>,<cwbm>;<cache_id1>=3D
> <cwbm>,<cwbm>,<cwbm>,<cwbm>;=1B$B!D=1B(B
>=20
> =1B$B!&=1B(BL1: Add a new interface to control the L1D cache.
> =1B$B!&=1B(B<cwbm>,<cwbm>,<cwbm>,<cwbm>=1B$B!'=1B(BSpecify the number of =
ways for each
> sector.
> =1B$B!&=1B(Bcwbm=1B$B!'=1B(BSpecify the number of ways in each sector as =
a bitmap (percentage),
>   but the bitmap does not indicate the location of the cache.
> * In the sector cache function, L2 sector cache way setting register is
>   shared among PEs (Processor Element) in shared domain. If two PEs
>   which share L2 cache belongs to different resource groups, one resource
>   group's L2 setting will affect to other resource group's L2 setting.
> * Since A64FX does not support MPAM, it is not necessary to consider
>   how to switch between MPAM and sector cache function now.
>=20
> Some questions:
> 1.I'm still studying about RDT, could you tell me whether RDT has
>   the similar mechanism with sector cache function?
> 2.In RDT, L3 cache is shared among cores in socket. If two cores which
>   share L3 cache belongs to different resource groups, one resource
>   group's L3 setting will affect to other resource group's L3 setting?
> 3.Is this approach acceptable? could you give me some advice?
>=20
>=20
> Best regards
> Tan Shaopeng

