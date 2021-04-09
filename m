Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A004359505
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhDIFx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:53:56 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33]:29525 "EHLO
        esa16.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229840AbhDIFxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:53:55 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Apr 2021 01:53:54 EDT
IronPort-SDR: WJMjrz4/1Dp1ReRR6t1FzyYM5BGXSOqQrrtCxXZDgC6J30xAy0C9/BQ1Cnnxgdhx/LJLNKV+kk
 uWLKSk0bzdhiDzvLf+/tSPk6dOX68YS7cnh+bxdETk5iDzik3JAMix5jp5AKum8ZLe6hWvIFVA
 1myq11xrZ0747Efks3au5klWfEifmt+RlY8GxgkK2OPJI8pHy388zdkqR/YwcfPz5HrASqMXe2
 jglWLRV0oM07yxVjVVvSPhOAfKjNQDajharlo/VJC9T8oDemTXUAK9ZhFGddrG08Np9zSVghTu
 yuk=
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="29335514"
X-IronPort-AV: E=Sophos;i="5.82,208,1613401200"; 
   d="scan'208";a="29335514"
Received: from mail-ty1jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 14:46:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyuIlWhxS/V3WitfkhD9jaHBKtE4oAapbiFEPxZb7OY//68kzeizWjL3ivS+dL52p9A/k+H2JrXOxb0/zyEsrv3adyMnTCMZ8lUzg7v1zgbrbokSbdsa4f7d2gkVmSHpQLVGeBzaePQ3W17OsJpx6mhOsmS2HfDZ38JcFwDJg3aecCWPOwulUp+hxECRwT7FCBXNLCdiOC/+UznIs+EicB2J1a0rVmOYhyutTsYLnfM8DGwv3NzVZ3k4y5OeRmulEtsNFXFHPvi0wO/9d6zl6amydXLbbFTngkcn/288iVbSUPk0F98aixHhAl2OWOHQid4pdZAUdUe53hGVaERDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQYafnE16lFJcFCTU+AvV2L1pZYr6iITTWbnoGnVNXY=;
 b=Xy/PrdrPAzFNGE5HAKPzEnP/IM0u2uwk7tHpteWPV3TIC3rkYICaa04f4ZjAu4orEZHzOrGPXifc9/mX9BnyvmrV8KlOEdMRFtuz7rfxutI0liiRxMVpKsAiBg4ISwxJa+SfeZgx9tQBQnMKUfY9auxIfiHAz4HF3vrMZ8ipKhaN84558ln/16mx4wzwOAW2oHjA19rn07PGKeS//pVqGVw3UE8i8dwrvcYFPYAJ+XBaeS1z1oQ5qzr4xXlT12CH2mMSjSD3U0yidHRcH8ahie5zzmQKnrFNRhTsiTOysr6htzqbqDCN5UruEUCrXhryx/qXSabOv4h/ICYrh5fU/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQYafnE16lFJcFCTU+AvV2L1pZYr6iITTWbnoGnVNXY=;
 b=Ar/LNk3wMTbeZQ2865dH32OSwncKEm+Emy1COD6ht4O4BqtnrQFbt9//PeC95RVj4MGqiJe0DrYA0xOwd3ZMg7jOPCi1U2OJVZfk3iDA4omLhu/2hBPceZUSsNkiXIjq9IJi8GYsTcXnwtQNoOZFa5D1UYvSR8FXuvUqCUG2Um0=
