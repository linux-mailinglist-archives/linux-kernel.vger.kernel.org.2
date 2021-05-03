Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9912D37165C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhECODy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230431AbhECODm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620050569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0u9t3tvEwE9PLg1X8/LPO9YVPO0/W0tDSZeTY8ystLo=;
        b=Yc2tF5gIVhs5QfRSVgKrdHVP8A7jjUy0dJ5526Gzct9cT3y2HTzuYUn4M3T721g/GLQEcA
        9Ld9f2EOJYYEtxeTvUVC5G4Sy6FUVc3AveMOGBkB0wbb7BkqyQkA+O+EC0ZzKSrGzT6cVm
        BOvjQ71MlNiqijGWsrNM5hX22EmEGfU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-ZB0pIdkKOm2N50OzSGCncw-1; Mon, 03 May 2021 10:02:45 -0400
X-MC-Unique: ZB0pIdkKOm2N50OzSGCncw-1
Received: by mail-ej1-f70.google.com with SMTP id 16-20020a1709063010b029037417ca2d43so2075034ejz.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 07:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0u9t3tvEwE9PLg1X8/LPO9YVPO0/W0tDSZeTY8ystLo=;
        b=EvqKaUXOH8gkOSwe82tdGot7VQGahQpCCqCc3g08aTLXWmWgGGqjMxR/9aIecGkdAm
         U71r6Bb1v5IKrshaxPz/3/0f3DYTEA5Sggh2HOKj82UoET+ACI5EolUgN+lRXpZhoLyP
         Ag4OoV3qholN68dUBtzeW4h5h20ZgcNt46ApRSR0hW/qa1GIAgpWLdR6jqqloL0SIhTD
         Q1hHL6C7gSSv4TpLpttqxhn3Si+V3x2UPX6ACLlmJCHo3M92UINyZnnbn6eBS3xIuhkr
         IK3qGa756Q3/fY6QsKkmkvyiRawKQuR2/FpDfdU90a3NCId8gJp//GeHNxe2poF9DHD6
         fI7g==
X-Gm-Message-State: AOAM5331l4NwXOIqlNu01BE1hx5b3H9n3Lh/teBHfiR8z0A3o4XrPIsG
        FlgbsxEwvuVhf2I+xBmB+Ba15Dffp9HYALz6FQS4ApCKLXEtDkuq+glXgW1M83wLLgWks71PI9B
        QpskydTzbhOZfC1SbwJ049ELa
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr20162353edb.306.1620050564196;
        Mon, 03 May 2021 07:02:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWUYZDCgERL1OTjYaUJd6HS9FQOec6Ixn67My045GQCSLXIuz0zhigWa57++bHd7d7mVQVKQ==
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr20162332edb.306.1620050564002;
        Mon, 03 May 2021 07:02:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q12sm11490307ejy.91.2021.05.03.07.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 07:02:43 -0700 (PDT)
Subject: Re: [PATCH 5/5] KVM: nSVM: set a dummy exit reason in L1 vmcb when
 loading the nested state
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Cathy Avery <cavery@redhat.com>
References: <20210503125446.1353307-1-mlevitsk@redhat.com>
 <20210503125446.1353307-6-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a3a08464-d67c-fe71-6b2a-01b9ee58312c@redhat.com>
Date:   Mon, 3 May 2021 16:02:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210503125446.1353307-6-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/21 14:54, Maxim Levitsky wrote:
> Since the nested migration is a result of a VMRUN, this makes it
> possible to keep a warning that L1 vmcb should always have
> VMRUN exit reason when switching back to it, which
> otherwise triggers incorrectly.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

Does this fix "KVM: nSVM: If VMRUN is single-stepped, queue the #DB 
intercept in nested_svm_vmexit()"?  I don't like this, and also vmcb12 
is not initialized here (nested_load_control_from_vmcb12 is using the 
state passed in from userspace instead).

I think you should just remove the WARN instead.

Paolo

> ---
>   arch/x86/kvm/svm/nested.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 12a12ae940fa..146be4b5084b 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1338,6 +1338,12 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
>   	svm->vmcb01.ptr->save.rip = save->rip;
>   	svm->vmcb01.ptr->save.cpl = 0;
>   
> +	/*
> +	 * For consistency sake, restore the L1 exit reason
> +	 * (that happened prior to the migration) to SVM_EXIT_VMRUN.
> +	 */
> +	svm->vmcb->control.exit_code = SVM_EXIT_VMRUN;
> +
>   	nested_load_control_from_vmcb12(svm, ctl);
>   
>   	svm_switch_vmcb(svm, &svm->nested.vmcb02);
> 

