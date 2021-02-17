Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFAD31DE80
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 18:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhBQRlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 12:41:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234554AbhBQRi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 12:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613583450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UPGAdvbPe3s8hDQD7kYYeKCejFf3hkqwhppMcQX39O8=;
        b=TbN6S8z/R44ta0lZG8hhlF5B/BzsJE8/wPs4tCEsvl/1cl57mLqQUmqfflhQOdOW1xkFxG
        BGYp0KEtBULO4IZ/DD8twNfcn+cl0VS3wFZGDFEAIjKX4m8hjVCywCtTD0DwAG/L0bxNQb
        wFmIPh05FXuHVF5K6Q7iCwTM05kYfHU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-P3BGnftBPQmz4z43xE5CBg-1; Wed, 17 Feb 2021 12:37:28 -0500
X-MC-Unique: P3BGnftBPQmz4z43xE5CBg-1
Received: by mail-wm1-f70.google.com with SMTP id t15so2327466wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 09:37:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UPGAdvbPe3s8hDQD7kYYeKCejFf3hkqwhppMcQX39O8=;
        b=poPlv1ea+8+puUo3JdkbBYvaegNN7w5DShHJgKARyWv6H6/bAPuaWaLF40eX42cC1F
         Yt+xSXScbDLGrB497ZgwMlG2YniRKlcUjfqdNs2J06aAyiq/swOuOQox6uSqgCGfN6Ee
         Mkr9XN/ecEotmO97ToEguxXl6P0Z2+Onv+UV2ImijqAOLr3hhk6BoC1JTEW03J1qt/Qb
         11e64Fa6jNiVZFEoTde97j6oJc9ljQC+cYxQ+AxJk+LyamU5AMamvWJQFRdMBlRTPKAk
         KJILTRNZdHZQB3VIv32e0h8rTb3bHJ6/UeJt6XUFtwyy2pcjF2G/h3iPa5/l1V1AakzP
         Zx1Q==
X-Gm-Message-State: AOAM5339OUkWujASerb+KczX4laJU1tjaj3GTnSADoZkKzj5mOxHWXZ9
        jAkEQWuYcQm6jCSJK4Z3YsuGYuKyUIpl0khK2b+jqwioBVXSOK2rw43UFdHuazSr1h8OQQHhwcx
        oqNFc8765ewuAqTzzqzsuMMJI
X-Received: by 2002:a1c:bbc5:: with SMTP id l188mr58825wmf.32.1613583447118;
        Wed, 17 Feb 2021 09:37:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzE1/ypz4t+gMfd5XV3rMhW1vFNWYoK+YTd/GqoJtUHKsj6mlHffXpSQ+5XtDl1Rs4O73+XjQ==
X-Received: by 2002:a1c:bbc5:: with SMTP id l188mr58817wmf.32.1613583446952;
        Wed, 17 Feb 2021 09:37:26 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i10sm6137319wrp.0.2021.02.17.09.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 09:37:26 -0800 (PST)
Subject: Re: [PATCH 4/7] KVM: nVMX: move inject_page_fault tweak to
 .complete_mmu_init
To:     Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20210217145718.1217358-1-mlevitsk@redhat.com>
 <20210217145718.1217358-5-mlevitsk@redhat.com> <YC1ShhSZ+6ST63nZ@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5a8bea9b-deb1-673a-3dc8-f08b679de4c5@redhat.com>
Date:   Wed, 17 Feb 2021 18:37:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YC1ShhSZ+6ST63nZ@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/21 18:29, Sean Christopherson wrote:
> All that being said, I'm pretty we can eliminate setting 
> inject_page_fault dynamically. I think that would yield more 
> maintainable code. Following these flows is a nightmare. The change 
> itself will be scarier, but I'm pretty sure the end result will be a lot 
> cleaner.

I had a similar reaction, though my proposal was different.

The only thing we're changing in complete_mmu_init is the page fault 
callback for init_kvm_softmmu, so couldn't that be the callback directly 
(i.e. something like context->inject_page_fault = 
kvm_x86_ops.inject_softmmu_page_fault)?  And then adding is_guest_mode 
to the conditional that is already in vmx_inject_page_fault_nested and 
svm_inject_page_fault_nested.

That said, I'm also rusty on _why_ this code is needed.  Why isn't it 
enough to inject the exception normally, and let 
nested_vmx_check_exception decide whether to inject a vmexit to L1 or an 
exception into L2?

Also, bonus question which should have been in the 5/7 changelog: are 
there kvm-unit-tests testcases that fail with npt=0, and if not could we 
write one?  [Answer: the mode_switch testcase fails, but I haven't 
checked why].


Paolo

