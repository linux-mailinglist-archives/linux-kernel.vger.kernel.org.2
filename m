Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B323BD8C5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhGFOqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233071AbhGFOqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ns4TUY5RO+JX4wfj0vy5qifMdax9cNA6M3GBSIkoFEM=;
        b=EYVfddCXVmmHZHbfebjb1WbzyNueM9CyXlDa93QN8q5JhwA+f7YbooDKuGkO70yJfJltGV
        uBNmNjn9f7qHpy1GaGAD5v/fyLUzPwPKMsVNNUzKUyg2tayswNrTlXyeiCcb9IqjJRYAsB
        2MjQG1nSoxwPD9DFRkFD8zvs1P0FJjs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-IOZRXOp8Oc-dviTTnBE7kQ-1; Tue, 06 Jul 2021 10:43:41 -0400
X-MC-Unique: IOZRXOp8Oc-dviTTnBE7kQ-1
Received: by mail-ed1-f72.google.com with SMTP id p13-20020a05640210cdb029039560ff6f46so10927695edu.17
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 07:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ns4TUY5RO+JX4wfj0vy5qifMdax9cNA6M3GBSIkoFEM=;
        b=Xg5xNa8NMTYdcXvHylipX9NL6GhJV0AtFtppzU2cCgdwBldNDEoqGe46Yh17+wXTyz
         +a8U0wtEaqRHlKhPOzaCv9rWS/GMgxG4HzXkOO3f6ps6jAH6VQHLHSAirdMNAEEaTyD9
         0315L6NRAEOIlJ03SrQm821nla5Ke7/VMK3M7udsYikMqdiKJKRPRhM1T9RUJXdKZgUR
         F0DucZE0XUGzfAhq7LaZQU0jYjOiGT3FoX+fO5DlSF64+CMSCa07vJKk8wFy3T+43dRI
         TP9AeGwg79D0fTqPO3THrYYtG0uJ2dZ8gyRFuwQA+XPO8GecOZC7gAsChe31c6TuoqfR
         u0OQ==
X-Gm-Message-State: AOAM530KOQVArGjtV1FcBchLCfEB8OUvWiB0g4Kzh1ZD4EYWnKA8dyHh
        EmDB9Y+D1GzySzuzUREsniPxTJI8O5krfL5GVlSA2OcvSz8Xt8twxuJQvsZkyjs8FJgEm4IFxDR
        zTJNdDg+NFaNAVX8Sl9bc4WGV
X-Received: by 2002:a05:6402:796:: with SMTP id d22mr23658824edy.64.1625582619818;
        Tue, 06 Jul 2021 07:43:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSSNMGGlg6GIilGiscCpEFKf2dSG/bfkm6NBsS+otzsw2jItjDuqovoJWdlrFftwo+iPPPAQ==
X-Received: by 2002:a05:6402:796:: with SMTP id d22mr23658798edy.64.1625582619689;
        Tue, 06 Jul 2021 07:43:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q5sm5807904ejc.117.2021.07.06.07.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 07:43:38 -0700 (PDT)
Subject: Re: [RFC PATCH v2 56/69] KVM: VMX: Move setting of EPT MMU masks to
 common VT-x code
To:     isaku.yamahata@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     isaku.yamahata@gmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <a1b2906ef5264c1a1bdaeca238da9d24028ab61d.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02dd301a-c15f-08d3-3f69-4cf501979a49@redhat.com>
Date:   Tue, 6 Jul 2021 16:43:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a1b2906ef5264c1a1bdaeca238da9d24028ab61d.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:05, isaku.yamahata@intel.com wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/kvm/vmx/main.c | 4 ++++
>   arch/x86/kvm/vmx/vmx.c  | 4 ----
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index c3fefa0e5a63..0d8d2a0a2979 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -34,6 +34,10 @@ static __init int vt_hardware_setup(void)
>   	if (ret)
>   		return ret;
>   
> +	if (enable_ept)
> +		kvm_mmu_set_ept_masks(enable_ept_ad_bits,
> +				      cpu_has_vmx_ept_execute_only());
> +
>   	return 0;
>   }
>   
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 77b2b2cf76db..e315a46d1566 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7644,10 +7644,6 @@ static __init int hardware_setup(void)
>   
>   	set_bit(0, vmx_vpid_bitmap); /* 0 is reserved for host */
>   
> -	if (enable_ept)
> -		kvm_mmu_set_ept_masks(enable_ept_ad_bits,
> -				      cpu_has_vmx_ept_execute_only());
> -
>   	if (!enable_ept)
>   		ept_lpage_level = 0;
>   	else if (cpu_has_vmx_ept_1g_page())
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

