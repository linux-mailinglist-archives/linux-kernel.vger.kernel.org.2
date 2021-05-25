Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366BB390152
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhEYMud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232696AbhEYMuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:50:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EE1561408;
        Tue, 25 May 2021 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621946942;
        bh=QUX2Qjh+C64K99gtIEF4QokUV1P6ESzhW/K6CgCKWgU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lwipGqaDxwbE+FjAtHCj9PXtXpW60qzRkwm640+P2cXI8ABoMkmq1fQDDqyEX3fXQ
         Vqo/qduvklMDAVSednKu0iy88p2qYY13Kur5uQ46CHtCFUpNV4TRcdtwv8pSRioVzE
         DU7e3vHriz5JLHJKJ8tSB/9+OrgZgeiJ2nActX19k9LRuRLqEtqgB15Ba2m31pvyO1
         AvS+WEB0xnUdlPa8UwdGRlFoVBASZpHO4iXOwwcLGe+Et5wcHEcAGRLUoyFpCwSo3i
         y3LUw3E8bmcq1PhO5mxi7yWwjHX4oGsJzyzZiwoswaeQirTLbet/9bHcIqAtz96PMn
         /7+LcMmcbDI5A==
Date:   Tue, 25 May 2021 21:48:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, jolsa@redhat.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH] perf probe: Provide more detail with relocation warning
Message-Id: <20210525214858.33a66846ac09e499c3268a63@kernel.org>
In-Reply-To: <20210525043744.193297-1-ravi.bangoria@linux.ibm.com>
References: <20210525043744.193297-1-ravi.bangoria@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021 10:07:44 +0530
Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:

> When run as normal user with default sysctl kernel.kptr_restrict=0
> and kernel.perf_event_paranoid=2, perf probe fails with:
> 
>   $ ./perf probe move_page_tables
>   Relocated base symbol is not found!
> 
> The warning message is not much informative. The reason perf fails
> is because /proc/kallsyms is restricted by perf_event_paranoid=2
> for normal user and thus perf fails to read relocated address of
> the base symbol.
> 
> Tweaking kptr_restrict and perf_event_paranoid can change the
> behavior of perf probe. Also, running as root or privileged user
> works too. Add these details in the warning message.
> 
> Plus, kmap->ref_reloc_sym might not be always set even if
> host_machine is initialized. Above is the example of the same.
> Remove that comment.

Yes, those are restricted in some cases. Anyway without priviledged
(super) user, perf probe can not set the probe in ftrace.

Hmm, I think it should check the effective user-id at first. If it
is not super user and the action will access tracefs and kallsyms,
it should warn at that point. 

Thank you,

> 
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  tools/perf/util/probe-event.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index a78c8d59a555..3a7649835ec9 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -108,7 +108,6 @@ void exit_probe_symbol_maps(void)
>  
>  static struct ref_reloc_sym *kernel_get_ref_reloc_sym(struct map **pmap)
>  {
> -	/* kmap->ref_reloc_sym should be set if host_machine is initialized */
>  	struct kmap *kmap;
>  	struct map *map = machine__kernel_map(host_machine);
>  
> @@ -819,7 +818,10 @@ post_process_kernel_probe_trace_events(struct probe_trace_event *tevs,
>  
>  	reloc_sym = kernel_get_ref_reloc_sym(&map);
>  	if (!reloc_sym) {
> -		pr_warning("Relocated base symbol is not found!\n");
> +		pr_warning("Relocated base symbol is not found! "
> +			   "Check /proc/sys/kernel/kptr_restrict\n"
> +			   "and /proc/sys/kernel/perf_event_paranoid. "
> +			   "Or run as privileged perf user.\n\n");
>  		return -EINVAL;
>  	}
>  
> @@ -3025,7 +3027,10 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
>  			(!pp->retprobe || kretprobe_offset_is_supported())) {
>  		reloc_sym = kernel_get_ref_reloc_sym(NULL);
>  		if (!reloc_sym) {
> -			pr_warning("Relocated base symbol is not found!\n");
> +			pr_warning("Relocated base symbol is not found! "
> +				   "Check /proc/sys/kernel/kptr_restrict\n"
> +				   "and /proc/sys/kernel/perf_event_paranoid. "
> +				   "Or run as privileged perf user.\n\n");
>  			ret = -EINVAL;
>  			goto out;
>  		}
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
