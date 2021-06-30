Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779973B88B1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbhF3St7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:49:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13932 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232745AbhF3St6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:49:58 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UIdhNm032717;
        Wed, 30 Jun 2021 11:47:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=43ZS64+ziD6PMDqLI97oSmYWN7yNb6yHoGqaNJ30HKI=;
 b=fqhXcaYsldxpRXSJQaPfDxD+THJ2lAqfA+l8YHAIyJk9T27Do1MNnpPOrhbzFILygwk2
 VOAwwspewgZjqZ+gz2NeoOw1vzb208odefCusm3MSEs7t+sqgbzqZwMbv/jLVOMfbDkI
 V+ffle0hygHhFWdHskqYZYTtSYwhqH6AScI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39gevgd61k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 30 Jun 2021 11:47:19 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 11:47:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkieJGdXzrCK8pr6haLk0Sr2BM+8ARs9DMYk/TcOwQ0QzxeHw9Y7l9YhvyutyYkWkAvRK/Efl8R1w8vyHPKKUY3nbROQbmj1rpnU5c/fe/DPySkXSkIeBZV2E7PAwucpDGpqnHavh2oYxhinqf168c1qOfKkKmWCYLglZXVuMjLSS8tvX8jFrlKD5Nnqcz8FwlzuhC93nQ5egtmXa1EqXKiet6bNYuG5zbenoPmi/oEB2fxpVywehGchp9sHT7JGdHxWH2C2lY616LVNEh4/goUf3ZSLhw5hSMJyzphbzhik4jaT+aSUaOr+AXGG9m/XPf9a41eC+kSZxfuQrd3vrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43ZS64+ziD6PMDqLI97oSmYWN7yNb6yHoGqaNJ30HKI=;
 b=PQnu9ow96hMOcNUn5Qf4O/3wLCZ7UtMJaoFYKHvLWi5Kd3iNpp3hl3fiq3TJVS4bvHuVZs5EB7iYgrqXdEC3Lkucy5R7CYb0+dOg24DqaD6j2dineO2Fo+RJ1RRRbEztD0/KbRWgGtURISYRqCTZrvBtxIEWucb09JZ2hPN1voet/jFSGbdA8e3bTjrpAqDifjcNIwhZ48EY3zh+RI9/CkGsdINPAgQ9iSq7wscFr7SztcSojeSATew4EUG/D72qMlT3sShNdL8LhracdcpMcKH/C1hJupcpihyf9unZxZP0ApVpKh1AKRcFVA68DxHr4fbrrPT6DzAb/lW9DCYoaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5112.namprd15.prod.outlook.com (2603:10b6:806:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Wed, 30 Jun
 2021 18:47:16 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::6ca0:8d70:ac3:14a]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::6ca0:8d70:ac3:14a%2]) with mapi id 15.20.4287.022; Wed, 30 Jun 2021
 18:47:16 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 4/4] perf stat: Enable BPF counter with --for-each-cgroup
Thread-Topic: [PATCH 4/4] perf stat: Enable BPF counter with --for-each-cgroup
Thread-Index: AQHXaZJSMJwCb4YzS0CgyQ0eCfrxzqss7YuA
Date:   Wed, 30 Jun 2021 18:47:16 +0000
Message-ID: <43811928-C46C-45CE-AB5A-4DE84DCDB1AF@fb.com>
References: <20210625071826.608504-1-namhyung@kernel.org>
 <20210625071826.608504-5-namhyung@kernel.org>
