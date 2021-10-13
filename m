Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83CD42CAF2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 22:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhJMUdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhJMUc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:32:59 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FB7C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 13:30:56 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x4so2616766pln.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 13:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9PhP5LnWmjohOPZhLhBYgaCC1+YOWlPFPRo83mwbho4=;
        b=pD6OmXXBTOW/yIwpOk/KSrZNP1Ej/JZtC2voenAiJFM/cTMdoxFtIp9TIQWX1KxhyV
         FkvsndsM6qJ0f6UNMeEIa5+RkyGwqX4Mqo2y8/xLJQx3aR0oR2LT6qX4tEH4HAbLlV+8
         wdRCtnJFXWx885h/qYMAwkdbr0y2eivFuU35+Du5UnuCiwZllFelYaVFDiPGDJp9zIa/
         UjfOW+2e5uIpN3cWHLA7cSnsy1o7i7xhJnIy3t2aBNzl7Y32aY3WXa9RdZQ5zywKo+OW
         xx4M/szC3DwJ6UaXmZyRSwtIBwC/S2oIn6GvFL3AKXfoccpTCcLm/kEvI3KHpIZb8sE5
         ztbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9PhP5LnWmjohOPZhLhBYgaCC1+YOWlPFPRo83mwbho4=;
        b=Ln+Mkhi31snh5pcf2YRWrbizS6b7a0AzYzv+kXy1jcOaZMoCAgUpKek+v3HTHsqKlR
         tm+uh0s62ilw287i8nLrk/0pZpAqGj9USaCKzFt8a7D2enOSQAhS5AMJQUMuy7OXoDIs
         JGoy7Qr6YpJBELESKrWf+YSMWjqaFmdW9K1Tf5bJaiaJ8cB/ZiZ05HDG0f4ilae6pqkx
         jHLwO0PIzoGBocNknKQnLFAtlgcsS9WQnirDNncMifYnvYR3dZK4lbBKmc7QHlrl61jr
         b+/Tg/g8AdACURFfh8GQB7V9Q28u5uRXKsHUoaqx7zhh5dmB+nGeXbxMyrHVirEOCn2i
         XVZQ==
X-Gm-Message-State: AOAM533xDwk1qzJvcA1El9LIVJBDRIBdb7ppXViT+Z2LFTe84YwjHFVR
        Ko33nC5PdSeCXl5PkhxYwcsQ2w==
X-Google-Smtp-Source: ABdhPJw4oK/+Bty0UKhgmURN0ZdxnXVu7qaYKwAshIi6up10GC4QWR3UCg7c96o6OOeb0Y8RTl8XLw==
X-Received: by 2002:a17:90b:1649:: with SMTP id il9mr1575673pjb.167.1634157055245;
        Wed, 13 Oct 2021 13:30:55 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d60sm6633945pjk.49.2021.10.13.13.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 13:30:54 -0700 (PDT)
Date:   Wed, 13 Oct 2021 20:30:50 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/6] x86/split_lock: Fix the split lock #AC handling
 when running as guest
Message-ID: <YWdB+rGPWDIVzuBY@google.com>
References: <20211005230550.1819406-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005230550.1819406-7-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005230550.1819406-7-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021, Kuppuswamy Sathyanarayanan wrote:
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> If running as guest and hypervisor enables
> MSR_TEST_CTRL.SPLIT_LOCK_DETECT during its running, it can get split
> lock #AC even though sld_state is sld_off.

That's a hypervisor bug, no?  The hypervisor should never inject a fault that
the guest cannot reasonably expect.

> For kernel mode #AC, it always dies("split lock"), no more action
> needed.
> 
> For user mode #AC, it should treat sld_off (default state when feature
> is not available) as fatal as well.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/intel.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 01d7935feaed..47f0bc95ce2a 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -1190,7 +1190,12 @@ static void bus_lock_init(void)
>  
>  bool handle_user_split_lock(struct pt_regs *regs, long error_code)
>  {
> -	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
> +	/*
> +	 * In virtualization environment, it can get split lock #AC even when
> +	 * sld_off but hypervisor enables it.
> +	 * Thus only handles when sld_warn explicitly.
> +	 */
> +	if ((regs->flags & X86_EFLAGS_AC) || sld_state != sld_warn)
>  		return false;
>  	split_lock_warn(regs->ip);
>  	return true;
> -- 
> 2.25.1
> 
