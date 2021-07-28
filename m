Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB8A3D9735
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 23:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhG1VEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 17:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhG1VEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 17:04:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E527C061765
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 14:04:35 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e5so4264422pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 14:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6oqQGW021mXZJqHUhtjWzolnPxlWrLTQodXSIJOlGhw=;
        b=eLM5EQeizByK/ijs+2tySCIiM3GHSuhXYwUPJ6UphRysKEwpdAJ+mOpZeWu7xL9V63
         QvpZiWmiNEo95qMPAXvd2v0zW9ZVSQC3Vjk23f9H8UEyxGEo7T4JiVwlmMbJmqGHBCax
         WdnE4yPAT81znogqh6ucbl7kXJlxqd2E/RBCmWdv7MeQQvE50lDQoFt4FlhoqOvK5ARC
         PTzDAyIg61H3EmKKCqyiy7E+f4HNlBuTJ2UhJzpuUzxMJDYyJjwhmD6HD7r1OvThixHo
         Eyj1oAEx35Sh7Enci2QkZ3ER77na7POa2ZJn2iEsy5fyU23H5v5w1nRXPqAAIVNzebXV
         YHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6oqQGW021mXZJqHUhtjWzolnPxlWrLTQodXSIJOlGhw=;
        b=dCDaEoju28aQzQ98KiRqWSx8421qaENP+zIzIxiYXyOl4YdrJWHHY5MU7iixOgh57o
         r5Pp5a1ILpRyEdmii+qnEI6IGZu8H8Yuua/VgS4a6BVDv4/C4nh5nsBC9IbinjD6Ynbi
         zgfyVw0TxsddMjEuAdlp83K+3JRQco5Khmf++FQYilUa3UR16KyJyh/LDWV0KKag/2Wi
         q6wVzEUNGOORns5378Jsgzp0lbIQ8BEhn5Dxj/gEhLFhzLmJQUPk+HvzqJ2pLRyvkoZ7
         As9TI6EqpLYbltVXHoUotgs2esFBbeSvH7yGTiN2u5L7KlX4lO/aocgAJkSkzaOwtdy8
         Xgkg==
X-Gm-Message-State: AOAM5309Qbq8qSGCJR4VRXcKZxOXQQ4CSUHFSMRsHNOwN1PrRCGp2PrG
        DCsMWuaJgo6yUShiaflxcPlqxoo5WG3q+A==
X-Google-Smtp-Source: ABdhPJzABD22vgcAIozv/lPX90Kviu7akrDr6A4LvJXVU7vw0qoySbS71Asd4jheWAIQsKpp/LwqzQ==
X-Received: by 2002:a62:ea10:0:b029:399:ff48:e9da with SMTP id t16-20020a62ea100000b0290399ff48e9damr1689492pfh.56.1627506274948;
        Wed, 28 Jul 2021 14:04:34 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id c23sm946425pfn.140.2021.07.28.14.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 14:04:34 -0700 (PDT)
Date:   Wed, 28 Jul 2021 21:04:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 8/9] KVM: X86: Optimize pte_list_desc with per-array
 counter
Message-ID: <YQHGXhOc5gO9aYsL@google.com>
References: <20210625153214.43106-1-peterx@redhat.com>
 <20210625153415.43620-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625153415.43620-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021, Peter Xu wrote:
> Add a counter field into pte_list_desc, so as to simplify the add/remove/loop
> logic.  E.g., we don't need to loop over the array any more for most reasons.
> 
> This will make more sense after we've switched the array size to be larger
> otherwise the counter will be a waste.
> 
> Initially I wanted to store a tail pointer at the head of the array list so we
> don't need to traverse the list at least for pushing new ones (if without the
> counter we traverse both the list and the array).  However that'll need
> slightly more change without a huge lot benefit, e.g., after we grow entry
> numbers per array the list traversing is not so expensive.
> 
> So let's be simple but still try to get as much benefit as we can with just
> these extra few lines of changes (not to mention the code looks easier too
> without looping over arrays).
> 
> I used the same a test case to fork 500 child and recycle them ("./rmap_fork
> 500" [1]), this patch further speeds up the total fork time of about 14%, which
> is a total of 38% of vanilla kernel:
> 
>         Vanilla:      367.20 (+-4.58%)
>         3->15 slots:  302.00 (+-5.30%)
>         Add counter:  265.20 (+-9.88%)
> 
> [1] https://github.com/xzpeter/clibs/commit/825436f825453de2ea5aaee4bdb1c92281efe5b3
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 9b093985a2ef..ba0258bdebc4 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -138,10 +138,15 @@ module_param(dbg, bool, 0644);
>  #include <trace/events/kvm.h>
>  
>  /* make pte_list_desc fit well in cache lines */
> -#define PTE_LIST_EXT 15
> +#define PTE_LIST_EXT 14

Doh, I looked at kvm/queue code before looking at the full series.

>  struct pte_list_desc {
>  	u64 *sptes[PTE_LIST_EXT];
> +	/*
> +	 * Stores number of entries stored in the pte_list_desc.  No need to be
> +	 * u64 but just for easier alignment.  When PTE_LIST_EXT, means full.
> +	 */
> +	u64 spte_count;

Per my feedback to the previous patch, this should be above sptes[] so that rmaps
with <8 SPTEs only touch one cache line.  No idea if it actually matters in
practice, but I can't see how it would harm anything.

>  	struct pte_list_desc *more;
>  };
