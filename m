Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5C3346E49
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 01:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhCXAaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 20:30:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64848 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234502AbhCXAaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 20:30:24 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12O0OhPN020690;
        Tue, 23 Mar 2021 17:30:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=tsn1DTbZa4n8G4Ei7rRxWTlwQUA0Hseox1wxrZtrA/M=;
 b=OZGoizgS4mc7oXR2rHG57ydgS7vlc6DvqPgwFoXzVuv73F5fu1uXPY1+1tB601nIgRbc
 usvWBF4eZ5Qn6uv3cXDO5kpuuxCdyzzc6FboCaNEroCNwkecCykJ5Kn7H79ZhNbPO2rp
 bO2fJ7+wCVwJLVNNpN+Rdq76kjOstIIhzrA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37fmayjnmg-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Mar 2021 17:30:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 23 Mar 2021 17:30:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ad6xDhQE3N2dHWcYtwEibHYuPl+9B5Fq0OYkoPLvTQIYQasU4lbX08qsF/TJvUI6JiK92ymKg2wdlu9XtU/SahL7sBdj+/nQG1561mItos+y0CEDkuC/ImEwowZuq6tpGRPv0sQ6o0/8/s45GVnKKB/W4grAA07FChpwAMPqhrQdNy5dRK+EyVhIwqMcB/rKAYYKH1VUW0mD9I3Frb0VFn1MUuyjxKlrdklKSrroBsoiPp6Hm/E3SQp76gC25h+W6JXIl8CqLNF4j3Hr7KhruJIdYmK5fH4Y8xZ2Zs4DtS91QfSUmEgyDgq8DX8UkyvYMJ3zpGEUFIscrDVGLmRGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsn1DTbZa4n8G4Ei7rRxWTlwQUA0Hseox1wxrZtrA/M=;
 b=FPZzHo/IOSzRxHNp55GlVVgJdfOpwFE3zTW82Vz/VA/X6FOycW/yDqLvQt2rooNosPLfj4GjVoTPPvac5QV4XWxzSNWqjtyX0yQjrhADe5Gzql10XrqHsGjNEb/tOpKQV0r07VBp3wpwQDtrF7vDqwRkdz0ZlW0F19hGMpMB7jxJQYGdHpDtBBPaHhINgu5HepowuMsAAuECwsgt+zDZjnyCZ8kY4M+q0BcnIS5IjrOPHjK3YjlRzalgegxzOWS06tN0lV1oXMN4HOhMPH0HvWZQ93KJVe0qgELJ1hEkuYuz9Ib9mDwCZzgQDc7jfN54fiULLSyKKbqWqq9Rs53Hfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2581.namprd15.prod.outlook.com (2603:10b6:a03:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Wed, 24 Mar
 2021 00:30:05 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.036; Wed, 24 Mar 2021
 00:30:05 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Ian Rogers" <irogers@google.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] perf/core: Share an event with multiple cgroups
Thread-Topic: [PATCH 1/2] perf/core: Share an event with multiple cgroups
Thread-Index: AQHXIACsCyQjF284/Uq+advPGrds7aqSSakA
Date:   Wed, 24 Mar 2021 00:30:05 +0000
Message-ID: <67AE9319-D5E1-480D-ACF1-64CB7C595C40@fb.com>
References: <20210323162156.1340260-1-namhyung@kernel.org>
 <20210323162156.1340260-2-namhyung@kernel.org>
In-Reply-To: <20210323162156.1340260-2-namhyung@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:efc5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe455fd9-d963-4632-a23f-08d8ee5bf8ea
x-ms-traffictypediagnostic: BYAPR15MB2581:
x-microsoft-antispam-prvs: <BYAPR15MB2581B54888F239963030237AB3639@BYAPR15MB2581.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dxO+FPC0FDx0skwdBZENWGpyZRZ/e7MAVVjbi3Vi2etgnQRzBPJJk6QJEf0TWz2rBsW2qv4CQ+F2lGviwbdHU2YcxYu6SVccvj7WmiFXmLNW4MmBasSD5oW4dUr3neMhIOmVNcGYhnjBod8qWd3I725JRf9/OO89ZO5a6oDnmaTdtxHokBUficLvI2HX29WZ4Q6RR66pVf8miuZv+s25ShiC4bv2wO3Kh6B8DSrnbtWaANmp6f1RaWXebQg4WbvWM7NuWXL8XhmEX6AYyOVY35hks6LnQyCqDQo6f0O2Kq+eBNw9css18bBZo7KEIZ5wwhP2zxAvR8KOgRRFmv+45Q2lEy2ffgZ4mwV6HwsqsDrlX3dtqHJJjBldT0LUDVF6Ex7hKADuCJoL26mOFP/cYW+XIlebIzTmi2mAdPVqStpM7UbLBYveN3jm4A6hVeKxefh5W2cZ11taqmG65spdcSfR+X6FmynFecDegNQP5cRlwnseruJ1rnDqmJkk6fk45YrGT9zkN5fQgHv3Is8OQk7Gl751t57F3x7foQTgJBGV8s//D6dMPT3X2/MM2kR27qwbjcQWizZKP0F6n2gjTnQWHaleJI2HYjtY1mEw+N6smpVsptLYGHzC7uzWmwYc5TW7dOGGRK3hRhhQovG91OgfRNvtebbdExBxzwhrsfPqe4rxzBL7l3K777GF9pPD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(39860400002)(366004)(346002)(6916009)(38100700001)(8676002)(71200400001)(2906002)(8936002)(86362001)(33656002)(316002)(36756003)(478600001)(2616005)(6512007)(66556008)(53546011)(7416002)(186003)(83380400001)(4326008)(5660300002)(66446008)(66946007)(54906003)(6506007)(76116006)(6486002)(91956017)(64756008)(66476007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XXUadpyoqbQ6R3hEE6skpxIj0tzJG3NevhXdXI6yGS8PxCMMfP0jw3l/AOHJ?=
 =?us-ascii?Q?5hV1tBL5UfrKVf7U+DQIaCnKmeAHrngcHTP4i8agxrimuEY44oGfUIquGm2Y?=
 =?us-ascii?Q?woN9v6J97o/6kzTa0E72h6ieRftirIqEqfVuKqTJN4AohgeVatNheDJ1Ns7R?=
 =?us-ascii?Q?U6znWPTi4wJHXCiTh0R3pheROkPG1M4M8x9bIbqYKHPhocB5skLcrGNaVQ+t?=
 =?us-ascii?Q?Pw6zj/AtnVg+Q8NMuVu3qba7HmB19biA8pe2DwJjxwNGMDP74hvRwmmkZL9J?=
 =?us-ascii?Q?M0g5dYuVDL2dtDSLq6FSbGJ3Jy2viEhzSf1Bt0smCNgrRbJDvZlQ3knFsrkN?=
 =?us-ascii?Q?6a4pIxR/2z6S/Oz3YPQnJUsqgHr9T2Xz9TLus6HIqoX4oYfPA6TeQNi2KG2O?=
 =?us-ascii?Q?excNqGfgjWO0H9HlLoS8Ozs6n8FvuQD5iq10FF5qnSozugQAaQ8oa3Exae+S?=
 =?us-ascii?Q?/rREXIVfaiJpmgJLjrY2iNuJNEeTTge80gCSreVN0UCJxhA0JiqweutxndQq?=
 =?us-ascii?Q?KBdazAf7xBaOz6oULtLMD84fnxhwZJ6BxwxJCjOQmYwj0BI90XWbcqbLIvWn?=
 =?us-ascii?Q?dOcGR/Ex3wyvhu4/Gl6JxCi5zr9NSexQ52Sb6Z9gH7vbYo5n3gjLeRSP6EdC?=
 =?us-ascii?Q?oEE77BHlFMGUyWpxNCSNAfvvKrFnGehB8ViIVgT885JS+UXB3Dyl/DKleAc1?=
 =?us-ascii?Q?f5kIRmwJMtMzth+8XOyTZFav7+sc+wBQQlGZH6MehWDXHkB1N5imS8WNTVaV?=
 =?us-ascii?Q?rlxjYNIgL/2ScIpo2/QwVeV6Aa4ZNTCCHfDR0O1T0KFp36dvI/uvqaO3VFI1?=
 =?us-ascii?Q?96TswNSs3EfHQgLcnQa5WPYVmH70/JsCmLuR36EbSdCwAwM2QpQnka7+5qx7?=
 =?us-ascii?Q?0VwotSIQTqTswn3jsKn/7/hOC3TAJaLgZUH4lCqKoZdAl6Ulv5aHvbDw6+oN?=
 =?us-ascii?Q?g9CyhQr6LygT+qpgCYqUNeEsMVtYpnaNaS5QP31q5JSvkLmuOr68ggEwQabY?=
 =?us-ascii?Q?3iWxr2cn9OSWCWeCW09i7LfkGZcUB05tG9tUnJEGRZ13uZZRx1oHQeqdk2ry?=
 =?us-ascii?Q?Y5Z0FwKjOCxQxo1nrjnmfYROnwEZmECNLylma76wScHzdmeJw2nq9Wcpplly?=
 =?us-ascii?Q?SlR7jIRUl7CyyDBxTghH6X1yFc1xdptU+hUFmrbMl2MoTCPIcZ+yrWt8+5RA?=
 =?us-ascii?Q?WkJQbzaZQvqJC5zOQU+PZCEKO6nk3v8Mwilp04Ul7GROAcN2U6TTfKFA4DHa?=
 =?us-ascii?Q?wuZSLv7VCriVTz3UMxviD2L0jkwaGH5qYiQ3t0ZuYDR/DE+vtbw/ec7wjLcj?=
 =?us-ascii?Q?+YHhdNtn7hNsuV1aCehZ5KzbuY25oHCnlCM3QaV01C/WBuxCfdR+twuDYeEO?=
 =?us-ascii?Q?yHycjqE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE892AAA76D3EB40BF9098AE8798CC51@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe455fd9-d963-4632-a23f-08d8ee5bf8ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 00:30:05.7187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRa1CSqAoo8wWbxc0FO3DBz31T1P+UrBtsSAi0c3Mt1Ob4xlZDY0u+Q3XaEEtGZpVUjoTqn+i2q+9ilJBUtEFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2581
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_11:2021-03-23,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1011 adultscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 23, 2021, at 9:21 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> As we can run many jobs (in container) on a big machine, we want to
> measure each job's performance during the run.  To do that, the
> perf_event can be associated to a cgroup to measure it only.
>=20
> However such cgroup events need to be opened separately and it causes
> significant overhead in event multiplexing during the context switch
> as well as resource consumption like in file descriptors and memory
> footprint.
>=20
> As a cgroup event is basically a cpu event, we can share a single cpu
> event for multiple cgroups.  All we need is a separate counter (and
> two timing variables) for each cgroup.  I added a hash table to map
> from cgroup id to the attached cgroups.
>=20
> With this change, the cpu event needs to calculate a delta of event
> counter values when the cgroups of current and the next task are
> different.  And it attributes the delta to the current task's cgroup.
>=20
> This patch adds two new ioctl commands to perf_event for light-weight
> cgroup event counting (i.e. perf stat).
>=20
> * PERF_EVENT_IOC_ATTACH_CGROUP - it takes a buffer consists of a
>     64-bit array to attach given cgroups.  The first element is a
>     number of cgroups in the buffer, and the rest is a list of cgroup
>     ids to add a cgroup info to the given event.
>=20
> * PERF_EVENT_IOC_READ_CGROUP - it takes a buffer consists of a 64-bit
>     array to get the event counter values.  The first element is size
>     of the array in byte, and the second element is a cgroup id to
>     read.  The rest is to save the counter value and timings.
>=20
> This attaches all cgroups in a single syscall and I didn't add the
> DETACH command deliberately to make the implementation simple.  The
> attached cgroup nodes would be deleted when the file descriptor of the
> perf_event is closed.

This is very interesting idea!=20

Could you please add some description of the relationship among=20
perf_event and contexts? The code is a little confusing. For example,
why do we need cgroup_ctx_list?=20

Thanks,
Song=20

[...]

