Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9885E319196
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhBKRxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhBKRSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:18:52 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B35C061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:18:11 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d13so3673659plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2Va0d5DLKmJ/vBD6ZtgEU+C4iwJe1g7ynRh/ylVryc4=;
        b=KMBWmNG8WFCySwjMyO2je+ink+5pH3UJyvLsHL+4zn8IRQYjg0TJiDbLuahQJWniLR
         DBZ3KSdJu0IuEYvrvnzy5EbhJ7UEVIExWceFJc/xxfGZImqiAGYeJrjyg5h+eu2vQ9lD
         iySXL5sT9jjCInm5ASo67ncULa5FJesyT/BXjwIjaErWbt1pKb4KfYD2Vgs0zOYbS7x7
         bku9ltYhf2Agf8DXinLHzFhloIXTDHvMyt/iRJMy0nYHMvDgzO13Id0TL7PS9ztPScXQ
         wWSyWPfmT8pIaWsIl1NK7GUiH+VQGW0bSkoq6+7A3jEwjyiEnhfxoXzNfh+QTPr2vjPn
         tYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2Va0d5DLKmJ/vBD6ZtgEU+C4iwJe1g7ynRh/ylVryc4=;
        b=pkhMTvnu8+DBctNiqgy84jvlf9OT/xCeSf/vpQ7SmtgBgBmlnjmHZVsPPIDu24q709
         pD+1NaVx9iGeom/LNcIP/U+K+sr7Ic5KqqzgJF/mwNw7ju/RZ54vygsOPZqI+1b/Rj0e
         WtnbBOOj1F8k26LCTsBRt9zXa41lcKThS4s2W1me7J1psh7XbfDQXJPeiArUh/8wpMOE
         jWTUmw/xJLu51AJqm/DX5sD4UVZB4ioOeiG3L7FaoMGAmM4mr7Zj8mxos7a/kQWuGP8k
         OT+nZo9Cs27DLOcSkvOHiehz7FOG0dz+JM0Ldcc5RrgCnoZYtlti6Ps7F6jjVFfU3Ixl
         kELw==
X-Gm-Message-State: AOAM532E2bmxo/1JmIsMKbPldUF7RVHfwbbkh9Oj5HpiK5J0UtOTk6LB
        XollYwBnRQ13zgY3DQlP7Lj0NHn7yNhDfg==
X-Google-Smtp-Source: ABdhPJzsSHNjxdlE/n1tiPWh163tang06udG1kM1kfg0+KzmHOUO7GjIz6ZrldYrikuAB1Ps3L6IqQ==
X-Received: by 2002:a17:90a:6347:: with SMTP id v7mr4970704pjs.22.1613063890677;
        Thu, 11 Feb 2021 09:18:10 -0800 (PST)
Received: from google.com ([2620:15c:f:10:f588:a708:f347:3ebb])
        by smtp.gmail.com with ESMTPSA id c84sm6383679pfb.16.2021.02.11.09.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 09:18:10 -0800 (PST)
Date:   Thu, 11 Feb 2021 09:18:03 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: nVMX: Sync L2 guest CET states between L1/L2
Message-ID: <YCVmyx8N6BYB7NGy@google.com>
References: <20210209083708.2680-1-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210209083708.2680-1-weijiang.yang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021, Yang Weijiang wrote:
> When L2 guest status has been changed by L1 QEMU/KVM, sync the change back
> to L2 guest before the later's next vm-entry. On the other hand, if it's
> changed due to L2 guest, sync it back so as to let L1 guest see the change.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 9728efd529a1..b9d8db8facea 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2602,6 +2602,12 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>  	/* Note: may modify VM_ENTRY/EXIT_CONTROLS and GUEST/HOST_IA32_EFER */
>  	vmx_set_efer(vcpu, vcpu->arch.efer);
>  
> +	if (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE) {
> +		vmcs_writel(GUEST_SSP, vmcs12->guest_ssp);
> +		vmcs_writel(GUEST_INTR_SSP_TABLE, vmcs12->guest_ssp_tbl);
> +		vmcs_writel(GUEST_S_CET, vmcs12->guest_s_cet);
> +	}
> +

This is incomplete.  If VM_ENTRY_LOAD_CET_STATE is not set, then CET state needs
to be propagated from vmcs01 to vmcs02.  See nested.vmcs01_debugctl and
nested.vmcs01_guest_bndcfgs.

It's tempting to say that we should add machinery to simplify implementing new
fields that are conditionally loading, e.g. define an array that specifies the
field, its control, and its offset in vmcs12, then process the array at the
appropriate time.  That might be overkill though...

>  	/*
>  	 * Guest state is invalid and unrestricted guest is disabled,
>  	 * which means L1 attempted VMEntry to L2 with invalid state.
> @@ -4152,6 +4158,12 @@ static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
>  
>  	if (vmcs12->vm_exit_controls & VM_EXIT_SAVE_IA32_EFER)
>  		vmcs12->guest_ia32_efer = vcpu->arch.efer;
> +
> +	if (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE) {

This is wrong, guest state is saved on VM-Exit if the control is _supported_,
it doesn't have to be enabled.

  If the processor supports the 1-setting of the “load CET” VM-entry control,
  the contents of the IA32_S_CET and IA32_INTERRUPT_SSP_TABLE_ADDR MSRs are
  saved into the corresponding fields. On processors that do not support Intel
  64 architecture, bits 63:32 of these MSRs are not saved.

And I'm pretty sure we should define these fields as a so called "rare" fields,
i.e. add 'em to the case statement in is_vmcs12_ext_field() and process them in
sync_vmcs02_to_vmcs12_rare().  CET isn't easily emulated, so they should almost
never be read/written by a VMM, and thus aren't with synchronizing to vmcs12 on
every exit.

> +		vmcs12->guest_ssp = vmcs_readl(GUEST_SSP);
> +		vmcs12->guest_ssp_tbl = vmcs_readl(GUEST_INTR_SSP_TABLE);
> +		vmcs12->guest_s_cet = vmcs_readl(GUEST_S_CET);
> +	}
>  }
>  
>  /*
> -- 
> 2.26.2
> 
