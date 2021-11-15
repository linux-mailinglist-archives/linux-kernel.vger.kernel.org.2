Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78E2451BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352441AbhKPAIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347651AbhKOTlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:41:02 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF16C061746
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 11:23:31 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so111281pja.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 11:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nPVEo+hKHgyq8lsQKVBoK2yvYubgVGaMGZmVFG+CK/w=;
        b=WM7edfzFScZ2aXRNtXCZJKRhJYyurxkKdDUbO6Z7/ADhGlQC/mUbv1njQHVyOMQWcy
         +e2d/WqmjKTNBgIfoYxULbutarIDJQ2smdwwQjYZ5iRBt70Ci6G1ffvkClhFEt2xQNri
         ZaQClW8iWH+HCe+8jGN6b1Xo+ZhgMBarSGAvMZ8/J7o1zbK6mR7tNOxItbPI64xMi4Qk
         O3KG9jTIM9LbrYdrTYPcCd6yX1TPiww0seJOVcpR7bhGfsu7RFyX2UhH3tVQc5olrOol
         R3p2Szf+oFpU0qO/Ev5l15H01xWW95nDLAYGedtbIz3m2PCwCXYImYpwxbWp1ZAE7vSL
         CeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nPVEo+hKHgyq8lsQKVBoK2yvYubgVGaMGZmVFG+CK/w=;
        b=kCjC/abUArz1fcWCHcBzLVvADNFsvBJBwRgQEx8BtLCSUxOtadaipiyO09s2eGfBPn
         XNIVFT8rKBSTM1WLVtWkWtGNlluDWDAFj7TxoZuxOm4q8RZdVmLA5HqvrViO1w6jq4Bs
         pTdVB+csxz8Uz/QFXfjmMNVkjd2M6D8kZte7rZsza8HNmgyPbuAbWUZyz4pC2sJNsIyU
         KNphjq7SnR/DMYyacqN+ATTwyAyuOes3gA2fkAHHOOXk5sUwgQ52OIcWNsdq0jcGWcGs
         sWR1do0pPhJaCNz6SwzufQuSl+K7T186soyNC5FlhtVbXzsvU+knjX5BS8HuG+jzB1ll
         49kw==
X-Gm-Message-State: AOAM532vGfpLSgqT6abSqbvCxGBdHmCK5MeRFaQ0ZkvrTE167SlKv1rU
        v9QEX7IFnKNXqad2GZrF+4mlSQ==
X-Google-Smtp-Source: ABdhPJyNw1GrRvLTMWZ6Xnn4PkIKCBsuERQ7wlYQcz2IeqXCD/FNpYcGvDcf5rJiPR75oAR/sMno2w==
X-Received: by 2002:a17:90a:df8d:: with SMTP id p13mr67019704pjv.197.1637004211130;
        Mon, 15 Nov 2021 11:23:31 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u38sm17006008pfg.0.2021.11.15.11.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 11:23:30 -0800 (PST)
Date:   Mon, 15 Nov 2021 19:23:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Update number of zapped pages even if page
 list is stable
Message-ID: <YZKzr4mn1jJ3vdqK@google.com>
References: <20211111221448.2683827-1-seanjc@google.com>
 <CALzav=dpzzKgaNRLrSBy71WBvybWmRJ39eDv4hPXsbU_DSS-fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=dpzzKgaNRLrSBy71WBvybWmRJ39eDv4hPXsbU_DSS-fA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021, David Matlack wrote:
> On Thu, Nov 11, 2021 at 2:14 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > When zapping obsolete pages, update the running count of zapped pages
> > regardless of whether or not the list has become unstable due to zapping
> > a shadow page with its own child shadow pages.  If the VM is backed by
> > mostly 4kb pages, KVM can zap an absurd number of SPTEs without bumping
> > the batch count and thus without yielding.  In the worst case scenario,
> > this can cause an RCU stall.
> >
> >   rcu: INFO: rcu_sched self-detected stall on CPU
> >   rcu:     52-....: (20999 ticks this GP) idle=7be/1/0x4000000000000000
> >                                           softirq=15759/15759 fqs=5058
> >    (t=21016 jiffies g=66453 q=238577)
> >   NMI backtrace for cpu 52
> >   Call Trace:
> >    ...
> >    mark_page_accessed+0x266/0x2f0
> >    kvm_set_pfn_accessed+0x31/0x40
> >    handle_removed_tdp_mmu_page+0x259/0x2e0
> >    __handle_changed_spte+0x223/0x2c0
> >    handle_removed_tdp_mmu_page+0x1c1/0x2e0
> >    __handle_changed_spte+0x223/0x2c0
> >    handle_removed_tdp_mmu_page+0x1c1/0x2e0
> >    __handle_changed_spte+0x223/0x2c0
> >    zap_gfn_range+0x141/0x3b0
> >    kvm_tdp_mmu_zap_invalidated_roots+0xc8/0x130
> 
> This is a useful patch but I don't see the connection with this stall.
> The stall is detected in kvm_tdp_mmu_zap_invalidated_roots, which runs
> after kvm_zap_obsolete_pages. How would rescheduling during
> kvm_zap_obsolete_pages help?

Ah shoot, I copy+pasted the wrong splat.  The correct, revelant backtrace is:

   mark_page_accessed+0x266/0x2e0
   kvm_set_pfn_accessed+0x31/0x40
   mmu_spte_clear_track_bits+0x136/0x1c0
   drop_spte+0x1a/0xc0
   mmu_page_zap_pte+0xef/0x120
   __kvm_mmu_prepare_zap_page+0x205/0x5e0
   kvm_mmu_zap_all_fast+0xd7/0x190
   kvm_mmu_invalidate_zap_pages_in_memslot+0xe/0x10
   kvm_page_track_flush_slot+0x5c/0x80
   kvm_arch_flush_shadow_memslot+0xe/0x10
   kvm_set_memslot+0x1a8/0x5d0
   __kvm_set_memory_region+0x337/0x590
   kvm_vm_ioctl+0xb08/0x1040
