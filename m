Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BD830D986
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbhBCMJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:09:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234238AbhBCMJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612354078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SrvxDfDLxZDeRFfsO00vBgZ9Ba/y5cDui2XTUBzZ7SE=;
        b=dH/17FQZZeYw4aufQK6MQt2XlufsdQEkUU06zbYYNJQX9LPu9VmXOG3bfA3f7wkZ7r9B+K
        FIOYPlSaZCksWotNccD+L85RQZNcp57zBDSwz5vVqEWxycJT8qQBZippMjBes019sdbgq1
        UtAHx24YuqivH5wu0xSIBGGwGuGwkoI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-SyjUe-29NcKZ8Te3gp8_6Q-1; Wed, 03 Feb 2021 07:07:56 -0500
X-MC-Unique: SyjUe-29NcKZ8Te3gp8_6Q-1
Received: by mail-ed1-f70.google.com with SMTP id m18so11337948edp.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:07:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SrvxDfDLxZDeRFfsO00vBgZ9Ba/y5cDui2XTUBzZ7SE=;
        b=Eb81VUUYWoUL455PcJukipGZWVMU2cfD2q4SLgGMb6blFyDz9Amw1XaV9lspK5Tlfh
         F/Y6PUzPCnE7uk586gmn4ugGvYkCsSyRIEW5jMiCdaNrVM+CHp12XHuqF93/IYwyMvMB
         1zsUJrSlXGMvfrhtgg0nL67xM+cqmRw/ZtU+T/lRqcJsR/+v5rSiuZQFg99AlyX6CRqZ
         Uk6twVA+KiEOy8P/sNXwuj+inGY50RaOQHp63ZNvEPyJgt7ydYwmiD+I0bcLwMl3gk81
         l9p/gEhmbWqQmA8QzhNpzHkxgZVu6CkQsHCcBLPVSsO9qhEP0lKctSivQC/ZVpp9vmQw
         WNbw==
X-Gm-Message-State: AOAM533ecFiTDYQZzxJLlyWopUovK25r28K1E0kT/TKoi3CBVtxw1Ox0
        2rA1aksgv3H5gV1rv1z/oYNJuO23MKQD20Yy3Y021daN63cSIK2pOWe3zBwqJ+mmsGcPT5BawkC
        iQ+qby5CtKx+mAwW01MIIh2E3
X-Received: by 2002:aa7:c682:: with SMTP id n2mr2626964edq.27.1612354075322;
        Wed, 03 Feb 2021 04:07:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwab3gwwD2lNmoJMyvUrcXBXIlmu3OP2NO56BrtfHb8dPrg5oZWPTPbqhHovoD08f1EUzfkOg==
X-Received: by 2002:aa7:c682:: with SMTP id n2mr2626934edq.27.1612354075090;
        Wed, 03 Feb 2021 04:07:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b17sm763438edv.56.2021.02.03.04.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 04:07:54 -0800 (PST)
Subject: Re: [PATCH v15 14/14] KVM: x86: Save/Restore GUEST_SSP to/from SMRAM
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        jmattson@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yu.c.zhang@linux.intel.com
References: <20210203113421.5759-1-weijiang.yang@intel.com>
 <20210203113421.5759-15-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55e43685-f4a7-b068-8d4c-931b8789f031@redhat.com>
Date:   Wed, 3 Feb 2021 13:07:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210203113421.5759-15-weijiang.yang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/21 12:34, Yang Weijiang wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 22eb6b8626a8..f63b713cd71f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8592,6 +8592,16 @@ static void enter_smm_save_state_64(struct kvm_vcpu *vcpu, char *buf)
>   
>   	for (i = 0; i < 6; i++)
>   		enter_smm_save_seg_64(vcpu, buf, i);
> +
> +	if (kvm_cet_supported()) {
> +		struct msr_data msr;
> +
> +		msr.index = MSR_KVM_GUEST_SSP;
> +		msr.host_initiated = true;
> +		/* GUEST_SSP is stored in VMCS at vm-exit. */
> +		kvm_x86_ops.get_msr(vcpu, &msr);
> +		put_smstate(u64, buf, 0x7ec8, msr.data);
> +	}
>   }
>   #endif
>   
> 

0x7ec8 is used for I/O instruction restart and auto-halt restart. 
0x7f08 is a free spot.  We should really document the KVM state save 
area format.

Paolo

