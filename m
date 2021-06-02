Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E673992B2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhFBSlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBSlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:41:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D0BC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 11:40:00 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f0e00fb29af68c81f5342.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:e00:fb29:af68:c81f:5342])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 658FA1EC047D;
        Wed,  2 Jun 2021 20:39:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622659199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1p169zuTSnb+F4C11QFsu1dq9u78p4YI/Gb69UPmJsU=;
        b=RSnzafbpzoUyFf4d76GHO3ktspCSdeAsukD2b48AZfGg6/2IiJ0oTc0+GkA+b4kvLRBx8B
        492CvM7NV1wU79LWWRMkn8HjNdLO7fwKYo0w7a0xvu73sRCgjyJaEUx0Q8BNyeYQBKiqrM
        0k4uQtRfyg2WoUQwolsNhf5F3KPUY38=
Date:   Wed, 2 Jun 2021 20:39:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
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
Message-ID: <YLfQf6quDHIVeRhH@zn.tnic>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLe92NXx1jZPtPqB@google.com>
 <3036a655-9d09-0f04-62a2-7a72ba9af5c7@amd.com>
 <YLfOApYdX/KL1wKF@zn.tnic>
 <23225953-2052-8e72-5eb0-6b30f2a5c84b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23225953-2052-8e72-5eb0-6b30f2a5c84b@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 11:32:18AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 6/2/21 11:29 AM, Borislav Petkov wrote:
> > If you can point me to a tree with your patches, I can try to hack up
> > what I mean.
> 
> https://github.com/intel/tdx/commit/8515b66a0cb27d5ab66eda201285090faee742f7

Ok, and which branch or tag?

tdx-guest-v5.12-7 or "guest"?

The github interface is yuck when one wants to look at commits...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
