Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076EC3D8DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbhG1MjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44999 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235020AbhG1MjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627475953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HXNFbdahmDX+c177h6RZhsPMzBfLmavkz0YVrNVerOg=;
        b=DRmhizL6a5EKsPfvgMcGNfT9uOH7W2keZodkFcMUYuuysE4k7QDS5gPVCpgPD5oTRzZP7r
        BOAOUpiujOMJ/sSDjNg2YAwBXS77kCQ7ncwhzUzbRmpzq9gzPu6Sg1TlvyN+Yiditt3S4P
        VAdAklpeLpcC2t5quKBKCRcLBs6/Wyc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-8j7bVl9qMPahmD3hGs2qtQ-1; Wed, 28 Jul 2021 08:39:10 -0400
X-MC-Unique: 8j7bVl9qMPahmD3hGs2qtQ-1
Received: by mail-ed1-f72.google.com with SMTP id c16-20020aa7d6100000b02903bc4c2a387bso1154811edr.21
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 05:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HXNFbdahmDX+c177h6RZhsPMzBfLmavkz0YVrNVerOg=;
        b=T4udOlMGzoz8UMdtK+ESoAfxy7wmxe9S0NDlMTAD+k0wFmR10s61BVr1Aiqos2OPj/
         FlIAIQpTk3rKFPTMaIVAg4XhmHHW3dbl7Aa3JwCOn6yxjtdTUsBOJw93M7XrEAuCXenK
         k90ZeXapyCS2pS0Ya83QJCdWTF7QWPvm0fnxlR2E6MQZW0D6MR4SgD+zyR61UhiUotwo
         85p2LgfGiOeOHYWKNGGUAEZi+8RPBzxyAxW8U9Ha9GaUoNehXnIEzb7+74ETEWwLTCY1
         siHuuYllhTGR90dM2NAP3+fiuptw34CripUuH5ZByFqvvigDqilvaIc10e3/b4EYSrGw
         e85g==
X-Gm-Message-State: AOAM533RE7O42WipZ6hcS8ARj5B/kvGBsuzG/fePBT7h6pLcFHbQJsKv
        xeHMWn9F3XF625feMJoW8FxcstwC7LO/Z5IxQ5U64WxPifkFisKqvh/AoKVaY+ZtzENcRuTT0Jr
        fsMn8MP7h3VM38rasyJnGBLqy
X-Received: by 2002:a17:906:a202:: with SMTP id r2mr26237799ejy.398.1627475949024;
        Wed, 28 Jul 2021 05:39:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzbqVneuxxswCi/3+V6VHw0Hz+FgePPtgokiB+Yl7UkLButBeC6ycb5jAkK2F0/tUIERx3kQ==
X-Received: by 2002:a17:906:a202:: with SMTP id r2mr26237779ejy.398.1627475948807;
        Wed, 28 Jul 2021 05:39:08 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t11sm1987292ejr.89.2021.07.28.05.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 05:39:08 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Exit to userspace when
 kvm_check_nested_events fails
In-Reply-To: <20210728115317.1930332-1-pbonzini@redhat.com>
References: <20210728115317.1930332-1-pbonzini@redhat.com>
Date:   Wed, 28 Jul 2021 14:39:07 +0200
Message-ID: <87o8am62ac.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> From: Jim Mattson <jmattson@google.com>
>
> If kvm_check_nested_events fails due to raising an
> EXIT_REASON_INTERNAL_ERROR, propagate it to userspace
> immediately, even if the vCPU would otherwise be sleeping.
> This happens for example when the posted interrupt descriptor
> points outside guest memory.
>
> Reported-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 348452bb16bc..916c976e99ab 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9752,10 +9752,14 @@ static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
>  	return 1;
>  }
>  
> -static inline bool kvm_vcpu_running(struct kvm_vcpu *vcpu)
> +static inline int kvm_vcpu_running(struct kvm_vcpu *vcpu)
>  {
> -	if (is_guest_mode(vcpu))
> -		kvm_check_nested_events(vcpu);
> +	int r;
> +	if (is_guest_mode(vcpu)) {
> +		r = kvm_check_nested_events(vcpu);
> +		if (r < 0 && r != -EBUSY)
> +			return r;
> +	}
>  
>  	return (vcpu->arch.mp_state == KVM_MP_STATE_RUNNABLE &&
>  		!vcpu->arch.apf.halted);
> @@ -9770,12 +9774,16 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
>  	vcpu->arch.l1tf_flush_l1d = true;
>  
>  	for (;;) {
> -		if (kvm_vcpu_running(vcpu)) {
> -			r = vcpu_enter_guest(vcpu);
> -		} else {
> -			r = vcpu_block(kvm, vcpu);
> +		r = kvm_vcpu_running(vcpu);
> +		if (r < 0) {
> +			r = 0;
> +			break;
>  		}
>  
> +		if (r)
> +			r = vcpu_enter_guest(vcpu);
> +		else
> +			r = vcpu_block(kvm, vcpu);
>  		if (r <= 0)
>  			break;

Shouldn't we also change kvm_arch_vcpu_runnable() and check
'kvm_vcpu_running() > 0' now?

-- 
Vitaly

