Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BEF39915E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFBRWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhFBRWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:22:13 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB8FC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 10:20:29 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 6so2805493pgk.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 10:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hTgajXviyW4jCxwrLt28Zvl2VnG98YwKx+ofNDCXy1Y=;
        b=LjwUd9udnDUlFrepOfnOS5znuPP4PW272SClvXK6whY8wLJcyTU/NgEJRGyDkC1ZHg
         M6sKFqqJZ0qpELrUiTgdHza78JdqTCT/nkv3ML0cmJJa2p2Kr+Nx7/DbdZJqo6nKkltH
         9doNRavy+7W+aqh6UpiPdtqRB3cxGp4hSFVxbAZgOOnX6tIRe7LvcUvHnDml6uQXX+to
         ZcHRCF9N3ZZfAbGAbrL9R6oCnQL1POdSvme2x/EcqWAhhz0MmJbbQvDJL8HkmGRx7IYC
         6KaQaQ20ipHcUdb/qzoF+2lrpWCmdAZ6wjWVTzJ0ufAJFRl+RNLGSflpDMbyYPHOoky+
         i5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hTgajXviyW4jCxwrLt28Zvl2VnG98YwKx+ofNDCXy1Y=;
        b=IYw18j/cK7j1q+4Ib9qjWRtpsEFLco6fOc08wO0I8LscWDZ6g9PCGN+WQa15aULpsU
         qvI9Khw3ZXTEqLfZTr3jdM+pHVCE9u1d/XpXRhf4b3VhLur9nN31NOzP7Dbx1DjH6h+c
         Bm8uyn33plVHuCGH8NaDMAlYoY3F2JIFjGt37zuJirOHQf3BwdRwbW7lp6YgtWFCAHvO
         RKtNPj1WljQ8eA58DUox5cm45eB9vYyWUz/EvD9JK5kPVvEqV1MHEhhrF5Rwy59xCDq6
         dmoJEwHPMgGkFKVFfqZdvK9aLDRtx4YldZO8N+mrmfSVgwbWajsD/vCWdPPY1KVcfqwh
         ax9w==
X-Gm-Message-State: AOAM532iu2+DO1dOWnx/EFR5mifcfAnNmrI89QxVFQoE2g5FJpucAnXY
        jc8OttCRetX+WiCUfAH1qbNI4A==
X-Google-Smtp-Source: ABdhPJyKJ6AaPSIBSMRBzQqhLuM9amLosRoiUHEeh8ReKsNxvZqicpNMLxXngaIU/Hpabis0swbI2Q==
X-Received: by 2002:a63:1347:: with SMTP id 7mr34643283pgt.245.1622654428875;
        Wed, 02 Jun 2021 10:20:28 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id o17sm367394pgj.25.2021.06.02.10.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 10:20:28 -0700 (PDT)
Date:   Wed, 2 Jun 2021 17:20:24 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstraction
Message-ID: <YLe92NXx1jZPtPqB@google.com>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021, Kuppuswamy Sathyanarayanan wrote:
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 9c80c68d75b5..1492b0eb29d0 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -56,6 +56,8 @@ bool sev_es_active(void);
>  
>  #define __bss_decrypted __section(".bss..decrypted")
>  
> +bool amd_protected_guest_has(unsigned long flag);


Why call one by the vendor (amd) and the other by the technology (tdx)?
sev_protected_guest_has() seems like the more logical name, e.g. if AMD CPUs
gain a new non-SEV technology then we'll have a mess.

> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index f0c1912837c8..cbfe7479f2a3 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -71,6 +71,8 @@ u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
>  u64 __tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
>  		    struct tdx_hypercall_output *out);
>  
> +bool tdx_protected_guest_has(unsigned long flag);

...

> +static inline bool protected_guest_has(unsigned long flag)
> +{
> +	if (is_tdx_guest())
> +		return tdx_protected_guest_has(flag);
> +	else if (mem_encrypt_active())

Shouldn't this be sev_active()?  mem_encrypt_active() will return true for SME,
too.

> +		return amd_protected_guest_has(flag);
> +
> +	return false;
> +}
