Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0842C3DC0DD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 00:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhG3WRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhG3WRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:17:12 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C76C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:17:06 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d1so12775399pll.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j3CWkr4LGFWVijA0F5+uvtBxXNJN5hzTi1peLb8EaHw=;
        b=ow2+bO53mxJeeECn8KgYGy3IbFqA6iDgjshHNGqQxGnsvy5Qs0peepWBDO0+fcgeDC
         mKsBZDZsn1AR/m2LyxITmg87T4UfvFnkxKpz+RPg5dX9BIsnjl9Zzyo3e1CXJIqFbp+y
         it4j4J0rIDdWkLwKNHXe98h6/dHjLlZoZpmU0nusPKIMZD87fI7wTKtJlRiVJDuAUPQO
         86f5PYjsuj4uszMa4saCfmkLoyajBh9s85Ta12T4iXQ9giz15/VuxBgFeMU6GTDO77iC
         pCApyFvv1y9BK+RmG/dcwc8nDjTEo3k0cLRXE9cF5XJN43d1Fin3OHdZ6rhVENOvwGAJ
         XA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j3CWkr4LGFWVijA0F5+uvtBxXNJN5hzTi1peLb8EaHw=;
        b=jtvvcnVz03WS06QPUiKw16k7IZs2XoXfPVw3h7/lfu5OE4AtwI+ndUCVOCjN1cZkYy
         uza3hT3RvuK24IcaMgwwEiM+2pI7a87objiiOHG8d+erdA/7wwTzRZoaeosjZpyqOQtH
         g0HegUIP2iuSRMZ3L6Yo4y7r7XGIXRa5j8O6A0+ZXosPyxhCOS7gTPGF1+Nr048bttPg
         Smi6z3hIzEaK65RjHri/l0iKJWnSoyeUiOOowQZoRw0Sk6PqbTXbluN5JGntmAdZoKCw
         aBByfk4XAcDT3WRyQg+H03RqlYqrsTv4kC9RKsB24ARY4sR+lwiAJJP+v9Aie7RpcstG
         v1lg==
X-Gm-Message-State: AOAM533b7RRNIeYMGeu6+URVkPrsUjciDe4Sv8b7ztm8vTLV9clIdK3g
        /FNKXziOhLh17XnR2rWfEmg5jQ==
X-Google-Smtp-Source: ABdhPJx1SekY7bQy0bRQnYQ0MeiObJeDznYkVJhGaDlL7rGX/UFK+JFO81HFuZgjL+UjIKZtKPNfiQ==
X-Received: by 2002:a62:8fd4:0:b029:3af:3fa7:c993 with SMTP id n203-20020a628fd40000b02903af3fa7c993mr3980514pfd.77.1627683426293;
        Fri, 30 Jul 2021 15:17:06 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id a21sm3214613pjq.2.2021.07.30.15.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 15:17:05 -0700 (PDT)
Date:   Fri, 30 Jul 2021 22:17:02 +0000
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
Subject: Re: [PATCH v3 3/3] KVM: x86: SGX must obey the
 KVM_INTERNAL_ERROR_EMULATION protocol
Message-ID: <YQR6XgkjaGfGhesl@google.com>
References: <20210729133931.1129696-1-david.edmondson@oracle.com>
 <20210729133931.1129696-4-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729133931.1129696-4-david.edmondson@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021, David Edmondson wrote:
> When passing the failing address and size out to user space, SGX must
> ensure not to trample on the earlier fields of the emulation_failure
> sub-union of struct kvm_run.
> 
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---
>  arch/x86/kvm/vmx/sgx.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
> index 6693ebdc0770..63fb93163383 100644
> --- a/arch/x86/kvm/vmx/sgx.c
> +++ b/arch/x86/kvm/vmx/sgx.c
> @@ -53,11 +53,9 @@ static int sgx_get_encls_gva(struct kvm_vcpu *vcpu, unsigned long offset,
>  static void sgx_handle_emulation_failure(struct kvm_vcpu *vcpu, u64 addr,
>  					 unsigned int size)
>  {
> -	vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> -	vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
> -	vcpu->run->internal.ndata = 2;
> -	vcpu->run->internal.data[0] = addr;
> -	vcpu->run->internal.data[1] = size;
> +	uint64_t data[2] = { addr, size };
> +
> +	kvm_prepare_emulation_failure_exit(vcpu, false, data, sizeof(data));

Assuming we go with my suggestion to have kvm_prepare_emulation_failure_exit()
capture the exit reason/info, it's probably worth converting all the
KVM_EXIT_INTERNAL_ERROR paths in sgx.c, even though the others don't clobber flags.
