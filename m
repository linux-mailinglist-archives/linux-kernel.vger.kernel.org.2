Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3CD3A186D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbhFIPEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbhFIPDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:03:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB65C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 08:01:56 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0cf6002c8ea3a9506b9c3f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:f600:2c8e:a3a9:506b:9c3f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 503F21EC047D;
        Wed,  9 Jun 2021 17:01:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623250914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kfX77Ymnle+d34mKDWN8JPq3/lkoDzCapvIk1TX61Go=;
        b=RuWsfiN3GmZbEZfNWc4n/+NwSdXPl4TrwBuqz8CEhUjdUwMCtsxI/w+f/ttXTI29DVD8lR
        y8ZvuAAjrzo8dC2DYRARxUv+WUTtgrgUbNxHClmXkhwN3ih14U1MjTVYoyha5yPdeWP09F
        eRB7SPr9vSC8iKofGPDZ6h0xSk+/XN8=
Date:   Wed, 9 Jun 2021 17:01:48 +0200
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
Message-ID: <YMDX3Ly91OQUxEge@zn.tnic>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLkcIuL2qvo0hviU@zn.tnic>
 <82f9e5a9-682a-70be-e5ea-938bb742265f@linux.intel.com>
 <YL5kvLvCpG37zWc/@zn.tnic>
 <9466ae0b-3a2a-5a43-a4c6-39e07ebe0fbc@linux.intel.com>
 <YMDRDmO751Dc2igX@zn.tnic>
 <040a760a-de34-f184-1157-0c8c2d5fcacd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <040a760a-de34-f184-1157-0c8c2d5fcacd@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 07:56:14AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> And any arch which wants to support prot_guest_has() can enable above
> config option and create their own asm/protected_guest.

I wouldnt've done even that but only the x86 asm version of
protected_guest.h and left it to other arches to extend it. I don't
like "preempting" use of functionality by other arches and would
leave them to extend stuff themselves, as they see fit, but ok,
ARCH_HAS_PROTECTED_GUEST sounds clean enough to me too, so sure, that's
fine too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
