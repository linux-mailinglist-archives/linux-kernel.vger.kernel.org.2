Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E23F355928
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346406AbhDFQ1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:27:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45386 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1346401AbhDFQ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:27:04 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 136GJqvC004552;
        Tue, 6 Apr 2021 09:26:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WUvrLFAIwXggUwf4fNPODPvKmeix7hlTRJJcgV3wnQ8=;
 b=XRmg/HvSinXfuJWFBWbCUPn1XuRQBKf0P2srat5xTDuUJ0C1UIAUAzhclbYyNUwWKTC9
 CTc14ULphZgFZWD5V13zBvHJGPjGYytYY7cBDeONaQvZiKEID+g2yCzuVu7VJWYfKTR4
 g42hhLZROGai0rst8Te/QIraQc+dbR+akuI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 37r8v3whfj-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 06 Apr 2021 09:26:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Apr 2021 09:26:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3Qq7bvHE8vC5npHrCErYdk5UJKZWJ6yHgg6MdXy9+RFJ9fIjRhs0B02s1JyrtEV1C3wYe75vIr8PQNT4jgz+0N4L03cwGEIyVGiT/mLpo4lEaF0dmh015f7iJVYF1EOAumgagHXA7Y+fiiuzC2y/S84h02Evrw1Q75bzNG1P9BJlVf/Hj4S1TpJU55S0+bUlkqh+1nDTylaZWVE61Y7+EzblEHTrQkQ7aE6exk5ZF3mvb+Cdvo5CQXd1Jioevi7J8X7yyGLv0PDjCN7ZeZwXxZBAD/9PezzftslJSy5pMdMA2BcRZ0L6YE2sZBiI59NZlsw+ZFH9mm+iNdvgfUXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUvrLFAIwXggUwf4fNPODPvKmeix7hlTRJJcgV3wnQ8=;
 b=TAWJfKTTE2wSYRf8W9smey78f/T13c0N6aQ3iYWTj1N5WwGTNmOGt392e+O3MMsK3ZkuU357DZvt3CX9QX7EDXsKG7IU4aZoOlXwaQ6ePYQVnOUWc9+n/9F9dZe148064tr+EdPqN/Y551xQXc4E6IaqDEWS7vmVD1OzqcgoR9qekoBruyuKHkdcoWQ7WyW1zyvsvw16BOty5UuGgJAlyT/V7zFRskFHs85g+DyRokk9p9TQGegaYWBRSHUreaWUHjxdR9Tkmek10qM79WPTGojP9TdYM/br3shjE9Gc/tYzg7dqWsv+e9Esd3mrVs6OuSpbeE5O7q0ESJArSz6KJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3094.namprd15.prod.outlook.com (2603:10b6:a03:ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 16:26:04 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.039; Tue, 6 Apr 2021
 16:26:03 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Song Liu <song@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH 1/2] perf util: move bperf definitions to a libperf header
Thread-Topic: [PATCH 1/2] perf util: move bperf definitions to a libperf
 header
