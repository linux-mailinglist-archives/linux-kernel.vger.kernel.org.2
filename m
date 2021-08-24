Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04D23F68A5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbhHXSD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240359AbhHXSDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:03:23 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163E7C05341F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:55:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id w68so19040109pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4J5j+k1+Wm4LiIcjdeGw8k45En6ooyJF7Ed5B1HrBS4=;
        b=KnQa+5opeiORJxUDlWkw/U4OGuIRvQuBVFYGmWedW8w9IZGLHsBgRByw+g4Qhr0wlF
         KlfHvSqhxi0xgIkGeLoQcDQ+KfXCMDOcRP5b1CIHt8l69y94dYrhrBbYj5um14LlEWSN
         nDW2xc+kYhzMNroW3eO5OANYh9JBIt2l/HkoVTT+6VaYGa9xTvqFIN5wPbe2W1E4l/8y
         frG9v/APtM/naDuGR7PjPEQlh7m7jkeahe4Hpohc7pKEKPa0K0Dh5QtQuhNi4KsK/Yjt
         YPah5W2wxEmU+Bt8o6cyKCgBz0loeguRQpbpGVT7LLr08f3CUf05u7tsyXRZ+ZzkXzyx
         wU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4J5j+k1+Wm4LiIcjdeGw8k45En6ooyJF7Ed5B1HrBS4=;
        b=pjsBhs/VP5tSeO81Lcb+RzlqUg5WOUSJd9zIKMVNpzsdLF1rXGJSVan8vXmoDcrUdG
         lZ1X8xhND4LO//KrC98SD9YGrp1XvSgy9sE3EONeG0EU/s/OKjEJAMwGyIA7L1xjwrZX
         4p6OdwWaesKoCHd+mb9porcnfrSEHr0rVNks7EuvawsRYralA44Fapsji5gPHKtSyHUT
         whr7p5JMBrWTkRvDQSNJvubi8el4BZr9pMQNwfEWX4z1eiZtBxQz59n4VZ2YelbgqGlP
         CEr2w6a5+8dc31Gv3oW5SDYqtP0WVxITaXXcjgUkonBiBPnhozeewc2Yiix1mjQvCBY8
         KLvw==
X-Gm-Message-State: AOAM533h+0QLp6jrfQTMakgFozkK2Ca3snzOpne6MQKI9PNLPPuLg5v5
        B9DmoNllOUAUPmPXlxj69uuTSQ==
X-Google-Smtp-Source: ABdhPJyRw81LMBUlPNEoFF4xwZdCR62gyKKRHRAlbz3WaV8wPpEL8Gz0byfS9O/EhGPAKaa8IPdgAw==
X-Received: by 2002:a65:404d:: with SMTP id h13mr14995782pgp.130.1629827702354;
        Tue, 24 Aug 2021 10:55:02 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id y3sm23770995pgc.67.2021.08.24.10.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 10:55:01 -0700 (PDT)
Date:   Tue, 24 Aug 2021 17:54:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] KVM: VMX: Restore host's MSR_IA32_RTIT_CTL when it's
 not zero
Message-ID: <YSUycNbERUv6xGmB@google.com>
References: <20210824110743.531127-1-xiaoyao.li@intel.com>
 <20210824110743.531127-2-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824110743.531127-2-xiaoyao.li@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021, Xiaoyao Li wrote:
> A minor optimation to WRMSR MSR_IA32_RTIT_CTL when necessary.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index fada1055f325..e0a9460e4dab 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1075,7 +1075,8 @@ static void pt_guest_exit(struct vcpu_vmx *vmx)
>  	}
>  
>  	/* Reload host state (IA32_RTIT_CTL will be cleared on VM exit). */

Could you opportunistically update the comment to call out that KVM requires
VM_EXIT_CLEAR_IA32_RTIT_CTL to expose PT to the guest?  E.g. something like

	/*
	 * KVM's requires VM_EXIT_CLEAR_IA32_RTIT_CTL to expose PT to the guest,
	 * i.e. RTIT_CTL is always cleared on VM-Exit.  Restore it if necessary.
	 */

With that,

Reviewed-by: Sean Christopherson <seanjc@google.com> 

> -	wrmsrl(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
> +	if (vmx->pt_desc.host.ctl)
> +		wrmsrl(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
>  }
>  
>  void vmx_set_host_fs_gs(struct vmcs_host_state *host, u16 fs_sel, u16 gs_sel,
> -- 
> 2.27.0
> 
