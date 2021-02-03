Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC8130DDB4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbhBCPLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:11:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234285AbhBCPJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:09:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D37964F86;
        Wed,  3 Feb 2021 15:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612364900;
        bh=pDM4pYBofq+v7TFAcBi5Qa3P75Pwg2/8NYQjNxoKwnQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rmffUVNgOB3l1a4lBHyYnMnCYU2Wf949KuuqlHoUma0OXwIaws8rqVU5durFoK6Lo
         dsy+2d2ppT5DraKD+Mzgsx0beTl6E5ou7a2/p57RUzhJCQny7g/JwJ62o9V8jSvO+n
         Nj+z3MI2JmpZ3kWjSPjDeT2X6RaiGEEOeAQckuvhQuYKsEKl1NEuAhzUP6KwCpqqKq
         N7+t6QwIF5KU5164xK2dUEfWgPGtUiFotPuU3nhLNPcpimMHvAa705/npuVe6iVuO8
         JFW+N0B5ojmFPBLJt2rC6m9ypoS6pbrU6p14kaQaQ30lIO2gM6PknyNFGhNHsReSq2
         ALsRbx1HpYiDQ==
Date:   Thu, 4 Feb 2021 00:08:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jianlin Lv <Jianlin.Lv@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, srikar@linux.vnet.ibm.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf probe: Added protection to avoid endless loop
Message-Id: <20210204000814.7bebaeda0edb54f121159fbd@kernel.org>
In-Reply-To: <20210203145702.1219509-1-Jianlin.Lv@arm.com>
References: <20210203145702.1219509-1-Jianlin.Lv@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Feb 2021 22:57:02 +0800
Jianlin Lv <Jianlin.Lv@arm.com> wrote:

> if dwarf_offdie() return NULL, the continue statement forces the next
> iteration of the loop without update variable off. It will cause an
> endless loop in the process of traversing the compilation unit.
> So added exception protection for loop CUs.
> 

Thanks for the quick update!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> ---
> v2: removed the statement that updates variable in the function argument.
> ---
>  tools/perf/util/probe-finder.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 76dd349aa48d..1b118c9c86a6 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -1187,8 +1187,10 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
>  	while (!dwarf_nextcu(dbg->dbg, off, &noff, &cuhl, NULL, NULL, NULL)) {
>  		/* Get the DIE(Debugging Information Entry) of this CU */
>  		diep = dwarf_offdie(dbg->dbg, off + cuhl, &pf->cu_die);
> -		if (!diep)
> +		if (!diep) {
> +			off = noff;
>  			continue;
> +		}
>  
>  		/* Check if target file is included. */
>  		if (pp->file)
> @@ -1949,8 +1951,10 @@ int debuginfo__find_line_range(struct debuginfo *dbg, struct line_range *lr)
>  
>  		/* Get the DIE(Debugging Information Entry) of this CU */
>  		diep = dwarf_offdie(dbg->dbg, off + cuhl, &lf.cu_die);
> -		if (!diep)
> +		if (!diep) {
> +			off = noff;
>  			continue;
> +		}
>  
>  		/* Check if target file is included. */
>  		if (lr->file)
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
