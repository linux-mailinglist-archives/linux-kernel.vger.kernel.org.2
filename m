Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C983238E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhBXIoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbhBXIm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:42:29 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68986C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:41:48 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id z126so1661592oiz.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=eEx+tUNpWU++e3WbT4VLeCJJv0tZkLBlof3TEfUNWBA=;
        b=dXH9qUxiqg76fHejvHxYm7HW/9xlZ8zhXGRCBwf/DwGoF2jcAyqJ8mdugk3jTNuUnp
         bqvl46EmLaAJLG6fr0RPZA5E7VUNX1jtK+K1JETNp6JWcY5vRjfj85zjqtwUXw0DVMmb
         0rr5WDc9Vt8y9vpKi7mOIfgydPePDYRD169j9CIWT4lQvZlCdTTTAjkeaej4JazF8KZc
         rPvhk8YZopqamTrgjFGwOpsPpro/7ZjmXB2ajbU9AJ34oMGYlqEvPZ2kFi1+k4w22VBn
         vK40RLUwLabxWVkGWs/gdqFndnyAyUblnqRdbsvoQQKzQl5TWaB7wE9/SsJ6rlQs8alS
         jnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=eEx+tUNpWU++e3WbT4VLeCJJv0tZkLBlof3TEfUNWBA=;
        b=b+lfVe5JKEBkbgFh5fXGtonI0MiCc9wnY1R+WKPVdf+IwNVFIQv2pSyNrXgaeMeGT3
         jMIiiCgjYYO7m/0n+3kzLL448UFEQzvo2C2ORf3Z04AyQ7V+o+zuDIEPJyJHUvKrg2+W
         CJZmVjG3WNECc59TIyF8jBxYOI+3YVPzrS18ogF/nlXQs4pIPEwsirGlonYbJF1LQtM2
         m5dIEsVEvXiCdXcqUtGe3yylQ7t8GTUDtnwNgL5PmX5/pIAFULWx8PNoMBk4MPXUi9Mq
         63TfUBm/CRlEmfxmRNLjdyGY3/KVFXnuKk0bM20Yx1gxDjnNH+dVS+SIxbz/BKlZHVVr
         4p4g==
X-Gm-Message-State: AOAM532FUxfK1UEzlMfYO7Oz78r6G8msMmmKaP/EqRQurRmlN2sN8Z5g
        ZbrVK35PFHr29wdHpx055DOlFg==
X-Google-Smtp-Source: ABdhPJwYoDrt4JbhEtTMAbm2jdCW2fhB6hoAR+CKNkoOf4Is/44ko3sczJayh5cSRTjb+eRKVv7BVw==
X-Received: by 2002:aca:b707:: with SMTP id h7mr2117827oif.174.1614156107446;
        Wed, 24 Feb 2021 00:41:47 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v20sm275126oie.2.2021.02.24.00.41.45
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 24 Feb 2021 00:41:46 -0800 (PST)
Date:   Wed, 24 Feb 2021 00:41:44 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>, xuyu@linux.alibaba.com,
        mgorman@suse.de, aarcange@redhat.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, mhocko@suse.com
Subject: Re: [PATCH v6 0/3] mm,thp,shm: limit shmem THP alloc gfp_mask
In-Reply-To: <e3f67a5f-9835-2752-3d35-fb5f6d701cf1@suse.cz>
Message-ID: <alpine.LSU.2.11.2102232329180.9202@eggly.anvils>
References: <20201124194925.623931-1-riel@surriel.com> <alpine.LSU.2.11.2012141226350.1925@eggly.anvils> <e3f67a5f-9835-2752-3d35-fb5f6d701cf1@suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Dec 2020, Vlastimil Babka wrote:
> On 12/14/20 10:16 PM, Hugh Dickins wrote:
> > On Tue, 24 Nov 2020, Rik van Riel wrote:
> > 
> >> The allocation flags of anonymous transparent huge pages can be controlled
> >> through the files in /sys/kernel/mm/transparent_hugepage/defrag, which can
> >> help the system from getting bogged down in the page reclaim and compaction
> >> code when many THPs are getting allocated simultaneously.
> >> 
> >> However, the gfp_mask for shmem THP allocations were not limited by those
> >> configuration settings, and some workloads ended up with all CPUs stuck
> >> on the LRU lock in the page reclaim code, trying to allocate dozens of
> >> THPs simultaneously.
> >> 
> >> This patch applies the same configurated limitation of THPs to shmem
> >> hugepage allocations, to prevent that from happening.
> >> 
> >> This way a THP defrag setting of "never" or "defer+madvise" will result
> >> in quick allocation failures without direct reclaim when no 2MB free
> >> pages are available.
> >> 
> >> With this patch applied, THP allocations for tmpfs will be a little
> >> more aggressive than today for files mmapped with MADV_HUGEPAGE,
> >> and a little less aggressive for files that are not mmapped or
> >> mapped without that flag.
> >> 
> >> v6: make khugepaged actually obey tmpfs mount flags
> >> v5: reduce gfp mask further if needed, to accomodate i915 (Matthew Wilcox)
> >> v4: rename alloc_hugepage_direct_gfpmask to vma_thp_gfp_mask (Matthew Wilcox)
> >> v3: fix NULL vma issue spotted by Hugh Dickins & tested
> >> v2: move gfp calculation to shmem_getpage_gfp as suggested by Yu Xu
> > 
> > Andrew, please don't rush
> > 
> > mmthpshmem-limit-shmem-thp-alloc-gfp_mask.patch
> > mmthpshm-limit-gfp-mask-to-no-more-than-specified.patch
> > mmthpshmem-make-khugepaged-obey-tmpfs-mount-flags.patch
> > 
> > to Linus in your first wave of mmotm->5.11 sendings.
> > Or, alternatively, go ahead and send them to Linus, but
> > be aware that I'm fairly likely to want adjustments later.

