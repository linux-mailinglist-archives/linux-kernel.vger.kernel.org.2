Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED9D41CCB2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245156AbhI2Tj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:39:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46978 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhI2Tj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:39:57 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TDFdjA015804
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:38:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=kRho7jvlBA3v3mfuo2/5Zv3vqQCIR1aesPbevXnMkXA=;
 b=hGFcOJMVOpTm8dGwLElR437/Pi986JbzRALPN4MwFR59FspxMTZVbz2OYO3hKKTqxbOf
 rnkB9Anb7pA0GImwzuwtAoiPctplawtVNF4IvNA+u+PZ23sIwsuR5pQUzAeanTxzLi28
 hhgGzFdPYbVSCIwfkNbY8NuPDUjllfY5+rE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bcrv634eu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:38:15 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 29 Sep 2021 12:38:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9RG/2djZfqMzzCmJv749jHwwaq15kFX8EUvPfyaADfOURek8FUS+20w1cajbthkGP7B/VqWvmOXn6PATPzf5qr6eSg8Ukyp2+7J+dxADgPBryxczDOhUppn6vq0AJwjnKJHIls05OGJ5yQMpJrXuMh3WDX2RBtIAeUcyo578j0NY3gAylimGsmyUQQla3gWDw4rKh4L9tPSFfmh3fUtJ22Bp2vQO6IJXKTbqDs8X8uy3QZhpRHVpUVs6+FHIS/rZElCO0fRRjqhLM3/F3s1dlTt33vxk3DmiHozC9hkchFSFaX6VOvR0gnmBjW1irE9urxisUkmCVTIyiVKCkkbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kRho7jvlBA3v3mfuo2/5Zv3vqQCIR1aesPbevXnMkXA=;
 b=D2FUZWkF7OtfVyeyelGkhBlQySh6sFCExyXC3b3h2AtVcHqwWHEjZPFGRoekJSfg6Vh2IhM/TOVLQ4Bd9lfyT/oHNQ8Uegiuv1OH4+iAOHhS9MvOrrzSOj70hE5fQqwSrnQiv26mQgJfqYrH3gMHDhSZP4D+QMkoAcivK9P0M6aD97oQESrGF72+gy9yhGIcLsmPiOJZjACnRsBKsyKlQ858KnGjMKnjUHTiWss0uCstCoJ/uS1Pvyz6sRokmzBa+/ZAONnpYR0sIoYnRXZG++ci9RKoSWyPipnKgVw+ZrNYiW5PqFYFq6iC/ikUwlXO6xQfXE9EIJ0Gl4g6AieGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5078.namprd15.prod.outlook.com (2603:10b6:806:1dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 29 Sep
 2021 19:38:12 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%8]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 19:38:12 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Lucian Grijincu <lucian@fb.com>
Subject: Re: [PATCH v2] perf/core: fix userpage->time_enabled of inactive
 events
Thread-Topic: [PATCH v2] perf/core: fix userpage->time_enabled of inactive
 events
Thread-Index: AQHXsON8cxUzcBLit0S7boefzLsslKu6xCKAgACtKYA=
Date:   Wed, 29 Sep 2021 19:38:12 +0000
Message-ID: <59D2F040-D16F-4ECE-9977-C5187127FB84@fb.com>
References: <20210924012800.2461781-1-songliubraving@fb.com>
 <YVQvYUuokUnev0tG@hirez.programming.kicks-ass.net>
