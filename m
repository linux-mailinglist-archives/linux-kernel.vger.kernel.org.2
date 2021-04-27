Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4BA36CBAD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbhD0Tbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:31:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8310 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235563AbhD0Tbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:31:49 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13RJTcRe029902;
        Tue, 27 Apr 2021 12:31:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=nR+goImPQZcfTDAeLuf/KFu+qrBjYgB+vpESenpVeO4=;
 b=gDV7+HVP6Rcd5FWvg4s89w9OwuQHLR7DTjGvvo8sU046m+Z4IQOiUO0ZOiKUZmFNDt7r
 61fiH4c06uqU8QQ4rPmJh+cPAggK7kS/C27MtPCIIoIHHnWfbk4lNuJ1LG8snK/C9J4V
 V+6UvjQpS+o7xBmHR0H/K2lkWuZKjJCf1aI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3866w85jww-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Apr 2021 12:31:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 12:30:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9J0z+ijdvbj0vRgpOFILb+NJmr/gNqdoOUkA97H5D3nr1I5zuaK2bQRo5k2p286n84UDuYUJ4FyJ03T/7dC7FjtMI5AowNCNLpXDjqg2pn+OtEU/JWEWOJift6qWz6h/fK4GA4o7lwvEfQ/uMFrKskF6ATFDopB/QSNnGoDI9SrGW5yc41/fP/sszpmKwChPumHaNoq79QqqMhORWpLNNhMXwaiy8vOgPSAMFuw/NIzBrh2GyLZWu9Wi3PLxUcBoSaOZMOI0jlUszMHyom8wDz3TEZRU62Nli9EKXh31nFix7yg02z4lwOmcDwJ69JpVbPB1bpW0BqIPvEc1uXK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR+goImPQZcfTDAeLuf/KFu+qrBjYgB+vpESenpVeO4=;
 b=dlul2xy4e3n3zDqHQduOHE7cyfLOVhSRntpTUTR8odl+vPvqSVqgm6yaiHRwhTimxNMnGac/Xiv0MDb5qnzzrOoXRT52GgrF4UTMr2mSVrfOjIa8i1evTEk+hj1KywRpU0JreILBsKHxYvhqN18NnMV2GoQQwpi3vK5o/MPVqjBN2PSWVUQCfIKObBAGA8BqW3rexc7Vzg5lDmRVZ5UoO07pQ4srYni1+Bv8tywsIomhECa2IueUm22dp6OSnBAhK/SEq2MLmdESYajW/9DDzuIpyxY2QT7Pz6EYGZBOH59Vu3U+6oYkFcJ0jouF/DMlAE8mMrfRq2VhXZsvrUpn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by SJ0PR15MB4204.namprd15.prod.outlook.com (2603:10b6:a03:2c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 27 Apr
 2021 19:30:28 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.040; Tue, 27 Apr 2021
 19:30:28 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Song Liu <song@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v5 5/5] perf-stat: introduce bpf_counter_ops->disable()
Thread-Topic: [PATCH v5 5/5] perf-stat: introduce bpf_counter_ops->disable()
Thread-Index: AQHXOhwex5gB4i62NU+zgG+lriKiJqrHUbkAgAAOWgCAAO6+AIAAdISA
Date:   Tue, 27 Apr 2021 19:30:28 +0000
Message-ID: <5257A59A-CC47-4CA7-9C15-CD6E20DC4BD0@fb.com>
References: <20210425214333.1090950-1-song@kernel.org>
 <20210425214333.1090950-6-song@kernel.org> <YIcwRj4WtsZln4SR@krava>
 <CDBE5630-F7F0-494D-BFA8-33742D831C2D@fb.com> <YIgElir6KJCoygX5@krava>
