Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39F03AAC70
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 08:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFQGf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 02:35:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29288 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229683AbhFQGfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 02:35:54 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15H6UnVK013453;
        Wed, 16 Jun 2021 23:33:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=c8udMXDR+Y3pZror7TLxcBXA0KNeGhFVCerpugnwZBk=;
 b=Uulm2Qn8CeYaZmOm0lpK/rdXPzwLuH8HojOwyYZu4s4gaxSpZ7dyYnab3K/a8SL21iwo
 7CHQ3DPiG13Tleyk3C9memp9SKfkdYwsLZB7HF0XSy628PRLNCeHRtiDsYQMHTW6tmd5
 Eev929u6sT6/IBseqorEgm0I6d+xVskHPu0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 397tpb9sn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Jun 2021 23:33:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 23:33:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBsRVmK7pEXZuLeWbCW4BOYM9r8FTUYIGncYt6lmmwMt9wQRszA4JWq9L+P0uQsb0/xI9mpsnv8JztTrZM45HBZwLXV+7pjhluIj81d4Vt7HevFFCm7gp1Ij9grpfLyRkiXw+fjt4HZCTSCgl+azt7TI54K2Jl50SJK2nodcigYsGVdTVuxWEk95o28tpbXV6zSnBgqQ3badomLNhQ28XTBN516nKM11miVZjkZoatQFAIxfUm4ECK5fNrh3dl6S758Ar/f4tNTMhvNHvSmgOmZUFTm03ZX6uSFuj8HvCLWVEJ8DXCsUv3WHE7F9ns0zkFrU6sBNaxusIVwPSQbC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8udMXDR+Y3pZror7TLxcBXA0KNeGhFVCerpugnwZBk=;
 b=LfYDzTNZDoM1vORgQTH5so7ev3fOFDfTaN+jwT4mnM3PgZlOBgYm6WuLLqhWUBnFAgWtMtLrPX0gOkRXHWFXD6SF8R1jgAuopHqsTNa4x72ZznipLPeWJhyVTozbOFE3Wof8R8a96KgXA0gycFuxVr7qqwSMSEx2HLYB+NJvDENpT9ts8jlimGAuXxmEgqzMimn88N/w+GrrI9yW9IzMNq2TYnYuduB4PUqzk/G38MNDXBPD/bZ/vDunoBF2CZxoPrTjhBqjmNgddknW175CjOC+oL/3oR/eA+FtOzuVC/cpUcl3a/WLCmcB3jF1KciUZrGOxJhEeb8SfRSr0tr+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2453.namprd15.prod.outlook.com (2603:10b6:a02:8d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 06:33:28 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::38d3:cc71:bca8:dd2a]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::38d3:cc71:bca8:dd2a%5]) with mapi id 15.20.4173.038; Thu, 17 Jun 2021
 06:33:28 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCHSET v2 0/3] perf stat: Enable BPF counters with
 --for-each-cgroup
Thread-Topic: [PATCHSET v2 0/3] perf stat: Enable BPF counters with
 --for-each-cgroup
Thread-Index: AQHXYYQ5rdK69Laxg0uZJ/OfrIDtY6sWwXEAgAAWQwCAAGQpAIAAhnaA
Date:   Thu, 17 Jun 2021 06:33:28 +0000
Message-ID: <55A8ECB0-0299-4A07-B285-E9F0D611E822@fb.com>
References: <20210615011724.672612-1-namhyung@kernel.org>
 <YMoVOp4+TIUViBb7@hirez.programming.kicks-ass.net>
 <CAM9d7cj2UhQsd2vx8_C8C_CEW2QQbzs741jCn7f7g-e0i9OiOg@mail.gmail.com>
 <20210616223212.GE4272@worktop.programming.kicks-ass.net>
