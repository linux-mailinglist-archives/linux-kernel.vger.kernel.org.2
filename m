Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2812345444
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhCWAyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:54:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35404 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230363AbhCWAyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:54:04 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12N0jDuQ017908;
        Mon, 22 Mar 2021 17:54:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FJbkxO1FK7tastRDepSijEmFCdl+BO8to6i0+M1XVqQ=;
 b=TMoCR//4mE2B6kedYDYRXux3Jr0umccgkxBa2G+iR+zUIMDekHvs4x8Mu3GYUg9kQ5xa
 yLyT3t4nnzldjhvBbzfRFIj+MIWh+z/Xr+v5sr4s1jN9tauyoWZ2t8dSlK/U8oomeqGM
 2dneLTw41Boj0CMO9zJWPKzN4T/cTpCoGgg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37e0vqgpuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Mar 2021 17:54:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 22 Mar 2021 17:54:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LB+MHvakR5gdKiep0c9Pk1m63wKUJi/EZpVwDVzysW2zchN9pyOdrYQPTnIyaNf6YwxkxQNt90pnoYXSEb6zqwEXSptKbfIH2I3FBUbD8Vbl5Z32Qipe4Mw0Lhn0PJD7vnc/KqGlMmJNn26ogYjkYpJQ5I6OT9DI8lEMBgyJsSUD2X0caLn9DJUxF/KfgdHrP0dGBDAzImXSYG03drJnzVihLdmZNOE841td8Ae20icoKuMxLpxLUm7Exiiv7MLzlniixDnSZadJufiAg31K7Ieb+TjDzZoS4hC7tcmaFxWDUISQp3sDwZ9W/jHUXUeMiGYvZxDd442FTAdEJGxq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnXJ5ZwHh1s8OOy9hJqh6taDR0em2pZwnpNeKHNHXOk=;
 b=eI0kWucYGa+P6a5oiQBWqCvOUGv+9NPrTEIydCp16b0b+G03Pu4zf5xCex3XJkwiLC2INrE0Xa8cIw9SIroFVek8/pJaVBHHe2vn9q5dHACot1KvhwOWCsibZikKV3pTdRT2R2K/VnzGjAyOOMLnwZIUJps+81dfVi1+VKy3TYgfhalahPievn2sUlwXb7ybHx7fb9Tt9e9xsArCq7i3vllfSWIe8Z8mEJ5lc74ufba12qnyO1u66ZqKI/BkILSqBnlFCdXZjTLGuuXXqGZHeg3yv36SEUTRQtawU/4rRtQU+gEBtcBydX5vlRr7cYK8yI2eZaJ32F06SM8mQO66NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2885.namprd15.prod.outlook.com (2603:10b6:a03:f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 23 Mar
 2021 00:53:59 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.036; Tue, 23 Mar 2021
 00:53:59 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v2 1/3] perf-stat: introduce bperf, share hardware PMCs
 with BPF
Thread-Topic: [PATCH v2 1/3] perf-stat: introduce bperf, share hardware PMCs
 with BPF
Thread-Index: AQHXGqoOnn6PYztrGkqjWdJT1tFfMKqKQj2AgAFng4CABR7vAA==
Date:   Tue, 23 Mar 2021 00:53:59 +0000
Message-ID: <DE8D5617-E55C-4A45-8993-8D85EEE1E87F@fb.com>
References: <20210316211837.910506-1-songliubraving@fb.com>
 <20210316211837.910506-2-songliubraving@fb.com> <YFPC4UbLWzTuzyER@krava>
 <YFTwdWxUvqHDNe1x@kernel.org>
