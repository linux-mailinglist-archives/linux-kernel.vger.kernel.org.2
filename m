Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2B5355E20
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 23:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343704AbhDFVqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 17:46:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4472 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243052AbhDFVqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 17:46:50 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 136LkIdh018250;
        Tue, 6 Apr 2021 14:46:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=I8wEWbC961zUJ7CVf5b6PAPiR0lunnPLvu7W1AyJAT0=;
 b=kccZue7zsHYFGX08NWwz+WmaLmBxce8rg+5upt/SLp5+7m8GbQqN1AMCjnKSI8pTQ8Ry
 fKMgZV4hQYXJbbjpvYc+w+eGvGA/4kzoXwgrWuTwUGWkw23wwQV4hYU8Wz/q1BGJyz4M
 DE1KjWge1yINnoNMXuAmCCMOHnXSvwbyd4I= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 37rvdrhg2h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 06 Apr 2021 14:46:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Apr 2021 14:46:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYSE2XqE2aOQ2K3vuF3NbW03kQ9aMRFvwiBV3sLzVfZ0mhn5xPcMf0G91F6W0T7YoRdB7LBEzviZrm/RxY+O+eVEA3o1g0ZI5MQr95QPeIQfDcvjLnEfuXwsptxmRZmVG2DvNKLXy2kmalbeszeORHEziR1/Xo0TVbH6woOKOFFf5lA4BNHVcNLrZb9sG1ztxhbzRoyoqJnsNs0EFxVbpElukOjyeHqoiP+k1+Hplg9AQaC6KlMixp5khF/Cv7rJDZIbbcsmP6TQ40gE5xf0pjkIoDK/igmR604BtmumOsHGDa88lp2bMA+nz+WpusTAf6Gd7UrcB3dPTIN7T2JXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8wEWbC961zUJ7CVf5b6PAPiR0lunnPLvu7W1AyJAT0=;
 b=eyLuAVopMl7iHJcrKGv9DEr4P1I3wG8XUZw/5ik82/AJABw+JgVNa/sc2e0QivNFPejbxXulYF8VBq+htVGEROxPMnglAB7yvSRhl8JuJ+UNkrGewZ6mrS/MvpmWuN4u8DXQcUPhb0zQSdx691IKgerumvTJnCQgoh1giMbyR+nztnyk0DJvkmjMZoD0McqTkvYJDei02kryef44wWJajnhy9F5xEPlMryTKI2Xbmm3QHZEIQGv3TiHHX5S9O1lhSKH9ZWUkjBHIV35XVn9nnzHdPPNE9WU8+MZrKbhMXGY28gr79vaSZnE0zABGF4OUhgQfVT6D5jnaAxp5mc8McA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3464.namprd15.prod.outlook.com (2603:10b6:a03:10a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 21:46:28 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.039; Tue, 6 Apr 2021
 21:46:28 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Song Liu <song@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH 2/2] perf-stat: introduce config stat.bpf-counter-events
Thread-Topic: [PATCH 2/2] perf-stat: introduce config stat.bpf-counter-events
Thread-Index: AQHXKCCIduhTbkO6e0WfWNZaS0HfRqqnkBmAgAB8PYA=
Date:   Tue, 6 Apr 2021 21:46:28 +0000
Message-ID: <8970DB18-42B1-44A0-84E9-5C317245F453@fb.com>
References: <20210403002938.390878-1-song@kernel.org>
 <20210403002938.390878-2-song@kernel.org> <YGxue1aHQUFj+UaG@krava>
