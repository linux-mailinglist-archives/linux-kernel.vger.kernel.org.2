Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469BA339225
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhCLPpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:45:55 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46342 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232896AbhCLPpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:45:23 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12CFaS3T030479;
        Fri, 12 Mar 2021 07:45:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=SoAd13xKzk+dfYFHB2vZuiZiMTDl3K4oU+sIOUzES24=;
 b=aXktjx7e1m4jxmsrBFX6oPugrRNYN6DkBniI95IBgppHr0j2zl8db3FKwXDiPWRhDsNW
 fRze9IwWF03GWi10rNwkbBS7tfaOBf+Ev4IE3Guuzng3rQ5IyLfXXu9W7lO+Uw+znbIr
 7t20rpKD6ftHwknQIMVg6v8HbssuP19kzPg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 37852dhpfj-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 12 Mar 2021 07:45:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 12 Mar 2021 07:45:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0p343iBRhoATBzBVeaKy4OBLVtoPILS4nGMbprFPBlM4K40mw7oK0Sv3LE7HUEjwC+7+pfBclzGFg+UWdRKGQlbB1IsBDEGiSuahYsSWiXHXA4jTNRt7XjaNdw4u3D9GUIADO50KeiSCOcth3RPFY0BpVmd8TcxOhrovPvVY0SulDuVNKUwnbW7ivvW0cufkpSvjL9YPcLghluLStsgCYLUzR7jIJsi+OYSKRwVzkv9d+5LwMOswb4xCG8TlP6pH/sl6VjQ/MX3rwbyzOjjUybGDbUVjUFI5mduLLNjA1tzuNaXARQJ3Pr1YHTafRgY9fkGGtUeMRLzItrSjgTB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoAd13xKzk+dfYFHB2vZuiZiMTDl3K4oU+sIOUzES24=;
 b=j0gzZ51g09c4hxp7JY1WFMmSOPNUrr/KUQgFUlfaUyL0PPQxHgeHc5iG974FJSyfaNi+MvFA4VKpRhe7PeDJm9oQhjSNDSYPPRduWzlw+2C7xCQPosJ4RFsfICQLrv2VUirqkHhuU6K3oxz1CQbHgezwNrsx1h3rHPg8KQIsTufKcUyaQVlMLP72dnYkQa3v07DnIvM6Pu6raagYnWfhJe5No2EsJeBP9nj3CA9xsqimBc21mCrm0S6uqMWMcitPvDaelqr5B4NKmTjsOZYhBhX1f7rlK6DNhUlwYDjlYrxzWTFh/IScfydGlAKoEmCMOUB6uBAPnhhl3Gj2mpx9cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB4117.namprd15.prod.outlook.com (2603:10b6:a02:c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Fri, 12 Mar
 2021 15:45:14 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 15:45:14 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Thread-Topic: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Thread-Index: AQHXFuPifzAWbJ/c0EGfxtA8c/wTpKqAREAAgAA7WYA=
Date:   Fri, 12 Mar 2021 15:45:13 +0000
Message-ID: <45BCAC33-1626-42D1-A170-92DC8D7BAAF8@fb.com>
References: <20210312020257.197137-1-songliubraving@fb.com>
 <YEtawFnompBDKpK0@krava>
In-Reply-To: <YEtawFnompBDKpK0@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:17f0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c605ef4-8561-456a-7e13-08d8e56dd3c7
x-ms-traffictypediagnostic: BYAPR15MB4117:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB4117120955A4DBBAEDFC5E66B36F9@BYAPR15MB4117.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HK4dPMTzOIufm4uzPKR33Ng1Gfl3tlMYX2UTMpCbXOShtW1iPB3yUDvER9qbk0Qqix60yvGi5XEtz0vk5PNXwIW4SjKZyqXL9hKJqo1KhX+HJkgI9g6PK4wGw6E25Y4a47qnswYvK9ovvPzSIG7q0tuau5+Owpspb5xh1xmKsqXa7Ete4ACUgmLcinAEFrxZNcu3oNKSP2xF8ka7zWn7JUDhHOYrUNLBJis8gt/oxK1LGgjfX6gLxGFgnGjZo4n5ptjCr/v/YcVFc12LWggEyb7JwHmycU2al4IDZCrnrfQQ1+WNhREaS9nL4JTquBJFLpHQDQth5e7ICQqSJG9HNx/mOv9PezZ+oLPrCCces0MpQ65HWBsyejWtRiDnwt+Cj60i5faZaBCLFrlqKDcYHM4IawlPJT9Cx0jVpMvpsNQ1yUOmL/Jv0ubyY7S0hacqW0GeqdB9mKNQeDAWWKxHacq+8i0Qv2FpSeQVrBMalEsm7fYIs4BfhetThTUeC/3hKEEoknsMwlVpFPrHlR2YDR30zH0SHNLXllEBilpNr25Hj52iBEr1iq/h/XBHTEd0DRGwu1fEoCdwuJ1aMdxGFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39860400002)(376002)(346002)(8936002)(6486002)(86362001)(4326008)(54906003)(36756003)(6506007)(66476007)(83380400001)(6916009)(186003)(316002)(6512007)(53546011)(76116006)(5660300002)(8676002)(478600001)(2906002)(71200400001)(64756008)(66556008)(91956017)(66446008)(66946007)(2616005)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bsKorJ2WlF30p2bMXWVR0gUnAKID1/VVSytUDW2kmLGpR2zeRiNIPCtBthwf?=
 =?us-ascii?Q?vyQ1y9/dZJyy7sywPDa720he+6DPz8qpOdZpvTmtG7wni2fwqh1XITtNPxaq?=
 =?us-ascii?Q?4B1W6j4AH+Y16eyrzDF0TaLvu9x6owuadti48khvT8ALl+UQYwuN4oEhd9LV?=
 =?us-ascii?Q?7byYXbdnXQtPm+E7G69uwbkvMctyRXRzX7vyo14zvSjXB3rmSMZ/mpL/VMvb?=
 =?us-ascii?Q?Q2pcIUboPeBTqC8a55d9SaEd6Gt/8wTUVYIXnCiS5/CSvaBPYls8Vd0DDe27?=
 =?us-ascii?Q?r8Zyemr+j9J3f1AAw/YC+2BAqr9HmzzkAql2K/ynCSx4ketCkpQt1LHpR1cf?=
 =?us-ascii?Q?UTcISREfKGy0PEeK2El/4W+wPKrSWLzpsQ5UhZkfhoq62Y33sSidlx6SO3r9?=
 =?us-ascii?Q?oDhrNbu5pOyXZTmD/HRO1cNkpm4hMb3crRmH3PFy6E9wNZ27+2dgMeT2nEox?=
 =?us-ascii?Q?2R10YmAUvsCOXQdtF4PArQwm60TxOXfhsQgaf2o3G6VevLGJUrNAQ2uJPNSO?=
 =?us-ascii?Q?fOQ1FAuj7d+dZ6WTXoo6WbxHBrKtShDqtvS7QrHJ0HpM79N2g2ICJMM8lofB?=
 =?us-ascii?Q?bcPk8LgsFlBb3ZuuMpdMsK+7u/VZtStgUr17I2HM0f9vXm4tIPpibyR2SfpG?=
 =?us-ascii?Q?/n1BcjGCdTDQ6UmWmcarqxFh9R96AoZZtALAOQikHvSOJUKOY6nkTyESTGlH?=
 =?us-ascii?Q?ZGPbMkOKMtWqXbzZD6QjFdznYGbGPPuxPJqY5Z1FQ4wS/HTDcpaLnyshUXHU?=
 =?us-ascii?Q?ccEmvxcLhhK8Lkpb7Z89kNNtuWc0jO8EayfOeNEpU0apo1f8ZFlHqjBCCslL?=
 =?us-ascii?Q?jtAhFZQ6VEMqEMLaK/UZZJEun1vcF5j9Y9KjrUt3B2h2JcQOzZc9/QECGCv8?=
 =?us-ascii?Q?8AfKsvU8SXDAzZ4s7VwDY5uaOd0kqDvThmMgQ7MoNu1ly0GmqixqElM+xpqj?=
 =?us-ascii?Q?+gLWk+i5b2gMmzxUEpT9RqG3qjyzq46/cWtm41+qkEuGk/0UHBTVDSFO1X6R?=
 =?us-ascii?Q?zYW5vEUJ/baut28cxOZvTscJTPK7VoqZwRqvZcG+GQxvH6zofT1WWC3FyqKy?=
 =?us-ascii?Q?d6hXex72PRwe11z+gqmyeqj7W6C3ZfoMN5LL1wInR7tH32FvOOzD1sMi3Tws?=
 =?us-ascii?Q?/BW5vUnC8Bnz1aCjPHTqmxorwgOFBIG1ODHPnP06jQLP6LEZDaW9C+N5b9ne?=
 =?us-ascii?Q?HqRr8K9U7QKkNbmjJaEAoSm5ucOehUfFZSQJcukw8wdta6pNK2xDFvdvsRMU?=
 =?us-ascii?Q?H7Fahp/irxZFDX+YXfdmSE3Ug+w7uGcM/KpSOKgtnCSJ9Z9flJqJqmLDVqT+?=
 =?us-ascii?Q?z1tnsGqAS+tZUfL88S/m3w4+ewxw5EDLE61PLyIZaM4Zmv6gRwOBQPGD3P0a?=
 =?us-ascii?Q?GNllhKE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CC9E0A1210AD954288217F54F0A04B5B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c605ef4-8561-456a-7e13-08d8e56dd3c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 15:45:13.8848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +twGgcAfJ1SUua69+NLqpwtx2wKlcrO9eQ6KrodixDOSYG14SylqgAMP97L+o769gGvBfcGYTGJDTyARiqQGLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4117
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-12_03:2021-03-10,2021-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103120112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 12, 2021, at 4:12 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Thu, Mar 11, 2021 at 06:02:57PM -0800, Song Liu wrote:
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
>>=20
>> bperf is off by default. To enable it, pass --use-bpf option to perf-sta=
t.
>> bperf uses a BPF hashmap to share information about BPF programs and map=
s
>> used by bperf. This map is pinned to bpffs. The default address is
>> /sys/fs/bpf/bperf_attr_map. The user could change the address with optio=
n
>> --attr-map.
>=20
> nice, I recall the presentation about that and was wondering
> when this will come up ;-)

The progress is slower than I expected. But I finished some dependencies of=
=20
this in the last year:=20

  1. BPF_PROG_TEST_RUN for raw_tp event;
  2. perf-stat -b, which introduced skeleton and bpf_counter;
  3. BPF task local storage, I didn't use it in this version, but it could,
     help optimize bperf in the future.=20

>=20
>>=20
>> ---
>> Known limitations:
>> 1. Do not support per cgroup events;
>> 2. Do not support monitoring of BPF program (perf-stat -b);
>> 3. Do not support event groups.
>>=20
>> The following commands have been tested:
>>=20
>>   perf stat --use-bpf -e cycles -a
>>   perf stat --use-bpf -e cycles -C 1,3,4
>>   perf stat --use-bpf -e cycles -p 123
>>   perf stat --use-bpf -e cycles -t 100,101
>=20
> I assume the output is same as standard perf?

Yes, the output is identical to that without --use-bpf option.=20

Thanks,
Song

