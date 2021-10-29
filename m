Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E37B43F995
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 11:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhJ2JS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 05:18:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29521 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231476AbhJ2JRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 05:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635498904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FKPJ14P0NBDDQOtnjBeYPNE2VaHGagsVkffrpahKyO4=;
        b=SuraIBbmMsB14D5J/ax0pcbddp8yFFoVzgjKCeBxSRpZ4ZHs41iQw3jlJte5n5OaXQI0pu
        TtoH8J4rLGNINV2xz1V5awU5XU6/Lyozp3mH4Q6ydfuKO1WC6O1WJziKzUbuEtT60m8cpK
        5sGNF09Td1mA5I1UOXORiFbBWKApfxQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-Q4cR0_cfOkSC1PJhtObNfg-1; Fri, 29 Oct 2021 05:15:02 -0400
X-MC-Unique: Q4cR0_cfOkSC1PJhtObNfg-1
Received: by mail-wm1-f70.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso1154916wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 02:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FKPJ14P0NBDDQOtnjBeYPNE2VaHGagsVkffrpahKyO4=;
        b=oET2NGAh/Ixw08xnAvyFatLSiqHiMAhTAMtmeey39zs9xIDpambb+NCWPgTkDhOCc6
         tgFXtZkdC/snWGeBQtW00YKhoRThXbV1R9X4YnTSxDbxhIOkX0PkEdQcYLVHj6ARaIs/
         Vgn5By6gwh9zoAuTpyjRcIptXyUCMkJoOlkhsOWZSuLXU/OS+2DT1NPjAdjjz97cBp6e
         p4ECp0RHVKeNYW4QvicnFTNja6zDrN9wmnQe9hqeFTUQebi78+Tj5n3lblNa6/SyYvNY
         Miu4eLZSj3+SHxU77Z3CvDdzb18LchrVwtD1GKiN86hsnB231ugt79koRaRMVbVecSxq
         eI1A==
X-Gm-Message-State: AOAM532bh64f/P5aVMroxtAJ0YfwERIgHI50tNAchLX6LeMWjGO0oe5Z
        p+WPG2AVVGvc6Wb0TL65zhTBP0TfCZjyZd1NuLHg9mX4GcWQnMpvD+4rD4CxlbagVZm+xe4Cw5P
        LsLFugxkFxd7VDeckrlzVppMc
X-Received: by 2002:a05:600c:3782:: with SMTP id o2mr18314881wmr.102.1635498900991;
        Fri, 29 Oct 2021 02:15:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBi96wOMUiniT8KYl19QAwCyp/0nDgv72yF7u0aKoMA8EIaa6Ez1bJSb8svu11JzSwqVPUsA==
X-Received: by 2002:a05:600c:3782:: with SMTP id o2mr18314851wmr.102.1635498900780;
        Fri, 29 Oct 2021 02:15:00 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b8sm6816697wri.53.2021.10.29.02.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 02:15:00 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [PATCH 1/2] x86/hyperv: Fix NULL deref in set_hv_tscchange_cb()
 if Hyper-V setup fails
In-Reply-To: <20211028222148.2924457-2-seanjc@google.com>
References: <20211028222148.2924457-1-seanjc@google.com>
 <20211028222148.2924457-2-seanjc@google.com>
Date:   Fri, 29 Oct 2021 11:14:59 +0200
Message-ID: <87tuh0ry3w.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Check for re-enlightenment support and for a valid hv_vp_index array
> prior to derefencing hv_vp_index when setting Hyper-V's TSC change
> callback.  If Hyper-V setup failed in hyperv_init(), e.g. because of a
> bad VMM config that doesn't advertise the HYPERCALL MSR, the kernel will
> still report that it's running under Hyper-V, but will have silently
> disabled nearly all functionality.
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000010
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] SMP
>   CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc2+ #75
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>   RIP: 0010:set_hv_tscchange_cb+0x15/0xa0
>   Code: <8b> 04 82 8b 15 12 17 85 01 48 c1 e0 20 48 0d ee 00 01 00 f6 c6 08
>   ...
>   Call Trace:
>    kvm_arch_init+0x17c/0x280
>    kvm_init+0x31/0x330
>    vmx_init+0xba/0x13a
>    do_one_initcall+0x41/0x1c0
>    kernel_init_freeable+0x1f2/0x23b
>    kernel_init+0x16/0x120
>    ret_from_fork+0x22/0x30
>
> Fixes: 93286261de1b ("x86/hyperv: Reenlightenment notifications support")
> Cc: stable@vger.kernel.org
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/hyperv/hv_init.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 708a2712a516..6cc845c026d4 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -139,7 +139,7 @@ void set_hv_tscchange_cb(void (*cb)(void))
>  	struct hv_reenlightenment_control re_ctrl = {
>  		.vector = HYPERV_REENLIGHTENMENT_VECTOR,
>  		.enabled = 1,
> -		.target_vp = hv_vp_index[smp_processor_id()]
> +		.target_vp = -1,
>  	};
>  	struct hv_tsc_emulation_control emu_ctrl = {.enabled = 1};
>  
> @@ -148,6 +148,11 @@ void set_hv_tscchange_cb(void (*cb)(void))
>  		return;
>  	}
>  
> +	if (!hv_vp_index)
> +		return;
> +
> +	re_ctrl.target_vp = hv_vp_index[smp_processor_id()];
> +
>  	hv_reenlightenment_cb = cb;
>  
>  	/* Make sure callback is registered before we write to MSRs */

The patch looks good, however, it needs to be applied on top of the
already merged:

https://lore.kernel.org/linux-hyperv/20211012155005.1613352-1-vkuznets@redhat.com/

-- 
Vitaly

