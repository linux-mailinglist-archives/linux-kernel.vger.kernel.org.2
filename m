Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9160D358D97
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhDHTmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:42:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36656 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231843AbhDHTmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:42:12 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138JbuiD012102;
        Thu, 8 Apr 2021 12:41:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=vgmyflLI1BLJkT5uaf3UM1cTN5aq5jlIHAYuCvf9bps=;
 b=ANaT3sQxYsGwvXftcoN4Wm7/PHudYMEMq/5PgE8zXWn/+uJf27BfnNYpmBAWiRKzb1MR
 wIV79Fj5XizK0+jRLbAtxoyfkdUB/+47hJpcKUnDboU5teBTlnLRmM15VXnk4WiQokMm
 Brwde4dQNGaKrmm7WdFvsFlVCBVNLTHJ8p4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37t81w82rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 08 Apr 2021 12:41:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 8 Apr 2021 12:41:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mserPy2nrzyyIzoSSrNjrU68CUCJ6PRGXzOFfhdHvwBWAw0etvMQ2qtSRv2EmEUnlzrou+NXQPREfCP9EJMzQlTJDqeIffkg45vjw0Y4rR8y+4ofCj2nZyXiTBJZNVE+JXOOySobf1EGOMl+Yt77prF/uHBYwXHbKJrE4vafsrnjSza9pSCDUBUBSY0yai/ILe57kOC7LbfBw9o/j+Y3pbECYbU7iXJD5QCKuv6a7wibwKW+qide8ahnee0TmuosskpmxRTpohU4v/+0nfLdcAOX1Er8ed6wQ5QowcWvLG+Zb/bkf7P8+9vDtk0hwESEP2pFzPbPmjZ/u+sa/wYYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgmyflLI1BLJkT5uaf3UM1cTN5aq5jlIHAYuCvf9bps=;
 b=Vbt0oVH0X7VhQ59ul5XxBeQXo3QD4EK3VlpcaXL+eoJdlVNUlDrV1mJMk04liO+MuMc42fUS/PHGOccrEeIep91QN5ueM/4/6X7b3uIk4kRcarHfnnSKh0GaxbR/0WV/HbKnTqcbEgSKbuz/uh9iQZQfWeP59sSXr1wTI4ldcpNoc8ssDayyZxF5NZg+ulpu6E4Wj8sph6jHBZ309d/NtkATtF9QaQ5pgscB/I7VEJIcWA0tKhp7THrJeu2GTa854CW+9IMka8l5Shnu3uzJz9s0gz5v9bqWZgmUlLcT3KQ3JDqmJkPr/rhn0uQAhiodfveACm5X1YUOecBSm6zeTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2647.namprd15.prod.outlook.com (2603:10b6:a03:153::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 8 Apr
 2021 19:41:52 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.039; Thu, 8 Apr 2021
 19:41:51 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     Jiri Olsa <jolsa@redhat.com>, Song Liu <song@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v2 3/3] perf-stat: introduce config
 stat.bpf-counter-events
Thread-Topic: [PATCH v2 3/3] perf-stat: introduce config
 stat.bpf-counter-events
Thread-Index: AQHXK0YG4LdD7IbPc0ehmtAjm2+fxaqqg16AgABRlYCAAAtnAIAAAjCAgAAEzwCAAAZpgIAABJqAgAAHGgCAAA5tAA==
Date:   Thu, 8 Apr 2021 19:41:51 +0000
Message-ID: <812857B3-D69F-4016-B419-DDD9786C6F40@fb.com>
References: <20210407003601.619158-1-song@kernel.org>
 <20210407003601.619158-4-song@kernel.org> <YG7tU/mVxQZLNCYL@krava>
 <FA667178-09F3-48C5-891C-9E44744276C0@fb.com> <YG87VLdSrhG0xSDj@krava>
 <0106D99A-5CBB-4CC4-B6F5-1B795E9B8274@fb.com> <YG9BMss16qFOjhos@krava>
 <FDBEC7CA-7F74-4494-93B3-7E5758E5DED9@fb.com> <YG9Kb9izJhQlth3X@krava>
 <20210408185012.GA15560@redhat.com>
