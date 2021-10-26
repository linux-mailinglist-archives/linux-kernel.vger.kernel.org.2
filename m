Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E74643B6F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237724AbhJZQUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:20:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43847 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237317AbhJZQT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635265023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HrGP2hx/5gqG8KTbScu3FM5mqdfWvd8zWiCw/D9kcnY=;
        b=Pd5YrAYpkwa/tw+562IPdlNBXS64oZMRqcgA8HzFFAHU957yht3MQfPJCQxQ22H0YTEi/o
        kArq+BJzWwWoj32Tf5fqHC+8pnaynFubg5YSXOr70HxuaQfbqJoU+Yn9usCgM1mBJjX3Kn
        TeCODiQ4/IQDjg95GdGNjEta+oWacic=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-ziy_cNYoP6ifkh4jS3Y73g-1; Tue, 26 Oct 2021 12:17:02 -0400
X-MC-Unique: ziy_cNYoP6ifkh4jS3Y73g-1
Received: by mail-ed1-f72.google.com with SMTP id g6-20020a056402424600b003dd2b85563bso10838770edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HrGP2hx/5gqG8KTbScu3FM5mqdfWvd8zWiCw/D9kcnY=;
        b=v3K1xY2h/Zv907qHtkL7xWDchlracl26WYX0pTDgSWqMvcCwEr1Lr8h//hGM8YzgKM
         dOWNU0C8evNnIGYywqHSh7ErdWKLSrAT1J3CNPaA14rVUFkPG39CURvY0S0NTnzKVHAY
         8bp1+yMmBTnSXG1WGXSHRQ5q3QwnC+DShjtl9ARBfz2BwlZfzSvoStLsMg/blDt9lRoU
         0yDjpDSmacy21hNL+DVcOWNz4xFWKGrek3SIrYtekxOEoeggAN/jGJWXm+g6bg5x+u7r
         9bkBpobA1Q6Wdv6DUTWgP4aDHs9pdqP5bIUwsWCTBKZe1vhpMqKojtdzHYs18mmxKtNz
         LKIg==
X-Gm-Message-State: AOAM533p5Z6NchDay4K/+hC3ekqGuKZSFc8KpJpxwtNuCyFkC60A47DA
        okLnhWw1BGQbseD9gj2g8AT7Y08b15a9JnKFGGb+NkIraMpD4r21W9NvqVxAlxUITl3QMs1QARN
        ElhOdcyGirZusEAg2Zgp9oeOz
X-Received: by 2002:a17:906:ca18:: with SMTP id jt24mr31355810ejb.325.1635265020751;
        Tue, 26 Oct 2021 09:17:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCAgaJ1nXM1ocpSePMgU4hrCoy1y+RLuGZFU21qMLu8XFQGQoffuE7NXc4djJHfV0Ccx8NlQ==
X-Received: by 2002:a17:906:ca18:: with SMTP id jt24mr31355787ejb.325.1635265020563;
        Tue, 26 Oct 2021 09:17:00 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x6sm468027eds.83.2021.10.26.09.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 09:17:00 -0700 (PDT)
Message-ID: <dabdf154-eba2-f453-1597-fa84d464a106@redhat.com>
Date:   Tue, 26 Oct 2021 18:16:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH MANUALSEL 5.14 4/5] KVM: SEV-ES: Set guest_state_protected
 after VMSA update
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20211025203828.1404503-1-sashal@kernel.org>
 <20211025203828.1404503-4-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211025203828.1404503-4-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/21 22:38, Sasha Levin wrote:
> From: Peter Gonda <pgonda@google.com>
> 
> [ Upstream commit baa1e5ca172ce7bf9554070139482dd7ea919528 ]
> 
> The refactoring in commit bb18a6777465 ("KVM: SEV: Acquire
> vcpu mutex when updating VMSA") left behind the assignment to
> svm->vcpu.arch.guest_state_protected; add it back.
> 
> Signed-off-by: Peter Gonda <pgonda@google.com>
> [Delta between v2 and v3 of Peter's patch, which had already been
>   committed; the commit message is my own. - Paolo]
> Fixes: bb18a6777465 ("KVM: SEV: Acquire vcpu mutex when updating VMSA")
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kvm/svm/sev.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index cb166bde449b..50dabccd664e 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -619,7 +619,12 @@ static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
>   	vmsa.handle = to_kvm_svm(kvm)->sev_info.handle;
>   	vmsa.address = __sme_pa(svm->vmsa);
>   	vmsa.len = PAGE_SIZE;
> -	return sev_issue_cmd(kvm, SEV_CMD_LAUNCH_UPDATE_VMSA, &vmsa, error);
> +	ret = sev_issue_cmd(kvm, SEV_CMD_LAUNCH_UPDATE_VMSA, &vmsa, error);
> +	if (ret)
> +	  return ret;
> +
> +	vcpu->arch.guest_state_protected = true;
> +	return 0;
>   }
>   
>   static int sev_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

I missed that bb18a677746543e7f5eeb478129c92cedb0f9658 was Cc'd to 
stable.  Good bot. :)

Paolo

