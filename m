Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B73239E7DC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhFGT5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhFGT5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:57:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E18EC061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 12:55:33 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i10so28292172lfj.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 12:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q6zrdvzuPcGvcKAWUCLEDQT9v0XjxsU0haFUhH9US3g=;
        b=mW3uCwFsaC64QKvn1yfjL1y9VvpaKPt6wcFn8WBQy6oc3sMKv/DFBTQM1hiUWHye7R
         mmh5zjigfBUrODbuvJaSEABSDpY58Gq4N+VASWU9cMxYcQvQsuVwjFLHgCB2ADzURdM6
         hZUy0Bi1FZJh+FvcMRu9F62zj7vZJp/AhAiZZbiIEpuzcDalEpyJTNypSM6PGW2EM0f0
         paBl0qiaaRdzqbcQLdSNXk7GYWFUK9Wd2ibk6q2vJQsoMWGQHHVDAl6sk61Qx9fpSmZH
         LglOqoLT8FnM0ZWkKmLZPtQ+8K7dmrRUGii33sskUb+pdHVvkBb0Byinhqr6QakShNRg
         J2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q6zrdvzuPcGvcKAWUCLEDQT9v0XjxsU0haFUhH9US3g=;
        b=bKArSp2mw3bZ4r4bryjTWYLQHCRnOhWcgSIAKxFbX6WfoCpE3Ym4zG9lpDv7wcR1y8
         NFsWwsn0mIhwSLVD85L1jPSCJAsxoUdexvwp3VnH6zWmcA8TTVwffIcjy5c1Wn5GabsS
         /8gfcqQPL7jJp0xiM0fF4fEI0uRgnWzwsTlZwC+JTzkmchb9ofQp+C+KIVnyZnSF/kH7
         t9KcVd0ke7r79RbTEMNVLPibRtJ123Co9vI95iAnNv/ufZUNufHh1ED7G6xeAspNEDP7
         rXxcDQtU8mMGK93xTTRG0Jp7QEIXlAIVbYCMO/ee8TFKzOHps+HgiM8HrQhCUXbEvZhL
         8TKw==
X-Gm-Message-State: AOAM532ZKSu3lvGA0byZ1FlRq77K2praAqk7zcj8Z8g7Bxm0HppF2Bko
        8KB3C1y+fXNj/TD1CVFCxwXQGg==
X-Google-Smtp-Source: ABdhPJzI8N6bzfif9SJ+dvgPrG7d8MN2S+/mXj+2/kaCzwMn8JJ46PhEslK0QKyo/xfhzoR8GQXZIA==
X-Received: by 2002:ac2:4c0a:: with SMTP id t10mr12395577lfq.401.1623095731453;
        Mon, 07 Jun 2021 12:55:31 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e20sm1883492lji.140.2021.06.07.12.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 12:55:30 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E5745101ED7; Mon,  7 Jun 2021 22:55:44 +0300 (+03)
Date:   Mon, 7 Jun 2021 22:55:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstractionn
Message-ID: <20210607195544.qlya6i5s2l2fkms2@box>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLkcIuL2qvo0hviU@zn.tnic>
 <YLkcUts9dWDkDKpY@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLkcUts9dWDkDKpY@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 08:15:46PM +0200, Borislav Petkov wrote:
> From f1e9f051c86b09fe660f49b0307bc7c6cec5e6f4 Mon Sep 17 00:00:00 2001
> From: Borislav Petkov <bp@suse.de>
> Date: Thu, 3 Jun 2021 20:03:31 +0200
> Subject: Convert sme_active()
> 
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 9c80c68d75b5..1bb9f22629fc 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -50,7 +50,6 @@ void __init mem_encrypt_free_decrypted_mem(void);
>  void __init mem_encrypt_init(void);
>  
>  void __init sev_es_init_vc_handling(void);
> -bool sme_active(void);
>  bool sev_active(void);
>  bool sev_es_active(void);
>  
> @@ -75,7 +74,6 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
>  static inline void __init sme_enable(struct boot_params *bp) { }
>  
>  static inline void sev_es_init_vc_handling(void) { }
> -static inline bool sme_active(void) { return false; }
>  static inline bool sev_active(void) { return false; }
>  static inline bool sev_es_active(void) { return false; }
>  
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index c078b0d3ab0e..1d88232146ab 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -387,7 +387,7 @@ void machine_kexec(struct kimage *image)
>  				       (unsigned long)page_list,
>  				       image->start,
>  				       image->preserve_context,
> -				       sme_active());
> +				       protected_guest_has(VM_HOST_MEM_ENCRYPT));
>  
>  #ifdef CONFIG_KEXEC_JUMP
>  	if (image->preserve_context)

I think conversions like this are wrong: relocate_kernel(), which got
called here, only knows how to deal with SME, not how to handle some
generic case.

(After a quick check, looks like all conversions in the patch are wrong
for the same reason.)

If code is written to handle a specific technology we need to stick with
a check that makes it clear. Trying to make sound generic only leads to
confusion.

Also, we have host memory encryption that doesn't require any of this
code: TME makes the ectryption transparently to OS.

Maybe it's better to take a conservative path: keep a check specific until
we find it can serve more than one HW feature?

-- 
 Kirill A. Shutemov