Received: from OSAPR01MB2146.jpnprd01.prod.outlook.com (2603:1096:603:15::15)
 by OS3PR01MB6150.jpnprd01.prod.outlook.com (2603:1096:604:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Fri, 9 Apr
 2021 05:46:28 +0000
Received: from OSAPR01MB2146.jpnprd01.prod.outlook.com
 ([fe80::6876:99f3:9288:691d]) by OSAPR01MB2146.jpnprd01.prod.outlook.com
 ([fe80::6876:99f3:9288:691d%6]) with mapi id 15.20.3999.034; Fri, 9 Apr 2021
 05:46:28 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>,
        "'reinette.chatre@intel.com'" <reinette.chatre@intel.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        'James Morse' <james.morse@arm.com>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Subject: About add an A64FX cache control function into resctrl
Thread-Topic: About add an A64FX cache control function into resctrl
Thread-Index: AdctARUohIvM7pb1S52qTlM+pjp6RA==
Date:   Fri, 9 Apr 2021 05:46:28 +0000
Message-ID: <OSAPR01MB214600C7923AEF7C35B02E648B739@OSAPR01MB2146.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.162.30.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fcf883b-389b-4019-80eb-08d8fb1ad239
x-ms-traffictypediagnostic: OS3PR01MB6150:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS3PR01MB615037E8C2AFB7633861FB728B739@OS3PR01MB6150.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dag8asAfFM9AZgpElUPTJzTVfhfNxAMTJMTvZUdpD6uB/YPn5phKA1wMaj5tmjIBA4j2Nq3vBgpAplE7f9PtjuxJ+OxMYuYRug0wJd4VYo1oqQcWH/SDpWNIDamh4W4kKPfYYmn/r8YyvM7FnhAWTl46QJfoM+boSOgct2SQYyQTGOrxHu748lN2fzFdiucdkBOsG58X7K1qwVxNIjKKrGcChtc+pXYq9PTbcHyA9Pbh3fFSD7c7SwLuKb8ygngbj8XZynxUmGYTGZF+l33f5aDYtNQsKmWY8RdlhgEkQ9m21t2hTHBN8JVEtcRtv2Ra9wNCxMoFFO8rCSAwROI1oVoZLyFcdTbArWQZGwOdOiOi9ZNcAiqYkQXVGFZ1+X1Dc0WnAxsdwmmID6z35rSmeaEInS8gSUWRrhlfZdklIhZpiUWs2TiwgFMPb+oH1TjYKFm4xQ9ltNNS/Jjpz3GXkCvohe2lGep4L5PYZaWA/q9t/ofRg5eLI8p8AZ5os5WUdr9+4RiilKUSN7kEHwgrOWBVlujWBBmMp8hBcgRScyf5rXkk4RAlcNCnoXNosDkEZ+cQenuCBru+f6U50tSe+8Zy0dhbiCNY32s/TqpyIOMGqwkkFeTxthfFGP3KgSR1I217LJgjGz/H9FQQSusXW7oyiNtm2Mil3SPdeMc8UwfoX4J/e9ZxgkKznyW//OjT9fYROluVgKCoFqBz1Q/ShVZ3HVgAYrHurTBlogLrGhC60bdNVI1VF09kUDcJcOg5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2146.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(83380400001)(9686003)(66476007)(66446008)(64756008)(52536014)(66946007)(86362001)(54906003)(2906002)(66556008)(76116006)(33656002)(110136005)(8676002)(107886003)(4326008)(966005)(71200400001)(7696005)(85182001)(5660300002)(6506007)(316002)(478600001)(55016002)(186003)(8936002)(38100700001)(26005)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?QTAreHBqVlJoOXNvNjNNY1M3em10OG1zeGZ2ckxaZHNXb3RuV1Q5ZWNt?=
 =?iso-2022-jp?B?U0JDMlhGemwrbEt4ODNuRzQyWjlGUWhhTFdjMlR3aHp5TUZKRlI3MHpH?=
 =?iso-2022-jp?B?MzFnNUhtUGhBTzhUQlhWaEZSY01NckQzSVJKeHFlUlJ0cXlLa0s5amo0?=
 =?iso-2022-jp?B?Q21tVGpKUWViblZwWDc5K0FSZ1dNbkxVMU9Wa0YvMzlxNCtUdnNLRm8w?=
 =?iso-2022-jp?B?ZmF3czJwQkY1VHZLeU9wQi9iSVBNcnZRSVE2U241YVBnWTFBOXhGWGN6?=
 =?iso-2022-jp?B?QmVsREFYUTA5VEpKQUFPdnI4Ty9jL1ZFK2h5YzB3bFhabmpRMmROZEsw?=
 =?iso-2022-jp?B?cElGNnZMbnBSREk4K3JQNmJXZndjTi9rbGdsYitFNURrRlVsUFFyNmtB?=
 =?iso-2022-jp?B?ZkRsZFViNU9uT0g1YXN4L0FOTHg5MmlkRFo4cFNBbEJENllSSFlHYmwv?=
 =?iso-2022-jp?B?bDNKQmx3SWZBbjlyZXVuSWtiL3grWVdEM0pYbHA3S0xKNnFxdGF3MUM1?=
 =?iso-2022-jp?B?eEsxdC9TL0VqWVpxWnh1dTA1YWNoMVlqVG13TDk3bTl4ZmEzL0REWDZv?=
 =?iso-2022-jp?B?TDFVeGpkNUJWTXJKSDRKQ1QrM1h4cmY1V1dPRFJYWVJMZ1F4K1ZKR1RC?=
 =?iso-2022-jp?B?aUhnM3RhQW1yblcxWFdmcnA3N3hRd1RMb2lDVWd4bU1vakVPOEhJY0cr?=
 =?iso-2022-jp?B?d1M4V09BMXQvWnJzTTVjYW9WN3d1TTEwNGxkR2gzKzVLNS84ejNoS2th?=
 =?iso-2022-jp?B?U0E5Qy9uQzU3MFoxSXBpNllncnc5Tk1RUG9DVmR1a2UyeVg3dVEwKzBJ?=
 =?iso-2022-jp?B?aUsyMmllVkZ1dElGVERiQURxZlFGM1lYN0dXRXVyejc1VXNDRXFNbTBK?=
 =?iso-2022-jp?B?cFBkRm13NjVLaCs3UFNJSVJUQmlTRFFnUGp4Z2hBeUxOZzdFdFBZNzgr?=
 =?iso-2022-jp?B?VTVKYUo0T3htZXlvOWtISzhTbjJHbUZzcThybGZnalFrVTZQcEtCbGpn?=
 =?iso-2022-jp?B?Y0lJQjM0TmViUHhRV2FPZGl4aU5nd2hpSk9ubzlUY1Vvc1FmVHA2cTNp?=
 =?iso-2022-jp?B?S1ZINHNoNWM1Q3FMd1UycGhmcHh2WlJKTlVFVnpmYmZheW9oNVpDck9V?=
 =?iso-2022-jp?B?RzB1TndxelQ2NVJpc2lkVWlKalh0QWllSHpTTDdQQXRIdEs2K2VMeDZ1?=
 =?iso-2022-jp?B?RC9pQTNPeWc2N3NUQWVSUXVvUVBNc296Q3hMRUFWbDU4TjN0bnNmaHdU?=
 =?iso-2022-jp?B?YUlRTVBUUGhOQTF3VExzVlpxRUtxRGdRRzB4RExVeno0K09BUDlGQWox?=
 =?iso-2022-jp?B?L0xjc2EyelhzRFVkYzRoaGhmeFNOMkRVUW91dU4zYmluaS8xaDh6WWVV?=
 =?iso-2022-jp?B?SjlEVlF6YVlSb3U0NVNybEdleUxSWWRvaXJhY25qc2RYNXQzWUsrZWZa?=
 =?iso-2022-jp?B?RGRMRDVxaHZ0di9kcHFnYTVyZmJ3MFM0RFV0cWdiamlET3dGMSthMGtx?=
 =?iso-2022-jp?B?MFlDZ0RQbVh2dGRwOGxieG1sSUNHc1dGazlsM1BlYWVoaW5rSHlSSVpw?=
 =?iso-2022-jp?B?eUkwVTNnOEYvdXpWUlVUL1VQV3pGYnNTT01LMCt2TXJIRDVNeWNYTlZr?=
 =?iso-2022-jp?B?T2pFT1RydzYwZCtEdC8xRUxVRko0NTVPZ0NmTWZ1aktSb0FTRE91cVdl?=
 =?iso-2022-jp?B?OWlxNzNJbTJNVmV2WjR3WVd5amlIYkFuaGZqYnpwMTJTbzYzNm5uQXFO?=
 =?iso-2022-jp?B?d0xWQjYvOTR4OUFRcUg0ODR5Z2lBakRTRjF5ZEZRdTAyU0lNRm9VeTJp?=
 =?iso-2022-jp?B?cHNWWm5zK0JsVTlqVEl6QmF3MnAxcE5xU1k2RHhxUGFzOHIwV1J1Y01K?=
 =?iso-2022-jp?B?dElhMXRldDZUbFd4dGdGSFRmalozVG9UODJIY2tXME9od2xWQjZTYnBI?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2146.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcf883b-389b-4019-80eb-08d8fb1ad239
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 05:46:28.6691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GdVT5/sSOGjm+63lmvxrz9wNLoudjmUgcRzbfF9uUSOMH+u84c/ki15gJ/egeSgW/JtDddCkBYtMdQF4mwwJjmLYFdATo9bp3lE1JpJDuDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello


I'm Tan Shaopeng from Fujitsu Limited.=20

I=1B$B!G=1B(Bm trying to implement Fujitsu A64FX=1B$B!G=1B(Bs cache related=
 features.=20
It is a cache partitioning function we called sector cache function=20
that using the value of the tag that is upper 8 bits of the 64bit=20
address and the value of the sector cache register to control virtual=20
cache capacity of the L1D&L2 cache.=20

A few days ago, when I sent a driver that realizes this function to=20
ARM64 kernel community, Will Deacon and Arnd Bergmann suggested=20
an idea to add the sector cache function of A64FX into resctrl.=20
https://lore.kernel.org/linux-arm-kernel/CAK8P3a2pFcNTw9NpRtQfYr7A5OcZ=3DAs=
2kM0D_sbfFcGQ_J2Q+Q@mail.gmail.com/=20

Based on my study, I think the sector cache function of A64FX can be=20
added into the allocation features of resctrl after James' resctrl=20
rework has finished. But, in order to implement this function,=20
more interfaces for resctrl are need. The details are as follow,=20
and could you give me some advice?=20

[Sector cache function]=20
The sector cache function split cache into multiple sectors and=20
control them separately. It is implemented on the L1D cache and=20
L2 cache in the A64FX processor and can be controlled individually=20
for L1D cache and L2 cache. A64FX has no L3 cache. Each L1D cache=20
and L2 cache has 4 sectors. Which L1D sector is used is specified=20
by the value of [57:56] bits of address, how many ways of sector=20
are specified by the value of register (IMP_SCCR_L1_EL0).=20
Which L2 sector is used is specified by the value of [56] bits of=20
address, and how many ways of sector are specified by value of register=20
(IMP_SCCR_ASSIGN_EL1, IMP_SCCR_SET0_L2_EL1, IMP_SCCR_SET1_L2_EL1).=20

For more details of sector cache function,=20
see A64FX HPC extension specification (1.2. Sector cache) in=20
https://github.com/fujitsu/A64FX=20

[Difference between resctrl(CAT) and this sector cache function]=20
L2/L3 CAT (Cache Allocation Technology) enables the user to specify=20
some physical partition of cache space that an application can fill.=20
A64FX's L1D/L2 cache has 4 sectors and 16ways. This sector function=20
enables a user to specify number of ways each sector uses.=20
Therefore, for CAT it is enough to specify a cache portion for=20
each cache_id (socket). On the other hand, sector cache needs to=20
specify cache portion of each sector for each cache_id, and following=20
extension to resctrl interface is needed to support sector cache.=20

[Idear for A64FX sector cache function control interface (schemata file det=
ails)]=20
L1:<cache_id0>=3D<cwbm>,<cwbm>,<cwbm>,<cwbm>;<cache_id1>=3D<cwbm>,<cwbm>,<c=
wbm>,<cwbm>;=1B$B!D=1B(B =20
L2:<cache_id0>=3D>=3D<cwbm>,<cwbm>,<cwbm>,<cwbm>;<cache_id1>=3D<cwbm>,<cwbm=
>,<cwbm>,<cwbm>;=1B$B!D=1B(B=20

=1B$B!&=1B(BL1: Add a new interface to control the L1D cache.=20
=1B$B!&=1B(B<cwbm>,<cwbm>,<cwbm>,<cwbm>=1B$B!'=1B(BSpecify the number of wa=
ys for each sector.=20
=1B$B!&=1B(Bcwbm=1B$B!'=1B(BSpecify the number of ways in each sector as a =
bitmap (percentage),=20
  but the bitmap does not indicate the location of the cache.=20
* In the sector cache function, L2 sector cache way setting register is=20
  shared among PEs (Processor Element) in shared domain. If two PEs=20
  which share L2 cache belongs to different resource groups, one resource=20
  group's L2 setting will affect to other resource group's L2 setting.=20
* Since A64FX does not support MPAM, it is not necessary to consider=20
  how to switch between MPAM and sector cache function now.=20

Some questions:=20
1.I'm still studying about RDT, could you tell me whether RDT has=20
  the similar mechanism with sector cache function?=20
2.In RDT, L3 cache is shared among cores in socket. If two cores which=20
  share L3 cache belongs to different resource groups, one resource=20
  group's L3 setting will affect to other resource group's L3 setting?=20
3.Is this approach acceptable? could you give me some advice?=20


Best regards=20
Tan Shaopeng=20

