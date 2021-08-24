Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C1C3F69F2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 21:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhHXTjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 15:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhHXTjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:39:31 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BC8C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:38:46 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1144000e600dcb30086556.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:4400:e60:dcb:3008:6556])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB7821EC04D1;
        Tue, 24 Aug 2021 21:38:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629833921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ri5TEBgTA2LGbGlEqzw1BWYXpn+hiv7uMMvSWE4yd40=;
        b=e2Y8kNG1MY8XIKPZ96YXtYnIM0QtlPtW/X5/6/ItyWxYH0bhEu1yqn0ye6o6wKVjwXia2v
        GkGfI+729kSvN9mgBSSXkvm4wC+I9nJLxenTZam0ohRMdiXMgW2GeB+vfcZ/PknXVN+yBH
        AnQNPDJVhMPpXnLONOxMZO7S6alcy2U=
Date:   Tue, 24 Aug 2021 21:39:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/12] x86/tdx: Wire up KVM hypercalls
Message-ID: <YSVK5cSFGfC7dY6z@zn.tnic>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-10-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YSUfpQPvL6wsk6Ou@zn.tnic>
 <8ccbf970-fd4f-b1ea-ac85-98acfe296b00@linux.intel.com>
 <YSU6eixLyNdESBe9@zn.tnic>
 <b4742f7b-b1d8-8431-407f-f15a78a0d3f0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4742f7b-b1d8-8431-407f-f15a78a0d3f0@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 12:11:00PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> If the TDX code is complied for another hypervior, we need some config to
> disable above the above code.

Isn't that what CONFIG_KVM_GUEST is for?

Also, if they don't get used anywhere, the compiler will simply discard
them. I still don't see the need for the ifdeffery.

> Following is the error info.
> 
> WARNING: modpost: EXPORT symbol "__tdx_hypercall" [vmlinux] version
> generation failed, symbol will not be versioned.
> 
> So to fix the above issue, added tdx.h in arch/x86/include/asm/asm-prototypes.h

You need the C-style declaration of __tdx_hypercall, see

334bb7738764 ("x86/kbuild: enable modversions for symbols exported from asm")

and you can do the include without the ifdeffery.

And also state in the commit message why you're including it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
