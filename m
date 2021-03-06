Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B2D32FCCC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhCFTeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:34:20 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51446 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231266AbhCFTdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:33:52 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 126JPcMv004795;
        Sat, 6 Mar 2021 11:33:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=l5mu6O4vxs4t8Yw+u+H7UGG5470u0LzK7SVRRpzGLVw=;
 b=AyFSgrRHIgNNwwKx3iFbbjMuZhCn1emNYmofVpUit0Ar9aJ2GGDQEjZjib98ThsLpwwb
 KAXQUbRGWIxj4H23UElv7Wnnv1IxWTa1LEbpDpFAX4Hr32AsxaZZya2dAf9gAsF3eQqk
 BWUi9dHRp+NDgXmtL3122d60aCtq2F2lyDY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3748bys5eq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 06 Mar 2021 11:33:12 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 6 Mar 2021 11:33:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkU7JWkCMY8dj2mJaEtW4DRdgwHUB4ipyWzlta5ozJ07RYdYDAID3qTxyey+pufhiOlqx2fRKydZaPIwgKQHlKrZFTv9R43Lcza9tP6iX1mmLOcuVY9F35byG7IQ4Fahn9W6f3h/ia2o1icKGXP9e4RXdNe08D8m6cJ5xUVL3F9RIOk+hqq06B5vf+D/v639DHbDiNBuFL7wOxxND8u0IxPP4MIUdXExpN6/3oyr714VUMwOMNk18m+1tPTrbO7jb+680KbblKgXpxpG1ZOu6w7VMhaEz+45hCmmsfmcQb6CdH2IhkFS3CdphkY2ivNBH+au567giKmAJXvA3i4l9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5mu6O4vxs4t8Yw+u+H7UGG5470u0LzK7SVRRpzGLVw=;
 b=Yad1OALXO0quiqbrhfTLVKWgRY6Tw5DwyM5BceXrSX3+QZ3jYVG13+YzkIXlhPLa6/6d/NDB4bTMm/YOiwsCD6lteMqA/x6YaBRyycbhXZpR8ba/ZDr6Elzi+akryFB/8pZEtYpa3F/DHkfBjwWwbgY4m1fJ7FRpXGcHjPvN9LaNoZ29l5RePlyOelJL202Fvth6N8is/bCB/4XOhCI5K+HbUG4zwpDB60nh8BjDHW9KiarjYYIIpS1G73/htmFNcSxyg9BRuHebAZYztzpEPI3c7bkKygSAvempgq/YhFnIuokjpoHeFhCRyTBhBsn3dGLrXqxShEoVRY7q5TPnAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY5PR15MB4290.namprd15.prod.outlook.com (2603:10b6:a03:1f9::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Sat, 6 Mar
 2021 19:33:09 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3912.026; Sat, 6 Mar 2021
 19:33:09 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/3] perf skel: Remove some unused variables.
