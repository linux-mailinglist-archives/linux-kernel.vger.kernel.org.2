Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008FC31DCE9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhBQQIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:08:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22207 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233740AbhBQQIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613578005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xx/3WvlTzcC3JQ0X57zlgEH5/O7A+hGnATTqDH1zbwA=;
        b=TAonOkk9yP725eCGEUbYc5xoXRFQVhUvQ1lzrqDEw2PL2BGmKWnQ03t1aOifMiWhfU8Fdu
        2bSMqDqCEC3zUTsgKTRPGlO2VGpy4xoEvlIJfm7dHtXid6/cNV7JfoAg6lDQdXwPFrcKKw
        DuVF6YcWI4yxr/B3DUf+mZ69wltsOkY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-TBdJVbDiNbSXu6hYwhuX1Q-1; Wed, 17 Feb 2021 11:06:43 -0500
X-MC-Unique: TBdJVbDiNbSXu6hYwhuX1Q-1
Received: by mail-wr1-f69.google.com with SMTP id x12so16658096wrw.21
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:06:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xx/3WvlTzcC3JQ0X57zlgEH5/O7A+hGnATTqDH1zbwA=;
        b=QcEv9I8EXwKlzP+NYDgo01xzLnDoQFYh8/tT6+8r4gtYieXd8NFyv07JIEZet4sQTx
         nbvrFXq+Uf8y4AcwbYx3jbjHdZhQCzF8l43Aij0miVbGATNu+2ntE/9pGvpKuJqsEWu1
         yTCG6CfHtOJO8h1afbRAAutSgu2/Nmk9CxOdeKzsQIS4qqCcP9THfIrm/KzKkoF6urpZ
         an92Lht9qyfkWm8ZOrBSO/pg49Dr8ygx7BOFLINBS+cLn+Hp5hRTN/P0t98bREP390xA
         e+37c0RPd6zzKcAQkWAVzP/pcPjx/wGphFX03E/H1aoKmkuE19XZA50+BzRUbn+ZFGlZ
         3gXg==
X-Gm-Message-State: AOAM53338/jvxq5kPxQiDlWTgR3n9uYkbSjRGXcy96y721hDfirRUe9J
        GIKlbMuuknCR4crczQMd+5ihj225mwDa9z8EO/zekw7qNxgsqpcyNvGmKJmXdKU5HOS5nQ0iu64
        iKEY9FBFQXiCMFR/V4n3L6TvQ
X-Received: by 2002:a1c:9a06:: with SMTP id c6mr7621487wme.140.1613578002610;
        Wed, 17 Feb 2021 08:06:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOeuR/6k5/Yu56xP0XRWEW2iDB8En4mmF4J9uPErF7EqilyJenTCKXNRiVaeCiRpw4PziTug==
X-Received: by 2002:a1c:9a06:: with SMTP id c6mr7621469wme.140.1613578002183;
        Wed, 17 Feb 2021 08:06:42 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t9sm4444132wrw.76.2021.02.17.08.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 08:06:40 -0800 (PST)
Subject: Re: [PATCH 1/7] KVM: VMX: read idt_vectoring_info a bit earlier
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20210217145718.1217358-1-mlevitsk@redhat.com>
 <20210217145718.1217358-2-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <09de977a-0275-0f4f-cf75-f45e4b5d9ca5@redhat.com>
Date:   Wed, 17 Feb 2021 17:06:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210217145718.1217358-2-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/21 15:57, Maxim Levitsky wrote:
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index b3e36dc3f164..e428d69e21c0 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6921,13 +6921,15 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  	if (unlikely((u16)vmx->exit_reason.basic == EXIT_REASON_MCE_DURING_VMENTRY))
>  		kvm_machine_check();
>  
> +	if (likely(!vmx->exit_reason.failed_vmentry))
> +		vmx->idt_vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
> +

Any reason for the if?

Paolo

