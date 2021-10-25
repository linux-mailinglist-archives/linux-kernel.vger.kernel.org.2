Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60702439462
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 13:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhJYLCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 07:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhJYLCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 07:02:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E8DC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 04:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=acPLA71S1ep7pYBvutH8rAYXBSbDlehTnu3UD961M04=; b=FIjBlj52Y8W6YmMnXMkuPpo4u3
        aWPYKAZG3rmv1OW4UfS953EDP3UVSfXwLZJetgX2iGwm4pTvo0ftDFJE19juoV/GZgoosmTYQqYu+
        M1I/MCKsgq3f3rj1hVb9VZ/of6kP3lNl6CxEsk8FXjIXpLo1tk+hssqJ0jdCfTBgxWsY5b6fulEHm
        n7wPW9/5TaDte5l5qbBbJZMaqztRueLYDn2E7kJqLtu0bqFmC9ZmRZm0yoUG3z4QbvU42JHgHH7bp
        jfAF7WdEkEotfpXKAlbtWcF9Nrx/82oGtZ+h26XqPzT7yBJYjN5nt/OCscg8nM4rpGNUqnkUtXTF5
        wDSKMwQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mexht-00C8Ba-PZ; Mon, 25 Oct 2021 10:59:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6849300230;
        Mon, 25 Oct 2021 12:59:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F67D20C6C14F; Mon, 25 Oct 2021 12:59:56 +0200 (CEST)
Date:   Mon, 25 Oct 2021 12:59:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [PATCH v2 3/5] x86/mm: check exec permissions on fault
Message-ID: <YXaOLAIo7B0+1NUc@hirez.programming.kicks-ass.net>
References: <20211021122112.592634-1-namit@vmware.com>
 <20211021122112.592634-4-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021122112.592634-4-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 05:21:10AM -0700, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>

> Add a check to prevent access_error() from returning mistakenly that
> page-faults due to instruction fetch are not allowed. Intel SDM does not
> indicate whether "instruction fetch" and "write" in the hardware error
> code are mutual exclusive, so check both before returning whether the
> access is allowed.

Dave, can we get that clarified? It seems a bit naf and leads to
confusing code IMO.

Other than that, the change looks ok to me.

> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index b2eefdefc108..e776130473ce 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1100,10 +1100,17 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
>  				       (error_code & X86_PF_INSTR), foreign))
>  		return 1;
>  
> -	if (error_code & X86_PF_WRITE) {
> +	if (error_code & (X86_PF_WRITE | X86_PF_INSTR)) {
>  		/* write, present and write, not present: */
> -		if (unlikely(!(vma->vm_flags & VM_WRITE)))
> +		if ((error_code & X86_PF_WRITE) &&
> +		    unlikely(!(vma->vm_flags & VM_WRITE)))
>  			return 1;
> +
> +		/* exec, present and exec, not present: */
> +		if ((error_code & X86_PF_INSTR) &&
> +		    unlikely(!(vma->vm_flags & VM_EXEC)))
> +			return 1;
> +
>  		return 0;
>  	}



