Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867AF340B81
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhCRRQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:16:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35834 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229723AbhCRRQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:16:30 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12IGv5EW000684;
        Thu, 18 Mar 2021 10:16:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=2NRnUoABY/xzkIqqOZtSzKj08H0aWP+8MGo3iSVXhog=;
 b=kPa4quX/EJh4wGqMP3XL1PPmamy8QKPJ0BBQr6SEq+dSJD/HQh+2ccz0QfvLlfYDK7a/
 zTo8QOBXKPnDQHoITHf/uCgj54E75hoxApINreU8ltey/2654cWPFJGFS4fVPxOdpyum
 MX14KRpqnHv5hreznFwFk6D4afkTdaZDEw4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 37bs26ngeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Mar 2021 10:16:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 18 Mar 2021 10:16:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoIdtr9bfhh2JnSPpb7pSauBc/MXW/WHwOCvG06jWBmJH09QCZOHbougraR7et6PDgDYptT5QWqHOGoX1CJnqWwTyZDPh3hwvrZmN0H8nL4OM1NfFZ1qnDGFwrVfya6XFh7hr2JubnSdmO6uMKCRjhdaqygd2QdIrKNviSaybGefI7j8+HytYLKOwtpF9KecNKUEbQNbuqvfAR8lNpVdeLlLCo23X2s63x7cCesplAdRE2IxKdfI0fkMG1IqLSV3KLqGKKOrPoMOX2NJ1nH7WaBkQKduEl8LEkspe1fRs9276k6CGtEtEE/aP6FeXtJ7jzygFs+z8cf7IaQjPfJghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NRnUoABY/xzkIqqOZtSzKj08H0aWP+8MGo3iSVXhog=;
 b=JNBx/VYWRVPtKBZ/RtO25ggC4Rb9uBJxDilZNSKvVyay+CGcObn11dpGtORm0g7G+KW0b2GoR2lR9UsvxiPVlpn0S901envjoNn0x6PaepASmOHfwxk/Btid1FOdcX2JfDHUVasi7Svsgd9WCHgnKdZKKwhQId5lLwaNRKyycr8LOM3PyaCLYCw5lPNQVggo/Gwd5cdTyVOesdI8T3yToG2jhk5fEt0xFfybhkMAHKNYt89Om4gAHSXIK+L9ZXxpEnSYRtEDrg5dsiHsZ2TtJwgGGtS/IHMcKjOdXDdUOG08XPlHY+3NLt37xEsQPesmRfJAoopYfswfnlDg5Q2dcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by SJ0PR15MB4520.namprd15.prod.outlook.com (2603:10b6:a03:379::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 17:16:24 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 17:16:24 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 1/3] perf-stat: introduce bperf, share hardware PMCs
 with BPF
Thread-Topic: [PATCH v2 1/3] perf-stat: introduce bperf, share hardware PMCs
 with BPF
Thread-Index: AQHXGqoOnn6PYztrGkqjWdJT1tFfMKqJQQYAgAAYjYCAAGw9gIAAObOA
Date:   Thu, 18 Mar 2021 17:16:24 +0000
Message-ID: <D8EF49AA-D49D-40B6-B1BD-0182E08CBD2B@fb.com>
References: <20210316211837.910506-1-songliubraving@fb.com>
 <20210316211837.910506-2-songliubraving@fb.com>
 <CAM9d7cgqqj5_Koe_dxBxsEXqLFS6d8VOoSwkiVaEO79V55JcxQ@mail.gmail.com>
 <5816B9E5-1664-4D66-9128-EFC2EEE089B2@fb.com>
 <CAM9d7cg7PyKjdWFmv_0B+sz4TDciGGyNkRTC1p+DoXBOn-xXRg@mail.gmail.com>
