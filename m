Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8364365B51
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhDTOjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:39:40 -0400
Received: from mail-il1-f171.google.com ([209.85.166.171]:42687 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhDTOji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:39:38 -0400
Received: by mail-il1-f171.google.com with SMTP id c4so5669315ilq.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 07:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=78qdlKaXI5c/gSLjMnYAG5j/XtzAnKAkFt6jrSWobTY=;
        b=sSc0d8kZB3KD1Cle4/01auORLNfCIOMpvE3RV1TH+uWOVQhqy2r3Ixry/yrwVJQLrT
         QSi9qszCt//6vK8gmPezO8sdE+H7cav6DZu53y9eTo+l4sNh5LtR3y8UJ7sUk/TDyLtW
         y+M4X18mXCBQ7TDLtBbNTndCeu7ZJQ/x9ZwWjbEjoC1qEM9fLUn9ponw8oATdxLRrQhw
         QGW1V8AGsyQmhjLGwORSnlSXbQRg6UAJLoyvXG/9kwaDOazarCGZxTH8fzPcqCzb8l62
         n5P0vhnws0RoiiqK+iUr2sGsis2CQ3h05o3kFHErYU4ziPW+eWASDswC7afjNVSaP1xo
         /j1A==
X-Gm-Message-State: AOAM532cnj+ygClho0TUx+Vx9l9A5CsvnvNMwinOpgnrH0uPxFix70iY
        zmmnkNQK1FeLXw+VJygscCMzLM450W4=
X-Google-Smtp-Source: ABdhPJwE0P8x78EkGHi9DtTb/pP1avcbuKkIaMy3rapRcfs05mICBMGpo7yqu5PV0J4ml7b1NLgkGA==
X-Received: by 2002:a05:6e02:dea:: with SMTP id m10mr22189841ilj.112.1618929547061;
        Tue, 20 Apr 2021 07:39:07 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id e6sm8691965iom.2.2021.04.20.07.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 07:39:06 -0700 (PDT)
Date:   Tue, 20 Apr 2021 14:39:04 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Pratik Sampat <psampat@linux.ibm.com>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] percpu: partial chunk depopulation
Message-ID: <YH7niMfDo3AzF7lG@google.com>
References: <20210419225047.3415425-1-dennis@kernel.org>
 <YH4KzmddTHWx9Gih@google.com>
 <8a1fa15c-3373-6357-2a2e-4a2b8b3bfb06@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a1fa15c-3373-6357-2a2e-4a2b8b3bfb06@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 04:37:02PM +0530, Pratik Sampat wrote:
> 
> On 20/04/21 4:27 am, Dennis Zhou wrote:
> > On Mon, Apr 19, 2021 at 10:50:43PM +0000, Dennis Zhou wrote:
> > > Hello,
> > > 
> > > This series is a continuation of Roman's series in [1]. It aims to solve
> > > chunks holding onto free pages by adding a reclaim process to the percpu
> > > balance work item.
> > > 
> > > The main difference is that the nr_empty_pop_pages is now managed at
> > > time of isolation instead of intermixed. This helps with deciding which
> > > chunks to free instead of having to interleave returning chunks to
> > > active duty.
> > > 
> > > The allocation priority is as follows:
> > >    1) appropriate chunk slot increasing until fit
> > >    2) sidelined chunks
> > >    3) full free chunks
> > > 
> > > The last slot for to_depopulate is never used for allocations.
> > > 
> > > A big thanks to Roman for initiating the work and being available for
> > > iterating on these ideas.
> > > 
> > > This patchset contains the following 4 patches:
> > >    0001-percpu-factor-out-pcpu_check_block_hint.patch
> > >    0002-percpu-use-pcpu_free_slot-instead-of-pcpu_nr_slots-1.patch
> > >    0003-percpu-implement-partial-chunk-depopulation.patch
> > >    0004-percpu-use-reclaim-threshold-instead-of-running-for-.patch
> > > 
> > > 0001 and 0002 are clean ups. 0003 implement partial chunk depopulation
> > > initially from Roman. 0004 adds a reclaim threshold so we do not need to
> > > schedule for every page freed.
> > > 
> > > This series is on top of percpu$for-5.14 67c2669d69fb.
> > > 
> > > diffstats below:
> > > 
> > > Dennis Zhou (2):
> > >    percpu: use pcpu_free_slot instead of pcpu_nr_slots - 1
> > >    percpu: use reclaim threshold instead of running for every page
> > > 
> > > Roman Gushchin (2):
> > >    percpu: factor out pcpu_check_block_hint()
> > >    percpu: implement partial chunk depopulation
> > > 
> > >   mm/percpu-internal.h |   5 +
> > >   mm/percpu-km.c       |   5 +
> > >   mm/percpu-stats.c    |  20 ++--
> > >   mm/percpu-vm.c       |  30 ++++++
> > >   mm/percpu.c          | 252 ++++++++++++++++++++++++++++++++++++++-----
> > >   5 files changed, 278 insertions(+), 34 deletions(-)
> > > 
> > > Thanks,
> > > Dennis
> > Hello Pratik,
> > 
> > Do you mind testing this series again on POWER9? The base is available
> > here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git/log/?h=for-5.14
> > 
> > Thanks,
> > Dennis
> 
> Hello Dennis, I have tested this patchset on POWER9.
> 
> I have tried variations of the percpu_test in the top level and nested cgroups
> creation as the test with 1000:10 didn't show any benefits.

