Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC3739CAD5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 22:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhFEUKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 16:10:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52760 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhFEUKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 16:10:47 -0400
Received: from zn.tnic (p200300ec2f2a750019e0f27448df8285.dip0.t-ipconnect.de [IPv6:2003:ec:2f2a:7500:19e0:f274:48df:8285])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA2141EC034B;
        Sat,  5 Jun 2021 22:08:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622923737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tlaf54Z6nPA4PCg8qfxuo7bdPsfGPi8WRyfq8gVLZNw=;
        b=kGUY90Mc7nH3WGYqzWk+Uau34ZMi6g+5vTX1+3mTYjk4FoCM+nk4w2MN+hwZgQJU8OHgHA
        xl62wiBlVy9R/ONEdZkyIE5r7onaLobTnE2IrQd0H5qbMqlObJzJ8y8R+PPf+pV24sxSJ+
        ABQRRYOSzOZDgC87Ud1WArh/R9GiaIs=
Date:   Sat, 5 Jun 2021 22:08:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
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
 abstractionn
Message-ID: <YLvZ1Js0Ws/PAzYG@zn.tnic>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLkcIuL2qvo0hviU@zn.tnic>
 <YLkcUts9dWDkDKpY@zn.tnic>
 <1c8938fb-c9e9-af51-5224-70fc869eedea@amd.com>
 <YLqmGzgXo0jFRhpw@zn.tnic>
 <12bba26f-5605-fabf-53ea-f0bc1bb9db44@amd.com>
 <YLtaGXcjCMsSyT/a@zn.tnic>
 <c25b334a-3c01-2af4-6374-883c19e3837a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c25b334a-3c01-2af4-6374-883c19e3837a@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2021 at 11:12:57AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> cc_has() or protected_guest_has() or prot_guest_has() or protected_boot_has()

Even if I still think it is not optimal, prot_guest_has() seems to be
best what we have because protected_guest_has() together with the flag
will become just too long to scan at a quick glance. And if you have to
do two tests, you'd have to break the line.

> For flag prefix either PR_GUEST_* or CC_*

PR_GUEST_* sounds ok to me.

The "cc" prefix stuff is nice and short but it doesn't say what it means
because it is simply too short. And code readability is very important.

I'd say.

Still open for better suggestions though.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