In-Reply-To: <CAM9d7cg7PyKjdWFmv_0B+sz4TDciGGyNkRTC1p+DoXBOn-xXRg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:591]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a5392ae-0d86-48be-daab-08d8ea318ed0
x-ms-traffictypediagnostic: SJ0PR15MB4520:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR15MB4520B55EFD105DACC555797BB3699@SJ0PR15MB4520.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LnY788cvI3Sfm2UoRyxxnnRbw1xNw06aAXASiHr+9M83q9HMd3qwmZUG6rfKVqQsiiJCKMTnu+G5FVrYF+FxStUEDK2kk7vftwnyjYqAAZgR1qD6+yVtuQwiRGFt+GGU3skkDTKxtFSq5Bz59JYMIZ5PHkc0PmF6l3j1xgCXDtL4TXa2UjQaxSMOKaPzuEt/AEvlg6UpT4lecQAtaCK58Ou9NUkuLyX24Lt9tkTssWAjviUjWylXBWhR6odgv8qCQutLSjsEInMJU42Q4EUzgvIJKymEK0kgZYQ+Cs0FY/qa5p0ex+tYG46TVoUscEi4waHvCXPsmGK2EPh26cHtj3N+7I5i7Dbkb+rwgq2Lbuv81/7k24epm9U+pZBilC7il9vHxWDil0mJOgrytqTA+noVZ5zoxuKU+6D7441kch7I7U4Xm0XEiOKDqELV+Q7w5w+DvtBT9dHt9cA2G87jooWelzSfbproCd+BRJhIroehPAbqVbgbuTbIp0CiwgEeBYg+mYYqlU3fbn3GlVUFDaMx/tXB4wlXaGqy3hzmnJaSmBwMYTGV4x4qpKAfljq/iuzsmfT5RwhVkYHWpYYAzgeLCMi0y7WfZOp+uowNf34AlA0m855UWMH3ra+1uzY4ZV0iyYb2gsYQlaOFdHWXPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(376002)(136003)(346002)(4326008)(86362001)(71200400001)(66946007)(76116006)(54906003)(66556008)(6506007)(8676002)(38100700001)(83380400001)(53546011)(316002)(2616005)(6486002)(33656002)(36756003)(5660300002)(8936002)(6512007)(478600001)(64756008)(66476007)(186003)(6916009)(66446008)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?srlDcvzHYHijiJ9OvtsDEA2igTBbakQlNMsZs9QDNKnu1nPGsyN0H/7iurwN?=
 =?us-ascii?Q?+bmntrxG9DXUXbQOr++xIh6l121nVpOWTnUMhMg8PUlmekkanFzxOZSzoghL?=
 =?us-ascii?Q?sGP0k/Htf6JXam8eyuIwxo6SDZPbwCcNSxUxR/q0q/97iUxDRvHK4e7zY/lN?=
 =?us-ascii?Q?6jqJibkdvnTVDFXk1KdLMsxrLKcQHK2hZ4fOiY66kvYL5mK9fgEbFxy6CW6D?=
 =?us-ascii?Q?hmNMkIjxedIE5k34Ap56eaiTA2nnPUIRgHk+EF/2fOJttfHP8O+MxRRH9xZ2?=
 =?us-ascii?Q?aCMpF7XklbqrxS34QpYDOGNhf6D4f7Qt/8WYmKj8YciZjQi9imaJdYxGdh/g?=
 =?us-ascii?Q?co3VnFp3Kxqocv2twrAc0uqZkw0mmKe2xptY/VgNSeoygbTZ84AJsnyBCPzq?=
 =?us-ascii?Q?nBfg04mAN4TNd0cpFGdKiogRJYu5CALq+mxagzgNfmiH3tg2eY6uJYHjdQdI?=
 =?us-ascii?Q?d932tdBlkvklSi3rU2wzLFPyKkkuq1NK50xNOldR5objgEhskzY3SSLSrRSG?=
 =?us-ascii?Q?suOdhPmoaRq/K5crucVDw9uOBSWQJONx53RI0NTkGuOgDTrLhJwirGqi8KsP?=
 =?us-ascii?Q?ltZidn3YUtSQJnFGzI9A/4xz5yP97fqqW7FhlMntJICjMcsQHtPYDgReB5AP?=
 =?us-ascii?Q?YN1wBfsim6uMluusnSowQlHGPRdFIf1x/9SJFNrHThiFwrlUEUAN74V/yZKv?=
 =?us-ascii?Q?BEFfkvGbvJ3yCKdjTDy3kMZZ6bQbI59cAhMyC4hjvxi4d5gH8+9ZILbDMLs5?=
 =?us-ascii?Q?XXkNKIhZwmVtCt+ZhReuTLvjeK+fIZRTl66hE7fWTIgMO/xu/IBf1bZ+mE3z?=
 =?us-ascii?Q?gYzClPYSQsi+wCdOPHTdhpwZzwZttfEvC/2aZ0S9uCm3GZamEuCFxVDrmLBY?=
 =?us-ascii?Q?+yYYVNASgWLRATKsYdQ4cMbPBsHUICdL6vSb6M/i1lBURm07wpUhaD5dTXP3?=
 =?us-ascii?Q?A7VkRd7SlMXK7GUMSKFecT9ElFipKS6YjhgHi4QKKawJ9LKOCXBI7ng3HTAr?=
 =?us-ascii?Q?2oYzIFyVSXHnThZpcpkkzMVm5Ui8dux13GFZeddRmUvgI5Pc4e7QgGXewcRd?=
 =?us-ascii?Q?H9RDgYXOK1E/cLYza2lrpk6hWujT5hJZJAc+DpzI1NES0F+321Hl65fKGzfb?=
 =?us-ascii?Q?1wG4TxhRQhsvjcE2JKiF4eKoAe+PA0XZd6R5q1bjuUzl/FWQwc0CoT7g6VA3?=
 =?us-ascii?Q?y0X2jx0zKqOqMnZz2ZSTMGKcnZVfB8Ln1ppmxO4eRN1hQQj6oXrOJgtAFquw?=
 =?us-ascii?Q?7Dq318RoKaKE0w/tDq/bS70SHwVopIYdcDiWGjjwrfdsNLR6pMYtQ4j5X0y5?=
 =?us-ascii?Q?iRqmwtrIQzrCd5+tfO1A8DzfDInJWOZmdon87OCu2Vcm/pHzMcrTTnbVgkV3?=
 =?us-ascii?Q?pqPjT9g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4A4ABE4BA430444D98E885ACCC2A039A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5392ae-0d86-48be-daab-08d8ea318ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 17:16:24.2175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hrH3ExKeokJBcMd6X9qQ6c1IK88FysWRpjiSYiPsgLq8MUNB1tq7KdEE79DBn1whfS8O1/AgBFJ6yzIxJbx4CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4520
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_09:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103180121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 18, 2021, at 6:49 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> On Thu, Mar 18, 2021 at 4:22 PM Song Liu <songliubraving@fb.com> wrote:
>>=20
>>=20
>>=20
>>> On Mar 17, 2021, at 10:54 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>>>=20
>>=20
>> [...]
>>=20
>>>> +
>>>> +static int bperf_reload_leader_program(struct evsel *evsel, int attr_=
map_fd,
>>>> +                                      struct perf_event_attr_map_entr=
y *entry)
>>>> +{
>>>> +       struct bperf_leader_bpf *skel =3D bperf_leader_bpf__open();
>>>> +       int link_fd, diff_map_fd, err;
>>>> +       struct bpf_link *link =3D NULL;
>>>> +
>>>> +       if (!skel) {
>>>> +               pr_err("Failed to open leader skeleton\n");
>>>> +               return -1;
>>>> +       }
>>>> +
>>>> +       bpf_map__resize(skel->maps.events, libbpf_num_possible_cpus())=
;
>>>> +       err =3D bperf_leader_bpf__load(skel);
>>>> +       if (err) {
>>>> +               pr_err("Failed to load leader skeleton\n");
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       err =3D -1;
>>>> +       link =3D bpf_program__attach(skel->progs.on_switch);
>>>> +       if (!link) {
>>>> +               pr_err("Failed to attach leader program\n");
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       link_fd =3D bpf_link__fd(link);
>>>> +       diff_map_fd =3D bpf_map__fd(skel->maps.diff_readings);
>>>> +       entry->link_id =3D bpf_link_get_id(link_fd);
>>>> +       entry->diff_map_id =3D bpf_map_get_id(diff_map_fd);
>>>> +       err =3D bpf_map_update_elem(attr_map_fd, &evsel->core.attr, en=
try, BPF_ANY);
>>>> +       assert(err =3D=3D 0);
>>>> +
>>>> +       evsel->bperf_leader_link_fd =3D bpf_link_get_fd_by_id(entry->l=
ink_id);
>>>> +       assert(evsel->bperf_leader_link_fd >=3D 0);
>>>=20
>>> Isn't it the same as link_fd?
>>=20
>> This is a different fd on the same link.
>=20
> Ok
>=20
>>=20
>>>=20
>>>> +
>>>> +       /*
>>>> +        * save leader_skel for install_pe, which is called within
>>>> +        * following evsel__open_per_cpu call
>>>> +        */
>>>> +       evsel->leader_skel =3D skel;
>>>> +       evsel__open_per_cpu(evsel, all_cpu_map, -1);
>>>> +
>>>> +out:
>>>> +       bperf_leader_bpf__destroy(skel);
>>>> +       bpf_link__destroy(link);
>>>=20
>>> Why do we destroy it?  Is it because we get an another reference?
>>=20
>> Yes. We only need evsel->bperf_leader_link_fd to keep the whole
>> skeleton attached.
>>=20
>> When multiple perf-stat sessions are sharing the leader skeleton,
>> only the first one loads the leader skeleton, by calling
>> bperf_reload_leader_program(). Other sessions simply hold a fd to
>> the bpf_link. More explanation in bperf__load() below.
>=20
> Ok.
>=20
>>=20
>>=20
>>>=20
>>>> +       return err;
>>>> +}
>>>> +
>>>> +static int bperf__load(struct evsel *evsel, struct target *target)
>>>> +{
>>>> +       struct perf_event_attr_map_entry entry =3D {0xffffffff, 0xffff=
ffff};
>>>> +       int attr_map_fd, diff_map_fd =3D -1, err;
>>>> +       enum bperf_filter_type filter_type;
>>>> +       __u32 filter_entry_cnt, i;
>>>> +
>>>> +       if (bperf_check_target(evsel, target, &filter_type, &filter_en=
try_cnt))
>>>> +               return -1;
>>>> +
>>>> +       if (!all_cpu_map) {
>>>> +               all_cpu_map =3D perf_cpu_map__new(NULL);
>>>> +               if (!all_cpu_map)
>>>> +                       return -1;
>>>> +       }
>>>> +
>>>> +       evsel->bperf_leader_prog_fd =3D -1;
>>>> +       evsel->bperf_leader_link_fd =3D -1;
>>>> +
>>>> +       /*
>>>> +        * Step 1: hold a fd on the leader program and the bpf_link, i=
f
>>>> +        * the program is not already gone, reload the program.
>>>> +        * Use flock() to ensure exclusive access to the perf_event_at=
tr
>>>> +        * map.
>>>> +        */
>>>> +       attr_map_fd =3D bperf_lock_attr_map(target);
>>>> +       if (attr_map_fd < 0) {
>>>> +               pr_err("Failed to lock perf_event_attr map\n");
>>>> +               return -1;
>>>> +       }
>>>> +
>>>> +       err =3D bpf_map_lookup_elem(attr_map_fd, &evsel->core.attr, &e=
ntry);
>>>> +       if (err) {
>>>> +               err =3D bpf_map_update_elem(attr_map_fd, &evsel->core.=
attr, &entry, BPF_ANY);
>>>> +               if (err)
>>>> +                       goto out;
>>>> +       }
>>>> +
>>>> +       evsel->bperf_leader_link_fd =3D bpf_link_get_fd_by_id(entry.li=
nk_id);
>>>> +       if (evsel->bperf_leader_link_fd < 0 &&
>>>> +           bperf_reload_leader_program(evsel, attr_map_fd, &entry))
>>>> +               goto out;
>>=20
>> Continue with previous explanation. In bperf_reload_leader_program(),
>> we open another reference to the link, and destroy the skeleton. This
>> brings the code to the same state as evsel->bperf_leader_link_fd >=3D
>> condition above.
>=20
> Thanks for the explanation.
>=20
>>=20
>>>> +
>>>> +       /*
>>>> +        * The bpf_link holds reference to the leader program, and the
>>>> +        * leader program holds reference to the maps. Therefore, if
>>>> +        * link_id is valid, diff_map_id should also be valid.
>>>> +        */
>>>> +       evsel->bperf_leader_prog_fd =3D bpf_prog_get_fd_by_id(
>>>> +               bpf_link_get_prog_id(evsel->bperf_leader_link_fd));
>>>> +       assert(evsel->bperf_leader_prog_fd >=3D 0);
>>>> +
>>>> +       diff_map_fd =3D bpf_map_get_fd_by_id(entry.diff_map_id);
>>>> +       assert(diff_map_fd >=3D 0);
>>>> +
>>=20
>> [...]
>>=20
>>>> +static int bperf__read(struct evsel *evsel)
>>>> +{
>>>> +       struct bperf_follower_bpf *skel =3D evsel->follower_skel;
>>>> +       __u32 num_cpu_bpf =3D cpu__max_cpu();
>>>> +       struct bpf_perf_event_value values[num_cpu_bpf];
>>>> +       int reading_map_fd, err =3D 0;
>>>> +       __u32 i, j, num_cpu;
>>>> +
>>>> +       bperf_sync_counters(evsel);
>>>> +       reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);
>>>> +
>>>> +       for (i =3D 0; i < bpf_map__max_entries(skel->maps.accum_readin=
gs); i++) {
>>>> +               __u32 cpu;
>>>> +
>>>> +               err =3D bpf_map_lookup_elem(reading_map_fd, &i, values=
);
>>>> +               if (err)
>>>> +                       goto out;
>>>> +               switch (evsel->follower_skel->bss->type) {
>>>> +               case BPERF_FILTER_GLOBAL:
>>>> +                       assert(i =3D=3D 0);
>>>> +
>>>> +                       num_cpu =3D all_cpu_map->nr;
>>>> +                       for (j =3D 0; j < num_cpu; j++) {
>>>> +                               cpu =3D all_cpu_map->map[j];
>>>> +                               perf_counts(evsel->counts, cpu, 0)->va=
l =3D values[cpu].counter;
>>>> +                               perf_counts(evsel->counts, cpu, 0)->en=
a =3D values[cpu].enabled;
>>>> +                               perf_counts(evsel->counts, cpu, 0)->ru=
n =3D values[cpu].running;
>>>=20
>>> I'm confused with this.  Does the accum_readings map contain values
>>> for all cpus?  IIUC it has only a single entry but you access it for ea=
ch cpu.
>>> What am I missing?
>>=20
>> accumulated_reading is a percpu array. In this case, each cpu has its ow=
n
>> bpf_perf_event_value with index 0. The BPF program could only access the
>> data on current cpu. When reading from use space, we get #-of-cpus entri=
es
>> for index 0.
>>=20
>> Does this make sense?
>=20
> Yep, I didn't know it returns all values when reading from user space.  T=
hen
> I think per cpu event doesn't have many entries too.  Like the global cas=
e
> it can simply put the value with key 0, no?

Current per cpu event use same logic as per task events, so we do have mult=
iple
entries. I think it is possible to modify the logic to use one entry for pe=
r
cpu events.=20

Thanks,
Song