In-Reply-To: <YGxue1aHQUFj+UaG@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:57e2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01e125e5-77d4-4c8f-a5ca-08d8f9456f46
x-ms-traffictypediagnostic: BYAPR15MB3464:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB3464C1FAF1B441C67380D948B3769@BYAPR15MB3464.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ISFkdMhKwZYwsfQOKQdwoj9Ti/Hi5XChB1yBeKdnEBCxSUxBYENpVmrpVlOEvQ47e9BUzevvTr6XucFKlywqUvUOLzYjLNTMe8bASRTwMsuNJI4hQcIRkQ3kNFeJH0MfMr8bl3DCWauFmhhgdetDyPI3vUWTwFK5rLR/4O0Ow5riFLCyav2cFVTJvXWnlQKR6ISpIBhyh03+R5plnCfKasZRal2WG3NNsoRAVE3/rKr1ycV72Nw7JvjR/VW91VgNALCXPk+UVEJ/2HATtDIJRHBotZlLEe74ZRPi6xB8QtdU07i94K1I7xbSBYeAb3ITv7KM+ZjNY7V55cEhqzcBT5SpgzFb2Ye0UwObvwF/FteuYUnuk5U+SbxJWqEj2pACH8IAohsmrqqpGTNGBN/Ly4XEaBb/0Bppin4xJj4pxnrTIghI1Pwf/eKp812wm+k5DQ9VBF9xGd5xQvNvY1IMuknvMr4Q0MWGWuVn13a310n+CVD9oU5EtO5QAdndL6PfE/1ptFeI4CPNanhvuNOFGkyIUYz2wQbxHE387RgQImqVbBJ6qHCdFI0TXY0FlMMEt3atYwPTbVyjofPlAcme1nRJTzoPNThJ4QMQEnbBmYiCVS3wa1Dl98U404xop8jqh17Fow1SYuUIc8yUf5mLpxMaz8f0dZMCKp61P9oP5kgSJl1jcdUXZMyKgkm6fySP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(498600001)(76116006)(91956017)(86362001)(2906002)(6506007)(53546011)(186003)(8676002)(4326008)(2616005)(6486002)(33656002)(6916009)(38100700001)(71200400001)(6512007)(36756003)(8936002)(66556008)(64756008)(66476007)(66446008)(66946007)(5660300002)(83380400001)(54906003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HwtuY1HAJnrmZPpQUMDd1yBqVqBbj9BshHSnR2TXijnK4mo40gWN4r12WXlZ?=
 =?us-ascii?Q?pEifO4F5d42+Eh9ws+YLDLJkMloRgAoS1j9WX1t32dfTgQH0vuzYYgvFH4wO?=
 =?us-ascii?Q?46xGHTijAFEbT6NGjQtlDqI/QY2+SF0sNEpLSWQgcU8QS9bnCeZ1ft3pWciu?=
 =?us-ascii?Q?aoYcdW0i98lJIs71X7IHSh/aZ4d878GnnYqLbu/76b/MmE3aLWFqcxzmJxkq?=
 =?us-ascii?Q?s+bYfE5ZmS56qLu+vu18KDQchXiO5+04gQWLHQFwmVu7UR2PpgfBlTsxhah+?=
 =?us-ascii?Q?1YJbywqMmWckKhXXI530T1oIGrzS8u8zHtJ83jK8ejV31ln/6/5LlTTG4C/C?=
 =?us-ascii?Q?oZ1J2+D7sv6e5PdVmiHbuXyWYvINeKadGUuae/koSqFaKrj5zBCWrJU517gs?=
 =?us-ascii?Q?SiOzB4GbeOtuYY6LcmdH4+Hn1q/fO3XBPh8GiOLbWuWsM0bx/lR3gd6SB1fv?=
 =?us-ascii?Q?0dwxZnweEzU5F9vt78V7UQ3E/yIpWPnWUdzFGYM6ETJqx99J3vbhhBtZT1Np?=
 =?us-ascii?Q?SNN3aa2FoYRVZQ/01IwCXaZh7XB1TLi0bJrkT2e4r4s/Ib+0TjfOFBFRuRTl?=
 =?us-ascii?Q?DEIaPeR0luxZCySGi1I9q+bk8w+tYU9R3OvcyTUNeMEv4XJBJtfjVPrKDvH3?=
 =?us-ascii?Q?A50YUD+iIEuk7R9ErZDb+Io9S3Aqie2K7juBplbCgd/LzcWQP8g4bYic20q5?=
 =?us-ascii?Q?GXV79WCniu4qlFmuaOBC+2GAoQNX/sVV3Xiup+mBX52/R/vodvIGwla41ORh?=
 =?us-ascii?Q?Qq1/gxVVOpG8AnG9vn19/GmlOuDBjcc9jgK6QqJBxBCLqIJFmiXKUfcF/pB+?=
 =?us-ascii?Q?jBRjhLgigJI94OKjzxzSeM/shAJexCGNlX/E+VyePGeZNXNK7hFfaoJn4MHa?=
 =?us-ascii?Q?2wRrGuQJAV7ZEUjmxYmYjVkW3ev1tVfDa876A7RbrvleBVQes/Kg7oRYTbB1?=
 =?us-ascii?Q?Q/8yLU5biaEoibQzfsWR2jaKNS3VzfLwGraHHBwiHFtaprFEheQcXO3qq/Ro?=
 =?us-ascii?Q?SjpYcoopCqPyEmYzoJLOcFyVVMagnDFL6P0xXVqvHVr7pUNQeoEfpnzzvf8J?=
 =?us-ascii?Q?RtN/TmVjf5q4bhSPAq95sdurkcLx1QILzV7ivV0s+sa/rTar+EQ3ZnSay1Fs?=
 =?us-ascii?Q?ZbtYBrldllCD3VcBAbc7FL+MEyBSfU7v9kCny6X79JxtBt9GJFcd+e7h0wyp?=
 =?us-ascii?Q?gEf2S71m0K0KStblt27lZ0Q8mUZnFTEyBSEcLzj0thw+w/pp+vCZSWR0Zepd?=
 =?us-ascii?Q?JGkcY78CYVuYCVndYrpQ51Kjq7m8ASCxJwNp7v5fFWFvR+ils0tVWLpj7rEN?=
 =?us-ascii?Q?1g3GoW7CZXuG/gSYDCE1UshSOcswIVvoERAhssifz3moN+VzK08DivRxCYPh?=
 =?us-ascii?Q?CV1B23M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19DBD3D4FF3B5B4FAA6408FD03BE03F3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e125e5-77d4-4c8f-a5ca-08d8f9456f46
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 21:46:28.6056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o1R573vlG4eK9c/zQtwZQAKe3//vVzjggsvpFH4QH+eJ3PQgMg5NrS7yrK5JxOJklyOCRhUv06kWwazea8lAQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3464
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: uw7D3zb39UyrJtrKLj2AvPoiwkfV1Q0v
X-Proofpoint-ORIG-GUID: uw7D3zb39UyrJtrKLj2AvPoiwkfV1Q0v
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_07:2021-04-06,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104060146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 6, 2021, at 7:21 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Fri, Apr 02, 2021 at 05:29:38PM -0700, Song Liu wrote:
>> Currently, to use BPF to aggregate perf event counters, the user uses
>> --bpf-counters option. Enable "use bpf by default" events with a config
>> option, stat.bpf-counter-events. This is limited to hardware events in
>> evsel__hw_names.
>>=20
>> This also enables mixed BPF event and regular event in the same sesssion=
.
>> For example:
>>=20
>>   perf config stat.bpf-counter-events=3Dinstructions
>>   perf stat -e instructions,cs
>=20
> hum, so this will effectively allow to mix 'bpf-shared' counters
> with normals ones.. I don't think we're ready for that ;-)

