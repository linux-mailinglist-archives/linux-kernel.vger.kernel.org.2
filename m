Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0131D3172FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 23:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhBJWLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 17:11:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:55736 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232813AbhBJWKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 17:10:54 -0500
IronPort-SDR: M9CPr5fIEnip2sK+OAzEFH03lweS0hJVdOPKnfYD4NrCmc1cIzBS86LtNFkGXgkpiH92CwCSQ5
 tuq73FJfwPAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="161305879"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="161305879"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 14:10:11 -0800
IronPort-SDR: 9gI3u5umNx/Ddanw0oR+u0CKPd3wlANZvY/NiacXkBBm8lbXyh0e1YEPDRJgYNdZSTvyY1mAOY
 kw3h5TTLSzTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="362293535"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.53])
  by orsmga006.jf.intel.com with ESMTP; 10 Feb 2021 14:10:11 -0800
Date:   Wed, 10 Feb 2021 14:11:34 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com
Subject: Re: [PATCH] x86, sched: Allow NUMA nodes to share an LLC on Intel
 platforms
Message-ID: <20210210221134.GA12410@alison-desk>
References: <20210209223943.9834-1-alison.schofield@intel.com>
 <YCOTujUj3D53uGjd@hirez.programming.kicks-ass.net>
 <b717d5cd-e40d-c86a-05de-a512a5e3b0af@intel.com>
 <YCQ2QiC7If2X8jnP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCQ2QiC7If2X8jnP@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 08:38:42PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 10, 2021 at 07:22:03AM -0800, Dave Hansen wrote:
> > On 2/10/21 12:05 AM, Peter Zijlstra wrote:
> > >> +	if (IS_ENABLED(CONFIG_NUMA))
> > >> +		set_cpu_bug(c, X86_BUG_NUMA_SHARES_LLC);
> > >>  }
> > > This seens wrong too, it shouldn't be allowed pre SKX. And ideally only
> > > be allowed when SNC is enabled.
> > 
> > Originally, this just added a few more models to the list of CPUs with
> > SNC.  I was hoping for something a bit more durable that we wouldn't
> > have to go back and poke at every year or two.
> 
> It's not like we don't have to update a gazillion FMS tables for each
> new instance anyway :-(
> 
> > > Please make this more specific than: all Intel CPUs. Ofcourse, since you
> > > all knew this was an issue, you could've made it discoverable
> > > _somewhere_ :-(
> > 
> > You're totally right, of course.  The hardware could enumerate SNC as a
> > feature explicitly somewhere.  But, that's a little silly because all of
> > the information that it's enumerating about the CPU caches and NUMA
> > nodes present and correct is *correct*.  The secondary information would
> > only be for the CPU to say, "yeah, I'm really sure about that other stuff".
> > 
> > I think this sanity check has outlived its usefulness.
> 
> Maybe BIOS monkeys got better, but I'm not sure I trust it all.
> 
> So SNC is all on-package, do all those nodes have the same pkg id? That
> is, I'm trying to find something to restrict topological madness.
> 
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 88cd0064d1f8..de1010dd0bba 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -458,6 +458,26 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>  	return false;
>  }
>  
> +static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
> +{
> +	if ((c->phys_proc_id == o->phys_proc_id) &&
> +		(c->cpu_die_id == o->cpu_die_id))
> +		return true;
> +	return false;
> +}
> +
> +/*
> + * Unlike the other levels, we do not enforce keeping a
> + * multicore group inside a NUMA node.  If this happens, we will
> + * discard the MC level of the topology later.
> + */
> +static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
> +{
> +	if (c->phys_proc_id == o->phys_proc_id)
> +		return true;
> +	return false;
> +}
> +
>  /*
>   * Define snc_cpu[] for SNC (Sub-NUMA Cluster) CPUs.
>   *
> @@ -495,33 +515,12 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>  	 * means 'c' does not share the LLC of 'o'. This will be
>  	 * reflected to userspace.
>  	 */
> -	if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu))
> +	if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu) && match_pkg(c, o))
>  		return false;
>  
>  	return topology_sane(c, o, "llc");
>  }
>  

This is equivalent to determining if x86_has_numa_in_package.
Do you think there is an opportunity to set x86_has_numa_in_package
earlier, and use it here and in set_cpu_sibling_map()?

With that additional info (match_pkg()) how about -

Instead of this:
-       if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu))
+       if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu) && match_pkg(c, o))

Do this:

-       if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu))
+       if (!topology_same_node(c, o) && match_pkg(c, o))


Looking at Commit 316ad248307f ("sched/x86: Rewrite set_cpu_sibling_map())
which reworked topology WARNINGs, the intent was to "make sure to
only warn when the check changes the end result"

This check doesn't change the end result. It returns false directly
and if it were bypassed completely, it would still return false with
a WARNING.

If we add that additional match_pkg() check is removing the WARNING for
all cases possible?


-snip
