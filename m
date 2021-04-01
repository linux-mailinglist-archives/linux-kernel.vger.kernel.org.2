Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1002351C5F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbhDASQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31037 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235145AbhDAR7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617299944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tB6J9Bg1LN9e67joE8P6cb1rpRW9jAPXApYd6V/ir4w=;
        b=GuDYPC1tV8ktqtro6F5yuj/4PtBghHsnacrjWzZ5dKuH+TuPcI38+yne+e4vL3e9GsK8Qa
        1C38XM6CD/6FFe3cBKMA+ZK6y8/9cIbvgs6Jwjx7wlk5+6pikzQQf4JYsMFisqc27TImPY
        JVu/4SoactJBd+lJYoe5Y29CX1H1cPg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-PZQIPihUMiuJutlqr5HqfA-1; Thu, 01 Apr 2021 08:51:49 -0400
X-MC-Unique: PZQIPihUMiuJutlqr5HqfA-1
Received: by mail-ed1-f72.google.com with SMTP id bm8so2788257edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 05:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tB6J9Bg1LN9e67joE8P6cb1rpRW9jAPXApYd6V/ir4w=;
        b=cS8dyicNt3f7WWW4aBW44VClAv/dtSbVoetjtNY5JRYClJra9+cLUwwph/WS+8zoyQ
         joPlkxqwHgtya8RtLjtDCOK0MQLd7ASf0hAoneWs6lPDjbOZIsVcY1jDmghB4d57Nv7+
         /JXdvdwOz4d40LWPgHsMCno8jOPcBb5otWQWtcE1iAMdSHH1c7ahM8D87K/QkM19Q8VE
         FDmZxMqSThQ/200wLELFBS2+B7Kjz6U+esuvSElGM9T8SJx9imsX/HXnUkRqhCvnOK6v
         de8eiSyOpAL489Gu5BdkYp2OSyh9TmT4PZxIs9uU3ATv97DV6c39w1BL3oF9BccPORXB
         JbZA==
X-Gm-Message-State: AOAM533QMNOja2Yl7I4KkRhr2YMHzUDVKmWxVSedZ5Ln86+VH7N+S+42
        K0IqHo1ctKnIw+F33bD7cukwRCEQrCyx+pE4ja8P43IeNcar0NKzH4xMif7iycgZSF7yqpPzMcW
        Iu8eW7Bz4xVWtER05BNLVFM+1
X-Received: by 2002:aa7:d0cb:: with SMTP id u11mr9657126edo.163.1617281508223;
        Thu, 01 Apr 2021 05:51:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwA4lfxUdSNn8+YAmnFxFvTxFUkkH/Qk5o21qSu282vEIncASsgENhDCq+hzeuiR8OkfduwnQ==
X-Received: by 2002:aa7:d0cb:: with SMTP id u11mr9657113edo.163.1617281508086;
        Thu, 01 Apr 2021 05:51:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y2sm2697878ejf.30.2021.04.01.05.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 05:51:47 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] KVM: x86: nSVM: fixes for SYSENTER emulation
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20210401111928.996871-1-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6acb7872-37ed-0b24-65a1-ddaa17bae6ef@redhat.com>
Date:   Thu, 1 Apr 2021 14:51:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210401111928.996871-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/21 13:19, Maxim Levitsky wrote:
> This is a result of a deep rabbit hole dive in regard to why
> currently the nested migration of 32 bit guests
> is totally broken on AMD.
> 
> It turns out that due to slight differences between the original AMD64
> implementation and the Intel's remake, SYSENTER instruction behaves a
> bit differently on Intel, and to support migration from Intel to AMD we
> try to emulate those differences away.
> 
> Sadly that collides with virtual vmload/vmsave feature that is used in nesting.
> The problem was that when it is enabled,
> on migration (and otherwise when userspace reads MSR_IA32_SYSENTER_{EIP|ESP},
> wrong value were returned, which leads to #DF in the
> nested guest when the wrong value is loaded back.
> 
> The patch I prepared carefully fixes this, by mostly disabling that
> SYSCALL emulation when we don't spoof the Intel's vendor ID, and if we do,
> and yet somehow SVM is enabled (this is a very rare edge case), then
> virtual vmload/save is force disabled.
> 
> V2: incorporated review feedback from Paulo.
> 
> Best regards,
>          Maxim Levitsky
> 
> Maxim Levitsky (2):
>    KVM: x86: add guest_cpuid_is_intel
>    KVM: nSVM: improve SYSENTER emulation on AMD
> 
>   arch/x86/kvm/cpuid.h   |  8 ++++
>   arch/x86/kvm/svm/svm.c | 99 +++++++++++++++++++++++++++---------------
>   arch/x86/kvm/svm/svm.h |  6 +--
>   3 files changed, 76 insertions(+), 37 deletions(-)
> 

Queued, thanks.

Paolo

