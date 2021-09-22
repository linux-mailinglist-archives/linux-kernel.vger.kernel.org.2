Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6BE4145B2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhIVKEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23619 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234309AbhIVKER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632304967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qb8DRYmAxRXlFdlb2jYQeeG3H/2W6Rld2Q8cOt11XZU=;
        b=MdY+iWCAZ/w27WObw6lm7KCoA2LVoaKUJznXA3nFKc2pELkpjurZMYM3PXZJl0wbpNfZQc
        eq0B+qH6H/n9gOrIOgBgVBu74smCmfhcJI/1xFYCpt1wWjucmYY9HLNZAVM1i2esBi4fmR
        cSGWulPMpcvwBnrJXcVfu0rU9DB7H64=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-qpQwGT1qM8uFYF3m3vL27g-1; Wed, 22 Sep 2021 06:02:46 -0400
X-MC-Unique: qpQwGT1qM8uFYF3m3vL27g-1
Received: by mail-ed1-f72.google.com with SMTP id h24-20020a50cdd8000000b003d8005fe2f8so2490206edj.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qb8DRYmAxRXlFdlb2jYQeeG3H/2W6Rld2Q8cOt11XZU=;
        b=d6qwB/8dyBpYeCzpBm/mAprZekvXuBTCN0NYi3rWhfgASOvMX9jVnk1naz+Y8h6fCK
         b5Z8eymmpRTpPRNbZhKNdpFWRj8THSrB/jT6QbrnwaDHDbEK0+vbv6LCexMq0OH0aPvO
         vRdx/d3WUinS7qStTvN7cTbsEYXpu6t7La6MbtCJJnyTtJVe0+N9KK85hgV9uzxBLVm5
         kJ0PKNSN0kaCmXngnIofsqZRockz+MOldQx8b5FeNK1GW1CrDukvKzxWkME6dRdasR9K
         ihZVpG7sgabtFdmnUsOcomc6Srv7yrhLwhRIYzJIOBXdk7JrNPXh2fLRMx2+WwQEZRcs
         gzPg==
X-Gm-Message-State: AOAM531ismiHGtWP07nmPkLoQvsWRxcc6Z94soBRhTkjv8gIQhY58dsi
        6mjgHGn8Z1qqsYHXpfI4XDgWLps0Ce7YG/jAt/jBFnNT5h2OysEVhgvmh09LE6sbU4U6SUnjtfR
        sq2jHx0qrbTrIIckn85GMkxSQ
X-Received: by 2002:a17:906:3fc8:: with SMTP id k8mr38612736ejj.217.1632304965364;
        Wed, 22 Sep 2021 03:02:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwe4x5M0xdDGG3Nj4Oi9PRMN0+2vvrg4Ke/sie9bJ7lVbvExB41cX+IyRQZGFMk7dfx+QFMag==
X-Received: by 2002:a17:906:3fc8:: with SMTP id k8mr38612711ejj.217.1632304965092;
        Wed, 22 Sep 2021 03:02:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id lb20sm799141ejc.40.2021.09.22.03.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 03:02:44 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Check if bus lock vmexit was preempted
To:     Hao Xiang <hao.xiang@linux.alibaba.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chenyi.qiang@intel.com,
        sean.j.christopherson@intel.com, shannon.zhao@linux.alibaba.com
References: <1631964600-73707-1-git-send-email-hao.xiang@linux.alibaba.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <87b411c3-da75-e074-91a4-a73891f9f5f8@redhat.com>
Date:   Wed, 22 Sep 2021 12:02:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1631964600-73707-1-git-send-email-hao.xiang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/21 13:30, Hao Xiang wrote:
> exit_reason.bus_lock_detected is not only set when bus lock VM exit
> was preempted, in fact, this bit is always set if bus locks are
> detected no matter what the exit_reason.basic is.
> 
> So the bus_lock_vmexit handling in vmx_handle_exit should be duplicated
> when exit_reason.basic is EXIT_REASON_BUS_LOCK(74). We can avoid it by
> checking if bus lock vmexit was preempted in vmx_handle_exit.

I don't understand, does this mean that bus_lock_detected=1 if 
basic=EXIT_REASON_BUS_LOCK?  If so, can we instead replace the contents 
of handle_bus_lock_vmexit with

	/* Do nothing and let vmx_handle_exit exit to userspace.  */
	WARN_ON(!to_vmx(vcpu)->exit_reason.bus_lock_detected);
	return 0;

?

That would be doable only if this is architectural behavior and not a 
processor erratum, of course.

Thanks,

Paolo

> Signed-off-by: Hao Xiang <hao.xiang@linux.alibaba.com>
> ---
>   arch/x86/kvm/vmx/vmx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 0c2c0d5..5ddf1df 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6054,7 +6054,8 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>   	 * still need to exit to user space when bus lock detected to inform
>   	 * that there is a bus lock in guest.
>   	 */
> -	if (to_vmx(vcpu)->exit_reason.bus_lock_detected) {
> +	if (to_vmx(vcpu)->exit_reason.bus_lock_detected &&
> +			to_vmx(vcpu)->exit_reason.basic != EXIT_REASON_BUS_LOCK) {
>   		if (ret > 0)
>   			vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
>   
> 

