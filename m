Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4673392C8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhCLQK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:10:29 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21086 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231331AbhCLQKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:10:03 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12CG9kXH011151;
        Fri, 12 Mar 2021 08:10:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=kmJOIWmzuEB7Od8RzJ3Wwc6diAJE52w3HI/d/HuVuLY=;
 b=lSNjQEx4X+60zd0hioYz9OfbBfaLRoCpgWR5cGwfQgzXWAU8LTKxCk6PyGckChFEOZXw
 R2b3PbHjGozAlLxE2ZZUuch1PoH1fM/h/414n80uBU4IoZkS0JCMhkCESnXAPel2YlYr
 AE+RHN8gusFmMys2frpjzh9WHhW0bPaPdPU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 377uht49wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 12 Mar 2021 08:10:00 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 12 Mar 2021 08:09:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hc05tCeSlbDk2AXblPA+OO1Kzj1NjhnMVt7kcRgA+MYNs7RwasE+bvEFPAj7PobFX455Qts+Uw9djvAnymNhsYhVehhGXyVmcF7j78HMVU3SLgVrbPdpSDiTnofb5AYacS4l5FPZ9zbd0nEnf9XF0Lbm4nxyLmsy1lDXt9XTjF0cN/zNN5axKzwAbaKNYUwnb2GGVhP6jPO6iE6EQMJGqFekzCI4gpyf8WjTs/lQIyzCcp+l3qonMXA6UheQW4Tzlax67NqaUXSDAWkAZyiQdBX1txfAwfclJySIbgGtjxJS6KZEg1Isz5DH6Va1UhrXLeO6fsrauB/2rjWZPBxOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmJOIWmzuEB7Od8RzJ3Wwc6diAJE52w3HI/d/HuVuLY=;
 b=iwZr6zHJW3vo4FOWQnJZZDR36TmLaW+VY8EJGnXjLFausQUtfjwNGhqgQAcuEB5FUW1aaUlbiWsVGNQH3sDWisUYw7HTqug9LFBrkdLpFIIjk9JMv/Tn080mtg65WMO8pQLHAj65GzOgrOqEr+sVMF5iVgaBZYDVVygOB+717YHBKWZiZfW30bEM7DbgGBSb1TEHAT4ZXfMgDyVni8iWjg8y/rZP9rWivi1PDVeblZPXjXYp18YH8h4w/mCf7yDfYygdPVr7qk38fmNQb9fIpUJJzfOwXqCZZT0b8cWiUp9If4c5nOmS4TFQ21qRsAsHbDFKi01pdtdCvtSu4S+gfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB4246.namprd15.prod.outlook.com (2603:10b6:a03:10e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.21; Fri, 12 Mar
 2021 16:09:53 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 16:09:53 +0000
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
Thread-Index: AQHXFuPifzAWbJ/c0EGfxtA8c/wTpKqAREAAgAA7WYCAAAbkgA==
Date:   Fri, 12 Mar 2021 16:09:53 +0000
Message-ID: <B7934C3F-4414-45AA-BE39-8FE3C64B7E7D@fb.com>
References: <20210312020257.197137-1-songliubraving@fb.com>
 <YEtawFnompBDKpK0@krava> <45BCAC33-1626-42D1-A170-92DC8D7BAAF8@fb.com>
In-Reply-To: <45BCAC33-1626-42D1-A170-92DC8D7BAAF8@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:17f0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d36b3ad-38b9-4908-d173-08d8e57145d4
x-ms-traffictypediagnostic: BYAPR15MB4246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB4246D5FE2096E70176C3E76AB36F9@BYAPR15MB4246.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0trFPc1Hbwe2RTQqLgI8B+RHXp/aeatzdGRP9nSzJJzB8p5+EcakuRc2X0kqsuEP/LmlcvzoE7TPPU+B38Ww+arHB2O926rtcOPYn9emWBi4zaOEcjM53cQGmQW/PP73JxHlznm3FGKE8eJlS/fmQXziYfoyse4n8zQyvEj13dg57C+wqjlcTSRDGOrFDThN+kUoURFK7UtAG1py9ObVnCstvaqvm7NJJVnvycIsifs+vbh6YW0W1wMoiS7VT+WuuLaBHhhnOA0h0zwRuKo/z/arX4aUGuC6qstR4685tKTfkezBjzNZ/Q+zJLoOzM/SnMDdq5ZKJwQPTpdWeME5eYsEn6KTE3qSjVfF7IIhImZQzoFtMBeVuddjNvkfWCqKE3WqpkBOytWHJM4cADJpEPNY40D1lMQShDUM/30XD+0jJwyFft3M/p1G36V5pQKb6S1mSSaHJGuxV7Xm3OALvvJn7eY87e4ezWjXnUOghKo907IYbo+8FfvsDmsQQ4PmIVNBJ4/0FPLtfsAorrev7Tq3GycHsEpNAn4uXiN0HJU/AgtBbra7MxpqE6Ah/YgfEVbm0zndtLIOflQ+pW348A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(346002)(376002)(2616005)(66476007)(66556008)(64756008)(83380400001)(54906003)(5660300002)(2906002)(186003)(478600001)(6486002)(8676002)(6916009)(53546011)(36756003)(6506007)(76116006)(66946007)(91956017)(8936002)(71200400001)(6512007)(66446008)(316002)(4326008)(86362001)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Ud9q5NcshfnXbmtXgSR89NPO5pTzbgqgk5GqrYSgZJ6X4iqdK+juI6WJawwM?=
 =?us-ascii?Q?IBB3+olY3y0NFLhhXMIJNYlqlHXcIva6ivdxn3qkrSpjBcXaCllFgWwc3469?=
 =?us-ascii?Q?L4yvVAQr0NnjyckVnI6PTSOYH3B4eqxnytYtktSeFUhUsHQVMLYWVMRGxqg1?=
 =?us-ascii?Q?ZGLz/vUoLiRwfKs7bWG0v2VOJ4YTTo6v7wtp6KEw0gADD11lohue7wOe/ef2?=
 =?us-ascii?Q?DokUXySeo8bgKk01tTtsDYkwArpt8UbZZODG1Ec5cFntn1K/OQ1g3THQKjaP?=
 =?us-ascii?Q?qcWmmJAbRU/PH9lWQZVPcuP+pPi188FzJlyimTxRyN5t1aRManvd+N0nzRtX?=
 =?us-ascii?Q?/Ro9zxa7wxtc/svEhT0xvop5pxTWKVvPPZvTCgLKRIomARFga5CfqqiPqjGZ?=
 =?us-ascii?Q?snjOkhFjJuMLBcT9buEcAsaH/xLg05lO6CKhPJP0Fvoiu+NOzT4rXazrbcD7?=
 =?us-ascii?Q?gRheEMmNrOaiMLQkmIo3VkoG91mwhCs+aiBUliu3Py87cT/3yfuzMXk3RJ7H?=
 =?us-ascii?Q?aNWkR20eh13Tw6yEOAKQhuVHGXTto2POrBV/3X65JpWtOJG1mEio9FU6+a1n?=
 =?us-ascii?Q?tGTLaYYlaRHHHRZhWMkXS2xMhMlLXWGFuroU4c2I58yGbpsESY71yuRo0PZg?=
 =?us-ascii?Q?rshoz4NJk3wNDUk7x7rSB72Yw5Wnb+YczElKAI6gnjLESHL2f1pdsQfsN9xa?=
 =?us-ascii?Q?Xf8OParmaXDToJk7+9rmOCZOy7smfcO/HBJGSScQr0ZdYH9b7ZG9RvSeN9QN?=
 =?us-ascii?Q?wTVRNPxOrGCCUTgOxl3FWTVZ6IjM0ynJ7Vm8QGvhmiAmWYeH9hR9mArOxVty?=
 =?us-ascii?Q?7pC8mmOEVTIfnR4VYxh/g0TEqLmWjBSIsJUA3OIE1CkaZET6FGANIloeAcCO?=
 =?us-ascii?Q?MzGuuJRrDpa8Z94p2GPHckHItLOiX96BGh58htzPKO/8aV72Fmljw5MSwVDB?=
 =?us-ascii?Q?Qj31F4wgOBK2wUJ6LZcN+BdKueH8R/9E4Dgac/xdNG4oMr2mxoPkAeYaoNNw?=
 =?us-ascii?Q?tewlbo7ahmfsREb44eGhxyOo3M/Ck5X1jTVmzvD9+VCirJhFZ+wssPGfkIGJ?=
 =?us-ascii?Q?5LwJ6HOmeIX3WIKEclodgZMDEwPkKEfBlDIV72Q8E901llaeG+vMRswBNfCs?=
 =?us-ascii?Q?T7MXGvk3JE5RJg8slb1S21YNvGYgOZcoLTMx3UO6JEp7dzDfSAUkXunxkUpj?=
 =?us-ascii?Q?HNMfdAsYyCKd1wevMFe7vq02SiFkaTTRrWAtBaSWtUmrDnZ1fhxm04DuMURl?=
 =?us-ascii?Q?vygNYJvI39TPYtIJ92Vslcp/8Vk2LlvRC1MNeIEW4N0roMVlpqFfNfUJ35QL?=
 =?us-ascii?Q?sUd9hDRgPpTpmrJ6EEDzTxfrRT8gNCOC6apQfrV/PWR0aDC+iqersc5CsMX9?=
 =?us-ascii?Q?+XqgRaI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BD7F889D183F3B4D998B019FF6AE32F7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d36b3ad-38b9-4908-d173-08d8e57145d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 16:09:53.7046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QHMh7Ix5s9h0RlJ3KFkvLmBMkuhLsH7lNerVCtU6kcNLL2y3zTxDxiU1kF5KeovqkI3jiaHna4NH9L1hZJPxsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4246
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-12_06:2021-03-12,2021-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103120116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 12, 2021, at 7:45 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Mar 12, 2021, at 4:12 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>=20
>> On Thu, Mar 11, 2021 at 06:02:57PM -0800, Song Liu wrote:
>>> perf uses performance monitoring counters (PMCs) to monitor system
>>> performance. The PMCs are limited hardware resources. For example,
>>> Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
>>>=20
>>> Modern data center systems use these PMCs in many different ways:
>>> system level monitoring, (maybe nested) container level monitoring, per
>>> process monitoring, profiling (in sample mode), etc. In some cases,
>>> there are more active perf_events than available hardware PMCs. To allo=
w
>>> all perf_events to have a chance to run, it is necessary to do expensiv=
e
>>> time multiplexing of events.
>>>=20
>>> On the other hand, many monitoring tools count the common metrics (cycl=
es,
>>> instructions). It is a waste to have multiple tools create multiple
>>> perf_events of "cycles" and occupy multiple PMCs.
>>>=20
>>> bperf tries to reduce such wastes by allowing multiple perf_events of
>>> "cycles" or "instructions" (at different scopes) to share PMUs. Instead
>>> of having each perf-stat session to read its own perf_events, bperf use=
s
>>> BPF programs to read the perf_events and aggregate readings to BPF maps=
.
>>> Then, the perf-stat session(s) reads the values from these BPF maps.
>>>=20
>>> Please refer to the comment before the definition of bperf_ops for the
>>> description of bperf architecture.
>>>=20
>>> bperf is off by default. To enable it, pass --use-bpf option to perf-st=
at.
>>> bperf uses a BPF hashmap to share information about BPF programs and ma=
ps
>>> used by bperf. This map is pinned to bpffs. The default address is
>>> /sys/fs/bpf/bperf_attr_map. The user could change the address with opti=
on
>>> --attr-map.
>>=20
>> nice, I recall the presentation about that and was wondering
>> when this will come up ;-)
>=20
> The progress is slower than I expected. But I finished some dependencies =
of=20
> this in the last year:=20
>=20
>  1. BPF_PROG_TEST_RUN for raw_tp event;
>  2. perf-stat -b, which introduced skeleton and bpf_counter;
>  3. BPF task local storage, I didn't use it in this version, but it could=
,
>     help optimize bperf in the future.=20
>=20
>>=20
>>>=20
>>> ---
>>> Known limitations:
>>> 1. Do not support per cgroup events;
>>> 2. Do not support monitoring of BPF program (perf-stat -b);
>>> 3. Do not support event groups.
>>>=20
>>> The following commands have been tested:
>>>=20
>>>  perf stat --use-bpf -e cycles -a
>>>  perf stat --use-bpf -e cycles -C 1,3,4
>>>  perf stat --use-bpf -e cycles -p 123
>>>  perf stat --use-bpf -e cycles -t 100,101
>>=20
>> I assume the output is same as standard perf?

Btw, please give it a try. :)=20

It worked pretty well in my tests. If it doesn't work for some combination=
=20
of options, please let me know.=20

Thanks,
Song

>=20
> Yes, the output is identical to that without --use-bpf option.=20



