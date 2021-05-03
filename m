Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FDF371665
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhECOG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233464AbhECOGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620050725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GNPR9aetB5O6vbBVkjBt4WTSfiMRhHXQRTN0FbjXPg4=;
        b=ct8CTkXH5sOc+v4F6HRc/aCHILwepnt63b1TxarNB2e6CPifd82Zlpuhj+CQRlD0IXMBFp
        XZVhC7wdPOthFJnySnb9Mn95eUU5FH/NbXLvhCA/I6jATUhp2wvNlBsSEh/3hS6a3+uH7p
        yIoO5bQ9xtC73/8VSI9+QcehOk1wVas=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-Y29VVtkRMt68ct1rPCnBlw-1; Mon, 03 May 2021 10:05:24 -0400
X-MC-Unique: Y29VVtkRMt68ct1rPCnBlw-1
Received: by mail-ej1-f70.google.com with SMTP id bi3-20020a170906a243b02903933c4d9132so2086632ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 07:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GNPR9aetB5O6vbBVkjBt4WTSfiMRhHXQRTN0FbjXPg4=;
        b=PCRI+WW6BrRzhQsucv43Wy6Ez5XJ5bNJfOxyvb41so2QTvaWpJe88lhjaQB4wLYJYn
         +XAGLL4Qk7Uro4Mccejz7fNFNxIJyGrokBdqfxUrBgfpo/908Ob8dUKGAi3If2rDpU/0
         sRXyy1OsGa6GU0k2TrfrAZODc0ZQEmdoP9oj6RETk5zuZrUR13GQVUoOzdF/4lcQIa8C
         3BpSH3oXOgLwZ3judi/IkPTYxx+KCwXYHE9G2TQprroYzplSpx2bK4tEsF88/sdonMW3
         Hr12jl3smhePo3zFEYVAv47fk9j9TYWoVlQUmvzaoEbT8puI+WmJVbsOHONlS77iOTbM
         0ZqQ==
X-Gm-Message-State: AOAM530n6ny0mVoIuKBkXOwkPEPuefq3EnfW7cFPQr5LHGQPK7BrwClS
        VD/R1b48BYfUCuWsGENvPwxBmlj4Uy65HuH5PiZjwa/qZieaQmSUZ9PMspEhB1RiZ4ilvYPlAur
        ZRbJ9OikHihIZf8i5zXQx5s+35+0mivcu2oMWYqyc3ybzmD02ASvu1zTUkOn7mM6XIcmZqNNkrQ
        Ff
X-Received: by 2002:a17:906:4d8d:: with SMTP id s13mr16729112eju.37.1620050722933;
        Mon, 03 May 2021 07:05:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4au918keNwU9ajYzFOowIyCo1Jppz2HVvxcn98scQ414jHG95DpQAGuWs5CJ8pUcPcdDWZw==
X-Received: by 2002:a17:906:4d8d:: with SMTP id s13mr16729075eju.37.1620050722699;
        Mon, 03 May 2021 07:05:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t14sm10993993ejc.121.2021.05.03.07.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 07:05:22 -0700 (PDT)
Subject: Re: [PATCH][next] KVM: x86: Fix potential fput on a null
 source_kvm_file
To:     Colin King <colin.king@canonical.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Tempelman <natet@google.com>, kvm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210430170303.131924-1-colin.king@canonical.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d28cde2-7aff-64bb-26f4-9909344676e5@redhat.com>
Date:   Mon, 3 May 2021 16:05:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210430170303.131924-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/21 19:03, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The fget can potentially return null, so the fput on the error return
> path can cause a null pointer dereference. Fix this by checking for
> a null source_kvm_file before doing a fput.
> 
> Addresses-Coverity: ("Dereference null return")
> Fixes: 54526d1fd593 ("KVM: x86: Support KVM VMs sharing SEV context")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   arch/x86/kvm/svm/sev.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 1356ee095cd5..8b11c711a0e4 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1764,7 +1764,8 @@ int svm_vm_copy_asid_from(struct kvm *kvm, unsigned int source_fd)
>   e_source_unlock:
>   	mutex_unlock(&source_kvm->lock);
>   e_source_put:
> -	fput(source_kvm_file);
> +	if (source_kvm_file)
> +		fput(source_kvm_file);
>   	return ret;
>   }
>   
> 

Queued, thanks.

Paolo

