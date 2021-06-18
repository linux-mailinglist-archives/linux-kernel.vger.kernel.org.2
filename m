Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79E53ACBED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhFRNSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:18:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233127AbhFRNRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:17:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37079613EC;
        Fri, 18 Jun 2021 13:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624022145;
        bh=+n+iHw/j953X5GMz1sQCPRm5FJcdR4ToT3OFSKdiL3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ax+jEfjMCJEE89SyEn9HKAWDxXDEo6JUdgyVentdZCuUYjmA4ylMBNjD6qojpej53
         T+IfkGlH3y1UMTtNb4QdnhiLYcs6U05Te6Ld3m1Z31Nw86cMFo3JDlpd+FB8UT3zed
         4xLQIq6ykZM5+q5NFl/fNYcSA8fuZZGP7oZVIyzOVm0a3a5Lo2t6VxCDXdN0jgQ07k
         JGV5jEy7PYojjhPs8DDG5Vj0DfIUorJm+mGqvFxYoj/O6GewcyGS0sK70Jnj7Jwxv6
         cXN72yikaIO04ZvqIchqXvH/JGSU2QROQi9JdJFiElHO7Q8aZOdFQzzx15wk1ImjM9
         8bW0g+n4+sdjg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AAB0B40B1A; Fri, 18 Jun 2021 10:15:42 -0300 (-03)
Date:   Fri, 18 Jun 2021 10:15:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] tools/perf probe: Print a hint if adding a probe fails
Message-ID: <YMycflwgCrosgTcb@kernel.org>
References: <20210610094442.1602714-1-naveen.n.rao@linux.vnet.ibm.com>
 <20210610192926.6f7b606f1fefd285b3907cd5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610192926.6f7b606f1fefd285b3907cd5@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 10, 2021 at 07:29:26PM +0900, Masami Hiramatsu escreveu:
> Hi Naveen,
> 
> On Thu, 10 Jun 2021 15:14:42 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > Adding a probe can fail in a few scenarios. perf already checks for the
> > address in the kprobe blacklist. However, the address could still be a
> > jump label, or have a BUG_ON(). In such cases, it isn't always evident
> > why adding the probe failed. Add a hint so that the user knows how to
> > proceed.
> > 
> 
> Thanks for the report.
> 
> Since now there is <tracefs>/error_log, if you see any errors in registering
> probe-events, perf probe should dump the error_log for the hint message.
> Also, kprobes should return the correct different error code for each
> errors.

Was there any followup on this? I think we should do as Masami suggests,
Naveen, could you do it?

Thanks,

- Arnaldo
 
> Thank you,
> 
> > Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  tools/perf/builtin-probe.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
> > index 6b150756677014..ff9f3fdce600dd 100644
> > --- a/tools/perf/builtin-probe.c
> > +++ b/tools/perf/builtin-probe.c
> > @@ -352,8 +352,11 @@ static int perf_add_probe_events(struct perf_probe_event *pevs, int npevs)
> >  	}
> >  
> >  	ret = apply_perf_probe_events(pevs, npevs);
> > -	if (ret < 0)
> > +	if (ret < 0) {
> > +		pr_info("Hint: Check dmesg to understand reason for probe failure.\n"
> > +			"      Consider probing at the next/previous instruction.\n");
> >  		goto out_cleanup;
> > +	}
> >  
> >  	for (i = k = 0; i < npevs; i++)
> >  		k += pevs[i].ntevs;
> > 
> > base-commit: 0808b3d5b7514dc856178dbc509929329bbf301d
> > -- 
> > 2.31.1
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

-- 

- Arnaldo