In-Reply-To: <20210625071826.608504-5-namhyung@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:5c9b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca6c2479-355e-4bcb-b7c3-08d93bf77b76
x-ms-traffictypediagnostic: SA1PR15MB5112:
x-microsoft-antispam-prvs: <SA1PR15MB511213166FFC691AC8ACC6C4B3019@SA1PR15MB5112.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hBoA9VIOaFVHXT2bcScBmkS2nGcJcFJOy7ykmNa1dPand9vW5D2tkuhYyZxDGqzOjxTuII7tqWkwxqt2km8WT5sOprAnsRCbK3UsnCKdH0pkJJ8nl86OtbzDePjPseCOJrnaVMfJGC7R5KRhhFtDX4ArIHwPZuVx989zaP3QaxUgGSk6SgVja7uY6/NoENda9M8Lhi/jiAnLgsL8V57mZpfiMqVvkpXWmPrao74j6ulv8Zv8AbCC7IRISv3Zee/oEd49bRWOxR95aGv+t6F2vKPpiEDu5k+ZVuajyvqHt4zWlYQiVUqLWzJe9k5pQqF/UCfuizeISpy69uFHYTt+WUPdtduOztIktFi5nW2lSOIP/elQ/7tYZPR7eZveQnqV0eoqkub3eG3I88XrDhBmdC+HQ4zcEINHUgHuBL2aJTtnXintdkX6IkfwR/yHlti7uqpnKwffewDXC7iwgbct3ogHNj9jVttPtp+g7swpcIbwrNvH/Hv+Nq4UKEmeKtVA+NsUoqZnvEqmnKg8jBYg5BA2olC4GMsHrRjV3fOF28jBQ67tDp2ij1QHUMEmk0ngh6b4HyWjPrO6jeEUPlbRk+WNb4+NfVr7shvJ8JoJ9cl6hAb6aYshIcPgX03l9zwKCqfcGnTvU9DcA3mrW1dmY8bgGAZ1LA8/vAJ0vABN3kG3nbGrE3ySuIsU/1yEw30ZIdh6CqJz0fUjvnCCV3/ZZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(6486002)(5660300002)(33656002)(86362001)(6506007)(71200400001)(6916009)(36756003)(53546011)(8676002)(38100700002)(66476007)(76116006)(478600001)(91956017)(2616005)(316002)(4326008)(66556008)(83380400001)(6512007)(2906002)(64756008)(66446008)(8936002)(54906003)(122000001)(186003)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DtnPWevl3G6+xH1FJxDTYtCj1x0dz0lgNEx2k188+mAuV5ppwbrQR+9yh2W9?=
 =?us-ascii?Q?iIVUjGjWCuJx72ueM6Omq+Tp8uX/BrdyC6NwYskQ4S20grBdQIHcBinoceM6?=
 =?us-ascii?Q?FZ07iXKbcsHp7rKqqoqMMPIMklot/d1852lnsB6OptUMBkjJUDnYbyp5Tm3T?=
 =?us-ascii?Q?lkOSXG2j0xgjT2SokHt6uL5cFEOy+jZQzj3IDz5oq3XwC7JLQndYdNmDulCJ?=
 =?us-ascii?Q?csPzctRmzIOqw6PmdoLK+jz7qO2r6Pzdq2ln0vdDxZR/N1Km9vxxXp1TYqJe?=
 =?us-ascii?Q?1JunwBiBkNqYhLFTz2+rZfRn0AJYinaUKwdDQm5z7GY6cqMIvlz80gP/TxPB?=
 =?us-ascii?Q?tcmBLqnw6APc+920gBFa74ucAhuB9nHXFVbqnA4ZiZwWYeqDQbmxMa7Md0H/?=
 =?us-ascii?Q?ukXtRhzwdzjhaSz6naD7L6f5H04cSvj1WEyA8Bv4axeMb6o7h7U7+h7KleNe?=
 =?us-ascii?Q?RxG8Zs9eyAcmiyr6vxyurWUQB4d2FaRgNnTUKjg3BvAfpX4VdL5IK73A1qGM?=
 =?us-ascii?Q?6avio+Qzewk5inOzeAI3FlMBncZ0336CeDDOlwoRkV0gqkn/Mrnie+/08mSN?=
 =?us-ascii?Q?J9t6DujQfz9GRwSQ9mTVl7+BscKydYoewFVPpkj/RWXw/zSoiTIEdfJ4HVYk?=
 =?us-ascii?Q?cd+41c36wXA0pZGhf4NUAFH+4iuoNeZmgnG9xnayBxpyRcjU4eD5fG3BzCf5?=
 =?us-ascii?Q?zHFGHnO7TDRKW3FNgQEmt+iM3nCtnnLrE8KUBFaREP8GuZ89eskGclrvyyat?=
 =?us-ascii?Q?GledwvNxi0OjT20f3b3pqARovaaoE3N0POpKVwRVFJt+cRhuWFErOxk+GQ/y?=
 =?us-ascii?Q?oQ3DS5TLHMUfiMxgUQjLyp36tyZLHqPgsR/YyMqSWx9MfZGkQJjoI0fZsF6o?=
 =?us-ascii?Q?WLt1qI3dDnQf1wsx03oNhdPQ7qWoF+KxMw9cPa5yx6q/VIWq9Ou9bzhcX2H6?=
 =?us-ascii?Q?k2HgdMurT1VpHxt9wIgxyYL6AZ4oyBmMPlp/993FKVHilWAnhc3qgziPvPO+?=
 =?us-ascii?Q?jvcpa1VuF00iVCQKbacu2f/0JqOQQBfp0Jn/vEOlhkzEzE2Rv0LWTJBAAKY/?=
 =?us-ascii?Q?LtCuOlvoqpZpzkg2Qpwjx5YmCRnyqUIEDDWlRQOVBevv4rlQN0auDSejpF9o?=
 =?us-ascii?Q?iCuAQQF/ozG+3T4EEP25zNc5dyh7Xdodv+UOvmdJu6eDcs/lH/kGOcUZ5Ja/?=
 =?us-ascii?Q?eyhqVtKcG1T+q5KQgmxl7OAXsi61GWiXZBzFxzDwj0z9GNv+tn4cYPpGnwTF?=
 =?us-ascii?Q?XeMw3naU05J0f4/vyLKjXugZq/tKd9nyioVfjT/a/vdm/hRp2/to0cuE4HRK?=
 =?us-ascii?Q?Wcz0Qs8ub38WFQx+4++MGIN52sNoWNXp0xndJidwRpJ4Od4+mPyF4wv4ovki?=
 =?us-ascii?Q?HxVz2hs=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F04ED109F975A341AE0F8D3A02C161E5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6c2479-355e-4bcb-b7c3-08d93bf77b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 18:47:16.2978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C32xCqUxVN2onZrJbvmH59QjAWIb7Y7UrxFbGjCMyYSbilrZSRcVrG1s5TE8GyQ7+xORrdBsM2Wjj7p6W7tfGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5112
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: himMU7YcqglWDbHtSPZZj24TZmqbEqi1
X-Proofpoint-GUID: himMU7YcqglWDbHtSPZZj24TZmqbEqi1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_08:2021-06-30,2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 25, 2021, at 12:18 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> Recently bperf was added to use BPF to count perf events for various
> purposes.  This is an extension for the approach and targetting to
> cgroup usages.
>=20
> Unlike the other bperf, it doesn't share the events with other
> processes but it'd reduce unnecessary events (and the overhead of
> multiplexing) for each monitored cgroup within the perf session.
>=20
> When --for-each-cgroup is used with --bpf-counters, it will open
> cgroup-switches event per cpu internally and attach the new BPF
> program to read given perf_events and to aggregate the results for
> cgroups.  It's only called when task is switched to a task in a
> different cgroup.
>=20
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> tools/perf/Makefile.perf                    |  17 +-
> tools/perf/util/Build                       |   1 +
> tools/perf/util/bpf_counter.c               |   5 +
> tools/perf/util/bpf_counter_cgroup.c        | 299 ++++++++++++++++++++
> tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 191 +++++++++++++
> tools/perf/util/cgroup.c                    |   2 +
> tools/perf/util/cgroup.h                    |   1 +
> 7 files changed, 515 insertions(+), 1 deletion(-)
> create mode 100644 tools/perf/util/bpf_counter_cgroup.c
> create mode 100644 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c

