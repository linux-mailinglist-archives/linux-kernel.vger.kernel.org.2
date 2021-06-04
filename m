Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C168439C35F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 00:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhFDWRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 18:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhFDWRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 18:17:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83AAC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 15:16:04 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1385001fd2d00863d02844.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:8500:1fd2:d008:63d0:2844])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E50061EC013E;
        Sat,  5 Jun 2021 00:16:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622844962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kiR/OKl/FnbVSeoJjkfPYh/10sMqDD0nf1kTNEhB5ec=;
        b=kbcdxexEbrhQvhg0RBMuZ2gQx02MYKlPFtC/RJf5Fqy02vpNyxqtUJsww5Z49AEy5SbORc
        NGWAHDWZ7gVuLi8Gg8cE7FeeKoReOSUwN3Ymo91si9ezB+CJGYPh1l6Hwv+iKnRZIoj92s
        dL5ntE/UtXHwtMPtHPZGo3NDpTbKRi8=
Date:   Sat, 5 Jun 2021 00:15:55 +0200
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
 abstractionn
Message-ID: <YLqmGzgXo0jFRhpw@zn.tnic>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLkcIuL2qvo0hviU@zn.tnic>
 <YLkcUts9dWDkDKpY@zn.tnic>
 <1c8938fb-c9e9-af51-5224-70fc869eedea@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c8938fb-c9e9-af51-5224-70fc869eedea@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 05:01:31PM -0500, Tom Lendacky wrote:
> The first is analogous to sme_active(), the second to sev_active() and the
> third to mem_encrypt_active(). Just my opinion, though...

Yeah, or cc_has() where "cc" means "confidential computing". Or "coco"...

Yeah, no good idea yet.

> I don't think you want a WARN_ON_ONCE() here. The code will be written to
> work with either SEV or TDX, so we shouldn't warn on a check for a TDX
> supported feature when running on AMD (or vice-versa).

That's an AMD-specific path so it would warn only when a flag is used
which is unknown/unused yet on AMD.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
