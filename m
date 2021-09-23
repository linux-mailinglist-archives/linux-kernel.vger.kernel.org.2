Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9CD416091
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbhIWOIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241565AbhIWOIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632406033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fZN0GBbDy9P7KAOZzoLgo28+FQMW7AjOD+Z/vyQx21c=;
        b=DrIqHvT81Dsxv21pRf12vAmkY5AwWmpgMuyJ5LYdUZjnEVweq4HCBKyjBkouL9jzUUg5Bc
        l3Zjgs0ofZkVkTAeAMvzU+YSCaFQhNgqPIj7OIBq+t/ES/pf8kYPHMmMzyajY4s+0OZWQ+
        Wfs3dhbq8+5eAFn2geqnm+QEanzvpwo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-u8d-yz7vO2Gos2NBDTsyqw-1; Thu, 23 Sep 2021 10:07:11 -0400
X-MC-Unique: u8d-yz7vO2Gos2NBDTsyqw-1
Received: by mail-wr1-f71.google.com with SMTP id r7-20020a5d6947000000b0015e0f68a63bso5211865wrw.22
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fZN0GBbDy9P7KAOZzoLgo28+FQMW7AjOD+Z/vyQx21c=;
        b=x5jHoljkkXGTatrgdj2q3nOtkYBJ4OG1bJvrQPZ+fno+Q+LZ1o0GS9DkqLjJ2bQ2Nd
         oXGLhRo3MCPSGnjQOGcEmV7hWDt2HAbKOyqDYYvKtpzuUXQYMb0HP449XLZxF1KiCIfI
         8gkFj1QCdN9R9qUkNIts82X0C1Uonje9/YqqY4WWIlXwCgZaPIHDWh5W6oDB8gksfcba
         4yy0gsURRPnHbn+dZx0EIyrmlEnYnnSbqrD7/M/zhousVsNwqRrrqZuatCNF+5iOl37j
         GrRTH5PbUZavAThAjfbUedHmbT89wEXqGXcO+BiGXGDPb59VR4SvkYt72k2/bcbt4CYn
         kQJQ==
X-Gm-Message-State: AOAM53248KnP94IjixMyvwMij4hEYW+fi7mhOtWc+PvquXjA470HTYZ/
        najIT7Ii4QbZrUIc5GFqLpSMLoisiXIA2j5hO7spEntu3xHUv5uti7PHPlQY8jza0amyUpE3lSl
        qUa1zzZyL2GxL4lUkrLMSK39a
X-Received: by 2002:a5d:4e47:: with SMTP id r7mr5443385wrt.417.1632406024115;
        Thu, 23 Sep 2021 07:07:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUQMnDy3ZVNZbHgyU+HhI4W3F+H6qWOMYVIopYfL9p7EOoewpifPSQk99Dj5T91ZZhr1pLDg==
X-Received: by 2002:a5d:4e47:: with SMTP id r7mr5443348wrt.417.1632406023916;
        Thu, 23 Sep 2021 07:07:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j20sm5534076wrb.5.2021.09.23.07.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 07:07:03 -0700 (PDT)
Subject: Re: [PATCH 05/14] KVM: x86: nSVM: don't copy virt_ext from vmcb12
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
 <20210914154825.104886-6-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4d1e6dfa-bce1-e774-286c-80b966b80e6b@redhat.com>
Date:   Thu, 23 Sep 2021 16:06:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914154825.104886-6-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/21 17:48, Maxim Levitsky wrote:
> These field correspond to features that we don't expose yet to L2
> 
> While currently there are no CVE worthy features in this field,
> if AMD adds more features to this field, that could allow guest
> escapes similar to CVE-2021-3653 and CVE-2021-3656.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   arch/x86/kvm/svm/nested.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 476e01f98035..4df59d9795b6 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -545,7 +545,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
>   		(svm->nested.ctl.int_ctl & int_ctl_vmcb12_bits) |
>   		(svm->vmcb01.ptr->control.int_ctl & int_ctl_vmcb01_bits);
>   
> -	svm->vmcb->control.virt_ext            = svm->nested.ctl.virt_ext;
>   	svm->vmcb->control.int_vector          = svm->nested.ctl.int_vector;
>   	svm->vmcb->control.int_state           = svm->nested.ctl.int_state;
>   	svm->vmcb->control.event_inj           = svm->nested.ctl.event_inj;
> 

Queued, thanks.

Paolo

