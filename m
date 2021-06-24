Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D813B38E3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 23:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhFXVnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 17:43:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28798 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232029AbhFXVni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 17:43:38 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15OLdR3s031236;
        Thu, 24 Jun 2021 14:41:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=yBocj29+6l7XwXGzlsSbAnevSCBUXfWulXyHd/PM+zE=;
 b=cGjhyOrw3LiM7VxwZWEGG2gLN4UO3VoX0xuMYY2lIy/7+yuxKCTkxU1u0m9rO8FM+/tr
 jenowq96G9MGZqYRTWU7UfN06XLCIeCaWWH0LPPqCiPpAQpiUXO/5v0DLopMOVaxjljN
 IGcWSg6y0cwbV+Ky8hBaaX2c06W12S0lQDY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39d24nr0qt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Jun 2021 14:41:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 24 Jun 2021 14:40:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwsHoYOmK1kKcjgp4FeP+dYgkB8vJ3wAZmuzeSW5eg0bVxem906WrbFx1KtvnaTnrgwhT+bwAg7ectC8WRV0WOwHlwzz3El05Yij64SOZKVB90tOvYExniU5poMAz9dTZUzUSW7cXiQsyLgLGKpM2v0qZ8NRmBvGS8YIvJuGoFCx6yimHNpOKCvhan44gq9GYpbh4xDaCaC6jafzRmWKnc8mmnS+BvtyMMBGTNemKLHNAglRIy7/PsNm2kmTszqANrIuMrPW5Lj2RXbfJBn4voQAWAwvCK9Hag/d82OhPpftwRmhrkRR66ucSnTS5viR2KCIftGb8eaR/f5paErjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBocj29+6l7XwXGzlsSbAnevSCBUXfWulXyHd/PM+zE=;
 b=UlOdRDRC+GuSmDG362ZDlunCuY2j/rFjuFCKMCn8uIak+2V0zUDKVodTaU9WeGpfCIWy80TvwOK41cx7LiROk8XE/4ZNYcqssQhwr0PFD8ifF6y/EEgNLx14KhUXX0tKQGG9hWDDsjyGYynzfRl2v+7gJhaNKbiKsDhJRiY6veqDiRW0PbXCSUq3TuAJqIZKGkrxknhiKMIw/dvoN4Gty1mQ84rdxWx50SAnDOK2Ynghh/nvoyQ2Vuv4/abxLikSxEalD+WWdVSFZsZJ022PE0LmR6fkUOCSA5L/j69qmBfW+uiLPHOfyEU8ilwwOLwpQzOe67SC9avNbX8oi5XgFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3301.namprd15.prod.outlook.com (2603:10b6:a03:101::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 21:40:40 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::38d3:cc71:bca8:dd2a]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::38d3:cc71:bca8:dd2a%5]) with mapi id 15.20.4173.038; Thu, 24 Jun 2021
 21:40:39 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 3/3] perf stat: Enable BPF counter with --for-each-cgroup
Thread-Topic: [PATCH 3/3] perf stat: Enable BPF counter with --for-each-cgroup
Thread-Index: AQHXZzX6p6bVUgsBlEW05HtuW1Dxiasim4OAgAAPYICAALBHAIAATpEAgAAK/QA=
Date:   Thu, 24 Jun 2021 21:40:39 +0000
Message-ID: <A157287B-5DE5-4D8D-B8BE-FF18BFAAC16E@fb.com>
References: <20210622071221.128271-1-namhyung@kernel.org>
 <20210622071221.128271-4-namhyung@kernel.org>
 <C2ABEEDF-04AF-4AB5-BA6C-C8AC5E8579C6@fb.com>
 <CAM9d7ci3kS+=ObL_mfx1Qi2rQ7SYRjdLQLJ5+SVmRUsaUepj_w@mail.gmail.com>
 <D5859F92-8AB6-4327-9D5F-A67DB14CB493@fb.com>
 <CAM9d7cgw5ZtuvA2wwEdVU1rL6Hra2Cy4BTHx0rKsNE_ickjN+Q@mail.gmail.com>
