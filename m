Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D8839C7AB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 13:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFELIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 07:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhFELH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 07:07:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775FFC061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 04:06:11 -0700 (PDT)
Received: from zn.tnic (p4fed32f0.dip0.t-ipconnect.de [79.237.50.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 10AC61EC01A2;
        Sat,  5 Jun 2021 13:06:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622891170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JZ9YF6+OF3bCVwHOtW45Mhrnr9jvP3HjzwjBTkIhoOI=;
        b=IQ0pCBU62C2BSj2MTIYWps6/806yC5yXG7Q+x7gCNFkUK+z8JJxA9UfjNMuMqnnrkHAkn3
        Ps4cIPw1fTHl3+rqnfNU15Xf83oIT3xthx+JBWqFIntxQChhh4W/7yP4FeRjmClPfge0Yi
        xO4qKCZWJpu6HToqasL2VgKMMW6BRpA=
Date:   Sat, 5 Jun 2021 13:03:53 +0200
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
Message-ID: <YLtaGXcjCMsSyT/a@zn.tnic>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLkcIuL2qvo0hviU@zn.tnic>
 <YLkcUts9dWDkDKpY@zn.tnic>
 <1c8938fb-c9e9-af51-5224-70fc869eedea@amd.com>
 <YLqmGzgXo0jFRhpw@zn.tnic>
 <12bba26f-5605-fabf-53ea-f0bc1bb9db44@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12bba26f-5605-fabf-53ea-f0bc1bb9db44@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 06:31:03PM -0500, Tom Lendacky wrote:
> If Intel has XYZ but AMD does not, you don't want to WARN, just return false.

Aha, *now*, I see what you mean. Ok, so the reason why I added the
WARN is to sanity-check whether we're handling all possible VM_* or
PROT_GUEST_* flags properly and whether we're missing some. As a
debugging help. It'll get removed before applying I guess.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
