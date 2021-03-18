Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5425C34002F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 08:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCRHXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 03:23:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22966 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229454AbhCRHWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 03:22:36 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12I7KlwF007946;
        Thu, 18 Mar 2021 00:22:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Riaex7WlIMkC7VPoiWprvDBhv85u8izjqTa+7OEfY+c=;
 b=hePLwYWO5KRfBcS//4WqayqzyZXhOVjOVq97R3RWJrCXjKex+BvqrHlpQDCzFFWwULOB
 5+qn3rs1R9t9Eq+LdplY3hiiQFB08nfcEPWAz5cPAhOcllYuVo2CwZf2t5ssEx1qc5Sk
 NTyPxvLFCqf574uSQc9UNGO5GmeqZHK8wzY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37b3bs1ehp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Mar 2021 00:22:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 18 Mar 2021 00:22:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Caj9NdyJOJPfwsjwCLKsitaLZ9HpOF1w7YD1dnt/vlDUMH9TsWvKW0MsOtY5xCaXPa2yOuXm04KYbEF6TDtlD5QWPZoqMTulCwwWbCSRS+XepQC2lstqIBHKxaRKy6qwn4/2hDI2svyT0RuUX/9UJspV5fRO7edb6aUhaQ9txK68eLB8YQX2ilT7S4b+1A7q3/NMzDNe858AxRG1QyBLu1++jKuDXya5q97pipWulTCnKUEvRNfPGFK3aufEbcgFe7jeRdYMMKoMwt6s47dfo5Kl92foHZNmOAql/romctfih3V3+FKJXoXdzp4DwAl0R6z7U8gd6uo4pHEO45qmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Riaex7WlIMkC7VPoiWprvDBhv85u8izjqTa+7OEfY+c=;
 b=hb7ZymZHSUAABSUaaQeBvgTffRFn7JGcoOQPeWi8gJhi4QF54XX55Kjuu3zgbmPdbvmTHCX5X+ILpuK1RA8CFdXId4FyMPqyYhOsJMjsSVJNUg0nWLoM7qTmzE6oADdxxK2ie+4iLa7J2cg9MTGNu76pQxxxlhQIzc1hJFEiEy7Jrt9L8Ha7AUOY0OvWmrHd9/InWmcD3aVeqK2FZL8nGa+y2VNsLsEnGW2j3SLgBY0I2XQ78hRUE94H6V2WubXFJ0t3h1idRGcKXXjJuTE6coS1GA6RXpnD3tcVO2MTMJTH3rMCuF109M2+P4lLQvCqifgrFaafnI0otKXbigxoCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2728.namprd15.prod.outlook.com (2603:10b6:a03:14c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 07:22:30 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 07:22:30 +0000
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
Thread-Index: AQHXGqoOnn6PYztrGkqjWdJT1tFfMKqJQQYAgAAYjYA=
Date:   Thu, 18 Mar 2021 07:22:30 +0000
Message-ID: <5816B9E5-1664-4D66-9128-EFC2EEE089B2@fb.com>
References: <20210316211837.910506-1-songliubraving@fb.com>
 <20210316211837.910506-2-songliubraving@fb.com>
 <CAM9d7cgqqj5_Koe_dxBxsEXqLFS6d8VOoSwkiVaEO79V55JcxQ@mail.gmail.com>
In-Reply-To: <CAM9d7cgqqj5_Koe_dxBxsEXqLFS6d8VOoSwkiVaEO79V55JcxQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:591]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2558fbb3-b861-4c3a-d578-08d8e9de9757
x-ms-traffictypediagnostic: BYAPR15MB2728:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB272861374BAFEECA1F67AC96B3699@BYAPR15MB2728.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5rowlc831JuOODNN70HAhHiXEWcWNfIqEf5iyzSc/PypGSTVjjoKs2ndUJqoOTDqCajfDpRfiwIqRRxp7MxPiR2IW5Hhqt+QXjGF8Xj4nKz1Meup2ThleNzh1SaTJgKGBEpQ6d6LZqkBk6lpFzhXtD451aXh74cgJ4mHHZYmP4JkrIsJ0M2EaXVyj95JyKT0pMH/HdN2ez/2Zwidh+e85xtWlh2oCqoGR/ACGec6xFOIcbYQoufic0zCT65jShI/IIIx8/3Jv5fXbPmyJzG1eBy1EdIB4j/A+ZisF+B90u5DmukhlwNGvF82I9k6th+UGUAyzO9RAevzRBvIt4vr4MSaGgP24AjJFXzp2DoddKL+CVWXBqJBZ9WaersyfBXI4AB1XPWf/0kr1YOAJ0GOQkVAS1gqtXly6F7VWMoEu8k0ki15sguZ5Gi6wjJOHYA5jp10MYQHjQO0IuaJvJ3MRec97I5R4JaYVnPk7zX+L4x/P48HSrOA2kZVFzMc8Bmc9Ih3/5BKG5glhbKaYLXSuuZws1LkNQ+d12lD5XaUWmDYCvkWZYMJvpksRknNzzB//eRuwW0va79f21dwMjRO1YiRxklcPI74XVbpGE1o2PcTZ2YPL5dpr82UTqBYa/+A7t57sZbgQmzfL9cvVyuO5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(366004)(376002)(346002)(54906003)(4326008)(38100700001)(33656002)(86362001)(186003)(6512007)(5660300002)(2906002)(6916009)(6486002)(53546011)(6506007)(76116006)(83380400001)(66446008)(66476007)(66556008)(64756008)(66946007)(71200400001)(8676002)(8936002)(478600001)(91956017)(316002)(2616005)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Z/Le2bhVW7g10RNmiydr4Azjb2cp5Tx0WEEylonpXnJG1FvXR6ORd7kHUwgt?=
 =?us-ascii?Q?VjN9ssIWgXHjy0rfCIVCPmZv+ywaQ5fpWxDWFG3hi7A8/+3r7HbfMUy5eP5J?=
 =?us-ascii?Q?1BNMdghMxcTRYQaWbqbpRQabvae8xZ/yzAsq2X2uURkf14QBzrlqx4Ddi4dG?=
 =?us-ascii?Q?ovCvNOs9QW5Bs+Uq5gy2mjZww/2tLvotAPQsZ3U8l075cFkB9p5cwwWz8rQn?=
 =?us-ascii?Q?ZcMRZxecv6VP+uORMA+nD7EUyo2bm3rtdYafeCwLZNVoW6E0tB+/2nUXrjYd?=
 =?us-ascii?Q?VEEOW5nlk9LxdMy7vISjDgheGMpqor5innLsvUO0jp/CBiM5EdT94CDJko1o?=
 =?us-ascii?Q?PLmNh8jbkWVz5Q3kk9ZwDGhm7i31j2vGvBwK1Sn1+rQLyRkVLzJdITmq77Dq?=
 =?us-ascii?Q?J2AiGY4x12CkBOcWlpW+PbIan85uWTRwic6RhQmnuaBBLtQ9dsDcIWKbNWmK?=
 =?us-ascii?Q?kW0lKdo/oi2HGdPHGEeOcdXgVop0o7MEcXRO+krJwl8q6eRB069R5+3MdRxK?=
 =?us-ascii?Q?rcne0eyo/VhB6EgB4YsCbxEw/0yeeOHo4Nz7Pjqah4kw/sh8UfCSca2Tzmcr?=
 =?us-ascii?Q?mYDvmlhPn6ejRjsTAbxcU0HZfTUf67lYnUM4ih211lBsKQnMYxn7LkjiUAOC?=
 =?us-ascii?Q?wVvs5VI8AusFMhiWfmBUruqmOHmxRmfS599G4LbLr3vPbRm1lLzywn5ld5U9?=
 =?us-ascii?Q?AaQzxP2R3K5YyIijS0xN+H4G12Gfu7QTza+9KfHGVvIze7xV7zdEPHm5kJzH?=
 =?us-ascii?Q?Ux4U6jWLhdBzeznUyZxks1rODB+H9eyFGLcd+eDouoLYIWxf8sOEXfc+gsL0?=
 =?us-ascii?Q?gDUOrdcTpcsFvlgtF5jWmJnwaT+lVfVI5H5yo3reURfsYpmXycO9d1JCtDi4?=
 =?us-ascii?Q?TLJmFVaed7+wOcaOfW/l+E5kbZf+ObQWDqikqt5pOqbvfAW0NPtlslkfqP+Q?=
 =?us-ascii?Q?aW0/QJrv0MW/C91Jzuc6zRNcweHCT94r9PB6zj2fewXCVze48eKA8LzXmbLp?=
 =?us-ascii?Q?hc6tE2Q2RQBYD/xvD2TsR+xfiQgZrArJf3pAbI9JPV9ey+MuXG4ZKKC3p+in?=
 =?us-ascii?Q?8244mMaqp2xcAdmw9gYCYIUc9L2BqwYlf0CdFlg6lntvtureXa95SaBmM931?=
 =?us-ascii?Q?ZJOo55gsQ7wMR+HAHVrFsbglr5Tkyub5axBhJyt7GaPeWXH9HGKD/r8hSXrT?=
 =?us-ascii?Q?gl+2mtQzth5BXMgv2EM6mgMuy06RB8YCkjK+g4PO+W2lxPAgHPlAZ5Oc823e?=
 =?us-ascii?Q?wLZ6/MnxO0l/2WdlUv8tTn3RJcQW+CnbWhp9aZwAiz/pAIpQZ+x12+PZOaoi?=
 =?us-ascii?Q?0L99YfLn+SqSL/aPS7twuoZG/TJnMAOnSrGhJdabt/tMwHMDbMrLMam9BmCz?=
 =?us-ascii?Q?pJzIMnY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F31BC1FB6E2A94CB8E861AB49863137@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2558fbb3-b861-4c3a-d578-08d8e9de9757
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 07:22:30.2463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PEdsB1KthAmvNhd1fJewAfIo1xfAGwPUzbPkN09jG1O2Rzg62Kz+byDRex6Ws7GZcRKVB2e0F8jftzadsEsMSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2728
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_02:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103180055
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 17, 2021, at 10:54 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20

