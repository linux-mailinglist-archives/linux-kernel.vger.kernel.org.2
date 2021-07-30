Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F416A3DB895
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 14:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbhG3M1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 08:27:35 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com ([40.107.220.76]:15294
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238736AbhG3M1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 08:27:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goqoUg3vQQ+Ji/OvtyW1o/zq2ZSfmucpMUPWJndADn8EAbYrrYMEphHpuMrviUMPACNBFxH/0s2L4JmixyBslQ1yFftZPUwvCZGmoYD6cJuwEcSeN8dAWLWmtXkWVOQoCKxayoEiqsvRJcIps0+OmXK3Nid1+PKAiLuvKtSHr/ahEo0FNWd2Dxm6LbGytnPuEWWTjEjJ1GfgBn7p0blmwpPEhDeYkNVkxb3Mb7PHryXlWFUuD9XR/TXJow51bEF11t8tL7z20Ph6xnquXfwqR+EXseaTlS6mslOxwOE6iXKj2nDWF6ckfuXODDZnET+K76PH7WvdqFc5199TDnfIBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B18dQY9x3y+v2JWyP/wtqmRjdb3BSj0Xgi3cIrXwWmI=;
 b=h6S7oWKaa9V4dnFhyQBNL3B5YFZFTtKTVriJZztUE5K8L0z2ORZwR6lLCDY4PzNLhrPOcN0XHbvpJQ31H5MEVkvNA5QRX4eCXlBNWn5BA0BrlxGIZi9q8BHQafFgIm1LbZo/UE4fGwdDFN73A9TrQ2/4kJvERIIssjJzs9anX3xw2c2DlkI/PSaCyVhifEbrODv8xR8Yw2FE38I640a+pPxaKze1IEkyEJHg5jpGsGfvx5bn+fiKdoDM46+2nmsk9qA0TLjfoVXavtltpKZncHjuoHC0cV65QMDRA8NAm25u0aY1cydduFN1ARwLx+MNrdbwS6u6rcw4eja+0L2/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B18dQY9x3y+v2JWyP/wtqmRjdb3BSj0Xgi3cIrXwWmI=;
 b=Ih1Kc6LIDg4D1jCAQ6mED+ofaOse//MLCLJKwi5zANqy0bQe5d3sOPwnglMZ+0xHF2nMQzHErODoLcsvavLppwOVFo07VbQuAhZu/J0xbgTHmiZOcobIw2VB00ebkWou9I9mvAQtiLTeWqkJIk3SdDre8TOdRUUNqtpc7RCtYAw=
Received: from BYAPR05MB4839.namprd05.prod.outlook.com (2603:10b6:a03:42::13)
 by BY5PR05MB7105.namprd05.prod.outlook.com (2603:10b6:a03:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.15; Fri, 30 Jul
 2021 12:27:27 +0000
Received: from BYAPR05MB4839.namprd05.prod.outlook.com
 ([fe80::a062:f4a9:6ef1:61ff]) by BYAPR05MB4839.namprd05.prod.outlook.com
 ([fe80::a062:f4a9:6ef1:61ff%5]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 12:27:27 +0000
From:   Abdul Anshad Azeez <aazees@vmware.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Rajender M <manir@vmware.com>,
        Rahul Gopakumar <gopakumarr@vmware.com>
Subject: [Linux Kernel 5.13 GA] ESXi Performance regression
Thread-Topic: [Linux Kernel 5.13 GA] ESXi Performance regression
Thread-Index: AQHXhTyNLF9o+lnoy02JoxwVp6cTWA==
Date:   Fri, 30 Jul 2021 12:27:26 +0000
Message-ID: <BYAPR05MB483975D437F293A40BEF3189A6EC9@BYAPR05MB4839.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bb92bf1-3af9-42bc-a7b9-08d95355645a
x-ms-traffictypediagnostic: BY5PR05MB7105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR05MB7105E4CFE2F645BA0FE8845DA6EC9@BY5PR05MB7105.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zysn2yvTAriioHpczw0MVMOOZGTt3+K4b4vEZYrSDeV31FC2eg9QwKztjNPziRWKV66La9u0oR/+acwIEiLcmMu1ojVZK4mhus/tz87GkrMz48f/YhI/gYJZQjvYGYDYHj60VxIlvajwFZY5qySDL09JNvRRF4XP9oiiyhZ1Ngbi6nNb40pCU8Wtu5mLcsKxsvLFqY2LMLHMOnCKhNf7kEGx+FnCLD654Nt+vWxO/ZlEwyoP4ak9rRxb2YEjpNFYSZPnD9IrcpxUfoJxXlY9IWAXECcH6z7W7kq3u8kpJ6RPUPFUwvvhk2WdCLUiUdaVgJGHPCCEvLqtqnU7QSAfT45Uj59w7HjoD+YYlhqRx7d2Gt9gSG+amCWiInGblSOALBgExIYhAovHzJurdZtD9LvDgcy35OM61htRrNHScljT4pl6+yev6NlVcgasjFZj9Eq1XNPbeawRPGB7IK+T/uavx7dbE3uepx4UynPGKYSUkIyVZHNoKm3uvOAJmbRW1K1qFK5QhcrJaxJ7ak6kDLzjxiHGXDPemmH0B7B7hmNIzrCEuJ9zGybDofk+DG9NoHI42gh9rvs0h7vghVG7ic1QV90p0Hl/rkkvJA1bmU05ErxTvFIaYfxF+n0iefGmBQ0m6jet+MKHJAK+xmDH8WIWkiue7jOXep+Xasv49xybpZGkPeqNr5B6inkdcrr9+JkgCchv0TGNGUyFwHw6qQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4839.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(55016002)(7696005)(8936002)(478600001)(86362001)(122000001)(38100700002)(38070700005)(9686003)(83380400001)(4326008)(186003)(8676002)(316002)(52536014)(2906002)(5660300002)(66476007)(66556008)(33656002)(54906003)(64756008)(66446008)(55236004)(66946007)(107886003)(6506007)(76116006)(26005)(91956017)(6916009)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?7pV1G6Ol1zxG/keq0LpbuSiXMrX8R4bxGloC5U5/McS5C/LZ5ukTbKgD?=
 =?Windows-1252?Q?g2t6lzX/30EjbZ++gSS45qBndDZ0rXIMXP7Kpgw9JgStR48hGOnVFoqY?=
 =?Windows-1252?Q?73Yl6ph0yKnLvoroGqpps8qaUmtee2WiELGnoEPFM0VLph/XzfLH26CE?=
 =?Windows-1252?Q?jUCNOfU6spEa1Xw3ILmHo+3mHql+XeDmQJB9FYghsJvjze+GkhSaSa9E?=
 =?Windows-1252?Q?JHaNCPw60WBMURqfbptB31h6clviB5brEbzjPfLqtUe2BpuFCgQPdDyr?=
 =?Windows-1252?Q?s8erNqDQjQF3II7mjRalKtkgmgAvyh7UvioHKPQ/l1DxEihBy+393v/i?=
 =?Windows-1252?Q?nB3RKP+NcL33qZD/pokMV0Yj4NoAyTAPOBU6CDBk9iHboISUp1rOdZ9C?=
 =?Windows-1252?Q?l7sSDTDINiipbxKj8qmWO/A+tiKyCRY4sJ62v4zQXfas9ORbDgU5Ip+Z?=
 =?Windows-1252?Q?H86aHmXmiqM6nFMSDwMnYH4w7mgCYjSdsS5VgTF0i71zawaehZst/x9o?=
 =?Windows-1252?Q?kwF3mEaCyUrxinKA1AKnSNHqViysKiMqSoMqMZqzlDCKkRmAczKQ0ZoI?=
 =?Windows-1252?Q?k6x91pTmLBMx2f6uwlgjCUe2+UzepwGD18f1Y5IM39tMcjaxCVWkLBCE?=
 =?Windows-1252?Q?UjMf0FwbWsvvll9HMNPSi++85FTFw0PdLns5Lic+6pCziY5otG6wYjb4?=
 =?Windows-1252?Q?ioCFksMKhnFxdl54DwQEqy40ZUPQwAdzJnGtEMBCZIOLejwKOqPmv6A+?=
 =?Windows-1252?Q?srP1Z8iLXeJFJu4BsZ5A2ZNIYjKUTSDLMsO/b2NDst0ANEMjIdsCdj3d?=
 =?Windows-1252?Q?7IuxJM09x5M7mJTfBR0saq4JJIMkEsYDvG/0qLj9AjnQnyRArvYSVDVD?=
 =?Windows-1252?Q?RTN0Hd9mozJJ709Iw82qgo3nMOkbJfGpkSAAjUAzN/dk6eVVoas/6CQ7?=
 =?Windows-1252?Q?DW5UhgGRtfDxmYdbl7IaUaxbAJoj/HRpaQgCmZp6TVuH7/XkHV64WXkG?=
 =?Windows-1252?Q?Ual1syeDCpzJBwnYdbF6eg0bDX7v57nk0+g/BPi9ZTWmwcyJmuxfohfj?=
 =?Windows-1252?Q?xtPABo9CfpaPKPPpM8X7U69JodfvCOoFjixaP4jm6nARLOrLnoNkMOT8?=
 =?Windows-1252?Q?uJ786HX8N9KaoY+bSBIMkERozPv8FKNWQSoZevHDAQPPt0I1Vjc3QY3r?=
 =?Windows-1252?Q?HDTYQVrAFkz8EsA9wVCcQ9euK9htNjvF1z94PnhXMAImIJLyuM4N1NwA?=
 =?Windows-1252?Q?xy6dhxrIvRWae5UDKDJSQjrOZJZrtTltfG3cgMESsN3EEm1KkPyh7fab?=
 =?Windows-1252?Q?kHcRPuhwSV+PKcn7khtJebG+75ogczXmXTOoerAfNofYGABFV4n+lw94?=
 =?Windows-1252?Q?hNuCziG5vmI4C4LS6i6Jjgmy1/8lLvYr3xg=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4839.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb92bf1-3af9-42bc-a7b9-08d95355645a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2021 12:27:26.9874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWbzx3RQbUf7LjhSjSlf8JPdtoZ9dMt3KJHQRmwOB965c8nVa4eHIHSlJ2DqFYwVCFKyOIkkwIJBTdEUKWHFmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR05MB7105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of VMware's performance regression testing for Linux Kernel=0A=
upstream releases, we evaluated the performance of Linux kernel 5.13=0A=
against the 5.12 release. Our evaluation revealed performance=0A=
regressions in ESXi Compute workloads up to 3x and ESXi Networking=0A=
workloads up to 40%.=0A=
=0A=
After performing the bisect between kernel 5.13 and 5.12, we=0A=
identified the root cause behavior to be a =93Scheduler=94 related commit=
=0A=
from Peter Zijlstra's "8a99b6833c884fa0e7919030d93fecedc69fc625 (=0A=
sched: Move SCHED_DEBUG sysctl to debugfs)". It appears that the=0A=
issue arose due to Peter's commit changing the default value of=0A=
"sched_wakeup_granularity_ns" and more details are below.=0A=
=0A=
Impacted test case details:=0A=
=0A=
1. Compute:=0A=
- VM Config - RHEL 8.1 - 1VM with 8vCPU & 16G Memory=0A=
- Benchmark - kernel compile=0A=
- Measures time taken to compile Linux kernel source code (Linux=0A=
kernel version used - 4.9.24)=0A=
- make -j 2xVCPU - This uses all the available CPU threads to achieve=0A=
100% CPU utilization=0A=
=0A=
2. Networking:=0A=
- VM Config - RHEL 8.1 - 1VM with 8vCPU & 16G Memory and 8VM with=0A=
4vCPU & 8G Memory=0A=
- Benchmark - Netperf=0A=
- Netperf TCP_STREAM RECV small (8K socket & 256B message)(=0A=
TCP_NODELAY set) packets =96 Throughput (1VM)=0A=
- Netperf UDP_STREAM RECV (256K socket & 256B message) =96 Packet rate (=0A=
8VM)=0A=
=0A=
From our testing, overall results indicate that the above-mentioned=0A=
commit has introduced performance regressions in kernel compile=0A=
workload for Compute area and in Networking, test cases with high=0A=
packet rates were impacted.=0A=
=0A=
We noticed that Peter Zijlstra's commit has moved the Scheduler=0A=
tunables to debugfs file system. And on taking a closer look, the=0A=
values of two such tunables are different between before and after=0A=
the above-mentioned commit.=0A=
=0A=
1. Before:=0A=
sched_min_granularity_ns    - 10000000 (10ms)=0A=
sched_wakeup_granularity_ns - 15000000 (15ms)=0A=
=0A=
2. After:=0A=
sched_min_granularity_ns    - 3000000 (3ms)=0A=
sched_wakeup_granularity_ns - 4000000 (4ms)=0A=
=0A=
With further experiments, we have confirmed that the value of=0A=
"sched_wakeup_granularity_ns" is influencing these performance=0A=
regressions. And, on setting the "sched_wakeup_granularity_ns" value=0A=
back to "15000000" in Peter Zijlstra's commit, we are able to gain=0A=
back the lost performance in our Compute & Networking workloads.=0A=
=0A=
Further, we also collected guest scheduling stats (during Kernel=0A=
compile workload) and were able to notice more involuntary switches=0A=
forced by the scheduler when "sched_wakeup_granularity_ns" value is=0A=
set to "4000000".=0A=
=0A=
1. "sched_wakeup_granularity_ns =3D 4000000" (3 iterations):=0A=
nr_involuntary_switches : 3=0A=
nr_involuntary_switches : 2=0A=
nr_involuntary_switches : 2=0A=
=0A=
2. "sched_wakeup_granularity_ns =3D 15000000" (3 iterations):=0A=
nr_involuntary_switches : 0=0A=
nr_involuntary_switches : 0=0A=
nr_involuntary_switches : 0=0A=
=0A=
So, we believe decreasing the value of "sched_wakeup_granularity_ns"=0A=
is causing more preemption to the running processes and it's=0A=
impacting the CPU-bound tasks - Kernel compile & Netperf high packet=0A=
rate workloads.=0A=
=0A=
Also, since Linux 5.14-rc3 kernel was recently released, we repeated=0A=
the same experiments on 5.14-rc3 and were able to observe the same=0A=
regressions in both areas (Compute & Networking).=0A=
=0A=
We wanted to understand the reason behind the change in default=0A=
values for the above two scheduler tunables and since changing the=0A=
value of "sched_wakeup_granularity_ns" from 15ms to 4ms forces more=0A=
involuntary switches and which in-turn introduces performance=0A=
regression, can this be changed back to 15ms?=0A=
=0A=
Abdul Anshad Azeez=0A=
Performance Engineering=0A=
VMware, Inc.=0A=
