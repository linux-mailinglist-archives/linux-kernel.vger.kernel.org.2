Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA3341857
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCSJb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229844AbhCSJbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616146263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYHOK4lMWpC+xS3RIkmJjIMrFZxUWa5W6Haf+gFHPEo=;
        b=ZbaBzumcn3ah7geulhQGpLnsre5yREMww26oPKfJeOU/h4ZamwJB9Knk5aOQDjlJ7EpBPH
        WU/2agKMv5TdakjkK/Jbp3oBAeXSMjfmkVyR3uVDdG6ovqhPJrZ8zfjxtpLvYGi/I1mx9C
        yse5KvNJ9JT/im51wgcSQbuZnaHwpm8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-V3QLBezwPxO4aAdQXn3CUg-1; Fri, 19 Mar 2021 05:31:01 -0400
X-MC-Unique: V3QLBezwPxO4aAdQXn3CUg-1
Received: by mail-ej1-f69.google.com with SMTP id e13so17908433ejd.21
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oYHOK4lMWpC+xS3RIkmJjIMrFZxUWa5W6Haf+gFHPEo=;
        b=aeUOwkXiNGnOxBH/XLhO+dJe5z0G+uIDEo6mIbHQAlv5eNw0UGiriT8OYAUS7lQU6k
         NHwqQnC1jr5QfcXWwWwEA0H8mRAcA4ouX9ukQUQhk15QzUhrcZlHENfivjVK+pVqN9IM
         vu4G2R7+cItS+FOr3p9Z2CsQCbrxw4uEZGPlXfDCpCPmJx2ntJ0X7IywmoCgj7f9MmzR
         QktpFpU40PaLcNEVqLLfbr7Qnfvk0dq5zGF/hFQnq7oDdCtypb6lw0SW8qJmGpMSgOEc
         Ga1Vr+A/KvSz1i7n6yAMbZxkxeT9raa7g7OLPhI8x07FbM6IquE8rIems+kego+76Xkj
         iQEQ==
X-Gm-Message-State: AOAM531xqsI3GMeYDBXgzjJ5ec2sstsbsWGbRnHXTXoTPeEZtYDQaXXj
        wJEfLhIKIewU2RPXYkTsZ9M4qTNsxzLDhGuHRsJ2FmiPk7eJkouTGmI1XJ+61N3iJHh7ot+SCNK
        FIvBOhvefr50KhXZ8uw4HAQEfqWTDpmqPQHcwU6hKgy8W3ywjslE+EiUyPHXnEC0iaaU2rzHzhH
        Qp
X-Received: by 2002:aa7:ccd7:: with SMTP id y23mr8413402edt.190.1616146260211;
        Fri, 19 Mar 2021 02:31:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNNwR4QLQrbUFsrZg4XyjREPZfV4WMGAz+2dAqPL5WGkOm3iW6Wk0Ch8wxRb+d/pQvhZM56w==
X-Received: by 2002:aa7:ccd7:: with SMTP id y23mr8413372edt.190.1616146259918;
        Fri, 19 Mar 2021 02:30:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id v8sm3688136edx.38.2021.03.19.02.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 02:30:59 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Remove unused variable rc
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1616143992-30228-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e8dc7779-346f-b63a-59d0-bc70fceeb1cb@redhat.com>
Date:   Fri, 19 Mar 2021 10:30:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1616143992-30228-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/21 09:53, Jiapeng Chong wrote:
> Fix the following coccicheck warnings:
> 
> ./arch/x86/kvm/emulate.c:4985:5-7: Unneeded variable: "rc". Return
> "X86EMUL_CONTINUE" on line 5019.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   arch/x86/kvm/emulate.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index f7970ba..8ae1e16 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -4982,8 +4982,6 @@ static unsigned imm_size(struct x86_emulate_ctxt *ctxt)
>   static int decode_imm(struct x86_emulate_ctxt *ctxt, struct operand *op,
>   		      unsigned size, bool sign_extension)
>   {
> -	int rc = X86EMUL_CONTINUE;
> -
>   	op->type = OP_IMM;
>   	op->bytes = size;
>   	op->addr.mem.ea = ctxt->_eip;
> @@ -5016,7 +5014,7 @@ static int decode_imm(struct x86_emulate_ctxt *ctxt, struct operand *op,
>   		}
>   	}
>   done:
> -	return rc;
> +	return X86EMUL_CONTINUE;
>   }
>   
>   static int decode_operand(struct x86_emulate_ctxt *ctxt, struct operand *op,
> 

Queued, thanks.

Paolo