In-Reply-To: <20210616223212.GE4272@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:bd6b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed6cec18-10f0-478e-9952-08d93159d170
x-ms-traffictypediagnostic: BYAPR15MB2453:
x-microsoft-antispam-prvs: <BYAPR15MB24536B63CAE3611B4743A94FB30E9@BYAPR15MB2453.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ws3H2x6Y/KPjcn7WPJ3gehm31xz1KxiNJPGJ9IPWtk+YNgPmlZwCqtHl4sNROxcSxazaF2XhcKySQB/n8d0WSy+vsVmbq53VVJ8Yw9YfCkK/oopkSkF7jcjPTzWsjEW9OQqaCxfYh33fE+rsdNO9FQYQlzQcJ/nMpa12PCj90LUV4pqgIzyz+qWt9W5AWuy5nQNtC+ZvHyNBNfEeOa21qqsvf/34h7B8x4daMbHw2ZbP45MilIRG1O2JL5De0EU5KyBCb8CintuTuGHzpjaP09+RvUJGcT/e4MGKPQJop47irgplV+Pk7YHcGs9cQ9w0K51AJUgfxbd+2R4EuFKYK83ejVw1UcRBHEnB5Fw1Utz4nt6lHM9MLiWi+X95/UsF8Ne5OHhedMkI2BEPX8t5nSHQeyND4Pk0bfwa+zxMcTiM1B+wAlE0L4oXC1wDcWLMrDqXClFKroZv2KR0QomW4jCCawzIF2qSVwGLCiwT4i8P5ncLaDElACLBV+1WSbSOJ4KbvBKvj5P/O9NVfOSPsJKPoGKetL089nUtu9qYTi+ol9+6tNvkXbhPuE5qK5cEKpHO75ulcL3lXWsAeaTzE7jmR99QPOWgP/X1I+/dv9GHcdxKsg1Ceekeq7lQLlu6lvuIOWPrdQb2O9/GwfueZAeREB8U8fPyhtiIjDFhd94=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(86362001)(54906003)(33656002)(6512007)(2906002)(186003)(2616005)(8676002)(316002)(5660300002)(71200400001)(66476007)(4326008)(6916009)(66946007)(36756003)(66446008)(91956017)(66556008)(6486002)(38100700002)(478600001)(64756008)(6506007)(122000001)(76116006)(53546011)(8936002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HcTdnhL7kRwwk0u+TNfIeX0YhtgIk0YPmmncKMoOPGq5/Y4SLKGgrKT8X03y?=
 =?us-ascii?Q?lKuTS1/xr5pJ0Fl4wV8deLHNi5B9tII8aeUJfzkmg6OSmoXQzohYUJHdyMIF?=
 =?us-ascii?Q?3hgXT0pPmlwp7GDPiU/YwQiQkD6T23lV7Kfk42mPDArbNShrFGa50asaTPrR?=
 =?us-ascii?Q?+GbVMK741OblwrWSd9raFhKHwe/Q/fYvAiRxyMayqZKpzwJK/qv4q53wfDLJ?=
 =?us-ascii?Q?UhnIBUZ7TJfd4EGsekUsz+1Be0bBqKluem7b9oZAtHcrgyQV2/9WR62kIS2T?=
 =?us-ascii?Q?DImGzBZn7SxSmeskRrxeukIc1w49CsQPMZtkged+izKk7eCjcWBxvkkLIKsp?=
 =?us-ascii?Q?DTPYvGp1vd+g30sZYr6dxFwuHKT8+NT8CqvfkjkBoeLogfXpww3IvAeXjvSx?=
 =?us-ascii?Q?UqoCYYGCp8qqtzRFZM25CJNYv3Vt5vXOv+3rQ8zXkLhsezBe0W/GYWKeUroN?=
 =?us-ascii?Q?bnlmHDwxY24NuqfOgbxuweg2g7bIzgaeqjPb6OJPTKrcdj3bdDT4y8RVc0F8?=
 =?us-ascii?Q?NFuQu2B/nSHwO+nzVSm19rh1HF7slVyNjQwAYFL3Dil06keUYOWwaAxvdcgT?=
 =?us-ascii?Q?25lXpL4hnH749X/JR5n1vvKmNegQ8Nc10/wSWNdYgfx8QnqUPBcjVxapObqA?=
 =?us-ascii?Q?z+xW4BYCUNhlyW5GDaoyfmfL1EG7sNTecPEjRsS5NYlhg9aI9XjVyZ0ENfiZ?=
 =?us-ascii?Q?g4xRcjVL20lCtXxCcQ9w3HNbvfS2IS/EfqkW7ULFb1MXIWSeteisvCQv8US5?=
 =?us-ascii?Q?MhXwCtKYxxVvL2ZIOPGkszB61wWjkjOqH2uqWy211ZqlPHX0U66jm2BjixG7?=
 =?us-ascii?Q?o7ydIY1Vgq8YpqpSBeA316gb7Q1qtiP533hLbVH7t+Z0WbFc1eBaGZXXxfZG?=
 =?us-ascii?Q?QeekUBF5f1sL+Q0xrT5fLvJOQbnkVV+kVSeYIPbghl8lnuZofbLgHiWbjygz?=
 =?us-ascii?Q?a0GD/egu+zYaf6lpjM9Ye8QuiBoZEIMTdvCv1iaXUn/eODF5BE7dx7nDdV+c?=
 =?us-ascii?Q?cKHbhEov6ca4Z2wkEw/AtpuTbbUg0tDzVgRNElcb4OaQhpfY8h08/VtBoEUY?=
 =?us-ascii?Q?KumlS3ZIrceBW/a5UV7PWnO7s4PT7kQr7TqnCV4/LAipAnohXzVDqIs9HTy4?=
 =?us-ascii?Q?slWn7U3HCJ6rjhZs7N8D5LUrZ8Dm827RL9uEjIPYYfN0Y49mI8hPo8fT4lii?=
 =?us-ascii?Q?uifie+c9cLvRPci6Wv/b19+Y3OvYdshRIc5TzFd6HggoEWNpvZ/kl6LE0Keo?=
 =?us-ascii?Q?lN8sO7Np0FBP2oXqlYbNcSWrqVU+fcVFp6kvVe4XFSJMhXm1dokLpOe4FJAM?=
 =?us-ascii?Q?wFl4S4XD8rmc+P/P57u827EMS/Kg4TwHZaS9lxfcPBBpVsbPemWBgbmBXLPV?=
 =?us-ascii?Q?+NkjfSU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F690E795D923CB41A0321897268BFCE5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6cec18-10f0-478e-9952-08d93159d170
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 06:33:28.4004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OjYWGgIGkiGvMlJDphJpdtgspIJ9wevKrJH8EQdxHF2xn+KiloVCbP085HrSdoRVXC615mGrBx0NZcSKErWXsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2453
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: E8Ww5j9YA1uNuBEhby2g6GscflBjgIx9
X-Proofpoint-ORIG-GUID: E8Ww5j9YA1uNuBEhby2g6GscflBjgIx9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_02:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170045
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 16, 2021, at 3:32 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Wed, Jun 16, 2021 at 09:33:42AM -0700, Namhyung Kim wrote:
>=20
>>> That seems unfortunate; there's no bpf helper to iterate cgroup
>>> hierarchy?
>>=20
>> I couldn't find one..
>=20
> Song, is that something that would make sense to have?

I think we can solve this with bpf_get_current_ancestor_cgroup_id and=20
a bounded loop. Like:

	/* get diff_reading, which is reading - prev_reading */

	for (i =3D 0; i < 10 /* at most 10 levels */; i++) {
		__u64 cgroup_id =3D bpf_get_current_ancestor_cgroup_id(i);
		if (!cgroup_id)
			break;
		/* add diff_reading to cgroup_id */
	}

>=20
>>>> * there's no reliable way to trigger running the BPF program
>>>=20
>>> You can't attach to the PERF_COUNT_SW_CGROUP_SWITCHES event?
>>=20
>> I did it.  But the BPF test run seems not to work with perf_event.
>> So it needs to trigger a cgroup switch manually..
>=20
> AFAICT it should be possible to set a bpf prog on a software event.
> perf_event_set_bpf_prog() will take the first branch
> (!perf_event_is_tracing()) and call perf_event_set_bpf_handler().
>=20
> That should then result in running the bpf program every time the event
> would generate a sample.
>=20
> So if you configure the event to sample on every single event, it should
> then run your program every time.
>=20
> This is all from looking at the code, because I really can't operate any
> of that for real. I suspect Song can help out.
>=20
> The alternative is to attach a BPF program to the sched_switch
> tracepoint and do the cgroup filter in BPF.

We can create a raw_tp BPF program just for BPF_PROG_TEST_RUN (now also cal=
led
BPF_PROG_RUN). The program should be the same as current on_switch program.=
=20
We don't have to attach the program, just use BPF_PROG_RUN to trigger it.=20

Would something like this work?

Thanks,
Song=20




