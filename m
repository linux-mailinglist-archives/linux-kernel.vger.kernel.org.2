Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1B5388F36
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353682AbhESNe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:34:57 -0400
Received: from verein.lst.de ([213.95.11.211]:38376 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240462AbhESNex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:34:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DBED467373; Wed, 19 May 2021 15:33:30 +0200 (CEST)
Date:   Wed, 19 May 2021 15:33:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Serge Belyshev <belyshev@depni.sinp.msu.ru>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [i915] b12d691ea5: kernel_BUG_at_mm/memory.c
Message-ID: <20210519133330.GA14452@lst.de>
References: <20210519024322.GA29704@xsang-OptiPlex-9020> <CAHk-=whcr5M=4Mz2ydu4XtxTL_34WkXPnmFmA4f8r+ELXDC6hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whcr5M=4Mz2ydu4XtxTL_34WkXPnmFmA4f8r+ELXDC6hg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 04:58:31PM -1000, Linus Torvalds wrote:
> On Tue, May 18, 2021 at 4:26 PM kernel test robot <oliver.sang@intel.com> wrote:
> >
> > commit: b12d691ea5e01db42ccf3b4207e57cb3ce7cfe91 ("i915: fix remap_io_sg to verify the pgprot")
> > [...]
> > [  778.550996] kernel BUG at mm/memory.c:2183!
> > [  778.559015] RIP: 0010:remap_pfn_range_notrack (kbuild/src/consumer/mm/memory.c:2183 kbuild/src/consumer/mm/memory.c:2211 kbuild/src/consumer/mm/memory.c:2233 kbuild/src/consumer/mm/memory.c:2255 kbuild/src/consumer/mm/memory.c:2311)
> > [  778.688951] remap_pfn_range (kbuild/src/consumer/mm/memory.c:2342)
> > [  778.692700] remap_io_sg (kbuild/src/consumer/drivers/gpu/drm/i915/i915_mm.c:71) i915
> 
> Yeah, so that BUG_ON() checks that theer isn't any old mapping there.
> 
> You can't just remap over an old one, but it does seem like that is
> exactly what commit b12d691ea5e0 ("i915: fix remap_io_sg to verify the
> pgprot") ends up doing.
> 
> So the code used to just do "apply_to_page_range()", which admittedly
> was odd too. But it didn't mind having old mappings and re-applying
> something over them.
> 
> Converting it to use remap_pfn_range() does look better, but it kind
> of depends on it ever being done *once*. But the caller seems to very
> much remap the whole vmsa at fault time, so...
> 
> I don't know what the right thing to do here is, because I don't know
> the invalidation logic and when faults happen.
> 
> I see that there is another thread about different issues on the
> intel-gfx list. Adding a few people to this kernel test robot thread
> too.
> 
> I'd be inclined to revert the commits as "not ready yet", but it would
> be better if somebody can go "yeah, this should be done properly like
> X".

I think reverting just this commit for now is the best thing.
