Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252ED3BD89E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhGFOpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232763AbhGFOoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lCW4mu5A03mAX1pfsF2WBElksRFyEmECNwG2q1aMd6o=;
        b=HVqqICgkfNgzHMBriZVwpHZAVmeRfU9YvRXWz6iq+zqxVPSSE6dshhDTpmr6MClwiLB6qb
        d3UkQ49aB9f1IIH22M13BYEKvrXo4v1zaaL6HI4QP4W7Ie5fEU0ZArG3Z8D4MVRkSVZvRS
        e7KLT5Fv/XVXbA4wYI/DGiGrTAlO818=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-bBkr53z5NHmHck_r__1DZQ-1; Tue, 06 Jul 2021 10:41:53 -0400
X-MC-Unique: bBkr53z5NHmHck_r__1DZQ-1
Received: by mail-ed1-f71.google.com with SMTP id y17-20020a0564023591b02903951740fab5so10997031edc.23
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 07:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lCW4mu5A03mAX1pfsF2WBElksRFyEmECNwG2q1aMd6o=;
        b=P35QyNCtKVmX1a9EDHa6zxnyxgObAwmgzIViOn+eQkaeV573RvlQ/EjI7OwUzH7TAM
         uF55YM/xSNvkOzpqOOcvo30w3cndfjgp6p/FoUBfdHsMtmVeVeyg7tDrp2nhfaP6fPws
         5ZEeqIlXFhWOMKGGbPov0Qjqt26VvkOXvlijOTIIxWj7318PEtN/GwYOKysVTUUwq/I1
         1J38Li3cUKrDqCDJIKOI0usa/mrN+nTiHe9dfHRzTaje+a8r4AW69WyODLL5MXnrAVdx
         W/69YMgW3IklqqjFCDzmi40dG8z7a13A1oCLyrP1gVqxMUQSOG25xxePgSFnQdD1J7jq
         xHMg==
X-Gm-Message-State: AOAM530TQ1vwrfhYIthb6Wo0WC7Ma5rTYDyKC/Wqa/ZEWl14iprh664Q
        fmlS+GB2cFeCbOzMQ+2kDa81M89hosyhR0Wvdv5V3vYv5QdqdQuQpQEmfuF6LPdfs5+wsvVf0M6
        kmxLSAiB2qUjcmuL+CztRquxM
X-Received: by 2002:a05:6402:51d0:: with SMTP id r16mr23189996edd.378.1625582512745;
        Tue, 06 Jul 2021 07:41:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxYn04pzI3wt4pey5+l7jbK1WYW0LRjZnDR75JfLgzL0udS2idZUY+M6PWnsZL2U2ThJ5mbg==
X-Received: by 2002:a05:6402:51d0:: with SMTP id r16mr23189961edd.378.1625582512597;
        Tue, 06 Jul 2021 07:41:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c6sm7151945ede.17.2021.07.06.07.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 07:41:51 -0700 (PDT)
Subject: Re: [RFC PATCH v2 53/69] KVM: VMX: Define EPT Violation architectural
 bits
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
 <e519d6ae1e75a4bea494bb3940e1272e935ead18.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b56f25fc-0e62-5875-d0cf-9e28574b1bb0@redhat.com>
Date:   Tue, 6 Jul 2021 16:41:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e519d6ae1e75a4bea494bb3940e1272e935ead18.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:04, isaku.yamahata@intel.com wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Define the EPT Violation #VE control bit, #VE info VMCS fields, and the
> suppress #VE bit for EPT entries.

Better: "KVM: VMX: Define EPT Violation #VE architectural bits".

Paolo

> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/include/asm/vmx.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index 035dfdafa2c1..132981276a2f 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -78,6 +78,7 @@ struct vmcs {
>   #define SECONDARY_EXEC_ENCLS_EXITING		VMCS_CONTROL_BIT(ENCLS_EXITING)
>   #define SECONDARY_EXEC_RDSEED_EXITING		VMCS_CONTROL_BIT(RDSEED_EXITING)
>   #define SECONDARY_EXEC_ENABLE_PML               VMCS_CONTROL_BIT(PAGE_MOD_LOGGING)
> +#define SECONDARY_EXEC_EPT_VIOLATION_VE		VMCS_CONTROL_BIT(EPT_VIOLATION_VE)
>   #define SECONDARY_EXEC_PT_CONCEAL_VMX		VMCS_CONTROL_BIT(PT_CONCEAL_VMX)
>   #define SECONDARY_EXEC_XSAVES			VMCS_CONTROL_BIT(XSAVES)
>   #define SECONDARY_EXEC_MODE_BASED_EPT_EXEC	VMCS_CONTROL_BIT(MODE_BASED_EPT_EXEC)
> @@ -226,6 +227,8 @@ enum vmcs_field {
>   	VMREAD_BITMAP_HIGH              = 0x00002027,
>   	VMWRITE_BITMAP                  = 0x00002028,
>   	VMWRITE_BITMAP_HIGH             = 0x00002029,
> +	VE_INFO_ADDRESS                 = 0x0000202A,
> +	VE_INFO_ADDRESS_HIGH            = 0x0000202B,
>   	XSS_EXIT_BITMAP                 = 0x0000202C,
>   	XSS_EXIT_BITMAP_HIGH            = 0x0000202D,
>   	ENCLS_EXITING_BITMAP		= 0x0000202E,
> @@ -509,6 +512,7 @@ enum vmcs_field {
>   #define VMX_EPT_IPAT_BIT    			(1ull << 6)
>   #define VMX_EPT_ACCESS_BIT			(1ull << 8)
>   #define VMX_EPT_DIRTY_BIT			(1ull << 9)
> +#define VMX_EPT_SUPPRESS_VE_BIT			(1ull << 63)
>   #define VMX_EPT_RWX_MASK                        (VMX_EPT_READABLE_MASK |       \
>   						 VMX_EPT_WRITABLE_MASK |       \
>   						 VMX_EPT_EXECUTABLE_MASK)
> 

