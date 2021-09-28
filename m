Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E018E41B9F7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 00:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243059AbhI1WOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 18:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243047AbhI1WOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:14:35 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA0C061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 15:12:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id q23so202354pfs.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 15:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mlGjiTQKkKxj4KcXOOnDVYyCs2ZSFatBALPcwummKQM=;
        b=jNRMWegrFCxfd1N3NSKKno4QA4WsToa8zhOgjhCTO9pYDJCneH2oOgqg6dFx8DO9WF
         fwg1HEPb3KvCAeF3bRE0/7Ymnd8Dfky61i04gYYvZL7w8j6q8Y/ySOjvayDVBN4iOWxC
         +FGF2ioFURjwyLWgi9QR0Ok/CwEElNFeuVoB9sT6QJJNTKVvZ0sDmvGthThk9iVZyaDD
         F1ZENnMgH4SFf4Va3ys/kvLX4q8l6AVlrCj4ZEeSj63wNA0C7PdNfwD7gNXfs0xY8fuO
         bpPRJE2F3EWvgtBjP8eZIeX/TGj2enUv06ukSy0MfjiC+Vq77zG/0ySvIBOJhAHJ8ZTc
         80iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mlGjiTQKkKxj4KcXOOnDVYyCs2ZSFatBALPcwummKQM=;
        b=upfX5haWnqt5Mf3/VVTYMNvAbS/lKZD3Mob7+Uen4R4g/9wvAc2q6lbTLH7pk4aYP2
         psVI8UtktN5j72zpBRtFbsC2rVqRuzZcdVoJ9fGw6yG7HqZ7D0QjG+aZmH6dG+fXbd/g
         4Pf3UBlhHrPESzjj5NjqSbInew8vkgXR3rk+h+uhTwikU0ELY8DjJbYp5KgVV3I6PrJ0
         Eqy4izRNaLvmQuPPLJFKUjy5H2YLjhSoVDYcqq+mW0pd5WsYPJVaTZxnpj/PCLj1x7YE
         lRFxlvLIdmW5ni7TrooL6jMy5lG1aT1U3iAdKCYspbySMKY5liA6Z6PyBGNZm5OHH+Ba
         V71Q==
X-Gm-Message-State: AOAM532zGkPAm+boA6ToCtLvPGiW67FdIJUrDsOvcNXJikVz6mwuX/ck
        aE22huAWxgnSuHkJ3dxx7oX72A==
X-Google-Smtp-Source: ABdhPJwMJ6PXu1iYzvoK+xsmZtCnYCHuS4ke1upsonClun/Rtn4gUyNzkh7CQWduaPHweqPWa/7aGA==
X-Received: by 2002:aa7:83c4:0:b0:44b:bc59:1a46 with SMTP id j4-20020aa783c4000000b0044bbc591a46mr2781583pfn.77.1632867175070;
        Tue, 28 Sep 2021 15:12:55 -0700 (PDT)
Received: from google.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id q6sm104284pjd.26.2021.09.28.15.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 15:12:54 -0700 (PDT)
Date:   Tue, 28 Sep 2021 22:12:50 +0000
From:   David Matlack <dmatlack@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Zhang <jingzhangos@google.com>
Subject: Re: [PATCH 13/14] KVM: x86: Directly block (instead of "halting")
 UNINITIALIZED vCPUs
Message-ID: <YVOTYk9aSl72hCmX@google.com>
References: <20210925005528.1145584-1-seanjc@google.com>
 <20210925005528.1145584-14-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925005528.1145584-14-seanjc@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 05:55:27PM -0700, Sean Christopherson wrote:
> Go directly to kvm_vcpu_block() when handling the case where userspace
> attempts to run an UNINITIALIZED vCPU.  The vCPU isn't halted and its time
> spent in limbo arguably should not be factored into halt-polling as the
> behavior of the VM at this point is not at all indicative of the behavior
> of the VM once it is up and running, i.e. executing HLT in idle tasks.
> 
> Note, because this case is encountered only on the first run of an AP vCPU,
> vcpu->halt_poll_ns is guaranteed to be '0', and so KVM will not attempt
> halt-polling, i.e. this really only affects the post-block bookkeeping.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
>  arch/x86/kvm/x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0d71c73a61bb..b444f9315766 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10127,7 +10127,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  			r = -EINTR;
>  			goto out;
>  		}
> -		kvm_vcpu_halt(vcpu);
> +		kvm_vcpu_block(vcpu);
>  		if (kvm_apic_accept_events(vcpu) < 0) {
>  			r = 0;
>  			goto out;
> -- 
> 2.33.0.685.g46640cef36-goog
> 
