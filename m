Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107A53BD7B6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 15:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhGFN0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 09:26:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231248AbhGFN0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 09:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625577840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sqq825G+li9OjVk5eaykIR+on9NrEBX7TA9mjDioEsU=;
        b=XzUfaVdd8psHMn90T6bz3eC9ZTdsxDnndbcIXPIUZ+rCHACpeYFnef++S9kU2qOrupLVuI
        kOdtLqs1iovwQxtVEeGidjcwz2U+HXOUnFH6PyiQQ7/MbxKjB220Mybi4fd0VFsxwo3+KB
        J3QtiAGzI9nZISFpXPtFWOe2zGycwtk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-tqJq4Ei8OZioB-RZITA9PQ-1; Tue, 06 Jul 2021 09:23:59 -0400
X-MC-Unique: tqJq4Ei8OZioB-RZITA9PQ-1
Received: by mail-ej1-f69.google.com with SMTP id ia10-20020a170907a06ab02904baf8000951so4215322ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 06:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sqq825G+li9OjVk5eaykIR+on9NrEBX7TA9mjDioEsU=;
        b=rD6ZgpPRviUzs7iRRazR+z5K36u4FvjICxctAGe839XKQJusglUba+LvXx8hQS9plR
         IcqMBgBM1g2kPenz1X96XMU2tgTbTw9t9V03feH+WX9EnbtS3EDbGzmhpZG3Qa13Fhdb
         xLIplXkD+lbx4eKkHnQ2HOzuFe/Vm6I0xB+5EdWLUpLjenGcRmpU8cov4RoOhRVCkHE6
         2XJwCmSvCvGyiFD/atyji2kSo7knwJDHDOd4naSUCEgLi+RdlE8LWXquQPHYMucjHQFb
         Yw2o2hvni5h+/ijsap62bHIl6bPaXLE2k9vWTG87NSxaeRomNM9zwfTowg70GL17XD04
         Owkw==
X-Gm-Message-State: AOAM531DbgJb2DxMuxFlrWxJqJk2f3PCZu0U/Cklm0jm/15um9baHzgf
        JRuMbE+AjJ0ZCgRFlaKaNuBRs4/Sl/9gMRv67kz0jvYzdXZ+zHl/Uenna7txESL0voRPm2Lcy9I
        tMipQuuT4giRixTUWMMUWkO9v
X-Received: by 2002:a17:906:2b0c:: with SMTP id a12mr11089869ejg.429.1625577838102;
        Tue, 06 Jul 2021 06:23:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpRHqxBDqgfllzawdsQdoN6ohItuD1Gz4sLZ7t9zIW0XkC+Apu6iTpuhuyoOIKoLxmFrKCxA==
X-Received: by 2002:a17:906:2b0c:: with SMTP id a12mr11089840ejg.429.1625577837885;
        Tue, 06 Jul 2021 06:23:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e2sm5733462ejt.113.2021.07.06.06.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 06:23:57 -0700 (PDT)
Subject: Re: [RFC PATCH v2 08/69] KVM: TDX: add trace point before/after TDX
 SEAMCALLs
To:     isaku.yamahata@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     isaku.yamahata@gmail.com
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <28a0ae6b767260fcb410c6ddff7de84f4e13062c.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <03a48573-85b2-f908-f058-205e9aa02787@redhat.com>
Date:   Tue, 6 Jul 2021 15:23:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <28a0ae6b767260fcb410c6ddff7de84f4e13062c.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:04, isaku.yamahata@intel.com wrote:
> +	trace_kvm_tdx_seamcall_enter(smp_processor_id(), op,
> +				     rcx, rdx, r8, r9, r10);
> +	err = __seamcall(op, rcx, rdx, r8, r9, r10, ex);
> +	if (ex)
> +		trace_kvm_tdx_seamcall_exit(smp_processor_id(), op, err, ex->rcx,
> +					    ex->rdx, ex->r8, ex->r9, ex->r10,
> +					    ex->r11);
> +	else
> +		trace_kvm_tdx_seamcall_exit(smp_processor_id(), op, err,
> +					    0, 0, 0, 0, 0, 0);

Would it make sense to do the zeroing of ex directly in __seamcall in 
case there is an error?

Otherwise looks good.

Paolo

