Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8BE346B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhCWV1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:27:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34358 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233581AbhCWV0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:26:46 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NLOWGV012191;
        Tue, 23 Mar 2021 14:26:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FroWAXpNHl5LOwwAPAExGQeecmlzfPb+I2egCFYDgik=;
 b=OcOlm0OfSR+XMzutG5Q4fPyIhdLGlmS5ElN71WHuZSYrUGM7oKy7hvIYA8/L3yWVlMcU
 Z8DkvE2V0M83OHKqlvOiPCRaAPJPNiyY/45GiPhspXGLQpuFImO9zMxZwawLGrsJQjhO
 +He/pjwWR6A8iVrxIwT41UrVKVuEwt++IrY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37fmayhq7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Mar 2021 14:26:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 23 Mar 2021 14:26:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ny1SDPkellVGY9dVLdJ/iR2VkPRg9TAkkSNOKl2mzy7pAPmyCoATIAhVlee9p8lS+XFc9+zkLRjgi9Z84Avy5vYhrecE72RGL6rvOglRBSo8jpEEpS6IlANoE5Nw1WswVO9D0o935Y1pXhrY1g99/U8OFfLvYn5I+/ItfT+HgHM9MKGVAOUdVJ036DU/AkNJ7OliLZwBB6yOD9sB0MUA3wvFM+PoPDlAC+rFdo+wnmXVT6JrtWk3obKZi9PmEWqJBdvzx++gT4yJWVBMbVmijLwHR3APXRcYbRS06TikbElGHecPtjf3vSf2LCfSxP8DLMrBlyqxvqRycYbd64qgEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Sz4S+7kmcLnQpy00PrzryFxhztmYTfb1VzXMSH2xkc=;
 b=Y4NJLZd6YSmmLu4/PKhewxrvR8VQjdz5JETB6o8X8yNEFNB7QdicjxPXgV0rPS3zcSlJbUw8EVbtT1v0alibXBmvTFc9BlEXwT+aWaHhlZa5q7N4lGdCKtYqd7rGjl/rwakfvUm21Q0SppLQIy+Xh+YqrLpDQf1OkzVn1YcwVMuLtW4LOsnr4JQf+4RvgRpL0+apOO4BElQy8j+PW2HUA0Yda7hlN09Z3yv6kxOWzcia9k8aK2x1bg/viiH9fn8s147ZwyQLdrEvuztVAS11XoSfWWqAziPx9dzl2hPeHRCevlEbGY+MUG1EQxfd/OOVOZGIpErGK8HZgM9gFkLHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2455.namprd15.prod.outlook.com (2603:10b6:a02:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 21:26:39 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.036; Tue, 23 Mar 2021
 21:26:39 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
Thread-Topic: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
Thread-Index: AQHXGqn3m2pRtlCATE6KZ0qUM3kt26qHp6sAgACBEACAAPZFAIABIw8AgAAwyYCAAAOcAIAACTCAgAD17gCAAAZrAIAABJ8AgAab7wCAAASLAA==
Date:   Tue, 23 Mar 2021 21:26:39 +0000
Message-ID: <9F55EE0A-3B60-46E8-B6AF-22259BD1B6D1@fb.com>
References: <CAM9d7ci=hfFjq3+XuBcCZ0TUJxv6AmdFk0dkHFQD3wx27aJMjA@mail.gmail.com>
 <YFH//FRPvrPswhld@kernel.org> <7D48A756-C253-48DE-B536-826314778404@fb.com>
 <YFPCul51MjrlY65P@krava> <388AF530-5176-4DB9-93C4-6C302432CE12@gmail.com>
 <3E65B60E-B120-4E1A-BAF2-2FAEF136A4CD@fb.com>
 <CAM9d7ch_axD_4E0W7MEx8ueeq9QsvhxNWaJ0J3AtVgeKqKQmbA@mail.gmail.com>
 <YFTEsOhbx4Il1nji@kernel.org>
 <CAM9d7cgoP28V_ONk2AJeu=Y7RQ8vzovzW=pGVYtERe97+ZH0Aw@mail.gmail.com>
 <EC00E37D-8587-4662-8E30-7AD5F874FA84@fb.com> <YFpZPijlMSyfIVbl@kernel.org>
In-Reply-To: <YFpZPijlMSyfIVbl@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:efc5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9247d8d4-5b0f-4fe5-0e60-08d8ee4258d1
x-ms-traffictypediagnostic: BYAPR15MB2455:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB24552DC66DCB4EFB6D9C1832B3649@BYAPR15MB2455.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YjMveRyAMjUdfpOrbdcD2iTjysBebEdWcAXSECwq4/3XogwZ5FbooUPZB1gcz7Y/tHQTt0JELombG+gXwMbtNxsTaPu16OB0PKSE9qHwD57N6MYO7MmbUnWsYH7wi0r5PW1ho4rmDbda1KQVUz7Y1/GLJ30DYg9//8tlNH+ML441c+Yism9cURsB2yE9VpCSJuGJ18SJmbkCq5SWLJ458YqxHNcesEc6PECC3RxWVHD/9x+fJccFc54KSG6tVrIEke2wq6U46Fu0KRAkuv1LmKp+cQVe8vlGr4psu1VLmCUsQj75ibmuYprBXxnpu/MZ7okhHhbQc4oulI5PhJcW0cF/xJy/BDUkIDB5pGtNihpTi+KPkjndRf82Ie1/HgLu9kNTHJN96SdpDnOFvUNgt6T7BV550vspYeS3OQ4b+d1Uk1M1/ypoypRQuv1gm5twPUdS6+2G9TPH+pGzDH52hxnDjqedN4saCEQoKAZfKf3VsSzucx5n7G+cFWaweoXCcxFdjKToUkznh9kQJ4dJc07zZkoEMaKwt6Q1LyJRCKP1iRqh9zA2Uz8KUk2VBXZrWuhT+XI6Cnjr33li0IADtz1j3luW8pewevldZx+WbsFL9Zn1ff2BNjMr1lFhKZ9yhOTfuRKD7dmd/kNDJGFHs13T3/CsrG6qM1hZDNJb7oc4z4CZjC9+BlHazffpTwyjmXaG9fagG5RFv9MZSWxZpstS695VDalFPD9MehHmFIpQpMXUSPQot1UMzLgfjYZ9wVcdBeTdIuH5cc6fA6cmQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(396003)(376002)(366004)(186003)(86362001)(33656002)(6506007)(6916009)(54906003)(83380400001)(4326008)(2616005)(5660300002)(8936002)(36756003)(53546011)(316002)(71200400001)(478600001)(66446008)(64756008)(66476007)(66946007)(38100700001)(6486002)(8676002)(66556008)(6512007)(966005)(76116006)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SGm5/J7WPM+Q4ntrBU9pu4kkBHY3lu1FxmyL7uuq1267JrhS+wK9JN52tYw8?=
 =?us-ascii?Q?crhjcMfi/FnXTnATmHtgaY7gH/85ep9Nvr3vQjTTg1uCtApIfP0kPuVVWnZ+?=
 =?us-ascii?Q?VAXXqAAh0pqBds650lIvnCu9yVIeRNU9dpWISjKXcyVFaYqsNMB8crnqdJBq?=
 =?us-ascii?Q?29o6UNGmV6pxwZw1Brl7Y9LFC214/QFE7RNR2WcglnC4Fc2rerS4SVH0P2yw?=
 =?us-ascii?Q?oXi93nWrBqVUWZ+dXlFCJn94IWEeFat0eL1myfSN8ctwILCEOvOiPo4YohrV?=
 =?us-ascii?Q?fXZS68vaJYfFwK6Wz16zW6XjWTWgzm8BwzMzVjoHDXxpWv4LEaIj/nM5LgTv?=
 =?us-ascii?Q?MOT8z8bb0VhYtrnGkWX8eBgp2V7+Zukwf9IraUj7kAe3HHjU5DyMuQhpSYlh?=
 =?us-ascii?Q?oGJ/Coi2CaPt/O77iMPK1yjJPidg4HjwveqbAu+xI8SKVPWnlD9BTcGvkb1f?=
 =?us-ascii?Q?qWo/CCF9Cf+rhMZpjJ9wgbGHMcryMgBYZyGoa8rmM5ZGQMwnDJEyfAFV5fdw?=
 =?us-ascii?Q?doszehf08LRWKtPA6hw14YYCtboAwr6q8Ag+W1Lmku5nYtQxR/lRpakApl0x?=
 =?us-ascii?Q?y+zSzte06LL27IU4+NXVrYeRZKiLeTpLGajL8XWnPv0sagLlmkkAoO1oTqw/?=
 =?us-ascii?Q?toUvs58pP70OKpXwT+q0xRsA3QSfg/wjv270ClUBXKUgtbVAluxzp4gRIhJl?=
 =?us-ascii?Q?HKQTPWUuxBSsT3VtUDj5/tMpGa+CxWTygZZYPG/PAHBSe72pDJYVb9yZRw9s?=
 =?us-ascii?Q?4D5qToBxWiGrsd8+KOzteAMkNxbv44e2IAcOi73xDgKK8my54laExkeVhWfu?=
 =?us-ascii?Q?1utw1TcU0sbkg+3UM1OM+30Q5dJZ3a9OUxzZBCJi6YfXmWyloPpOCdA7lEsq?=
 =?us-ascii?Q?Whp0fqCriuONyFtr8Hw+W14aVb41TFn0oZoWUZwNJciN+CB9aVwuGS0Yo2Gv?=
 =?us-ascii?Q?veLakyPUpaGOMew/7jWpDMbGTZEVu+y8+xJAdfMn5FDBs5XHj4pET15DVW+9?=
 =?us-ascii?Q?mWZyihaodNtoWZZLhKeFZjWwD9BHsKDoqynPsEGszKiKB0J2w/5VaLfDl4gV?=
 =?us-ascii?Q?P9exkgXsIVbGZG3/J0rL61mBypH/nvw7vpPCwiXYiNdyB+TYAuXKq/IKzzju?=
 =?us-ascii?Q?NSjeh7q/BtTSPKaSTWjqIL4WMcdcK5PxCxZUKLKfpSjGkOwVOsYga3MUUFl8?=
 =?us-ascii?Q?fqsJidaQmJau97merrflkzIdk8Y9/+KDpwVw1M0/6y8q8XQ3GLusY6nVAQ4T?=
 =?us-ascii?Q?b7SRJRqmcb9mWnGThbj913gy353ywX7iwU9xNTVmYm/j2sqBuRR5uJdyEt1/?=
 =?us-ascii?Q?K6rVoppa6aKNSzokwypZ5mSLRie6NuqzCoeSiDzd3TvNCFAPCfgT2noBUhKP?=
 =?us-ascii?Q?C1k4DVA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4CC1A55B4B02F944972EEEDCD82E503E@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9247d8d4-5b0f-4fe5-0e60-08d8ee4258d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 21:26:39.6314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fVyXIUWNqUbmJumjKo/4M+VYPwpXyea5p39anBA014ZFYcrlEkP7koOe4o8Dclomgb24StkfcpV1fi69uTceA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2455
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_11:2021-03-23,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230159
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 23, 2021, at 2:10 PM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> Em Fri, Mar 19, 2021 at 04:14:42PM +0000, Song Liu escreveu:
>>> On Mar 19, 2021, at 8:58 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>>> On Sat, Mar 20, 2021 at 12:35 AM Arnaldo Carvalho de Melo <acme@kernel.=
org> wrote:
>>>> Em Fri, Mar 19, 2021 at 09:54:59AM +0900, Namhyung Kim escreveu:
>>>>> On Fri, Mar 19, 2021 at 9:22 AM Song Liu <songliubraving@fb.com> wrot=
e:
>>>>>>> On Mar 18, 2021, at 5:09 PM, Arnaldo <arnaldo.melo@gmail.com> wrote:
>>>>>>> On March 18, 2021 6:14:34 PM GMT-03:00, Jiri Olsa <jolsa@redhat.com=
> wrote:
>>>>>>>> On Thu, Mar 18, 2021 at 03:52:51AM +0000, Song Liu wrote:
>>>>>>>>> perf stat -C 1,3,5                  107.063 [sec]
>>>>>>>>> perf stat -C 1,3,5 --bpf-counters   106.406 [sec]
>=20
>>>>>>>> I can't see why it's actualy faster than normal perf ;-)
>>>>>>>> would be worth to find out
>=20
>>>>>>> Isn't this all about contended cases?
>=20
>>>>>> Yeah, the normal perf is doing time multiplexing; while --bpf-counte=
rs
>>>>>> doesn't need it.
>=20
>>>>> Yep, so for uncontended cases, normal perf should be the same as the
>>>>> baseline (faster than the bperf).  But for contended cases, the bperf
>>>>> works faster.
>=20
>>>> The difference should be small enough that for people that use this in=
 a