In-Reply-To: <20210408185012.GA15560@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:57e2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1559856-8728-463e-24d9-08d8fac65b90
x-ms-traffictypediagnostic: BYAPR15MB2647:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2647901A1E7671D2D1E03113B3749@BYAPR15MB2647.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zbsxuk54nTTy6IYkBDlWLF6r7vlRUMcKhdeO4oUM5XYlEtrdXKvvoxgOHA/01LUVg28Fdk8NMHKsnJYL0jRqcIGSw5y9fR+I/TXCViIYMGzwktDbfROFDjJuXa1jnLd4unYKAmRcLJcyaqMa56sVyh7eL3uc1Tlyz6U49Wx6UWdIVWKVkEWlf7epklqFfvGP5ueMiPT7CB2v4i/A2J/v+4tWDN573dH385NFta8+0bEWyuxuR4cA4MzH7eYdPavnFuSIGxBT2lV+BsGRhB96ddoCkjUEnCay4nciCRkfU36ENMnnddBgClA0ns6+qGkhIjorY5sSZYZWQJD6swrx9CC6EN1lNgqeSAl9AFq0uQaLGTeLWBPnGuVkuY44xYtJBYWYr76KwUyXBPYo2e7PxEM51DSL5tySD8mUTP+ecUX7u56dp0O+I5UvbpqRxffWPhbM7J7+Ozhec3/MD7W09B/JX+C0ndVzjyeGDAH0nopRZBXp72Vs0VMupqMndtuHjPZaxLW4rtyTLHDSmtjn8iRgO5g2GpFFPe235w2CFJN0IHjpbMC+IdpqJl+bYib+5eW+A8x5fDBZaljZ22H6OVBV5GXi23cEc1r6aKfgGDZGuQUlWDtaNWEK4yR3nvdZ6lY4BqWWcvQQatccZqxxOmydwpFZT56TvglGWLlMDYOMDE8ZtTLEJRLVn3aTnEO1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(396003)(346002)(39860400002)(71200400001)(38100700001)(53546011)(36756003)(91956017)(54906003)(6506007)(316002)(8936002)(6512007)(76116006)(186003)(66946007)(66556008)(6486002)(33656002)(8676002)(2906002)(66446008)(64756008)(66476007)(2616005)(4326008)(6916009)(83380400001)(5660300002)(86362001)(478600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?py/loVAaQhd23WAM0p9lYk7zBKNnbWAJPmutEfM9NfkgH/Xuh8kCRJET8Aib?=
 =?us-ascii?Q?p76Hd8I7NxzjOlflVILFfOF5MEye0FTCZHsHwrvUEA3YIhIsefYH4Zca4dTh?=
 =?us-ascii?Q?vaGe/T52T2oPMPPjfmtisEeYSH16izKEmH+yNEWyYytBXCOP1sztYzyqn2AV?=
 =?us-ascii?Q?GYOQLT5b/2n1hVEDMDsUzp63XZBOy0eQYyZxVuHZ/bCcmpwcCrK4OlA18pXO?=
 =?us-ascii?Q?u+gzdG1LT9LYZSbcrNeWqOuLivjG70qNcoj1ftKSHqY/ND2iHhmsvGZADOvd?=
 =?us-ascii?Q?SjRwP0SDvMhIQLXbsvDcBFln7rXw7FBbbo8UnxEZowDVGAaNkoiG/OUPSPVR?=
 =?us-ascii?Q?bZ58YmVNTlE/e5dw/zXEXLV6AkdQ4Dd+vRdccKcCTl1f6V1YtnHbBYIY05gX?=
 =?us-ascii?Q?avZdo8gA6gmlxEXdGYuZ1AGre5jGeYU+5Z4F2Bw46uGyQVCCe9zYCZOyUZyU?=
 =?us-ascii?Q?0gAaL5YfraVvn+0D1mZoXoxqg1mlBwJD6ToHW5zswzPqkiTBbf9jGqNlCllj?=
 =?us-ascii?Q?KU4IWQ/LzALvlQMBeAeWQ2pLy8ByLTyqULkdk6cZD//oikUityAJvzY18aWE?=
 =?us-ascii?Q?hbSfkkbqqmGhQr0n6P9Q5Zb399Gmw6NY3Btzfez24UiCFqu8pSGQV2Mhp7px?=
 =?us-ascii?Q?dlcBGVAZpQuHq/4dDfa/22cuL6E0KeNiYkuQ8SJIjon6N3FVMNwsNZWuwwJm?=
 =?us-ascii?Q?po5sd23l1Gy0J1DnC6SBmcyhjwmRbdVQanwv3a+yq6dFSufDgxyddza2tg56?=
 =?us-ascii?Q?ruE9it3S3M7u6zTqVI7FCEs2nwiB+zx6okDpS+q9aoU7tB5M3llTzdU0hSiV?=
 =?us-ascii?Q?wOdVV9+2Z4HCOcH5ukSQFyYIBPCzYNhTj3T7hqsJuMpXoeUqG+d/CVbnqB3F?=
 =?us-ascii?Q?h15UAjBSr88LZYyC6sw7J4khQ+nqvtbhw7InhTpkRr5mrXicyeLnEree+jo/?=
 =?us-ascii?Q?qKtszoUhevo/+XNzlZNO6TozC0uLbUhlStBbwdZ5LN5ZDt+OzaehKcd4aDMr?=
 =?us-ascii?Q?6c3UJKGU5Bcdv+rIvwyAWV3kSClxIZb/H/s7/ikkdD/KpC21+9N50OvcYux1?=
 =?us-ascii?Q?Zbvz0/Aa1B/eMQA6h7GFK8qe9Ws+0iV91O2kSXu7q4b+hyxbvoJddFJq+lKI?=
 =?us-ascii?Q?NnKF78Gt45SgtSMyATFRTNqS7/CE46gSSwd0XSMttKxBzqfmwnd+YIvDxjzL?=
 =?us-ascii?Q?+pCg1XeH2JmDkB3ZTmrJ5NamKQ1+USTbzcQlRL3EXeBa8tBIqCPQ7ApjpDUu?=
 =?us-ascii?Q?0o0+gPi/Lbnb+hil7tkI4Iqw414DfQg6lIBlzOaIlRvLE6TRnHfD8QxuqsD5?=
 =?us-ascii?Q?j78lNLJbGLZyLpWSxKheVAAqKuKQulmuSuHAkAe39A0l5vyvnRhdqtzfce5P?=
 =?us-ascii?Q?K/cIyS4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D6E12B73BF6684478FB58D915C5E9694@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1559856-8728-463e-24d9-08d8fac65b90
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 19:41:51.8187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbfADMOrgJCYwIwhBodQtrnWWp28gK67w37lqK3aFOCgYIojrDhPp8cFjZFOGVV02+QT1Y6evAUjQMirG0uVVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2647
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: InEcYgmrniqJ26O7ppBhiokvkI21YC5l
X-Proofpoint-GUID: InEcYgmrniqJ26O7ppBhiokvkI21YC5l
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_04:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 adultscore=0 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 8, 2021, at 11:50 AM, Arnaldo Carvalho de Melo <acme@redhat.com> w=
rote:
>=20
> Em Thu, Apr 08, 2021 at 08:24:47PM +0200, Jiri Olsa escreveu:
>> On Thu, Apr 08, 2021 at 06:08:20PM +0000, Song Liu wrote:
>>>=20
>>>=20
>>>> On Apr 8, 2021, at 10:45 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>>=20
>>>> On Thu, Apr 08, 2021 at 05:28:10PM +0000, Song Liu wrote:
>>>>>=20
>>>>>=20
>>>>>> On Apr 8, 2021, at 10:20 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>>>>=20
>>>>>> On Thu, Apr 08, 2021 at 04:39:33PM +0000, Song Liu wrote:
>>>>>>>=20
>>>>>>>=20
>>>>>>>> On Apr 8, 2021, at 4:47 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>>>>>>=20
>>>>>>>> On Tue, Apr 06, 2021 at 05:36:01PM -0700, Song Liu wrote:
>>>>>>>>> Currently, to use BPF to aggregate perf event counters, the user =
uses
>>>>>>>>> --bpf-counters option. Enable "use bpf by default" events with a =
config
>>>>>>>>> option, stat.bpf-counter-events. This is limited to hardware even=
ts in
>>>>>>>>> evsel__hw_names.
>>>>>>>>>=20
>>>>>>>>> This also enables mixed BPF event and regular event in the same s=
esssion.
>>>>>>>>> For example:
>>>>>>>>>=20
>>>>>>>>> perf config stat.bpf-counter-events=3Dinstructions
>>>>>>>>> perf stat -e instructions,cs
>>>>>>>>>=20
>>>>>>>>=20
>>>>>>>> so if we are mixing events now, how about uing modifier for bpf co=
unters,
>>>>>>>> instead of configuring .perfconfig list we could use:
>>>>>>>>=20
>>>>>>>> perf stat -e instructions:b,cs
>>>>>>>>=20
>>>>>>>> thoughts?
>>>>>>>>=20
>>>>>>>> the change below adds 'b' modifier and sets 'evsel::bpf_counter',
>>>>>>>> feel free to use it
>>>>>>>=20
>>>>>>> I think we will need both 'b' modifier and .perfconfig configuratio=
n.=20
>>>>>>> For systems with BPF-managed perf events running in the background,=
=20
>>>>>>=20
>>>>>> hum, I'm not sure I understand what that means.. you mean there
>>>>>> are tools that run perf stat so you don't want to change them?
>>>>>=20
>>>>> We have tools that do perf_event_open(). I will change them to use=20
>>>>> BPF managed perf events for "cycles" and "instructions". Since these=
=20
>>>>> tools are running 24/7, perf-stat on the system should use BPF manage=
d
>>>>> "cycles" and "instructions" by default.=20
>>>>=20
>>>> well if you are already changing the tools why not change them to add
>>>> modifier.. but I don't mind adding that .perfconfig stuff if you need
>>>> that
>>>=20
>>> The tools I mentioned here don't use perf-stat, they just use=20
>>> perf_event_open() and read the perf events fds. We want a config to mak=
e
>>=20
>> just curious, how those tools use perf_event_open?
>=20
> I.e. do they use tools/lib/perf/? :-)

Not right now. I do hope we can eventually let them use libperf. But I=20
haven't figured out the best path forward.=20

>=20
> I guess they will use it now for getting that "struct perf_event_attr_map=
_entry" and
> the map name define.
>=20
>>> "cycles" to use BPF by default, so that when the user (not these tools)
>>> runs perf-stat, it will share PMCs with those events by default.=20
>=20
>> I'm sorry but I still don't see the usecase.. if you need to change both=
 tools,
>> you can change them to use bpf-managed event, why bother with the list?
>=20
> He wants users not to bother if they are using bpf based counters, this w=
ill happen
> automagically after they set their ~/.perfconfig with some command line S=
ong provides.
>=20
> Then they will be using bpf counters that won't get exclusive access to t=
hose
> scarce counters, the tooling they are using will use bpf-counters and all=
 will
> be well.
>=20
> Right Song?

Yes, exactly. The config automatically switches ad-hoc perf-stat runs (for =
debug,=20
performance tuning, etc.) to bpf managed counters.=20

Thanks,
Song

