Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8720134286A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 23:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhCSWHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 18:07:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23310 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230507AbhCSWG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 18:06:57 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12JM5DFi027000;
        Fri, 19 Mar 2021 15:06:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=tQWlwpLZHUsUPKQHoqI/uezFkkclK2tu0m/tTZr3aIU=;
 b=GjAjYVEuJuWRKqEU3UGIOpPH4taXyj5PVl5yi7r8KPowWsrWWtsYV8sEmM51Cm6gbWh1
 QkzV4Q9+8CbpKJze80UUYd/Oy6h8UNWfsyJ8JLU+OrutyXqMQETe4qEPf3z8hpIQtFKa
 euLioBqcFwjI6gbl5mHdtKJPKeLlIUh4dh4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37cx90j9c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Mar 2021 15:06:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 19 Mar 2021 15:06:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuMZVEtGnA4oqZjkKdHombLteul/eteNllBaouQD5K8V91yPhfk2LzAWCoc7CXnTEEvtQ4lJtbNLrgW+NRs26qAkKC7AVMpk+8E6lxko1OSV6ExYfC0Js0GvAyopAwB2SagnGW72Rmjg40ybLZPTDdYLy0GsQ804FCnsc1bdyVRSK52ogYyEQJFAhyaQMXl3UTBvRcnvdHgQj1+4IyCqa7v0gRBjLqNVExOWjSbi9Etb2Xt9Tkz7/2dhFlWAt8KPeSEcKa4fOUzJ0KF5xxBR/dn40P82FBxwX9Xkh1AdBF0vYo08l22hxQ+33t3I70pV39He8SxdGNgTmaeEADFIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQWlwpLZHUsUPKQHoqI/uezFkkclK2tu0m/tTZr3aIU=;
 b=lbzRFVaUqHq+k5P7tfc6WE0wdKFVHwFHzJbkFD0r1dRiTMWqN4P5gEqds7rIVXGjN5JaA6Rjr8u7IXqc+ihGH+T9rEORpRc6UKlWmbM6smIWTp+/I1abfJqOB5S5rNrS3EucXDDHoLOzw4+mzodyVrXedFENrnSB4pMMWA3Kff1LwvfRCAlobo0ivR4r7TQDqPBk/l/eTsV4x24hM2sb++HUJs95gNkYLhVdLCc8zICD227gsp8YRDkCX03/S25Fwpgzk0DAOVCKzo4Tc/nhzg5+1gd1HIBxyxGXR8lzFqSATcmXkutaYLDteeD7YLzEhWhN6+R5LwL3I9J+IYxTZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3208.namprd15.prod.outlook.com (2603:10b6:a03:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 19 Mar
 2021 22:06:47 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.033; Fri, 19 Mar 2021
 22:06:47 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v2 1/3] perf-stat: introduce bperf, share hardware PMCs
 with BPF
Thread-Topic: [PATCH v2 1/3] perf-stat: introduce bperf, share hardware PMCs
 with BPF
Thread-Index: AQHXGqoOnn6PYztrGkqjWdJT1tFfMKqKQj2AgAFng4CAAAPPgIAANWuA
Date:   Fri, 19 Mar 2021 22:06:47 +0000
Message-ID: <C8B17AAE-79FE-43BA-84AD-0EC7A83DADF3@fb.com>
References: <20210316211837.910506-1-songliubraving@fb.com>
 <20210316211837.910506-2-songliubraving@fb.com> <YFPC4UbLWzTuzyER@krava>
 <YFTwdWxUvqHDNe1x@kernel.org> <YFTzp9CA2/il8p77@krava>
