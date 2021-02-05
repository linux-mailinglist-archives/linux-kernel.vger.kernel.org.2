Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A1331067A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhBEIRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:17:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231682AbhBEIRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612512949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5A2n83ZDnlm1NkFFw8bns49S50xt4DIpYPGWdbWm6fs=;
        b=UMBb+IW0qNkE8R2VZnCJOXFsdsnDAv89tCypQaf9BJ6qmDflUZj7nG10IYvtfoXq4sc0yr
        s5/BYkl6bhEGAIExR/UUoPgF/V/yQ8b+U7rKyLnOAkkHCkGQd2yyJY0etdcwGLkVrKuXwi
        9LGiGayWpdZyyUZHaSyjHTHTWMeZClM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-qc-9pHu1MUmTGraXvowhdQ-1; Fri, 05 Feb 2021 03:15:48 -0500
X-MC-Unique: qc-9pHu1MUmTGraXvowhdQ-1
Received: by mail-ed1-f69.google.com with SMTP id ay16so6429758edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 00:15:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5A2n83ZDnlm1NkFFw8bns49S50xt4DIpYPGWdbWm6fs=;
        b=I3LJgr6e8mM+ricENqBou25nSY/rJlvJIg0bQI5x4sMk911/mtke3Qe0Md2JMWLg/W
         0LYhULCxYbwY88FDSa3xqZYMm7YHQ+A8j4j0i1NNmwaTBO9tmrrb4jEGLGYU1HAVrN6Y
         rBNNdDRPN+KdDwQC4W8vpvVWQ4KGlD6jtvgLrc34A/xKRuFaxYxil2QibrMRaimeS9IR
         POADWSqhN6+Uv0Bm4yLOYCeNkOh/hxo5E1dNq5WnSdNF8Yrgz03UNhXJLSaJ7YY892SP
         m5A2gV39b2eK65eH2Yz0jiQ0cCvXEy1MzntDH3yCdUeefLfXIqsHF0H7yioF4uZcy1wG
         HO0Q==
X-Gm-Message-State: AOAM530FUAIcCmEXc7voQnswUMZ54D7EBIwmtNzqebV7hwU0eDdluP8G
        9T1Cpsd5Thge8fQfdwfdqvtmKaavWSgyijt+DQa8AWAjUy3UtSIMzYNiDTnwMhZITwHqOiPUbad
        dgV8M8di4BFHUSu0Ts5AHp9WDHj968KixGchqoRIE8b3eTllW/6grZPTkbRza9dOMpavWIPwnro
        sS
X-Received: by 2002:aa7:d2d2:: with SMTP id k18mr2501886edr.222.1612512946086;
        Fri, 05 Feb 2021 00:15:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeaKAF6aBanEvGHcCd7fxNJFLUULphXfvk9kbURBuLZvf1nOmdWlO/GtUMsm7nvs6507ZdlQ==
X-Received: by 2002:aa7:d2d2:: with SMTP id k18mr2501864edr.222.1612512945903;
        Fri, 05 Feb 2021 00:15:45 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c1sm2270549eja.81.2021.02.05.00.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 00:15:45 -0800 (PST)
Subject: Re: [PATCH 2/2] KVM: x86: Restore all 64 bits of DR6 and DR7 during
 RSM on x86-64
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210205012458.3872687-1-seanjc@google.com>
 <20210205012458.3872687-3-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ed4e33e-191d-1ee9-eee5-1c5a8a553b41@redhat.com>
Date:   Fri, 5 Feb 2021 09:15:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210205012458.3872687-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/21 02:24, Sean Christopherson wrote:
> Restore the full 64-bit values of DR6 and DR7 when emulating RSM on
> x86-64, as defined by both Intel's SDM and AMD's APM.
> 
> Note, bits 63:32 of DR6 and DR7 are reserved, so this is a glorified nop
> unless the SMM handler is poking into SMRAM, which it most definitely
> shouldn't be doing since both Intel and AMD list the DR6 and DR7 fields
> as read-only.
> 
> Fixes: 660a5d517aaa ("KVM: x86: save/load state on SMM switch")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/emulate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 2e6e6c39922f..72a1bd04dfe1 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -2564,12 +2564,12 @@ static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
>   	ctxt->_eip   = GET_SMSTATE(u64, smstate, 0x7f78);
>   	ctxt->eflags = GET_SMSTATE(u32, smstate, 0x7f70) | X86_EFLAGS_FIXED;
>   
> -	val = GET_SMSTATE(u32, smstate, 0x7f68);
> +	val = GET_SMSTATE(u64, smstate, 0x7f68);
>   
>   	if (ctxt->ops->set_dr(ctxt, 6, val))
>   		return X86EMUL_UNHANDLEABLE;
>   
> -	val = GET_SMSTATE(u32, smstate, 0x7f60);
> +	val = GET_SMSTATE(u64, smstate, 0x7f60);
>   
>   	if (ctxt->ops->set_dr(ctxt, 7, val))
>   		return X86EMUL_UNHANDLEABLE;
> 

Queued, thanks.

Paolo

