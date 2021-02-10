Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4F7316091
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhBJIGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbhBJIGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:06:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44800C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ORx5ViwjJV9pMKGucAYChSgTytRoYsvTBgReihaihv4=; b=g2bmdM8aePGB7YyGJcObvKv44o
        0HKb3mHI+7gRKpEnEwbEvL38jBZuMQYRRtwYLeUDrgG5hJwg7e/m3A+nAt5W8pcuOBBlfPuItqH4A
        OMaUVRoFe12OfOa+HriZocqHoDd5k9paHAWp11LJjD0Xf4RvLJMAKbyK9NbTMTMfmhxQf9d4WB2SG
        l9RQEIy0U2UxtyiGlRTP9ETDrf+92WlrBrPwmuOOaWztv33nQPHFzEHa86gHzXw1BUiOrDNNeoWQH
        Hhi9ehCwMGHDY29/pE0ju2ItPWKRlckZgFP0/25/t4WCbMpkGhT6/6N1UNUJfBViQgo8lpjumMom9
        yEf2xhdw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l9kUt-008YKA-B1; Wed, 10 Feb 2021 08:05:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43DEA3010D2;
        Wed, 10 Feb 2021 09:05:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1CDB4201D19B1; Wed, 10 Feb 2021 09:05:14 +0100 (CET)
Date:   Wed, 10 Feb 2021 09:05:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <YCOTujUj3D53uGjd@hirez.programming.kicks-ass.net>
References: <20210209223943.9834-1-alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209223943.9834-1-alison.schofield@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 02:39:43PM -0800, Alison Schofield wrote:

> Commit 1340ccfa9a9a ("x86,sched: Allow topologies where NUMA nodes
> share an LLC") added a vendor and model specific check to skip the
> topology_sane() check for Intel's Sky Lake Server CPUs where NUMA
> nodes shared an LLC.
> 
> This topology is no longer a quirk for Intel CPUs as Ice Lake and
> Sapphire Rapids CPUs exhibit the same topology. Rather than maintain
> the quirk list, define a synthetic flag that directs the scheduler
> to allow this topology without warning for all Intel CPUs when NUMA
> is configured.

Hurmph, I still think it's daft.

> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 816fdbec795a..027348261080 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -719,6 +719,21 @@ static void init_intel(struct cpuinfo_x86 *c)
>  		tsx_disable();
>  
>  	split_lock_init();
> +
> +	/*
> +	 * Set X86_BUG_NUMA_SHARES_LLC to allow topologies where NUMA
> +	 * nodes share an LLC. In Sub-NUMA Clustering mode Intel CPUs
> +	 * may enumerate an LLC as shared by multiple NUMA nodes. The
> +	 * LLC is shared for off-package data access but private to
> +	 * the NUMA node for on-package access. This topology first
> +	 * appeared in SKYLAKE_X. It was treated as a quirk and allowed.
> +	 * This topology reappeared in ICELAKE_X and SAPPHIRERAPIDS_X.
> +	 * Rather than maintain a list of quirk CPUS, allow this topology
> +	 * on all Intel CPUs with NUMA configured. When this X86_BUG is
> +	 * set, the scheduler accepts this topology without warning.
> +	 */
> +	if (IS_ENABLED(CONFIG_NUMA))
> +		set_cpu_bug(c, X86_BUG_NUMA_SHARES_LLC);
>  }

This seens wrong too, it shouldn't be allowed pre SKX. And ideally only
be allowed when SNC is enabled.

Please make this more specific than: all Intel CPUs. Ofcourse, since you
all knew this was an issue, you could've made it discoverable
_somewhere_ :-(
