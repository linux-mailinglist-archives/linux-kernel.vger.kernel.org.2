Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA084416185
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241783AbhIWO65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:58:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:62058 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241702AbhIWO64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:58:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="287528049"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="287528049"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 07:57:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="513999620"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga008.fm.intel.com with ESMTP; 23 Sep 2021 07:57:20 -0700
Date:   Thu, 23 Sep 2021 22:57:20 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH] x86, vmlinux.lds: Add debug option to force all data
 sections aligned
Message-ID: <20210923145720.GA28463@shbuild999.sh.intel.com>
References: <1627456900-42743-1-git-send-email-feng.tang@intel.com>
 <20210922185137.ivdp4yoalv4qdbe2@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922185137.ivdp4yoalv4qdbe2@treble>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh, 

On Wed, Sep 22, 2021 at 11:51:37AM -0700, Josh Poimboeuf wrote:
> On Wed, Jul 28, 2021 at 03:21:40PM +0800, Feng Tang wrote:
> > 0day has reported many strange performance changes (regression or
> > improvement), in which there was no obvious relation between the culprit
> > commit and the benchmark at the first look, and it causes people to doubt
> > the test itself is wrong.
> > 
> > Upon further check, many of these cases are caused by the change to the
> > alignment of kernel text or data, as whole text/data of kernel are linked
> > together, change in one domain can affect alignments of other domains.
> > 
> > To help to quickly identify if the strange performance change is caused
> > by _data_ alignment. add a debug option to force the data sections from
> > all .o files aligned on THREAD_SIZE, so that change in one domain won't
> > affect other modules' data alignment.
> > 
> > We have used this option to check some strange kernel changes [1][2][3],
> > and those performance changes were gone after enabling it, which proved
> > they are data alignment related.
> > 
> > Similarly, there is another kernel debug option to check text alignment
> > related performance changes: CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B,  
> > which forces all function's start address to be 64 bytes alinged.
> > 
> > This option depends on CONFIG_DYNAMIC_DEBUG==n, as '__dyndbg' subsection
> > of .data has a hard requirement of ALIGN(8), shown in the 'vmlinux.lds':
> > 
> > "
> > . = ALIGN(8); __start___dyndbg = .; KEEP(*(__dyndbg)) __stop___dyndbg = .;
> > "
> > 
> > It contains all pointers to 'struct _ddebug', and dynamic_debug_init()
> > will "pointer++" to loop accessing these pointers, which will be broken
> > with this option enabled.
> > 
> > [1]. https://lore.kernel.org/lkml/20200205123216.GO12867@shao2-debian/
> > [2]. https://lore.kernel.org/lkml/20200305062138.GI5972@shao2-debian/
> > [3]. https://lore.kernel.org/lkml/20201112140625.GA21612@xsang-OptiPlex-9020/
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  arch/x86/Kconfig.debug        | 13 +++++++++++++
> >  arch/x86/kernel/vmlinux.lds.S |  7 ++++++-
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> Hi Feng,
> 
> Thanks for the interesting LPC presentation about alignment-related
> performance issues (which mentioned this patch).
>  
>   https://linuxplumbersconf.org/event/11/contributions/895/
> 
> I wonder if we can look at enabling some kind of data section alignment
> unconditionally instead of just making it a debug option.  Have you done
> any performance and binary size comparisons?
 
Thanks for reviewing this!

For binary size, I just tested 5.14 kernel with a default desktop
config from Ubuntu (I didn't use the normal rhel-8.3 config used
by 0Day, which is more for server):

v5.14
------------------------
text		data		bss	    dec		hex	filename
16010221	14971391	6098944	37080556	235cdec	vmlinux

v5.14 + 64B-function-align
--------------------------
text		data		bss	    dec		hex	filename
18107373	14971391	6098944	39177708	255cdec	vmlinux

v5.14 + data-align(THREAD_SIZE 16KB)
--------------------------
text		data		bss	    dec		hex	filename
16010221	57001791	6008832	79020844	4b5c32c	vmlinux

So for the text-align, we see 13.1% increase for text. And for data-align,
there is 280.8% increase for data.

Performance wise, I have done some test with the force-32bytes-text-align
option before (v5.8 time), for benchmark will-it-scale, fsmark, hackbench,
netperf and kbuild:
* no obvious change for will-it-scale/fsmark/kbuild
* see both regression/improvement for different hackbench case
* see both regression/improvement for netperf, from -20% to +98%

As I didn't expect the text-align will be turned on by-default, so I
didn't dive deep into it at that time.


For data-alignment, it has huge impact for the size, and occupies more
cache/TLB, plus it hurts some normal function like dynamic-debug. So
I'm afraid it can only be used as a debug option.

> On a similar vein I think we should re-explore permanently enabling
> cacheline-sized function alignment i.e. making something like
> CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B the default.  Ingo did some
> research on that a while back:
> 
>    https://lkml.kernel.org/r/20150519213820.GA31688@gmail.com

Thanks for sharing this, from which I learned a lot, and I hope I
knew this thread when we first check strange regressions in 2019 :)

> At the time, the main reported drawback of -falign-functions=64 was that
> even small functions got aligned.  But now I think that can be mitigated
> with some new options like -flimit-function-alignment and/or
> -falign-functions=64,X (for some carefully-chosen value of X).

Will study more about these options. 

If they have much less size increase and no regression in performance,
then maybe it could be turned on by default.

Thanks,
Feng

> -- 
> Josh
