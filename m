Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877F6401980
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 12:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241738AbhIFKKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 06:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241716AbhIFKKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 06:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630922966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HzNSo6ZS3uFrxA20jWLtzoSv8xjVW2nhmQ7Wv83IjVA=;
        b=C2LXMUHiJGwQLrCVI/X+hSJZ2CA7sF/MS9pQ3L1xl/PbpArhcaMbzEeHHE4YtyymLm3xyF
        Qn7hyuVGrXPIepTA/2sgJyR1ihSnb+kywtjiBHtbgjYa+r9hcnjFqIsxqAAEvtmPyzjjTv
        3vqZShmzXblbabcXl/9G8kWf5+iMXPA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-etxbxGGvMLC2ugj2Sv_wFQ-1; Mon, 06 Sep 2021 06:09:25 -0400
X-MC-Unique: etxbxGGvMLC2ugj2Sv_wFQ-1
Received: by mail-ej1-f71.google.com with SMTP id r21-20020a1709067055b02904be5f536463so2146938ejj.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 03:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HzNSo6ZS3uFrxA20jWLtzoSv8xjVW2nhmQ7Wv83IjVA=;
        b=nWM9HmB8llpxt7mO9AnBBrRXDJz1/55fvrG+Exyc4yXTEuCSny7NEn4NhffVfJXfr3
         tBPxaj/3sO4K1iuWSG8EKTa8iGUFpHOZ5LJ/N72AnhNHfp9uDuJmnsMteEn8KZD2rCQS
         hoNFBN8KpLPaTFl3Lare8RaTypul6V8CUGIPD9aBl+ahlwmUrET/+h/46401QGaA9IZc
         3HPw5OBHN14LvVwCaO4USg60EZtq60vZaxgRBJDwcqzokeBrwJIExLAiAi0OxYAmSTDu
         6Cj9fzEN0M9MJA2zQTDYrDbdZ/l9ztx85zOR66CbpfADMHMDDLfJjIpdnthiDJT1TW7O
         jk1Q==
X-Gm-Message-State: AOAM533CAU2FDRA3pilR+RD2HMCONVL7Juc6zFBZN9gCwvSr1stmo9nh
        1av88hDDy7XZpadSvcZqN51EZJ4zfp8/6BJUtcB8WVIm1RiU+HZuSSxaW4H6B+bc6L+Y1PETrPd
        d5nMZogcIZjgS8py7DO3n3IRYyfXQC6Ef7bNeL43/mJyyXDcSZX8SZxru0TcJzfRx/jiQZzFxzN
        Hf
X-Received: by 2002:a17:906:12d8:: with SMTP id l24mr12531109ejb.126.1630922964299;
        Mon, 06 Sep 2021 03:09:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzd9KbL+Acs/HYH/PjpLSyiMZlMgHJj0efCCqbwsXoqVusO8sfoN1t9OiWHp06pAKfBgPBlrw==
X-Received: by 2002:a17:906:12d8:: with SMTP id l24mr12531079ejb.126.1630922964078;
        Mon, 06 Sep 2021 03:09:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q18sm3661864ejc.84.2021.09.06.03.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 03:09:23 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: VMX: avoid running vmx_handle_exit_irqoff in
 case of emulation
To:     Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20210826095750.1650467-1-mlevitsk@redhat.com>
 <20210826095750.1650467-2-mlevitsk@redhat.com> <YSe6wphK9b8KSkXW@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a642cc28-272b-9a1f-51bb-657416e588d0@redhat.com>
Date:   Mon, 6 Sep 2021 12:09:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSe6wphK9b8KSkXW@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/21 18:01, Sean Christopherson wrote:
>> +	if (vmx->emulation_required)
>> +		return;
> Rather than play whack-a-mole with flows consuming stale state, I'd much prefer
> to synthesize a VM-Exit(INVALID_GUEST_STATE).  Alternatively, just skip ->run()
> entirely by adding hooks in vcpu_enter_guest(), but that's a much larger change
> and probably not worth the risk at this juncture.

I'm going with Maxim's patch for now (and for stable kernels especially)
but I like the


+       if (unlikely(static_call(kvm_x86_emulation_required)(vcpu)))
+               return static_call(kvm_x86_emulate_invalid_guest_state)(vcpu);
+

idea.  I'll put a Fixes for 95b5a48c4f2b ("KVM: VMX: Handle NMIs, #MCs and
async #PFs in common irqs-disabled fn", Linux 5.3).

Paolo

