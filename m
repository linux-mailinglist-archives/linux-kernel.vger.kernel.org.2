Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99043E9FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 09:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbhHLHxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 03:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhHLHxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 03:53:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E412C061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 00:52:36 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f8300af8ada8aa61ab0b3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:8300:af8a:da8a:a61a:b0b3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD34B1EC0345;
        Thu, 12 Aug 2021 09:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628754750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eqoQdmn4KxRsRUQlKcBD5PTqyymvsP+uV2AUYXlcQQc=;
        b=nJiK3s6jHS+eK6AIJ0xA8+Ta7pItDNeTqyuTa5k+SE57Vl0/uqJ3nUsV4PhtWwCZibZFh2
        pwLsvYhNOhGbtr+L1xAXx+Q8sFJ4Dhe9NDKff+8rXKNO6znqlm0K+8u3dQX3eEjoY8/ZPP
        oVsosxtmkD9vv8zu6lLP4W0m0LArfBo=
Date:   Thu, 12 Aug 2021 09:53:09 +0200
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
Message-ID: <YRTTZU3Pzm/1tH9M@zn.tnic>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQsNpG55v7dhFqIb@google.com>
 <9c576f24-e6de-f816-623d-408a4a2ae747@intel.com>
 <4f28fe6e-a8ce-e444-51db-d0eb564eca8f@linux.intel.com>
 <YQsX54MPVYFuLmFr@google.com>
 <ca4aa25c-7d88-9812-4852-ced3274493a8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca4aa25c-7d88-9812-4852-ced3274493a8@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 04:00:18PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Boris, how do you want to proceed? Do you want me to implement intel_prot_guest_has()
> or change comparison log to TDX specific?

Yes, the idea was to have the generic call prot_guest_has() call
into the vendor one. This way each vendor is free to do whatever it
desires in its own version and callers simply need to call the generic
interface.

> > Given amd_prot_guest_has(), my guess is Boris intended intel_prot_guest_has()...

Yap, exactly.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
