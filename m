Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DC237165A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhECOBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230431AbhECOBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620050454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQP5f90o36Xr8pCkH+xTrPiQ9ls07TJ+JHUflRSejpM=;
        b=evmatw4O0SLfpM2gDvxj5oAAeKNIqlDwGIIri+XsiiWKZZuUHkKVJ0u1s45ij8bEZ0AhbY
        x/pM3yQmlfybIU6bVCCoiHvlPJx/EgaSsxR7coMpEN+N3mswwmpTKkMwknnlwBjxoIXLbE
        G69gc566fX5al5tQKIBDusM+ESELVcI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-NxZkN7L3OTaPMhTLjvucrw-1; Mon, 03 May 2021 10:00:51 -0400
X-MC-Unique: NxZkN7L3OTaPMhTLjvucrw-1
Received: by mail-ej1-f72.google.com with SMTP id yh1-20020a17090706e1b029038d0f848c7aso2076993ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 07:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LQP5f90o36Xr8pCkH+xTrPiQ9ls07TJ+JHUflRSejpM=;
        b=WQXCjiLJrf6aCTtpX3tELLQOBzJhb9FHltPmD1mp7aE8SU/lQXAuIGhMTIWs9uqzOj
         fL2OIWIkeJU84760XoUqdau4QH7AnnWEb8xn39QeBcG3CxOKyUyfk5JVxpidbwW3HFjt
         8FnhpGrZuWyXT9TOHdo1PEodu3gtosvsCKJoxbNg3QSSnMiDgf6nCKRjUv0710GXAwrG
         8cEEMnqwmqNcd+jnlE3yNE77omss9NpRb5pIUz7uYmtA4rkDSTITD0U6G0E5G3N/Njrs
         Txf1gCY37jMhYUuAXhWEYaOf+CWg9lJtNOTTkwHZKMXvQeyVI+GZRPSrW5jLEJZF1JVR
         NDxg==
X-Gm-Message-State: AOAM530VmpL5TzxiO9zPFyic130D4ZaZUFG20OS705r6IyqCXKfmMpmD
        qztvgxmzjaF3GE13uvCEcGkCLMisHUfXBYtcgAa9StOWD8JbvKY9LniFcUPvgzgo2l5zAthxFKd
        ypdjIzVa6d78vGemCoflh33qF
X-Received: by 2002:a50:fe03:: with SMTP id f3mr19855433edt.92.1620050450107;
        Mon, 03 May 2021 07:00:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzD6d7R6KEA+JnEqTPFmo6jf6aAbjBIWVVaZ5xSe/NHlSWTGcjof2n47qmYuEiT/PbXqWfC5A==
X-Received: by 2002:a50:fe03:: with SMTP id f3mr19855411edt.92.1620050449890;
        Mon, 03 May 2021 07:00:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k12sm12006105edo.50.2021.05.03.07.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 07:00:48 -0700 (PDT)
Subject: Re: [PATCH 4/5] KVM: nSVM: force L1's GIF to 1 when setting the
 nested state
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
 <20210503125446.1353307-5-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7d2fe4a1-9603-8bea-e7f1-fb3c24198941@redhat.com>
Date:   Mon, 3 May 2021 16:00:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210503125446.1353307-5-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/21 14:54, Maxim Levitsky wrote:
> While after a reset the GIF value is already 1,
> it doesn't have to have this value if the nested state
> is loaded later.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   arch/x86/kvm/svm/nested.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 32400cba608d..12a12ae940fa 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1314,6 +1314,9 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
>   	else
>   		svm->nested.vmcb02.ptr->save = svm->vmcb01.ptr->save;
>   
> +	/* Force L1's GIF to true */
> +	svm_set_gif(svm, true);
> +
>   	svm->nested.nested_run_pending =
>   		!!(kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING);
>   
> 

Hmm, not sure about this one.  It is possible in principle to do CLGI in 
L2 with the intercept disabled.

You need to use

svm_set_gif(svm, !!(kvm_state->flags & KVM_STATE_NESTED_GIF_SET));

instead.

Paolo

