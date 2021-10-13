Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943B742CCE1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhJMVh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhJMVh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:37:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7C5C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:35:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634160950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Re+GdYo+PoEmEAbKGfcLHDJwoP7CVYgcXgDxf4NJBw=;
        b=OoM6NptdahaDa2tsoTZKFjkNQWyZtgJfbbkh8zsJXEsQUE08zCemPj3YGnU0eOiIgXXRZf
        x9KxGzrHQ1LeshsaM0S4MymdwsXahYxi+EVkUUEvo94cVeY83bHtnJ2ViJR/tHURZjpJek
        cGISRm84XDZNH9Ahsx8boX4a9N42zJDHiYkknhuVUgikoFt07KLQ9VQixR9awjo1y+pFpQ
        JOPxCjX71rZ+IBFcYvrGb0ufPmLAB41D8KjqeDWugkasg01SPqbDcwS8vMwVZsh0DvbwZ3
        EsUlkhMNVAUY9yddUAyVC1aeL0pW4oHj4NMHsWBqgIrmoR7W+TdpYIbtswD/MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634160950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Re+GdYo+PoEmEAbKGfcLHDJwoP7CVYgcXgDxf4NJBw=;
        b=6G5JUz6mqyvvjeprWYJviFao1fwi7F1AwiAetZE0efrQZi9BC1ZP93JbU2MDeoevffGK31
        HLOQ89UOEmYsw1AQ==
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuwamy@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 03/11] x86/cpufeatures: Add TDX Guest CPU feature
In-Reply-To: <47e707a2-9737-c518-9140-e495d60aed37@linux.intel.com>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87ee8o8xje.ffs@tglx>
 <47e707a2-9737-c518-9140-e495d60aed37@linux.intel.com>
Date:   Wed, 13 Oct 2021 23:35:49 +0200
Message-ID: <874k9k8v62.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sathyanarayanan,

On Wed, Oct 13 2021 at 14:05, Sathyanarayanan Kuppuswamy wrote:
> On 10/13/21 1:44 PM, Thomas Gleixner wrote:
>> tdx_early_init() is invoked from x86_64_start_kernel() very early in the
>> boot process __before__ is_tdx_guest() is invoked.
>>
>> So why on earth is it requried to keep those conditionals and cpuid()
>> muck around after init?
>
> is_tdx_guest() is also used by cc_platform_has() API. Please check
> the following patch [1]. cc_platform_has() will be called much earlier
> than x86_64_start_kernel() (like __startup_64() [2]).

That's just fundamentally wrong as I pointed out to Borislav already.

AMD has done it the right way.

__startup_64()
  sme_enable()

  x86_64_start_kernel()
    sme_early_init()
    copy_bootdata()
    ...

It's not that hard and we are not going to make this fundamentally
different just because Intel.

Thanks,

        tglx