Thread-Index: AQHXKCCISAhD2jKzCkmPS3MX7a1o1qqnkAwAgAAixAA=
Date:   Tue, 6 Apr 2021 16:26:03 +0000
Message-ID: <FAF2CD39-4FDB-4E6D-96AB-E246030DF8CC@fb.com>
References: <20210403002938.390878-1-song@kernel.org> <YGxucIgiq+ogX687@krava>
In-Reply-To: <YGxucIgiq+ogX687@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:57e2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c286294-8a01-4dc3-fe37-08d8f918ac62
x-ms-traffictypediagnostic: BYAPR15MB3094:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB30947D67F45DC76C101DD74CB3769@BYAPR15MB3094.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kDN1XwIBGyN6gy3zw5GI9/CJcPchW5rmw0Gzs1eitL2RveMkvQsqKNGTD0evu1Ecs8tYFOvBJi0gmbaa5eFkDDqFDBhVjaDe9GpZSzrDVRtILXNtKxfW1l8MvK1glkzVV+stLErnPFHV9FIWN2B13pPFjLqwzS4flHYXr6FlMKZhxSw518+8//UWjq+4AtCAbBaYsLsyQTfz4koZ7/sgtO+Sb68+k5Lk8qIH52CuKGxn7tfacceuxmQi5KGvhtIBRVKHgKbQtw2Zm0/UEqruPWFA687nLxMsA1Nk3vY5AbEGeZ7p3s6lEpcBOtNf57W2/k1t1XwI50YNOHLmJVlM8w3NRJrCdpJgllz9WH2MfUtsJ7zFawahG8lO71neW7VmolR1f0I7NsyD7spzigkRiqZFC1PsBGyKgWYPNTWT4e9btZOlxYi0PWAZjjR0JTbhsfNiIhd9+CxQsriKtwlAdBSvu40pun6eyrTf5JjREhKHcSwxffudMave8lFcoPwjuuAVQPvGiAGtdQOgfWyNteua3x7Sav3hXZIncrOKRn8xE0nfpFLyqFT5NmoT5UlCEJzZrkOmwVjf75g4CoXya3HEHQcrE3xDNkyoFFBZCuzezA4yo4/rR96aje74LsWYGt2rHkEUVLLPylOXq+TgNVHukp52GOkZ9nisEkjDpt0YX7Ka1EhC/lOMy1inPtnr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(366004)(346002)(396003)(5660300002)(71200400001)(6486002)(8676002)(54906003)(186003)(2616005)(478600001)(316002)(53546011)(86362001)(6916009)(4326008)(33656002)(6512007)(6506007)(66476007)(66946007)(2906002)(76116006)(8936002)(66556008)(83380400001)(91956017)(38100700001)(64756008)(66446008)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Q9FnIvJVqDyypgUuTIth2cRZkhnFd1PbWejMpj9bqrw2ukBiHodFYouf1NRm?=
 =?us-ascii?Q?xvxfLz6lrGdwB0GzSMf+lNGmeG/b8qjZftalTYwjYRHGXwzqLyS6cCN/pkkO?=
 =?us-ascii?Q?f4gSUMzpSXiS9ciyKD2LqOjM3h6zWnAQHyoko1gtVxiiOaIwfBOf+N9gTptb?=
 =?us-ascii?Q?vZ3TDpy6B2m4apuziYXKrMWETttmEPfGkKmv0MDe6RtJTjscQyzK5CJ8O1vQ?=
 =?us-ascii?Q?itpGDmSSDTniLM9qUW6iZfoJNfRAhUTeZpBfc1V9LcRxwPBvCAJmqaIAZd/1?=
 =?us-ascii?Q?JDXezUax28kDyG9GekdLdE3tJ2Cr/xIans031VhvZVYDF7pJUZP8NlKZHUlv?=
 =?us-ascii?Q?lAQZ8JkSZsVmYkFr1+wQn59R4r+ns6LjC4/mYM8WWwP1jQpnmIhCpNN8vj/K?=
 =?us-ascii?Q?0a4WaLR8zPC0VyycswmneoEdefxZetk8RI3EotMVBvYpVjsVbSvD22lRzwkV?=
 =?us-ascii?Q?aP15ijX2vt0IDyTmLn5hnTZ5vUiDn4Dlf1C4bovYaSh229RYZpyc2EROlakO?=
 =?us-ascii?Q?VN0KBfbGzUZud+/5ydIelajWuAOj5LGIFIQQw631OAIvcfdR3Oxw7bWHONLZ?=
 =?us-ascii?Q?CfrwitFgyLYQfeO5SZqOuhE4ZWpCYuVV8oHPWhZDN6Kzdd29IxZujLD+IvFf?=
 =?us-ascii?Q?mpmzQDIwhmb43+UWjpKmG/ufiFYVzPU7rgz7R5jK0B9L6ZfuXKbOp4W86RyY?=
 =?us-ascii?Q?scbTcG4Vp0Di5ECOgHYULwlyzISymil6YWFnuaWbumQmvbNcLWLRoiWqKQo5?=
 =?us-ascii?Q?rBXplzXrTm4jWf333uAv8QOhxEHTSUyncVrMtc15nb5jROwlDH12WbBwsfv/?=
 =?us-ascii?Q?ciPTocelqwhsHdTI6qjTKPNwzA1G3Ykll8hCOpfZTVomInkWDu5z84XjieMN?=
 =?us-ascii?Q?7NIXzEIHwTXJWwypKqcmT18nS0/jrhG1LfywT6AZVJ1/uOe5zF7e5Xyx+Ftt?=
 =?us-ascii?Q?qMozrouTUN/C34aqrN54eKmtw197L5rRrGX3ZF2EBRGgXodAQijB0OuRXyeW?=
 =?us-ascii?Q?nlq9F0+SRntFB/T59pE/oNRYluLyeaM23C+U80eJ6PvlLoEtgczeZ0Gp3ImH?=
 =?us-ascii?Q?qKHJ5v6DG6nu8L1iAS+uFWEXAcULVik0IiTEGXPWkA+Uw8+nZ6cRwBYEB0wL?=
 =?us-ascii?Q?WAoqRhVn2WP7Eoudjj8brYFhs4rihUdcmmkaG2L95oJ8KKzkzjTEBdeev0Kl?=
 =?us-ascii?Q?mvBzCoQzXg4gDDjKLKzaUqge9WmYl4ZlN8byG7po0ML6SY8/MUPyS4zJ4pQq?=
 =?us-ascii?Q?Mga7oPouzaS2sNEyVbTCMhji8uNFaBSVOoYd+rstgRsRLpItTrTWZmemxQ+A?=
 =?us-ascii?Q?W3kG4CHNah1BbXqWxhMjfjuOpv7bicEPaaP1YzErp/HXr9c688VdztmLhlXH?=
 =?us-ascii?Q?gKitzAc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FC734C981216094986F246948E423FDC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c286294-8a01-4dc3-fe37-08d8f918ac62
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 16:26:03.8106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aGpFX+NpfVRif8dFNmc5jJaKpIpAr7Kya4MC0pptNIWM2HinCUgjMf8tmbJjMTAh15tbPYXUpOTqo4RZYlQdEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3094
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: vDln0rgkCpqgrrdUFBRLSs_cnUHruum8
X-Proofpoint-ORIG-GUID: vDln0rgkCpqgrrdUFBRLSs_cnUHruum8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_04:2021-04-06,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 6, 2021, at 7:21 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Fri, Apr 02, 2021 at 05:29:37PM -0700, Song Liu wrote:
>> By following the same protocol, other tools can share hardware PMCs with
>> perf. Move perf_event_attr_map_entry and BPERF_DEFAULT_ATTR_MAP_PATH to
>> bperf.h for other tools to use.
>=20
> hi,
> so is this necessary for some other tool now?

