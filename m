Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D95C42ED0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 11:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbhJOJEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 05:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236345AbhJOJEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634288560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PhlIsRLo815t+m2jVfDd0ZVZoAGb7rOYgz0mDMFFLoY=;
        b=HtXIOO5bcslkKF1RKEflO70XW+oQ5aZx55hGr2p3jJ7BFMxE1wuJvt1/xs810E7Uha/0P0
        BHYSoD9fz6pTg0selOkDUrHhM+Mo8lzgZKr2kUlEACOD1BNOe+N+XWdnXX8benpWxmyNLC
        ZG6RUddvM03Zf7ufXUZzx1Njrt+zLT8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-lFqk9N0LMW-MEvBhtl78zg-1; Fri, 15 Oct 2021 05:02:39 -0400
X-MC-Unique: lFqk9N0LMW-MEvBhtl78zg-1
Received: by mail-ed1-f70.google.com with SMTP id u23-20020a50a417000000b003db23c7e5e2so7654282edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 02:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PhlIsRLo815t+m2jVfDd0ZVZoAGb7rOYgz0mDMFFLoY=;
        b=ytOyvlmK9gMlrVfnFXzhPcw6Y2tjPGsYo61EHxILqD3VA4E0B3pmaGJikInmp44S88
         mBp7+qfo2lRVWLhVw+FBBO44czhdEIvRGik0W8wTko5FEifD/zsF19oZ2FMedu0oURen
         vw1d8QK0E7/GVMQkM5xDuXXAgsSit50KWXCa1Jsiav01f9ivB+deCtQQMyVLcI5C9UJ3
         Tn1bpvcxwHQyw0q+toFl4ZAAI5IC7bvBkota83F78V1sWWjp5kvPj0atPMXRGYv0mqe8
         tDiDyHUHv0Kt7hcUqUmSmh82XWO3xomlSmDIKJB6PMgQpOeZf606gODUPSJwI7ILcYqr
         HeeQ==
X-Gm-Message-State: AOAM530b0mTXjqEiD0W7W+4s4Bj8w+FI4XtuOlHesMRAuxedZID5bI5u
        HI6jGRf1+H1X6IwNHRSuG6hJOzg/Rj8TxKl4g2MiIKjZrYS3v7sC1ezqWAp76UDrt34rC15LL9Y
        LS8/F2t9ZCFunwwC7Vvepr9V0
X-Received: by 2002:a05:6402:1157:: with SMTP id g23mr16943909edw.379.1634288557818;
        Fri, 15 Oct 2021 02:02:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjBoqUowr96DKoVb83o/A9q/NX7u5qyRXRA1DgBIXoYK9ebh5lAWp8ZEEhPoxT2B5TTbDAjQ==
X-Received: by 2002:a05:6402:1157:: with SMTP id g23mr16943848edw.379.1634288557311;
        Fri, 15 Oct 2021 02:02:37 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j21sm4003886edr.64.2021.10.15.02.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 02:02:36 -0700 (PDT)
Message-ID: <7b2c41cb-31fd-3755-dd34-86e7926f2f49@redhat.com>
Date:   Fri, 15 Oct 2021 11:02:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 0/2] KVM: x86: Revert to fix apic_hw_disabled underflow
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+9fc046ab2b0cf295a063@syzkaller.appspotmail.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20211013003554.47705-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211013003554.47705-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/21 02:35, Sean Christopherson wrote:
> Revert (mostly) a patch from the vCPU RESET cleanup that open coded some
> APIC shenanigans to avoid stuffing vcpu->arch.apic_base at vCPU creation,
> and completely overlooked the side effects on apic_hw_disabled.  I went
> for a revert as I think the original behavior is the least awful solution,
> just somewhat poorly documented.
> 
> The second patch adds WARNs to detect "overflow", where "overflow" means
> KVM incorrectly increments apic_hw_disabled.
> 
> Sean Christopherson (2):
>    Revert "KVM: x86: Open code necessary bits of kvm_lapic_set_base() at
>      vCPU RESET"
>    KVM: x86: WARN if APIC HW/SW disable static keys are non-zero on
>      unload
> 
>   arch/x86/kvm/lapic.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 

Queued for 5.15, thanks.

Paolo

