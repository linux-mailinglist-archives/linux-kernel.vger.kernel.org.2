Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECF9339188
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhCLPjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:39:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8512 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232037AbhCLPit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:38:49 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12CFVtZM007379;
        Fri, 12 Mar 2021 07:38:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=n2Z8A6oML3M4G40SWYUCXX49nccUyLFiV5qxABM9PYM=;
 b=aGOQ+zq/O20KYZ8o4e+ePgvBvrl2RgUzjHpZZKlPsjsK2MSPQlHvWAqL4o3Fak3jdiR2
 xzv+QHMi6+k7IvUDcOMx9q0eS+IHjthe/zUSDjEen88GLyBgrKYiFJBZwFbQaBp1EMCf
 HrSYe2Toa/AUYIiMRXQl2vXuRaNXQteiSPs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 377uht442h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 12 Mar 2021 07:38:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 12 Mar 2021 07:38:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZuW+tuhBO0mhkqMdiQx7Vxh+VH7QCEZ4LUF2EWiwod6xi99dT+J03lGBQfrKQleBUN2aasP0zn3XpwO/K47i62kvnf47w+ygxBTHr0fvJvlrVFD4JkDeC3gNVzeTn4JWHnbqrzi2k9FdMm/uCeBW2WnIBsndVDlt4/8juRTuujRvYjT+fWJevm/0/1S31naqbmkrN1K3q929G6tGl/bEdU3nTQnU4hFiXT3QCfXskNQ4Kwq9332RTJH/j9XXHG5Y8mFKjVxDEDJWXAo4LQvgCZM4f21RHS6Ga/dfTntEvPBbTJXTGwlLchg0VQ8PlnV/MgqO444Y7Pbh58NsXDNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2Z8A6oML3M4G40SWYUCXX49nccUyLFiV5qxABM9PYM=;
 b=AXhEjgR2G9TPpxGlpGe+L+QdbdYav5jFeTgCCKgtBMV9KPNiV5A0xPkSBV/iyYMIeN4efIOiuxbruPU9fcOmgbTNi7reztM643D/po0QL2gLHGML924FYiy5d6QxP4VQQUHT/fbJBZ0GWab1Ds1Yg6Jv/oa7nksee7Men3MYrxMp/TXx/uqYNVqdosyI3+SPSt9NOUEkRwdRYT4iKDqtJqX/9QQUIzceV0YlVI1x9ph3aU4WnXMEpP7gk+jhUrqRnSKWALD73MZabtANq7Ykl4AvMNu7dNZ3JgU6F0/8aS4WkWL+A53qJ7d9dIRG+65ph55vInVaEAYMm5IfXO2rCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY5PR15MB3716.namprd15.prod.outlook.com (2603:10b6:a03:1b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.29; Fri, 12 Mar
 2021 15:38:44 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 15:38:44 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Thread-Topic: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Thread-Index: AQHXFuPifzAWbJ/c0EGfxtA8c/wTpKqAB7cAgAB2EYA=
Date:   Fri, 12 Mar 2021 15:38:43 +0000
Message-ID: <4B3CF1B3-5EED-4882-BC99-AD676D4E3429@fb.com>
References: <20210312020257.197137-1-songliubraving@fb.com>
 <CAM9d7che4Ott6F6SNj8aaXea+wgzDE8pVntkpGr1TCbnfWNXkw@mail.gmail.com>
In-Reply-To: <CAM9d7che4Ott6F6SNj8aaXea+wgzDE8pVntkpGr1TCbnfWNXkw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:17f0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1fb98fe-2fda-4371-7916-08d8e56ceb51
x-ms-traffictypediagnostic: BY5PR15MB3716:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB37160B7355CC8BF3AC762F0DB36F9@BY5PR15MB3716.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 48HG8nZ8VkJM3cJqC1DnlNYbBGctacAs6m2T7M1Ql6XqEoMmBcukFU41oaqM1FYg63I+Ygo37iNxYbGLC3luZpnukfbu9Env+Q1D3XjnLJ8440trK+gj6xpX0QXL5dpDahYekzWklcUwGc3O430VyQNEWy1V26uxhngGdLwyHxQ17Qwmzh0Oz/M/dXkIgbhbnL/Ixyl5DVhPr41k/l6XTecSGL+qyITm8kbqvYOHpdHiYSMgje4oUVjzfm7Qgo0YyPBu/uzOFkGyAy4H09qMYDPkm7ucq14yOU11Yv68oSuHkwwKrhi9EIG2naFTBUuDZdQVKaa6pLySUI4N9CK083ijfZTGbxWZityRILlTU8PVUWYmqUsOMPn1Drrv4asct7feDsLIDY/u/tijAytMVXZ8RKmOFTFTrqr8v9hktcZ3XFZi1lsnPEZWvqx7CSoRUMlLgCjTchdirKUbL+/ptHUBQJTrrMj5Ar9qt62fE8sXHtLT5BwDTcz17BkWt05SUgp+vWj4C4P0nvNTAtACNvlOZvxiQNTX+GXe4x9Dwnt06MbYE37OxW6i6Nul55f4L7LQeCHIK6spwFFl2iNVoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39860400002)(64756008)(478600001)(5660300002)(316002)(4326008)(66476007)(2906002)(186003)(66446008)(6512007)(36756003)(8936002)(66946007)(33656002)(76116006)(6506007)(71200400001)(66556008)(86362001)(8676002)(83380400001)(6486002)(53546011)(6916009)(54906003)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0NyeW1dPl4Cq7Z5/Y2EsDx9uIVqCFit47TiPTsnF2VMAwpb3QbK2JKEzsv2C?=
 =?us-ascii?Q?1jYuQp8TmcFo5wXbM1y4s/515PUndBWXKpHrSDeaqMWVEyeUZ+nLkuVtcbMc?=
 =?us-ascii?Q?PYI+eyhhIF6CD5psGL4dEtcBNHFhFSL71UACzW4neEHhLEc8i7MEzJd7V9CT?=
 =?us-ascii?Q?740qmkgo2Nx23OjC/h/7iRtQqX1nctekpbx0P3gkPyD2LTWuV05/xxeFU0wt?=
 =?us-ascii?Q?f1pXZHJAwIunC88W5NOVkoaK3ocTqV+yWdx3szl6Za0LKl8zHwmNMeDUmdS3?=
 =?us-ascii?Q?nMGm9Wr2DhyEC7QtF3/p4I6FsmznRvfVXJ0MWFPybBS5bMNlziDGbBT8dtaW?=
 =?us-ascii?Q?XcmN1lrciINVgvsaZEFn8sIBHeIeUl0/AeohyDqpYrivvddzFk8xsW24QTyA?=
 =?us-ascii?Q?QTjf0bXUbrNZAb3LFH59D/+Y/MFq7bgJHu+QRKZO2Pl7xhl7WS71ARJYZNpD?=
 =?us-ascii?Q?hkRCpYFgNFbZoUndDbuH6lfztFsZVoNsqdDT0KycVpJdHhokZEvmeqb+xwWv?=
 =?us-ascii?Q?xciIUuQeyLfqoqAiNZ87+h6NiuaM5nyCM2HWRsGYYqnqQuV7osOu2TWl6G1y?=
 =?us-ascii?Q?qGmZDVzf/hDG1HJUlQ8UOHflGHn7pTxYrimZGl577Dmnpoi+RIWg8LukRRwj?=
 =?us-ascii?Q?Z7Nnt20O2tiFKYbY9bcmwVQhNUvRaGnsRShEKln1Py5ll/2HWS+1eXy6Si3x?=
 =?us-ascii?Q?5/xTY4LS/8wQGWYfU3+zMm8PgLJLuayv+a+UUfHiStcRQH/4pkD0ChCEdai3?=
 =?us-ascii?Q?9kj2Rt/Xuk4Z17CI5TRknYQzi+GW3W8azfP5ae26mT4YVUqNWAo/aqefDbOx?=
 =?us-ascii?Q?Wuwf2QDljReuPib/AJDhAUJhpJ/PGmXIrPZko/09MMVUbRsqVCDyQY4/69mj?=
 =?us-ascii?Q?6WydnglKiG7UzkdxhEKlfJCIiCT9i6xOl9dDMTdepMNlill1xT37Rrls6KP/?=
 =?us-ascii?Q?gG7UCXvOIPvADmmAEKHtL2olQQYdUcbbAKePQmNMWzd4QIdr4E7CQFJTZ3Nt?=
 =?us-ascii?Q?PmubXafGiBFsEVRHFju88vmZSTch4ZLhN64ZPfm7jrWHXUxnHkUYwqAfekf8?=
 =?us-ascii?Q?Mi6OPXYAYH3u7ZaLkumOYqWDjtMP4JHdZ1PzqnGSwpPlEPQYO3I2cFZToQWr?=
 =?us-ascii?Q?SoglNl4yDx32j5Ix9qVoQt/PlGh+mv1/W2t1AFp5LZlcBJwOoPOU+Y5uzgER?=
 =?us-ascii?Q?xT/HRchxs6VW+KsxJY4wtAh1YnCsi+ql4HBvjICVrjrrLdNKarpMEaeOsOyR?=
 =?us-ascii?Q?XqEQSf+/ace6YFrZ9CGST2PKE4I/O31xZ3InseB9oTOOwtFBcpGHJQYKZmoI?=
 =?us-ascii?Q?gf5cYZGspUe4o/RdlDUpANmsS2yBOiOsfFwj13dQ9EancOYlVbxbokeuXFjR?=
 =?us-ascii?Q?LZvU+ks=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <89370B765D468F4883E89DF1704CDCCA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fb98fe-2fda-4371-7916-08d8e56ceb51
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 15:38:43.9299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRKrfmqT1Ec8ptsLGXg1y5Mw9tNoaiUGDhDlHvW41mKToYJYr/iyY1Hb5OiIf4IpoPKdDuUaNd8ulI++uJV+4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3716
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-12_06:2021-03-10,2021-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103120112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 12, 2021, at 12:36 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> Hi,
>=20
> On Fri, Mar 12, 2021 at 11:03 AM Song Liu <songliubraving@fb.com> wrote:
>>=20
>> perf uses performance monitoring counters (PMCs) to monitor system
>> performance. The PMCs are limited hardware resources. For example,
>> Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
>>=20
>> Modern data center systems use these PMCs in many different ways:
>> system level monitoring, (maybe nested) container level monitoring, per
>> process monitoring, profiling (in sample mode), etc. In some cases,
>> there are more active perf_events than available hardware PMCs. To allow
>> all perf_events to have a chance to run, it is necessary to do expensive
>> time multiplexing of events.
>>=20
>> On the other hand, many monitoring tools count the common metrics (cycle=
s,
>> instructions). It is a waste to have multiple tools create multiple
>> perf_events of "cycles" and occupy multiple PMCs.
>>=20
>> bperf tries to reduce such wastes by allowing multiple perf_events of
>> "cycles" or "instructions" (at different scopes) to share PMUs. Instead
>> of having each perf-stat session to read its own perf_events, bperf uses
>> BPF programs to read the perf_events and aggregate readings to BPF maps.
>> Then, the perf-stat session(s) reads the values from these BPF maps.
>>=20
>> Please refer to the comment before the definition of bperf_ops for the
>> description of bperf architecture.
>=20
> Interesting!  Actually I thought about something similar before,
> but my BPF knowledge is outdated.  So I need to catch up but
> failed to have some time for it so far. ;-)
>=20
>>=20
>> bperf is off by default. To enable it, pass --use-bpf option to perf-sta=
t.
>> bperf uses a BPF hashmap to share information about BPF programs and map=
s
>> used by bperf. This map is pinned to bpffs. The default address is
>> /sys/fs/bpf/bperf_attr_map. The user could change the address with optio=
n
>> --attr-map.
>>=20
>> ---
>> Known limitations:
>> 1. Do not support per cgroup events;
>> 2. Do not support monitoring of BPF program (perf-stat -b);
>> 3. Do not support event groups.
>=20
> In my case, per cgroup event counting is very important.
> And I'd like to do that with lots of cpus and cgroups.