In-Reply-To: <CAM9d7cgw5ZtuvA2wwEdVU1rL6Hra2Cy4BTHx0rKsNE_ickjN+Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:cce7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd00deb7-01ee-42c7-ab25-08d93758b601
x-ms-traffictypediagnostic: BYAPR15MB3301:
x-microsoft-antispam-prvs: <BYAPR15MB3301F571C3FF1525C1ABD278B3079@BYAPR15MB3301.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JevYxmIVqTfpKML858MSFV0j9cGKST/xL3JB3BKbHI+2PNvQxPJ5+Buiask/IA+soHUUAF8jsScMzx5p9T/FlSc0v+oTdjq1mJXlZKD3FsIPzm944TiAppEu1wKa1o0pf9xvubGyZsGW6BFrOIUNFigjSTSMacGAa81PbqYd6kvGbMFvaQB+FLTqBzOazxNndbKW53kckcGbS8LgnCwErRhnokx8+2x84W80niHO/AOdtV2IcCYr4muqfqi57s4wJL8/KV8J2QhusTSeuqCIwUWqy9ZPtzOhksl4666SJalPqsXxTC+eNE6dpw4gJPzhmD71JrE+CAFRZUjJ6OMZwIOLLEe0ldNbyCwAOPBYk2GaHlGNfX15o4wvqqKKD+AKf8Rj8+oO0HNdtXkkwPx5vb7Ch/GvrzhNjOKCbEETon4GTK+sSDcLIMlW1fHzpPbCzBX7SOVVW3o4kgfY6jnj2YHx7oRg5rnRCJpdLRlhCZr0Gbu9UDkppzro7NtdL9DN8zgyp3Dd3P/el0Lz2EgLkEHFjocokY1F+NNxUAymRgTPcz7Fm+64WVJZ6kuKnExVi6cv7ObdHuAdaI4/6oon6IH/VTrQ6FAn/i5qC6r71pym9JpKjURULA7glxlyrEcEwcBOMp3JXKpPH77U6xeQzy8AMxB/CL6m9X5ZosCjDtw5Qv+N12Bl6L6RBXJN1ZAVZH3iNGUFc5+P9C3nhfXszA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(33656002)(186003)(6506007)(83380400001)(6486002)(6512007)(54906003)(8676002)(8936002)(53546011)(6916009)(316002)(4326008)(2906002)(478600001)(2616005)(36756003)(122000001)(66946007)(66476007)(66556008)(64756008)(66446008)(86362001)(38100700002)(71200400001)(5660300002)(76116006)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8lw5FfQGG1CsQh+LjUKK+m/DxwBt+gn4FHmBDSPzAaVqV19qdVcJCcudF99P?=
 =?us-ascii?Q?7DAhjK4EyWXEv1kQMNpaTC2VduRxGD5ukR0W2GWxP0B3I0iz13pe6/IS08VZ?=
 =?us-ascii?Q?wXpNvkR7MSoRO9wx/LNc+d0ZWNlgswmREWWBY610CFrzL+bCn5qL5mi9EyFu?=
 =?us-ascii?Q?Cmju6ZTN9FyaANAJuNzW3LsOYdv1IHTNB4VDyJB1QUoezyFOO6n7YxqmUI4S?=
 =?us-ascii?Q?8hA5M/1W2o8U2dGR9wD8d37pH9o8B9u/PaFBWffOnruQQ7SBLjheOFZb/wAF?=
 =?us-ascii?Q?EO8CN/Tx1cmm2WkdHd57g/hellRCUvE4CPb6jmOS4o5A0GQYGTajGWYh/4xg?=
 =?us-ascii?Q?/94MNQHzJnCYfNcWlzSq1J7JPb6ovMoEIWnSSghDv6MGbbRrptiHwXyAWm/E?=
 =?us-ascii?Q?PGdYnB3D8sv3Qc3MMohH/bLD4BmN3c2NrP9MTfvecATRxwGbUzpofTXkQvgr?=
 =?us-ascii?Q?6Ux2CrqPuRLHhOUrIcuoRb8lekW7hEKkN9RFigJH5xVfq3ugRxaAhaGq10aA?=
 =?us-ascii?Q?7f0rqNm1uDk9UWZhHMXlTNXvP4cpIRG3Wqc+am19jzD1hTwUHKxYVoE4PFlu?=
 =?us-ascii?Q?vvnYRsipEfsSkVv54tpG0n1hcT5g7UOuW6SceuErxVDRKGjGBpn1FeXz/ACz?=
 =?us-ascii?Q?dxKfVbte4yefk6n+/ZzVZAFUHSb5EmqeSS8gSO7nL1dvevLa28aSOOog56Jy?=
 =?us-ascii?Q?rvOOxtqSdIDuBjkOVaF+VVdmT2AQFpEDAb+ZZc8ELlkgMLKPxfU8xWWMWAJc?=
 =?us-ascii?Q?pZSi0BCtwpXtJsGH9enouLCSsD1Oi9SfuOH4BuUXUYI6xGGNTwW5LWCsIevc?=
 =?us-ascii?Q?F70X6obPNkrGLdJXTOlewblcEggP0HYN65YpPD3LxbPQc/NcLxmWGYhZfjFh?=
 =?us-ascii?Q?ULpkjIdyA791P+FirffWMZ8wYCki3TQ5z+bHjOK8bqVlRnRopDcjEJwh7gVb?=
 =?us-ascii?Q?yz6U52NR7jYstiiH7OcdcJIfFCl1qDG1TrF9TRUmB4Cpg4zB9pxmnxZu9Zjd?=
 =?us-ascii?Q?NTB/6U4ioTt5fHf6uGDHH6wr+T2ZDy+asA7PSSAxv/XKXYAw/PlSqIfS8sEn?=
 =?us-ascii?Q?Gya78ulY6jf97IL2n+EYDJOCtO/cuAQD9XktPPuRhIVcTadilB24MAoVc099?=
 =?us-ascii?Q?OJfGDF2UJogeyoq4hiaeiNYg6avxPQ4QMzTTBXAdNoAnp0LYCrm23+y5Q5Ci?=
 =?us-ascii?Q?hAyJUGWEYy4iTTWmKqPT5rzSOSIvZprEtpriVW/CaetwuX5V9PYqbN9FlFes?=
 =?us-ascii?Q?9HfrxoxFwYuk4TB3YmIgG2KTdwJ37OssDPtbW3GiM1t74dgXswQzty59fu01?=
 =?us-ascii?Q?kGGJUwn6ap/Lw93LCxkQhxNfyxv8XRVUOEB+Z8PnFWuZrDwJO8jNxdSf3QSR?=
 =?us-ascii?Q?Os4VP00=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F35882C53B04334AAAFB49C75C2093C4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd00deb7-01ee-42c7-ab25-08d93758b601
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 21:40:39.8249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JuPTp7UPqYYAEVfLnYrYmmGS+5t4df4ZFAND4NTwuvC6TnG5kQn7vvXmheGPVLNs5IJNcPWLCHX5ZDsYXgdyyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3301
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 2y9a-WrWzNR8nQ23LlANSJtbk2vwGooY
X-Proofpoint-ORIG-GUID: 2y9a-WrWzNR8nQ23LlANSJtbk2vwGooY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-24_16:2021-06-24,2021-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106240120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 24, 2021, at 2:01 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> On Thu, Jun 24, 2021 at 9:20 AM Song Liu <songliubraving@fb.com> wrote:
>>>>> +
>>>>> +// single set of global perf events to measure
>>>>> +struct {
>>>>> +     __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>>>>> +     __uint(key_size, sizeof(__u32));
>>>>> +     __uint(value_size, sizeof(int));
>>>>> +     __uint(max_entries, 1);
>>>>> +} events SEC(".maps");
>>>>> +
>>>>> +// from logical cpu number to event index
>>>>> +// useful when user wants to count subset of cpus
>>>>> +struct {
>>>>> +     __uint(type, BPF_MAP_TYPE_HASH);
>>>>> +     __uint(key_size, sizeof(__u32));
>>>>> +     __uint(value_size, sizeof(__u32));
>>>>> +     __uint(max_entries, 1);
>>>>> +} cpu_idx SEC(".maps");
>>>>=20
>>>> How about we make cpu_idx a percpu array and use 0,1 for
>>>> disable/enable profiling on this cpu?
>>>=20
>>> No, it's to calculate an index to the cgrp_readings map which
>>> has the event x cpu x cgroup number of elements.
>>>=20
>>> It controls enabling events with a global (bss) variable.
>>=20
>> If we make cgrp_idx a per cpu array, we probably don't need the
>> cpu_idx map?
>=20
> Right.
>=20
>>=20
>>>=20
>>>>=20
>>>>> +
>>>>> +// from cgroup id to event index
>>>>> +struct {
>>>>> +     __uint(type, BPF_MAP_TYPE_HASH);
>>>>> +     __uint(key_size, sizeof(__u64));
>>>>> +     __uint(value_size, sizeof(__u32));
>>>>> +     __uint(max_entries, 1);
>>>>> +} cgrp_idx SEC(".maps");
>>>>> +
>>>>> +// per-cpu event snapshots to calculate delta
>>>>> +struct {
>>>>> +     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>>>>> +     __uint(key_size, sizeof(__u32));
>>>>> +     __uint(value_size, sizeof(struct bpf_perf_event_value));
>>>>> +} prev_readings SEC(".maps");
>>>>> +
>>>>> +// aggregated event values for each cgroup
>>>>> +// will be read from the user-space
>>>>> +struct {
>>>>> +     __uint(type, BPF_MAP_TYPE_ARRAY);
>>>>> +     __uint(key_size, sizeof(__u32));
>>>>> +     __uint(value_size, sizeof(struct bpf_perf_event_value));
>>>>> +} cgrp_readings SEC(".maps");
>>>>=20
>>>> Maybe also make this a percpu array? This should make the BPF program
>>>> faster.
>>>=20
>>> Maybe.  But I don't know how to access the elements
>>> in a per-cpu map from userspace.
>>=20
>> Please refer to bperf__read() reading accum_readings. Basically, we read
>> one index of all CPUs with one bpf_map_lookup_elem().
>=20
> Thanks!  So when I use a per-cpu array with 3 elements, I can access
> to cpu/elem entries in a row like below, right?
>=20
>  0/0, 0/1, 0/2, 1/0, 1/1, 1/2, 2/0, 2/1, 2/2, 3/0, ...

I am not sure I am following here.=20

Say the system have 10 cpus, and the array has 3 elements. We can do:

	__u32 values[10];  /* assuming both key and value are __u32 */
	__u32 elem;
	int cpu;

	for (elem =3D 0; elem < 3; elem++) {
		bpf_map_lookup_elem(map_fd, &elem, values);
		for (cpu =3D 0; cpu < 10; cpu++)
			values[cpu] /* this is the value for cpu/elem */
	}

Thanks,
Song
