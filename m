Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4832381B2C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 23:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbhEOVTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 17:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229938AbhEOVTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 17:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621113516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zBUSTjaOt7lKl1TV4Dqo1lACa/ZYYOqm/0r3o0CUJzM=;
        b=X8qbm5nTj7ZuidzVXfVfFClRF/rYRMVVm0Z429io3a40ANtblXa2n9w6b3vdqwkc/EHr7y
        58IQ2o5swL5vO4YK2Ckvfy4yIlozyuVJIPnenWPvGLNV170pNekzgJ9vKk18fyl2Jeq72I
        jMZP7t2OWm8GFPpdy+pxogGCnXSVQWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-VfUQzT0dNkq5S1jpH395Bw-1; Sat, 15 May 2021 17:18:32 -0400
X-MC-Unique: VfUQzT0dNkq5S1jpH395Bw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3E725F9F1;
        Sat, 15 May 2021 21:18:30 +0000 (UTC)
Received: from krava (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with SMTP id B13C519C79;
        Sat, 15 May 2021 21:18:27 +0000 (UTC)
Date:   Sat, 15 May 2021 23:18:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 0/2] perf header: Support HYBRID_TOPOLOGY and
 HYBRID_CPU_PMU_CAPS
Message-ID: <YKA6oqfP0niinZkD@krava>
References: <20210514122948.9472-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514122948.9472-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 08:29:46PM +0800, Jin Yao wrote:
> AlderLake uses a hybrid architecture utilizing Golden Cove cores
> (core cpu) and Gracemont cores (atom cpu). It would be useful to let user
> know the hybrid topology, the HYBRID_TOPOLOGY feature in header indicates
> which cpus are core cpus, and which cpus are atom cpus.
> 
> On hybrid platform, it may have several cpu pmus, such as, "cpu_core" and
> "cpu_atom". The HYBRID_CPU_PMU_CAPS feature in perf header is created to
> support multiple cpu pmus.
> 
> v4:
> ---
> - Only minor update in '[PATCH v4 2/2] perf header: Support HYBRID_CPU_PMU_CAPS feature'.
>   1. Directly return process_per_cpu_pmu_caps() in process_cpu_pmu_caps.
>      Remove the variable 'ret'.
>   2. Set 'ret = -1' if (!n->pmu_name) in process_hybrid_cpu_pmu_caps().

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> v3:
> ---
> - For "[PATCH v3 1/2] perf header: Support HYBRID_TOPOLOGY feature",
>   update HEADER_HYBRID_TOPOLOGY format in perf.data-file-format.txt.
> 
> - For "[PATCH v3 2/2] perf header: Support HYBRID_CPU_PMU_CAPS feature",
>   Don't extend the original CPU_PMU_CAPS to support hybrid cpu pmus.
>   Instead, create a new feature 'HYBRID_CPU_PMU_CAPS' in header.
> 
> v2:
> ---
> - In "perf header: Support HYBRID_TOPOLOGY feature", don't use the n->map
>   to print the cpu list, just use n->cpus.
> 
> - Separate hybrid CPU_PMU_CAPS support into two patches:
>   perf header: Write hybrid CPU_PMU_CAPS
>   perf header: Process hybrid CPU_PMU_CAPS
> 
> - Add some words to perf.data-file-format.txt for HYBRID_TOPOLOGY and
>   hybrid CPU_PMU_CAPS.
> 
> Jin Yao (2):
>   perf header: Support HYBRID_TOPOLOGY feature
>   perf header: Support HYBRID_CPU_PMU_CAPS feature
> 
>  .../Documentation/perf.data-file-format.txt   |  33 +++
>  tools/perf/util/cputopo.c                     |  80 ++++++
>  tools/perf/util/cputopo.h                     |  13 +
>  tools/perf/util/env.c                         |  12 +
>  tools/perf/util/env.h                         |  16 ++
>  tools/perf/util/header.c                      | 249 ++++++++++++++++--
>  tools/perf/util/header.h                      |   2 +
>  tools/perf/util/pmu-hybrid.h                  |  11 +
>  8 files changed, 397 insertions(+), 19 deletions(-)
> 
> -- 
> 2.17.1
> 

