Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2826B3652A0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 08:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhDTGxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 02:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229985AbhDTGxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 02:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618901563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/RHLOcD8M249MwA8TbQiobmQMiRvQB/PzoDWZSaIlRs=;
        b=Ssvubkvr/UFMkIOl99mC8y7qskAtjOy/PrAG0X4+Sqs9oa7NmUrsZNgX8yFBPQTopB9eRQ
        eAG5TZdkXc8IsCGa7fLC7Uo19Jm3DpnM07nLgwTvdNPZPQlUyYikL0huHsss3o9LOBu24f
        fjGEvaFfLYzXUjmheeo0LVUguM8BDrU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-ae4sSDMxPwGgwLxiI5IQhw-1; Tue, 20 Apr 2021 02:52:04 -0400
X-MC-Unique: ae4sSDMxPwGgwLxiI5IQhw-1
Received: by mail-ej1-f69.google.com with SMTP id j25-20020a1709060519b029037cb8ca241aso4384969eja.19
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 23:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/RHLOcD8M249MwA8TbQiobmQMiRvQB/PzoDWZSaIlRs=;
        b=FbIQxHOiVe0Cf0Al9m4ivHiwiq70DOEhSbAciMqlem51ND+/7hU5Dw0YlH4+eVHyzc
         oKJ/gKIdS8FagAd1H50na0bwfMatGWcO/oAxeMYBk4+u+hC/WXxVGXJJPoAtvdkdHg8T
         /q5AE89c+gJkaG55R5D2vqueHLnGDUpY/ntPR4SHxOdJjaaXzjpmh3oWpewkQG4WkdnG
         Egb6G9KQ2xacW6ZOjBjRvXRDRT+2kFw9BdwH698dyXeQOfwN1Wu+bk+jKSNW+OpEU6xO
         AfDSuOFDSMQk45bvUFjg0XPUf2xBnDydcrIHXQVJY6zund1FeE9USpakJLqn3vgpIMZl
         kVYw==
X-Gm-Message-State: AOAM533FUumYcaLExnhpFM5qrQb7+BC40gBLpfSL9sb6/xV/8/wZViur
        nRyn3GYn19Nva9fqllP20+pDXbeCuO8gbR12SWIKAD0jThHB7RBTX5WKxOBfUvyj7g2O03BMv/o
        fKCz/Bp9uIXsvRqoZXvHHOeM7+tYK4qTshMcUcyOLvWQFDncT7+kF3xpcROLwFqDPNlpQulpIB+
        WF
X-Received: by 2002:aa7:d615:: with SMTP id c21mr17156917edr.176.1618901522508;
        Mon, 19 Apr 2021 23:52:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZe4nQ7sV/TKik7MnccxJgmY8EXJfdk5pySAzdJqMH4GFHWmvdy8kRgIWbmaKvxr7m3t3iOw==
X-Received: by 2002:aa7:d615:: with SMTP id c21mr17156887edr.176.1618901522269;
        Mon, 19 Apr 2021 23:52:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id z14sm311068edc.62.2021.04.19.23.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 23:52:01 -0700 (PDT)
Subject: Re: Doubt regarding memory allocation in KVM
To:     Shivank Garg <shivankgarg98@gmail.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAOVCmzH4XEGMGgOpvnLU7_qW93cNit4yvb6kOV2BZNZH_8POJg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e7c9b569-a1c4-7b8f-ce47-8e3526464c60@redhat.com>
Date:   Tue, 20 Apr 2021 08:52:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAOVCmzH4XEGMGgOpvnLU7_qW93cNit4yvb6kOV2BZNZH_8POJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/21 07:45, Shivank Garg wrote:
> Hi,
> I'm learning about qemu KVM, looking into code and experimenting on
> it. I have the following doubts regarding it, I would be grateful if
> you help me to get some idea on them.
> 
> 1. I observe that KVM allocates memory to guests when it needs it but
> doesn't take it back (except for ballooning case).
> Also, the Qemu/KVM process does not free the memory even when the
> guest is rebooted. In this case,  Does the Guest VM get access to
> memory already pre-filled with some garbage from the previous run??

Yes.

> (Since the host would allocate zeroed pages to guests the first time
> it requests but after that it's up to guests). Can it be a security
> issue?

No, it's the same that happens on non-virtual machine.

> 2. How does the KVM know if GPFN (guest physical frame number) is
> backed by an actual machine frame number in host? If not mapped, then
> it faults in the host and allocates a physical frame for guests in the
> host. (kvm_mmu_page_fault)

It's all handled by Linux.  KVM only does a call to get_user_pages.  See 
functions whose name starts with hva_to_pfn in virt/kvm/kvm_main.c

Given a GPA, the GFN is simply the guest physical address minus bits 
0:11, so shifted right by 12.

Paolo