In-Reply-To: <YFTzp9CA2/il8p77@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ab65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3e0c3b4-2306-41a9-977f-08d8eb234a61
x-ms-traffictypediagnostic: BYAPR15MB3208:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB320877C3A2D87CF0311C9851B3689@BYAPR15MB3208.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MR9l1kFfj5OLsgr7RzBeIQ+jLTLcxzfcXEQx3dUnz4xvV1jYiRrKs2jxg2SHjCWpGkT9Pc6QIKohzNd32rh8U0VvE/uLumaC7cKru3i+UzfjRx+Ux2yGWjhxigX7YV9aXIZTRfWD7XyR4QL6e/NEChHluNl7AoZez/tpe35IU6yHgHWQ14xgjWtAY6owx0xwD6uXfPE2ger1sUGPrJ3iVvcItuocj068SUJOi9JH09z7/hbV30mkTsjbj/xltrl6kW/FGwQOLLXgLeeVbj9MXP1kLWtOXf/hBIHRmf144y4J0a799f1Lz6bNM8WaKwxwy3CWQ38s+Zp6fFIPaCPxQgAhdOYppqvk7CXb+NQWiL5Q0EzYeu7ESFDQlByboRmnPaQhC77q8qxhTTnzyM9/mtv3gokBbH/biEgQnvgj1a9RivjdgUAWXldJ81+ECbLvRN5U29h5M8DU4/f8fz4qfVd8EY+oj6980FuUmQKdo543rtywYIl4zhqIFjGe9sR7CgxJhKHzlXeLDvCKslI0WDF4Z1RI+TzEE0Rg4oY4wJ+qMRtxS4BrdMsRwnHDOEr6IVg+Wcp4AOPau/Qme9J9jLmgZKM6gZpoY4xvq3C90TZ+upoWiCFcMjeIXcq48ADrjEhEGLyIupsWVVnYYhpDgpvqVucozx5M4idJ3IJaka3YAmBug08QVKzw6ZeyzOgKRBjICYNe7gJsiOSakSYT73520/75JARS4D58M//sQr0reGzolYNAK6VPCEgNYBxSX3Hd1L/N+5BgT/oWCwEIpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(39860400002)(346002)(6486002)(64756008)(36756003)(6512007)(2906002)(4326008)(66446008)(76116006)(66556008)(66946007)(33656002)(6916009)(71200400001)(66476007)(6506007)(186003)(5660300002)(316002)(8676002)(478600001)(2616005)(53546011)(54906003)(38100700001)(8936002)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UjqbO2tz0ZVxl3BbQHvXxHZq9vqodIu186uJD0OwT1tX0oLs85Q0wdvCDDw8?=
 =?us-ascii?Q?Lw8F6Uqwj6jn7Yb7L9sWQ28QbFreugyKZ9hy1qCTaXtckniU358badkp4PXi?=
 =?us-ascii?Q?0mGpDnqYPxSMy5n3imRrlB4FMeg5OXzCMsAe3K4QbtSq83GVn4f4TrZ8aUNJ?=
 =?us-ascii?Q?4E9gDyKw0vF4Ak2JDnMI94PI5RMVupB+F60mK62s9JYvdvLf6Kp2Rh9dApJ6?=
 =?us-ascii?Q?kUbG2bWaF8UYFjs5JNVqoGJzv2NDPo9SxLRqWmCKkjNBUPfUODVwgRWFtqd/?=
 =?us-ascii?Q?ZtEyjN8FyIULzUWWi171alPjihw4+BQ/rUnplmIrEQX2Rm6Y7qYNZx1Ex602?=
 =?us-ascii?Q?tsk0PzTGGGeD1zwODp2EZ7BVhPbokuVoZTJ4PQNVoAogyTIaLJVY+J0P/EHu?=
 =?us-ascii?Q?pupAuKa6CsGdWMoIjuNZNdm+0sRhExsq1PujtFQ8UuukPrjtRag9Ze1w+wY7?=
 =?us-ascii?Q?QmUhmEVQgUr2lauDoi1t1xH05iSZbNFP7hQgrWGZnno4W/QIQ5RAoH2jQCUJ?=
 =?us-ascii?Q?ww3PCiHHxsFkWH/NeYRlkQLU+o1FtwhiD7BsgPhvf4KJBJ6CQF/8LjIzLcF3?=
 =?us-ascii?Q?ceu3kMJK/6bREYXqOWPXUewsTnqYW1Hn4fhJUNfx3dD14xtUWpEl20UTpKuA?=
 =?us-ascii?Q?oIZDekEB+3nFLtpxLuS5h/yG6FxVZAbvT0+IOyG1VxZe2PKEXawJVfePV8RB?=
 =?us-ascii?Q?0koMRwjc3XCEohzkSioNc8ZeUNeYFSo59OItCNQSfQDE/x4zkSkoSmpG0+Uh?=
 =?us-ascii?Q?KWr5Lfq0110i7NNLhDZkaLMx1/lFqf8ChygpfYrKXZd+MBZRB6nlPX0YHkbd?=
 =?us-ascii?Q?12O9kQvQuyFXtmes2C5aSanzn7IQs5oGeexXvb6rJlyG+URK75Kl6tS33yhb?=
 =?us-ascii?Q?EmsGK9EUzfWacPH9et9OpcbLC0/3t5uRZuTvrk4ZNLks5Bu1XQNxqbR/TOgc?=
 =?us-ascii?Q?bO4LvuTsHwHUSfhdCaj9HvrawQ10vkEj2KwIA8TjVu6mSL6RzfMd8AUxoetJ?=
 =?us-ascii?Q?5fMNkkO/V5t5S2mKyOaxZk1dDx11j2C3cGca+b0QqN5hIlxiRLuT7qXPUj6s?=
 =?us-ascii?Q?imy7Be6rE1YRj7SKZvRP7xzvsNIimUrO9W4jFsRRD4QpDp4DV9Ohb82G7dZT?=
 =?us-ascii?Q?/MERZ/+cnuJxmVOu5taZ2h1F1a2Ful+aOqzueBlyD3EXQ0zbIs0Lr+Nn/TN1?=
 =?us-ascii?Q?R0qO4/UDRvY9ZggvYYaWVHOnSC+oZQvZKJ2d8AnXFNC9x9whvW2zCaAGXCDZ?=
 =?us-ascii?Q?YlhmARci9oYH+WEKmwSoYIwuYIJSUTT1JBE9aP1b06MadV/zEViM6i7yLAXJ?=
 =?us-ascii?Q?NuudhblZa45jrUdnsrAHaQJQCa9wCkDqmQswDpPW/SMi8bCUtnpDAYYTxBMa?=
 =?us-ascii?Q?SQ4Z8as=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20D46027278D6A4EA0FBFD7082CA597B@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e0c3b4-2306-41a9-977f-08d8eb234a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 22:06:47.5378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpKg1I6bbdeQ5EPBFgjmcigIe57Sm5FvyjEZy/tiw0AJrP8kI4aUl1/XyvHcCJIt4m4bCyituQj9cCq9qypjkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3208
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-19_12:2021-03-19,2021-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103190151
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 19, 2021, at 11:55 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Fri, Mar 19, 2021 at 03:41:57PM -0300, Arnaldo Carvalho de Melo wrote:
>=20
> SNIP
>=20
>>  LD       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobj=
s/libbpf-in.o
>>  LINK     /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/libbpf.a
>>  LINK     /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/bpftool
>>  GEN-SKEL /tmp/build/perf/util/bpf_skel/bpf_prog_profiler.skel.h
>>  GEN-SKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
>>  GEN-SKEL /tmp/build/perf/util/bpf_skel/bperf_follower.skel.h
>> libbpf: map 'prev_readings': unexpected def kind var.
>> Error: failed to open BPF object file: Invalid argument
>> libbpf: map 'diff_readings': unexpected def kind var.
>> Error: failed to open BPF object file: Invalid argument
>=20
> I'm getting clean build for the same options,
> could you please send the same output also with 'JOBS=3D1 V=3D1'
>=20
>=20
>> make[2]: *** [Makefile.perf:1029: /tmp/build/perf/util/bpf_skel/bperf_le=
ader.skel.h] Error 255
>> make[2]: *** Waiting for unfinished jobs....
>> make[2]: *** [Makefile.perf:1029: /tmp/build/perf/util/bpf_skel/bperf_fo=
llower.skel.h] Error 255
>> make[1]: *** [Makefile.perf:236: sub-make] Error 2
>> make: *** [Makefile:110: install-bin] Error 2
>> make: Leaving directory '/home/acme/git/perf/tools/perf'
>> [acme@quaco perf]$ clang -v
>> clang version 11.0.0 (https://github.com/llvm/llvm-project 67420f1b0e9c6=
73ee638f2680fa83f468019004f)
>> Target: x86_64-unknown-linux-gnu
>> Thread model: posix
>> InstalledDir: /usr/local/bin
>> Found candidate GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
>> Selected GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
>> Candidate multilib: .;@m64
>> Candidate multilib: 32;@m32
>> Selected multilib: .;@m64
>> [acme@quaco perf]$
>>=20
>=20
> I have:
>=20
> [jolsa@dell-r440-01 linux-perf]$ clang --version
> clang version 11.0.0 (Fedora 11.0.0-2.fc33)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin

I am not able to repro this error either. I tried two versions of clang:

clang version 11.0.0 (Red Hat 11.0.0-0.2.rc2.module_el8.4.0+533+50191577)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /bin

clang version 12.0.0 (https://github.com/llvm/llvm-project.git 07f1e1f44c87=
d1ee84caf13d6e5aa64eb7e1b068)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/local/bin

Thanks,
Song