In-Reply-To: <YIgElir6KJCoygX5@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:1382]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 600a62d9-929e-4a50-1ff4-08d909b2ea3e
x-ms-traffictypediagnostic: SJ0PR15MB4204:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR15MB42042B7255839026D2EE8326B3419@SJ0PR15MB4204.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V7jjuKLpcW06Cd8IZryxG7bxvTZU7JDjWHp8KW/h7nCrqnqA4kiT7T03/xIVbiSSFOeE5G0FrOj2UIgnGgnGs/AXSseD40J3yIU2BSOuyUG7svDHfglfGirg+hDKz6LvZV5Qs1npJIASttatAgum2STGcUsUta5mZxt+27ZB2T4U/0IA8IBDg/nlotxsWjNjtjJMNelag8tmYhvhf3uhWkNTLvUsvVZAKDu6RAMyKlWxC5pM+AZrTtTyqjTWhbofQXiFvehYbdVdkhGqzERqYnmVxvYgdP7945eeks8y+DyKoDseUmHNdAYLHzgdB8ZF86Xq4xznW7MuSCV/N6E7IY2rxxmrss3DoBOmjvcKuu7ifODF1Z+CzmbMs2eG5+kxqSvMFzUIord+bKiQTGRbOxeAfAV+D6XL8Jyjl353y/UxWIYWxLCXxakwv4mKYI0bdTs+DavgDjkHiezWQBi/FfO5dmEI1TSSfyDI4nXOarEKnXltqXaDo283S8iIoYz3lll5zcwjUFURnot6XthiBnC3iBhKTMrT+Sy8s1+xTPKVsB7PGQG4DJ0ouxkk1q0N/ZkxyjoNGYe3UC8SrNBjzWFx3JKbUlwnFLmjVMKd6e1XbO1RBIKStj5DO+tPXhig+ZvAWc/vSva+34I5MyjgHUy1CffkgvJnL9xVZGwXIIU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39850400004)(6512007)(6506007)(478600001)(8936002)(8676002)(6486002)(76116006)(54906003)(2906002)(66946007)(38100700002)(36756003)(186003)(5660300002)(86362001)(53546011)(4326008)(66476007)(71200400001)(66556008)(64756008)(2616005)(33656002)(6916009)(316002)(122000001)(91956017)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0Sd92jVAhrEw17loS40Geqh90IY9N0htcKyOMBXy9HqtZ/RLK7rKgKTrZp4a?=
 =?us-ascii?Q?b9QUqW3qrlL1liDic14+RlSKs1qRpL4Y0DY55gwESwWOxthVISfQsyjIKLLf?=
 =?us-ascii?Q?8883V4ppr3GwHQlrQdHbYATFdxYZgCAmDinSKEr+Zwoxq6lCrYRlW+fPqdUv?=
 =?us-ascii?Q?UbPk75H3PdXowc069AV1B/oCfJnsXVBMrS66wN467L+QV5wQTw62cPboz+FR?=
 =?us-ascii?Q?0OYhykkUpLvZ/fz7/wcDgjJMt5WvqooCUx6eXAZCYt5UVxnsCn/f4sQoOz9X?=
 =?us-ascii?Q?PUiZskTQ+1aK2xBOFltRYI7P+F1kbuwaLJc46rw5v/CP9tiBMa0s+WCKDcd3?=
 =?us-ascii?Q?EPBtW8NGsscpd/elYqL3TZUPMlJiJO8z2/KgYf5IbSQE5BwSOvq/oujqzrha?=
 =?us-ascii?Q?MWxpBsFIaYtIsdFfGcqL5nn4bjJA8+bhHxzfDYt9yRbX1Ai8Z+GDf4r4aQiE?=
 =?us-ascii?Q?X4B9q3/AQCvrKTvfiCv6s+7vJiztcG5dQFTiT4hEHJksjo4qDADOJ99ODUi4?=
 =?us-ascii?Q?7tuJTrpLhcDpb2lZVURRhTgWZdp+jySvPYcsd/g67OMzbcemDUqOhdibqdbA?=
 =?us-ascii?Q?iIldoeP8yYeGF/3bukIiQJP44wEhF3cMRjbQTuBZmTg4f0KVVUvpaDnka/6I?=
 =?us-ascii?Q?TOh7mVo0/PkLJSnENg0SdoNuG5VaCO1DWHLIYPzoGDAHK9Qv4xE5l1p1pS2e?=
 =?us-ascii?Q?HkxpUh4B8EeRVwefpQrvPYRW/mlL0SdAkL6esMHGTSDrbHDupZeBrMFO9XP2?=
 =?us-ascii?Q?vjZsRLPC/tSK4Ham6PyWKwIOKUS0SP7+gDg0ouZ01ng4pI/udZEAWNuIGGC/?=
 =?us-ascii?Q?SlF2moMAhFVutC/UU4bESOatHYZSuN+b+0GEaGeuacznt685aoIsmI6MDyjn?=
 =?us-ascii?Q?/nyVrR0+Cyi14vd3qZ/YmBCmZhwA/Unc1IT9zD2QJ+rKC0uWAnBymkBwcujp?=
 =?us-ascii?Q?6G5+U+EYRvpVpN53gWUTpvpmX3TNTTbjQNLmWC5xIgW6CR1xWhchGOMTAi7e?=
 =?us-ascii?Q?mTQVaiwO0+hLsUVtWyVLTwmr98oPj7p7a0WmbQrLhvoMPn5XdGAwGOi+r9n5?=
 =?us-ascii?Q?xAe0m5sQ/CZ4npILAkOWYds7GXbRzuWchvQsUGb5IDt4+hUD+YNp1xZzclVH?=
 =?us-ascii?Q?XetENMHacyNqyzsuaZhoTPV6Gbbv5+OGmlkHikS8TqG1HeblHhi3FOMz2wyG?=
 =?us-ascii?Q?gs/TiKY5RZrK5sF9QYKMR4PCf52oaPgNvv0akmjEJrQ3qApfr/mvqykb8o94?=
 =?us-ascii?Q?sVhYxJUrxC4QBs6w1+uAyIi88FotW/TQ5726gK4PKdokF+Cq9B99VftARPwc?=
 =?us-ascii?Q?JfH/EqU+kWrtht8URdeGz6FYkvlrX/wPk+w3bc9S1/9u3vbIl+50zfccxzSQ?=
 =?us-ascii?Q?3MSQA9o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B5793A11AE96264A845A5C17922818B6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600a62d9-929e-4a50-1ff4-08d909b2ea3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2021 19:30:28.5935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cm2zD6OcuukuszDE6pwprdBdiLBCSjicqrdJI1z95IGqoUg387qvNDjtgC7E0iVcXPuWasR/6oZbcdtCIHyYsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4204
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: JnyqegSKrt8kJxMBqPWdYU06TUMEs6bC
X-Proofpoint-GUID: JnyqegSKrt8kJxMBqPWdYU06TUMEs6bC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_11:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104270129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 27, 2021, at 5:33 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Mon, Apr 26, 2021 at 10:18:57PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Apr 26, 2021, at 2:27 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>=20
>>> On Sun, Apr 25, 2021 at 02:43:33PM -0700, Song Liu wrote:
>>>=20
>>> SNIP
>>>=20
>>>> +static inline int bpf_counter__disable(struct evsel *evsel __maybe_un=
used)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +
>>>> static inline int bpf_counter__read(struct evsel *evsel __maybe_unused=
)
>>>> {
>>>> 	return -EAGAIN;
>>>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>>>> index d29a8a118973c..e71041c890102 100644
>>>> --- a/tools/perf/util/evlist.c
>>>> +++ b/tools/perf/util/evlist.c
>>>> @@ -17,6 +17,7 @@
>>>> #include "evsel.h"
>>>> #include "debug.h"
>>>> #include "units.h"
>>>> +#include "bpf_counter.h"
>>>> #include <internal/lib.h> // page_size
>>>> #include "affinity.h"
>>>> #include "../perf.h"
>>>> @@ -421,6 +422,9 @@ static void __evlist__disable(struct evlist *evlis=
t, char *evsel_name)
>>>> 	if (affinity__setup(&affinity) < 0)
>>>> 		return;
>>>>=20
>>>> +	evlist__for_each_entry(evlist, pos)
>>>> +		bpf_counter__disable(pos);
>>>=20
>>> I was wondering why you don't check evsel__is_bpf like
>>> for the enable case.. and realized that we don't skip
>>> bpf evsels in __evlist__enable and __evlist__disable
>>> like we do in read_affinity_counters
>>>=20
>>> so I guess there's extra affinity setup and bunch of
>>> wrong ioctls being called?
>>=20
>> We actually didn't do wrong ioctls because the following check:
>>=20
>>       if (... || !pos->core.fd)
>>                continue;
>>=20
>> in __evlist__enable and __evlist__disable. That we don't allocate=20
>> core.fd for is_bpf events.=20
>>=20
>> It is probably good to be more safe with an extra check of=20
>> evsel__is_bpf(). But it is not required with current code.=20
>=20
> hum, but it will do all the affinity setup no? for no reason,
> if there's no non-bpb event

Yes, it will do the affinity setup. Let me see how to get something
like all_counters_use_bpf here (or within builtin-stat.c).

Thanks,
Song

