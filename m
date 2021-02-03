Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B70A30DB13
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhBCNZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:25:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhBCNZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:25:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B98B64E38;
        Wed,  3 Feb 2021 13:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612358706;
        bh=O+kH3ITMKM6l1qByP0zBPlBOwdqr6u5g3w5pGD/SwUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lgT6NiD7VBQPkUvT3PWCsWepLwf0wZjPA04mmgILMbuu7mstJm+/URQifNaA5yfyS
         bnOXqGpWZ93yC79I35DDrkqT/22f+c1RfFvyBrUvAFvojeSqH+l67sV07IsHZoM02G
         e/CNoLAK0EPx0i7rz43keO59N3n7dpFLo0Il9iLb66HKCLtbsEiZf8ssVmm14LEST/
         hk34fEaYRBkqfoQQEEP5+vIqx3/tHmdskVTFiI8CSIWBQ3XQa4hijc3wIqMXE1rkVN
         DRRfcno+FZBDHLFi3VNwVYv0IuyR5Qr09VqrzbrXDSYmniPXf8J4EXuopCoC43djgm
         zAQot7XdsNp+Q==
Date:   Wed, 3 Feb 2021 22:25:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jianlin Lv <Jianlin.Lv@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, srikar@linux.vnet.ibm.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: Added protection to avoid endless loop
Message-Id: <20210203222502.a8b9b7bf8fba4e0ba0fe5681@kernel.org>
In-Reply-To: <20210203022507.677283-1-Jianlin.Lv@arm.com>
References: <20210203022507.677283-1-Jianlin.Lv@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Feb 2021 10:25:07 +0800
Jianlin Lv <Jianlin.Lv@arm.com> wrote:

> if dwarf_offdie() return NULL, the continue statement forces the next
> iteration of the loop without update variable off. It will cause an
> endless loop in the process of traversing the compilation unit.
> So added exception protection for loop CUs.

Good catch!

> 
> Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> ---
>  tools/perf/util/probe-finder.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 76dd349aa48d..887bffb1cc58 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -1156,7 +1156,7 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
>  	Dwarf_Die *diep;
>  	int ret = 0;
>  
> -	off = 0;
> +	noff = 0;
>  	pf->lcache = intlist__new(NULL);
>  	if (!pf->lcache)
>  		return -ENOMEM;
> @@ -1184,7 +1184,7 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
>  	}
>  
>  	/* Loop on CUs (Compilation Unit) */
> -	while (!dwarf_nextcu(dbg->dbg, off, &noff, &cuhl, NULL, NULL, NULL)) {
> +	while (!dwarf_nextcu(dbg->dbg, off = noff, &noff, &cuhl, NULL, NULL, NULL)) {

I don't like to update variable in function argument, 

I would rather like below code;

>  		/* Get the DIE(Debugging Information Entry) of this CU */
>  		diep = dwarf_offdie(dbg->dbg, off + cuhl, &pf->cu_die);
  		if (!diep) {
+			off = noff;
			continue;
		}

Or, "goto next;" and

> @@ -1208,7 +1208,6 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
>  			if (ret < 0)
>  				break;
>  		}

next:

> -		off = noff;
>  	}
>  
>  found:
> @@ -1919,7 +1918,7 @@ int debuginfo__find_line_range(struct debuginfo *dbg, struct line_range *lr)
>  {
>  	struct line_finder lf = {.lr = lr, .found = 0};
>  	int ret = 0;
> -	Dwarf_Off off = 0, noff;
> +	Dwarf_Off off = 0, noff = 0;
>  	size_t cuhl;
>  	Dwarf_Die *diep;
>  	const char *comp_dir;
> @@ -1943,6 +1942,7 @@ int debuginfo__find_line_range(struct debuginfo *dbg, struct line_range *lr)
>  
>  	/* Loop on CUs (Compilation Unit) */
>  	while (!lf.found && ret >= 0) {
> +		off = noff;

Here too.
Can you update it?

Thank you,

>  		if (dwarf_nextcu(dbg->dbg, off, &noff, &cuhl,
>  				 NULL, NULL, NULL) != 0)
>  			break;
> @@ -1967,7 +1967,6 @@ int debuginfo__find_line_range(struct debuginfo *dbg, struct line_range *lr)
>  				ret = find_line_range_by_line(NULL, &lf);
>  			}
>  		}
> -		off = noff;
>  	}
>  
>  found:
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
