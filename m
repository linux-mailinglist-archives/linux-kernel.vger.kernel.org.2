Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAE130D957
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhBCL7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:59:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47941 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234421AbhBCL7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612353466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u9U3VSpDQSD/KsDApyXK6tPmD8iQWbI6YSpXdCHYYUY=;
        b=X/HUiZoJvKm98YdQ25FvH9g5FxnfxRhR/dqVXXn7yTdmtlkLGd/a8UakGuII2q6lhoCHdc
        HYfCo2thn2+FLZnz8F4jKc9Iy+hCSNp4RxiDMCEPBuqy+F6R65HtL1BThkZK7kpgFDRUKQ
        NFwjAaQcqqwIAbJiLt5lChIaNzA3iJo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-fi-yIYANMjSVqJyk0rNURw-1; Wed, 03 Feb 2021 06:57:44 -0500
X-MC-Unique: fi-yIYANMjSVqJyk0rNURw-1
Received: by mail-ej1-f72.google.com with SMTP id eb5so2147525ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 03:57:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u9U3VSpDQSD/KsDApyXK6tPmD8iQWbI6YSpXdCHYYUY=;
        b=oB68gS8Q/JiJcpSFcVEWQ/82WQ4ErrtTf+Pf+BWRHTn684AG4Zg2ZQUi7O/rfAIovs
         TNoOOjrY64oAgQSQScV1Xl2enIJS51GcKHwBiwG62DbHOM2aSkVdQsH9+2wCqJ6j3m9p
         K4RVWxRCOZQHlhn61mdIixtU5vyUvWvgwokbGQwlZq4uU4g7xp9h8WHBKQXHYtxeviZu
         k1RpNpHaaHIuW7RsR97f/TqPSh03GQq+kRiSHTuOVWaK+LGp9XSbplo+DtzrxjgNhlDU
         zWQkG3UKFyDYrxj1RibRiw3V2iMxUFfcgyE9jQZeJDFVtfxzcotWlTYhIJmDOfhCXwCz
         skGg==
X-Gm-Message-State: AOAM533lVE0KE+bZ35S5KcV+JcPo1f8mo+FbaCEb9zQyyDM7z+zzAHOk
        IfRIcJgWH/05vPKYfNu9TUOj14+gfB3rl1yNSOpkYdoaSXXL2Iuc575/9FTRsxgXaeB+P94a4Td
        XUZgukGdyWahXxlmhEf7JB6oP
X-Received: by 2002:a05:6402:1642:: with SMTP id s2mr2435753edx.360.1612353463638;
        Wed, 03 Feb 2021 03:57:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVkfWTIEQrO9vWCZ2vQ13K+3xHCWHXMLYnnJhZzDcuCEnWeDXkP6kDbAirVUMBgxJrne/hcQ==
X-Received: by 2002:a05:6402:1642:: with SMTP id s2mr2435745edx.360.1612353463498;
        Wed, 03 Feb 2021 03:57:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r4sm757194edv.27.2021.02.03.03.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 03:57:42 -0800 (PST)
Subject: Re: [PATCH v15 07/14] KVM: VMX: Emulate reads and writes to CET MSRs
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        jmattson@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yu.c.zhang@linux.intel.com
References: <20210203113421.5759-1-weijiang.yang@intel.com>
 <20210203113421.5759-8-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6a743d57-8128-b5db-ddc1-9dd4c4c1004e@redhat.com>
Date:   Wed, 3 Feb 2021 12:57:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210203113421.5759-8-weijiang.yang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/21 12:34, Yang Weijiang wrote:
> MSRs that are switched through XSAVES are especially annoying due to 
> the possibility of the kernel's FPU being used in IRQ context. Disable 
> IRQs and ensure the guest's FPU state is loaded when accessing such MSRs.

Good catch!  This should be in x86.h and named kvm_get/set_xsave_msr 
because it's not VMX specific.  The commit message should also be there 
as a comment.

In addition,

> +	case MSR_IA32_S_CET:
> +		if (!cet_is_control_msr_accessible(vcpu, msr_info))
> +			return 1;
> +		msr_info->data = vmcs_readl(GUEST_S_CET);
> +		break;
> +	case MSR_IA32_U_CET:
> +		if (!cet_is_control_msr_accessible(vcpu, msr_info))
> +			return 1;
> +		vmx_get_xsave_msr(msr_info);
> +		break;

these two might as well be the same "case" for symmetry with the 
handling of WRMSR.

I've fixed this up locally, since these patches will not be pushed to 
Linus until the corresponding bare metal support is there.

Paolo

