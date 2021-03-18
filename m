Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C96A33FDEE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 04:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhCRDxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 23:53:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63616 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhCRDw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 23:52:58 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12I3ihpg011495;
        Wed, 17 Mar 2021 20:52:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Vd4SAFVdQ9XpBNvlHbxiObSNJlomZunvw8RdUkY7SIU=;
 b=muL2Ar1gdaO1G7CCEktwpfd2oUQJADp/isycdGDnCVzd0Qm3GkMGW5JVgL4PqYUnB/RM
 7IXB8YQ4p/WteR7thOyUotd7fn8DksrClzdokT44yixAf9iqkaNLnOUaQHIZ+qW1e1UG
 deSpz8y440mf9TLM61Fcc+5+wKzlMkkL/Ac= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37b3bs0qvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 17 Mar 2021 20:52:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 17 Mar 2021 20:52:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJAqn1EKRXwKZmfclj99UiCd/bw2zB1g8jApEZ08cihXG1EEJa4VLHNYSFGs17vghiVbcTp8MYodBrdPblYZb5ZEwtFuMQM0s0BvdBMtZ1Mb1ujCPRtBifQP9qGuBHOS7ARoeKb2DD8JELpf3tktP9JyRSlR/kq9RpeDuEcpeADCpaVhHuPburPqcM+o8z9JxZKGbJ5bvQ1fzUvZ/G5qJAU4WIFBzj1+cd/10axkek4ZmykBI6GkSYN5bZLKQp96VmOUaIh80Nsi6BLhKRkBZT3zvqV+MPSspf2uh9MnjFBxfvIto+9wZmBLBVUHm82BiDCl8tCk4JAmBgaJpB5TyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vd4SAFVdQ9XpBNvlHbxiObSNJlomZunvw8RdUkY7SIU=;
 b=OQSIsXVoFTsj7O5JE5MR9KmWmA4Sp+24qd4q7rFa4SaGjKhyjJk1ubTyHJcndZ4XjEVsYzAV+AQtWkYPEGrldePuXnpVgDLPqxKWJIl/MnVlr/U2pjFJ05iTH6gUp5JPbd3GTyku+24qIpdK+HogC2yXSczh0wHYmGG458BHoDW7kDHSdH6JpFk+/dTgcZctCxElfGYPDXvxUoO1mAzsgZyhK8iWs7YWm7/SbyX8ULqw118Dr1fvYYGGft3pk7eXyaqKHM7J4/yMVjozFiwDfLZQszLNzt6jMFmq7kJ+l+0IptzePplGSU39N9K4EknwuueonYDS8jXoiOgvihDAVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2405.namprd15.prod.outlook.com (2603:10b6:a02:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 03:52:51 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 03:52:51 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
Thread-Topic: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
Thread-Index: AQHXGqn3m2pRtlCATE6KZ0qUM3kt26qHp6sAgACBEACAAPZFAA==
Date:   Thu, 18 Mar 2021 03:52:51 +0000
Message-ID: <7D48A756-C253-48DE-B536-826314778404@fb.com>
References: <20210316211837.910506-1-songliubraving@fb.com>
 <CAM9d7ci=hfFjq3+XuBcCZ0TUJxv6AmdFk0dkHFQD3wx27aJMjA@mail.gmail.com>
 <YFH//FRPvrPswhld@kernel.org>
In-Reply-To: <YFH//FRPvrPswhld@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:591]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fd62e1e-9ee4-4a07-c221-08d8e9c14d9f
x-ms-traffictypediagnostic: BYAPR15MB2405:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2405A56F9BEEA727D6BFD418B3699@BYAPR15MB2405.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P6CE3WfvJ/kCUmjHHOuZOclpV4N3DY1z08LM6Cm+vZUHDkXDPLwclTdlsMb8spYLn06fPtcWYRdmk9YYyYrlQBlDm+1hPlCbPPdlZELEZkCMQhr96vItvPp+3A88ADA1K0/J6+PM7XpQsdnwyRfjfhCH1QOCIwFPl+Xutg9PPhvtS7jtZdJde7Sg6FFfl8eQItkjcoj6DItqAdMCqypIa15BshSOz8p5qTXC7vR5IIkN/NXZcIzjQsTVXCFbjrCATJ7LERoElO5wdQV+a0lrqsLYn4+tBkMdae2fpEGK/2LH2Ox28Ahjc2IkBcT5kVjg1sFbSveWDyz2O/q5GMIUHGv6B/jyECZepR7hISUhLaPHvDRFL3kBUZ851AF2ntWGUXURHWnfADw+Uj+29Z7E6UZ3mQkgbCYj5aDt2JPzpWiFfu5z9qCpr84VIazRwcklOuA4fxUNtRrfveSnjE3nOvg092GyZOGf01XVtF98kKopo+nVWTabJwASrmn7UZEaxKTTOA/oCy4EkyGGOZuY90iGCfs54Q0rRady59IDEZXNr1wOGAwiQ1TkCGWWTAihU1ABCSK75SvB8ihrBXh0wopoSj1T+BPVmH7Z/dU8RMFhU3JJRgFqfICHoiYW2KoNQs07itqyMzDCZCM6tcnmbvwQClX9RFoh4xR8lSEoVMo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(366004)(376002)(136003)(33656002)(8676002)(2906002)(478600001)(54906003)(64756008)(66946007)(76116006)(71200400001)(316002)(8936002)(83380400001)(91956017)(6916009)(4326008)(86362001)(6506007)(5660300002)(2616005)(186003)(66476007)(53546011)(36756003)(66446008)(66556008)(38100700001)(6512007)(6486002)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mlTmqo49wlZ/2xHNPooXk3tDCX/CGePQx+3ceIeljD4l/UgkLn5MTgZy1IDI?=
 =?us-ascii?Q?Vqn9xyuv+6VWt4cf70ytCjq+kECiRfFcoEbGLjmWS5v0De2wVpcZS/FgKAe/?=
 =?us-ascii?Q?46kRws1uni3c48FpBB5edwZvzLeSQyRKIIM+VP/hm00iGMvSrJVK+668Vdb8?=
 =?us-ascii?Q?t1jTt4dvjIDcRKxT0msF7byX7XrwH9L+iME9DorYhTYZu/AwbDV7zEWtP8YG?=
 =?us-ascii?Q?rqm+UIm1pYawdBshSh5oaymEPHiiI4/ccLZRrAR1Xk127dBEi/mIBKVVvv3M?=
 =?us-ascii?Q?HxHIoYhc1eaL2FkPUE93ImvJgKwuFQMvA/WU/gBEHMZ8+cV+CS04y87w7iCc?=
 =?us-ascii?Q?l46ye1DAwJsqVQ2fd3JMJPewa+jP1xGFUa7j190iIBSX2+oiNButVDfkj4J+?=
 =?us-ascii?Q?F2zuWrhoJovD4IRIUHCqbyA8oFO5y9KdEkW1u4i1ZAjHs2tlOtKXhx7nHr3s?=
 =?us-ascii?Q?g6X0abFtzgrEOe5NgpNCeTYafc4TNdlgfrLS1gjT3zAhoUQnb3+wl77DffJk?=
 =?us-ascii?Q?g8WZsYt8T3pBJHT/hVyK3thT2igXpvnxenRm7soa4EP08aD5EcpNIdjrNYbF?=
 =?us-ascii?Q?MEi5PRaI0Dg4osCDLIBYOs05Gyjc4whgqHW1GfjO8JYlsqxTwZqws7bpYAZ4?=
 =?us-ascii?Q?gPiQC2KKmloOo3Fd+sLvmc8P0TBOnClTbC/qMgVhFqGhIN22iwDye8KdXRoy?=
 =?us-ascii?Q?XybgXikXUWHc99pmCBqHhZA3sZqrMXvgpRh4P1vjrDQpufHSrsATqnlPSwmS?=
 =?us-ascii?Q?1GggoNCX2BjFSzv/2xxYII3J5UroHXY/Dwi6EvbL+VxPRE+Jw29X3yZqe9Hw?=
 =?us-ascii?Q?pmg/0qJu8TemRwF9eHCnrVV4HHnwRLlLoeSSSoNeNSo9oNQifBbqZ4/CJQjb?=
 =?us-ascii?Q?+AE8xHl+RbPGULRQcUD6f4ERThaVF8+sSsaTXY85sdna1ALA/iZhaKFKep8Q?=
 =?us-ascii?Q?o2gzzLNp4fXNmVmVAA3u8y/9G57HsNbVZHWxsCkMNSeRtzLM6YfbokOQ/pox?=
 =?us-ascii?Q?3Oc1lc5LlQNUGfjhQ52A2WFsBiUxSP4w1Na1xN19ecVgKgcBpPVXczxUa/kx?=
 =?us-ascii?Q?QZ8Y5kNgs7gK4nIbI+0e7FVRnx9VckJBW6qV9tmlG7sKoxCcxQfWakR5OlVn?=
 =?us-ascii?Q?C2GylIEcs9SHc64aLnNKFI23TqNdg4bRlDfn+JmTXgvdGH35iB2Bik+d+OpY?=
 =?us-ascii?Q?uZyH33tmvHEo6tEGoRhoAvxA2urwMznPClkTr9UBLN8mW2YfrR3I9HPf+3Ii?=
 =?us-ascii?Q?SJB+CgiYIU7VpCwL2VTUBBBM0+L99JgVhWiY3x3DMRISIIIwlKMJ6eB6Ythy?=
 =?us-ascii?Q?CppqKj7f7BoHCpM4Ol/m5agExT+NpaFsZVFniuq/DHRUtRq3mawN0fUYfHxA?=
 =?us-ascii?Q?m+B0y1I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D6E86289470C1140B35F0A8A9A01A299@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd62e1e-9ee4-4a07-c221-08d8e9c14d9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 03:52:51.1981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sDFgBVGcuCCQRVjthtEIuoCq8wMayuTPEiIWWRSeGgMEQX0SchnpFdHs/0ZvpODiuQazWof7Rpfh+VVZZNYs3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2405
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_01:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103180028
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 17, 2021, at 6:11 AM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> Em Wed, Mar 17, 2021 at 02:29:28PM +0900, Namhyung Kim escreveu:
>> Hi Song,
>>=20
>> On Wed, Mar 17, 2021 at 6:18 AM Song Liu <songliubraving@fb.com> wrote:
>>>=20
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
>>=20
>> Right, it'd be really helpful when the PMCs are frequently or mostly sha=
red.
>> But it'd also increase the overhead for uncontended cases as BPF program=
s
>> need to run on every context switch.  Depending on the workload, it may
>> cause a non-negligible performance impact.  So users should be aware of =
it.
>=20
> Would be interesting to, humm, measure both cases to have a firm number
> of the impact, how many instructions are added when sharing using
> --bpf-counters?
>=20
> I.e. compare the "expensive time multiplexing of events" with its
> avoidance by using --bpf-counters.
>=20
> Song, have you perfmormed such measurements?

I have got some measurements with perf-bench-sched-messaging:

The system: x86_64 with 23 cores (46 HT)

The perf-stat command:
perf stat -e cycles,cycles,instructions,instructions,ref-cycles,ref-cycles =
<target, etc.>

The benchmark command and output:
./perf bench sched messaging -g 40 -l 50000 -t
# Running 'sched/messaging' benchmark:
# 20 sender and receiver threads per group
# 40 groups =3D=3D 1600 threads run
     Total time: 10X.XXX [sec]


I use the "Total time" as measurement, so smaller number is better.=20

For each condition, I run the command 5 times, and took the median of=20
"Total time".=20

Baseline (no perf-stat)			104.873 [sec]
# global
perf stat -a				107.887 [sec]
perf stat -a --bpf-counters		106.071 [sec]
# per task
perf stat 				106.314 [sec]
perf stat --bpf-counters 		105.965 [sec]
# per cpu
perf stat -C 1,3,5 			107.063 [sec]
perf stat -C 1,3,5 --bpf-counters 	106.406 [sec]

From the data, --bpf-counters is slightly better than the regular event
for all targets. I noticed that the results are not very stable. There=20
are a couple 108.xx runs in some of the conditions (w/ and w/o=20
--bpf-counters).


I also measured the average runtime of the BPF programs, with=20

	sysctl kernel.bpf_stats_enabled=3D1

For each event, if we have one leader and two followers, the total run=20
time is about 340ns. IOW, 340ns for two perf-stat reading instructions,=20
340ns for two perf-stat reading cycles, etc.=20

Thanks,
Song=
