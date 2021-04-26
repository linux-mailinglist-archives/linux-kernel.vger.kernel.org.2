Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C8B36BB9C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 00:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbhDZWTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 18:19:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30094 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232062AbhDZWTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:19:46 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QMHX87007664;
        Mon, 26 Apr 2021 15:19:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FYjeeTdIfT0FnFugDqEcJfuFQ81zdYjjj9SYQ++XdA0=;
 b=TOMMUyWQClV/lX6iaUj1rkfmBjNf+ZU0ZC78mpVR6V+A+amGGLMAoy6RnGA9qxt/RaN5
 C5c033h/IoL4ORToSre6nX656qoA36wN0uPmnacie+NDY06crHIJ5K6x+ptXMJjpeSmd
 UWw/Rd+ccTGo6xvE3+W7iZsMmzZ8RSFL5MI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3853g8ge2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Apr 2021 15:19:01 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Apr 2021 15:19:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/eU0q2/ullXOVIEirPjuVbBI1w1LMYnmwfuHEapxRzcHtSz40e+vv2bj7w+jRMUli/tTnUP+s0oaGVcbi5sVbx0pkQeyqeVvfB4Sfph1DFKO2eOF0yXQtcdPWsQEZKxUXI/l90Bt2f3FV3eTmjtmI9i8LBwxaTxWfKVgrosF5oqgu3dsOovM9j+OjWlUumwx7XtL/IbLWlq20dF9mS6fwAixQMUf9Ly47t7L4KJJG6plDUAuKBPEzM959WmhS5JzAxKKj9iFGd/XZ6KTe6qOqK6tikLmK3qgDmu4ZIREd9RTaFwmHuRtb1HFablUaqTzkGtRqlyGzKvaq+huiGbRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYjeeTdIfT0FnFugDqEcJfuFQ81zdYjjj9SYQ++XdA0=;
 b=OVYwOLqQVmnJUorsxuox1VnrGu1vDG4gfz/wP4crEKPFDyf73oOpz58ynE4X3tc+ubAPOaQ473IUAE5TFCZXkvmyoHOB5GYUjhlaJb3m+GvwbWi+Yj1g21p/m2GGl35tUqH9XnpFWt/0Pe6Bxp1QKu1E6hPVMOmYwOPc5pJ6fujHWC44oLm/neyKQ2DLBA/h5KR8eWscOQOliMsmgoKarTtIUl7PAOIlnv2PMNyTIINRR64HGgvpkn4PJUKVfq7bTpHhfIKKNugQt1IfOKQMqLzklpzhK5AmwzBr3GQZEeoKVcvWBIBOIRePzIX3FbuKTTFslPYbgsca/MNdv3YP6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2325.namprd15.prod.outlook.com (2603:10b6:a02:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Mon, 26 Apr
 2021 22:18:57 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.040; Mon, 26 Apr 2021
 22:18:57 +0000
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
Thread-Index: AQHXOhwex5gB4i62NU+zgG+lriKiJqrHUbkAgAAOWgA=
Date:   Mon, 26 Apr 2021 22:18:57 +0000
Message-ID: <CDBE5630-F7F0-494D-BFA8-33742D831C2D@fb.com>
References: <20210425214333.1090950-1-song@kernel.org>
 <20210425214333.1090950-6-song@kernel.org> <YIcwRj4WtsZln4SR@krava>
In-Reply-To: <YIcwRj4WtsZln4SR@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:1382]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e88317c8-948c-46f5-8fd0-08d9090148e7
x-ms-traffictypediagnostic: BYAPR15MB2325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB232575F8FDEF74E56D15E85FB3429@BYAPR15MB2325.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SNZTALjelc063qiiO+0OLa6kZy8G8nr8+5mA/DI0ldFo0ExTz3v87FvPLIbJ6oEXAKPfPjgpImxCa1N5CVFkjtXzqaWpsXmgNJZ4JvKSFdeBB78M+L9Qq8cy+GxbpkYEQC8SM/XugpUYG3FrMG3QYoMFmAz1btOmnDGcH1Stfxyt4/ApIuhJcxbfDURqvQMimZuRARog5frww6EKydhU+hP5e5WPAJ43nZ3ZYTeBEJLXWYKF1VondudSAYXlLHkmwXLuqr2Z+sH6WCGiZnKHWKCKFiOsVGyhX8Hyrvnd5Pus1/VxL8SVKF0fDy/NjjYmwcxDFZt6kkjsUfBAQxUvVFsY8gk5x4sx43HY04MyyEW9EmZ4uh3tkll2mYzgD0Yw8zo+9zlpAyhnF0Bq3R9nLIDLJJg49M7BsfA4vjH1w79aKe73OAe+0tKLTQmrrDLgL+X96ICKNsMYAm5vIjxBI3/b+0ROUo/Q7wRXNCGmhIaJdXBxlFH/rA7oNPRWfi51fTGXaNIBtVSEWSi/Sf146QVsuhwntTfMQw8qcb7O4bkvmqpN1SYLqSmZpWTQWg7GMwgyPNcunRzw2dWsYIvFjvTynQhp7DdcVsTulaGsQXiuFAty3uBp4UUnPt/l+JKrLCU6unxbzJoGkXhSItz2jErcVs2HFcXuClwA3EF/wIk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(6486002)(38100700002)(4326008)(478600001)(54906003)(33656002)(6512007)(186003)(316002)(6916009)(2906002)(8676002)(86362001)(2616005)(122000001)(66946007)(36756003)(91956017)(76116006)(66476007)(66556008)(66446008)(64756008)(5660300002)(53546011)(6506007)(71200400001)(8936002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ubSy05xIziHONM49wzrR728b1XG37N4wY25AaK83vgFmB1jlRky1cBCanJ/V?=
 =?us-ascii?Q?eJHuMxcz2djY9jl8bSKTCtc8oO4mNX5cMs0VlkNZXgtyLogRv+4DKwzCNET6?=
 =?us-ascii?Q?MetetP17aeoV3OZEvp9p8MkBO59JWPSt4QJv/av5glGmeYP0mZbCEKKa2SNE?=
 =?us-ascii?Q?u4Pquv56kvu3p9j5JJEShooJBIWwmeUqB+7vTLVeuWTPTjsfqBU5yTaSrocg?=
 =?us-ascii?Q?ilyBMKYgY4pL2zimkBQfb5/FZRyK+LC7QLHnLyHIXuv843HIgGLUpEfY+keD?=
 =?us-ascii?Q?p91jREcQ+ct8neii7nYRqIMaR2yVTOb0yOPezDuG3dAQR9bVL6yWHohSdrY3?=
 =?us-ascii?Q?kbrgkBpSAZuX2i8MAn8hL/iKbSqahqdmJ/UKjiyb6N2+r0yPR0zX+U1++VU6?=
 =?us-ascii?Q?TG7R8j4QZMxhmGMTUqNCEyMifvny9+YQCbTnYW5H9ZB0KczJwZvRozfualJ+?=
 =?us-ascii?Q?IUBnpit/qPkOiqOI70AQNU3Di8Lb9QRruwtvyF7+ko6x6dGTuNhPx/5LPkhM?=
 =?us-ascii?Q?hoPfYqHm0GqOWawS6SGNy+aegcF5Df6P1zjyIjN9ojJ4gtVqUB6pATaEMUAD?=
 =?us-ascii?Q?UFAb3xRPA5M+4f/QQ7foIuNRhFQFclnn/w82N0ZDVEpSotU6rwIeu+ByXIji?=
 =?us-ascii?Q?j+ERL6VCPEQmydLV+HJWSSsUGyshqo95Yog45yEcRpH4g7oD530nCxcVXMb0?=
 =?us-ascii?Q?IeUbBtdUIgvq8hdQNc0Myqi5zIhRThS9qlrjUbPavhyU6Lgf5y/4c1zxgCgQ?=
 =?us-ascii?Q?57eyH4AoADg5+OxjFgWMjckoFKGXj2WgaLgI6ahdtHmVoBM9XzaVaVsMnS6H?=
 =?us-ascii?Q?Z7emm/LXfKFkMSwvQ+2qRlQPKBpHgAhapcgB1Pxdyvgk53dAYFb+wdfBIEQZ?=
 =?us-ascii?Q?Z4SSGVl+xVFaTFJSR4DgsK784+oRKfP1IUG/zN9bB+gkhgksYTGj2auhJ9dE?=
 =?us-ascii?Q?virKXmbg5vfqdzreJ4AAO/WTVwxRxgA3qEzSvSQai5EkUEVaGALVKIvyWhFO?=
 =?us-ascii?Q?yovbscDZcDw8U9NGCChv6L0lY3Rdgx/1SO0afunW1lEkNER3SlARa5OLi92G?=
 =?us-ascii?Q?w0didjZ8ycWgUCr/q/gIUz0zwM/DGAqb7q+MHwUlj0WqDW6IiTiSGv9X8XRV?=
 =?us-ascii?Q?A6C9UEcSQnfy/MysnH0QEcAYLJMYmPv7mTlfQ2wepfmMF92Cwboin0fBLRcv?=
 =?us-ascii?Q?bkTtfpol7utle3eTjeIqR7Ui3JXRMrXP2qKHDxvmPG8SDmU9x4+HTnuHMbk1?=
 =?us-ascii?Q?54Q2pDlGxe77XpbKKpjWGNTMDR63pHoZN5HsSckaQgrb+yvI26kCLPrKHR/E?=
 =?us-ascii?Q?QndgGXGx6cbpkYfId59EA1Ojt/EMXvlKBZqTqZcg80GV5Hys5qxTuJFIq7SG?=
 =?us-ascii?Q?z0vjzWw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F6268CFC6193F64D895B1CA7B46E9E9A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88317c8-948c-46f5-8fd0-08d9090148e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 22:18:57.1139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VH4Ehodxf3tjetNHegyLEG1k4Nxy+dVRjDHLj+y3C2/y+2nP8AKxN6UOFvV/j32l8P+OLsamFO32H+4ZRUacnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2325
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 6-8GGMLoWm0EGSxWePWneiypB45HeVR3
X-Proofpoint-GUID: 6-8GGMLoWm0EGSxWePWneiypB45HeVR3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_12:2021-04-26,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260169
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 26, 2021, at 2:27 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Sun, Apr 25, 2021 at 02:43:33PM -0700, Song Liu wrote:
>=20
> SNIP
>=20
>> +static inline int bpf_counter__disable(struct evsel *evsel __maybe_unus=
ed)
>> +{
>> +	return 0;
>> +}
>> +
>> static inline int bpf_counter__read(struct evsel *evsel __maybe_unused)
>> {
>> 	return -EAGAIN;
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index d29a8a118973c..e71041c890102 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -17,6 +17,7 @@
>> #include "evsel.h"
>> #include "debug.h"
>> #include "units.h"
>> +#include "bpf_counter.h"
>> #include <internal/lib.h> // page_size
>> #include "affinity.h"
>> #include "../perf.h"
>> @@ -421,6 +422,9 @@ static void __evlist__disable(struct evlist *evlist,=
 char *evsel_name)
>> 	if (affinity__setup(&affinity) < 0)
>> 		return;
>>=20
>> +	evlist__for_each_entry(evlist, pos)
>> +		bpf_counter__disable(pos);
>=20
> I was wondering why you don't check evsel__is_bpf like
> for the enable case.. and realized that we don't skip
> bpf evsels in __evlist__enable and __evlist__disable
> like we do in read_affinity_counters
>=20
> so I guess there's extra affinity setup and bunch of
> wrong ioctls being called?

We actually didn't do wrong ioctls because the following check:

       if (... || !pos->core.fd)
                continue;

in __evlist__enable and __evlist__disable. That we don't allocate=20
core.fd for is_bpf events.=20

It is probably good to be more safe with an extra check of=20
evsel__is_bpf(). But it is not required with current code.=20

Thanks,
Song

[...]=