In-Reply-To: <YFTwdWxUvqHDNe1x@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:feb3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86dab61b-e93e-4ab0-d861-08d8ed962522
x-ms-traffictypediagnostic: BYAPR15MB2885:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB28850E8719DE32C812C527D9B3649@BYAPR15MB2885.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OhMcwDOVebviZuSIhRSWtd1GAEmqHACHN95LdJHc+iL/vbmUKmnj6YIVl862opZSt0Uah+CklGeY+zS4CLr6/aJ7AvWX4QToq2fCFcQswCYzy6Xxw5mACLYdG8t3txAKIBYOq7zYjV9YP6fxXM+rSSCJjyRhuyAmm1BiWibnXRAOajeYl/vtaPznDEnQzMEG8WtHA606rA/EkGIGAGtWTFDjwjtZBqYG60grN27khDlOC77P/SB6+Ufbv3ikqT1oBjYO3BeCn96LAPSA4iJZ9KS7QkRJZVfWlhkrjwFL/DIk3CEMXqh3FrksXCMgeh7StaXHW3hniLhFKf1JUPCTCDmBcuAHea+48dKhvpq4fNCXg9PO299utwsrCcR/RVhtJSnyE8dknnmGz97H9tGTp8C/4Jai+L3BgtIZze7sBwMpknOxs5AjyucgxS/ezytRi1HlVaQv1KIGV9w4PZNVLFNzp67IYtYEtM5g907+ilW/U1Z9TSgjzbHhwHyUU8OfkODSmjyHy0tiJFsI3Fdf3q8OKYEpI06hMWw0rMqMsn8gpkUHVvbYFf0GhorgIw6lfk7Zj2KWTAfWCr7W4jMte4ElZB/15ihFxLsLtrzf+BQ7UpXDg7FjAq1Zpnzdsq3x3/V/QUsNqBX1+ZXHiUKOgVo3UGK256JmVP+BI2sag7Ms9Xbz7yoW6XOtEA2OtNS1iw2g1bsK8aQfRFdv6CYVRonFPxEq5UAxT2wkF3BJl1q5okG2sHed1kmVWrYruduAd+kbVV8tCfPa6K1dJke05A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(39860400002)(376002)(6486002)(5660300002)(8676002)(2616005)(8936002)(36756003)(71200400001)(478600001)(30864003)(38100700001)(2906002)(86362001)(76116006)(83380400001)(54906003)(66446008)(66556008)(6506007)(53546011)(6512007)(64756008)(66946007)(66476007)(6916009)(33656002)(316002)(186003)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AxSEluqFJrRqlTUktS4y1dQwFrHyBpdzeLyZaYalZ2z8Z0Z4khK4Zt8YyS+X?=
 =?us-ascii?Q?2nAQzwqmW4F6AbVVa/rBf1m5VBockLnQX29Xozgj1UcBcQa6parCA1FHlXxG?=
 =?us-ascii?Q?nFEzVEu/ZtCgExch7N6nE7G5tCNbaUampb9cU6LQ1K4rv8FNWsCYUPmwi6kE?=
 =?us-ascii?Q?4Gnas2khDRKKXgm79MZ6LoWaHhT0LWzymoOVsLu0zHazfR0/tRXGWzcktNTD?=
 =?us-ascii?Q?t3cZrm6M/xUCH2ZE6f5j2GFOqkkTUWAQ/w9DSsge3Ox92ehOYXn9+c0xQ8jY?=
 =?us-ascii?Q?PsNyxpjwwo0WzUhneTrhAy7/XahvZ2DYcgNSbSD1LoF63ZSPTl/b4CRKjsnU?=
 =?us-ascii?Q?RZ4TCccfILBDWkWUTjl1kvUIBm+Ge6VBfMKWZIKQhWfpDKzQ70joEvv/qgXH?=
 =?us-ascii?Q?B3OOGvHavxnGzKc6++e0Jg6hTCUNLAmN5cZz0U275nKc34JuqCdgOuy/TvWs?=
 =?us-ascii?Q?6D2i0nohQ92nJ7wHH+f31Re2w+nJ16Z1urU1h7mgCi67dDxxUzpjHfYSdxuZ?=
 =?us-ascii?Q?X4AElYKO3ZkM0xwuPkuz478G9ORY9cqHH/0TukhT9uKo4YXeIptbgyxWhKZH?=
 =?us-ascii?Q?+Rk3kHAJqMAMohUEX6VnXuOuVxDeazGGqfIaknn8nslOhiNAgCQ7cEHEro7f?=
 =?us-ascii?Q?0a0BSSbG/aFjAVMjLYl/VNS1o8oo2E6SuP70CEljBT8ulVqTouKKEw1VUQru?=
 =?us-ascii?Q?CwIelIfko2fxn21UjFcXoKuX51ABnFQ89ovzZxbbQSbsM/DLOGsxnDkTVUvJ?=
 =?us-ascii?Q?Z9UKmMYxIYDeSrxZuHtpMrCN5Ad9aOsHWLO3H1WK7uQjc/9sBOVk9AITuyGd?=
 =?us-ascii?Q?T79CAhJF+yRy/fl01YZjN6FDrOc3MOeKohjR7rrohKFKZTigy5aF0dFopk2M?=
 =?us-ascii?Q?h0/xd7wgjUF0a11Ra7I5G5XQllfe5JjGlo5xvX3cdGEC/aTyxiE26ldCWrwF?=
 =?us-ascii?Q?M7NeN5arZTUDVFuaBwKT9HutTae1RURRZmN1Qh0a6MeIvq6anANhzeBddSJL?=
 =?us-ascii?Q?Va2SnCkzhQ2gfcXkKseN7nO/sU51DE9jvOuvgItT3cTiOjKO5XjvOYcI8jgp?=
 =?us-ascii?Q?dNVhLTgkYgMTCz1C1vHziE1wndiCH5axDuUlUniEhcaGnpv8e9RCCiCF2rGa?=
 =?us-ascii?Q?S2LQ+HXUBeIATKzadXOiNVCnPKunaIUCghQReCtHmCshK8Gng6LJScJPeKzZ?=
 =?us-ascii?Q?PjCNXO1gDCQIOTK3S+J8JVXjFRoPbTD8BnqPz2vIfXyd5ACIPoFGlRKGfWRO?=
 =?us-ascii?Q?/1JU8ijRqrvZ86bSFZGvzdxaFmwEy69PexSAnYZF80Qo4K+Zq1iOmjRLDXKh?=
 =?us-ascii?Q?mjQlASKjJZL683EIVGhA6kEOmzWCljwhExIVSHR2osRrTl6xFX/VDWeRopAO?=
 =?us-ascii?Q?8w8gt/4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3A5EC9529AA6F14B9457EB4AD842FA7B@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86dab61b-e93e-4ab0-d861-08d8ed962522
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 00:53:59.5943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8LL2oop0Vr7Wej9dSFUdFZNgj+43/FhsNiv9lD0Xe2NZy23bYR6nsFnWaIJIgLAD7xIu5rMw/7XaFjGHnG5HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2885
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_12:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103230001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 19, 2021, at 11:41 AM, Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
>=20
> Em Thu, Mar 18, 2021 at 10:15:13PM +0100, Jiri Olsa escreveu:
>> On Tue, Mar 16, 2021 at 02:18:35PM -0700, Song Liu wrote:
>>> bperf is off by default. To enable it, pass --bpf-counters option to
>>> perf-stat. bperf uses a BPF hashmap to share information about BPF
>>> programs and maps used by bperf. This map is pinned to bpffs. The defau=
lt
>>> path is /sys/fs/bpf/perf_attr_map. The user could change the path with
>>> option --bpf-attr-map.
>>>=20
>>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>=20
>> Reviewed-by: Jiri Olsa <jolsa@redhat.com>
>=20
> After applying just this first patch in the series I'm getting this
> after a 'make -C tools/ clean', now I'm checking if I need some new
> clang, ideas?
>=20
> - Arnaldo