And I have a suspicion that Andrew might want to send these in
for 5.12.

I spent a lot of time trying to find a compromise that would
satisfy us all, but failed to do so.  I kept hoping to find one
next day, so never reached the point of responding.

My fundamental objection to Rik's gfp_mask patches (the third
is different, looks good, though I never studied it properly) is
that (as I said right at the start) anyone who uses a huge=always
mount of tmpfs is already advising for huge pages. The situation is
different from anon, where everything on a machine with THP enabled
is liable to get huge pages, and an madvise necessary to distinguish
who wants.  (madvise is also quite the wrong tool for a filesystem.)

But when I tried modifying the patches to reflect that huge=always
already advises for huge, that did not give a satisfactory result
either: precisely what was wrong with every combination I tried,
I do not have to hand - again, I was hoping for a success which
did not arrive.

But if Andrew wants to put these in, I'll no longer object to their
inclusion: it seems wrong to me, to replace one unsatisfactory array
of choices by another unsatisfactory array of choices, but in the end
it's to be decided by what users prefer - if we hear of regressions
(people not getting the huge pages that they have come to expect),
then the patches will have to be reverted.

> > 
> > Sorry for limping along so far behind, but I still have more
> > re-reading of the threads to do, and I'm still investigating
> > why tmpfs huge=always becomes so ineffective in my testing with
> > these changes, even if I ramp up from default defrag=madvise to
> > defrag=always:
> >                     5.10   mmotm
> > thp_file_alloc   4641788  216027
> > thp_file_fallback 275339 8895647

I never devised a suitable test to prove it, but I did come to
believe that the worrying scale of that regression comes from the
kind of unrealistic testing I'm doing, and would not be nearly so
bad in "real life".

Since I'm interested in exercising the assembly and splitting of
huge pages for testing, I'm happy to run kernel builds of many small
source files in a limited huge=always tmpfs in limited memory.  But
for that to work, for the files allocated hugely to fit in, it does
depend on direct reclaim and kswapd to split and shrink the ends of the
older files, so compaction can make huge pages available to the newer.

Whereas most people should be using huge tmpfs more appropriately,
for huge files.

> 
> So AFAICS before the patch shmem allocated hugepages basically with:
> mapping_gfp_mask(inode->i_mapping) |  __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN
> where mapping_gfp_mask() should be the default GFP_HIGHUSER_MOVABLE unless I
> missed some shmem-specific override of the mask.
> 
> So the important flags mean all zones avilable, both __GFP_DIRECT_RECLAIM and
> __GFP_KSWAPD_RECLAIM, but also __GFP_NORETRY which makes it less aggressive.
> 
> Now, with defrag=madvise and without madvised vma, there's just
> GFP_TRANSHUGE_LIGHT, which means no __GFP_DIRECT_RECLAIM (and no
> __GFP_KSWAPD_RECLAIM). Thus no reclaim and compaction at all. Indeed "little
> less aggressive" is an understatement.

Yes, I remember agreeing with your analysis.

> 
> On the other hand, with defrag=always and again without madvised vma there
> should be GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM | __GFP_NORETRY, so
> compared to "before the patch" this is only missing __GFP_KSWAPD_RECLAIM. I
> would be surprised if this meant so much difference in your testing as you show
> above - I think you would have to be allocating those THPs just at a rate where
> kswapd+kcompactd can keep up and nothing else "steals" the pages that background
> reclaim+compaction creates.
> In that (subjectively unlikely) case, I think significant improvement should be
> visible with defrag=defer over defrag=madvise.

I do have reams of results from trying different things, but I'm not
referring to them now: I think I found that, as you supposed, defrag=defer
did give the closest approximation to what I was seeing before the patches;
but was still inferior, in both THP success rate and overall time taken.

But going that way, we might be suggesting one mode of defrag for shmem,
and a different mode of defrag for anon; whereas Rik's intent was to
unify, without more knobs.

> 
> > I've been looking into it off and on for weeks (gfp_mask wrangling is
> > not my favourite task! so tend to find higher priorities to divert me);
> > hoped to arrive at a conclusion before merge window, but still have
> > nothing constructive to say yet, hence my silence so far.
> > 
> > Above's "a little less aggressive" appears understatement at present.
> > I respect what Rik is trying to achieve here, and I may end up
> > concluding that there's nothing better to be done than what he has.
> > My kind of hugepage-thrashing-in-low-memory may be so remote from
> > normal usage, and could be skirting the latency horrors we all want
> > to avoid: but I haven't reached that conclusion yet - the disparity
> > in effectiveness still deserves more investigation.
> > 
> > (There's also a specific issue with the gfp_mask limiting: I have
> > not yet reviewed the allowing and denying in detail, but it looks
> > like it does not respect the caller's GFP_ZONEMASK - the gfp in
> > shmem_getpage_gfp() and shmem_read_mapping_page_gfp() is there to
> > satisfy the gma500, which wanted to use shmem but could only manage
> > DMA32.  I doubt it wants THPS, but shmem_enabled=force forces them.)

Oh, I'd forgotten all about that gma500 aspect:
well, I can send a fixup later on.

> > 
> > Thanks,
> > Hugh
