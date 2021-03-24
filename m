Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAF8348223
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbhCXTpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237892AbhCXTpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616615131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=71BnMFS9rn8SPVKmnpmhBKFC1i10nRCVkAwJRE2/qiI=;
        b=WAnyVc4vQPgUSBT6VTSOiWkm47nmkrvPMxdi4w2QEPKzjJiiVsgdHAymJU0Z5RHQ7KuVWL
        Q2xo/iH2+Dj9mdUSJKiOfT5ZAIj/B3uAB5Rwy4+61myfPfnl3yk4B+7cAcGOUXtnuLJfRL
        o7rG5i3r6evpTLQQts18PkG9OQsTzgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-9ef1xfLNNA2T-RmkDksVBg-1; Wed, 24 Mar 2021 15:43:49 -0400
X-MC-Unique: 9ef1xfLNNA2T-RmkDksVBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F1C21922037;
        Wed, 24 Mar 2021 19:43:47 +0000 (UTC)
Received: from krava (unknown [10.40.196.25])
        by smtp.corp.redhat.com (Postfix) with SMTP id A716262677;
        Wed, 24 Mar 2021 19:43:44 +0000 (UTC)
Date:   Wed, 24 Mar 2021 20:43:43 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mpe@ellerman.id.au,
        acme@kernel.org, jolsa@kernel.org, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com, kjain@linux.ibm.com,
        kan.liang@linux.intel.com, peterz@infradead.org
Subject: Re: [PATCH V2 3/5] tools/perf: Add powerpc support for
 PERF_SAMPLE_WEIGHT_STRUCT
Message-ID: <YFuWb3S8p0ZGjmGu@krava>
References: <1616425047-1666-1-git-send-email-atrajeev@linux.vnet.ibm.com>
 <1616425047-1666-4-git-send-email-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616425047-1666-4-git-send-email-atrajeev@linux.vnet.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 10:57:25AM -0400, Athira Rajeev wrote:
> Add arch specific arch_evsel__set_sample_weight() to set the new
> sample type for powerpc.
> 
> Add arch specific arch_perf_parse_sample_weight() to store the
> sample->weight values depending on the sample type applied.
> if the new sample type (PERF_SAMPLE_WEIGHT_STRUCT) is applied,
> store only the lower 32 bits to sample->weight. If sample type
> is 'PERF_SAMPLE_WEIGHT', store the full 64-bit to sample->weight.
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/arch/powerpc/util/Build   |  2 ++
>  tools/perf/arch/powerpc/util/event.c | 32 ++++++++++++++++++++++++++++++++
>  tools/perf/arch/powerpc/util/evsel.c |  8 ++++++++
>  3 files changed, 42 insertions(+)
>  create mode 100644 tools/perf/arch/powerpc/util/event.c
>  create mode 100644 tools/perf/arch/powerpc/util/evsel.c
> 
> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
> index b7945e5a543b..8a79c4126e5b 100644
> --- a/tools/perf/arch/powerpc/util/Build
> +++ b/tools/perf/arch/powerpc/util/Build
> @@ -4,6 +4,8 @@ perf-y += kvm-stat.o
>  perf-y += perf_regs.o
>  perf-y += mem-events.o
>  perf-y += sym-handling.o
> +perf-y += evsel.o
> +perf-y += event.o
>  
>  perf-$(CONFIG_DWARF) += dwarf-regs.o
>  perf-$(CONFIG_DWARF) += skip-callchain-idx.o
> diff --git a/tools/perf/arch/powerpc/util/event.c b/tools/perf/arch/powerpc/util/event.c
> new file mode 100644
> index 000000000000..f49d32c2c8ae
> --- /dev/null
> +++ b/tools/perf/arch/powerpc/util/event.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/types.h>
> +#include <linux/string.h>
> +#include <linux/zalloc.h>
> +
> +#include "../../../util/event.h"
> +#include "../../../util/synthetic-events.h"
> +#include "../../../util/machine.h"
> +#include "../../../util/tool.h"
> +#include "../../../util/map.h"
> +#include "../../../util/debug.h"

nit, just #include "utils/...h" should work no?

other than that, the patchset looks ok to me

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> +
> +void arch_perf_parse_sample_weight(struct perf_sample *data,
> +				   const __u64 *array, u64 type)
> +{
> +	union perf_sample_weight weight;
> +
> +	weight.full = *array;
> +	if (type & PERF_SAMPLE_WEIGHT)
> +		data->weight = weight.full;
> +	else
> +		data->weight = weight.var1_dw;
> +}
> +
> +void arch_perf_synthesize_sample_weight(const struct perf_sample *data,
> +					__u64 *array, u64 type)
> +{
> +	*array = data->weight;
> +
> +	if (type & PERF_SAMPLE_WEIGHT_STRUCT)
> +		*array &= 0xffffffff;
> +}
> diff --git a/tools/perf/arch/powerpc/util/evsel.c b/tools/perf/arch/powerpc/util/evsel.c
> new file mode 100644
> index 000000000000..2f733cdc8dbb
> --- /dev/null
> +++ b/tools/perf/arch/powerpc/util/evsel.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include "util/evsel.h"
> +
> +void arch_evsel__set_sample_weight(struct evsel *evsel)
> +{
> +	evsel__set_sample_bit(evsel, WEIGHT_STRUCT);
> +}
> -- 
> 1.8.3.1
> 

