Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA0242AAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 19:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhJLRjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 13:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230268AbhJLRjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 13:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634060223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AOJ17ZDdGPcPHBUfbfFgaoz9bH3Zt0ZWlSO0prGEojs=;
        b=CJk2TeWIZa0vOYqm/KJio/lpqXMT0WNDoX1ZYqMRioKLHxMAjbD9Y5EMkrR7ck+2xEJh4r
        hSgh3stsvXB29z8dOFg6FHkB9GkiIUZUUHRgPe0ijPMlfUHKAHCnHVk20DuEdWPbZ+mxZl
        JyEdhjwvFjCdJij+21BZRBIjA66MAyY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-elW0Iok6ORmaighpnXXf2Q-1; Tue, 12 Oct 2021 13:37:01 -0400
X-MC-Unique: elW0Iok6ORmaighpnXXf2Q-1
Received: by mail-wr1-f70.google.com with SMTP id 41-20020adf812c000000b00160dfbfe1a2so12702777wrm.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 10:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AOJ17ZDdGPcPHBUfbfFgaoz9bH3Zt0ZWlSO0prGEojs=;
        b=KrvoUtRONcThuhNW0XoPOnXCDCweI6DZumwDGyXlRP+7GpE5ybCkhvLUDV1cK9H/8o
         L21qBzLU2X6XRXWJy3yeoB/iVw8g8Dv6S+Bg2FM0u7aVuKmIIwQII9Z3uDRcdr4RzOQN
         FyTYXeCmY7h1qP4+rtqX6Is8EuHnv7pVkXfO47j4fkkFdrVHvVs3P2MpdBW3K6h8upwY
         sbsxSa/QW7JhuQs9M6h8CfsfcrLhAS47WcGtnAoHZIYt1pCDECaP4IXNKKbLloOPpXmj
         wQpdpsTRc1MFxYPsyCGF/XGK22Gyr1Kgagy2BWjotLmo2M6+i6ERS6f4oYFG6mBsqHyK
         M0MA==
X-Gm-Message-State: AOAM531z+u6KenTj/zI6Nqi17wQ5zwZt7SPXspW35JB699AUZ2PHGuh6
        f/MW2eIN82KiGVQ2uYckXU4Y9k2HL7CTZ5HoEK7I/qnuuFrinUFN8Jvtsl+JafUFfnWHUFMpAzc
        mem9pfxSrjOXAJFbnK9WCl0oX
X-Received: by 2002:a05:6000:1684:: with SMTP id y4mr33729283wrd.252.1634060220547;
        Tue, 12 Oct 2021 10:37:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDEtaocwpe6emZXum3WToMWnLvX4o39ZILRi/f2mlvfjYpIs9xpZ1Gf/fxa19BtopOGMi0Rg==
X-Received: by 2002:a05:6000:1684:: with SMTP id y4mr33729260wrd.252.1634060220328;
        Tue, 12 Oct 2021 10:37:00 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p17sm11148863wro.34.2021.10.12.10.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 10:36:59 -0700 (PDT)
Message-ID: <0d222978-014a-cdcb-f8aa-5b3179cb0809@redhat.com>
Date:   Tue, 12 Oct 2021 19:36:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [patch 16/31] x86/fpu: Replace KVMs homebrewn FPU copy to user
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        kvm@vger.kernel.org
References: <20211011215813.558681373@linutronix.de>
 <20211011223611.249593446@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211011223611.249593446@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 02:00, Thomas Gleixner wrote:
> 
> -	if (boot_cpu_has(X86_FEATURE_XSAVE)) {
> -		memset(guest_xsave, 0, sizeof(struct kvm_xsave));
> -		fill_xsave((u8 *) guest_xsave->region, vcpu);
> -	} else {
> -		memcpy(guest_xsave->region,
> -			&vcpu->arch.guest_fpu->state.fxsave,
> -			sizeof(struct fxregs_state));
> -		*(u64 *)&guest_xsave->region[XSAVE_HDR_OFFSET / sizeof(u32)] =
> -			XFEATURE_MASK_FPSSE;
> -	}

After the patch, this final assignment is not done in the else case:

> +
> +	if (cpu_feature_enabled(X86_FEATURE_XSAVE)) {
> +		__copy_xstate_to_uabi_buf(mb, &kstate->xsave, pkru,
> +					  XSTATE_COPY_XSAVE);
> +	} else {
> +		memcpy(&ustate->fxsave, &kstate->fxsave, sizeof(ustate->fxsave));
> +	}
> +}

This leaves the xstate_bv set to 0 instead of XFEATURE_MASK_FPSSE. 
Resuming a VM then fails if you save on a non-XSAVE machine and restore 
it on an XSAVE machine.

The memset(guest_xsave, 0, sizeof(struct kvm_xsave)) also is not 
reproduced, you can make it unconditional for simplicity; this is not a 
fast path.

Paolo

