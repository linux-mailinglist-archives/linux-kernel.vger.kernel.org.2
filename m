Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5445326385
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhBZNr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:47:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229449AbhBZNrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614347188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rm+gaRysO+Q0MRGvbQQd8H4P5JQmbKXbT2WFf0jpCCw=;
        b=HbFQhN+HC7r3P/zmQhU/FuyRi2j3BlGvZ7NCbMHe+fg4P5MBqodn76ALlivQS+KuLA5mtO
        Zcn4FnwQwZB9AkxyDAaryIgNQZ5Srmmc7WjupuUKzc5ShFMU4XIloyoNFStVyb7+EH1twi
        kD7oV2ZyMw2FYuSWgozboQ6mMDEeAtE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-icvR8qUMMK6VY2DW6eylCw-1; Fri, 26 Feb 2021 08:46:27 -0500
X-MC-Unique: icvR8qUMMK6VY2DW6eylCw-1
Received: by mail-wr1-f71.google.com with SMTP id b15so3103266wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 05:46:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rm+gaRysO+Q0MRGvbQQd8H4P5JQmbKXbT2WFf0jpCCw=;
        b=bmXZXFY/Q7zDS6egWeczQyx6mfPLzQ86EmbIFTW/toHciq6KJJ3p5g6erh9y7oL1WR
         zjNMggidNfRgtdrFYbqyluSjFBkvL/kYGBPCN0MusgW4EYPrM+ehGYso+3reE3YOK9an
         IOI3fUc+5LFK2QCxhaUxcsryKaWi9br7kZN37XARiPvSw29NHG61er+1jXyYEVf4Blyo
         RJYv/g4J5DuDLevbD0D7RH2ogCgxe9Doz/N6hB9JOrt3/DzO6NaDPx65w3Y3EamrKDh1
         s3PjI1WKVo6kcZSVq5MgyoHxNIQx6m80pNA8Qto8XvaljN/Di15PspGH5YhJGcl97qDu
         jrCg==
X-Gm-Message-State: AOAM5306P+SCZt0+KWzvWukMFNJC2c28uch0SGtIUNHs6Tip//aI3p34
        j9yrIj1BKzyMRbRbrsIK91W1C3pxiCMkETuXcJgBX1xZAZ+BJ9kFvEXfZj06k1kGn3Aj3xw2LOs
        9O8ApYMZ/A1+vheHeEzxkEVGq
X-Received: by 2002:a1c:9d15:: with SMTP id g21mr2993969wme.51.1614347185631;
        Fri, 26 Feb 2021 05:46:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZYB+s+PtIvVNix5yGaQoSxNxfM/IeW5wxxMlOHeTqdtyd1fHf6YnaFVy7wGeuzMEEI0tUDw==
X-Received: by 2002:a1c:9d15:: with SMTP id g21mr2993950wme.51.1614347185414;
        Fri, 26 Feb 2021 05:46:25 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r20sm11829566wmd.18.2021.02.26.05.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 05:46:24 -0800 (PST)
Subject: Re: [PATCH] KVM/SVM: Move vmenter.S exception fixups out of line
To:     Uros Bizjak <ubizjak@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>
References: <20210226125621.111723-1-ubizjak@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <87d6caab-7982-13ee-20a2-8ed69d448ca0@redhat.com>
Date:   Fri, 26 Feb 2021 14:46:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210226125621.111723-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/21 13:56, Uros Bizjak wrote:
> Avoid jump by moving exception fixups out of line.
> 
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>   arch/x86/kvm/svm/vmenter.S | 35 ++++++++++++++++++++---------------
>   1 file changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
> index 343108bf0f8c..4fa17df123cd 100644
> --- a/arch/x86/kvm/svm/vmenter.S
> +++ b/arch/x86/kvm/svm/vmenter.S
> @@ -80,15 +80,9 @@ SYM_FUNC_START(__svm_vcpu_run)
>   	/* Enter guest mode */
>   	sti
>   
> -3:	vmrun %_ASM_AX
> -	jmp 5f
> -4:	cmpb $0, kvm_rebooting
> -	jne 5f
> -	ud2
> -	_ASM_EXTABLE(3b, 4b)
> +1:	vmrun %_ASM_AX
>   
> -5:
> -	cli
> +2:	cli
>   
>   #ifdef CONFIG_RETPOLINE
>   	/* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET! */
> @@ -155,6 +149,13 @@ SYM_FUNC_START(__svm_vcpu_run)
>   #endif
>   	pop %_ASM_BP
>   	ret
> +
> +3:	cmpb $0, kvm_rebooting
> +	jne 2b
> +	ud2
> +
> +	_ASM_EXTABLE(1b, 3b)
> +
>   SYM_FUNC_END(__svm_vcpu_run)
>   
>   /**
> @@ -174,18 +175,15 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
>   #endif
>   	push %_ASM_BX
>   
> -	/* Enter guest mode */
> +	/* Move @vmcb to RAX. */
>   	mov %_ASM_ARG1, %_ASM_AX
> +
> +	/* Enter guest mode */
>   	sti
>   
>   1:	vmrun %_ASM_AX
> -	jmp 3f
> -2:	cmpb $0, kvm_rebooting
> -	jne 3f
> -	ud2
> -	_ASM_EXTABLE(1b, 2b)
>   
> -3:	cli
> +2:	cli
>   
>   #ifdef CONFIG_RETPOLINE
>   	/* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET! */
> @@ -205,4 +203,11 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
>   #endif
>   	pop %_ASM_BP
>   	ret
> +
> +3:	cmpb $0, kvm_rebooting
> +	jne 2b
> +	ud2
> +
> +	_ASM_EXTABLE(1b, 3b)
> +
>   SYM_FUNC_END(__svm_sev_es_vcpu_run)
> 

Queued, thanks.

Paolo

