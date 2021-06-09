Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD833A174F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbhFIOex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:34:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41828 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234734AbhFIOes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:34:48 -0400
Received: from zn.tnic (p200300ec2f0cf6002c8ea3a9506b9c3f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:f600:2c8e:a3a9:506b:9c3f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8EC981EC0516;
        Wed,  9 Jun 2021 16:32:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623249172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oTvJUNqNPXJgrATOUO5AJ0EllSZ5xLN85/3fQaACIhM=;
        b=ckclrrh8R2rjSCsIJOO3Gmdo5IV8CSqDWXGxCyOiLEGdOp8yE4bUSK2hliXNS5hrCdi1Xy
        KAjGylpJid/k5gR66MMg90X8SOLKxELW44ANk8UQEiE0CpB7nVsCJ1hs+p36f/1TnNO2Bq
        gPxBZguTtaQXHrH610B7eRQWEh+oDW4=
Date:   Wed, 9 Jun 2021 16:32:46 +0200
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
Message-ID: <YMDRDmO751Dc2igX@zn.tnic>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLkcIuL2qvo0hviU@zn.tnic>
 <82f9e5a9-682a-70be-e5ea-938bb742265f@linux.intel.com>
 <YL5kvLvCpG37zWc/@zn.tnic>
 <9466ae0b-3a2a-5a43-a4c6-39e07ebe0fbc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9466ae0b-3a2a-5a43-a4c6-39e07ebe0fbc@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 07:01:13AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> I am still not clear. What happens when a driver which includes
> linux/protected-guest.h is compiled for non-x86 arch (s390 or arm64)?

I was wondering what felt weird: why is prot{ected,}_guest_has() in a
generic linux/ namespace header and not in an asm/ one?

I think the proper way is for the other arches should be to provide
their own prot_guest_has() implementation which generic code uses and
the generic header would contain only the PR_GUEST_* defines.

Take ioremap() as an example:

arch/x86/include/asm/io.h
arch/arm64/include/asm/io.h
arch/s390/include/asm/io.h
...

and pretty much every arch has that arch-specific io.h header which
defines ioremap() and generic code includes include/linux/io.h which
includes the respective asm/io.h header so that users can call the
respective ioremap() implementation.

prot_guest_has() sounds just the same to me.

Better?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
