Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A8F42346C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 01:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbhJEXYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 19:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236855AbhJEXYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 19:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633476135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qoig9YLaROF70cWSZJHtV07yNnPKNFQwM+8CJKZDvBc=;
        b=JifMz1Qa0XklK/eKSOmP+bEc22fLF6n+JROC+4hEX3DJ/1hAQ/d4g+lHy/vfcexXed9gYj
        uA2INXXVe2Yeiw9qMxSRtERGgUAWpXWT0ZrMsYvsdxw/NEGaKeTSSP7jgEW5wlS65MlqrT
        h91uU0zl3vbdbSBHwTH0cNLuBNRlB6Q=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-KuX-0oTvP-WAQN1kttQ7dg-1; Tue, 05 Oct 2021 19:22:14 -0400
X-MC-Unique: KuX-0oTvP-WAQN1kttQ7dg-1
Received: by mail-qt1-f198.google.com with SMTP id o7-20020ac86d07000000b002a69537d614so605044qtt.21
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 16:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qoig9YLaROF70cWSZJHtV07yNnPKNFQwM+8CJKZDvBc=;
        b=IRF/cTub8v/mmYV+QrQN92YXJ2CIZi3ZEKeHmcK2+hYsMwBwMdXNz8lL7VUgxSsOu/
         rDXLleWDhSdT24fUkcosII2n6+D1fBdq+n2A1irlFAsoSFbB7ICTynX1utCnMg4Ks2Kh
         1yP7r+ymOLt/aqDsUvceyHBNJ4QwH393zjECAYERM8aacTsH1zHhUCkNc9KeCfzgUjUD
         xdQAkWnzQprRrDJeMUUFtxtz2TzNfM+vgAP/6HbnLoV1Ut9Jc2rXo4A8z+cqJ4dCg5zq
         rmLFm2xF9TnuNWI4YMXWvC8PiqpqLlDebSUVmX1/T4IJUtP6oHfEEK9CQBxdXA8gJ6uX
         MVQQ==
X-Gm-Message-State: AOAM532US1GidEW6XIHxtwqf2505G+8YO9+PprIq8REzcyKs/1FYJdIP
        7/wCqLOoIauhM7LE4gi6PXp99E5bRvPSqqx8NineBQrBC7sATXl02CVY7AVh4yojHsbNIm1UhSW
        eVG5QEI9MpNm97Nd3f+pZ0nK3
X-Received: by 2002:ac8:5905:: with SMTP id 5mr22906069qty.391.1633476133608;
        Tue, 05 Oct 2021 16:22:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfQ1xUNVnffIP0WLTcPBMp+wNs/p/fBsBlIq9JrbtKSVzJX1xXGa+vwn0y+lr1jAJnDdUo4A==
X-Received: by 2002:ac8:5905:: with SMTP id 5mr22906033qty.391.1633476133396;
        Tue, 05 Oct 2021 16:22:13 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id d129sm10413270qkf.136.2021.10.05.16.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 16:22:12 -0700 (PDT)
Date:   Tue, 5 Oct 2021 16:22:09 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/11] x86/tdx: Add MSR support for TDX guest
Message-ID: <20211005232209.ozugpocq2cvx22li@treble>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-10-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211005025205.1784480-10-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:52:03PM -0700, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Use hypercall to emulate MSR read/write for TDX platform.
> 
> TDVMCALL[Instruction.RDMSR] and TDVMCALL[Instruction.WRMSR] provide MSR
> oprations.
> 
> RDMSR and WRMSR specification details can be found in
> Guest-Host-Communication Interface (GHCI) for Intel Trust Domain
> Extensions (Intel TDX) specification, sec titled "TDG.VP.
> VMCALL<Instruction.RDMSR>" and "TDG.VP.VMCALL<Instruction.WRMSR>".
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Changes since v7:
>  * Removed tdx_is_context_switched_msr() support (since the list
>    is incomplete).

This fails to build:

arch/x86/kernel/tdx.c: In function ‘tdx_write_msr_safe’:
arch/x86/kernel/tdx.c:135:22: error: implicit declaration of function ‘tdx_is_context_switched_msr’ [-Werror=implicit-function-declaration]
  135 |         WARN_ON_ONCE(tdx_is_context_switched_msr(msr));
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/bug.h:104:32: note: in definition of macro ‘WARN_ON_ONCE’
  104 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~

-- 
Josh

