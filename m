Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2F230671E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 23:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbhA0WRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 17:17:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234153AbhA0WQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611785733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YcOI/UqUJj4wTni8xLXTUoLGcY3M0PTANiH5BbKJk+Q=;
        b=G0KbOuAJ6hgwJ1M8qGaM+qCtI2+wYsjcF9R9Mwlj1iJzun/HBAPk+FKadQTbjZLHmb0gnd
        mRsFWg29Gf2EXxKT0WGEhOA5Mghy+CJDCg5LJOkTQruhm396rLyZ2PK0WQQ6sBJ90m8/FP
        TWYCYSj5S/ILGH2c/flhdq9jC6lxHvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-HnJTI35fOR65n1VlpHNbMQ-1; Wed, 27 Jan 2021 17:15:29 -0500
X-MC-Unique: HnJTI35fOR65n1VlpHNbMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B230802B40;
        Wed, 27 Jan 2021 22:15:27 +0000 (UTC)
Received: from krava (unknown [10.40.193.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 438A95D9C6;
        Wed, 27 Jan 2021 22:15:25 +0000 (UTC)
Date:   Wed, 27 Jan 2021 23:15:24 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH 2/2] perf script: Support dso filter
Message-ID: <20210127221524.GC284633@krava>
References: <20210124232750.19170-1-yao.jin@linux.intel.com>
 <20210124232750.19170-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124232750.19170-2-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 07:27:50AM +0800, Jin Yao wrote:
> Other perf tool builtins have already supported dso filter.
> 
> For example,
> perf report --dso, which only considers symbols in these dsos.
> 
> Now dso filter is supported for perf-script.
> 
> root@kbl-ppc:~# ./perf script --dso "[kernel.kallsyms]"
>             perf 18123 [000] 6142863.075104:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
>             perf 18123 [000] 6142863.075107:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
>             perf 18123 [000] 6142863.075108:         10   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
>             perf 18123 [000] 6142863.075109:        273   cycles:  ffffffff9ca7730a native_write_msr+0xa ([kernel.kallsyms])
>             perf 18123 [000] 6142863.075110:       7684   cycles:  ffffffff9ca3c9c0 native_sched_clock+0x50 ([kernel.kallsyms])
>             perf 18123 [000] 6142863.075112:     213017   cycles:  ffffffff9d765a92 syscall_exit_to_user_mode+0x32 ([kernel.kallsyms])
>             perf 18123 [001] 6142863.075156:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
>             perf 18123 [001] 6142863.075158:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
>             perf 18123 [001] 6142863.075159:         17   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/Documentation/perf-script.txt | 3 +++
>  tools/perf/builtin-script.c              | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index 0ef2261baeb9..6e32b2f9b828 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -444,6 +444,9 @@ include::itrace.txt[]
>  	[0x4007a0, 0x0x4007a9]:
>  	perf script -S 0x4007a0 --addr-range 10
>  
> +--dsos=::
> +	Only consider symbols in these dsos.
> +
>  --call-trace::
>  	Show call stream for intel_pt traces. The CPUs are interleaved, but
>  	can be filtered with -C.
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index e0feda33dbb9..f8d3d8582ea2 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3523,6 +3523,8 @@ int cmd_script(int argc, const char **argv)
>  		     parse_output_fields),
>  	OPT_BOOLEAN('a', "all-cpus", &system_wide,
>  		    "system-wide collection from all CPUs"),
> +	OPT_STRING(0, "dsos", &symbol_conf.dso_list_str, "dso[,dso...]",
> +		   "only consider symbols in these dsos"),
>  	OPT_STRING('S', "symbols", &symbol_conf.sym_list_str, "symbol[,symbol...]",
>  		   "only consider these symbols"),
>  	OPT_INTEGER(0, "addr-range", &symbol_conf.addr_range,
> -- 
> 2.17.1
> 

