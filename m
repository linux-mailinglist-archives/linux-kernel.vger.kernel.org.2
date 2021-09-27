Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39722418FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 09:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhI0HGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 03:06:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:55214 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233160AbhI0HGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 03:06:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="288083145"
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="288083145"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 00:04:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="519952158"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by orsmga001.jf.intel.com with ESMTP; 27 Sep 2021 00:04:48 -0700
Date:   Mon, 27 Sep 2021 15:04:48 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Denys Vlasenko <dvlasenk@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH] x86, vmlinux.lds: Add debug option to force all data
 sections aligned
Message-ID: <20210927070448.GA78698@shbuild999.sh.intel.com>
References: <1627456900-42743-1-git-send-email-feng.tang@intel.com>
 <20210922185137.ivdp4yoalv4qdbe2@treble>
 <20210923145720.GA28463@shbuild999.sh.intel.com>
 <5ac33795-9402-43e6-9595-d6c07f3250bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ac33795-9402-43e6-9595-d6c07f3250bc@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denys,

On Fri, Sep 24, 2021 at 10:13:42AM +0200, Denys Vlasenko wrote:
[...]
> >
> >For binary size, I just tested 5.14 kernel with a default desktop
> >config from Ubuntu (I didn't use the normal rhel-8.3 config used
> >by 0Day, which is more for server):
> >
> >v5.14
> >------------------------
> >text		data		bss	    dec		hex	filename
> >16010221	14971391	6098944	37080556	235cdec	vmlinux
> >
> >v5.14 + 64B-function-align
> >--------------------------
> >text		data		bss	    dec		hex	filename
> >18107373	14971391	6098944	39177708	255cdec	vmlinux
> >
> >v5.14 + data-align(THREAD_SIZE 16KB)
> >--------------------------
> >text		data		bss	    dec		hex	filename
> >16010221	57001791	6008832	79020844	4b5c32c	vmlinux
> >
> >So for the text-align, we see 13.1% increase for text. And for data-align,
> >there is 280.8% increase for data.
> 
> Page-size alignment of all data is WAY too much. At most, alignment
> to cache line size should work to make timings stable.
> (In your case with "adjacent cache line prefetcher",
> it may need to be 128 bytes. But definitely not 4096 bytes).

This data-alignment patch is inteneded for debug only. Also with this
"SUBALIGN" trick, 4096 is the smallest working value, others like 64
or 2048 will make the kernel not boot.

> 
> >Performance wise, I have done some test with the force-32bytes-text-align
> >option before (v5.8 time), for benchmark will-it-scale, fsmark, hackbench,
> >netperf and kbuild:
> >* no obvious change for will-it-scale/fsmark/kbuild
> >* see both regression/improvement for different hackbench case
> >* see both regression/improvement for netperf, from -20% to +98%
> 
> What usually happens here is that testcases are crafted to measure
> how well some workloads scale, and to measure that efficiently,
> testcases were intentionally written to cause congestion -
> this way, benefits of better algorithms are easily seen.
> 
> However, this also means that in the congested scenario (e.g.
> cache bouncing), small changes in CPU architecture are also
> easily visible - including cases where optimizations are going awry.
> 
> In your presentation, you stumbled upon one such case:
> the "adjacent cache line prefetcher" is counter-productive here,
> it pulls unrelated cache into the CPU, not knowing that
> this is in fact harmful - other CPUs will need this cache line,
> not this one!
> 
> Since this particular case was a change in structure layout,
> increasing alignment of .data sections won't help here.
> 
> My opinion is that we shouldn't worry about this too much.
> Diagnose the observed slow downs, if they are "real"
> (there is a way to improve), fix that, else if they are spurious,
> just let them be.

Agreed. The main topic of the talk is to explain or root cause
those "strange" performance changes. 