[...]

>> +
>> +static int bperf_reload_leader_program(struct evsel *evsel, int attr_ma=
p_fd,
>> +                                      struct perf_event_attr_map_entry =
*entry)
>> +{
>> +       struct bperf_leader_bpf *skel =3D bperf_leader_bpf__open();
>> +       int link_fd, diff_map_fd, err;
>> +       struct bpf_link *link =3D NULL;
>> +
>> +       if (!skel) {
>> +               pr_err("Failed to open leader skeleton\n");
>> +               return -1;
>> +       }
>> +
>> +       bpf_map__resize(skel->maps.events, libbpf_num_possible_cpus());
>> +       err =3D bperf_leader_bpf__load(skel);
>> +       if (err) {
>> +               pr_err("Failed to load leader skeleton\n");
>> +               goto out;
>> +       }
>> +
>> +       err =3D -1;
>> +       link =3D bpf_program__attach(skel->progs.on_switch);
>> +       if (!link) {
>> +               pr_err("Failed to attach leader program\n");
>> +               goto out;
>> +       }
>> +
>> +       link_fd =3D bpf_link__fd(link);
>> +       diff_map_fd =3D bpf_map__fd(skel->maps.diff_readings);
>> +       entry->link_id =3D bpf_link_get_id(link_fd);
>> +       entry->diff_map_id =3D bpf_map_get_id(diff_map_fd);
>> +       err =3D bpf_map_update_elem(attr_map_fd, &evsel->core.attr, entr=
y, BPF_ANY);
>> +       assert(err =3D=3D 0);
>> +
>> +       evsel->bperf_leader_link_fd =3D bpf_link_get_fd_by_id(entry->lin=
k_id);
>> +       assert(evsel->bperf_leader_link_fd >=3D 0);
>=20
> Isn't it the same as link_fd?

This is a different fd on the same link.=20

>=20
>> +
>> +       /*
>> +        * save leader_skel for install_pe, which is called within
>> +        * following evsel__open_per_cpu call
>> +        */
>> +       evsel->leader_skel =3D skel;
>> +       evsel__open_per_cpu(evsel, all_cpu_map, -1);
>> +
>> +out:
>> +       bperf_leader_bpf__destroy(skel);
>> +       bpf_link__destroy(link);
>=20
> Why do we destroy it?  Is it because we get an another reference?

Yes. We only need evsel->bperf_leader_link_fd to keep the whole=20
skeleton attached.=20

When multiple perf-stat sessions are sharing the leader skeleton,=20
only the first one loads the leader skeleton, by calling=20
bperf_reload_leader_program(). Other sessions simply hold a fd to=20
the bpf_link. More explanation in bperf__load() below. =20


>=20
>> +       return err;
>> +}
>> +
>> +static int bperf__load(struct evsel *evsel, struct target *target)
>> +{
>> +       struct perf_event_attr_map_entry entry =3D {0xffffffff, 0xffffff=
ff};
>> +       int attr_map_fd, diff_map_fd =3D -1, err;
>> +       enum bperf_filter_type filter_type;
>> +       __u32 filter_entry_cnt, i;
>> +
>> +       if (bperf_check_target(evsel, target, &filter_type, &filter_entr=
y_cnt))
>> +               return -1;
>> +
>> +       if (!all_cpu_map) {
>> +               all_cpu_map =3D perf_cpu_map__new(NULL);
>> +               if (!all_cpu_map)
>> +                       return -1;
>> +       }
>> +
>> +       evsel->bperf_leader_prog_fd =3D -1;
>> +       evsel->bperf_leader_link_fd =3D -1;
>> +
>> +       /*
>> +        * Step 1: hold a fd on the leader program and the bpf_link, if
>> +        * the program is not already gone, reload the program.
>> +        * Use flock() to ensure exclusive access to the perf_event_attr
>> +        * map.
>> +        */
>> +       attr_map_fd =3D bperf_lock_attr_map(target);
>> +       if (attr_map_fd < 0) {
>> +               pr_err("Failed to lock perf_event_attr map\n");
>> +               return -1;
>> +       }
>> +
>> +       err =3D bpf_map_lookup_elem(attr_map_fd, &evsel->core.attr, &ent=
ry);
>> +       if (err) {
>> +               err =3D bpf_map_update_elem(attr_map_fd, &evsel->core.at=
tr, &entry, BPF_ANY);
>> +               if (err)
>> +                       goto out;
>> +       }
>> +
>> +       evsel->bperf_leader_link_fd =3D bpf_link_get_fd_by_id(entry.link=
_id);
>> +       if (evsel->bperf_leader_link_fd < 0 &&
>> +           bperf_reload_leader_program(evsel, attr_map_fd, &entry))
>> +               goto out;

Continue with previous explanation. In bperf_reload_leader_program(),=20
we open another reference to the link, and destroy the skeleton. This=20
brings the code to the same state as evsel->bperf_leader_link_fd >=3D=20
condition above.=20

>> +
>> +       /*
>> +        * The bpf_link holds reference to the leader program, and the
>> +        * leader program holds reference to the maps. Therefore, if
>> +        * link_id is valid, diff_map_id should also be valid.
>> +        */
>> +       evsel->bperf_leader_prog_fd =3D bpf_prog_get_fd_by_id(
>> +               bpf_link_get_prog_id(evsel->bperf_leader_link_fd));
>> +       assert(evsel->bperf_leader_prog_fd >=3D 0);
>> +
>> +       diff_map_fd =3D bpf_map_get_fd_by_id(entry.diff_map_id);
>> +       assert(diff_map_fd >=3D 0);
>> +

[...]

>> +static int bperf__read(struct evsel *evsel)
>> +{
>> +       struct bperf_follower_bpf *skel =3D evsel->follower_skel;
>> +       __u32 num_cpu_bpf =3D cpu__max_cpu();
>> +       struct bpf_perf_event_value values[num_cpu_bpf];
>> +       int reading_map_fd, err =3D 0;
>> +       __u32 i, j, num_cpu;
>> +
>> +       bperf_sync_counters(evsel);
>> +       reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);
>> +
>> +       for (i =3D 0; i < bpf_map__max_entries(skel->maps.accum_readings=
); i++) {
>> +               __u32 cpu;
>> +
>> +               err =3D bpf_map_lookup_elem(reading_map_fd, &i, values);
>> +               if (err)
>> +                       goto out;
>> +               switch (evsel->follower_skel->bss->type) {
>> +               case BPERF_FILTER_GLOBAL:
>> +                       assert(i =3D=3D 0);
>> +
>> +                       num_cpu =3D all_cpu_map->nr;
>> +                       for (j =3D 0; j < num_cpu; j++) {
>> +                               cpu =3D all_cpu_map->map[j];
>> +                               perf_counts(evsel->counts, cpu, 0)->val =
=3D values[cpu].counter;
>> +                               perf_counts(evsel->counts, cpu, 0)->ena =
=3D values[cpu].enabled;
>> +                               perf_counts(evsel->counts, cpu, 0)->run =
=3D values[cpu].running;
>=20
> I'm confused with this.  Does the accum_readings map contain values
> for all cpus?  IIUC it has only a single entry but you access it for each=
 cpu.
> What am I missing?

accumulated_reading is a percpu array. In this case, each cpu has its own=20
bpf_perf_event_value with index 0. The BPF program could only access the=20
data on current cpu. When reading from use space, we get #-of-cpus entries=
=20
for index 0. =20

Does this make sense?

Thanks,
Song