In-Reply-To: <YVQvYUuokUnev0tG@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 310be829-f9f0-4a12-3c5a-08d98380acc8
x-ms-traffictypediagnostic: SA1PR15MB5078:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB507820D05A9C526553FF1E9AB3A99@SA1PR15MB5078.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E/fWdkA/jAvuMLlFzpPY673F9HYFMFl1+3s71M7mqtx4GW7WhbOoEfu/EQigpP0LPgH9M1kON/lFe3HkiMSb9lk7DTJitsMxq2uMjQ+2oMLSfDTxba5KNj70HTm/DwpqK+T9rPnFLStDeLVepf4ehoEmg15jHCCYVML3N6zUXMItRm8MSBlOFriPvMQwQcS+mtrTwU4enD0M7PNGuBWCEr6+twcRBs9tIzWe8GGgwvXXTmGowiFgTxPiipE/HWoWGHv0YFuGE/f/D7oSZMa3s1YTP9Zh3DMaS8Ma3sqaM1w/5QxonT4lntgNkBgQiOduzIUE8Tv6TxLDmOvQS6h2KOB3lbpm2YG6Jz9BlrOQRVPDMlIXkrjO2g/oJMiK7KB9r+e1JcXDP7oe06p8Us0mqI3IXvCuoO78iqy1VULlFFlT8YpmddwNlkDT9A6btWWbz+mOEYKwZkeKEnBqXvikBhg6rlPpqcj0ErrWLEs/r5hQhO86SNg8/zfK3kipx5ZTKM13+7nly2d/wznFuRAPIkckkx2inWCi0lejy3MYyjz1hFnPxD5RXhPXHfPaR1QSWMvWQXN32zPSj3j34eCNCbr0QO9AC3Vyv3gXmZAT6NdE2l/v/HWBWaLe/QrJVVRt42SImOY0JkKIe54BeR5yTCRIplXYdah/lm3c2ktD5bHlb7NFEdnTT85P9Ue+tFAmssU98EpHxr/i1eQWXaQqhRjRBCH6eIvVXRYnK9FHhcVr7xicg3NrEAGBLnAkl1CB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(6486002)(54906003)(6506007)(122000001)(83380400001)(8936002)(8676002)(64756008)(2616005)(38100700002)(71200400001)(66946007)(316002)(53546011)(66476007)(66556008)(76116006)(91956017)(6916009)(186003)(6512007)(86362001)(2906002)(508600001)(33656002)(38070700005)(5660300002)(36756003)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oU04qz3mIhnbmnozH4EE5rCbu238dGO6wcrtdGmShquVUXvU38Yw5YPAbMI6?=
 =?us-ascii?Q?UX0WNchMdC+Hwt6uQBRwpYi5LyOaXJMrrUedIhMnWp0eY0z1ODXmCH/cC3Pc?=
 =?us-ascii?Q?0y+WVXMRUDjnP9brSHFElIFdO1lLIQZvhr8TLaDOgmuWVDyMUHG1I4GyaW7l?=
 =?us-ascii?Q?lmIwZd3e8lXfLo4hKeHf4qukSYjF+YBJ8zRIghAcWiWtw+f0betfLfxGEweQ?=
 =?us-ascii?Q?VNQdYs9qa55SKC7RdiEnC9bU+rryPw485xb7z0TdzVsTHLOstkAJfSJjDoVk?=
 =?us-ascii?Q?B/M/JX0d9RdB+f8DI+I2aKD3+3fxEiFnn4WKHbcSJ1cppQKsFOCChJq9Gcij?=
 =?us-ascii?Q?EnN8QmqOwoCIFdCpBJ7rPXf8iDxPpXomImNc1UVSi6OaKB3xiNFJmJ9QZ6PA?=
 =?us-ascii?Q?eju+CtZmgUp2rZ0ukRqXu9WqaaxUjKcxQ81TGur6uallcv2bMpxT8OvXmwpv?=
 =?us-ascii?Q?/GJ4kLkyI8OoJvITK5bCpbN83z1BTfq4XbkSe2XtmmRLqe9Om4McBVt5M2fl?=
 =?us-ascii?Q?A237gU/v4c0FO800R4advsjWID9KKFGQWsyqLQdCARkg0jGgQOe+yzN11IXK?=
 =?us-ascii?Q?gmOCr/uV0jqxrM5kbwhBCfbx50JtArBEc47E0nfDrhqM+6IwS2xl5pw4dF4p?=
 =?us-ascii?Q?0guBYjnn+KVKkB/hg0JSRfC0TNmpUovODljJYbKxPQA2j6z0n+qLFBrdJioA?=
 =?us-ascii?Q?4cqRgA35SWRUvX141i82Xbu3w+2ttJfl6++cq7rMbgD8Ban/f9nV5N8IQRzI?=
 =?us-ascii?Q?cKNxDljD4A7oLz915K21etk+Xj5lgWOJgfxRqWwSgKVIE/UHN3Vi4Pw/z1ob?=
 =?us-ascii?Q?if+a0DwVUEdLh9SeBHcYIAxkiMGV5pDiLYjrQNhyLGx6Rex+DSapJvZAk8s2?=
 =?us-ascii?Q?fv1+hg4oGvjinpxY0De5rFH2B9Jq3i0M28XnMc4ylV0tcD+Q/IFwWZt2zPrH?=
 =?us-ascii?Q?eJs8iVFz7ua+cOzhCv9ZcSVI57swUOt6rPmivS9AJII2ja4IXBojy+TXZqYi?=
 =?us-ascii?Q?jO++GN5W3frGw9ZDtVnIQFlNIa1DfOX8O4kNZXr6PwYYiaLCYABpRx7zcYc5?=
 =?us-ascii?Q?fGQO6Fx5w+ZCUrC2bhPW4hHUcmHGPdjmI5X5zoPIZonFlU0fLs1Zf0y3xWJd?=
 =?us-ascii?Q?+8C1xzZ0J/Ia8Ktl3Kj+yE8xo8ebeCCudfDVBG/taaoUNXolhKvfftTV9qwp?=
 =?us-ascii?Q?xtCaz4pP0d93fVklKgmuMy/VvLi6+eHSncVFg5zSJkYyoQLX64VhStQaUiGd?=
 =?us-ascii?Q?R3EoahWjq+Z97i4pRmFl6CxDnC9gV1gSMmV2FPIjjCxBmbqk4w4gtvWshM5y?=
 =?us-ascii?Q?7gMVO7qIXNq06MqHsMIi+nrNNtyMWfS8ETZBu1b40VR3tLfcKda+1FI5MLGQ?=
 =?us-ascii?Q?mE5jco8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <639094499385C646B9549B1EC9278B43@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310be829-f9f0-4a12-3c5a-08d98380acc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 19:38:12.6068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RVBbP3hclVe+audoAn6s1+xUbr749KPp4Vqha5aFcT9bvX6bj5qYDtMzkTOEN6Z9DtAk9FpKWiTvLqcjdRZcow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5078
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: nAxkosqRgAwo8db4OKP4yDz-wcKSIvdi
X-Proofpoint-ORIG-GUID: nAxkosqRgAwo8db4OKP4yDz-wcKSIvdi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-29_08,2021-09-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 29, 2021, at 2:18 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Thu, Sep 23, 2021 at 06:28:00PM -0700, Song Liu wrote:
> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 1cb1f9b8392e2..d73f986eef7b3 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -3707,6 +3707,46 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
>> 	return 0;
>> }
>> 
>> +static inline bool event_update_userpage(struct perf_event *event)
>> +{
>> +	/*
>> +	 * Checking mmap_count to avoid unnecessary work. This does leave a
>> +	 * corner case: if the event is enabled before mmap(), the first
>> +	 * time the event gets scheduled is via:
>> +	 *
>> +	 *  __perf_event_enable (or __perf_install_in_context)
>> +	 *      -> ctx_resched
>> +	 *         -> perf_event_sched_in
>> +	 *            -> ctx_sched_in
>> +	 *
>> +	 * with mmap_count of 0, so we will skip here. As a result,
>> +	 * userpage->offset is not accurate after mmap and before the
>> +	 * first rotation.
>> +	 *
>> +	 * To avoid the discrepancy of this window, the user space should
>> +	 * mmap the event before enabling it.
>> +	 */
> 
> It seems to me that writing that comment was more work than actually
> fixing perf_mmap() to DTRT, no? AFAICT all we need is something like:
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index fd2ae70fa6c4..1e33c2e6b0dc 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6324,6 +6324,8 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
> 
> 		ring_buffer_attach(event, rb);
> 
> +		perf_event_update_time(event);
> +		perf_set_shadow_time(event, event->ctx);
> 		perf_event_init_userpage(event);
> 		perf_event_update_userpage(event);
> 	} else {

Yeah, this does work. I will fold this in v3. 

Thanks,
Song