We have monitoring tools do perf_event_open(). I would like to migrate thes=
e
to bperf.=20

>=20
>>=20
>> Also add bperf_attr_map_compatible() to check whether existing attr_map
>> is compatible with current perf binary.
>=20
> please separate this change

Will do.=20

>=20
>>=20
>> Signed-off-by: Song Liu <song@kernel.org>
>> ---
>> tools/lib/perf/include/perf/bperf.h | 29 +++++++++++++++++++
>> tools/perf/util/bpf_counter.c       | 44 ++++++++++++++---------------
>> 2 files changed, 50 insertions(+), 23 deletions(-)
>> create mode 100644 tools/lib/perf/include/perf/bperf.h
>>=20
>> diff --git a/tools/lib/perf/include/perf/bperf.h b/tools/lib/perf/includ=
e/perf/bperf.h
>> new file mode 100644
>> index 0000000000000..02b2fd5e50c75
>> --- /dev/null
>> +++ b/tools/lib/perf/include/perf/bperf.h
>=20
> I wonder we want to call it bpf_perf.h to be more generic?
> or best just bpf.h ... but that might give us some conflict
> headache in future ;-)

I would rather avoid bpf.h... I am ok with bpf_perf.h or bperf.h

>=20
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
>> +#ifndef __LIBPERF_BPERF_H
>> +#define __LIBPERF_BPERF_H
>> +
>> +/*
>> + * bperf uses a hashmap, the attr_map, to track all the leader programs=
.
>> + * The hashmap is pinned in bpffs. flock() on this file is used to ensu=
re
>> + * no concurrent access to the attr_map.  The key of attr_map is struct
>> + * perf_event_attr, and the value is struct perf_event_attr_map_entry.
>> + *
>> + * struct perf_event_attr_map_entry contains two __u32 IDs, bpf_link of=
 the
>> + * leader prog, and the diff_map. Each perf-stat session holds a refere=
nce
>> + * to the bpf_link to make sure the leader prog is attached to sched_sw=
itch
>> + * tracepoint.
>> + *
>> + * Since the hashmap only contains IDs of the bpf_link and diff_map, it
>> + * does not hold any references to the leader program. Once all perf-st=
at
>> + * sessions of these events exit, the leader prog, its maps, and the
>> + * perf_events will be freed.
>> + */
>> +struct perf_event_attr_map_entry {
>> +	__u32 link_id;
>> +	__u32 diff_map_id;
>> +};
>=20
> this header file should be self contained,
> so you need __u32 definitions

Will add.=20

>=20
>=20
>> +
>> +/* pin the map at sysfs__mountpoint()/BPERF_DEFAULT_ATTR_MAP_PATH */
>> +#define BPERF_DEFAULT_ATTR_MAP_PATH "fs/bpf/perf_attr_map"
>=20
> if we are going to expose this, I think we should expose just
> "perf_attr_map" ... without the 'fs/bpf' part, because that
> could be mounted anywhere

Will fix this.=20

Thanks,
Song

