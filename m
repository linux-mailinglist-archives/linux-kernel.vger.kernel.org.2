Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CCC34116D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 01:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhCSAW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 20:22:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35470 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230381AbhCSAWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 20:22:16 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12J0F3Jj004693;
        Thu, 18 Mar 2021 17:22:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=IhjjNaz8PhGbFHgnPFJjsBWUKeESdFG0BD51YrRpLmw=;
 b=Pw/E0oWSnxBnz9KsiP1X20jIqJUgrS7+fpWzT9voAC36//iLh3xKjOFMsdwCwCdDhuCt
 XIscjLr0yM1ohih50oNzj1zI13EVIE+IhAA2hqhRaD5f+H/2mAWRtvdTGW80s6vfijiX
 enma01JI+6VA9NFTSJX3UAIG6i+7RTAAtN4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37bek0urka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Mar 2021 17:22:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 18 Mar 2021 17:22:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUwGdt58l/XAeqqMHzmeK+ic4NZYE8sW0Goe5phS6/3muGeG9cai+QcqYB4mVTsVGsfgd0Gz3SEWVKKuklFZFNRRf6oTa9U43FUQYz6H1+Cv1+IZ4FMw/NeY+VvA4KHyoC7heEWEVL0SAFOLVjTLr3k8aPLgi0hud9/+8t0t/xx219pFIivLLHlqUIoKzz2pKNzMN6oA9SNcDs1txvIinWmxNtDpvFKsY9aMUY0/aqZHfcr63lBo+WZPRrXjNTOeGwaJKSoaayVr9njXA+/GJ+L69cgTgUq2pO9srWDJt2GUkvI98d5fbEBHV/ljKdGTW7xqd7pNZePgPTDjrY3yKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhjjNaz8PhGbFHgnPFJjsBWUKeESdFG0BD51YrRpLmw=;
 b=Q7LBnFHqZRofHF3dWJpiZ+IkbxgJEHT2s2JFtmMUbgYnYXkDlwRYjLbOJouGlFw+YO4n+b4B2AhOZ0cFrEQu3NPvEXhFhlx2WOZlWbUyOQg2eWR5F9Tud/qG4bikKENzWWLJj4De72tp75bLOwnf1wZZGcL0/1cN5IDjVEHNJJSSwLxayEUfM5mAlKs/byE0f/TcupVmkondoEOzbQqMlqBpYeB0uYDl11wP6ajjsYVTS2qD0JLb8uNL8+WROvu0gTOrOZ3/l2XDk0MLQft7QdhasrYxJVnRlGZeG6CM+8zQlVHPDEtAcT/FxFaE8TK+j0graA6hQaUc3vQgYYp/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB4118.namprd15.prod.outlook.com (2603:10b6:a02:bf::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 00:22:07 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.033; Fri, 19 Mar 2021
 00:22:07 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo <arnaldo.melo@gmail.com>
CC:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
Thread-Topic: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
Thread-Index: AQHXGqn3m2pRtlCATE6KZ0qUM3kt26qHp6sAgACBEACAAPZFAIABIw8AgAAwyYCAAAOcAA==
Date:   Fri, 19 Mar 2021 00:22:07 +0000
Message-ID: <3E65B60E-B120-4E1A-BAF2-2FAEF136A4CD@fb.com>
References: <20210316211837.910506-1-songliubraving@fb.com>
 <CAM9d7ci=hfFjq3+XuBcCZ0TUJxv6AmdFk0dkHFQD3wx27aJMjA@mail.gmail.com>
 <YFH//FRPvrPswhld@kernel.org> <7D48A756-C253-48DE-B536-826314778404@fb.com>
 <YFPCul51MjrlY65P@krava> <388AF530-5176-4DB9-93C4-6C302432CE12@gmail.com>
In-Reply-To: <388AF530-5176-4DB9-93C4-6C302432CE12@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ab65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7fab5a47-b770-4ef6-7239-08d8ea6d07c2
x-ms-traffictypediagnostic: BYAPR15MB4118:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB4118F87BA989717012EDA4F5B3689@BYAPR15MB4118.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kGQCL9wRWAN6lzzA1Og6QR+k3G/tvcZCMPbhh1S2sSnwnOKW7fEnG8TRrzVPqhV8cwFc+sYL4pjnDB8IpuBe5NxnoodL/OnNb/Gu1u2H+CqNq+pDr5Pl8iRs82Fa93mvNt8VjIjnkyeLN9gq4FNbKSwFlBzA0ij3M58+kRmRcZGD/4DDltzJ4MiEMhGk3qSorfPnO/8Xf5NmVH/lneikLMFbqOsxmppGVRNUODdfieHgVqHPrKAdWFRG18ZPT8CB9VUM+q4w9NMFqKGIU1fcOjHxdQf27HDB/gFIe0C2BCL9+ukpEIS9hLV+zogimBPfTLgfCYGKlviJGsCTyKrqRQlsCWbmen1joFP7a5exmd8uMQfpKv+sp0tPHMs8Asl5fefd57iXQGBcPMeXK6RED0dRjs1a5Iz4e3OzQanHeb7F7d4OwFChKooxqszdNgilXCXuVY17B8ogT7unTqvdXSNnc79V0cpPsG2EaQS1Mh9//OHMlkEZoKCDBE8GQygK5YjeqZQwYjB2hVYi3aDhhTSP4a/xwRSFp6MOjQ9/LE/hScItR5+T9qewnuhyTeXTD+Km1txC2bFNftCLZJq1xFRclMJkrNkg3VuAB/QZ5xfKuwsawgowScQDlQ6lfu1l+KfCCLM6aYKe6VRfsArlhqB+8fs4oUUVQovN4dI99i/CQToxGopvp6DadeYUfzP/FZE4xXLscayb9UuNj9S0CA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(39860400002)(396003)(4326008)(83380400001)(2616005)(6486002)(71200400001)(6916009)(66476007)(2906002)(186003)(33656002)(5660300002)(36756003)(6506007)(8676002)(6512007)(66946007)(53546011)(64756008)(66446008)(76116006)(38100700001)(8936002)(86362001)(66556008)(478600001)(316002)(54906003)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mWgZcVpPVkSbRVzNTckCyXhaH/natLqqkl158kiZ/PyPanDwQDOoTGZjKMUb?=
 =?us-ascii?Q?LO7ILAv/cTwXc27L8FmEURD6i8gb4vllezTHbhjYLgBWcP+pt25y+RAg1qFd?=
 =?us-ascii?Q?x9+O3RSeKvHW5JJJHMpXvv+bbcReQtYp+0xuwLSf62KpJvffpjWuzP/roX1u?=
 =?us-ascii?Q?wNiC3/5b6YeEK3oq0qzxPr4KWzWj5HTKtjIhqYs4wqaEVWGxhZjUyKAGJWEK?=
 =?us-ascii?Q?AWt6nh8TVGmN+9b3qNeVdJRyLZdgfcnWt/k1Hdy9/mUIUnwK4VKeV/dHitL3?=
 =?us-ascii?Q?/VTjbKnfeF4nVclkNyxcff20le/5Vo88OjPrMPqUS03BaKEwRyS19v1mmU8r?=
 =?us-ascii?Q?Nmt0ldCm4pMD20M2zIWL920YW9YxWIkoWHxh6ilPyPBdiq8+06xkCkQoUn8g?=
 =?us-ascii?Q?YEEEwMcAkvBmF83xHUpqRLsPGZxYKUqCqMdUhK9Htld0139G+dtCamNwRNjl?=
 =?us-ascii?Q?gHJxm4sxZpTjHgNFbqTbg74PqRv2tcxdYa0icEaWAqPr/9YPwxaDCBCZySn8?=
 =?us-ascii?Q?+fXPdDyL+VqU5BYaTny3pUziQStCQgw+XqFDZP6xBnLXUunYKz5cO5uc74VN?=
 =?us-ascii?Q?2KCDlYVXWf1u6twpt0HR2VVst5rt04k8dkooV55sK9/VOvlwu0ID7WDrY/D/?=
 =?us-ascii?Q?VNpVUtxZODrvrGMhtxvdQBOMQ6c7l6J44T6nUbFiLKSp12dzBwUESHs51Aai?=
 =?us-ascii?Q?eGbwlVu9XbNhgtXrPcsudvHkSJTLN6QO1v7H0zHlWGk9MsHUof1I1170VWWA?=
 =?us-ascii?Q?QU24gV1VfzT7odEADMh5XDXBva65cFlXmv2E9lnaYHOvPeqfF49B50Ty61UZ?=
 =?us-ascii?Q?Z+w5lEURygCducZYeCH38SDzG2ey2ayUykQ75qi2np4rsGup/i06qjcnZK10?=
 =?us-ascii?Q?1qpg9lvSnxN/VqtJ3Io5DAxdLTeJC/LRgSIj79Su69f96J4rijqaIpCaGM1d?=
 =?us-ascii?Q?O2r2tp4avu51Xp+DUwLnioZ+GBMNoeEG6b/BYBPjl0DDBzddOTKiTbvETYa+?=
 =?us-ascii?Q?FQxfFB6Ok92eDWGAcbYQ1PGBCaHJlOBdyHxkVGgFME8omig4thFfWubiHU/Z?=
 =?us-ascii?Q?wQn8e/O/SENUzQZmK8fO7SwdAkyJWM4Jg8NcZQS0ERIvXxScv0lEFGt7+cbA?=
 =?us-ascii?Q?oVWLBZXoGjv52exe3NIRfnEwEJ0HPFjjpKmrGV07JMhQRoqsKusIrQ8R9iIF?=
 =?us-ascii?Q?qron0A6oOWSDWz4Z+46wsDRPXpzjM8hJYELF5nYpT4yHCKMh0wzBroubfxI/?=
 =?us-ascii?Q?YQihBipYqDH38ZrCglaniu5CvGAzZkSdDzxvn44ow4OJ1/Ak/nryIcesZvlF?=
 =?us-ascii?Q?bV7o39JnXT0HelM6npC0yEZUB5SHyovav7YJEJf4t8AB3J0ctTcJx1PYGEyn?=
 =?us-ascii?Q?9WPeDrI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB6D040CD9CDF643AB2D4B477C0B9E6D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fab5a47-b770-4ef6-7239-08d8ea6d07c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 00:22:07.3984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D8F1wGb6qnWz8VKs/apc2q38ICMXighsgcNI3eBGYDb+sYRqm047JMou1l32rtqhyq7CZPvgHA7LnGQrAJvaCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4118
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_19:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 18, 2021, at 5:09 PM, Arnaldo <arnaldo.melo@gmail.com> wrote:
>=20
>=20
>=20
> On March 18, 2021 6:14:34 PM GMT-03:00, Jiri Olsa <jolsa@redhat.com> wrot=
e:
>> On Thu, Mar 18, 2021 at 03:52:51AM +0000, Song Liu wrote:
>>>=20
>>>=20
>>>> On Mar 17, 2021, at 6:11 AM, Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>>>>=20
>>>> Em Wed, Mar 17, 2021 at 02:29:28PM +0900, Namhyung Kim escreveu:
>>>>> Hi Song,
>>>>>=20
>>>>> On Wed, Mar 17, 2021 at 6:18 AM Song Liu <songliubraving@fb.com>
>> wrote:
>>>>>>=20
>>>>>> perf uses performance monitoring counters (PMCs) to monitor
>> system
>>>>>> performance. The PMCs are limited hardware resources. For
>> example,
>>>>>> Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
>>>>>>=20
>>>>>> Modern data center systems use these PMCs in many different ways:
>>>>>> system level monitoring, (maybe nested) container level
>> monitoring, per
>>>>>> process monitoring, profiling (in sample mode), etc. In some
>> cases,
>>>>>> there are more active perf_events than available hardware PMCs.
>> To allow
>>>>>> all perf_events to have a chance to run, it is necessary to do
>> expensive
>>>>>> time multiplexing of events.
>>>>>>=20
>>>>>> On the other hand, many monitoring tools count the common metrics
>> (cycles,
>>>>>> instructions). It is a waste to have multiple tools create
>> multiple
>>>>>> perf_events of "cycles" and occupy multiple PMCs.
>>>>>=20
>>>>> Right, it'd be really helpful when the PMCs are frequently or
>> mostly shared.
>>>>> But it'd also increase the overhead for uncontended cases as BPF
>> programs
>>>>> need to run on every context switch.  Depending on the workload,
>> it may
>>>>> cause a non-negligible performance impact.  So users should be
>> aware of it.
>>>>=20
>>>> Would be interesting to, humm, measure both cases to have a firm
>> number
>>>> of the impact, how many instructions are added when sharing using
>>>> --bpf-counters?
>>>>=20
>>>> I.e. compare the "expensive time multiplexing of events" with its
>>>> avoidance by using --bpf-counters.
>>>>=20
>>>> Song, have you perfmormed such measurements?
>>>=20
>>> I have got some measurements with perf-bench-sched-messaging:
>>>=20
>>> The system: x86_64 with 23 cores (46 HT)
>>>=20
>>> The perf-stat command:
>>> perf stat -e
>> cycles,cycles,instructions,instructions,ref-cycles,ref-cycles <target,
>> etc.>
>>>=20
>>> The benchmark command and output:
>>> ./perf bench sched messaging -g 40 -l 50000 -t
>>> # Running 'sched/messaging' benchmark:
>>> # 20 sender and receiver threads per group
>>> # 40 groups =3D=3D 1600 threads run
>>>     Total time: 10X.XXX [sec]
>>>=20
>>>=20
>>> I use the "Total time" as measurement, so smaller number is better.=20
>>>=20
>>> For each condition, I run the command 5 times, and took the median of
>>=20
>>> "Total time".=20
>>>=20
>>> Baseline (no perf-stat)			104.873 [sec]
>>> # global
>>> perf stat -a				107.887 [sec]
>>> perf stat -a --bpf-counters		106.071 [sec]
>>> # per task
>>> perf stat 				106.314 [sec]
>>> perf stat --bpf-counters 		105.965 [sec]
>>> # per cpu
>>> perf stat -C 1,3,5 			107.063 [sec]
>>> perf stat -C 1,3,5 --bpf-counters 	106.406 [sec]
>>=20
>> I can't see why it's actualy faster than normal perf ;-)
>> would be worth to find out
>=20
> Isn't this all about contended cases?

Yeah, the normal perf is doing time multiplexing; while --bpf-counters=20
doesn't need it.=20

Thanks,
Song