I think we are ready. :) all bpf_counter stuff is within evsel, so mixing=20
them doesn't need much work.=20

>=20
>>=20
>> The second command will use BPF for "instructions" but not "cs".
>>=20
>> Signed-off-by: Song Liu <song@kernel.org>
>> ---
>> tools/perf/Documentation/perf-stat.txt |  2 ++
>> tools/perf/builtin-stat.c              | 41 ++++++++++++++++----------
>> tools/perf/util/bpf_counter.c          | 11 +++++++
>> tools/perf/util/config.c               | 32 ++++++++++++++++++++
>> tools/perf/util/evsel.c                |  2 ++
>> tools/perf/util/evsel.h                |  1 +
>> tools/perf/util/target.h               |  5 ----
>> 7 files changed, 74 insertions(+), 20 deletions(-)
>>=20
>> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documen=
tation/perf-stat.txt
>> index 744211fa8c186..6d4733eaac170 100644
>> --- a/tools/perf/Documentation/perf-stat.txt
>> +++ b/tools/perf/Documentation/perf-stat.txt
>> @@ -97,6 +97,8 @@ report::
>> 	Use BPF programs to aggregate readings from perf_events.  This
>> 	allows multiple perf-stat sessions that are counting the same metric (c=
ycles,
>> 	instructions, etc.) to share hardware counters.
>> +	To use BPF programs on common hardware events by default, use
>> +	"perf config stat.bpf-counter-events=3D<list_of_events>".
>>=20
>> --bpf-attr-map::
>> 	With option "--bpf-counters", different perf-stat sessions share
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 4bb48c6b66980..5adfa708ffe68 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -423,17 +423,28 @@ static int read_affinity_counters(struct timespec =
*rs)
>> 	return 0;
>> }
>>=20
>> +/*
>> + * Returns:
>> + *     0   if all events use BPF;
>> + *     1   if some events do NOT use BPF;
>> + *     < 0 on errors;
>> + */
>> static int read_bpf_map_counters(void)
>> {
>> +	bool has_none_bpf_events =3D false;
>> 	struct evsel *counter;
>> 	int err;
>>=20
>> 	evlist__for_each_entry(evsel_list, counter) {
>> +		if (!counter->bpf_counter_ops) {
>> +			has_none_bpf_events =3D true;
>> +			continue;
>> +		}
>> 		err =3D bpf_counter__read(counter);
>> 		if (err)
>> 			return err;
>> 	}
>> -	return 0;
>> +	return has_none_bpf_events ? 1 : 0;
>> }
>>=20
>> static void read_counters(struct timespec *rs)
>> @@ -442,9 +453,10 @@ static void read_counters(struct timespec *rs)
>> 	int err;
>>=20
>> 	if (!stat_config.stop_read_counter) {
>> -		if (target__has_bpf(&target))
>> -			err =3D read_bpf_map_counters();
>> -		else
>> +		err =3D read_bpf_map_counters();
>> +		if (err < 0)
>> +			return;
>> +		if (err)
>> 			err =3D read_affinity_counters(rs);
>=20
> so read_affinity_counters will read also 'bpf-shared' counters no?
> as long as it was separated, I did not see a problem, now we have
> counters that either have bpf ops set or have not
>=20
> it'd be great to do some generic separation.. I was thinking to move
> bpf_counter_ops into some generic counter ops and we would just fill
> in the proper ops for the counter.. buuut the affinity readings are
> not compatible with what we are doing in bperf_read and the profiler
> bpf read
>=20
> so I think the solution will be just to skip those events in
> read_affinity_counters and all the other code, and have some
> helper like:
>=20
>   bool evsel__is_bpf(evsel)
>=20
> so it's clear why it's skipped

Yes, this will be better! Current version does have the problem of=20
extra read in read_affinity_counters(). Will fix this.=20

Thanks,
Song=
