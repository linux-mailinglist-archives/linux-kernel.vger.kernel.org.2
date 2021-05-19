Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F2738952C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 20:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhESSTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 14:19:11 -0400
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com ([40.107.92.67]:27041
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231311AbhESSTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 14:19:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFKb2DvBR/AfSRmgyY5pzDvvUTPezsH7EqTL+khJYU1QXQtv31fyg91WG6Qj0ETBEMDV1bcOeGNEt6JAvDFVIljGo79LLBPgllX10oo8mukNHJslYm+tDvhX8tfsQv19RHxFsAC3CNkH8nRcG8dbFSRL535w3hdW+vaWPQiVpI+P1zox1yTWfexzyBItmUHyf4DIBZ4nOcf8B08yFeGsFtc+agHN7vzqHst7rLtyBxFbI7x2NA1AJIATbkLcv4KUnORfe8E6WUuvV4ZunLrPARxGCshTwsUjBUH25oZrldreFpxnoiG+C/kRnvGXXbvHmiEElxZ3mGO/TcNx98SUrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5rThxPNGVuaOs1UtLlskhRKUF/f3sTuh1JCPeZ57tg=;
 b=XVe5XEx2TohS/9jTODHyw2ZRaxjme+N4Hk4+mRWIoh2L87GXbkA0pCcMteFlkwNbAHwzd42JYPk3k1GQIaPnHwaxkTYYnUg5p7u1WeZaH9jeLLUb7dwLXsw0qRz1La2KUvc7fe5YlT7gUoJCCv+cL+MCnbeBLfC9cBVGmdsnG9QcPziibxP6Id4QgvorfJAPUGwf9pJjkTn7k2UGdHoy6mKAQcaUwjaGH9YPaCYKqRAb2CTF0r4o2/v2MkXCF4tZTnYVeuyz16OU7R6sqTKR/F2YHnsZ7YHIuh8BMie3+EFDh7j0h+bqGSUowYtgq4VYfEuXhZ7tgdjU/BZu3glMug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5rThxPNGVuaOs1UtLlskhRKUF/f3sTuh1JCPeZ57tg=;
 b=aTFvHzNg0VqxMo8JFooXZvvELumCi65cdXeh+CZQtg7FZz/izW4JQ4Pb4BYaHUictGaNvJpvngi+XbEKDzChJ1GSpZJzTjzVmPbM286DCFSl2Rjcgqmm6Ui/LxRCF9n5jM/X+RyQNGffvzjRWGkQwihfna7/aRWnzGP+EfL3tok=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB6248.namprd05.prod.outlook.com (2603:10b6:a03:db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.12; Wed, 19 May
 2021 18:17:36 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::1c28:6a3d:d0d6:42fd]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::1c28:6a3d:d0d6:42fd%3]) with mapi id 15.20.4150.019; Wed, 19 May 2021
 18:17:36 +0000
