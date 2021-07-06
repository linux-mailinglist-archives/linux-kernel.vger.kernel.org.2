Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E433BD8EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhGFOvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231736AbhGFOvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=McsgxVcRwZrz3jkI4WiryERrD7OS3yQzBONl/84ETUg=;
        b=i11lPgBOs9oELUBeixNDGvEInpLk60i54f2gmzpt9Yd1gjZtVn6YPxD+kY+NDYBZRVJRYp
        5cSfe2F7dxk48T/YrgI8An+0b7o1jgPq144HL9LTDhJpswF52fGjnGjvvIYgzNcoPQMvs0
        5zD+h9iwZIckboDtkVqrCQdTp+fQnR4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-smqANdXZPDm3-Svw4PFIEg-1; Tue, 06 Jul 2021 10:48:59 -0400
X-MC-Unique: smqANdXZPDm3-Svw4PFIEg-1
Received: by mail-lj1-f199.google.com with SMTP id p9-20020a2e80490000b0290184499f2aceso1651364ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 07:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=McsgxVcRwZrz3jkI4WiryERrD7OS3yQzBONl/84ETUg=;
        b=mf1z91amk8gtBlR/3oz1K1p34j5y+gtsCb+9jdhobXmZO2aT6W7xsxyFVAIox3p1fe
         3f7xD7BlwE9e12TLK3CcNMWe5E5xZbToRd+My42MO9R7C9NTorvL+oR/FQB5/3aox2YT
         YVTqKk0sn0jwHJLL+CqemzriiSDJBzAR6z9In6KnEOJ4ZdX2I6nRLVfLak0qupLaQNIz
         rIVq5k22JOdCE3w2RtioB8P71GzE10HBk2XEkxVdW8mtypgoCo/LJNYd4azFh2EFycTP
         DRA3G3WDdJ6MK2EgJcOwp4Z9EFTaWexw4SH9nYZGEc6pCgyHMe/VBPTkwvYq4zXVZCaP
         fY4Q==
X-Gm-Message-State: AOAM530pxo4dJ14XzIb/i9s9hnztXPHkyCUmJz6VSKEvVk7Z2aOk6Ky8
        mVAgbjms6Hqh0ZzM5+DGstunEjsgoPQdeIXH7DdVmaiIxqB0jv+VodGNeroucm/V/Taj9kmYcy4
        6AbGdqkKGWTrm7PPfhnq06gpf
X-Received: by 2002:a17:906:3693:: with SMTP id a19mr9903347ejc.237.1625582561773;
        Tue, 06 Jul 2021 07:42:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwbxWvwp60kqcqhky9/mwQk1xdW/Xhxe5g5Ux3YtstsLMjGM27875BD0OAV+jSW3dCDxig/w==
X-Received: by 2002:a17:906:3693:: with SMTP id a19mr9903309ejc.237.1625582561583;
        Tue, 06 Jul 2021 07:42:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c15sm7354300edu.19.2021.07.06.07.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 07:42:40 -0700 (PDT)
Subject: Re: [RFC PATCH v2 54/69] KVM: VMX: Define VMCS encodings for shared
 EPT pointer
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
Cc:     isaku.yamahata@gmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <9d24d2d63de110962f85f66ce84250967436f96b.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <56866301-e218-fee4-1b79-2249db5a3bed@redhat.com>
Date:   Tue, 6 Jul 2021 16:42:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9d24d2d63de110962f85f66ce84250967436f96b.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:05, isaku.yamahata@intel.com wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Add the VMCS field encoding for the shared EPTP, which will be used by
> TDX to have separate EPT walks for private GPAs (existing EPTP) versus
> shared GPAs (new shared EPTP).
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/include/asm/vmx.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index 132981276a2f..56b3d32941fd 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -235,6 +235,8 @@ enum vmcs_field {
>   	ENCLS_EXITING_BITMAP_HIGH	= 0x0000202F,
>   	TSC_MULTIPLIER                  = 0x00002032,
>   	TSC_MULTIPLIER_HIGH             = 0x00002033,
> +	SHARED_EPT_POINTER		= 0x0000203C,
> +	SHARED_EPT_POINTER_HIGH		= 0x0000203D,
>   	GUEST_PHYSICAL_ADDRESS          = 0x00002400,
>   	GUEST_PHYSICAL_ADDRESS_HIGH     = 0x00002401,
>   	VMCS_LINK_POINTER               = 0x00002800,
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

