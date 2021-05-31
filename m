Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8F93969CC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 00:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhEaWvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 18:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231859AbhEaWvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 18:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622501382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y5NlMndcCjHiv1lwuJA8RIjKcYo7HAjS4RgWx28WLPw=;
        b=ToI4Newq0PS21KS0hL3by7hBv8J8Y3NvvKamjVjBBtbjSNH4UGYtLIjgWLnsKZlc527yGH
        N4xuNHMTk72Nq/oiYfvnJXmDKsUDXvz1dUWNTsU64RaEXq0McTTOzFVL6gczYk/9IQw7ob
        v6fQowJLejqAQkvWeHJkncEccfhIRz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119--zE6XeqJOiqz_c_o8rGrmg-1; Mon, 31 May 2021 18:49:39 -0400
X-MC-Unique: -zE6XeqJOiqz_c_o8rGrmg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D694501E0;
        Mon, 31 May 2021 22:49:37 +0000 (UTC)
Received: from krava (unknown [10.40.195.234])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5A4995C1B4;
        Mon, 31 May 2021 22:49:35 +0000 (UTC)
Date:   Tue, 1 Jun 2021 00:49:34 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 0/8] perf: Support perf-mem/perf-c2c for AlderLake
Message-ID: <YLVn/jh/8H5fZ/QJ@krava>
References: <20210527001610.10553-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527001610.10553-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 08:16:02AM +0800, Jin Yao wrote:
> AlderLake uses a hybrid architecture utilizing Golden Cove cores
> (core CPU) and Gracemont cores (atom CPU). This patchset supports
> perf-mem and perf-c2c for AlderLake.
> 
> v2:
> ---
> - Use mem_loads_name__init to keep original behavior for non-hybrid platform.
> - Move x86 specific perf_mem_events[] to arch/x86/util/mem-events.c.
> - Move mem-store event to a new patch.
> - Add a new patch to fix wrong verbose output for recording events
> - Add a new patch to disable 'mem-loads-aux' group before reporting

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> Jin Yao (8):
>   perf tools: Check mem-loads auxiliary event
>   perf tools: Support pmu prefix for mem-load event
>   perf tools: Support pmu prefix for mem-store event
>   perf tools: Check if mem_events is supported for hybrid platform
>   perf mem: Support record for hybrid platform
>   perf mem: Fix wrong verbose output for recording events
>   perf mem: Disable 'mem-loads-aux' group before reporting
>   perf c2c: Support record for hybrid platform
> 
>  tools/perf/arch/arm64/util/mem-events.c   |   2 +-
>  tools/perf/arch/powerpc/util/mem-events.c |   2 +-
>  tools/perf/arch/x86/util/mem-events.c     |  54 ++++++++++--
>  tools/perf/builtin-c2c.c                  |  40 +++++----
>  tools/perf/builtin-mem.c                  |  51 ++++++-----
>  tools/perf/builtin-report.c               |   2 +
>  tools/perf/util/evlist.c                  |  25 ++++++
>  tools/perf/util/evlist.h                  |   1 +
>  tools/perf/util/mem-events.c              | 101 ++++++++++++++++++++--
>  tools/perf/util/mem-events.h              |   4 +-
>  10 files changed, 225 insertions(+), 57 deletions(-)
> 
> -- 
> 2.17.1
> 

