Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4432358BED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhDHSIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:08:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48818 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232604AbhDHSIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:08:43 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138I4rX5017212;
        Thu, 8 Apr 2021 11:08:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=jDqx86gv9F4y76q1yGIb4f8VhQji7UIvhXZlfdlBUzw=;
 b=D+sUuxFlypbFa5Fb5TDH/2tO3+wnNB/MbSCqJUih+CJvtJJUADzMmRqlIU5Q/M8hg3mp
 lWMCuXBygjs3p5sDDi3fufpujnnZpoJ2AVkDIKIv+itab8BQf2IumaSbPHEYEIQAp40E
 XE/PSh4TVA6IyeK/gFQCkYX7dErf+LL277c= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37t1hnabfy-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 08 Apr 2021 11:08:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 8 Apr 2021 11:08:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSdu1Hg4zuqK+WPMByGFhUxlW5+1sqUM9fkbkYMcQVHXRhnce6a1aYmfvZIoqAHAe0//9trNm3vt7cA8U72UvUVAqjaOgouwyzAIwqwWihNTsQlXG7ILZqlMw3KEZkc4AeGcHNkxIkQnsfp2Sbk4hB98q0/MOpRRcVYflaf+Z6UVjYzY8XuS5Bhb058vyF4PXZxeXQrjrPjN9bwtXipPzABYJ9BRVTrbhfx5onIir8jEGIHKSuTVcWpAtp7uTbp3YqL3QWs3Lt/BF8Z71438OpNHycGWigdNv7oll+Ei1oJSV62t1Pxy8G6rCIEsAdiYACJMP6npz6IAlUYy7mWcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDqx86gv9F4y76q1yGIb4f8VhQji7UIvhXZlfdlBUzw=;
 b=ixy2uWF1XTF8pspj4B00kqM7vIjBPueu5UdgjL+gmVjeX5DDC7Rxc8jGs8rMdoHbeXzKFOsZ56ZkaD5T89jrt4YRyKYOF/QFDn34Zx22fzP4Rr6r8rdqFFEi+b1yfuC4B1jHV93MhM/deFxFbo3Lq10bOQp+mnmrhbWZV/U3ZjtZJySm1Inkw3eFQu1EXFVhCSwkqkZLTl1MAjk1q4cUClqSt5hAYKTDbn5Z3q9/S0CAil4l0M8I2rtgDW4wj5jBcmL1aTIl5tQciV2pQdBRWmYcKXRQL63+YoOGPmwEjln9mDooOKl/uProAmgt1rBSaH7ukxlM6ARwr5O0CfiHlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB4248.namprd15.prod.outlook.com (2603:10b6:a03:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 8 Apr
 2021 18:08:21 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.039; Thu, 8 Apr 2021
 18:08:21 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Song Liu <song@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v2 3/3] perf-stat: introduce config
 stat.bpf-counter-events
Thread-Topic: [PATCH v2 3/3] perf-stat: introduce config
 stat.bpf-counter-events
Thread-Index: AQHXK0YG4LdD7IbPc0ehmtAjm2+fxaqqg16AgABRlYCAAAtnAIAAAjCAgAAEzwCAAAZpgA==
Date:   Thu, 8 Apr 2021 18:08:20 +0000
Message-ID: <FDBEC7CA-7F74-4494-93B3-7E5758E5DED9@fb.com>
References: <20210407003601.619158-1-song@kernel.org>
 <20210407003601.619158-4-song@kernel.org> <YG7tU/mVxQZLNCYL@krava>
 <FA667178-09F3-48C5-891C-9E44744276C0@fb.com> <YG87VLdSrhG0xSDj@krava>
 <0106D99A-5CBB-4CC4-B6F5-1B795E9B8274@fb.com> <YG9BMss16qFOjhos@krava>
