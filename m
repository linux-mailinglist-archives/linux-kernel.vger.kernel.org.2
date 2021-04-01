Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23ED43513AF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhDAKc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:32:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234119AbhDAKc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617273137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1eUiXnpnH6n4/oGTREYOSpo6rDfrAd7KXaTmdQGW+OU=;
        b=BCLmn9iGp7XYYXfgFZqqrDI4KoF7pWCi6dZbOu2vPm8mcK9Nzrse+W7Ec2qf4csdc9VJeH
        S8nbARbx9yA385f41JFkfteEq3Stm5xK9INEkoRgqFL5mRBlRl/38bVbh0SKWZoMU4Lwgp
        ZWXGNkr43b9XvzdqTWCYmdmCxU3SN3w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-U-G_GTQbNqWENZNvAlpImQ-1; Thu, 01 Apr 2021 06:32:16 -0400
X-MC-Unique: U-G_GTQbNqWENZNvAlpImQ-1
Received: by mail-ed1-f72.google.com with SMTP id i19so2625117edy.18
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 03:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1eUiXnpnH6n4/oGTREYOSpo6rDfrAd7KXaTmdQGW+OU=;
        b=D/l7hd320SpkzkX9cBEG0GucrbY1NHfK1q5PUtqcM8HcSVNcUKVtiLZ+IKVKhXbZgA
         Ez5t9/VJZg7Giy6FN9qVgv0pgOeyCma9Ocnq5xPo1is7UNvn5bMG2UXl2+k4DxxRqU56
         SKvWGjOTbq+QTQ1+Mq59PhP+nxWdcxLCa85rqbhSaG7WcEqSDzkWdCv6crXzhzO2Mnqt
         idfVdCJpFyYcnGfo4yvLvGpoSJl4kFDYyUfYJKou2UhkVTJggAGHafz1Sk8yqE+jrvQC
         02rLegq5357KRm5AZv5N0aQrKKK5pRDtqbd1vyoNXbJ/Kh0OrnrtCCOAgKY+ra2Ers8D
         TS+w==
X-Gm-Message-State: AOAM5309Qw3yvykTOyvwejVleifv1W7BkfHwlSavLCZDZorR3XInemQB
        o7O+qohRdtw9qYQLW9DZXKP/qz/O4Fmig/9Fhmcsn0RNX1XR2FuCTJzvcNOFeh17Rib+d6Xp+Oh
        A0+OJlqYw7FyatvQ1CbE9+gqP
X-Received: by 2002:a17:906:170f:: with SMTP id c15mr8251975eje.358.1617273135173;
        Thu, 01 Apr 2021 03:32:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxp7pLCchsEQe6GRgziondNEofsHQiuq/17gNPT5UApEqlYEhzeOqXUMZuIdD/PwJTrvx7Wlw==
X-Received: by 2002:a17:906:170f:: with SMTP id c15mr8251959eje.358.1617273134980;
        Thu, 01 Apr 2021 03:32:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y24sm3386648eds.23.2021.04.01.03.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 03:32:14 -0700 (PDT)
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210202185734.1680553-1-bgardon@google.com>
 <20210202185734.1680553-21-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 20/28] KVM: x86/mmu: Use atomic ops to set SPTEs in TDP
 MMU map
Message-ID: <f4fca4d7-8795-533e-d2d9-89a73e1a9004@redhat.com>
Date:   Thu, 1 Apr 2021 12:32:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202185734.1680553-21-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/21 19:57, Ben Gardon wrote:
> @@ -720,7 +790,8 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
>   		 */
>   		if (is_shadow_present_pte(iter.old_spte) &&
>   		    is_large_pte(iter.old_spte)) {
> -			tdp_mmu_set_spte(vcpu->kvm, &iter, 0);
> +			if (!tdp_mmu_set_spte_atomic(vcpu->kvm, &iter, 0))
> +				break;
>   
>   			kvm_flush_remote_tlbs_with_address(vcpu->kvm, iter.gfn,
>   					KVM_PAGES_PER_HPAGE(iter.level));
>
>  			/*
>  			 * The iter must explicitly re-read the spte here
>  			 * because the new value informs the !present
>                          * path below.
>                          */
>                         iter.old_spte = READ_ONCE(*rcu_dereference(iter.sptep));
>                 }
> 
>                 if (!is_shadow_present_pte(iter.old_spte)) {

Would it be easier to reason about this code by making it retry, like:

retry:
                 if (is_shadow_present_pte(iter.old_spte)) {
			if (is_large_pte(iter.old_spte)) {
	                        if (!tdp_mmu_zap_spte_atomic(vcpu->kvm, &iter))
	                                break;

				/*
				 * The iter must explicitly re-read the SPTE because
				 * the atomic cmpxchg failed.
				 */
	                        iter.old_spte = READ_ONCE(*rcu_dereference(iter.sptep));
				goto retry;
			}
                 } else {
			...
		}

?

Paolo

