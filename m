Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAAC3E0F45
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 09:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbhHEHeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 03:34:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238682AbhHEHeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 03:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628148835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1X4atkIAaKHKvFaPgSQTrOWjpkdnsM1vBayaGygXCVA=;
        b=eU2iQoRAVQr9qpkoTBrFwvE80Bktz2EypQGmcT6zXHQTEJCR7Za5TOnp9/Ww4VCE88SumB
        Bthq6bkhAl2mchLGrLRXdicSGkucChplxjNlBxfU5w3sGHx6XZkGMOWekQfJuL6iFOt3b0
        ZXbkRtpDeACwxO1cdCFSjzKXMGVVVvo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-dOJXak3kMd6SXhu3c3Is2w-1; Thu, 05 Aug 2021 03:33:53 -0400
X-MC-Unique: dOJXak3kMd6SXhu3c3Is2w-1
Received: by mail-ed1-f71.google.com with SMTP id s10-20020a05640217cab02903bddc3e8fb3so2559069edy.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 00:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1X4atkIAaKHKvFaPgSQTrOWjpkdnsM1vBayaGygXCVA=;
        b=iHGfuRPz3E5V0ePk6u+YGpDubIjayumI22ihgHcUzyDIQphyqeq6l/jiWbzP8d9Pgp
         +dew2ga8sYVY/fOCZTwwcvCbYJtdrTZHKq9hrnRLeueR2cya4CSjFxZza+Dz+3ONpRMt
         nGwNlbpDLZk3U15fcexr2rdM4o4xKJ9dQGH2jGsmNwAyD6CQkEKXUEhV2aEQ2CvZaMmL
         5AAaBCTjV86wrj6xfuuQnDJ/deXDFxrewc2asO4nwFlhXYy3nLwDXfYrkuORKWj3Vh+n
         34lnOcO/8F80UFDteDPGbt0lX2AWbcnOeDNKymjBJaPdHY5bvg6pYFV5zEuDgqyckNIh
         vevA==
X-Gm-Message-State: AOAM533aV9JuroERUo1yv2NJN3lFVbZhRf5YIVmqCK+2nGMfe2wtZQ2M
        5U0Mj7oF1jj0rpOGn1yA9XJh8wbbVjaNvXd9E9du9RxyRCYFoiwHv+lwYeQ9yGh5KUMsZosy/VR
        9pbEO+7BDCT3Hs6wh6NONY8zX
X-Received: by 2002:a17:906:acf:: with SMTP id z15mr3478778ejf.512.1628148832682;
        Thu, 05 Aug 2021 00:33:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznKB1r0CMePbBY5Fa8xL01mLW4gcnEfvw2D+pstCkRlMae0hElKTucF/c2Ck/KkB9T2KxNBA==
X-Received: by 2002:a17:906:acf:: with SMTP id z15mr3478763ejf.512.1628148832502;
        Thu, 05 Aug 2021 00:33:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id nb39sm1385122ejc.95.2021.08.05.00.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:33:52 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/mmu: Fix per-cpu counter corruption on 32-bit
 builds
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
References: <20210804214609.1096003-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9527197a-2a81-832b-7391-80d646a5e212@redhat.com>
Date:   Thu, 5 Aug 2021 09:33:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804214609.1096003-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/21 23:46, Sean Christopherson wrote:
> Take a signed 'long' instead of an 'unsigned long' for the number of
> pages to add/subtract to the total number of pages used by the MMU.  This
> fixes a zero-extension bug on 32-bit kernels that effectively corrupts
> the per-cpu counter used by the shrinker.
> 
> Per-cpu counters take a signed 64-bit value on both 32-bit and 64-bit
> kernels, whereas kvm_mod_used_mmu_pages() takes an unsigned long and thus
> an unsigned 32-bit value on 32-bit kernels.  As a result, the value used
> to adjust the per-cpu counter is zero-extended (unsigned -> signed), not
> sign-extended (signed -> signed), and so KVM's intended -1 gets morphed to
> 4294967295 and effectively corrupts the counter.
> 
> This was found by a staggering amount of sheer dumb luck when running
> kvm-unit-tests on a 32-bit KVM build.  The shrinker just happened to kick
> in while running tests and do_shrink_slab() logged an error about trying
> to free a negative number of objects.  The truly lucky part is that the
> kernel just happened to be a slightly stale build, as the shrinker no
> longer yells about negative objects as of commit 18bb473e5031 ("mm:
> vmscan: shrink deferred objects proportional to priority").
> 
>   vmscan: shrink_slab: mmu_shrink_scan+0x0/0x210 [kvm] negative objects to delete nr=-858993460
> 
> Fixes: bc8a3d8925a8 ("kvm: mmu: Fix overflow on kvm mmu page limit calculation")
> Cc: stable@vger.kernel.org
> Cc: Ben Gardon <bgardon@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/mmu/mmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index b4b65c21b2ca..082a0ba79edd 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1700,7 +1700,7 @@ static int is_empty_shadow_page(u64 *spt)
>    * aggregate version in order to make the slab shrinker
>    * faster
>    */
> -static inline void kvm_mod_used_mmu_pages(struct kvm *kvm, unsigned long nr)
> +static inline void kvm_mod_used_mmu_pages(struct kvm *kvm, long nr)
>   {
>   	kvm->arch.n_used_mmu_pages += nr;
>   	percpu_counter_add(&kvm_total_used_mmu_pages, nr);
> 

Queued, thanks.

Paolo

