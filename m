Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A1032D80B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbhCDQru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbhCDQrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:47:33 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B96C061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 08:46:52 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id z5so3607138plg.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 08:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HykUYsSsCm1IFF5m9E/k7YQYE5w/GX/AcJ5dFtF+PPY=;
        b=Bu/HtmPQyoZWTuTrnyk3UonPFCw0rkRVZjaDulB6nziD1cO8Dg0oS4UMfOoKtEy/ta
         xzY7+dyLHjEG5b06Ets5SAKwEXTVvubhNeElmMbf5QVxfq/KMhmbR4G9G/Pj9gAg8vCR
         UX5i8kesGIELWFRFvI9Q4NAsounGXg/uFpGlvZSCr47Vt2+McHGCFCOWst6GNKMTjRvl
         Ta3OIwXuWaEj+msk5nd2b50OvOswgXD6/xbpJMb1BRVPKVSY/29v+Aqtwr5akmfMRgiz
         /ct6wcLYYMuNh6J2/STdwV1mOkucwRmfr7vCO0QGeO9Ukkjp8Z8bOn94S8PvWePPkrnn
         ytyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HykUYsSsCm1IFF5m9E/k7YQYE5w/GX/AcJ5dFtF+PPY=;
        b=uUXXGgv21PFdi9/JtAPpmfh871Dc2Dkmrg9AfMlVHe1alf4f4HmNsJ7RWTp6SMAF38
         0D2aqlV/sqPiFl96zKP5i041Yst+T4mPaxuzv7TdwWW7CZ0NukAQGoYOysa6F5eOIp++
         6E+AeTPhpxqRcgXWt8uxEHkuR25BYfPYN+YduS1RFyW7gC6DidSXlo8n5QZeHSbSbKY7
         7gl7uUfPUnA5rYQvZchRvc5xDNyubD+d7Tcxqv2PeKRwAEex90t+wWHj54d0uadmeywQ
         3LfIK2icZ7DmLnM56ZOpI1pZlvchcIRF3MrmlkpudcdeX9Dif99+tspwEQ8Vvaev0bVY
         mDhw==
X-Gm-Message-State: AOAM533JmXAZ7vS6fTRiYVc4S3TSMZcaM4/bjV/VIcEJQxaWOK7XR4do
        B5CF/ESp0bgKencdQZ4bbSY4fQ==
X-Google-Smtp-Source: ABdhPJzIXTyPntut7N7hgGC3heqthHAeAhMGGV92UhYXavHskIqEBcgq+UInjamoip17yFYoR9IjUA==
X-Received: by 2002:a17:902:b711:b029:e5:ba7a:d2ee with SMTP id d17-20020a170902b711b02900e5ba7ad2eemr4805470pls.13.1614876412330;
        Thu, 04 Mar 2021 08:46:52 -0800 (PST)
Received: from google.com ([2620:15c:f:10:9857:be95:97a2:e91c])
        by smtp.gmail.com with ESMTPSA id u17sm2925695pgl.80.2021.03.04.08.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 08:46:51 -0800 (PST)
Date:   Thu, 4 Mar 2021 08:46:45 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] KVM: nVMX: Sync L2 guest CET states between L1/L2
Message-ID: <YEEO9bcLnc0gyLyP@google.com>
References: <20210304060740.11339-1-weijiang.yang@intel.com>
 <20210304060740.11339-2-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304060740.11339-2-weijiang.yang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021, Yang Weijiang wrote:
> @@ -3375,6 +3391,12 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
>  	if (kvm_mpx_supported() &&
>  		!(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS))
>  		vmx->nested.vmcs01_guest_bndcfgs = vmcs_read64(GUEST_BNDCFGS);
> +	if (kvm_cet_supported() &&
> +		!(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE)) {

Alignment.

> +		vmx->nested.vmcs01_guest_ssp = vmcs_readl(GUEST_SSP);
> +		vmx->nested.vmcs01_guest_s_cet = vmcs_readl(GUEST_S_CET);
> +		vmx->nested.vmcs01_guest_ssp_tbl = vmcs_readl(GUEST_INTR_SSP_TABLE);
> +	}
>  
>  	/*
>  	 * Overwrite vmcs01.GUEST_CR3 with L1's CR3 if EPT is disabled *and*
> @@ -4001,6 +4023,9 @@ static bool is_vmcs12_ext_field(unsigned long field)
>  	case GUEST_IDTR_BASE:
>  	case GUEST_PENDING_DBG_EXCEPTIONS:
>  	case GUEST_BNDCFGS:
> +	case GUEST_SSP:
> +	case GUEST_INTR_SSP_TABLE:
> +	case GUEST_S_CET:
>  		return true;
>  	default:
>  		break;
> @@ -4052,6 +4077,11 @@ static void sync_vmcs02_to_vmcs12_rare(struct kvm_vcpu *vcpu,
>  		vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS);
>  	if (kvm_mpx_supported())
>  		vmcs12->guest_bndcfgs = vmcs_read64(GUEST_BNDCFGS);
> +	if (kvm_cet_supported()) {

Isn't the existing kvm_mpx_supported() check wrong in the sense that KVM only
needs to sync to vmcs12 if KVM and the guest both support MPX?  Same would
apply to CET.  Not sure it'd be a net positive in terms of performance since
guest_cpuid_has() can be quite slow, but overwriting vmcs12 fields that
technically don't exist feels wrong.

> +		vmcs12->guest_ssp = vmcs_readl(GUEST_SSP);
> +		vmcs12->guest_s_cet = vmcs_readl(GUEST_S_CET);
> +		vmcs12->guest_ssp_tbl = vmcs_readl(GUEST_INTR_SSP_TABLE);
> +	}
>  
>  	vmx->nested.need_sync_vmcs02_to_vmcs12_rare = false;
>  }
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 9d3a557949ac..36dc4fdb0909 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -155,6 +155,9 @@ struct nested_vmx {
>  	/* to migrate it to L2 if VM_ENTRY_LOAD_DEBUG_CONTROLS is off */
>  	u64 vmcs01_debugctl;
>  	u64 vmcs01_guest_bndcfgs;
> +	u64 vmcs01_guest_ssp;
> +	u64 vmcs01_guest_s_cet;
> +	u64 vmcs01_guest_ssp_tbl;
>  
>  	/* to migrate it to L1 if L2 writes to L1's CR8 directly */
>  	int l1_tpr_threshold;
> -- 
> 2.26.2
> 
