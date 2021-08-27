Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064573F9858
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 13:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244964AbhH0LHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 07:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbhH0LHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 07:07:50 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0473C061757;
        Fri, 27 Aug 2021 04:07:01 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id t32so4980211qtc.3;
        Fri, 27 Aug 2021 04:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=vNMYOSXAZyBVs7ywdkOKGb2aW1su0o8ULmszjz2RygE=;
        b=bVQTrfPZIoU2sY+o9aPePbCrPkjQyg8PFkxXYGxs3npNTicxuZEi3qtWFuNMm9ktoK
         v8iwGEU7IuhfIpFocJ4txv3SyeqDQ3jfErYwqAX2ryEwxqAeH8OjmSNTQb9+PDf5LtN4
         jOC/cHTXc2aBJSIQMgJMWbpduavhm5DUjXoIWRLjiePoQEnHZgowZKwY+gvc3szu5ZKo
         +rNBDumSCTVoMJ8wxFuP9Y+QQMN65qth4gs2OkKuA49ybtlO14rJDDyE20i3233q+q3J
         JsinozDAmzYXVJJSVp0PhE7QvmEoJB2InWaHBpAKVtJEQs885HrphBMWDbA/R8niZnvP
         iifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=vNMYOSXAZyBVs7ywdkOKGb2aW1su0o8ULmszjz2RygE=;
        b=iSFrpWJOC7Z4LeakINk9D9aS3TJogRGVQVAY48x5NDD4kOtF9wyZ5kVMi+42sPad05
         3idF8LduJayF1D/6q7CR6RhFiU2sU22bkhbq+aKXOECXUg8amo36yLRssRC15GLQU1mT
         aysCEuJLC04KcgKnwb4C3vLPnDqunZymJ7Kkqao5Q7mJvuNzqW0XRHrxfg7Jje94yEnl
         eFU3iidEwhSNZpk8chGeNRiSLSKAYQ4xZjt5yk90U5CEPsCx6bRHtMMsTYa8UD8IHqrb
         SUGxwyu16Wt+S1To3eLoajRPtEuB4D8hN0WQD4pAYjkbU23NOmjGOlBVggF6vmLOxAs9
         otog==
X-Gm-Message-State: AOAM533zwvEkSsWO56XNaXvvogidRpwRTPduiPsJmnPX9ufy0/6l/xNM
        rGzepzSiurpesA8uE9nG3r4=
X-Google-Smtp-Source: ABdhPJzP/HCCf1zxKhYjwS1Opx69ldPQoMOZN2Xi5W4ZPoefJFFdq31xkimt/cRTA21dwDuFzvYeDA==
X-Received: by 2002:a05:622a:10c:: with SMTP id u12mr7785173qtw.303.1630062420607;
        Fri, 27 Aug 2021 04:07:00 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id d68sm4647708qke.19.2021.08.27.04.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 04:07:00 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     SeongJae Park <sj38.park@gmail.com>, akpm@linux-foundation.org,
        markubo@amazon.com, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@Huawei.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendanhiggins@google.com,
        corbet@lwn.net, dwmw@amazon.com, elver@google.com,
        fan.du@intel.com, foersleo@amazon.de, greg@kroah.com,
        gthelen@google.com, guoju.fgj@alibaba-inc.com, jgowans@amazon.com,
        joe@perches.com, mgorman@suse.de, mheyne@amazon.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, rppt@kernel.org, shakeelb@google.com,
        shuah@kernel.org, sieberf@amazon.com, snu@zelle79.org,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v34 05/13] mm/damon: Implement primitives for the virtual memory address spaces
