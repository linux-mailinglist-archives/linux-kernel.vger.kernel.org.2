Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604123F2E10
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240858AbhHTO2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhHTO2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:28:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FD9C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 07:27:29 -0700 (PDT)
Received: from zn.tnic (p200300ec2f107b003f09257bf467226c.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:7b00:3f09:257b:f467:226c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4899B1EC0587;
        Fri, 20 Aug 2021 16:27:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629469643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Y9RoDNuLVtJpK5UbLpDSjd3IdhM7OwHoEaic+l5NPos=;
        b=UpnYHQqT0kUqtHkSVLzwqWI86TpfZnjZdkDHN4xCeP96ewQmvXUnE7IbYevB5ghWJVrYzv
        8UnyRLOQffkDBFqJ5V4Hm2cKV3uU7jyfByTaNUvF7CiYxey4WROnKUHQDLJJe6fsjttT1T
        ZTpB+byEf2cfvCpl0m7URaEsKI1/n6s=
Date:   Fri, 20 Aug 2021 16:28:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/12] x86/tdx: Add protected guest support for TDX
 guest
Message-ID: <YR+78mxnKW0T9Vdv@zn.tnic>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQsNpG55v7dhFqIb@google.com>
 <9c576f24-e6de-f816-623d-408a4a2ae747@intel.com>
 <4f28fe6e-a8ce-e444-51db-d0eb564eca8f@linux.intel.com>
 <YQsX54MPVYFuLmFr@google.com>
 <ca4aa25c-7d88-9812-4852-ced3274493a8@linux.intel.com>
 <YRTTZU3Pzm/1tH9M@zn.tnic>
 <486afc0e-0396-e57b-63fe-31a8433bd603@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <486afc0e-0396-e57b-63fe-31a8433bd603@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 10:18:39AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> I can implement intel_prot_guest_has() in arch/x86/kernel/cpu/intel.c.
> And call tdx_prot_guest_has() from it.

No, you should simply implement intel_prot_guest_has() or whatever we
end up calling it and have the generic routine call it. Not two routines
- tdx_* and intel_*

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
