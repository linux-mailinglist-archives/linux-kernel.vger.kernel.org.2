Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59353BD93B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhGFO7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232356AbhGFO7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625583425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ajXTV150imp5i5LHBYKTJZiAWY9kq7YZNMi3S09CEc=;
        b=bPDIjuA+s1AiM50Pj1NCIbVhrRTV6Qk2ABsjqntxLVxzwqGazY6A+K7gWzCCVPFCpjybxo
        1SQyibuDAV3F1xwIBA/kRSOzqCTprPcsjyIE9aMKg2fRGnbW32/HPvVggf5OOrNsi7gL+M
        JFzSWam+IuMN145Dh1nvk/Bb35ArWvo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-cJhb3zr-OLq3tN0N7zPLxg-1; Tue, 06 Jul 2021 10:57:04 -0400
X-MC-Unique: cJhb3zr-OLq3tN0N7zPLxg-1
Received: by mail-ed1-f72.google.com with SMTP id m15-20020a056402430fb0290399da445c17so3070639edc.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 07:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ajXTV150imp5i5LHBYKTJZiAWY9kq7YZNMi3S09CEc=;
        b=B/ye+oQGn9tky77B/azRc3KxKuTqbog+D8GrzsVAV9TtynptuDS8w3Fq9GD8yG0Iet
         mugViQprfYDelE+bhy9eZvOXmEoTyTWlY5LTgMunK5wGoK0Zd9i9/bkqYQnxl1x45kuU
         Q3yOGpgj9oisYhSXrhmBgTHuYCHT01ofBV8nu3kgmm4xP29r1h4RLaUEpxpvAC+tpFIQ
         MwSEvdXSag/JmscEBgWQ3CXWoG1oBd1cxNTd9Z97gQIigpfdNe3BfC/Z2bcpU/Hz/fwa
         KyqGv195HLf8w52N+ljq7zHvQELrlKzcHI+VjhZw+39kD64FKTyp9SOIswyyTh5GNxiz
         YUKw==
X-Gm-Message-State: AOAM531YmAbbqMOTeVgHsDd3Pll1PoQttJB7X7OaC5MRcpm+EIHTj2sm
        tXiBQIIaebRA6/Jhen2PU1B8BNJ/uP/ANUVdiF0rftuHqVfKcOoh//5Xu8FMHdDO3eE8mmOTD1U
        m++mxd1M70qp7x8TPOSbCphai
X-Received: by 2002:a17:906:a20b:: with SMTP id r11mr19060881ejy.221.1625583423479;
        Tue, 06 Jul 2021 07:57:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyl9/fA/olglusnGZGiD3rJjGLlUSaaVEshCNmI4RzJe3uvRHHhn4YU+Yo/ba5lt6Hy/ncYtQ==
X-Received: by 2002:a17:906:a20b:: with SMTP id r11mr19060862ejy.221.1625583423322;
        Tue, 06 Jul 2021 07:57:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i18sm7610877edc.7.2021.07.06.07.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 07:56:58 -0700 (PDT)
Subject: Re: [RFC PATCH v2 45/69] KVM: x86/mmu: Return old SPTE from
 mmu_spte_clear_track_bits()
To:     isaku.yamahata@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     isaku.yamahata@gmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <b16bac1fd1357aaf39e425aab2177d3f89ee8318.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3ca5f199-3fd8-34b0-14e4-2d9259b6fb6e@redhat.com>
Date:   Tue, 6 Jul 2021 16:56:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b16bac1fd1357aaf39e425aab2177d3f89ee8318.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:04, isaku.yamahata@intel.com wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Return the old SPTE when clearing a SPTE and push the "old SPTE present"
> check to the caller.  Private shadow page support will use the old SPTE
> in rmap_remove() to determine whether or not there is a linked private
> shadow page.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/kvm/mmu/mmu.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 0259781cee6a..6b0c8c84aabe 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -542,9 +542,9 @@ static bool mmu_spte_update(u64 *sptep, u64 new_spte)
>    * Rules for using mmu_spte_clear_track_bits:
>    * It sets the sptep from present to nonpresent, and track the
>    * state bits, it is used to clear the last level sptep.
> - * Returns non-zero if the PTE was previously valid.
> + * Returns the old PTE.
>    */
> -static int mmu_spte_clear_track_bits(u64 *sptep)
> +static u64 mmu_spte_clear_track_bits(u64 *sptep)
>   {
>   	kvm_pfn_t pfn;
>   	u64 old_spte = *sptep;
> @@ -555,7 +555,7 @@ static int mmu_spte_clear_track_bits(u64 *sptep)
>   		old_spte = __update_clear_spte_slow(sptep, shadow_init_value);
>   
>   	if (!is_shadow_present_pte(old_spte))
> -		return 0;
> +		return old_spte;
>   
>   	pfn = spte_to_pfn(old_spte);
>   
> @@ -572,7 +572,7 @@ static int mmu_spte_clear_track_bits(u64 *sptep)
>   	if (is_dirty_spte(old_spte))
>   		kvm_set_pfn_dirty(pfn);
>   
> -	return 1;
> +	return old_spte;
>   }
>   
>   /*
> @@ -1104,7 +1104,9 @@ static u64 *rmap_get_next(struct rmap_iterator *iter)
>   
>   static void drop_spte(struct kvm *kvm, u64 *sptep)
>   {
> -	if (mmu_spte_clear_track_bits(sptep))
> +	u64 old_spte = mmu_spte_clear_track_bits(sptep);
> +
> +	if (is_shadow_present_pte(old_spte))
>   		rmap_remove(kvm, sptep);
>   }
>   
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

