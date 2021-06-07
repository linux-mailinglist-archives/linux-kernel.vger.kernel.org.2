Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B14039E6A0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhFGS2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:28:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45502 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230314AbhFGS2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:28:01 -0400
Received: from zn.tnic (p200300ec2f0b4f0088b5a9d37dea41e8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:4f00:88b5:a9d3:7dea:41e8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 539F91EC046E;
        Mon,  7 Jun 2021 20:26:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623090369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=azms+Yk2ZETfvoS+P+DUK8+0jUupud5mBLYULKl7iGc=;
        b=ULD7Pl98JEvCjX/K6tcniNLBpm0mLFd3n7JWgE2IusVZtD2+V7E5sJwZHITYhvOGUHiHkJ
        FbpTUC8IA+uwaEVRWO/8/JAQsiVe5nZtw/d9b0ZWtjuUZIs96sFHeqPO1yqLAMo1pX0Tzr
        Db/8A7k5ZSK+WVeJbj09AXEHHeZaIf8=
Date:   Mon, 7 Jun 2021 20:26:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
 abstraction
Message-ID: <YL5kvLvCpG37zWc/@zn.tnic>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLkcIuL2qvo0hviU@zn.tnic>
 <82f9e5a9-682a-70be-e5ea-938bb742265f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82f9e5a9-682a-70be-e5ea-938bb742265f@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 11:01:05AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Why move this header outside CONFIG_INTEL_TDX_GUEST or
> CONFIG_AMD_MEM_ENCRYPT ifdef?

Because asm headers are usually included at the beginning of another,
possibly generic header. Unless you have a specially particular
reason to put them in additional guarding ifdeffery. Have a look at
include/linux/.

> This header only exists in x86 arch code. So it is better to protect
> it with x86 specific header file.

That doesn't sound like a special reason to me. And compilers are
usually very able at discarding unused symbols so I don't see a problem
with keeping all includes at the top, like it is usually done.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
