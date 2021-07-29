Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1863DAED4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhG2W1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbhG2W1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:27:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2287DC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 15:27:34 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i10so8700664pla.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 15:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U7V9Ap3CLbBdQCnG02pu0xdSqMhicUYByn9SxkAU8rw=;
        b=Ffk8XpysnuqjpLBT6TZqn4W5/OEbtQF8oVqJwVgwx/tfDyKtg04s3+tvbENJTzrV5J
         4NJrhbizq83pOW9DriO0IT1D4PRHNil84BWsETrNpx1o81V0zVMAYWrhvFiYbCRUk2MD
         zG5yXj3ZhDiLFDAKQK4BizaWGfbivzK8Ia7+s06Ffs9L6mTHg6b2P3eFLnVlrfwT7WPO
         zByAMI0AQb70/64I2++woOOagf26a1zTqhRimG2LA8iijcdW37HJhjl3r+9q2qJIk7SM
         e9i3dvi3rB1sEJuHMPEhTCJ5YGvU3pkRsprjZZm28ZHEaP82OdR6kEcxqbW5GzfTj/Ng
         aG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U7V9Ap3CLbBdQCnG02pu0xdSqMhicUYByn9SxkAU8rw=;
        b=X4AFBKA1NjJz1IK3o86D5CdOsUCjswe+okUGNaXo6U4LZVXCkeiLtwaxRNCkn/MngG
         S9+1WP9M49xryBzSj1r0c3bK6eLkRpc8gXaMk0beUssciyV7XdU6/fGRJybpT+cdKaz6
         dImgDd0nO5E1iDCQcZWWKNiu/TCfDum3J3BlIkNqmf7KbaHYiHknbupmPLQsm4C+HdEG
         IVv/3dyYZxphTVRf0BuSia7SVpCnkL2VlPhzm3ICjUQLd5eBBSvrD5FoZcJIeyRDPIvz
         aG88T/5qDlROsbhST0JjVVa/1tcN5qp4CqtvzTaISBgbtyDvlNI//UB+TM0Kgf9X3fym
         DuOg==
X-Gm-Message-State: AOAM532n3szFQCiXAtSCS7KIwxjEnGsL+efWhQholdApISluUr0ZZ3Ka
        G8RpEC29p2qx8jXjsLutnoGtPW06mgf/ew==
X-Google-Smtp-Source: ABdhPJwUIJmnIsqgtiT+cHGl4vPiaiiOn9b6WyOeTGaDzqUNureByRM1AZxpT7XVVs9zcWtSUdzInA==
X-Received: by 2002:a17:902:d492:b029:12b:dd74:5c79 with SMTP id c18-20020a170902d492b029012bdd745c79mr6407841plg.45.1627597653314;
        Thu, 29 Jul 2021 15:27:33 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z124sm5138144pgb.6.2021.07.29.15.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:27:32 -0700 (PDT)
Date:   Thu, 29 Jul 2021 22:27:28 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Edmondson <david.edmondson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        David Matlack <dmatlack@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v3 1/3] KVM: x86: kvm_x86_ops.get_exit_info should
 include the exit reason
Message-ID: <YQMrUOjZMD1eiIeE@google.com>
References: <20210729133931.1129696-1-david.edmondson@oracle.com>
 <20210729133931.1129696-2-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729133931.1129696-2-david.edmondson@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shortlog is a bit odd, "should" is subjective and makes this sound like a bug fix.

  KVM: x86: Get exit_reason as part of kvm_x86_ops.get_exit_info

On Thu, Jul 29, 2021, David Edmondson wrote:
> Extend the get_exit_info static call to provide the reason for the VM
> exit. Modify relevant trace points to use this rather than extracting
> the reason in the caller.
> 
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---
> -static void svm_get_exit_info(struct kvm_vcpu *vcpu, u64 *info1, u64 *info2,
> +static void svm_get_exit_info(struct kvm_vcpu *vcpu, u64 *reason,
> +			      u64 *info1, u64 *info2,
>  			      u32 *intr_info, u32 *error_code)
>  {
>  	struct vmcb_control_area *control = &to_svm(vcpu)->vmcb->control;
>  
> +	*reason = control->exit_code;
>  	*info1 = control->exit_info_1;
>  	*info2 = control->exit_info_2;
>  	*intr_info = control->exit_int_info;

...

> diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
> index b484141ea15b..2228565beda2 100644
> --- a/arch/x86/kvm/trace.h
> +++ b/arch/x86/kvm/trace.h
> @@ -273,11 +273,11 @@ TRACE_EVENT(kvm_apic,
>  
>  #define TRACE_EVENT_KVM_EXIT(name)					     \
>  TRACE_EVENT(name,							     \
> -	TP_PROTO(unsigned int exit_reason, struct kvm_vcpu *vcpu, u32 isa),  \
> -	TP_ARGS(exit_reason, vcpu, isa),				     \
> +	TP_PROTO(struct kvm_vcpu *vcpu, u32 isa),			     \
> +	TP_ARGS(vcpu, isa),						     \
>  									     \
>  	TP_STRUCT__entry(						     \
> -		__field(	unsigned int,	exit_reason	)	     \
> +		__field(	u64,		exit_reason	)	     \

Converting to a u64 is unnecessary and misleading.  vmcs.EXIT_REASON and
vmcb.EXIT_CODE are both u32s, a.k.a. unsigned ints.  There is vmcb.EXIT_CODE_HI,
but that's not being included, and AFAICT isn't even sanity checked by KVM.

>  		__field(	unsigned long,	guest_rip	)	     \
>  		__field(	u32,	        isa             )	     \
>  		__field(	u64,	        info1           )	     \
