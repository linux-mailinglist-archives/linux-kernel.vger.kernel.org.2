Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DE5325B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 01:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhBZApY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 19:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhBZApU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 19:45:20 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633CEC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 16:44:40 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 17so4258158pli.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 16:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h7jDxtZalASzyHkDmaEkhchEdLrcFz/khshrlyrri3k=;
        b=r0Vat1kAG1Bu8IcR6MpU+iBMvoP/CkYqLYmjE4WaZc7OQopnDifxmPEwhM4Hl9Xu+R
         DfA0l3YJSwplfvOnd8KvMYSLPBQFJw4o3zs16vafJuKuSCEGc38NbUqOHUFkKe73eqQ6
         6O39RaxGP1JZIbL4Ocm7d7QY99PH99I49PbzgYkgx+3BO4GTD+3HSL3Px2CTjOUszVGh
         Z284h3NYwZOahyt56aEBLoOx3BxnC1S0+e5UyvHbyh/wpqMWz5z3b1HszmDpiBUeGy/5
         65iBYeSvfvW/8N6xIHbzwpmS2G4F6ijOIRPc40qjTeVpswW1nTdTPGvEvTudOG/HtGc8
         zoew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h7jDxtZalASzyHkDmaEkhchEdLrcFz/khshrlyrri3k=;
        b=JRR/Exk6LWNbSqxlgEJMNWV5gUtV22GTVhPIH764jEiXciBI6ybfP95O+GMxl/NK6a
         VzYeF22DM7mYnUm4Plqk47DnGmxcD7XHYFIKP9yJepTdwudRbtvMDFUwTl0D9LMtYhH3
         fxfjRg3dvx5lVglpqnB+q0qEyEVos0frMDANI7uAuYxJMFk74AhQxdPZigRFh5GaiIH0
         G78DU3+epslp3bWmusaKWy0Dks9vyVk2LukTSluY8eAQGzqHlyp/5spUfQURoQSAkYCV
         z9a1hGOHflc/dmr7YIgMc3x4Ow5ovGzvQmMilZ6++3EImo+xNimrNlNrVGWdTEJP67fp
         L4bA==
X-Gm-Message-State: AOAM532jrxtUtICr0h5XpeMqWYIjbdXejkfKkAe//lMwrcw2rtUgQZM2
        Ecd4LU4Xl/nrm8yLmS+7xM6jMANsy7wNVA==
X-Google-Smtp-Source: ABdhPJwmtflgmUgWFwxajdco2lxGXTx2TGBqit52YW2hmQYM6h5P52xe7XelELD3tQdfepTS7hMl6w==
X-Received: by 2002:a17:902:d202:b029:e4:55cd:dde8 with SMTP id t2-20020a170902d202b02900e455cddde8mr437517ply.51.1614300278242;
        Thu, 25 Feb 2021 16:44:38 -0800 (PST)
Received: from google.com ([2620:15c:f:10:34c4:7c1d:f9ba:4576])
        by smtp.gmail.com with ESMTPSA id i10sm8047735pgo.75.2021.02.25.16.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 16:44:37 -0800 (PST)
Date:   Thu, 25 Feb 2021 16:44:31 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH 1/1] KVM: x86: remove incorrect comment on
 active_mmu_pages
Message-ID: <YDhEby3lwgMVFEjl@google.com>
References: <20210223203707.1135-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223203707.1135-1-dongli.zhang@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021, Dongli Zhang wrote:
> The 'mmu_page_hash' is used as hash table while 'active_mmu_pages' is a
> list. This patch removes the incorrect comment on active_mmu_pages.

Maybe change the last sentence to "Remove the misplaced comment, it's mostly
stating the obvious anyways."  It's more misplaced than flat out incorrect, e.g.
the alternative would be to hoist the comment above mmu_page_hash.  I like
removing it though, IMO mmu_page_hash is the most obvious name out of the
various structures that track shadow pages.

With that tweak:

Reviewed-by: Sean Christopherson <seanjc@google.com>


> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 84499aad01a4..318242512407 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -937,9 +937,6 @@ struct kvm_arch {
>  	unsigned int indirect_shadow_pages;
>  	u8 mmu_valid_gen;
>  	struct hlist_head mmu_page_hash[KVM_NUM_MMU_PAGES];
> -	/*
> -	 * Hash table of struct kvm_mmu_page.
> -	 */
>  	struct list_head active_mmu_pages;
>  	struct list_head zapped_obsolete_pages;
>  	struct list_head lpage_disallowed_mmu_pages;
> -- 
> 2.17.1
> 
