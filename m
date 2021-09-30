Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3343F41DB4D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349934AbhI3Nnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351727AbhI3Nno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633009320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PDMqNfSKGf/ERQRj6wC7MdYJINADeGqp707yfUyPD08=;
        b=IbA0ZxEs0FVIBTPsaRzG8LRWSu9Q60Gp4OC1iaFY+zUzQZH3o0rgudQpasrKZYHhlYrS8B
        loSdMwFtgaGs2VcTJD5psAmvD1pxYxZ6Pht+Ey0f2g5JLIcsGTJzvPCP9049yVGvP2SMj7
        Q+1y1ibmDE1MpKZPIv8X2qzDuNiKLKw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-z_O8LahJMJOg81bcNwCDUQ-1; Thu, 30 Sep 2021 09:41:59 -0400
X-MC-Unique: z_O8LahJMJOg81bcNwCDUQ-1
Received: by mail-wm1-f69.google.com with SMTP id j21-20020a05600c1c1500b00300f1679e4dso4339864wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PDMqNfSKGf/ERQRj6wC7MdYJINADeGqp707yfUyPD08=;
        b=mM69IO4xlFDax9AYu0U18aTz+Av8eRayryGuvqbf9tVWcYfMHAf+4VPERl3cAoFO2q
         z5oC2cGgIkhfJhvlRD3IXKVXKkGpB4NLlVwrLHR9n9tDZLm3/Aa1pbncrSH/S1N4sPer
         u9q2WGglkGT5cfaqXG8t+J/AczfpQFXhhDF+4/AiUQS/LFVFIGFYTQ6A9eWzNm3ZptNe
         6WodA70KS+DxFrRuAIoh0VJJUbTcIs1PS02TsXdBZbeXUnAzdcnopbhBMXyjeUmtX0A+
         jnrFisCS0deLFS2zdl8Pp2wJAK60xhxkPiYMg+FaubINHgvKupGPXTkxNVVVfhRk7Xh8
         BhSg==
X-Gm-Message-State: AOAM531msgUYfwY7wyEKAAHoZYlgxyH0b5TvZXEOikGIdaB1YCmUDPK9
        Xx2zMFtFTH/bqbDiWLltEwdjDYIn6Df+0+HyWeDjNKCcWwSiwapWN+quibTbRenqiorWtDDRGHl
        pG3Ej1ZWo3XkK5uqgL/tUz/ww
X-Received: by 2002:a1c:ed1a:: with SMTP id l26mr7780440wmh.119.1633009318225;
        Thu, 30 Sep 2021 06:41:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4l2Yfv0mO85HCocdYZNYG7Bb9tAUaBu0z8GxFMLgJdjcgyHpMcnggFkyTGeyjID5O7FoAyA==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26mr7780413wmh.119.1633009318027;
        Thu, 30 Sep 2021 06:41:58 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y7sm4655050wmj.37.2021.09.30.06.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 06:41:57 -0700 (PDT)
Message-ID: <2a02b09c-785c-605d-5ab4-e2ce0f5b9e80@redhat.com>
Date:   Thu, 30 Sep 2021 15:41:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] KVM: x86: Expose Predictive Store Forwarding Disable
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     hpa@zytor.com, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tony.luck@intel.com, peterz@infradead.org,
        kyung.min.park@intel.com, wei.huang2@amd.com, jgross@suse.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <163244601049.30292.5855870305350227855.stgit@bmoger-ubuntu>
 <d1b1e0da-29f0-c443-6c86-9549bbe1c79d@redhat.com>
 <44cef2e9-2ba1-82c6-60bf-c3fe4b5ed9ff@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <44cef2e9-2ba1-82c6-60bf-c3fe4b5ed9ff@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/21 22:27, Babu Moger wrote:
> 
> On 9/28/21 11:04 AM, Paolo Bonzini wrote:
>> On 24/09/21 03:15, Babu Moger wrote:
>>>    arch/x86/include/asm/cpufeatures.h |    1 +
>>>    arch/x86/kvm/cpuid.c               |    2 +-
>>>    2 files changed, 2 insertions(+), 1 deletion(-)
>> Queued, with a private #define instead of the one in cpufeatures.h:
> Thanks Paolo. Don't we need change in guest_has_spec_ctrl_msr?

Not strictly necessary unless you expect processors to have PSFD and not 
SSBD; but yes it's cleaner.

Paolo

