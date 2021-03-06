Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B54C32FCCE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhCFTey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:34:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31812 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231384AbhCFTef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:34:35 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 126JQGkn022266;
        Sat, 6 Mar 2021 11:34:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=kAof7vES5ie0KwttH1xFuD1YsxFdHQDOd6ALtptf9VU=;
 b=ZVccqrZ96pFLfTCV+C8xZUCJhEjdu1C1MamthdY7+RNUa8XeSntPdjaiECwk6vNCvPlh
 korgS8MkosTVQaYytt12k7KIFwlvBD27TNtVInBBshiEMJx+wZNaj/dq3fG9E8abLOrw
 kTQj4FmnfaXfr8LWfQaLz1l+qImEoprgYZU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3748aks5j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 06 Mar 2021 11:34:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 6 Mar 2021 11:34:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMvVCUmXyfDuhdSMh/1AgAhcw9ncKQhKIKZI5Sk0Ld//4DSxkuMSfj7zsLvBrwUrGCCSOwutwvY60bwB6Av6aJhfKDpqXssHmRDQkPostUrWv9ZyTchJFem+hjUPwiTVoMDq8RwIzmh/hyt0Arfp52el2SQk7Qbmvs9pwce8kxiYhPGczo4S89HsKYaqJiU7yM0PXlgk5JZ29wfdgP9vIrHw51CneWXr1lkG9QyKe3v2c60lcWK+qXRWSdOtwyCRuclwYm1tNyK3Hz1j3XZUFRYIDxGjaSQGmOn9GFn8T+LRXNOLQgZygPurFyQqG0sZ4UxoQ8nkYBS+jycltmZdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAof7vES5ie0KwttH1xFuD1YsxFdHQDOd6ALtptf9VU=;
 b=bD5eSvByeqQZHYGPec5qXffefzsxC4+BRWoZ0DI9Qey6SelUnDSOWgV26eCTnfAxLgUGrPfNcb6z6+7YPxp6LbNuGcqKcXu2Us0JwgBptbzmQ+CgcC7OcoMHHpZqStloo8AV/sGV39pzPzg83Xeg/U6AflP63VKo3UwViTB54+v8aroLlk53wIGnhAgUa+CuRZWEmQo/RYr986nyw6zRhCyrxi62tOiNtjT+lXYA8KwEsNb1Jvx7Rn/YChP1CGs0syJPQ8fQghZN9EBzlLgkTbvWuwVR2nsFjuTplO6Frs3kZ1VSPmOEg5lyr4c5OywOYsdQbphyEM8Vy/Ovdu2UqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY5PR15MB4290.namprd15.prod.outlook.com (2603:10b6:a03:1f9::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Sat, 6 Mar
 2021 19:34:15 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3912.026; Sat, 6 Mar 2021
 19:34:15 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 3/3] perf bpf: Minor whitespace cleanup.
Thread-Topic: [PATCH 3/3] perf bpf: Minor whitespace cleanup.
Thread-Index: AQHXEl/yq5ok08LMt026g6Q85FLSWap3WqEA
Date:   Sat, 6 Mar 2021 19:34:15 +0000
Message-ID: <0F6C1A46-2961-4D55-BDF9-D85A01EC26D4@fb.com>
References: <20210306080840.3785816-1-irogers@google.com>
 <20210306080840.3785816-3-irogers@google.com>