From:   Nadav Amit <namit@vmware.com>
To:     kernel test robot <oliver.sang@intel.com>
CC:     Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [smp]  a32a4d8a81:  netperf.Throughput_tps -2.1% regression
Thread-Topic: [smp]  a32a4d8a81:  netperf.Throughput_tps -2.1% regression
Thread-Index: AQHXTLjYaZT7B2vV3EiePfaz1IztJKrrHQgA
Date:   Wed, 19 May 2021 18:17:35 +0000
Message-ID: <16A4D949-D82D-4034-B5A4-DE4DADE15884@vmware.com>
References: <20210519142742.GA5275@xsang-OptiPlex-9020>
In-Reply-To: <20210519142742.GA5275@xsang-OptiPlex-9020>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.80.0.2.43)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e2a1454-f808-41e6-c948-08d91af260fc
x-ms-traffictypediagnostic: BYAPR05MB6248:
x-microsoft-antispam-prvs: <BYAPR05MB624810C978723406B184F29CD02B9@BYAPR05MB6248.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A7WIlF5DFxKFclhUoDruXOZLrO3nq24SUAp1eUZha61Mh/lawfmYvKj3u0Ta4WRhsQcUAZ5iq9Gf2IQ7sP9rBcAZIT63HCF1nzj1+fyPoQ5Y8hA7PJzS8fOViNSco2xOy9xJmELEacZdbPUGO6PdzW39jAIW0ooDP7PYc3LVNEWMZkwHqL1u8lQcM2yA0iSZ+wnSgICtOdJfLREQBWMzc84yNFMLQSIwkmL0oyr8mzIjrlJ3tKLJu+oucrYbeWhH7+b1pbYApVtowbWRhv9zSiqZSUoHp3k5HdWxlIv2KJ6GNrOzE1VdC76OSTXhwqP0Ag9HgetKdzlxx9+S8wj/Bnl8NCv1VsghM5/fRJsnGNvDWAFCM9EnddMwKeZgalZf7PDfeAFV4k22ZNWhYgjRZ2nz7PE6AZyyvmQulsKAhmeIJRZd3IpzFECHgCI6FkK7VwVOwenFqJ7Nxpj3rHwSwPYmeLtsRtFSOASYFDsJfGjqyX9mcBWe/w/NaO9eStfDAOd7sJifg1uEyLEPAL0b+jQeoVTWLHJeoMba2cCTz/75OyGACGbI/++WiGbS/59HB8hvM4kyHpdQJ6PgA0YO76vvuqXfW5Gdu/QolQIKuyPvPBJR7fWBHC4KVKi5dNbN6BA3UqU3DLC7sCQ3xPipM5c1LKHVHcKtVIfc6BpLJBZwws31gfH0/MTOHwK+2PVoIiAsaP2n25GBOUrCMFGA9s1wBis2dMTNHYQJ5T19nTxiVDKCPAkx3BF52n8pA72cKHk+DEuLnI8ScvAvMno6vA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(478600001)(5660300002)(86362001)(99936003)(6486002)(33656002)(2906002)(76116006)(186003)(45080400002)(36756003)(71200400001)(6512007)(4326008)(122000001)(83380400001)(54906003)(8676002)(66446008)(7416002)(2616005)(66556008)(966005)(66476007)(64756008)(316002)(6916009)(8936002)(6506007)(66946007)(19627235002)(26005)(66616009)(53546011)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Q1p4QVpHcUUrRm1DZFVETGFYeDJQcEdIRy9TaHdDQW1ia3VsTGVlb0NzUHNy?=
 =?utf-8?B?NDA0Z3NqNWpaU2ZkUzdmNjRuMkVRSW0xaHgwSlVOMkM1UlVZNzZVblVIMGUy?=
 =?utf-8?B?MTVGQVFGVCtLelErcCtWK2dYZSszQXp6MDZBR3F2ZG5uNUV4MXVMaVJSV0Nu?=
 =?utf-8?B?b0dBUDJnbVVOMTl2UER1SWFTaS9sMkd1WldLcDh0ZERMc2tPZ1pGMW12THZC?=
 =?utf-8?B?R04yNmFPR3VyQTlaN2tYUVZIK1l2UkR6WHRMdkJYc2RYVFE3aStTOWFMZWs4?=
 =?utf-8?B?S2pLRDBURUFhOVFvTHlldHlXeG9INVh3YzY3QnFKSWlqOXVHVHEwN1B5OGJI?=
 =?utf-8?B?eFIxY1lNWEUyTnhsYUpTbFdaMEpUUFZ1Qnl3dHVvTnovNEUvL3BpNWduZDBw?=
 =?utf-8?B?amhKZStlYklpQk82SmlENDZ0cHgrdzFvQStjSUpNZFF3Qm5YaHVTOEZXekE0?=
 =?utf-8?B?bFlCa05OM3o4U1J4L00rNnM4dDVWRWYrRnFPYWdCMk56R253NUQ3Qk42SERU?=
 =?utf-8?B?UisxM3dJbktZSzNzVGREeWZrcFVYVHFxODVBdmhxaUNzVEl2ZnJJelk2TmFH?=
 =?utf-8?B?R3llUU9pTmdHbCtoR25sZmRiTFVOVEpGS01oRlRzL0hiamJDV3BpbkhrWWNH?=
 =?utf-8?B?cUJqL1hHMXBLckR4dXBNb0N2ZVpPTEhmdElESFZiTUlGVjg4MWQyc1UxWWhl?=
 =?utf-8?B?NE5nb0ZFM0tHOFc2QVQ1ckZuYjNoL1EvRXdPSGxNai9VeXhJb2V6SVdaY0RO?=
 =?utf-8?B?QW1iYWx3RVJQbVg1OFpKMkJ3QmtmSjVlZDM1YWFmNW5uWE9DY1hkZ2ljTTNL?=
 =?utf-8?B?cU1KbW51aFQvWkMwbGhRcUliK0I1NjA5cVNjSGFXbkJZMjBvTnczaFFNc0E4?=
 =?utf-8?B?cmJEY3ZrVFJ0R1pLRUFpdktZaEVGUFR0U0o1b29SSWx2YzU4dGJHcEtGbFdy?=
 =?utf-8?B?N0ZKaG1EN25LZlRVMWVBWXI5RVZ1N0xkMndqN2NQd0E0L05mTldERDRPYThz?=
 =?utf-8?B?QS8rWERuRnhRanQ3VEUrODVJZis2NHV3M25uYTJOSm8wZVBMUVR0U1ZiMVlQ?=
 =?utf-8?B?S1lwWFY5MEtBMFUwNWxOQ3llZ1c5cDhZSXdXeDFBR1R3cUtEV2VyMkNTRGtQ?=
 =?utf-8?B?cFZscmxDcjVQNS9CeHI1S2hETGd6d0dsUlFmTjNmbDlUYUVLZWczNFFUSnBJ?=
 =?utf-8?B?UFhMekRvdEIwdU45YWxsQitUbnR3bjBMU2didzNReFl1VmNOSU4rWVVlSys3?=
 =?utf-8?B?cHdWNnoreEg1bEtyOHhkZzlPSEZGY05vNHQ3TS80Y25NVGlBcXJtc0JaYWR4?=
 =?utf-8?B?MVY0dDBFMndXN1ZTWmFWOVVoejFaNlkzYU1LbEJFOHNhMDczUC9CUlZxOFRE?=
 =?utf-8?B?Qkk2S2lWZjVrbWtEWCtKVEl2QUgyWUFXdWNtVFhRczgzZ0VrOFBwcmlabXVz?=
 =?utf-8?B?aFJjYWhyYTJPeGpjUjhQT3pOeFo4ZHVxU3VGV3FvbkdnTVN5bmI4L1JjbWhW?=
 =?utf-8?B?eFZId1Znemhxd2k5bEJGa216SkRRa0hhK0JyMTFKcnpsYmcvTWw4cHMxdG5O?=
 =?utf-8?B?TlBoT1ViUjltSWZwUzBPVnZUbDlkaUNlR21PTmxTb3k0UXdYUTcxb1NKZDRQ?=
 =?utf-8?B?akdxTCt0ZkU3SkVDNys3VGFvVXNsbERKM2RWbmh0akdZWHZyMGNhN3lWYm5U?=
 =?utf-8?B?MUJWbGp1eDE2bUk1dVZTbEpDNElybmZGblRxRXJGd2pmcmJEc040VjdYamlZ?=
 =?utf-8?Q?x2NBSwUqyje86du3fB1ISZQAq6JSyMPU6p/nH5J?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed;
        boundary="Apple-Mail=_58AAFC2A-66A2-47BB-84B3-9650423EA90C";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2a1454-f808-41e6-c948-08d91af260fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 18:17:36.0068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zzB68yFXeJv1D0HyVK/4MN6EEagK4faBp/7b6QzvkB3HKVNcGN51p5KPYDMqEKvdId1PhF0OS/kwIs4VpQpMTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6248
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_58AAFC2A-66A2-47BB-84B3-9650423EA90C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

