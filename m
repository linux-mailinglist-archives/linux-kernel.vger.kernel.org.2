Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0AA422CC7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbhJEPni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbhJEPnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:43:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33D7C061753
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 08:41:46 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so2354775pjw.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 08:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5/7o5EIsmXSiuzP1m4Q+SWodBgxhNUVp7n/GckW+Jrk=;
        b=Dl8yKD10zzy661mtoaa0QdpladaehtORzyWw8GaN0/Az/CLUUH9TBPrvwKoF6GQQs4
         PXQvWfPWsBHlEOT1LDRGkdd+aZjK6DRTpa1NLkqjig72gEJcG4FndrVbdUbpkylaDuVE
         dEvFRUSrC8x5KMWvIGfiEXlMjgyxZsdZ5ptfDNNxIkGk7mqOpn7RsNMdoV6zpFvZHwLr
         43JDIpGK7Oj35lRWTSwrW1t08d42apKif4VNtj6l94zOjuK69osIqs4rmWNN6YuvH4wU
         Koo4kZjiSqGO4GZ8Ej9MJ8loW3X6iqAp8C6bae/u4eu4uAWONJp01OYo7yF0ISHNPGY1
         noEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5/7o5EIsmXSiuzP1m4Q+SWodBgxhNUVp7n/GckW+Jrk=;
        b=cXjdlXodCGMNyGTrmi00PYQbD4qHLlvNQPxuVh3jd+i5Pt49jpmAWo2sj5B91mFM0/
         bmpWnDzaBhfXBSiVfXaPTGnNL8ieAz8+l3BMyt2e/9Na6qNerHi803BNgYZvKWsL1DTP
         aStlDGEpAJOg8wHAplGOqPXsuCzgJuxjI4x7GppMApo/6PSOSgOS2vPg48gx3C2vbyq1
         UlL5C0lNhgfbWi/APcacBcLBoV4+XpzRJ/Xi32xY2Le4CT0vMKrzRtNr3uUEu0Jw7Fr+
         aoTzQ2FQkHriVTxJeE+n/SXHzH1OHFskZWmH7I+44Rz6NXxtxaVl2BwSiE+OPdG6h70n
         2eCw==
X-Gm-Message-State: AOAM531/VWwo5vutC72QDsufVZEjW6xQug2ofCogfBO9aMbHpygYokJp
        TaROtzYWOAEUYabbxhIwwPkYvw==
X-Google-Smtp-Source: ABdhPJz7Eu5WhkXk+3OVsJv0v8fEKxdtoYqJuoAyIMqCgFUECW/V7fiWss45GtxUT3gd2sgeCsfWCg==
X-Received: by 2002:a17:90a:890a:: with SMTP id u10mr4555711pjn.40.1633448506134;
        Tue, 05 Oct 2021 08:41:46 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t1sm17244661pgf.78.2021.10.05.08.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 08:41:45 -0700 (PDT)
Date:   Tue, 5 Oct 2021 15:41:42 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        David Stevens <stevensd@chromium.org>, kvm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] KVM: x86: Fix allocation sizeof argument
Message-ID: <YVxyNgyyxA7EnvJb@google.com>
References: <20211001110106.15056-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001110106.15056-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The allocation for *gfn_track should be for a slot->npages lot of
> short integers, however the current allocation is using sizeof(*gfn_track)
> and that is the size of a pointer, which is too large. Fix this by
> using sizeof(**gfn_track) instead.
> 
> Addresses-Coverity: ("Wrong sizeof argument")
> Fixes: 35b330bba6a7 ("KVM: x86: only allocate gfn_track when necessary")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  arch/x86/kvm/mmu/page_track.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
> index bb5d60bd4dbf..5b785a5f7dc9 100644
> --- a/arch/x86/kvm/mmu/page_track.c
> +++ b/arch/x86/kvm/mmu/page_track.c
> @@ -92,7 +92,7 @@ int kvm_page_track_enable_mmu_write_tracking(struct kvm *kvm)
>  		slots = __kvm_memslots(kvm, i);
>  		kvm_for_each_memslot(slot, slots) {
>  			gfn_track = slot->arch.gfn_track + KVM_PAGE_TRACK_WRITE;
> -			*gfn_track = kvcalloc(slot->npages, sizeof(*gfn_track),
> +			*gfn_track = kvcalloc(slot->npages, sizeof(**gfn_track),
>  					      GFP_KERNEL_ACCOUNT);

Eww (not your patch, the original code).  IMO the double indirection is completely
unnecessary, e.g. I find this far easier to follow

diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index bb5d60bd4dbf..8cae41b831dd 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -75,7 +75,7 @@ int kvm_page_track_enable_mmu_write_tracking(struct kvm *kvm)
 {
        struct kvm_memslots *slots;
        struct kvm_memory_slot *slot;
-       unsigned short **gfn_track;
+       unsigned short *gfn_track;
        int i;
 
        if (write_tracking_enabled(kvm))
@@ -91,13 +91,13 @@ int kvm_page_track_enable_mmu_write_tracking(struct kvm *kvm)
        for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
                slots = __kvm_memslots(kvm, i);
                kvm_for_each_memslot(slot, slots) {
-                       gfn_track = slot->arch.gfn_track + KVM_PAGE_TRACK_WRITE;
-                       *gfn_track = kvcalloc(slot->npages, sizeof(*gfn_track),
-                                             GFP_KERNEL_ACCOUNT);
-                       if (*gfn_track == NULL) {
+                       gfn_track = kvcalloc(slot->npages, sizeof(*gfn_track),
+                                            GFP_KERNEL_ACCOUNT);
+                       if (gfn_track == NULL) {
                                mutex_unlock(&kvm->slots_arch_lock);
                                return -ENOMEM;
                        }
+                       slot->arch.gfn_track[KVM_PAGE_TRACK_WRITE] = gfn_track;
                }
        }
 


>  			if (*gfn_track == NULL) {
>  				mutex_unlock(&kvm->slots_arch_lock);

Hrm, this fails to free the gfn_track allocations for previous memslots.  The
on-demand rmaps code has the exact same bug (it frees rmaps for previous lpages
in the _current_ slot, but does not free previous slots).

And having two separate flows (and flags) for rmaps vs. gfn_track is pointless,
and means we have to maintain two near-identical copies of non-obvious code.

Paolo, is it too late to just drop the original deae4a10f166 ("KVM: x86: only
allocate gfn_track when necessary")?

> -- 
> 2.32.0
> 