>>>> machine where contention happens most of the time, setting a
>>>> ~/.perfconfig to use it by default should be advantageous, i.e. no need
>>>> to use --bpf-counters on the command line all the time.
>=20
>>>> So, Namhyung, can I take that as an Acked-by or a Reviewed-by? I'll ta=
ke
>>>> a look again now but I want to have this merged on perf/core so that I
>>>> can work on a new BPF SKEL to use this:
>=20
>>> I have a concern for the per cpu target, but it can be done later, so
>=20
>>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>=20
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=
=3Dtmp.bpf/bpf_perf_enable
>=20
>>> Interesting!  Actually I was thinking about the similar too. :)
>>=20
>> Hi Namhyung, Jiri, and Arnaldo,
>>=20
>> Thanks a lot for your kind review.=20
>>=20
>> Here is updated 3/3, where we use perf-bench instead of stressapptest.
>=20
> I had to apply this updated 3/3 manually, as there was some munging, its
> all now at:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=3Dt=
mp.perf/core
>=20
> Please take a look at the "Committer testing" section I added to the
> main patch, introducing bperf:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=
=3Dtmp.perf/core&id=3D7fac83aaf2eecc9e7e7b72da694c49bb4ce7fdfc
>=20
> And check if I made any mistake or if something else could be added.
>=20
> It'll move to perf/core after my set of automated tests finishes.

Thanks Arnaldo! Looks great!

Song


