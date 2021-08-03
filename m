Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3C83DF123
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbhHCPLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbhHCPLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:11:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFE6C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 08:11:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u16so15562786ple.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NuJ2xEEWKF1Vla0gUGurVlQWkveVpljRc+Zu/G7Vi0c=;
        b=ieusyNcocip4+sLNejScJnPuqQlILCsYclqRn5zVJl6UmkQJQBtW0nlvO7PeSaEOzK
         aRaUaM05kbbmI7SZAToygSXbbBc7j01WHfkuL1VmYG8ZsaMKoMN6NZoSWv6wk5m1DJVf
         +JYw72yduJQx2LiEhHAEwLeB1bX5Jn8+pz9tnIAI55Zv7fNWMUluj0Ap5CmG43kXFU2q
         8GKUil5wcLltM3u1f1a/UtK3MwqswA/zQLxOFBs4VOxGEgJruRBR1p/usUEk5BsVUuQY
         aUpDpWFRZrRGRSW/p0Gwo5tQLppapoGyb+PC5nPFP9zEi/52vl0KRgOw2h5aUWuKPXmM
         peLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NuJ2xEEWKF1Vla0gUGurVlQWkveVpljRc+Zu/G7Vi0c=;
        b=kct205xSqS1Nw8VxobpS/pxJZd4vyiP4JNqhoUyf4slzePwxP35osmuyZnDtuD52jC
         UOWcN0EziY5A5PlCbFA0qiPRxwoTas76dBSfZdScTSuvGJGoz7lUk+JvgwPs7G3tIIfz
         Ats4attosKlEJ2hhboFipRCMvsn+EMESzKRyUh13acBPvVKAmE5WeeR9Ku+PoEldz6cE
         QaHgGF1J1BBJgZ3mk60xi7Szb7bAxoW5zBB086P1OkJbqDrxmnb4glJB6Nru0EJCgNTu
         K/gDxg+heOmkeWYzTGWR37eGXKdUq9a7GlOtfpEM/z6pnUyEDj1+AkB9soEFATygxKZV
         rTuQ==
X-Gm-Message-State: AOAM530wYqKCwl6htFeyYb3WvFfZVTj3R2tNpuNU9gSOC6LL7QgahiqF
        Ub6yh5UVK1rhgKzWAnQ3+FafGQ==
X-Google-Smtp-Source: ABdhPJxZlvIJf4rIZsrmOu4Rg+gEaKhU1VM79P45ri1rV8HqdszOC3a8i8R7/2/lEEyL1ULF5tV50g==
X-Received: by 2002:a65:6a4d:: with SMTP id o13mr583344pgu.361.1628003467627;
        Tue, 03 Aug 2021 08:11:07 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p8sm6767304pfw.35.2021.08.03.08.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:11:07 -0700 (PDT)
Date:   Tue, 3 Aug 2021 15:11:03 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Jim Mattson <jmattson@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 01/12] Revert "KVM: x86/mmu: Allow zap gfn range to
 operate under the mmu read lock"
Message-ID: <YQlch2fVEfDnz8aX@google.com>
References: <20210802183329.2309921-1-mlevitsk@redhat.com>
 <20210802183329.2309921-2-mlevitsk@redhat.com>
 <14a0d715-d059-3a85-a803-63d9b0fb790f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14a0d715-d059-3a85-a803-63d9b0fb790f@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021, Paolo Bonzini wrote:
> On 02/08/21 20:33, Maxim Levitsky wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > 
> > This together with the next patch will fix a future race between
> > kvm_zap_gfn_range and the page fault handler, which will happen
> > when AVIC memslot is going to be only partially disabled.
> > 
> > This is based on a patch suggested by Sean Christopherson:
> > https://lkml.org/lkml/2021/7/22/1025
> 
> I'll also add a small note from the original message:
> 
>     The performance impact is minimal since kvm_zap_gfn_range is only called by
>     users, update_mtrr() and kvm_post_set_cr0().  Both only use it if the guest
>     has non-coherent DMA, in order to honor the guest's UC memtype.  MTRR and CD
>     setup only happens at boot, and generally in an area where the page tables
>     should be small (for CD) or should not include the affected GFNs at all
>     (for MTRRs).
> 
> On top of this, I think the CD case (kvm_post_set_cr0) can be changed to use
> kvm_mmu_zap_all_fast.

No, because fast zap requires kvm->slots_lock be held.  That could be relaxed by
reverting ca333add6933 ("KVM: x86/mmu: Explicitly track only a single invalid mmu
generation") and converting mmu_valid_gen to a u64 (to prevent wrap on 32-bit KVM).
IMO the extra memory cost, even though it's meager savings when using TDP without
nested, isn't worth relaxing the rules for fast zap.  Non-coherent DMA isn't very
common these days, and toggling CR0.CD is a rare guest operation (it'd probably
never happen if the darn architcture didn't set it on RESET).