In-Reply-To: <YG9BMss16qFOjhos@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:57e2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b71f512-6ea9-4ec6-5adc-08d8fab94b2d
x-ms-traffictypediagnostic: BYAPR15MB4248:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB4248424E21360EA1CB0F076DB3749@BYAPR15MB4248.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ul8TDaWBdS2cK9fzOTY884wLJ/srxQmsf254Wl0LMkkoRrRBACrJquv2J6pgKOSULgKAKhkYFgDzhoJfdpb90TX9JjCqnliGBb0BKMSDlN1i+fuRa34haQoDDn1ESbXJsvfYXOncb+Ll0cn/bVbsnpxDA+VIikW2YAcR9+vBy5JL4Mwbw5XKvzQkZEtlOp8Ey1CqVcd27hQRwj0Xbl8tL3tR4M5BofaO4XQJFYVBzHOsO/Av28XqyM1S0+YZTzzyND90enSFR+ddDH5IxbCGXOu6gLFPqdHKSu+9kL0hRVYaw7+qyfQuZEINv8GWL/2bDy43Dh8BypEq1FOIb/6E1PtviT0jisGk09s54oCNmaINlDQkzq0ZuHy/wSO7nu8PG4z4ywaaqQ0S4SR6Cc0T3ohf0Ig1Q6dAO9Gk61sVHzNgxiNc71ZvpFA3YnvNjARvg/jKz9ykew7C1oGeevYfgj+7EUdA/0knlNAoDfuk19kLA09to+NPo9/FYJ7eTZ/zmkUTamkbyEb9nUXVXLFdTfQ9CO+wQDLBAUM1BzQ/31pxRVU0590pnGGHBN9Pdtb8j+7GGiSAJ+2v0I/c3lW1RU11ReYXnuR3tNfx/or7FE8ESABSP58LlV6tnE7wX6IUWmIVA88u2ch3L9QBCmHXo/ucaZiBgwExL4aFcK2WK8EOCEpbnpvD8ttSDcilX2Jq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(136003)(39860400002)(6916009)(316002)(6486002)(71200400001)(64756008)(86362001)(6512007)(66556008)(54906003)(33656002)(6506007)(38100700001)(8676002)(5660300002)(66476007)(66946007)(186003)(8936002)(478600001)(91956017)(2906002)(36756003)(83380400001)(53546011)(4326008)(2616005)(76116006)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Y/GQ7kJESz7hMVhP9pgpvCjTxfNe9s31kkiRA8LLdmhSc7BrypQAFRmn1Maq?=
 =?us-ascii?Q?BsOzlb3ULYG3UkiM44dk4A98fW/gtkCbZWaY6HKq3lZ30jK0SieyIvFOPElk?=
 =?us-ascii?Q?MU6ARrU8G86CdWDSBy5tyoHpS1UOHbUQ2RH6qXRi0jqpBP249qiEvjtbWEu7?=
 =?us-ascii?Q?D9xMlwImtLF//pz48yHmhQMvxZtFot5aqk8A2tXDfkqMdGew35pRkPn/Yuuj?=
 =?us-ascii?Q?UUljXn6r1u0Ck98jdBqOjsAKlEMh9ocAopVbXF8cI0E3CG8YTD+sf8+JdYgU?=
 =?us-ascii?Q?zFDSJRhE+fSJa6qST4BbTv2xad9QUySoXm2l/6prnsXLzWlM3WoLSDjmBxPJ?=
 =?us-ascii?Q?bRByXuAnLHa821qd4q8X/Yz3bJzkJdvyg+qfjnGlUlFMOKYfx+jAIaDor0tx?=
 =?us-ascii?Q?zbaRVOP6Zm70/Bw3jjG6d+HGkZfpDnfLeYx4hHpLydCdY4e6UZiMrdnbp4T0?=
 =?us-ascii?Q?C3FLqHrgW2YdB0jfciMnyMo1FCfDGEhHKFqD3ziFHA874sWd0byDeCH3S8Ww?=
 =?us-ascii?Q?KSn+WERlGJ125wu7yjwdkJAQ3QuLtxQy4KQt0B6meyiEKCa80z+y6Jg+Ly5Q?=
 =?us-ascii?Q?mJbpIA83oJMjFZn63BUqFtI21RKZQ/9IjDE8yoD49m0lDP/971eBO3CyA34Z?=
 =?us-ascii?Q?TN+tFVM4zmilT0rn7KGyEH1dWpkP/bEMVzi/7ZbPpNd0zGXNpEduyeOPIBn2?=
 =?us-ascii?Q?8mKr9JXoq9v1HshVUy5N/+x+UyjIdsvRCUOhzFsXBcdISW3vyrP6hkLBNWw5?=
 =?us-ascii?Q?lekFDt7g0vuU4pHxPTwfR9YcLTXmZjjfAQcxhh6O2jZy1f6ww/9e2ddNhcTe?=
 =?us-ascii?Q?We4zhZOAJDiiW/jvusateV/WDn/E37inwrtM7rxYTODm1k2gp+GM9oullu/f?=
 =?us-ascii?Q?SM+AVrk94xno4ToleS+wMxzG/SDD/EIHzuwNW5ZROJFpJTSxdEzoideWHDzd?=
 =?us-ascii?Q?tKdpt1SOKFweLdxL/NiAhThn2drTqCQZiB6WMUqPLTeL4naTjQEJgOuRI3uI?=
 =?us-ascii?Q?AlqqW9sfmPYG/RHWwcUyc5VHKjoFLqTgBPbSHbLbSKBZlQRS/Urlt9qOo9WM?=
 =?us-ascii?Q?T/usn71Q09VqLGinpx3GFX4zu2XYjed8N4NQG6qDkbJ2Zir+97gMT6N5OUOP?=
 =?us-ascii?Q?NvMA7aIZuadSyxqhYInV/IxQIjfeM77AuwpC//80kNjBKo3DcqLWDLuPMUK2?=
 =?us-ascii?Q?i2NxYrSN60PBlY1zaz3nD5H9bosFCPpwARJZike3fAOdXadXlB/prhUfz2mR?=
 =?us-ascii?Q?Tv3S0ZdcW3+tl+KnPqG8DfaElLYm0sGf3bgOofrQuB0+AbazvG9YSX++XcGX?=
 =?us-ascii?Q?k9EW5Iw1JKk7ce8n4/bMZnrbynahqHcR6jWigDESexSjUWTtV2kU45SH+0rw?=
 =?us-ascii?Q?G3BwJqY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4722273CE1F7AC4AA028C7FDF79AEB18@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b71f512-6ea9-4ec6-5adc-08d8fab94b2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 18:08:20.9023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esl02lgD62XWZjyizRIRtqDvRT5Cvf2dkdFBcnSpRUxUHe3Kf4ESK1V8Ad/rnlADvVAD+bpWF5BTlV88UWVQoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4248
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: yUpvKsPZ0MLBhP-twyQsN8BM5l6Lfic4
X-Proofpoint-ORIG-GUID: yUpvKsPZ0MLBhP-twyQsN8BM5l6Lfic4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_04:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 8, 2021, at 10:45 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Thu, Apr 08, 2021 at 05:28:10PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Apr 8, 2021, at 10:20 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>=20
>>> On Thu, Apr 08, 2021 at 04:39:33PM +0000, Song Liu wrote:
>>>>=20
>>>>=20
>>>>> On Apr 8, 2021, at 4:47 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>>>=20
>>>>> On Tue, Apr 06, 2021 at 05:36:01PM -0700, Song Liu wrote:
>>>>>> Currently, to use BPF to aggregate perf event counters, the user use=
s
>>>>>> --bpf-counters option. Enable "use bpf by default" events with a con=
fig
>>>>>> option, stat.bpf-counter-events. This is limited to hardware events =
in
>>>>>> evsel__hw_names.
>>>>>>=20
>>>>>> This also enables mixed BPF event and regular event in the same sess=
sion.
>>>>>> For example:
>>>>>>=20
>>>>>> perf config stat.bpf-counter-events=3Dinstructions
>>>>>> perf stat -e instructions,cs
>>>>>>=20
>>>>>=20
>>>>> so if we are mixing events now, how about uing modifier for bpf count=
ers,
>>>>> instead of configuring .perfconfig list we could use:
>>>>>=20
>>>>> perf stat -e instructions:b,cs
>>>>>=20
>>>>> thoughts?
>>>>>=20
>>>>> the change below adds 'b' modifier and sets 'evsel::bpf_counter',
>>>>> feel free to use it
>>>>=20
>>>> I think we will need both 'b' modifier and .perfconfig configuration.=
=20
>>>> For systems with BPF-managed perf events running in the background,=20
>>>=20
>>> hum, I'm not sure I understand what that means.. you mean there
>>> are tools that run perf stat so you don't want to change them?
>>=20
>> We have tools that do perf_event_open(). I will change them to use=20
>> BPF managed perf events for "cycles" and "instructions". Since these=20
>> tools are running 24/7, perf-stat on the system should use BPF managed
>> "cycles" and "instructions" by default.=20
>=20
> well if you are already changing the tools why not change them to add
> modifier.. but I don't mind adding that .perfconfig stuff if you need
> that

The tools I mentioned here don't use perf-stat, they just use=20
perf_event_open() and read the perf events fds. We want a config to make
"cycles" to use BPF by default, so that when the user (not these tools)
runs perf-stat, it will share PMCs with those events by default.=20

>=20
>>=20
>>>=20
>>>> .perfconfig makes sure perf-stat sessions will share PMCs with these=20
>>>> background monitoring tools. 'b' modifier, on the other hand, is usefu=
l
>>>> when the user knows there is opportunity to share the PMCs.=20
>>>>=20
>>>> Does this make sense?=20
>>>=20
>>> if there's reason for that then sure.. but let's not limit that just
>>> on HARDWARE events only.. there are RAW events with the same demand
>>> for this feature.. why don't we let user define any event for this?
>>=20
>> I haven't found a good way to config RAW events. I guess RAW events=20
>> could use 'b' modifier?=20
> any event uing the pmu notation like cpu/instructions/

Can we do something like "perf config stat.bpf-counter-events=3Dcpu/*" mean=
s=20
all "cpu/xx" events use BPF by default?

Thanks,
Song

>=20
> we can allow any event to be BPF-managed, right? IIUC we don't care,
> the code will work with any event

Yes, the code works with any event. =