Date:   Fri, 27 Aug 2021 11:06:51 +0000
Message-Id: <20210827110651.1950-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <3b094493-9c1e-6024-bfd5-7eca66399b7e@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Thu, 26 Aug 2021 23:42:19 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 26.08.21 19:29, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > Hello David,
> > 
> > 
> > On Thu, 26 Aug 2021 16:09:23 +0200 David Hildenbrand <david@redhat.com> wrote:
> > 
> >>> +static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
> >>> +{
> >>> +	pte_t *pte = NULL;
> >>> +	pmd_t *pmd = NULL;
> >>> +	spinlock_t *ptl;
> >>> +
> >>
> >> I just stumbled over this, sorry for the dumb questions:
> > 
> > Appreciate for the great questions!
> > 
> >>
> >>
> >> a) What do we know about that region we are messing with?
> >>
> >> AFAIU, just like follow_pte() and follow_pfn(), follow_invalidate_pte()
> >> should only be called on VM_IO and raw VM_PFNMAP mappings in general
> >> (see the doc of follow_pte()). Do you even know that it's within a
> >> single VMA and that there are no concurrent modifications?
> > 
> > We have no idea about the region at this moment.  However, if we successfully
> > get the pte or pmd under the protection of the page table lock, we ensure the
> > page for the pte or pmd is a online LRU-page with damon_get_page(), before
> > updating the pte or pmd's PAGE_ACCESSED bit.  We release the page table lock
> > only after the update.
> > 
> > And concurrent VMA change doesn't matter here because we read and write only
> > the page table.  If the address is not mapped or not backed by LRU pages, we
> > simply treat it as not accessed.
> 
> reading/writing page tables is the real problem.
> 
> > 
> >>
> >> b) Which locks are we holding?
> >>
> >> I hope we're holding the mmap lock in read mode at least. Or how are you
> >> making sure there are no concurrent modifications to page tables / VMA
> >> layout ... ?
> >>
> >>> +	if (follow_invalidate_pte(mm, addr, NULL, &pte, &pmd, &ptl))
> > 
> > All the operations are protected by the page table lock of the pte or pmd, so
> > no concurrent page table modification would happen.  As previously mentioned,
> > because we read and update only page table, we don't care about VMAs and
> > therefore we don't need to hold mmap lock here.
> 
> See below, that's unfortunately not sufficient.
> 
> > 
> > Outside of this function, DAMON reads the VMAs to know which address ranges are
> > not mapped, and avoid inefficiently checking access to the area with the
> > information.  Nevertheless, it happens only occasionally (once per 60 seconds
> > by default), and it holds the mmap read lock in the case.
> > 
> > Nonetheless, I agree the usage of follow_invalidate_pte() here could make
> > readers very confusing.  It would be better to implement and use DAMON's own
> > page table walk logic.  Of course, I might missing something important.  If you
> > think so, please don't hesitate at yelling to me.
> 
> 
> I'm certainly not going to yell :) But unfortunately I'll have to tell 
> you that what you are doing is in my understanding fundamentally broken.
> 
> See, page tables might get removed any time
> a) By munmap() code even while holding the mmap semaphore in read (!)
> b) By khugepaged holding the mmap lock in write mode
> 
> The rules are (ignoring the rmap side of things)
> 
> a) You can walk page tables inside a known VMA with the mmap semaphore 
> held in read mode. If you drop the mmap sem, you have to re-validate the 
> VMA! Anything could have changed in the meantime. This is essentially 
> what mm/pagewalk.c does.
> 
> b) You can walk page tables ignoring VMAs with the mmap semaphore held 
> in write mode.
> 
> c) You can walk page tables lockless if the architecture supports it and 
> you have interrupts disabled the hole time. But you are not allowed to 
> write.
> 
> With what you're doing, you might end up reading random garbage as page 
> table pointers, or writing random garbage to pages that are no longer 
> used as page tables.
> 
> Take a look at mm/gup.c:lockless_pages_from_mm() to see how difficult it 
> is to walk page tables lockless. And it only works because page table 
> freeing code synchronizes either via IPI or fake-rcu before actually 
> freeing a page table.
> 
> follow_invalidate_pte() is, in general, the wrong thing to use. It's 
> specialized to VM_IO and VM_PFNMAP. take a look at the difference in 
> complexity between follow_invalidate_pte() and mm/pagewalk.c!
> 
> I'm really sorry, but as far as I can tell, this is locking-wise broken 
> and follow_invalidate_pte() is the wrong interface to use here.
> 
> Someone can most certainly correct me if I'm wrong, or if I'm missing 
> something regarding your implementation, but if you take a look around, 
> you won't find any code walking page tables without at least holding the 
> mmap sem in read mode -- for a good reason.

Thank you very much for this kind explanation, David!  I will send a patch for
this soon.


Thanks,
SJ

> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