We can easily extend this approach to support cgroups events. I didn't=20
implement it to keep the first version simple.=20

> So I'm working on an in-kernel solution (without BPF),
> I hope to share it soon.

This is interesting! I cannot wait to see how it looks like. I spent
quite some time try to enable in kernel sharing (not just cgroup
events), but finally decided to try BPF approach.=20

>=20
> And for event groups, it seems the current implementation
> cannot handle more than one event (not even in a group).
> That could be a serious limitation..

It supports multiple events. Multiple events are independent, i.e.,
"cycles" and "instructions" would use two independent leader programs.

>=20
>>=20
>> The following commands have been tested:
>>=20
>>   perf stat --use-bpf -e cycles -a
>>   perf stat --use-bpf -e cycles -C 1,3,4
>>   perf stat --use-bpf -e cycles -p 123
>>   perf stat --use-bpf -e cycles -t 100,101
>=20
> Hmm... so it loads both leader and follower programs if needed, right?
> Does it support multiple followers with different targets at the same tim=
e?

Yes, the whole idea is to have one leader program and multiple follower
programs. If we only run one of these commands at a time, it will load=20
one leader and one follower. If we run multiple of them in parallel,=20
they will share the same leader program and load multiple follower=20
programs.=20

I actually tested more than the commands above. The list actually means
we support -a, -C -p, and -t.=20

Currently, this works for multiple events, and different parallel=20
perf-stat. The two commands below will work well in parallel:
 =20
  perf stat --use-bpf -e ref-cycles,instructions -a
  perf stat --use-bpf -e ref-cycles,cycles -C 1,3,5

Note the use of ref-cycles, which can only use one counter on Intel CPUs.
With this approach, the above two commands will not do time multiplexing
on ref-cycles.=20

Thanks,
Song
