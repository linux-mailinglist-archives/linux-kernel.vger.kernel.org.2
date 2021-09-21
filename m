Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667784134DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhIUNyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233160AbhIUNyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632232353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V0zAq0x+oqzBpgunFTqnsA/mjDvVGVJTfSNQG5aaHl4=;
        b=Y2wbzX+xXlAZPDs9yIQMb77vXlV2yau+gHsQKyP9rMcQ4Qc7eeLFUdcrS0k0r3ZWX8VMq4
        zuFuAa4BKdZBKc3kXv4ODhbB9qRk9cLUow6GM4D7/uePRojQxVSGpwaqMwip+cpiijJHMu
        BYuFNkCis+TCyGlX83xCIFm3KqcgWx4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-fEOCiu4aM3-1nOf9uI1Rvw-1; Tue, 21 Sep 2021 09:52:32 -0400
X-MC-Unique: fEOCiu4aM3-1nOf9uI1Rvw-1
Received: by mail-wr1-f72.google.com with SMTP id h5-20020a5d6885000000b0015e21e37523so8870737wru.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 06:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=V0zAq0x+oqzBpgunFTqnsA/mjDvVGVJTfSNQG5aaHl4=;
        b=l8m8Cg3RZf47LS1zWQgsJ8MYOMUClHYjFWk0xwjJCNeq2y5fpXKn9PXyAZPQXMARZh
         UXO/qrZNEfffEfpGzwp4Dv7xD2pcFkWZhxnpSTb2MeXMmqP4XPyzP/hP3Kzv/8TyAH0w
         0OtaptldrM0gxckozHZ1y72dvFEBXTzhl0UBQOrisouatQAbZ16VkXk4wGXd63IvBei3
         5tbvjS137o0XoUyMhIfjBh7Uk7MXdn/gjC6znnTQUddj00JsJkq6Xbzk8PzH2DnnzB2Y
         N6EQpkTqweRGQ/pfVDhqf0ApjPl8tBTQ80qjM+XfIBFhIiHGzDm9M60rQjMzvh0q0o6U
         pU8A==
X-Gm-Message-State: AOAM53104BpbpuF4KoJGuwXBVKTOgd5dVx9N9T3SZtqhQSuybrXJGVvl
        EtIhIfSz4o9LkiLCWhvhPON4J/MfbBZRUWtWaDTKPtiFqMboe1HngYR2B5mJ3IATWqmvhlJ1Cd0
        lJUxVBpUfT5JwgwDJYuvP+f4N
X-Received: by 2002:a5d:64ab:: with SMTP id m11mr32878899wrp.343.1632232351223;
        Tue, 21 Sep 2021 06:52:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqNngkbqDMiHzQQklz3eCjHb4+L2IXwXQtwQ4UV/2L86vZDwomrKKd2RNX5DwoTklZM8hAcw==
X-Received: by 2002:a5d:64ab:: with SMTP id m11mr32878879wrp.343.1632232351058;
        Tue, 21 Sep 2021 06:52:31 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id g25sm3701252wrc.88.2021.09.21.06.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:52:30 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH v2 02/10] KVM: x86: Clear KVM's cached guest CR3 at
 RESET/INIT
In-Reply-To: <20210921000303.400537-3-seanjc@google.com>
References: <20210921000303.400537-1-seanjc@google.com>
 <20210921000303.400537-3-seanjc@google.com>
Date:   Tue, 21 Sep 2021 15:52:29 +0200
Message-ID: <878rzq9gte.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Explicitly zero the guest's CR3 and mark it available+dirty at RESET/INIT.
> Per Intel's SDM and AMD's APM, CR3 is zeroed at both RESET and INIT.  For
> RESET, this is a nop as vcpu is zero-allocated.  For INIT, the bug has
> likely escaped notice because no firmware/kernel puts its page tables root
> at PA=0, let alone relies on INIT to get the desired CR3 for such page
> tables.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/x86.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e77a5bf2d940..2cb38c67ed43 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10899,6 +10899,9 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
>  	kvm_rip_write(vcpu, 0xfff0);
>  
> +	vcpu->arch.cr3 = 0;
> +	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);

kvm_register_mark_dirty() is redundant here as PATCH1 does

      vcpu->arch.regs_avail = ~0;
      vcpu->arch.regs_dirty = ~0;

just a few lines above. The dependency is, however, implicit and this
patch is marked for stable@ (well, PATCH1 has 8 Fixes: tags so I'd
expect it to get picked by everyone too, especially by robots) and
flipping two bits is cheap.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

> +
>  	/*
>  	 * CR0.CD/NW are set on RESET, preserved on INIT.  Note, some versions
>  	 * of Intel's SDM list CD/NW as being set on INIT, but they contradict

-- 
Vitaly

