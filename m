Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FE336DB6A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbhD1PO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:14:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239803AbhD1POw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:14:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F6F361440
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 15:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619622847;
        bh=xG7IdJumg4Q9sXJ8+UBUVHjJ+hKMOn7nNzLC0QXPCQU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ksjBkX+Sw4ROm+ksLudw+FDw/+NmY/ywobwWShXfUoBKOOYoAcZR2+k4PZK/f1Xud
         nvBWDWpDKansHO99Hqz82+rPuGcPJ1gqhWPSAF/EQIUJCU7Wg1G04iFLXW/ZhwdoHZ
         TrrnV7pFmK2E4W1HDN3JLm+6BvfRmIYJsV/bn4P0MuS+yMc2Xv2ejwz8JlkxzWDvDa
         wteZ1ICPuRFSz3H+ztxiuhouJLagQoE+mN8K9zxESNDOJIvgfJ/x44AdqCB07sUNKt
         M2fKPJJS5OkqVbWSpedvwVcoD6DPf9z2Rs/WkiOVH/7U7TgYyZFoBpCIp8EvN3wCbn
         4dRUo6q8EyTcA==
Received: by mail-ej1-f47.google.com with SMTP id u17so95279932ejk.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 08:14:07 -0700 (PDT)
X-Gm-Message-State: AOAM532TvmYGqYbp4yIuz0ZYTAm/fyEmRfGcU2qzRZRYT2iTiZihfHD0
        x++/7BPJsNa3cpFpATjGCcF3p+QOdcMynDfY7ZO1Og==
X-Google-Smtp-Source: ABdhPJxOcmIc+lDu0PisdMd/DERFJX0tTTN+bEnjlJAW1lkwYOMUPs398lWAWCP3CiFZM6LmCf3D166ugEX/ePVWSjw=
X-Received: by 2002:a17:906:f742:: with SMTP id jp2mr13124583ejb.199.1619622845689;
 Wed, 28 Apr 2021 08:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210407014502.24091-1-michel@lespinasse.org> <20210407014502.24091-14-michel@lespinasse.org>
 <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org> <20210428145823.GA856@lespinasse.org>
In-Reply-To: <20210428145823.GA856@lespinasse.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 28 Apr 2021 08:13:53 -0700
X-Gmail-Original-Message-ID: <CALCETrVRGtVqv9cMSryfg5q3iZ9s3jBey20cY4K23YLRhQRzbQ@mail.gmail.com>
Message-ID: <CALCETrVRGtVqv9cMSryfg5q3iZ9s3jBey20cY4K23YLRhQRzbQ@mail.gmail.com>
Subject: Re: [RFC PATCH 13/37] mm: implement speculative handling in __handle_mm_fault().
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 8:05 AM Michel Lespinasse <michel@lespinasse.org> wrote:
>
> On Wed, Apr 07, 2021 at 08:36:01AM -0700, Andy Lutomirski wrote:
> > On 4/6/21 6:44 PM, Michel Lespinasse wrote:
> > > The page table tree is walked with local irqs disabled, which prevents
> > > page table reclamation (similarly to what fast GUP does). The logic is
> > > otherwise similar to the non-speculative path, but with additional
> > > restrictions: in the speculative path, we do not handle huge pages or
> > > wiring new pages tables.
> >
> > Not on most architectures.  Quoting the actual comment in mm/gup.c:
> >
> > >  * Before activating this code, please be aware that the following assumptions
> > >  * are currently made:
> > >  *
> > >  *  *) Either MMU_GATHER_RCU_TABLE_FREE is enabled, and tlb_remove_table() is used to
> > >  *  free pages containing page tables or TLB flushing requires IPI broadcast.
> >
> > On MMU_GATHER_RCU_TABLE_FREE architectures, you cannot make the
> > assumption that it is safe to dereference a pointer in a page table just
> > because irqs are off.  You need RCU protection, too.
> >
> > You have the same error in the cover letter.
>
> Hi Andy,
>
> Thanks for your comment. At first I thought did not matter, because we
> only enable ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT on selected
> architectures, and I thought MMU_GATHER_RCU_TABLE_FREE is not set on
> these. But I was wrong - MMU_GATHER_RCU_TABLE_FREE is enabled on X86
> with paravirt. So I took another look at fast GUP to make sure I
> actually understand it.
>
> This brings a question about lockless_pages_from_mm() - I see it
> disabling interrupts, which it explains is necessary for disabling THP
> splitting IPIs, but I do not see it taking an RCU read lock as would
> be necessary for preventing paga table freeing on
> MMU_GATHER_RCU_TABLE_FREE configs. I figure local_irq_save()
> indirectly takes an rcu read lock somehow ? I think this is something
> I should also mention in my explanation, and I have not seen a good
> description of this on the fast GUP side...

Sounds like a bug!  That being said, based on my extremely limited
understanding of how the common RCU modes work, local_irq_save()
probably implies an RCU lock in at least some cases.  Hi Paul!

--Andy
