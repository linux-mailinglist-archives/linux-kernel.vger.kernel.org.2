Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499213CCA9E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 22:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhGRUfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 16:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229615AbhGRUfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 16:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626640364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOCbVgG9U8x+NoVX3pVCcVmmzN+A8qZCtIf7MIsJPSs=;
        b=CfmvfkXUBLGhe3zyz+jAcm7Acp3x01SO8DevtEaWA5KyGmOIluMQY185oi/bhckimVTZkX
        Zg6dr8fWY7P8GBT7syyZs64dCIsknXlz/mbnGI3JqHFMlPq4Y9hwKXQ7yo4GMwTes+fH3M
        bETTYCc/R3K/Up8LEcDeHVM1Mpyjs1k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-eIbKUlTrNX-Zx5ADjDMgew-1; Sun, 18 Jul 2021 16:32:42 -0400
X-MC-Unique: eIbKUlTrNX-Zx5ADjDMgew-1
Received: by mail-ed1-f72.google.com with SMTP id j7-20020aa7c4070000b02903a4b519b413so8103631edq.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 13:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HOCbVgG9U8x+NoVX3pVCcVmmzN+A8qZCtIf7MIsJPSs=;
        b=V+KPuRdRMGD/Mza47+Mvd0C/R8xd+FD3gljNKfogRn4t6StPOAdfpH0qDD4WnNXOjh
         icT0PcWn/YJMrk8zoNAOEL6dq6wtm0r8nYqJjBjNK61aDt+e90Pdp7gQWh6cBsYoeAaP
         pcOQ2bxrBcXkH2odfWtktepbIkN2ucdOUUKwknnk83sEyUtm+GCQ/1hQ59rwuex1p9ZQ
         y8yqHH+pAPEORGXynfhrs7GpYPmNesp/M2db7QNSdlrtS8F53X+hHwRnAF/nJFvSTvBd
         sK7HwPwrc5Wt2Ih7+h5QUi8rut3BwVTJrkqGtg8cnWEu+8Y81NwPdViefvxBzvL2cfsl
         MjIw==
X-Gm-Message-State: AOAM530dNVWJNod9t32zfL3D3MsbV0Rhu3J+yAl2XL9jDQWHe/ZD14jM
        +8hkBgtyCRXuH20M0zcpOpE4/GDcd2pTMW1PFIv9HeOwf8kNV5HsyWQYi+igzJcTKxv/IgaIEfL
        c4lzwR6QyWTynCXtsnkhYxm6O
X-Received: by 2002:a17:906:5e09:: with SMTP id n9mr23936022eju.15.1626640361449;
        Sun, 18 Jul 2021 13:32:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8MPuhz1+gRJoKoUN0X+ZWZULe5Ox+QV8KAdS7/rtmM67HPcZsw79vspQGbzpo2mM1E4w8oA==
X-Received: by 2002:a17:906:5e09:: with SMTP id n9mr23936007eju.15.1626640361294;
        Sun, 18 Jul 2021 13:32:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id a5sm6729439edj.20.2021.07.18.13.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jul 2021 13:32:40 -0700 (PDT)
Subject: Re: [PATCH 6/6] KVM: VMX: enable IPI virtualization
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
 <8aed2541-082d-d115-09ac-e7fcc05f96dc@redhat.com>
 <89f240cb-cb3a-c362-7ded-ee500cc12dc3@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0d6f7852-95b3-d628-955b-f44d88a86478@redhat.com>
Date:   Sun, 18 Jul 2021 22:32:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <89f240cb-cb3a-c362-7ded-ee500cc12dc3@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/21 05:55, Zeng Guang wrote:
>>>      if (_cpu_based_exec_control & 
>>> CPU_BASED_ACTIVATE_TERTIARY_CONTROLS) {
>>> -        u64 opt3 = 0;
>>> +        u64 opt3 = enable_ipiv ? TERTIARY_EXEC_IPI_VIRT : 0;
>>>          u64 min3 = 0;
>>
>> I like the idea of changing opt3, but it's different from how 
>> setup_vmcs_config works for the other execution controls.  Let me 
>> think if it makes sense to clean this up, and move the handling of 
>> other module parameters from hardware_setup() to setup_vmcs_config().
>>
> May be an exception for ipiv feature ?

Yes, possibly.  I'll look into using this idea for other parameters.

>>> +    if (vmx->ipiv_active)
>>> +        install_pid(vmx);
>>
>> This should be if (enable_ipiv) instead, I think.
>>
>> In fact, in all other places that are using vmx->ipiv_active, you can 
>> actually replace it with enable_ipiv; they are all reached only with 
>> kvm_vcpu_apicv_active(vcpu) == true.
>>
> enable_ipiv as a global variable indicates the hardware capability to 
> enable IPIv. Each VM may have different IPIv configuration according to 
> kvm_vcpu_apicv_active status. So we use ipiv_active per VM to enclose 
> IPIv related operations.

Understood, but in practice all uses of vmx->ipiv_active are guarded by 
kvm_vcpu_apicv_active so they are always reached with vmx->ipiv_active 
== enable_ipiv.

The one above instead seems wrong and should just use enable_ipiv.

Paolo

