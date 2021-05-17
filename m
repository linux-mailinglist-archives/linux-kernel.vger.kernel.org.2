Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED6A383C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 20:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbhEQSjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 14:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhEQSjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 14:39:14 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8913CC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 11:37:57 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id j12so5247760pgh.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 11:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PNRZ0cmcsxxyzMWzWyZzpnT/o4DbLuhlBX+OlPacxbQ=;
        b=pKcXqriSmzSQTmgKM3uMmye3rD5o7GXX9Ksw/VXXnNbSWYn+fSFo2aTyqns/5M9epb
         sFP9MqurpViMyXB8KQATbgfTtPEpwBNOlvKbA37nLDgyVclSXD5oZwImt6PDkJAGBPww
         VkbEYCnmh9KR7HpdvMtWoZONrpVMjPB+9VZ5hmYVkNbfUsUatDgiP5DKrBo8Z/+/5rhp
         pIGVver39L9jVlBWXkl05CPs0WeHrCSzrpgtt0gGFuk+prXc2Cft3pEk+e68kop014LM
         xoX6SLykF8JRvymCMGwXNX8RtfwpeHwiMg8P1CvjgjiVBEAUyKXaAfzVQWZsD3woVR/Z
         BAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PNRZ0cmcsxxyzMWzWyZzpnT/o4DbLuhlBX+OlPacxbQ=;
        b=Vx97zR2QN7o2/ZvA3v9WdRx35A+XnYMiMNxTtkak3stuDlqNC9Tc5cFJZpuCcpjXHD
         6EHLI2E2h4lg0kyqcdOGTpVzd/kuLPIgwVFifjCRPtIEkJuxarVIg5/9YyIPsVJ+SPxl
         WJSC/I1ZXheXhlQ35MDKKF8vQMiQFP6n2tYuxx3nL6WYFHOO+fVGkPXNduoHkjb6tAcg
         4iS5q+4P2q3j2w4Oa0YVR3Bfa1Z9S24u5T5nQoopky2ty4CZqNbu0HvTSA5yDIEg2uj2
         0/w/yYRe+yDUL7/kRQwh1tUyWYVX7Xid8J3ZF0+z6VBUweWS6Q4zxVvgVMDFGiha8ANl
         3wiA==
X-Gm-Message-State: AOAM5332sZT+BWej43O91/2X6HhoRbg2t2D0SkYLUiLLf2KbkMcCKRo8
        uUGz0CQgDt60Q4PPmY3tB42jIQ==
X-Google-Smtp-Source: ABdhPJw1MM4NSYLINMyM1Rc/SIsqC73og/fFQ/RwYEGuGtqkRxMwXnbOf5wWqlaIH7k1sHnmonaUUA==
X-Received: by 2002:a63:e14:: with SMTP id d20mr892940pgl.35.1621276676955;
        Mon, 17 May 2021 11:37:56 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id x23sm135463pje.52.2021.05.17.11.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 11:37:56 -0700 (PDT)
Date:   Mon, 17 May 2021 18:37:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 26/32] x86/mm: Move force_dma_unencrypted() to common
 code
Message-ID: <YKK4AHhfv1nrYiw2@google.com>
References: <bbcb688c-5aa0-eeb1-192a-45edaccc2f32@intel.com>
 <20210512130821.7r2rtzcyjltecun7@box.shutemov.name>
 <e8886298-83fa-212e-ab3a-5e5b21a7ab6c@intel.com>
 <YJv6EWJmDYQL4Eqt@google.com>
 <c6b40305-d643-6023-907b-e6858d422a36@linux.intel.com>
 <943645b7-3974-bf05-073c-03ef4f889379@intel.com>
 <a72bce3a-d7da-c595-9456-cfda42d9cdc3@linux.intel.com>
 <YKKzCOW9u6q06E5I@google.com>
 <d5fb2565-110e-17d1-ea00-35cf4d196f1e@linux.intel.com>
 <5cc06488-09fe-17b5-077b-02c4ba9ca198@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cc06488-09fe-17b5-077b-02c4ba9ca198@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021, Dave Hansen wrote:
> On 5/17/21 11:27 AM, Kuppuswamy, Sathyanarayanan wrote:
> > On 5/17/21 11:16 AM, Sean Christopherson wrote:
> >> What generic code needs access to SEV vs. TDX? 
> >> force_dma_unencrypted() is called from generic code, but its
> >> implementation is x86 specific.
> > 
> > When the hardening the drivers for TDX usage, we will have
> > requirement to check for is_protected_guest() to add code specific to
> > protected guests. Since this will be outside arch/x86, we need common
> > framework for it.
> 
> Just remember, a "common framework" doesn't mean that it can't be backed
> by extremely arch-specific mechanisms.
> 
> For instance, there's a lot of pkey-specific code in mm/mprotect.c.  It
> still gets optimized away on x86 with all the goodness of X86_FEATUREs.

Ya, exactly.  Ideally, generic code shouldn't have to differentiate between SEV,
SEV-ES, SEV-SNP, TDX, etc..., a vanilla "bool is_protected_guest(void)" should
suffice.  Under the hood, x86's implementation for is_protected_guest() can be
boot_cpu_has() checks (if we want).
