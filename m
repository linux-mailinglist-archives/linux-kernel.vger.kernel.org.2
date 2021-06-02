Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC107399289
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhFBSbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBSbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:31:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2384C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 11:29:28 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f0e00ae3ef7328f799462.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:e00:ae3e:f732:8f79:9462])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 533BF1EC047D;
        Wed,  2 Jun 2021 20:29:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622658567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JcCqV66/MI6K2z/mFaHnloQLOn8x1Hqpj91uv1miXQ8=;
        b=kYgOZ7M6ZODQfPl84NJOzDeFnm6eovmiQQ7XgE0NysQGCQwLGbzdFPi7xpqm9WJgFkawKe
        Yv3m7J7tpdPAwL9NTNmmDWT3XkXBzjZOjeW46hML4RR2QSi/FKjbcmkBQmJ93bqhxciJN4
        3eBRureI2iskTOdBImXTkT3HX44uDe8=
Date:   Wed, 2 Jun 2021 20:29:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstraction
Message-ID: <YLfOApYdX/KL1wKF@zn.tnic>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLe92NXx1jZPtPqB@google.com>
 <3036a655-9d09-0f04-62a2-7a72ba9af5c7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3036a655-9d09-0f04-62a2-7a72ba9af5c7@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 01:15:23PM -0500, Tom Lendacky wrote:
> The original suggestion from Boris, IIRC, was for protected_guest_has()
> function (below) to be:
> 
> 	if (intel)
> 		return intel_protected_guest_has();
> 	else if (amd)
> 		return amd_protected_guest_has();
> 	else
> 		return false;
> 
> And then you could check for TDX or SME/SEV in the respective functions.

Yeah, a single function call which calls vendor-specific functions.

If you can point me to a tree with your patches, I can try to hack up
what I mean.

> I believe Boris was wanting to replace the areas where sme_active() was
> specifically checked, too. And so protected_guest_has() can be confusing...

We can always say

	protected_guest_has(SME_ACTIVE);

or so and then it is clear.

> Maybe naming it protected_os_has() or protection_attr_active() might work.
> This would then work SME or MKTME as well.

But other names are fine too once we're done with the bikeshedding.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
