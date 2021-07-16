Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEFF3CB579
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 11:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhGPJzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 05:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231386AbhGPJzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626429136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fb4R+JVoagpsb7WH3nwCiNnKAH31HT4aNCBqTWasD8c=;
        b=QFPxxgzuUDD72Q5SSvalruNCTh6biu9CK3lvCCRhb+UrcfqW1Da3hqwW2woU/kuxZd1zGF
        x7UswQHXHPwbYGjobXXynZ03E+OG7p8PUJeoGzAXrZMXVHjC5DTOUoudhCk5pAUBj8prP1
        b8nFFk2kFcRtMPOP36HeFndl917I/C8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-STFjihbcMl6nWBWD-P0GHg-1; Fri, 16 Jul 2021 05:52:14 -0400
X-MC-Unique: STFjihbcMl6nWBWD-P0GHg-1
Received: by mail-wm1-f69.google.com with SMTP id p9-20020a7bcc890000b02902190142995dso2210856wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 02:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fb4R+JVoagpsb7WH3nwCiNnKAH31HT4aNCBqTWasD8c=;
        b=uLdQ7HKZtNvo3fsPJlkL/IZcW+DOtBvII9caPcM9nlhH+Dthhw26MLFZr/z2Qcx+Dt
         X08oDnyRQxTGVLBGoj7J966mm4Gb7jDu32p/K0lyOjjX2oi37AIuV3GGdyyxxDYOvY07
         EwHwGv4cyFZKzvASeNcPZcU9gkLFBny+PlXK1EX8T1TLypJuVCI7QxtxUntpri/WMtSl
         3ebzP+qwQwaU80LXfbU9oCPFiFOah2h8vcyyYTKYYLvToHM/2XQwerx289BJ7FxstbUx
         aKJLlhdC7COIAXCJsAjVYUxDq91a4LBOoNdTOvK/96LcLa0ipHrGmaqjJSOfKC7t5+DJ
         jYSw==
X-Gm-Message-State: AOAM531qBK4vXWIJJKEZk7kX4aH8nO4dBKc67tUxf+qtTCs9lWqPTG2+
        4cLaK6iS5YXXWikt8JBeKjbHWz91KQUeIp9Fp6vy3XKeawfHqCYQX9VGK/e9DKw9JGunFHCWcWF
        X4fIKKsxp9n/NeZGcEGMsvxjn
X-Received: by 2002:a05:600c:4f96:: with SMTP id n22mr9487005wmq.137.1626429133665;
        Fri, 16 Jul 2021 02:52:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4PzoAhnSdzpCYK7ODLnh30V49UUpOf9H5Ht+rIvB4Eqa05Jn7dZdV6hgU0Y5jzzVByP7LiQ==
X-Received: by 2002:a05:600c:4f96:: with SMTP id n22mr9486968wmq.137.1626429133409;
        Fri, 16 Jul 2021 02:52:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id c125sm12505903wme.36.2021.07.16.02.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 02:52:12 -0700 (PDT)
To:     Zeng Guang <guang.zeng@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Kai Huang <kai.huang@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Robert Hu <robert.hu@intel.com>, Gao Chao <chao.gao@intel.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
References: <20210716064808.14757-1-guang.zeng@intel.com>
 <20210716064808.14757-7-guang.zeng@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/6] KVM: VMX: enable IPI virtualization
Message-ID: <8aed2541-082d-d115-09ac-e7fcc05f96dc@redhat.com>
Date:   Fri, 16 Jul 2021 11:52:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716064808.14757-7-guang.zeng@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/21 08:48, Zeng Guang wrote:
>  
> +	if (!(_cpu_based_3rd_exec_control & TERTIARY_EXEC_IPI_VIRT))
> +		enable_ipiv = 0;
> +
>   	}

Please move this to hardware_setup(), using a new function 
cpu_has_vmx_ipiv() in vmx/capabilities.h.

>  	if (_cpu_based_exec_control & CPU_BASED_ACTIVATE_TERTIARY_CONTROLS) {
> -		u64 opt3 = 0;
> +		u64 opt3 = enable_ipiv ? TERTIARY_EXEC_IPI_VIRT : 0;
>  		u64 min3 = 0;

I like the idea of changing opt3, but it's different from how 
setup_vmcs_config works for the other execution controls.  Let me think 
if it makes sense to clean this up, and move the handling of other 
module parameters from hardware_setup() to setup_vmcs_config().

> +
> +	if (vmx->ipiv_active)
> +		install_pid(vmx);

This should be if (enable_ipiv) instead, I think.

In fact, in all other places that are using vmx->ipiv_active, you can 
actually replace it with enable_ipiv; they are all reached only with 
kvm_vcpu_apicv_active(vcpu) == true.

> +	if (!enable_apicv) {
> +		enable_ipiv = 0;
> +		vmcs_config.cpu_based_3rd_exec_ctrl &= ~TERTIARY_EXEC_IPI_VIRT;
> +	}

The assignment to vmcs_config.cpu_based_3rd_exec_ctrl should not be 
necessary; kvm_vcpu_apicv_active will always be false in that case and 
IPI virtualization would never be enabled.

Paolo

