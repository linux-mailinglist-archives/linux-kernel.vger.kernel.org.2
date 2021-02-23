Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B14323425
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 00:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhBWXNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 18:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbhBWW73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:59:29 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5A5C06178B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 14:58:37 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id s23so3022734pji.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 14:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nKO+dRLATRVmZPlvZjV64HXRuWuPyFxt3gyKTmbS/9c=;
        b=IG3vsiD67MFToXB74AUsAQK01d5BoNsk9Ngn7a976Zqnvvhjq4JdhuKPd4wTBme59G
         vgarm/gtwPsUlSUnJV3voLecAG9x7V1jTItn1u9+65t3hhZpCFfuGLZgGQhLJAEgpoMn
         6zjxzwHD32nUxNfyCc3IXBECyIDfdvDKEHs4CPmghbJK246OoXwxEsAQIh33uDqHu9H+
         GTdzElwsxPx3B5COt7euCWI+PiIkbE98TN5VjWkbzTk+Qbpc4fQ9laNbBBroMTjxypVp
         jDEsuIhD+pd1Q6NUAxPrtozhuiRvgKMqW9G+RbLy+h1nHT3/fUfy70d0Xcd4N1lTrdcM
         /z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nKO+dRLATRVmZPlvZjV64HXRuWuPyFxt3gyKTmbS/9c=;
        b=Rka39Cv3wMUhEIobHb62r31DYuFxahDbB0/4lxtAabieTAzKkSB6GHot6KWTh6/g0u
         ISTYixT4/dDQDpHEuw7GI41csRr580N+kksugEhaDvAi8fBK8hMyuUteabDqk5ToMsDV
         yq0T10nRTB25FGeyTT6b9SIxgwHUKUh62Ie5Z9egAXaZGK3wu6Bx2UuOUGd7bNY1hTJa
         oa1uySZPDFprJgNmBlu/3hpsUqzbYbAVjBeXUGPesytSFUsy7c0k2vTOBoiEtEOHND2f
         jcjnQM/wOlEoXXu3JV4oyEaTllwd/BQP3vB5ebdRz5L7NYZfLJPZZHyFA+5qszNcEPeB
         x39g==
X-Gm-Message-State: AOAM531e3NcdF7pE1tSKV5+2Ojm4ssrMHvy+otdYKhdj285Za7VYz80s
        zLllkTV+66FF5bm40QDKmQWqeg==
X-Google-Smtp-Source: ABdhPJwf4lgyPhoO5d3TmW9Bnu7Af4BQI2aHZ7bRGqRcJhnpGd33iOu526317KAErf/DnuCF4h/bIg==
X-Received: by 2002:a17:90a:8b02:: with SMTP id y2mr1027275pjn.111.1614121116679;
        Tue, 23 Feb 2021 14:58:36 -0800 (PST)
Received: from google.com ([2620:15c:f:10:c939:813f:76bc:d651])
        by smtp.gmail.com with ESMTPSA id w1sm159092pjq.38.2021.02.23.14.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 14:58:36 -0800 (PST)
Date:   Tue, 23 Feb 2021 14:58:29 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     David Edmondson <david.edmondson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v2 2/3] KVM: x86: dump_vmcs should not conflate EFER and
 PAT presence in VMCS
Message-ID: <YDWIlb0epWBcxFNr@google.com>
References: <20210219144632.2288189-1-david.edmondson@oracle.com>
 <20210219144632.2288189-3-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219144632.2288189-3-david.edmondson@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021, David Edmondson wrote:
> Show EFER and PAT based on their individual entry/exit controls.
> 
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 818051c9fa10..25090e3683ca 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5805,11 +5805,12 @@ void dump_vmcs(void)
>  	vmx_dump_sel("LDTR:", GUEST_LDTR_SELECTOR);
>  	vmx_dump_dtsel("IDTR:", GUEST_IDTR_LIMIT);
>  	vmx_dump_sel("TR:  ", GUEST_TR_SELECTOR);
> -	if ((vmexit_ctl & (VM_EXIT_SAVE_IA32_PAT | VM_EXIT_SAVE_IA32_EFER)) ||
> -	    (vmentry_ctl & (VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_IA32_EFER)))
> -		pr_err("EFER =     0x%016llx  PAT = 0x%016llx\n",
> -		       vmcs_read64(GUEST_IA32_EFER),
> -		       vmcs_read64(GUEST_IA32_PAT));
> +	if ((vmexit_ctl & VM_EXIT_SAVE_IA32_EFER) ||

Not your code, and completely benign since VM_EXIT_SAVE is never set, but I
don't like checking the VM_EXIT_SAVE_* flag as saving a field on VM-Exit has
zero impact on whether VM-Entry succeeds or fails.  Same complaint on the PAT
field.

> +	    (vmentry_ctl & VM_ENTRY_LOAD_IA32_EFER))
> +		pr_err("EFER= 0x%016llx\n", vmcs_read64(GUEST_IA32_EFER));

Tying into the previous patch, I think we should print both the effective EFER
and vmcs.EFER.  The effective EFER is relevant for several consistency checks.
Maybe something like this?

	pr_err("EFER= 0x%016llx  ", effective_efer);
	if (vmentry_ctl & VM_ENTRY_LOAD_IA32_EFER)
		pr_cont("vmcs.EFER= 0x%016llx\n", vmcs_read64(GUEST_IA32_EFER));
	else
		pr_cont("vmcs.EFER not loaded\n")

> +	if ((vmexit_ctl & VM_EXIT_SAVE_IA32_PAT) ||
> +	    (vmentry_ctl & VM_ENTRY_LOAD_IA32_PAT))
> +		pr_err("PAT = 0x%016llx\n", vmcs_read64(GUEST_IA32_PAT));
>  	pr_err("DebugCtl = 0x%016llx  DebugExceptions = 0x%016lx\n",
>  	       vmcs_read64(GUEST_IA32_DEBUGCTL),
>  	       vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS));
> @@ -5846,10 +5847,10 @@ void dump_vmcs(void)
>  	       vmcs_readl(HOST_IA32_SYSENTER_ESP),
>  	       vmcs_read32(HOST_IA32_SYSENTER_CS),
>  	       vmcs_readl(HOST_IA32_SYSENTER_EIP));
> -	if (vmexit_ctl & (VM_EXIT_LOAD_IA32_PAT | VM_EXIT_LOAD_IA32_EFER))
> -		pr_err("EFER = 0x%016llx  PAT = 0x%016llx\n",
> -		       vmcs_read64(HOST_IA32_EFER),
> -		       vmcs_read64(HOST_IA32_PAT));
> +	if (vmexit_ctl & VM_EXIT_LOAD_IA32_EFER)
> +		pr_err("EFER= 0x%016llx\n", vmcs_read64(HOST_IA32_EFER));
> +	if (vmexit_ctl & VM_EXIT_LOAD_IA32_PAT)
> +		pr_err("PAT = 0x%016llx\n", vmcs_read64(HOST_IA32_PAT));
>  	if (cpu_has_load_perf_global_ctrl() &&
>  	    vmexit_ctl & VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL)
>  		pr_err("PerfGlobCtl = 0x%016llx\n",
> -- 
> 2.30.0
> 
