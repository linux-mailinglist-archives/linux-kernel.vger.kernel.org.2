Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4D839E829
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhFGUQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:16:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33840 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231263AbhFGUQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:16:29 -0400
Received: from zn.tnic (p200300ec2f0b4f003f1ec01ee0666919.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:4f00:3f1e:c01e:e066:6919])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77A311EC01DF;
        Mon,  7 Jun 2021 22:14:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623096876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=B4pmyNunWUMjDUP69GNVkOnzL1WI6677dnlEB/m07d4=;
        b=LERCftxMXPY0iHQQhSe4ACZfV2y43PCMsz1Tm+CVPxusNdk7a5Qwoxk38YZNy9ziJu1K+Y
        uI8HoOPBJPvhdqJ8EnxUtIsosrCKxy/p9N/tUazJFrnnZO7lz0ebwOoUwPBzOx3LhmquGP
        Yb5FJ1uA2UfaQBDnUR0cWE7PbZF+euk=
Date:   Mon, 7 Jun 2021 22:14:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstractionn
Message-ID: <YL5+JkxaQbN4pNqD@zn.tnic>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLkcIuL2qvo0hviU@zn.tnic>
 <YLkcUts9dWDkDKpY@zn.tnic>
 <20210607195544.qlya6i5s2l2fkms2@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210607195544.qlya6i5s2l2fkms2@box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 10:55:44PM +0300, Kirill A. Shutemov wrote:
> I think conversions like this are wrong: relocate_kernel(), which got
> called here, only knows how to deal with SME, not how to handle some
> generic case.

What do you mean wrong? Wrong for TDX?

If so, then that can be

protected_guest_has(SME)

or so, which would be false on Intel.

And this patch was only a mechanical conversion to see how it would look
like.

> If code is written to handle a specific technology we need to stick
> with a check that makes it clear. Trying to make sound generic only
> leads to confusion.

Sure, fine by me.

And I don't want a zoo of gazillion small checking functions per
technology. sev_<something>, tdx_<something>, yadda yadda.

So stuff better be unified. Even if you'd have vendor-specific defines
you hand into that function - and you will have such - it is still much
saner than what it turns into with the AMD side of things.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
