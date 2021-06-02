Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAC039928E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhFBScq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhFBScn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:32:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8897C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 11:30:59 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f0e00ae3ef7328f799462.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:e00:ae3e:f732:8f79:9462])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 438791EC047D;
        Wed,  2 Jun 2021 20:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622658658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=s2MpVwsPPjHrgo3VWJyqJekulpEUVtwlLcFpp91/3GQ=;
        b=Y5LJX1L4Y6mXe+niBhG5UBS8zTtMca4U283WO4ITb4qI0XwzAG9Yv6bedaRcsTUl7/ylLN
        YhPmYPCdLPcxg+GQpt5u3fTF7fQ42VvZ3PAl/XpaQA1a21fo03BMCUbVbvOZUvzTAQeqQd
        8vKicnZq0sgVr7Anc5+3rEaPIjhNk20=
Date:   Wed, 2 Jun 2021 20:30:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstraction
Message-ID: <YLfOYvv89X+wCLJv@zn.tnic>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <dfb6b319-97ad-4c16-67ae-de4ce4ef415b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dfb6b319-97ad-4c16-67ae-de4ce4ef415b@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 01:19:07PM -0500, Tom Lendacky wrote:
> This certainly doesn't capture all of the situations where true would need
> to be returned. For example, SEV, but not SEV-ES, requires that string I/O
> be unrolled, etc.

Yeah, I believe this would be better done for you guys, ontop, as you
know best what needs to be queried where. So this first patch adding
only a stub should be fine. Or you or someone else does the conversion
ontop of the Intel patch and then all patches go together.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
