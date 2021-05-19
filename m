Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B3B3896A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhEST1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhEST1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:27:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15464C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 12:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hw79MrKuovD7etPKwxzs9sDx+CJQK+CgTkP8HwPx4jo=; b=gg8YOoUchA1EbgsIQc5qffZdB7
        U3rtnd3YK2ELo192kBIdiMwVeCqJwV5jVa+NeGuaSMyND1g2DjRWI1vamjIzcckmq8MOJJXrW67Jb
        a31ktgfc8GD6fnY6pHIv0SmwX+sJ37JpJXtncI9A+GxxiggSFfmdNkmmYTBLh5PqHJnBamGZz6Jfo
        L8ia5mE8p27KIsGcakEeeXKuT2WJw9c58jG2VM63kJkXvy0EaLEF7TUvB2+XeCNiRSpd0+gCNfM/7
        90RlLta/wXcuk1fCjdxqrpo8mG9Ui1Pskfkc/u8S24pv04C+ESi2PCY2zHoYkZe+rz+AjjvXAPIrm
        hesmdzsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljRlk-00FEmP-PH; Wed, 19 May 2021 19:22:48 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB19D986465; Wed, 19 May 2021 21:22:11 +0200 (CEST)
Date:   Wed, 19 May 2021 21:22:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Oliver Sang <oliver.sang@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        x86@kernel.org, Kalesh Singh <kaleshsingh@google.com>
Subject: Re: BUG: unable to handle page fault for address - EIP:
 __kmap_local_page_prot
Message-ID: <20210519192211.GI21560@worktop.programming.kicks-ass.net>
References: <CA+G9fYtAbUGO9oAtL8eZ9Pu-_a1wx3y8Tk=pDO3Fh3dEwoRGWg@mail.gmail.com>
 <87mtsqd0c1.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtsqd0c1.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 08:50:54PM +0200, Thomas Gleixner wrote:
> On Wed, May 19 2021 at 20:38, Naresh Kamboju wrote:
> > While running LTP mm test suite on i386 kernel the following warning and BUG
> > reported on linux next 5.13.0-rc2-next-20210519.
> >
> > The warning is not regression, We have been noticing these warnings often on
> > i386
> 
> Noticing? Did you report them?
> 
> > but kernel BUG: looks to be a new crash.
> 
> It's just the consequence of the problem which is pointed out by the
> warning. Fix below.

Maybe something like so as well?

---
 mm/mremap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index 47c255b60150..477a908bdb6b 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -210,6 +210,10 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 }
 
 #ifdef CONFIG_HAVE_MOVE_PMD
+#if CONFIG_PGTABLE_LEVELS < 2
+#error "Can't very well move non-existant pgtable levels"
+#endif
+
 static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 		  unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd)
 {
@@ -277,6 +281,10 @@ static inline bool move_normal_pmd(struct vm_area_struct *vma,
 #endif
 
 #ifdef CONFIG_HAVE_MOVE_PUD
+#if CONFIG_PGTABLE_LEVELS < 3
+#error "Can't very well move non-existant pgtable levels"
+#endif
+
 static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
 		  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
 {
