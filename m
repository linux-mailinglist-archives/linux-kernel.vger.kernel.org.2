Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E683A356176
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 04:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348127AbhDGCtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 22:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbhDGCtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 22:49:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD32C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 19:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=czw0NKvfj1CYNJsZJ8QXfSvhtH1Tu2flRlleTlgXKQk=; b=sV31xBpM8O1Dln4u5AytLygMsh
        o0SMLCFEMvHK+KO5oxpty68CF8FPyhOmQ3cAkdvCVQXyIjP3Sxpk0KP3g0oJu8R2oCqQBiDrb3dHm
        Tc+tT2IDTnp/MpqLbSMXicIGCqea8hT4tbsgPLGTSyQ4/Gg2y72fUQYXpv4397QtPTdhiTewK9mZT
        gqbFTsEkSEkctS7yBu81ev71NFJ9SN2Mp0MKi66/8am1DbgomhMdQCY+qbVocx3Wit4J9fq2XzfRW
        IHXT6AKsr3ZfJymj48W0Zz7GOJ+FpmVRz6Z+kwbg0mBkd8Joy3dNppapODcNvB/xibFJK7wKyQkjQ
        N/IosjQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTyEl-00DmjV-Dw; Wed, 07 Apr 2021 02:48:15 +0000
Date:   Wed, 7 Apr 2021 03:48:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 33/37] mm: enable speculative fault handling only for
 multithreaded user space
Message-ID: <20210407024811.GA2531743@casper.infradead.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-34-michel@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407014502.24091-34-michel@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 06:44:58PM -0700, Michel Lespinasse wrote:
> +	/* Only try spf for multithreaded user space faults. */

This comment is misleading ... mm_users will also be incremented for
ptraced programs as well as programs that are having their /proc/$pid/maps
examined, etc.  Maybe:

	/* No need to try spf for single-threaded programs */

Also, please, can we not use an acronym for this feature?  It's not a
speculative page fault.  The page fault is really happening.  We're
trying to handle it under RCU protection (if anything the faultaround
code is the speculative page fault code ...)  This is unlocked page
fault handling, perhaps?

> +	if (!(flags & FAULT_FLAG_USER) || atomic_read(&mm->mm_users) == 1)
> +		goto no_spf;
> +
>  	count_vm_event(SPF_ATTEMPT);
>  	seq = mmap_seq_read_start(mm);
>  	if (seq & 1)
> @@ -1351,6 +1355,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>  
>  spf_abort:
>  	count_vm_event(SPF_ABORT);
> +no_spf:
>  
>  	/*
>  	 * Kernel-mode access to the user address space should only occur
> -- 
> 2.20.1
> 
> 