[...]

> diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_c=
ounter_cgroup.c
> new file mode 100644
> index 000000000000..327f97a23a84
> --- /dev/null
> +++ b/tools/perf/util/bpf_counter_cgroup.c
> @@ -0,0 +1,299 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Copyright (c) 2019 Facebook */

I am not sure whether this ^^^ is accurate.=20

> +/* Copyright (c) 2021 Google */
> +
> +#include <assert.h>
> +#include <limits.h>
> +#include <unistd.h>
> +#include <sys/file.h>
> +#include <sys/time.h>
> +#include <sys/resource.h>
> +#include <linux/err.h>
> +#include <linux/zalloc.h>
> +#include <linux/perf_event.h>
> +#include <api/fs/fs.h>
> +#include <perf/bpf_perf.h>
> +
> +#include "affinity.h"
> +#include "bpf_counter.h"
> +#include "cgroup.h"
> +#include "counts.h"
> +#include "debug.h"
> +#include "evsel.h"
> +#include "evlist.h"
> +#include "target.h"
> +#include "cpumap.h"
> +#include "thread_map.h"
> +
> +#include "bpf_skel/bperf_cgroup.skel.h"
> +
> +static struct perf_event_attr cgrp_switch_attr =3D {
> +	.type =3D PERF_TYPE_SOFTWARE,
> +	.config =3D PERF_COUNT_SW_CGROUP_SWITCHES,
> +	.size =3D sizeof(cgrp_switch_attr),
> +	.sample_period =3D 1,
> +	.disabled =3D 1,
> +};
> +
> +static struct evsel *cgrp_switch;
> +static struct bperf_cgroup_bpf *skel;
> +
> +#define FD(evt, cpu) (*(int *)xyarray__entry(evt->core.fd, cpu, 0))
> +
> +static int bperf_load_program(struct evlist *evlist)
> +{
> +	struct bpf_link *link;
> +	struct evsel *evsel;
> +	struct cgroup *cgrp, *leader_cgrp;
> +	__u32 i, cpu;
> +	int nr_cpus =3D evlist->core.all_cpus->nr;
> +	int total_cpus =3D cpu__max_cpu();
> +	int map_size, map_fd;
> +	int prog_fd, err;
> +
> +	skel =3D bperf_cgroup_bpf__open();
> +	if (!skel) {
> +		pr_err("Failed to open cgroup skeleton\n");
> +		return -1;
> +	}
> +
> +	skel->rodata->num_cpus =3D total_cpus;
> +	skel->rodata->num_events =3D evlist->core.nr_entries / nr_cgroups;
> +
> +	BUG_ON(evlist->core.nr_entries % nr_cgroups !=3D 0);
> +
> +	/* we need one copy of events per cpu for reading */
> +	map_size =3D total_cpus * evlist->core.nr_entries / nr_cgroups;
> +	bpf_map__resize(skel->maps.events, map_size);
> +	bpf_map__resize(skel->maps.cgrp_idx, nr_cgroups);
> +	/* previous result is saved in a per-cpu array */
> +	map_size =3D evlist->core.nr_entries / nr_cgroups;
> +	bpf_map__resize(skel->maps.prev_readings, map_size);
> +	/* cgroup result needs all events (per-cpu) */
> +	map_size =3D evlist->core.nr_entries;
> +	bpf_map__resize(skel->maps.cgrp_readings, map_size);
> +
> +	set_max_rlimit();
> +
> +	err =3D bperf_cgroup_bpf__load(skel);
> +	if (err) {
> +		pr_err("Failed to load cgroup skeleton\n");
> +		goto out;
> +	}
> +
> +	if (cgroup_is_v2("perf_event") > 0)
> +		skel->bss->use_cgroup_v2 =3D 1;
> +
> +	err =3D -1;
> +
> +	cgrp_switch =3D evsel__new(&cgrp_switch_attr);
> +	if (evsel__open_per_cpu(cgrp_switch, evlist->core.all_cpus, -1) < 0) {
> +		pr_err("Failed to open cgroup switches event\n");
> +		goto out;
> +	}
> +
> +	for (i =3D 0; i < nr_cpus; i++) {
> +		link =3D bpf_program__attach_perf_event(skel->progs.on_cgrp_switch,
> +						      FD(cgrp_switch, i));
> +		if (IS_ERR(link)) {
> +			pr_err("Failed to attach cgroup program\n");
> +			err =3D PTR_ERR(link);
> +			goto out;
> +		}
> +	}
> +
> +	/*
> +	 * Update cgrp_idx map from cgroup-id to event index.
> +	 */
> +	cgrp =3D NULL;
> +	i =3D 0;
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (cgrp =3D=3D NULL || evsel->cgrp =3D=3D leader_cgrp) {
> +			leader_cgrp =3D evsel->cgrp;
> +			evsel->cgrp =3D NULL;
> +
> +			/* open single copy of the events w/o cgroup */
> +			err =3D evsel__open_per_cpu(evsel, evlist->core.all_cpus, -1);
> +			if (err) {
> +				pr_err("Failed to open first cgroup events\n");
> +				goto out;
> +			}
> +
> +			map_fd =3D bpf_map__fd(skel->maps.events);
> +			for (cpu =3D 0; cpu < nr_cpus; cpu++) {
> +				int fd =3D FD(evsel, cpu);
> +				__u32 idx =3D evsel->idx * total_cpus +
> +					evlist->core.all_cpus->map[cpu];
> +
> +				err =3D bpf_map_update_elem(map_fd, &idx, &fd,
> +							  BPF_ANY);
> +				if (err < 0) {
> +					pr_err("Failed to update perf_event fd\n");
> +					goto out;
> +				}
> +			}
> +
> +			evsel->cgrp =3D leader_cgrp;
> +		}
> +		evsel->supported =3D true;
> +
> +		if (evsel->cgrp =3D=3D cgrp)
> +			continue;
> +
> +		cgrp =3D evsel->cgrp;
> +
> +		if (read_cgroup_id(cgrp) < 0) {
> +			pr_err("Failed to get cgroup id\n");
> +			err =3D -1;
> +			goto out;
> +		}
> +
> +		map_fd =3D bpf_map__fd(skel->maps.cgrp_idx);
> +		err =3D bpf_map_update_elem(map_fd, &cgrp->id, &i, BPF_ANY);
> +		if (err < 0) {
> +			pr_err("Failed to update cgroup index map\n");
> +			goto out;
> +		}
> +
> +		i++;
> +	}
> +
> +	/*
> +	 * bperf uses BPF_PROG_TEST_RUN to get accurate reading. Check
> +	 * whether the kernel support it
> +	 */
> +	prog_fd =3D bpf_program__fd(skel->progs.trigger_read);
> +	err =3D bperf_trigger_reading(prog_fd, 0);
> +	if (err) {
> +		pr_debug("The kernel does not support test_run for raw_tp BPF programs=
.\n"
> +			 "Therefore, --for-each-cgroup might show inaccurate readings\n");

I think this should be a warning, and we should set err =3D 0 to continue?=
=20

> +	}
> +
> +out:
> +	return err;
> +}
> +

[...]

> +
> +/*
> + * trigger the leader prog on each cpu, so the cgrp_reading map could ge=
t
> + * the latest results.
> + */
> +static int bperf_cgrp__sync_counters(struct evlist *evlist)
> +{
> +	int i, cpu;
> +	int nr_cpus =3D evlist->core.all_cpus->nr;
> +	int prog_fd =3D bpf_program__fd(skel->progs.trigger_read);
> +
> +	for (i =3D 0; i < nr_cpus; i++) {
> +		cpu =3D evlist->core.all_cpus->map[i];
> +		bperf_trigger_reading(prog_fd, cpu);
> +	}
> +
> +	return 0;
> +}
> +
> +static int bperf_cgrp__enable(struct evsel *evsel)
> +{

Do we need to call bperf_cgrp__sync_counters() before setting enabled to 1?=
=20
If we don't, we may count some numbers before setting enabled to 1, no?=20

> +	skel->bss->enabled =3D 1;
> +	return 0;
> +}

[...]

