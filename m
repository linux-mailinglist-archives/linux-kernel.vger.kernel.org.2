Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75771416084
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbhIWOH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21908 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241567AbhIWOHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632405951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I61BRjMeqtBhdStSHIPW3/cYSD2YUvHTtLYDBjO5ZPg=;
        b=EGQzi3wAjcIYzM9W2FsuXNEkBWa/hx/XyvSoGAuO02A01b6kwQDYJbQm6/Abcsxr5iGHK0
        qc9VeU5Ajn8D6xfORNyV2Wux58RlqyAKp3TVqS6JPjbvK1B/QQlyJEHz9xcRIGMxq85Urc
        ldgOaxbYPkAnjqnff1SDWhYiDU0G6vU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-7oIQipXnNMCfIT7ZyIEFLw-1; Thu, 23 Sep 2021 10:05:50 -0400
X-MC-Unique: 7oIQipXnNMCfIT7ZyIEFLw-1
Received: by mail-wr1-f70.google.com with SMTP id f7-20020a5d50c7000000b0015e288741a4so5237516wrt.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I61BRjMeqtBhdStSHIPW3/cYSD2YUvHTtLYDBjO5ZPg=;
        b=ULfw3BwWBuZNX3+AXkBa6fZu6OAyf5aFxQoZAhiHVbFpd64U76cedxv0rPRGMY0JIk
         6KpIlwf7OcCsQrKF1AIe7G6xHgDISTORnH0ArivLvQbdId9B8ugZat5bd9qXZniozZTZ
         /Yp3ap0Tv9Hn+YwHQx/67GsOnT/bl7yqVcP65jb9jCcDxbjZ7b2nn8XwK8stuIldyIzL
         RMyjiY5NxwqblbTou1vCIDBtH9IuR1L3+GzO2GFtKzo1DCQ04Uef9FuxTKMQM9t9WGhI
         WNDsofD69ECUjXWg+ne/HWfJfG4nc4C+M6ISyvfW7xF+dXWrn5cxub2C3VBXWzCMS3Dx
         OaLg==
X-Gm-Message-State: AOAM530sBfsqx460l5zWPrvv9vPa7K+WGCufILUQhTay9LZl28oamf73
        3RvIYgRhlAj7r+QcZ+ys4MflO5k4/9q2pbb5LG9lJYZ1AjjBNQHaPZ4t4zO0JQ7BjpymOR5t1Z6
        o0z4rHjy9LmfQJpvimPO4UreN
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr4627948wmb.112.1632405949070;
        Thu, 23 Sep 2021 07:05:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBO+kcR3MMr9vXzqpgSTE2fqf1eRRmNCeq1QHKJ3qEXiRHRA8kfVeFeyBm7fUDExvf0mXVQQ==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr4627927wmb.112.1632405948843;
        Thu, 23 Sep 2021 07:05:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id 25sm10735912wmo.9.2021.09.23.07.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 07:05:48 -0700 (PDT)
Subject: Re: [PATCH 03/14] KVM: x86: nSVM: test eax for 4K alignment for GP
 errata workaround
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Bandan Das <bsd@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Wei Huang <wei.huang2@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>
References: <20210914154825.104886-1-mlevitsk@redhat.com>
 <20210914154825.104886-4-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <59d45b27-9191-4136-929a-a7826ac891d8@redhat.com>
Date:   Thu, 23 Sep 2021 16:05:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914154825.104886-4-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/21 17:48, Maxim Levitsky wrote:
> GP SVM errata workaround made the #GP handler always emulate
> the SVM instructions.
> 
> However these instructions #GP in case the operand is not 4K aligned,
> but the workaround code didn't check this and we ended up
> emulating these instructions anyway.
> 
> This is only an emulation accuracy check bug as there is no harm for
> KVM to read/write unaligned vmcb images.
> 
> Fixes: 82a11e9c6fa2 ("KVM: SVM: Add emulation support for #GP triggered by SVM instructions")
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   arch/x86/kvm/svm/svm.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index b2e710a3fff6..6645542df9bd 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2224,6 +2224,10 @@ static int gp_interception(struct kvm_vcpu *vcpu)
>   	if (error_code)
>   		goto reinject;
>   
> +	/* All SVM instructions expect page aligned RAX */
> +	if (svm->vmcb->save.rax & ~PAGE_MASK)
> +		goto reinject;
> +
>   	/* Decode the instruction for usage later */
>   	if (x86_decode_emulated_instruction(vcpu, 0, NULL, 0) != EMULATION_OK)
>   		goto reinject;
> 


Queued, thanks.

Paolo

