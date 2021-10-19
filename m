Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482D9433CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 19:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhJSRCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 13:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234319AbhJSRCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634662818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zGvLIs148hziB4PUxgRa4SMQOneyHkfkSPS3E4B1O/U=;
        b=f1DebP4SeQSz/51ulKZ1YJsZqxxaj1hOxegGnVBUsX/wHg6NyOtO4NUkbCqYkyl9n+gDOo
        68XA4RS74mqrhT1RkGJFsta1sywNreIeCF/ZwObc8FVLtCkZ2a73spHS6Z2UfqkRU9I7nD
        LfdTfULVdz9T3k2fT01T+N+nCZyjurs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-w4gk2xbLOm2lDM3MbzcqFA-1; Tue, 19 Oct 2021 13:00:12 -0400
X-MC-Unique: w4gk2xbLOm2lDM3MbzcqFA-1
Received: by mail-ed1-f69.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso518530edj.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 10:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zGvLIs148hziB4PUxgRa4SMQOneyHkfkSPS3E4B1O/U=;
        b=Ry1X4yiCvYGxuD3AJGmjkqMRgctrscCRam/gO9yBhA9sEER08wAr/0t/E8zuynDcXW
         0dLOC8twVrMSmaks66xS1XKG+/V5+1cBaqQ0PzsESP8/KQKYtr0K4sj4NNHdiUOM+e3t
         bkIiSTTsm/yLQ8mJVWmfT1W0tp8tLEgX/3xzZ8OUuR5uyCzdmXc/kZnvbwTF+3a4MF9L
         O3rvhXaIPql/n9/DFl/+rUHRlZveSmbVtGdWdWUajueNp3gMOA9j7qk3gDqO5mgOaJI7
         DBIYwwwzqDCdMCQwORAiVxtJjDCaIi+0DcT1tHC9TQCy2Ptx/ZctNdV0VZA9/MtXMVfN
         wujw==
X-Gm-Message-State: AOAM531UacSgBH4sdMZxU+c0dsb70NI4DkIvVjv4usEbw4xVcLgGt4j1
        ri93SEXZrc64MtLlM2yKpkA3pCc/RB8rXUxR0Q+Eg2m+lF8cDX3MNLqtQev4n347TDnvJ1vU6Dp
        YZC5pXjIF9AGZLpw2rvC2xCCY
X-Received: by 2002:a17:906:cccb:: with SMTP id ot11mr38326047ejb.219.1634662810967;
        Tue, 19 Oct 2021 10:00:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVDgHSlgJMQQCpSKbI6RvbpD0gCr7VgQKsONRyAup2RQedluzTYxrKtWBegjWiO9mZ9tbj8Q==
X-Received: by 2002:a17:906:cccb:: with SMTP id ot11mr38325973ejb.219.1634662810372;
        Tue, 19 Oct 2021 10:00:10 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:8e02:b072:96b1:56d0? ([2001:b07:6468:f312:8e02:b072:96b1:56d0])
        by smtp.gmail.com with ESMTPSA id n10sm10310389ejk.86.2021.10.19.10.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 10:00:09 -0700 (PDT)
Message-ID: <39b178d0-f3aa-9bab-e142-60f917b0f707@redhat.com>
Date:   Tue, 19 Oct 2021 19:00:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 1/3] KVM: emulate: Don't inject #GP when emulating
 RDMPC if CR0.PE=0
Content-Language: en-US
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1634631160-67276-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <1634631160-67276-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/21 10:12, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> SDM mentioned that, RDPMC:
> 
>    IF (((CR4.PCE = 1) or (CPL = 0) or (CR0.PE = 0)) and (ECX indicates a supported counter))
>        THEN
>            EAX := counter[31:0];
>            EDX := ZeroExtend(counter[MSCB:32]);
>        ELSE (* ECX is not valid or CR4.PCE is 0 and CPL is 1, 2, or 3 and CR0.PE is 1 *)
>            #GP(0);
>    FI;
> 
> Let's add the CR0.PE is 1 checking to rdpmc emulate, though this isn't
> strictly necessary since it's impossible for CPL to be >0 if CR0.PE=0.

Why not just add a comment then instead?

Paolo

> Reviewed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v2 -> v3:
>   * add the missing 'S'
> v1 -> v2:
>   * update patch description
> 
>   arch/x86/kvm/emulate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 9a144ca8e146..ab7ec569e8c9 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -4213,6 +4213,7 @@ static int check_rdtsc(struct x86_emulate_ctxt *ctxt)
>   static int check_rdpmc(struct x86_emulate_ctxt *ctxt)
>   {
>   	u64 cr4 = ctxt->ops->get_cr(ctxt, 4);
> +	u64 cr0 = ctxt->ops->get_cr(ctxt, 0);
>   	u64 rcx = reg_read(ctxt, VCPU_REGS_RCX);
>   
>   	/*
> @@ -4222,7 +4223,7 @@ static int check_rdpmc(struct x86_emulate_ctxt *ctxt)
>   	if (enable_vmware_backdoor && is_vmware_backdoor_pmc(rcx))
>   		return X86EMUL_CONTINUE;
>   
> -	if ((!(cr4 & X86_CR4_PCE) && ctxt->ops->cpl(ctxt)) ||
> +	if ((!(cr4 & X86_CR4_PCE) && ctxt->ops->cpl(ctxt) && (cr0 & X86_CR0_PE)) ||
>   	    ctxt->ops->check_pmc(ctxt, rcx))
>   		return emulate_gp(ctxt, 0);
>   
> 