This is most likely because the 1 in every 11 still pins every page
while 1 in 50 does not. Can you try the patch below on top? I think it
may show slightly better perf as well. If it doesn't I'll just drop it.

> 
> The following example shows more consistent benefits with the de-allocation
> strategy.
> Outer: 1000
> Inner: 50
> # ./percpu_test.sh
> Percpu:             6912 kB
> Percpu:           532736 kB
> Percpu:           278784 kB
> 
> I believe it could be a result of bulk freeing within "free_unref_page_commit",
> where pages are only free'd if pcp->count >= pcp->high. As POWER has a larger
> page size it would end up creating lesser number of pages but with the
> effects of fragmentation.

This is unrelated to per cpu pages in slab/slub. Percpu is a separate
memory allocator.

> 
> Having said that, the patchset and its behavior does look good to me.

Thanks, can I throw the following on the appropriate patches? In the
future it's good to be explicit about this because some prefer to credit
different emails.

Tested-by: Pratik Sampat <psampat@linux.ibm.com>

Thanks,
Dennis

The following may do a little better on power9:
---
From a1464c4d5900cca68fd95b935178d72bb74837d5 Mon Sep 17 00:00:00 2001
From: Dennis Zhou <dennis@kernel.org>
Date: Tue, 20 Apr 2021 14:25:20 +0000
Subject: [PATCH] percpu: convert free page float to bytes

The percpu memory allocator keeps around a minimum number of free pages
to ensure we can satisfy atomic allocations. However, we've always kept
this number in terms of pages. On certain architectures like arm and
powerpc, the default page size could be 64k instead of 4k. So, start
with a target number of free bytes and then convert to pages.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index ba13e683d022..287fe3091244 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -80,6 +80,7 @@
 #include <linux/mutex.h>
 #include <linux/percpu.h>
 #include <linux/pfn.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
@@ -107,11 +108,12 @@
 /* chunks in slots below this are subject to being sidelined on failed alloc */
 #define PCPU_SLOT_FAIL_THRESHOLD	3
 
-#define PCPU_EMPTY_POP_PAGES_LOW	2
-#define PCPU_EMPTY_POP_PAGES_HIGH	4
+#define PCPU_EMPTY_POP_PAGES_LOW	(max_t(int, (SZ_8K) / PAGE_SIZE, 1))
+#define PCPU_EMPTY_POP_PAGES_HIGH	(max_t(int, (SZ_16K) / PAGE_SIZE, \
+					       PCPU_EMPTY_POP_PAGES_LOW + 1))
 
 /* only schedule reclaim if there are at least N empty pop pages sidelined */
-#define PCPU_EMPTY_POP_RECLAIM_THRESHOLD	4
+#define PCPU_EMPTY_POP_RECLAIM_THRESHOLD	(PCPU_EMPTY_POP_PAGES_HIGH)
 
 #ifdef CONFIG_SMP
 /* default addr <-> pcpu_ptr mapping, override in asm/percpu.h if necessary */
-- 
2.31.1.368.gbe11c130af-goog