> Even when some CPU optimizations are unintentionally hurting some
> benchmarks, on the average they are usually a win:
> CPU makers have hundreds of people looking at that as their
> full-time jobs. With your example of "adjacent cache line prefetcher",
> CPU people might be looking at ways to detect when these
> speculatively pulled-in cache lines are bouncing.

I agree with you on this and I've never implied the HW cache prefetcher
is a bad thing :), see "as being helpful generally" in the foil. Also
in the live LPC discussion, I said "I don't recommend to disable the HW
prefetcher"
 
> >For data-alignment, it has huge impact for the size, and occupies more
> >cache/TLB, plus it hurts some normal function like dynamic-debug. So
> >I'm afraid it can only be used as a debug option.
> >
> >>On a similar vein I think we should re-explore permanently enabling
> >>cacheline-sized function alignment i.e. making something like
> >>CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B the default.  Ingo did some
> >>research on that a while back:
> >>
> >>    https://lkml.kernel.org/r/20150519213820.GA31688@gmail.com
> >
> >Thanks for sharing this, from which I learned a lot, and I hope I
> >knew this thread when we first check strange regressions in 2019 :)
> >
> >>At the time, the main reported drawback of -falign-functions=64 was that
> >>even small functions got aligned.  But now I think that can be mitigated
> >>with some new options like -flimit-function-alignment and/or
> >>-falign-functions=64,X (for some carefully-chosen value of X).
> 
> -falign-functions=64,7 should be about right, I guess.

In last email about kernel size, I used an old gcc version which didn't
support '-flimit-function-alignment', also as FRAME_POINTER option has
big effect on kernel size, I updated the gcc to 10.3.0 and retest
compiling kernel w/ and w/o FRAME_POINTER enabled, in three cases:
1. vanilla v5.14 kernel
2. vanilla v5.14 kernel + '-falign-functions=64'
3. vanilla v5.14 kernel + '-flimit-function-alignment -falign-functions=64:7'

And the sizes are as below ('fp' means CONFIG_FRAME_POINTER=y, and 'nofp'
means it's disabled):

   text		data		bss	    dec		hex	filename
18118898	14976647	6094848	39190393	255ff79	vmlinux-fp
16005288	14976519	6111232	37093039	235feaf	vmlinux-nofp
18118898	14976647	6094848	39190393	255ff79	vmlinux-text-align-fp
18102440	14976519	6111232	39190191	255feaf	vmlinux-text-align-nofp
16021746	14976647	6094848	37093241	235ff79	vmlinux-align-64-7-fp
16005288	14976519	6111232	37093039	235feaf	vmlinux-align-64-7-nofp

size wise, the '-falign-functions=64,7' has good result, but it does
break the vanilla kernel's 16 bytes alignment, and there are random
offset like

ffffffff81145f20 T tick_get_tick_sched
ffffffff81145f40 T tick_nohz_tick_stopped
ffffffff81145f63 T tick_nohz_tick_stopped_cpu
ffffffff81145f8a T tick_nohz_idle_stop_tick
ffffffff811461f4 T tick_nohz_idle_retain_tick
ffffffff8114621e T tick_nohz_idle_enter
ffffffff8114626f T tick_nohz_irq_exit
ffffffff811462ac T tick_nohz_idle_got_tick
ffffffff811462e1 T tick_nohz_get_next_hrtimer

I cannot run it with 0Day's benchmark service right now, but I'm afraid
there may be some performance change.

Btw, I'm still interested in the 'selective isolation' method, that
chose a few .o files from different kernel modules, add alignment to
one function and one global data of the .o file, setting up an
isolation buffer that any alignment change caused by the module before
this .o will _not_ affect the alignment of all .o files after it.

This will have minimal size cost, for one .o file, the worst waste is
128 bytes, so even we pick 128 .o files, the total cost is 8KB text
and 8KB data space.

And surely we need to test if this method can really make kernel
performance more stable, one testing method is to pick some reported
"strange" performance change case, and check if they are gone with
this method. 

Thanks,
Feng


