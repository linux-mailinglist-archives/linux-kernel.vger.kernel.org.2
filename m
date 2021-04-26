Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4008336B41C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 15:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhDZN33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 09:29:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230250AbhDZN32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619443726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0w6s9JA5RI0isSgkR+9N2p6gh0AphGNhzBqN3GnUkgk=;
        b=HxZiOzLlqWqY/cPhCZ21AQitPo44M61VUZ0XwEmvA+N3Y/0+E9qeh7dvQAE+vQHmN28STE
        n13WX0YgcQzfUtOJyUFn96BlB3A49KPDvqPUS+91Sl8D9hqEu7joEglZj1wbKrkIacIbcQ
        DyB/3mjnFo232OlD5j5KSttiv9fJ+OQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-JP-bEps_MX6PXtitUzyT9g-1; Mon, 26 Apr 2021 09:28:45 -0400
X-MC-Unique: JP-bEps_MX6PXtitUzyT9g-1
Received: by mail-ej1-f69.google.com with SMTP id gb17-20020a1709079611b029038c058a504cso1075783ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 06:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0w6s9JA5RI0isSgkR+9N2p6gh0AphGNhzBqN3GnUkgk=;
        b=TlELJn1KYu3pT2YJiuS6CzPfImZjq5JBXT78c80YohXWfqmQMQQc4gLt1hW5+h4caF
         ygbmNrqQR7cXITfHCherF/NyO6gEbSXnKiyod0gM5pfgiMhfA5HQVWmyWH1Lgf1PzB8w
         d8tEZz/SQ7/w6v5D2u71W7ZqJ+HgdSfwQjFKK4FzzjBa0MDb8n7+yvx0HPO7uai02Tlw
         arluj6NMF+UsamTBoAMsovocJpMsMk61QKmSRQLxRclUmg9gynX9XHSa8/Z20xEjN7U1
         3s9fzyRBTpk/duNS3qssrY8K1Pulz9CAvA1OcDrEGwN64E3o9fuoszJMlAbJ+4ciLNGN
         l0kg==
X-Gm-Message-State: AOAM531cPvPdnsnVHcwYdD3mwyBBqOChZAoZKlsF0PEzdwS5FYRFGzZd
        AiDqxGje+fc1Uubpruzq3MWwMOgiUBNrTZEh9uJSabTay6ynoMvUAASXZhZWAC5oVvfBNUblR9O
        uJMm47Y9ECLqCwxCRwVshsGvk
X-Received: by 2002:a17:906:6d12:: with SMTP id m18mr18622238ejr.435.1619443724116;
        Mon, 26 Apr 2021 06:28:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTAoew1cy3xv0PXLFesxN7tVtkXGTKdLFUD1tKu7GQzZWvKsNtpzG29ZVwDbpmC/gjb8duKw==
X-Received: by 2002:a17:906:6d12:: with SMTP id m18mr18622054ejr.435.1619443721952;
        Mon, 26 Apr 2021 06:28:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q25sm14448253edt.51.2021.04.26.06.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 06:28:41 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] KVM: x86: Introduce KVM_GET_SREGS2 /
 KVM_SET_SREGS2
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20210426111333.967729-1-mlevitsk@redhat.com>
 <20210426111333.967729-5-mlevitsk@redhat.com>
 <898a9b18-4578-cb9d-ece7-f45ba5b7bb89@redhat.com>
 <eeaa6c0f6efef926eb606b354052aba8cfef2c21.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <05161b6e-6d85-be14-9e30-e61cb742f6d0@redhat.com>
Date:   Mon, 26 Apr 2021 15:28:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <eeaa6c0f6efef926eb606b354052aba8cfef2c21.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/21 14:56, Maxim Levitsky wrote:
> On Mon, 2021-04-26 at 14:32 +0200, Paolo Bonzini wrote:
>> On 26/04/21 13:13, Maxim Levitsky wrote:
>>> +	if (sregs2->flags & KVM_SREGS2_FLAGS_PDPTRS_VALID) {
>>> +
>>> +		if (!is_pae_paging(vcpu))
>>> +			return -EINVAL;
>>> +
>>> +		for (i = 0 ; i < 4 ; i++)
>>> +			kvm_pdptr_write(vcpu, i, sregs2->pdptrs[i]);
>>> +
>>> +		kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
>>> +		mmu_reset_needed = 1;
>>> +	}
>>
>> I think this should also have
>>
>> 	else {
>> 		if (is_pae_paging(vcpu))
>> 			return -EINVAL;
>> 	}
> 
> 
> What about the case when we migrate from qemu that doesn't use
> this ioctl to qemu that does?

Right, that makes sense but then the "else" branch should do the same as 
KVM_SET_SREGS.  Maybe add a "load_pdptrs" bool to __set_sregs_common?

Paolo