Hi Arnaldo,=20

Are you still getting this error?=20

Thanks,
Song

>=20
> [acme@quaco perf]$ make O=3D/tmp/build/perf -C tools/perf BUILD_BPF_SKEL=
=3D1 PYTHON=3Dpython3 install-bin
> make: Entering directory '/home/acme/git/perf/tools/perf'
>  BUILD:   Doing 'make -j8' parallel build
> Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs fr=
om latest version at 'include/uapi/linux/kvm.h'
> diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
> Warning: Kernel ABI header at 'tools/perf/arch/mips/entry/syscalls/syscal=
l_n64.tbl' differs from latest version at 'arch/mips/kernel/syscalls/syscal=
l_n64.tbl'
> diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/ker=
nel/syscalls/syscall_n64.tbl
>=20
> Auto-detecting system features:
> ...                         dwarf: [ on  ]
> ...            dwarf_getlocations: [ on  ]
> ...                         glibc: [ on  ]
> ...                        libbfd: [ on  ]
> ...                libbfd-buildid: [ on  ]
> ...                        libcap: [ on  ]
> ...                        libelf: [ on  ]
> ...                       libnuma: [ on  ]
> ...        numa_num_possible_cpus: [ on  ]
> ...                       libperl: [ on  ]
> ...                     libpython: [ on  ]
> ...                     libcrypto: [ on  ]
> ...                     libunwind: [ on  ]
> ...            libdw-dwarf-unwind: [ on  ]
> ...                          zlib: [ on  ]
> ...                          lzma: [ on  ]
> ...                     get_cpuid: [ on  ]
> ...                           bpf: [ on  ]
> ...                        libaio: [ on  ]
> ...                       libzstd: [ on  ]
> ...        disassembler-four-args: [ on  ]
>=20
>  GEN      /tmp/build/perf/common-cmds.h
>  CC       /tmp/build/perf/exec-cmd.o
>  MKDIR    /tmp/build/perf/fd/
>  MKDIR    /tmp/build/perf/fs/
>  CC       /tmp/build/perf/fs/fs.o
>  CC       /tmp/build/perf/event-parse.o
>  CC       /tmp/build/perf/fd/array.o
>  CC       /tmp/build/perf/core.o
>  GEN      /tmp/build/perf/bpf_helper_defs.h
>  CC       /tmp/build/perf/event-plugin.o
>  MKDIR    /tmp/build/perf/staticobjs/
>  PERF_VERSION =3D 5.12.rc2.g3df07f57f205
>  CC       /tmp/build/perf/staticobjs/libbpf.o
>  CC       /tmp/build/perf/cpu.o
>  LD       /tmp/build/perf/fd/libapi-in.o
>  CC       /tmp/build/perf/cpumap.o
>  CC       /tmp/build/perf/help.o
>  MKDIR    /tmp/build/perf/fs/
>  CC       /tmp/build/perf/fs/tracing_path.o
>  CC       /tmp/build/perf/fs/cgroup.o
>  CC       /tmp/build/perf/trace-seq.o
>  CC       /tmp/build/perf/pager.o
>  CC       /tmp/build/perf/parse-options.o
>  LD       /tmp/build/perf/fs/libapi-in.o
>  CC       /tmp/build/perf/debug.o
>  CC       /tmp/build/perf/str_error_r.o
>  CC       /tmp/build/perf/run-command.o
>  CC       /tmp/build/perf/sigchain.o
>  LD       /tmp/build/perf/libapi-in.o
>  AR       /tmp/build/perf/libapi.a
>  CC       /tmp/build/perf/subcmd-config.o
>  CC       /tmp/build/perf/threadmap.o
>  CC       /tmp/build/perf/evsel.o
>  CC       /tmp/build/perf/parse-filter.o
>  MKDIR    /tmp/build/perf/staticobjs/
>  CC       /tmp/build/perf/staticobjs/bpf.o
>  CC       /tmp/build/perf/evlist.o
>  CC       /tmp/build/perf/parse-utils.o
>  CC       /tmp/build/perf/kbuffer-parse.o
>  CC       /tmp/build/perf/tep_strerror.o
>  CC       /tmp/build/perf/mmap.o
>  CC       /tmp/build/perf/zalloc.o
>  CC       /tmp/build/perf/event-parse-api.o
>  LD       /tmp/build/perf/libsubcmd-in.o
>  AR       /tmp/build/perf/libsubcmd.a
>  CC       /tmp/build/perf/xyarray.o
>  LD       /tmp/build/perf/libtraceevent-in.o
>  LINK     /tmp/build/perf/libtraceevent.a
>  CC       /tmp/build/perf/staticobjs/nlattr.o
>  CC       /tmp/build/perf/staticobjs/btf.o
>  CC       /tmp/build/perf/lib.o
>  CC       /tmp/build/perf/staticobjs/libbpf_errno.o
>  CC       /tmp/build/perf/staticobjs/str_error.o
>  CC       /tmp/build/perf/staticobjs/netlink.o
>  CC       /tmp/build/perf/staticobjs/bpf_prog_linfo.o
>  CC       /tmp/build/perf/staticobjs/libbpf_probes.o
>  LD       /tmp/build/perf/libperf-in.o
>  AR       /tmp/build/perf/libperf.a
>  MKDIR    /tmp/build/perf/pmu-events/
>  HOSTCC   /tmp/build/perf/pmu-events/json.o
>  CC       /tmp/build/perf/plugin_jbd2.o
>  CC       /tmp/build/perf/staticobjs/xsk.o
>  MKDIR    /tmp/build/perf/pmu-events/
>  HOSTCC   /tmp/build/perf/pmu-events/jsmn.o
>  CC       /tmp/build/perf/staticobjs/hashmap.o
>  LD       /tmp/build/perf/plugin_jbd2-in.o
>  CC       /tmp/build/perf/staticobjs/btf_dump.o
>  CC       /tmp/build/perf/plugin_hrtimer.o
>  HOSTCC   /tmp/build/perf/pmu-events/jevents.o
>  LD       /tmp/build/perf/plugin_hrtimer-in.o
>  CC       /tmp/build/perf/plugin_kmem.o
>  CC       /tmp/build/perf/staticobjs/ringbuf.o
>  LD       /tmp/build/perf/plugin_kmem-in.o
>  CC       /tmp/build/perf/plugin_kvm.o
>  HOSTLD   /tmp/build/perf/pmu-events/jevents-in.o
>  CC       /tmp/build/perf/perf-read-vdso32
>  CC       /tmp/build/perf/plugin_mac80211.o
>  LD       /tmp/build/perf/plugin_kvm-in.o
>  CC       /tmp/build/perf/plugin_sched_switch.o
>  CC       /tmp/build/perf/plugin_function.o
>  MKDIR    /tmp/build/perf/jvmti/
>  CC       /tmp/build/perf/jvmti/libjvmti.o
>  LD       /tmp/build/perf/plugin_mac80211-in.o
>  GEN      perf-archive
>  LD       /tmp/build/perf/plugin_sched_switch-in.o
>  CC       /tmp/build/perf/plugin_futex.o
>  CC       /tmp/build/perf/plugin_xen.o
>  CC       /tmp/build/perf/plugin_scsi.o
>  LD       /tmp/build/perf/plugin_function-in.o
>  CC       /tmp/build/perf/plugin_cfg80211.o
>  LD       /tmp/build/perf/plugin_futex-in.o
>  LD       /tmp/build/perf/plugin_xen-in.o
>  LINK     /tmp/build/perf/plugin_jbd2.so
>  LINK     /tmp/build/perf/plugin_hrtimer.so
>  CC       /tmp/build/perf/plugin_tlb.o
>  LINK     /tmp/build/perf/plugin_kmem.so
>  LINK     /tmp/build/perf/plugin_kvm.so
>  LD       /tmp/build/perf/plugin_scsi-in.o
>  LINK     /tmp/build/perf/plugin_mac80211.so
>  LINK     /tmp/build/perf/plugin_sched_switch.so
>  LINK     /tmp/build/perf/plugin_function.so
>  LINK     /tmp/build/perf/plugin_futex.so
>  LD       /tmp/build/perf/plugin_cfg80211-in.o
>  LINK     /tmp/build/perf/plugin_xen.so
>  LINK     /tmp/build/perf/plugin_scsi.so
>  LD       /tmp/build/perf/plugin_tlb-in.o
>  MKDIR    /tmp/build/perf/jvmti/
>  LINK     /tmp/build/perf/plugin_cfg80211.so
>  CC       /tmp/build/perf/jvmti/jvmti_agent.o
>  LINK     /tmp/build/perf/plugin_tlb.so
>  GEN      perf-with-kcore
>  CC       /tmp/build/perf/jvmti/libstring.o
> CFLAGS=3D make -C ../bpf/bpftool \
> 	OUTPUT=3D/tmp/build/perf/util/bpf_skel/.tmp/ bootstrap
>  CC       /tmp/build/perf/jvmti/libctype.o
>  GEN      /tmp/build/perf/libtraceevent-dynamic-list
>  LINK     /tmp/build/perf/pmu-events/jevents
>  DESCEND  plugins
>  GEN      /tmp/build/perf/python/perf.so
>  GEN      /tmp/build/perf/pmu-events/pmu-events.c
>  CC       /tmp/build/perf/plugins/plugin_jbd2.o
>  CC       /tmp/build/perf/plugins/plugin_hrtimer.o
>  LD       /tmp/build/perf/plugins/plugin_jbd2-in.o
>  LD       /tmp/build/perf/plugins/plugin_hrtimer-in.o
>  CC       /tmp/build/perf/plugins/plugin_kmem.o
>  CC       /tmp/build/perf/plugins/plugin_kvm.o
>  LD       /tmp/build/perf/jvmti/jvmti-in.o
>  LD       /tmp/build/perf/plugins/plugin_kmem-in.o
>  LINK     /tmp/build/perf/libperf-jvmti.so
>  CC       /tmp/build/perf/plugins/plugin_mac80211.o
>  CC       /tmp/build/perf/plugins/plugin_sched_switch.o
>  CC       /tmp/build/perf/pmu-events/pmu-events.o
>  LD       /tmp/build/perf/plugins/plugin_kvm-in.o
>  CC       /tmp/build/perf/plugins/plugin_function.o
>  LD       /tmp/build/perf/plugins/plugin_mac80211-in.o
>  CC       /tmp/build/perf/plugins/plugin_futex.o
>  LD       /tmp/build/perf/plugins/plugin_sched_switch-in.o
>  CC       /tmp/build/perf/plugins/plugin_xen.o
>  LD       /tmp/build/perf/plugins/plugin_function-in.o
>  CC       /tmp/build/perf/plugins/plugin_scsi.o
>  LD       /tmp/build/perf/plugins/plugin_futex-in.o
>  CC       /tmp/build/perf/plugins/plugin_cfg80211.o
>  LD       /tmp/build/perf/plugins/plugin_xen-in.o
>  CC       /tmp/build/perf/plugins/plugin_tlb.o
>  LD       /tmp/build/perf/plugins/plugin_scsi-in.o
>  LD       /tmp/build/perf/plugins/plugin_cfg80211-in.o
>  LINK     /tmp/build/perf/plugins/plugin_jbd2.so
>  LINK     /tmp/build/perf/plugins/plugin_hrtimer.so
>  LINK     /tmp/build/perf/plugins/plugin_kmem.so
>  LINK     /tmp/build/perf/plugins/plugin_kvm.so
>  LINK     /tmp/build/perf/plugins/plugin_mac80211.so
>  LD       /tmp/build/perf/plugins/plugin_tlb-in.o
>  LINK     /tmp/build/perf/plugins/plugin_function.so
>  LINK     /tmp/build/perf/plugins/plugin_sched_switch.so
>  LINK     /tmp/build/perf/plugins/plugin_futex.so
>  LINK     /tmp/build/perf/plugins/plugin_xen.so
>  LINK     /tmp/build/perf/plugins/plugin_scsi.so
>  LINK     /tmp/build/perf/plugins/plugin_cfg80211.so
>  LINK     /tmp/build/perf/plugins/plugin_tlb.so
>  INSTALL  trace_plugins
>  LD       /tmp/build/perf/pmu-events/pmu-events-in.o
>=20
> Auto-detecting system features:
> ...                        libbfd: [ on  ]
> ...        disassembler-four-args: [ on  ]
> ...                          zlib: [ on  ]
> ...                        libcap: [ on  ]
> ...               clang-bpf-co-re: [ on  ]
>=20
>  MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/
>  MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/
>  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/main.o
>  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/common.o
>  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/json_writer.o
>  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/gen.o
>  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/btf.o
>  GEN      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/bpf_helper=
_defs.h
>  MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>  MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/libbpf.o
>  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/bpf.o
>  MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/nlattr.o
>  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/btf.o
>  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/libbpf_errno.o
>  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/str_error.o
>  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/netlink.o
>  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/bpf_prog_linfo.o
>  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/libbpf_probes.o
>  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/xsk.o
>  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/hashmap.o
>  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/btf_dump.o
>  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/ringbuf.o
>  LD       /tmp/build/perf/staticobjs/libbpf-in.o
>  LINK     /tmp/build/perf/libbpf.a
>  CLANG    /tmp/build/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
>  CLANG    /tmp/build/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o
>  CLANG    /tmp/build/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o
>  LD       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs=
/libbpf-in.o
>  LINK     /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/libbpf.a
>  LINK     /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/bpftool
>  GEN-SKEL /tmp/build/perf/util/bpf_skel/bpf_prog_profiler.skel.h
>  GEN-SKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
>  GEN-SKEL /tmp/build/perf/util/bpf_skel/bperf_follower.skel.h
> libbpf: map 'prev_readings': unexpected def kind var.
> Error: failed to open BPF object file: Invalid argument
> libbpf: map 'diff_readings': unexpected def kind var.
> Error: failed to open BPF object file: Invalid argument
> make[2]: *** [Makefile.perf:1029: /tmp/build/perf/util/bpf_skel/bperf_lea=
der.skel.h] Error 255
> make[2]: *** Waiting for unfinished jobs....
> make[2]: *** [Makefile.perf:1029: /tmp/build/perf/util/bpf_skel/bperf_fol=
lower.skel.h] Error 255
> make[1]: *** [Makefile.perf:236: sub-make] Error 2
> make: *** [Makefile:110: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf/tools/perf'
> [acme@quaco perf]$ clang -v
> clang version 11.0.0 (https://github.com/llvm/llvm-project 67420f1b0e9c67=
3ee638f2680fa83f468019004f)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /usr/local/bin
> Found candidate GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
> Selected GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
> Candidate multilib: .;@m64
> Candidate multilib: 32;@m32
> Selected multilib: .;@m64
> [acme@quaco perf]$

