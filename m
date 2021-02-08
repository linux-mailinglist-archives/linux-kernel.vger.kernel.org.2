Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E7F313211
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhBHMR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:17:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:24230 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233102AbhBHMAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:00:08 -0500
IronPort-SDR: eOazuktmJKJgDsTFBHHHm5ZZ5FYGQLjua9K3cT6TTXFnvc8O44AupmBVgslWksCvw7ltV4FcZ7
 yaZSuQ15fQxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9888"; a="180922986"
X-IronPort-AV: E=Sophos;i="5.81,161,1610438400"; 
   d="scan'208";a="180922986"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 03:58:22 -0800
IronPort-SDR: ncRexIF1iT0WrnVQ4ffEt9O5L2TJKdbfmlB5C8vGAAQW/Sz1kRudsPeLWGub1mJ1BnK/UUKbda
 ncavoILoBKbg==
X-IronPort-AV: E=Sophos;i="5.81,161,1610438400"; 
   d="scan'208";a="395357863"
Received: from aantonov-mobl.ccr.corp.intel.com (HELO [10.249.226.173]) ([10.249.226.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 03:58:19 -0800
Subject: Re: [PATCH v4 3/5] perf stat: Helper functions for PCIe root ports
 list in iostat mode
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210203135830.38568-1-alexander.antonov@linux.intel.com>
 <20210203135830.38568-4-alexander.antonov@linux.intel.com>
 <CAM9d7cjs5Su824v+02rEWd5jgvt8tGsMmoXftXBsj-mTTU_xkA@mail.gmail.com>
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
Message-ID: <db4b9f6c-2522-b4bd-fa27-980228844d92@linux.intel.com>
Date:   Mon, 8 Feb 2021 14:58:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7cjs5Su824v+02rEWd5jgvt8tGsMmoXftXBsj-mTTU_xkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/4/2021 3:32 PM, Namhyung Kim wrote:
> On Wed, Feb 3, 2021 at 10:58 PM Alexander Antonov
> <alexander.antonov@linux.intel.com> wrote:
>> Introduce helper functions to control PCIe root ports list.
>> These helpers will be used in the follow-up patch.
>>
>> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
>> ---
>>   tools/perf/arch/x86/util/iostat.c | 124 ++++++++++++++++++++++++++++++
>>   1 file changed, 124 insertions(+)
>>   create mode 100644 tools/perf/arch/x86/util/iostat.c
>>
>> diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
>> new file mode 100644
>> index 000000000000..961e540106e6
>> --- /dev/null
>> +++ b/tools/perf/arch/x86/util/iostat.c
>> @@ -0,0 +1,124 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * perf iostat
>> + *
>> + * Copyright (C) 2020, Intel Corporation
>> + *
>> + * Authors: Alexander Antonov <alexander.antonov@linux.intel.com>
>> + */
>> +
>> +#include <api/fs/fs.h>
>> +#include <linux/kernel.h>
>> +#include <linux/err.h>
>> +#include <limits.h>
>> +#include <stdio.h>
>> +#include <string.h>
>> +#include <errno.h>
>> +#include <sys/types.h>
>> +#include <sys/stat.h>
>> +#include <fcntl.h>
>> +#include <dirent.h>
>> +#include <unistd.h>
>> +#include <stdlib.h>
>> +#include <regex.h>
>> +#include "util/cpumap.h"
>> +#include "util/debug.h"
>> +#include "util/iostat.h"
>> +#include "util/counts.h"
>> +#include "path.h"
>> +
>> +struct iio_root_port {
>> +       u32 domain;
>> +       u8 bus;
>> +       u8 die;
>> +       u8 pmu_idx;
>> +       int idx;
>> +};
>> +
>> +struct iio_root_ports_list {
>> +       struct iio_root_port **rps;
>> +       int nr_entries;
>> +};
>> +
>> +static void iio_root_port_show(FILE *output,
>> +                              const struct iio_root_port * const rp)
>> +{
>> +       if (output && rp)
>> +               fprintf(output, "S%d-uncore_iio_%d<%04x:%02x>\n",
>> +                       rp->die, rp->pmu_idx, rp->domain, rp->bus);
>> +}
>> +
>> +static struct iio_root_port *iio_root_port_new(u32 domain, u8 bus,
>> +                                              u8 die, u8 pmu_idx)
>> +{
>> +       struct iio_root_port *p = calloc(1, sizeof(*p));
>> +
>> +       if (p) {
>> +               p->domain = domain;
>> +               p->bus = bus;
>> +               p->die = die;
>> +               p->pmu_idx = pmu_idx;
>> +       }
>> +       return p;
>> +}
>> +
>> +static struct iio_root_ports_list *iio_root_ports_list_new(void)
>> +{
>> +       struct iio_root_ports_list *list = calloc(1, sizeof(*list));
>> +
>> +       if (list) {
>> +               list->rps = calloc(1, sizeof(struct iio_root_port *));
> This seems unnecessary now.
>
> Thanks,
> Namhyung
>

Yes, you are right. Will be fixed.

Thank you,
Alexander
>> +               if (!list->rps) {
>> +                       free(list);
>> +                       list = NULL;
>> +               }
>> +       }
>> +       return list;
>> +}
>> +
>> +static void iio_root_ports_list_free(struct iio_root_ports_list *list)
>> +{
>> +       int idx;
>> +
>> +       if (list) {
>> +               for (idx = 0; idx < list->nr_entries; idx++)
>> +                       free(list->rps[idx]);
>> +               free(list->rps);
>> +               free(list);
>> +       }
>> +}
>> +
>> +static struct iio_root_port *iio_root_port_find_by_notation(
>> +       const struct iio_root_ports_list * const list, u32 domain, u8 bus)
>> +{
>> +       int idx;
>> +       struct iio_root_port *rp;
>> +
>> +       if (list) {
>> +               for (idx = 0; idx < list->nr_entries; idx++) {
>> +                       rp = list->rps[idx];
>> +                       if (rp && rp->domain == domain && rp->bus == bus)
>> +                               return rp;
>> +               }
>> +       }
>> +       return NULL;
>> +}
>> +
>> +static int iio_root_ports_list_insert(struct iio_root_ports_list *list,
>> +                                     struct iio_root_port * const rp)
>> +{
>> +       struct iio_root_port **tmp_buf;
>> +
>> +       if (list && rp) {
>> +               rp->idx = list->nr_entries++;
>> +               tmp_buf = realloc(list->rps,
>> +                                 list->nr_entries * sizeof(*list->rps));
>> +               if (!tmp_buf) {
>> +                       pr_err("Failed to realloc memory\n");
>> +                       return -ENOMEM;
>> +               }
>> +               tmp_buf[rp->idx] = rp;
>> +               list->rps = tmp_buf;
>> +       }
>> +       return 0;
>> +}
>> --
>> 2.19.1
>>
