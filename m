Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5749841C218
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 11:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245225AbhI2J5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 05:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245221AbhI2J5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 05:57:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26EFC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 02:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F1ZLDmFr3JLFI67mtkM8Oy3hemi9FH59+C4PCq5sths=; b=Bx9A2ZQm8vmqJMBPFMuIDNxMyB
        eOMl3ZkUiyslKrodeaEND2oczaTUs42se3v0AbZZkabbDvqckedmQ8L+J85fqlOiVeJDs0kNvY8QX
        gg2Dctz7UPC7xqcjyILXT3RMCNHaEHiIN2f0o5WXO2+maOa4JxqX6/QfV9oQd5IFjPA/VQmgrQ8XH
        limRSmVdVjwo6nh13WHuGZiNbH5w/wDd8I8qFDngAe51PGGFtIL9bxvRB6P44/3dHKhR6YAYGai5x
        IeD9wuwyZU0xBLqt+QM/1wdr7TcAm+qJiKfZZF2z4MVWDyXCigfyAhr/vwQNxRiDByIV+uS7HDdsp
        I6DSRJHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVWHz-00BhuC-Sr; Wed, 29 Sep 2021 09:54:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD91C30023F;
        Wed, 29 Sep 2021 11:54:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BAAE02DC92D07; Wed, 29 Sep 2021 11:54:09 +0200 (CEST)
Date:   Wed, 29 Sep 2021 11:54:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Message-ID: <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com>
 <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com>
 <87o88jfajo.ffs@tglx>
 <87k0j6dsdn.ffs@tglx>
 <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
 <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 04:03:53PM -0700, Andy Lutomirski wrote:
> I think the perfect and the good are a bit confused here. If we go for
> "good", then we have an mm owning a PASID for its entire lifetime.  If
> we want "perfect", then we should actually do it right: teach the
> kernel to update an entire mm's PASID setting all at once.  This isn't
> *that* hard -- it involves two things:
> 
> 1. The context switch code needs to resync PASID.  Unfortunately, this
> adds some overhead to every context switch, although a static_branch
> could minimize it for non-PASID users.

> 2. A change to an mm's PASID needs to sent an IPI, but that IPI can't
> touch FPU state.  So instead the IPI should use task_work_add() to
> make sure PASID gets resynced.

What do we need 1 for? Any PASID change can be achieved using 2 no?

Basically, call task_work_add() on all relevant tasks [1], then IPI
spray the current running of those and presto.

[1] it is nigh on impossible to find all tasks sharing an mm in any sane
way due to CLONE_MM && !CLONE_THREAD.
