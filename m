Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC713348E60
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhCYKww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49207 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230151AbhCYKwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616669561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bpc7MIQzDWxL2dXyalkYoq9pW+R2aTSeVpfg3G/26SY=;
        b=KxJhd9+GqExnOCCl/3aGrqpPL6tlIkqevjzp4gCiTt/d1MQPkLk++z0G51QvQn7ks+X1fC
        zCTNJwf3YOTId/YW1EDSywjFviAbFoYLiyIP+glCD7CmBIczEWJ+fardUjjnIyRYDDNUXA
        mKWq5FjJcRqzlo+h8OrjcfJll8ZFruo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-iheQ0nTOOfyP9bo7_BMYng-1; Thu, 25 Mar 2021 06:52:37 -0400
X-MC-Unique: iheQ0nTOOfyP9bo7_BMYng-1
Received: by mail-wr1-f71.google.com with SMTP id n16so2483068wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 03:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bpc7MIQzDWxL2dXyalkYoq9pW+R2aTSeVpfg3G/26SY=;
        b=H7mHeBGXLH9DHULCYSM1l/8BIl3xLt19SVriyUOcJXgWuAxYmqkYP1oNiJHoH5uI/R
         i4PCSGhXv7+13DgpK9E3tLMxZ2Z1jzd/nxJGkJfU5X3g2YkIi39PIakyHUnsA/tiiN8K
         C19meZjmBcZaUaKrqxeXYCuiHwTDIiHjg/t0kSVg5TnZH5yoTEJtSEhMRv+3Cn/fYbWv
         +/bLOPwWXfTLocK8TgBTurJuthfzVEnOOy2jAKTFMvMSvhsJ4nsQkWEz4B4NJ+kaVNVD
         JBfAn36I6efIBca+t4SsHv7g7o4SQF09XGUpon0aBmYW78tfQjtogr/9AGFTXKP87B3o
         cXDw==
X-Gm-Message-State: AOAM532J2RV8LzLXBYgCj0TUXLkQIG8mHTCUtZKlWVx4fyrGCgvElpQg
        smaLrObPw2/lJZumCLmO5PZhhxq2EgaGiogbF08F0lE2BT02RQQGgoh5xHGTPcHxjjLL2hKAaBh
        zur+YhVV5O3mTadw31d4NWhL7
X-Received: by 2002:adf:edc3:: with SMTP id v3mr7986370wro.79.1616669556763;
        Thu, 25 Mar 2021 03:52:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsUgct9zaROKZvtJ/6Sc0qgVzQx3QyxP9sxC9MzKk2U3lH3e1Vx2J/tCBc9a2L2dFxBbcUfg==
X-Received: by 2002:adf:edc3:: with SMTP id v3mr7986338wro.79.1616669556579;
        Thu, 25 Mar 2021 03:52:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id b65sm5957962wmh.4.2021.03.25.03.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 03:52:36 -0700 (PDT)
Subject: Re: [PATCH] x86/tlb: Flush global mappings when KAISER is disabled
To:     Borislav Petkov <bp@alien8.de>, Hugh Dickins <hughd@google.com>
Cc:     Babu Moger <babu.moger@amd.com>, Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Makarand Sonare <makarandsonare@google.com>,
        Sean Christopherson <seanjc@google.com>
References: <2ca37e61-08db-3e47-f2b9-8a7de60757e6@amd.com>
 <20210311214013.GH5829@zn.tnic>
 <d3e9e091-0fc8-1e11-ab99-9c8be086f1dc@amd.com>
 <4a72f780-3797-229e-a938-6dc5b14bec8d@amd.com>
 <20210311235215.GI5829@zn.tnic>
 <ed590709-65c8-ca2f-013f-d2c63d5ee0b7@amd.com>
 <20210324212139.GN5010@zn.tnic>
 <alpine.LSU.2.11.2103241651280.9593@eggly.anvils>
 <alpine.LSU.2.11.2103241913190.10112@eggly.anvils>
 <20210325095619.GC31322@zn.tnic> <20210325102959.GD31322@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <757ba616-c2df-1ae8-5682-1059b33c78f9@redhat.com>
Date:   Thu, 25 Mar 2021 11:52:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210325102959.GD31322@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/21 11:29, Borislav Petkov wrote:
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index f5ca15622dc9..2bfa4deb8cae 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -245,12 +245,15 @@ static inline void __native_flush_tlb_single(unsigned long addr)
>   	 * ASID.  But, userspace flushes are probably much more
>   	 * important performance-wise.
>   	 *
> -	 * Make sure to do only a single invpcid when KAISER is
> -	 * disabled and we have only a single ASID.
> +	 * In the KAISER disabled case, do an INVLPG to make sure
> +	 * the mapping is flushed in case it is a global one.
>   	 */
> -	if (kaiser_enabled)
> +	if (kaiser_enabled) {
>   		invpcid_flush_one(X86_CR3_PCID_ASID_USER, addr);
> -	invpcid_flush_one(X86_CR3_PCID_ASID_KERN, addr);
> +		invpcid_flush_one(X86_CR3_PCID_ASID_KERN, addr);
> +	} else {
> +		asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
> +	}
>   }
>   
>   static inline void __flush_tlb_all(void)
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