[ +PeterZ for reference ]


> On May 19, 2021, at 7:27 AM, kernel test robot <oliver.sang@intel.com> =
wrote:
>=20
>=20
>=20
> Greeting,
>=20
> FYI, we noticed a -2.1% regression of netperf.Throughput_tps due to =
commit:
>=20
>=20
> commit: a32a4d8a815c4eb6dc64b8962dc13a9dfae70868 ("smp: Run functions =
concurrently in smp_call_function_many_cond()")
> =
https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.ke=
rnel.org%2Fcgit%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=3D0=
4%7C01%7Cnamit%40vmware.com%7Ca49b22e928144aab039908d91acff8c4%7Cb39138ca3=
cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637570302823256266%7CUnknown%7CTWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10=
00&amp;sdata=3Dh2VRetBNlEQBvOlkYrRCMCK6%2BukRqlCElYxM8UfVxqI%3D&amp;reserv=
ed=3D0 master
>=20
>=20
> in testcase: netperf
> on test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 =
CPU @ 2.30GHz with 192G memory
> with following parameters:
>=20
> 	ip: ipv4
> 	runtime: 300s
> 	nr_threads: 1
> 	cluster: cs-localhost
> 	test: UDP_RR
> 	cpufreq_governor: performance
> 	ucode: 0x5003006
>=20
>=20

[snip]

> commit:
>  v5.12-rc2
>  a32a4d8a81 ("smp: Run functions concurrently in =
smp_call_function_many_cond()")
>=20
>       v5.12-rc2 a32a4d8a815c4eb6dc64b8962dc
> ---------------- ---------------------------
>         %stddev     %change         %stddev
>             \          |                \
>    116903            -2.1%     114404        =
netperf.Throughput_total_tps
>    116903            -2.1%     114404        netperf.Throughput_tps
>  35066769            -2.1%   34317990        =
netperf.time.voluntary_context_switches
>  35071059            -2.1%   34321258        netperf.workload
>     67295            +1.5%      68333        proc-vmstat.nr_anon_pages
>    463520            -2.1%     453603        vmstat.system.cs
>    535.28 =C2=B1  6%      -8.3%     490.97 =C2=B1 10%  =
sched_debug.cfs_rq:/.util_est_enqueued.max
>      0.02 =C2=B1  8%     -10.8%       0.02 =C2=B1  4%  =
sched_debug.cpu.nr_running.avg
>  76309820 =C2=B1  4%    +320.0%  3.205e+08 =C2=B1158%  cpuidle.C1.time
>  23409116 =C2=B1  3%     +31.0%   30676822 =C2=B1 20%  =
cpuidle.C1.usage
>  46720133 =C2=B1  2%     -12.9%   40709940 =C2=B1  2%  =
cpuidle.POLL.usage
>      5282 =C2=B1110%    +317.0%      22029 =C2=B1 58%  =
numa-vmstat.node3.nr_anon_pages
>     11998 =C2=B1 55%    +138.7%      28637 =C2=B1 45%  =
numa-vmstat.node3.nr_inactive_anon
>     11998 =C2=B1 55%    +138.7%      28637 =C2=B1 45%  =
numa-vmstat.node3.nr_zone_inactive_anon
>      8397 =C2=B1136%    +588.7%      57827 =C2=B1 75%  =
numa-meminfo.node3.AnonHugePages
>     21162 =C2=B1110%    +316.7%      88189 =C2=B1 58%  =
numa-meminfo.node3.AnonPages
>     48780 =C2=B1 54%    +136.8%     115533 =C2=B1 45%  =
numa-meminfo.node3.Inactive
>     48780 =C2=B1 54%    +136.8%     115533 =C2=B1 45%  =
numa-meminfo.node3.Inactive(anon)
>    467040            -2.1%     457094        =
perf-stat.i.context-switches
>      0.01 =C2=B1138%      +0.0        0.03 =C2=B1 73%  =
perf-stat.i.dTLB-store-miss-rate%
> 9.415e+08            -2.4%  9.188e+08 =C2=B1  2%  =
perf-stat.i.dTLB-stores
>      0.01 =C2=B1137%      +0.0        0.03 =C2=B1 73%  =
perf-stat.overall.dTLB-store-miss-rate%
>    465472            -2.1%     455557        =
perf-stat.ps.context-switches
> 9.385e+08            -2.4%  9.158e+08 =C2=B1  2%  =
perf-stat.ps.dTLB-stores
>      1.21 =C2=B1 14%      +0.2        1.41 =C2=B1  5%  =
perf-profile.calltrace.cycles-pp.__ip_append_data.ip_make_skb.udp_sendmsg.=
sock_sendmsg.__sys_sendto
>      2.05 =C2=B1 10%      +0.3        2.33 =C2=B1  4%  =
perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.s=
tart_secondary.secondary_startup_64_no_verify
>      0.06 =C2=B1  7%      +0.0        0.08 =C2=B1 14%  =
perf-profile.children.cycles-pp.__calc_delta
>      0.08 =C2=B1 19%      +0.0        0.10 =C2=B1  9%  =
perf-profile.children.cycles-pp._copy_to_user
>      0.09 =C2=B1 22%      +0.0        0.12 =C2=B1  8%  =
perf-profile.children.cycles-pp._copy_from_user
>      0.12 =C2=B1 20%      +0.0        0.17 =C2=B1 13%  =
perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>      0.14 =C2=B1 11%      +0.1        0.19 =C2=B1  9%  =
perf-profile.children.cycles-pp.skb_release_data
>      1.21 =C2=B1 14%      +0.2        1.41 =C2=B1  5%  =
perf-profile.children.cycles-pp.__ip_append_data
>      2.07 =C2=B1 11%      +0.3        2.33 =C2=B1  4%  =
perf-profile.children.cycles-pp.schedule_idle
>      0.06 =C2=B1  7%      +0.0        0.08 =C2=B1 11%  =
perf-profile.self.cycles-pp.__calc_delta
>      0.19 =C2=B1  8%      +0.0        0.24 =C2=B1  6%  =
perf-profile.self.cycles-pp.__softirqentry_text_start
>      0.24 =C2=B1  8%      +0.1        0.29 =C2=B1  4%  =
perf-profile.self.cycles-pp.__skb_recv_udp
>      0.14 =C2=B1 11%      +0.1        0.19 =C2=B1  9%  =
perf-profile.self.cycles-pp.skb_release_data
>      0.02 =C2=B1142%      +0.1        0.08 =C2=B1 17%  =
perf-profile.self.cycles-pp.sock_alloc_send_pskb
>      0.11 =C2=B1 17%      +0.1        0.19 =C2=B1 13%  =
perf-profile.self.cycles-pp.__ip_append_data
>      0.12 =C2=B1 34%      +0.1        0.26 =C2=B1 22%  =
perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
>      0.87 =C2=B1 13%      +0.2        1.05 =C2=B1  6%  =
perf-profile.self.cycles-pp._raw_spin_lock
>      1287 =C2=B1 42%     +75.3%       2256 =C2=B1 14%  =
interrupts.CPU111.CAL:Function_call_interrupts
>      1326 =C2=B1 43%     +71.0%       2267 =C2=B1 13%  =
interrupts.CPU119.CAL:Function_call_interrupts
>      1300 =C2=B1 45%     +75.9%       2287 =C2=B1 37%  =
interrupts.CPU120.CAL:Function_call_interrupts
>      1299 =C2=B1 45%     +60.1%       2081 =C2=B1 28%  =
interrupts.CPU128.CAL:Function_call_interrupts
>      1305 =C2=B1 45%     +61.7%       2110 =C2=B1 29%  =
interrupts.CPU131.CAL:Function_call_interrupts
>      1299 =C2=B1 45%     +61.8%       2102 =C2=B1 28%  =
interrupts.CPU139.CAL:Function_call_interrupts
>     66.67 =C2=B1133%     -97.2%       1.83 =C2=B1155%  =
interrupts.CPU14.TLB:TLB_shootdowns
>      1299 =C2=B1 45%    +107.8%       2700 =C2=B1 33%  =
interrupts.CPU142.CAL:Function_call_interrupts
>    301.83 =C2=B1128%     -95.6%      13.17 =C2=B1140%  =
interrupts.CPU149.RES:Rescheduling_interrupts
>    389.17 =C2=B1 89%     -73.5%     103.17 =C2=B1 35%  =
interrupts.CPU164.NMI:Non-maskable_interrupts
>    389.17 =C2=B1 89%     -73.5%     103.17 =C2=B1 35%  =
interrupts.CPU164.PMI:Performance_monitoring_interrupts
>      1299 =C2=B1 45%     +60.2%       2081 =C2=B1 28%  =
interrupts.CPU35.CAL:Function_call_interrupts
>      1244 =C2=B1 50%     +66.8%       2076 =C2=B1 27%  =
interrupts.CPU45.CAL:Function_call_interrupts
>      1300 =C2=B1 44%     +59.5%       2075 =C2=B1 28%  =
interrupts.CPU46.CAL:Function_call_interrupts
>      1.50 =C2=B1 63%   +1422.2%      22.83 =C2=B1167%  =
interrupts.CPU47.RES:Rescheduling_interrupts
>    467.33 =C2=B1 85%     -64.6%     165.67 =C2=B1 74%  =
interrupts.CPU58.NMI:Non-maskable_interrupts
>    467.33 =C2=B1 85%     -64.6%     165.67 =C2=B1 74%  =
interrupts.CPU58.PMI:Performance_monitoring_interrupts
>    306.67 =C2=B1 75%     -59.9%     122.83 =C2=B1 16%  =
interrupts.CPU68.NMI:Non-maskable_interrupts
>    306.67 =C2=B1 75%     -59.9%     122.83 =C2=B1 16%  =
interrupts.CPU68.PMI:Performance_monitoring_interrupts
>      1131 =C2=B1 27%     +61.2%       1822 =C2=B1 35%  =
interrupts.CPU85.CAL:Function_call_interrupts
>      1180 =C2=B1 31%     +79.6%       2119 =C2=B1 24%  =
interrupts.CPU86.CAL:Function_call_interrupts
>=20

Could it be a result of a regression that was resolved by commit
641acbf6fd6 ("smp: Micro-optimize smp_call_function_many_cond()")
or does this report mean that the performance regression also
happened on the -rc?


--Apple-Mail=_58AAFC2A-66A2-47BB-84B3-9650423EA90C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmClVj8ACgkQHaAqSaba
D1oyCA/9HxpRK1Li7xEVjsCcYv1fT9uq91N/EJhX96voDP+zIluULBrjCzqsfleT
8f51ISPiBy/TKwUHelpgswu22JWQFrBmryvxHdC+E+9KOcmysKtMXdGHQMls6vBF
Sj7ipW8gPhqy5wOi404SYztSYOChXtAQPEZiHcSXdD0JHlKNVEFY/czbfGNJYLC/
D0Q5JWXZWbleocplXFqRRHnvKhxUnFIMhCGqCQ5soNxWuT6LaalrncbKGizlG8V8
/qoHlySa02T51VYrwWTKASrcZ+GPsCxVNODl1Qf0XlAAjYiPjUwX43KLwRIpl4tZ
Jwrb0fVU8twVM1wWwV1hM5lod/3bIshXgLIn9NVu382+7PjO6biaVF0LJ80d91NO
0pFq4TPF4yg5sdbxzCRWf1DQ6BJ63+2ENipEzMp1S56SnOTFOusspDsrkGfFkvR3
5R1NHV6maAhkAkg4WbP8ogbberiK3ZWyXgcEdTEHUYhmMjw/Qyh5Qp58V7l2BtwM
sf6+P/caeWwx9Fs+qema2rMGr0m4LKlUNqeU0uLd/WpHsAn4AH9EYj0WEXmnPg4F
yYKPT6NCJ09CVCGdQD/hUmhiEXnCELtPRjs2NFWZxTOO4TQPkUzNg026tGbUCT8h
ZWn225WS9XYMCV/hH8FL5gaeQ0e2Zque5U2qUdmBi69BCmERUQk=
=iHLY
-----END PGP SIGNATURE-----

--Apple-Mail=_58AAFC2A-66A2-47BB-84B3-9650423EA90C--