Thread-Topic: [PATCH 1/3] perf skel: Remove some unused variables.
Thread-Index: AQHXEl/vpBzgg5ndjUy6jNeqH2g3aap3WlOA
Date:   Sat, 6 Mar 2021 19:33:09 +0000
Message-ID: <BA2B7D75-9ABC-4666-82FC-0AE1A0729372@fb.com>
References: <20210306080840.3785816-1-irogers@google.com>
In-Reply-To: <20210306080840.3785816-1-irogers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c091:480::1:ace9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9916e333-37b8-46af-d9fc-08d8e0d6aca9
x-ms-traffictypediagnostic: BY5PR15MB4290:
x-microsoft-antispam-prvs: <BY5PR15MB429098C7683B3566E08D6AFBB3959@BY5PR15MB4290.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VwsK1FN3MCGEibsl8pGOZ5I0VDF8EDNwPVZJSki9ps3jAgRbeP+XJny/5gX3i1m/VCPyj+Rp+v/1x1lG1Dn6PhnXXxKO8fBndHV1XBE8ZY+tSH8nIUlqD7lYFnqk7wq90ZTT0a2NkqcQUTGeqE7u9y6eZ2KmT+yrJ/iVgXSERvCt2u9S7Lm2X8gl/XFQ6xCGxeAE2UGbDLf7SrFko49UjpcdlZTJ2Re7mYbe5do0ispaXGXJ6BFlICBBopUIzAKy2XUIP5roX0fB8CQvssVBx9mR30h9VTzd/NQaqBnlLNcHRVp2sgX0gS4Tyc+YAmt4NPs5UZsPtJcoa0LzUSq/HwWF43MxEnRnACiFknD79ct6fpHbtlWGxIbBN8joHmRImJ9pUNHCA6khsoVt9xgmqgEup/RpVLug54Rjr0WiHNlZq6EiZhGPEKCVa6VWgNrzNL7MRqDBXSzj53yh8itJrKaL9yZ4LJKkAErbpX5kl4bcJpiwpjq/FwMfejcwhOAsdG7861PIsiI2pB13+3fx4XuUkfgiCcXHVsQiK0S2sIukHiFeLnYrc80spfBmJYzHTHF33rfdYbMwfC7OJmUXVD7Iik5PThE0t/pm5JsNnN0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(396003)(136003)(366004)(54906003)(66556008)(86362001)(36756003)(4326008)(8676002)(66476007)(66446008)(64756008)(6486002)(76116006)(5660300002)(6506007)(83380400001)(66946007)(91956017)(6512007)(316002)(186003)(478600001)(71200400001)(6916009)(7416002)(8936002)(2616005)(53546011)(33656002)(2906002)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NeKWfcVqDnBthvyYdlPnBIfLTeDBE8rLXXvrdrmUdnZyvUPD3dWOhYvcct6m?=
 =?us-ascii?Q?doeN90jvphD1SpaBoLhiSmKrriPiyDluhMWwND1bscZW2GJJwy9kWi3pGFzX?=
 =?us-ascii?Q?qZ4KNl2UtS3bg3E5Yuog4LB9N/ZjonZQsnnQjCYK+iHjVq/ItBN/sjYIK9r8?=
 =?us-ascii?Q?Awh+d89k36QyR2Fkw3ifg0+oOTg46xoKay5n9Ya7j5OOzwH8atqmlD0igvxM?=
 =?us-ascii?Q?hr6cBHuiFFRZnDxfYimFm4kNxbdakApt60Qb3jJQPniGYN7CLRV0x4Cv+OFb?=
 =?us-ascii?Q?0meN0vzx3V5qeB/vYGNczxnBokm3WUOH2C0Pk0ULEF/DUVA1sVm6Dv5McZsO?=
 =?us-ascii?Q?AtG/KgJhGBxfK7RwL+lBrB683vbv+GvlppOe/idNhli7TIR74iHgiFS+D8iT?=
 =?us-ascii?Q?rHLDxShr7HQJbxYXroDNkq4GRA8n8Tx4CqtE+rQCbWVO/BTrSNPaQNRRubUd?=
 =?us-ascii?Q?QEddXJxgc8SjPS4Z9Q7SjGsf3WlbZzN5X/X/rc+JHhYzSgNaeKwanYf+Hrer?=
 =?us-ascii?Q?9mRon2uaJ4VSXlBKB5gT/dzgIX2mwjUlUEZhgR8i9n5/ucZH2QZ7RemwfvuG?=
 =?us-ascii?Q?xCrItrRN3QcS+wO2vuy27V4P29VfXNXRnMYbutSKULB6SDMC5PWklWKyPTO/?=
 =?us-ascii?Q?GLyq30qeGM2eFSKsRRWsDTEm9Qg7G+MZP9tSHf4kbmOm16rzEuJ5mQUMHl4L?=
 =?us-ascii?Q?EUxTW5BDjvxdwTmFQkkyXGPoBat3lecApQMGXQZANdDImw9xV2eVFGPBVIIM?=
 =?us-ascii?Q?L7JEuWiSh1JwxuQRHE/J8VSHjlMEOD27R4sqhj4jJHWaEqj9Ia+4Ffj/oEpX?=
 =?us-ascii?Q?7mmM67KH3GXXOeDcUc6WhWGj1at7no851ClK+2M0qdQaePgwwQqCl62shNtl?=
 =?us-ascii?Q?PmlD2zMxEMQeq3Lopu80sFjQ/LL76L/bUorPzuztY8lC/XD5Xrntzshulj37?=
 =?us-ascii?Q?G/RRUmmtjQndmE5McTNnsB4llObFgGs0vrYvM3LShj4J6LIswZVztfVa3n3p?=
 =?us-ascii?Q?vLEQqOmi5bnQsp+wiE69Gqseu9cm8gj4UrCBPjRwY6mnXcKRaFAsEG1w5Vql?=
 =?us-ascii?Q?f5xye74wcwtyDTWbNIfQH0+0OzpEAbHg/S2KLbbu09oKbn1Cfdc3IZSq1jDi?=
 =?us-ascii?Q?2Ns6a9veaedfSns2xJ3yvvYyH93jPMjsU17cmxJwGaouUMvT7T/GlgY2J+SP?=
 =?us-ascii?Q?kG+bQn+k3u+XIUQQkDzm/ksKGHDQ7qAIohghfSA4/IEcO7W9iv06SV7CXj/p?=
 =?us-ascii?Q?2UBEG+lhnthegIdUxYL+GSbPozHHNIft+S8yE3VmD9CuPF9XrRljuerC4xG0?=
 =?us-ascii?Q?LqLlw+C8W3QqYx9phU1/rLgJzrX/TuqwYdrbG2WA3ZP/JaigByTRH7fscxoV?=
 =?us-ascii?Q?hO+Ri8w=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F2DAA7CDC4EAD146B4D11F4B56E2B7E3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9916e333-37b8-46af-d9fc-08d8e0d6aca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2021 19:33:09.6151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 453nLDGBfTTE/AYZTX38+sbnnaRUm0H+pwn1YdbvOlx5xU6oIJ/TlOt0/90sZBxvB/e/5t/p0EREt1P7baFlyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB4290
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-06_08:2021-03-03,2021-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 clxscore=1011 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103060121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 6, 2021, at 12:08 AM, Ian Rogers <irogers@google.com> wrote:
>=20
> Fixes -Wall warnings.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Song Liu <songliubraving@fb.com>

Thanks for the clean up!

> ---
> tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c b/tools/per=
f/util/bpf_skel/bpf_prog_profiler.bpf.c
> index c7cec92d0236..ab12b4c4ece2 100644
> --- a/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> +++ b/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> @@ -52,7 +52,7 @@ int BPF_PROG(fentry_XXX)
> static inline void
> fexit_update_maps(struct bpf_perf_event_value *after)
> {
> -	struct bpf_perf_event_value *before, diff, *accum;
> +	struct bpf_perf_event_value *before, diff;
> 	__u32 zero =3D 0;
>=20
> 	before =3D bpf_map_lookup_elem(&fentry_readings, &zero);
> @@ -78,7 +78,6 @@ int BPF_PROG(fexit_XXX)
> {
> 	struct bpf_perf_event_value reading;
> 	__u32 cpu =3D bpf_get_smp_processor_id();
> -	__u32 one =3D 1, zero =3D 0;
> 	int err;
>=20
> 	/* read all events before updating the maps, to reduce error */
> --=20
> 2.30.1.766.gb4fecdf3b7-goog
>=20

