Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F02F413949
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhIUR4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:56:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53773 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231944AbhIUR4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632246878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Q2MHEXLXim+/y032QTQuhLFxwAxHerebm3zs86tuZU=;
        b=CPZMWwVBzSwunJpdTEIruBLZVIRes0CMo+EBD7tCk3y3SFvfV00RGzr4IuCY8kiVrviEh9
        JKQq0pb1m3bMq9oAV5Gq1+zZOJYD4WDZXOdYxJvO1DtFA9hP9KMPoRr7+/Hyvv32ApekDo
        8/PZwLreNnptepgWF0kSzGKpZg0ngtA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-6qt6HZDcMJCiIbx1HaTcpw-1; Tue, 21 Sep 2021 13:54:37 -0400
X-MC-Unique: 6qt6HZDcMJCiIbx1HaTcpw-1
Received: by mail-ed1-f71.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so19834923edy.14
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1Q2MHEXLXim+/y032QTQuhLFxwAxHerebm3zs86tuZU=;
        b=Ugvpwu/BefkAAV1UDgUdaLAesivxq/6J3lC14rxkfKjwXdgj2IMDY2BfDgxCvf+AfO
         1GiVu/aCwO6Q6YCDkc2xWsdr4chnfhwc0JCU0C59DrUN6OPteZZItvaKiJg3Bkx906xL
         XjBQDEjnqDxj8M5udHiUYwGQOsex2IGD+VIqjqPaP563AiQ8l2WJ6sZRcTHrg9HXfT0X
         FfwaRzdh/Yr5b3+h7jPI0j2v+N7gQ6A+425FGcmk71K0CcgpI1Voq2kP9yS9OY5Eo7GD
         XfvPkPySt0YEaihyeGlYHiS1b+AGDkJgofhFb36gq5a+cXeo9OjliakNk7vzidtJQNaX
         4yrw==
X-Gm-Message-State: AOAM530TyrvtPg2YvLdmAVTIuqHxCJ6fOGOmNd9fQGCQD45LrHmJgJDE
        LFM6s+WxUK+M1RrZcJFOazAQboF4XgcN4c9mNUgMO7kCLn6oJrMqOUnxJEd+1+SDImSsJj3P0fb
        MLRpN4+0wK31Tz1NzfS63UMMEIphIpgSM4u7K8V4yyeHe37bzPALv/HqmyPr3/lDMmeKBL5R38l
        4a
X-Received: by 2002:a17:906:fc09:: with SMTP id ov9mr36344909ejb.128.1632246875479;
        Tue, 21 Sep 2021 10:54:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXK/mL83pYtX0BzGMb+1ADVxehMaWKTjXAZ/aKuq5m8OXlXbQkmZvV+/7fOBolEtPtEiTNBA==
X-Received: by 2002:a17:906:fc09:: with SMTP id ov9mr36344874ejb.128.1632246875238;
        Tue, 21 Sep 2021 10:54:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u4sm7792965ejc.19.2021.09.21.10.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 10:54:34 -0700 (PDT)
Subject: Re: [PATCH V2] KVM: SEV: Acquire vcpu mutex when updating VMSA
To:     Peter Gonda <pgonda@google.com>, kvm@vger.kernel.org
Cc:     Marc Orr <marcorr@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210915171755.3773766-1-pgonda@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ec40f2bc-6f36-bac4-27ba-ba38720db807@redhat.com>
Date:   Tue, 21 Sep 2021 19:54:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210915171755.3773766-1-pgonda@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/21 19:17, Peter Gonda wrote:
> Adds vcpu mutex guard to the VMSA updating code. Refactors out
> __sev_launch_update_vmsa() function to deal with per vCPU parts
> of sev_launch_update_vmsa().
> 
> Fixes: ad73109ae7ec ("KVM: SVM: Provide support to launch and run an SEV-ES guest")
> 
> Signed-off-by: Peter Gonda <pgonda@google.com>
> Cc: Marc Orr <marcorr@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: kvm@vger.kernel.org
> Cc: stable@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> 
> V2
>   * Refactor per vcpu work to separate function.
>   * Remove check to skip already initialized VMSAs.
>   * Removed vmsa struct zeroing.
> 
> ---
>   arch/x86/kvm/svm/sev.c | 53 ++++++++++++++++++++++++------------------
>   1 file changed, 30 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 75e0b21ad07c..766510fe3abb 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -595,43 +595,50 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
>   	return 0;
>   }
>   
> -static int sev_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
> +static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
> +				    int *error)
>   {
> -	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
>   	struct sev_data_launch_update_vmsa vmsa;
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	int ret;
> +
> +	/* Perform some pre-encryption checks against the VMSA */
> +	ret = sev_es_sync_vmsa(svm);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The LAUNCH_UPDATE_VMSA command will perform in-place encryption of
> +	 * the VMSA memory content (i.e it will write the same memory region
> +	 * with the guest's key), so invalidate it first.
> +	 */
> +	clflush_cache_range(svm->vmsa, PAGE_SIZE);
> +
> +	vmsa.reserved = 0;
> +	vmsa.handle = to_kvm_svm(kvm)->sev_info.handle;
> +	vmsa.address = __sme_pa(svm->vmsa);
> +	vmsa.len = PAGE_SIZE;
> +	return sev_issue_cmd(kvm, SEV_CMD_LAUNCH_UPDATE_VMSA, &vmsa, error);
> +}
> +
> +static int sev_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
> +{
>   	struct kvm_vcpu *vcpu;
>   	int i, ret;
>   
>   	if (!sev_es_guest(kvm))
>   		return -ENOTTY;
>   
> -	vmsa.reserved = 0;
> -
> -	kvm_for_each_vcpu(i, vcpu, kvm) {
> -		struct vcpu_svm *svm = to_svm(vcpu);
> -
> -		/* Perform some pre-encryption checks against the VMSA */
> -		ret = sev_es_sync_vmsa(svm);
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		ret = mutex_lock_killable(&vcpu->mutex);
>   		if (ret)
>   			return ret;
>   
> -		/*
> -		 * The LAUNCH_UPDATE_VMSA command will perform in-place
> -		 * encryption of the VMSA memory content (i.e it will write
> -		 * the same memory region with the guest's key), so invalidate
> -		 * it first.
> -		 */
> -		clflush_cache_range(svm->vmsa, PAGE_SIZE);
> +		ret = __sev_launch_update_vmsa(kvm, vcpu, &argp->error);
>   
> -		vmsa.handle = sev->handle;
> -		vmsa.address = __sme_pa(svm->vmsa);
> -		vmsa.len = PAGE_SIZE;
> -		ret = sev_issue_cmd(kvm, SEV_CMD_LAUNCH_UPDATE_VMSA, &vmsa,
> -				    &argp->error);
> +		mutex_unlock(&vcpu->mutex);
>   		if (ret)
>   			return ret;
> -
> -		svm->vcpu.arch.guest_state_protected = true;
>   	}
>   
>   	return 0;
> 

Queued, thanks.

Paolo

