Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65E2452A21
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 06:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbhKPGAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 01:00:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:54311 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238720AbhKPF7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 00:59:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="213663289"
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="213663289"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 21:54:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="454324503"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2021 21:54:10 -0800
Date:   Tue, 16 Nov 2021 13:54:10 +0800
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
        Andy Lutomirski <luto@kernel.org>, longman@redhat.com,
        arnd@arndb.de, akpm@linux-foundation.org, jannh@google.com
Subject: Re: [RFC PATCH] x86, vmlinux.lds: Add debug option to force all data
 sections aligned
Message-ID: <20211116055410.GE34844@shbuild999.sh.intel.com>
References: <1627456900-42743-1-git-send-email-feng.tang@intel.com>
 <20210922185137.ivdp4yoalv4qdbe2@treble>
 <20210923145720.GA28463@shbuild999.sh.intel.com>
 <5ac33795-9402-43e6-9595-d6c07f3250bc@redhat.com>
 <20210927070448.GA78698@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927070448.GA78698@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 03:04:48PM +0800, Feng Tang wrote:
[...]  
> > >For data-alignment, it has huge impact for the size, and occupies more
> > >cache/TLB, plus it hurts some normal function like dynamic-debug. So
> > >I'm afraid it can only be used as a debug option.
> > >
> > >>On a similar vein I think we should re-explore permanently enabling
> > >>cacheline-sized function alignment i.e. making something like
> > >>CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B the default.  Ingo did some
> > >>research on that a while back:
> > >>
> > >>    https://lkml.kernel.org/r/20150519213820.GA31688@gmail.com
> > >
> > >Thanks for sharing this, from which I learned a lot, and I hope I
> > >knew this thread when we first check strange regressions in 2019 :)
> > >
> > >>At the time, the main reported drawback of -falign-functions=64 was that
> > >>even small functions got aligned.  But now I think that can be mitigated
> > >>with some new options like -flimit-function-alignment and/or
> > >>-falign-functions=64,X (for some carefully-chosen value of X).
> > 
> > -falign-functions=64,7 should be about right, I guess.
[...] 
> I cannot run it with 0Day's benchmark service right now, but I'm afraid
> there may be some performance change.
> 
> Btw, I'm still interested in the 'selective isolation' method, that
> chose a few .o files from different kernel modules, add alignment to
> one function and one global data of the .o file, setting up an
> isolation buffer that any alignment change caused by the module before
> this .o will _not_ affect the alignment of all .o files after it.
> 
> This will have minimal size cost, for one .o file, the worst waste is
> 128 bytes, so even we pick 128 .o files, the total cost is 8KB text
> and 8KB data space.
> 
> And surely we need to test if this method can really make kernel
> performance more stable, one testing method is to pick some reported
> "strange" performance change case, and check if they are gone with
> this method. 

Some update on the experiments about "selective isolation": I tried
three code alignment related cases that have been discussed, and
found the method does help to reduce the performance bump, one is
cut from 7.5% to 0.1%, and another from 3.1% to 1.3%.

The 3 cases are:
1. y2038 code cleanup causing +11.7% improvement to 'mmap' test of
   will-it-scale
   https://lore.kernel.org/lkml/20200305062138.GI5972@shao2-debian/#r
2. a hugetlb fix causing +15.9% improvement to 'page_fault3' test of
   will-it-scale
   https://lore.kernel.org/lkml/20200114085637.GA29297@shao2-debian/#r
3. a one-line mm fix causing -30.7% regresson of scheduler test of
   stress-ng
   https://lore.kernel.org/lkml/20210427090013.GG32408@xsang-OptiPlex-9020/#r

These cases are old (one or two years old), and case 3 can't be
reproduced now. Case 1's current performance delta is +3.1%,
while case 2's is +7.5%, and we tried on case 1/2.

The experiment we did is to find what files the patch touches, say
a.c, then we chose the b.c which follows a.c in Makefile which means
the b.o will be linked right after a.o (this is for simplicity, that
there are other factors like special section definitions), and
make one function of b.c aligned on 4096 bytes.

For case 2, the bisected commit c77c0a8ac4c only touches hugetlb.c,
so we made a debug patch for mempolicy.c following it:

  diff --git a/mm/mempolicy.c b/mm/mempolicy.c
  index 067cf7d3daf5..036c93abdf9b 100644
  --- a/mm/mempolicy.c
  +++ b/mm/mempolicy.c
  @@ -804,7 +804,7 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
   }
   
   /* Set the process memory policy */
  -static long do_set_mempolicy(unsigned short mode, unsigned short flags,
  +static long __attribute__((aligned(4096)))  do_set_mempolicy(unsigned short mode, unsigned short flags,
  			     nodemask_t *nodes)
   {
  	struct mempolicy *new, *old;

with it, the performance delta is reduced from 7.5% to 0.1% 

And for case 2, we tried similar way (add 128B align to several files),
and saw the performance change is reduced from 3.1% to 1.3%  

So generally, this seems to be helpful for making the kernel performance
stabler and more controllable. And the cost is not high either, say if
we pick 32 files to make one of their function 128B aligned, the space
waste is 8KB for worst case (128KB for 4096 bytes alignment)

Thoughts?

Thanks,
Feng

