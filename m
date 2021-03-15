Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7412333C57F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhCOSY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:24:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17720 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231401AbhCOSYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:24:20 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12FIAIAp020551;
        Mon, 15 Mar 2021 11:24:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=/6/5OQPnZqNRNMCbYYsEh6BonGKvN3c5ZW/uyk1xlbs=;
 b=p0bQUqLNngd6MlysmZ47e0PMLkaGmqfKjyetw/8QiJeWlxYvOnX+GWwvKoJtOk+VpT6C
 RIIm9BNnzojM3nyq1gqEMCF/avQNDf247FZQA0EO9DQEGzwAWJDM9rHMdE6wO4HskAbC
 FNHP1iFTrkZaW8Q/zxQ4DEqEgRB7LrMbdi0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 378ss5j3ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Mar 2021 11:24:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 15 Mar 2021 11:24:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dnn5nkvJ1QtKr5URW3Vzxe8SC20hZizrbiiUFxzxRGR+0LPz0l3c0GcuIsmEkj67csnIZKV8ePzxmdqKMLSxwcLWGICMjoHzR/8Swyn9AJFDDhkJOazRxt0t6qOIPN/5RLJINgEmsx3f5S6t31RMPp50Vv19dQyJESHK3xF6RudSnyf6USYZrWjx2BLA6fXitaSqw8nUZnrnYXBXKVXXrhcU0bU2jo+J7orQSo7mBJa/uSzIzPKhWLV0EoTOrnJgfm4vbaWtcsXxqgLOMRGn6PheDACf2BLW3JzN3E3b3vdMINTCpEdiAPmoYeHNHJLB5171v68b/P8iogiGuWB7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6/5OQPnZqNRNMCbYYsEh6BonGKvN3c5ZW/uyk1xlbs=;
 b=cOl4jmr2+GsMhORHI4lxUMyNTWBZhXaUTDjkgBomntQlJJN7+tzP6QP/nxMR5BTi8l1f2UFhZgG1WFqVQftRaE2BtzddYTXOdWNwtnhz65bN2ZeujMAEaCCSa9wb+eHice9YmILQ9tKHvyZ3D/nXvLX2kVlNi290UTOH1hTjp0gv4M2edOP+y9/XuA1zW0c/FQ+r12OL9g3LVZzvd6mv9yMhLqpPlGut57lTq9HNBFm0A0Mt5GlasA0pd1G9tzf9b/50QOXA5vQVmmpCRSrlsBVs16UGt90hZH2AUMZBq9XOx+y11QO2YoJ4n7cXOgMFmq9iIVsva3F+LzqWPconwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2821.namprd15.prod.outlook.com (2603:10b6:a03:15d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 18:24:11 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 18:24:11 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Thread-Topic: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Thread-Index: AQHXFuPifzAWbJ/c0EGfxtA8c/wTpKqEGnCAgACXtQCAAGmUgIAAR0gA
Date:   Mon, 15 Mar 2021 18:24:10 +0000
Message-ID: <6ECF90F5-6A99-47FB-B04F-D3EFC7564D04@fb.com>
References: <20210312020257.197137-1-songliubraving@fb.com>
 <YE6Sq78CRmr/JsHl@krava> <95CDB411-4F73-4C56-8CA5-48C002F03ACF@fb.com>
 <YE9qf8vcS8svnFG7@krava>
In-Reply-To: <YE9qf8vcS8svnFG7@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:17f0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 884a62a3-ffa0-4586-afb3-08d8e7df8787
x-ms-traffictypediagnostic: BYAPR15MB2821:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB28214C3236FD654F00001C8BB36C9@BYAPR15MB2821.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VBfNY8W+RdlOqIEP4BP3w5rggR16Wm4YjukRK5WpVi7gs+JR4nScPIOwVi63TAY9zd+bH8+wnB+rN7sj0SGfjXCVBNy6MRjaCjOPjIJmVNXg7VVNVJH/7elta+e1bZBWWPi+yc3lITD/BfnHbdGxJLCGHr4uEl0DPo5Bn/LJTxv+MRiaC4hgy8l5Jh9VFsT8cxsyMZYEl9DWRdr6Csj3Swzmta6rmzj+BchV/8UbPPFqG5Bm6ufGFAWm9ksnlxg4sG4hqwL3HXehayXg9ygG6fjFfzFN2+ZFNJkO++Nbswa+TNWglwKjkDdpw7GLmKel3AdTRkS7qtci/J8e3XZLoAvjhkjo7xssCS70/r0PlDE/8FADFIjHCy1s4S5lvAtW8UHbRILKX7RQSx3as1+W7+7nBELLTNxoJQNzR30o2QCwjefb5V5B66/nxmgtxaPFUkBLV1Q95z8x6tanT8V5l3sD1Y+R9h177aYwU6tlGjPQNQtCqpQplEmZVvgHyM8QArTE70fDCVAy03aYYwidUziu+ze+ly207PL/hdGK6a//X6NXTv2vr3nmc3mMyPiaLhxPTWUVou2NQp+VUuu/GCYVEj+jskXSBhmUIwQ6sghiV7JF6liIQ4YHOa4Q/lYO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(376002)(39860400002)(396003)(83380400001)(2616005)(86362001)(66476007)(5660300002)(8936002)(186003)(91956017)(71200400001)(66556008)(64756008)(66446008)(6916009)(2906002)(6512007)(8676002)(316002)(478600001)(36756003)(6506007)(53546011)(33656002)(4326008)(6486002)(54906003)(66946007)(76116006)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yn0+SQfNHghUy6wWpcfDU6vUY2WrPaCJUBElIyOsQsAE5tfgzvNxJM0Daehe?=
 =?us-ascii?Q?4YhYaP0/C+RGmn+QO1KOoskabJBWW5tC5dAW4s1cf+uh22vMEbPEWs1u0s0N?=
 =?us-ascii?Q?nO1D/Uce/SjvSy5GaeXGnmh7ttwmWPqQaKMUbU/nwZeaN6YFzp6GvKLs/QU1?=
 =?us-ascii?Q?3EYYBETrNozNbq02rtJ0UvF5PXKMC5jhnpcBewbAt2OA8mHtvlrGHdoQXbld?=
 =?us-ascii?Q?XjrveSHB3GHC7TcK3oCP74vn68CGInNmBOUovrwIkXTa6PaGUVpE92oQOcPS?=
 =?us-ascii?Q?UGJ/mW5XWKUm8jLg7IogedZ8+HVbLACZ+cGgptZeSOgFOGY1D1HZ0sOnUBEG?=
 =?us-ascii?Q?2Btv4+jnrdePgggQQVi/P9BJIQUVnE2FejQkhyGZaAreX61zB9zUvpdsP5Q8?=
 =?us-ascii?Q?l4b/97aPmb7wdaB9Fa4xfMzhWirUcfm5eNKUQVpEmuL9hYYG71sfFOXj/gfr?=
 =?us-ascii?Q?KnQGVxoaCVoPyn6wTHBjapQ6cbR+2leeR5XCI/l0Ux0kSWCrRFGPzmtIXmX2?=
 =?us-ascii?Q?rSRFaFFugdNqt582j/JWJ9LuMw1EoBVKpArWjLvaRiZ1WlcAoonI5Cz34TqP?=
 =?us-ascii?Q?Mfa7UqQF8NdoXpiAJNHhY3ehQMo16eNWJPCd3TWuT4tLn4Znd/m1pO130mAI?=
 =?us-ascii?Q?PaQqY6WNh/cjkljRVl/UZgRuT3bYW6S8fqdYsaJnHanABivyRAHLnrlpLCAv?=
 =?us-ascii?Q?2j+1NkfwgPJ3T/EpEi/ZZF/3+zz7zK6PzbA3Gvqt3E1NOI++BXBiW6vNBjYS?=
 =?us-ascii?Q?audq75mhOLF9uZImKOv1WmnTCP5U8HFZhrL7USPpC5tMCjkqoJu5hguHN5zi?=
 =?us-ascii?Q?NpyK2Tf/UPheVu81ScKbrga3rWKNbkJMq4Te4ncOLVOz9KK/RPMdbOxgys7r?=
 =?us-ascii?Q?KQFFurK95lNBmrbpdQ8ZvCvHlfPqq6ctX31LrEUaeoq0y+AJMct6sQhWA21z?=
 =?us-ascii?Q?T4Zwf33v6JTvGYj6sT9/5wfZ9aTsqTjdeMuoI2CCjp32NoW/pZKQRTJimvMY?=
 =?us-ascii?Q?Zp1/SHmLh86o28BuSTpRFKkDYtNgrsGh2O7w5yVbuA6dPy3axou4ahqY74DP?=
 =?us-ascii?Q?iqLrAJdspdHKvCKlB8F6WBCw0kRHtvDQluzhFzuYPWhXLATizsAdIwpc8oxo?=
 =?us-ascii?Q?Fa0l0ufZMF/8rT6NUGgF2+iR9vSXZiBAxKwsjUAStszPrgxP8dAhMcj8D+UM?=
 =?us-ascii?Q?/1QGS2PWRPg9QJVHvjUUnMiGUZtHXsDf+JGKA52XHdFSW/bskmrNGxZ5Ww4o?=
 =?us-ascii?Q?I9EswTiOHZ+aHeOI4eyRYfRRQyJbG/MA2Dvlgqu2dfgPNgiqJJ2MscG7Umwm?=
 =?us-ascii?Q?agYP0X5103oSTG65/fkK8UYTCJ5sHVES1pbNc2Ugtd4HUnEGQXzjZfj1ngHq?=
 =?us-ascii?Q?5XeF1Eg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <862CE1B7279F6942AF88EE59A3A7BDCB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884a62a3-ffa0-4586-afb3-08d8e7df8787
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 18:24:11.0135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ziqaccDh+wS2pxWAYz4BUcQgkSg/Zwt31LfQLw3+v2LFE/1dbM3GfnRP5GuoeuVuoBxj7lnjx3J1KKVHL/KAMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2821
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_11:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103150124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 15, 2021, at 7:09 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Mon, Mar 15, 2021 at 07:51:11AM +0000, Song Liu wrote:
>=20
> SNIP

[...]

>>=20
>> It is mostly to cover corner cases, like something else used the same=20
>> name.=20
>=20
> about that.. we just take the object fd assuming it's map,
> should we test it somehow?
>=20
>  map_fd =3D bpf_obj_get(path);
>=20
> if it's not the map we expect, I think we should generate
> another name without forcing user to run again with --attr-map
>=20
> but still warn, so other perf session can use the new name

The auto failover is an interesting idea. But I guess we still need=20
--attr-map. Another use case is when the user mounted bpffs to a=20
different path. Alternatively, maybe we can teach perf to search all=20
bpffs mount points for perf_attr_map?=20

>=20
> SNIP
>=20
>>>> +static int bperf_sync_counters(struct evsel *evsel)
>>>> +{
>>>> +	struct perf_cpu_map *all_cpus =3D perf_cpu_map__new(NULL);
>>>> +	int num_cpu, i, cpu;
>>>> +
>>>> +	if (!all_cpus)
>>>> +		return -1;
>>>> +
>>>> +	num_cpu =3D all_cpus->nr;
>>>> +	for (i =3D 0; i < num_cpu; i++) {
>>>> +		cpu =3D all_cpus->map[i];
>>>> +		bperf_trigger_reading(evsel->bperf_leader_prog_fd, cpu);
>>>> +	}
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int bperf__enable(struct evsel *evsel)
>>>> +{
>>>> +	struct bperf_follower_bpf *skel =3D evsel->follower_skel;
>>>> +	__u32 num_cpu_bpf =3D libbpf_num_possible_cpus();
>>>=20
>>> we have cpu__max_cpu for that
>>=20
>> libbpf calls for percpu array use libbpf_num_possible_cpus. So I guess i=
t=20
>> is better to use the same here. The two are identical at the moment thou=
gh.
>=20
> then in the bperf__read you take that array and update
> perf_counts, which is based on perf's cpus, so they mix
> anyway
>=20
> I'd like to keep perf code using perf's cpus api.. could
> we just check at the begining that libbpf_num_possible_cpus
> returns same number as cpu__max_cpu (if not, we have a
> problem anyway) and use perf's cpu api

Let me try cpu__max_cpu.=20

Thanks,
Song