In-Reply-To: <20210306080840.3785816-3-irogers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c091:480::1:ace9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b2cd534-d50d-4bdf-4ff1-08d8e0d6d3f4
x-ms-traffictypediagnostic: BY5PR15MB4290:
x-microsoft-antispam-prvs: <BY5PR15MB4290B9EFE8F9A4E495385D37B3959@BY5PR15MB4290.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:202;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dyUh7Tjcl6yhpVJQnezA+6lfxxYBjFNm1Riq37n0mxukTF8aMqToDbdSwJFkNotw9EesWuTKxHHExAPZ96HznvrFgMHAzOg87ogcVOscb/wcgJ34/gAwhPVM8fS1ThXXVYoHMKyd5oJqVqOJSOHCbmQV44xuaAhsicOXQ2CMhgD4EGxyngLBc9JhBg/dwP3yx+zHkXNp3NYKLoLj/O1rpWzyB2gpgO4COHXyOWXmdw5KLM+X09U8Q8yXwkhL8+MAYiOL95cjskTPAigT+uES5d5fMp0Rw2BaDwpN1I7OjdMabsVGdOgHqhwxCKomZ0bP+EZ2JN0i2KbqhlE9GqGH5n+E3kRtSld6OlpQotP/arIK/ao4r2cVc+40dPSPho/wXHtRV2LkXeW1SQk9ddOL1hFnZZ0gDa9OOd173I11V6TbBgs3k0vwaOhexsC5bTLtYApn4v6f/0Wl8HHSJhknLzyZf9hmt/MLwmGdONeIpgFkr4l4AfqCdcD+caD+P3FnrxEz6eQ1fPZ0tgT7eRp2svWoBxIgW9psLb71n9mBLPXoy5maxa3yyz4eQCx/K6hRsmemVQ+D+AbPK3D8ftEZjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(396003)(136003)(366004)(54906003)(66556008)(86362001)(36756003)(4326008)(8676002)(66476007)(66446008)(64756008)(6486002)(76116006)(5660300002)(6506007)(83380400001)(66946007)(91956017)(4744005)(6512007)(316002)(186003)(478600001)(71200400001)(6916009)(7416002)(8936002)(2616005)(53546011)(33656002)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?U3EhPceYgqiKZGU2R/TNT0H3YWlWSdxMD0U+7iwKFbCiqVf0n6AYoH+RKBah?=
 =?us-ascii?Q?3LGAWY1oWq6+KMHKyjeK8h/QPlP2qKyaxUMG/g+NxHni3w9J+flhkxThgD2s?=
 =?us-ascii?Q?hXVO1jqEflhRA/5BkF0suPdLKAUKzg3mrNQsY9Q1mp+jSkLGiSryqns4R4l6?=
 =?us-ascii?Q?hDTB69hWHiU1DFjEJboucKl6vyFw9i01fpBZudQqWR3dImQtV7gi9Ab8gZuN?=
 =?us-ascii?Q?WEe7KkhDyNMIPEVSpM1G0FVbdvRFzItVbYJaQaH+augAZw6kDVOc6O6As0qG?=
 =?us-ascii?Q?Dg7q687aPgJXhXkdg/WUdoYzcHSV95CkKEkOfKq+SsYZUDEJzj+1Zg46GDVE?=
 =?us-ascii?Q?Bvix1FfVH/up5qM2zetZTol1fTEFUiFd5+bfLfomrrC+MvPXrwhcYgHzExFn?=
 =?us-ascii?Q?fC8lKt1qLsvIckMMPKMAlHA6q448OrvoYgYiPbxCK4MHrgFAmxC0Xqr9FXiu?=
 =?us-ascii?Q?yvSx8AkyPIX8wj6kRPxD9wmoQS9QgTUX2sPv/qCyJQsvTlkYzsDPZRgXcXoY?=
 =?us-ascii?Q?Htl1Eper1tLCXkxiTtE5IyfBox1ykSKPplFEeWG5aQHfeRABEQkBP27/MMPR?=
 =?us-ascii?Q?5XGX9MXTCY6InZjNmoFilXuTe9P9H575R/Om9+wFKfNQp/7uXmtuitZJ9MEN?=
 =?us-ascii?Q?uaa2o5DkcghfnzH6aB4ijERTXXVmTp9ZYR2TgkoLD243a8c5C/N8mZ2SqDIm?=
 =?us-ascii?Q?4Wmi45vvjxn5Fl0Ksqieb0+zCzHpRBc+2awZMVqcAswvxTLZa7rGfluGs0Ay?=
 =?us-ascii?Q?9w3UkjjcDfad9sgQYjjR26dbbLSDAUFibAbEv/jsmzXbz5O8nL0xvQ22rsW0?=
 =?us-ascii?Q?WOz/0TPk19FcgBZ1RbDgPnnxyR0YafcC3f20mkdnhOabj4++L392eI/Mp++t?=
 =?us-ascii?Q?0MiUx3SBNZXgY0en4bVbRC5tGEoHpbT5vB9HYyUdmCuaFCHSgQjTig0beFzp?=
 =?us-ascii?Q?BsiWn6X67O3zIBJUF1gNOTh4oce8/aY737MkNgMRUsmAMJaE5vs2Xhwu6+n/?=
 =?us-ascii?Q?B16Y25C8QKRoe1RLQ98B5od0pnpU3lAaa711GBw75cc4Rz5mz7ATi7xORnaX?=
 =?us-ascii?Q?9qVoylfrY2Vyx4Fmi8oaDI9px1GGlefWZDAXJByCjXRt6PuLcT5X6LaJzeLt?=
 =?us-ascii?Q?W4hmBlHtDxf9uhND8RZN80E4avLhbaB9DDbe9BsBJeByTExnjUHcIwzJOGPG?=
 =?us-ascii?Q?BClnV/XpJsrWk5LPNGSNDnCQFB8V5CIVgru4lwsj3zvYwvFH+IgAKm+GSP7d?=
 =?us-ascii?Q?tBCmdVovi/ndPxoIvoxdtanS+7O+DD6VWaALHtVYH2qNelPgWfZlQCsZiteQ?=
 =?us-ascii?Q?6WfNae4hcug9P3yHKv/jDZmrdGyR57w5otsugwWvD41Haky5x2xhSHirYpUq?=
 =?us-ascii?Q?cfS+Sl4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D4A19E80FBCEA4BA78A97EDA843E405@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2cd534-d50d-4bdf-4ff1-08d8e0d6d3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2021 19:34:15.5632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bn+LR2gwfPR79uEa2MBPtMdo43uspphjy2PmrMvHZQnVRRlywjZui2I/YpGbXb9ZsYpCvje6pVEZ2T/ZsUfaPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB4290
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-06_08:2021-03-03,2021-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103060121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 6, 2021, at 12:08 AM, Ian Rogers <irogers@google.com> wrote:
>=20
> Missed space after #include.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
> tools/perf/util/bpf_counter.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.=
h
> index 2eca210e5dc1..cb9c532e0a07 100644
> --- a/tools/perf/util/bpf_counter.h
> +++ b/tools/perf/util/bpf_counter.h
> @@ -38,7 +38,7 @@ int bpf_counter__install_pe(struct evsel *evsel, int cp=
u, int fd);
>=20
> #else /* HAVE_BPF_SKEL */
>=20
> -#include<linux/err.h>
> +#include <linux/err.h>
>=20
> static inline int bpf_counter__load(struct evsel *evsel __maybe_unused,
> 				    struct target *target __maybe_unused)
> --=20
> 2.30.1.766.gb4fecdf3b7-goog
>=20

