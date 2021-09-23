Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2F2416324
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhIWQZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:25:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56860 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242135AbhIWQZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632414238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J4nZPAKWllqHjqXlqOvmm8xru0EBr9+YJ8WeLqeKUms=;
        b=Vut9K0Fq0ZBgf894oWBFEYL9yzBObqj9082NbQWbFewYMHDzFnQgiefdnZUqvPPhpk4r8D
        Kyo5S+qR6dn+eAlvc7qbE29FSKlXZzCNz6YdEZKO5SPgkQ3GaIRyuz6aMdeMLczKRrzJH+
        6la58x2AudthaxCvDpO8JNCSQPqVhJc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-Iffcy3ArOaqk7O80FXaV2g-1; Thu, 23 Sep 2021 12:23:57 -0400
X-MC-Unique: Iffcy3ArOaqk7O80FXaV2g-1
Received: by mail-ej1-f72.google.com with SMTP id bi9-20020a170906a24900b005c74b30ff24so83469ejb.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J4nZPAKWllqHjqXlqOvmm8xru0EBr9+YJ8WeLqeKUms=;
        b=ZRKiAQEe5l9l8IigWOhEpmxjgWuxbUyIGwN7/UGqfxSItOb5RxUObjJra8PAYOxH3x
         g3cDBP4BMrNafQrCCPjsDdMw2/Cicbke3g9iJ8SZkskCn9TvnbQ4ElfiEmQUL+xtxiF7
         d6jjE6orSQKRiiZU0X8h5MoHcG4k++gQjvGoGvrTlu32CVW8okvRbXEyEGvfIjws7GWm
         uL1xp+38o8rDKN+rQCHB8H3o5PlQkIz3TdPIR3hVlzfKO+ANJ2SUxiGHPfTkyG3ZB4g4
         c09MSoB/QiruM3jX7HfdBYgVM9Mx7Z4rOk+lytfJU1Ke3zF1j1fRADQje09WwmJ+areR
         7YqA==
X-Gm-Message-State: AOAM530TtXdek8VV/OyJL8obLggpLKX05u1z2G4Ls/KBuShI+wwCcCwk
        Lyv7Es0Gr8tvsPAyfAbJFYhdZet9XQ3+e+VvNxh1ZGDm5ehpwHmZyNTwqx3w9eMncIxt+lUgkVG
        SZMdO5qIuE5l5oXj1D+BE9IuE
X-Received: by 2002:a17:906:3fc1:: with SMTP id k1mr6152581ejj.44.1632414236144;
        Thu, 23 Sep 2021 09:23:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDarQFheVOPN7xa/s+ylmVG8oqKx6eZI8L60pSWGlm0nTHdQSHbL9Z5LTTo4wLMFBb7muLoQ==
X-Received: by 2002:a17:906:3fc1:: with SMTP id k1mr6152566ejj.44.1632414235961;
        Thu, 23 Sep 2021 09:23:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id m10sm3296604ejx.76.2021.09.23.09.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:23:55 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] KVM: x86: Clean up RESET "emulation"
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
References: <20210921000303.400537-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4dedad87-a665-1ee7-8915-743926c0b719@redhat.com>
Date:   Thu, 23 Sep 2021 18:23:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210921000303.400537-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/21 02:02, Sean Christopherson wrote:
> Add dedicated helpers to emulate RESET (or at least, the parts of RESET
> that KVM actually emulates) instead of having the relevant code scattered
> throughout vcpu_create() and vcpu_reset().
> 
> Vitaly's innocuous suggestion to WARN on non-zero CR0 led to a wonderful
> bit of git archaeology after, to my complete surprise, it fired on RESET
> due to fx_init() setting CR0.ET (and XCR0.FP).
> 
> v2:
>   - Add patches to drop defunct fx_init() code.
>   - Add patch to zero CR3 at RESET/INIT.
>   - Add patch to mark all regs avail/dirty at creation, not at RESET/INIT.
>   - Add patch to WARN if CRs are non-zero at RESET. [Vitaly]
> 
> v1: https://lkml.kernel.org/r/20210914230840.3030620-1-seanjc@google.com
> 
> Sean Christopherson (10):
>    KVM: x86: Mark all registers as avail/dirty at vCPU creation
>    KVM: x86: Clear KVM's cached guest CR3 at RESET/INIT
>    KVM: x86: Do not mark all registers as avail/dirty during RESET/INIT
>    KVM: x86: Remove defunct setting of CR0.ET for guests during vCPU
>      create
>    KVM: x86: Remove defunct setting of XCR0 for guest during vCPU create
>    KVM: x86: Fold fx_init() into kvm_arch_vcpu_create()
>    KVM: VMX: Drop explicit zeroing of MSR guest values at vCPU creation
>    KVM: VMX: Move RESET emulation to vmx_vcpu_reset()
>    KVM: SVM: Move RESET emulation to svm_vcpu_reset()
>    KVM: x86: WARN on non-zero CRs at RESET to detect improper
>      initalization
> 
>   arch/x86/kvm/svm/sev.c |  6 ++--
>   arch/x86/kvm/svm/svm.c | 29 ++++++++++--------
>   arch/x86/kvm/svm/svm.h |  2 +-
>   arch/x86/kvm/vmx/vmx.c | 68 ++++++++++++++++++++----------------------
>   arch/x86/kvm/x86.c     | 44 +++++++++++++--------------
>   5 files changed, 76 insertions(+), 73 deletions(-)
> 

Queued 3-10 too now, thanks.

Paolo

