Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6947637A3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhEKJhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhEKJhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:37:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEF7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 02:36:04 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ec70079cd82bef3234244.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:c700:79cd:82be:f323:4244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 740DE1EC0523;
        Tue, 11 May 2021 11:36:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620725761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=F7VxGCtxqOa5Uaq8/CVpfggBErw2DOeXqO+Qk8G4uYU=;
        b=kCiLX+qWCIE9DmOWmD2vOMkS8u1N1iOnViJVyAqlmlv12k52rSr9m3JcN39XVGWUjpKID0
        2tXfFE2NCcTiyfL2UFdEwyEpMt9/GaZ1ayxGK7E4IXPJF8CMaTurNEKkGOvbin4Ltur95d
        jWhLxSRGD+V5VtGSsz8O4h9x6t+T2R8=
Date:   Tue, 11 May 2021 11:35:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 28/32] x86/tdx: Make pages shared in ioremap()
Message-ID: <YJpP/S8MajKNhBl4@zn.tnic>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <eaaa692ce1ed897f66f864bbfa2df8683768d79e.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <b884067a-19d6-105f-9f8c-28feb3b43446@intel.com>
 <312879fb-d201-a16d-2568-150152044c54@linux.intel.com>
 <797c95bf-9516-8aee-59d0-f5259d77bb75@linux.intel.com>
 <5b4b4fc0-aaa8-3407-6602-537d59572bc1@intel.com>
 <YJm5QY8omAvdpBO9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJm5QY8omAvdpBO9@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 10:52:49PM +0000, Sean Christopherson wrote:
> I can't find the thread offhand, but Boris proposed something along the lines of
> cpu_has(), but specific to a given flavor of protected guest.  IIRC, it was
> sev_guest_has(SEV_ES) or something like that.
> 
> I 100% agree that we should have actual feature bits somewhere for the various
> protected guest flavors.

Preach brother! :)

/me goes and greps mailboxes...

ah, do you mean this, per chance:

https://lore.kernel.org/kvm/20210421144402.GB5004@zn.tnic/

?

And yes, this has "sev" in the name and dhansen makes sense to me in
wishing to unify all the protected guest feature queries under a common
name. And then depending on the vendor, that common name will call the
respective vendor's helper to answer the protected guest aspect asked
about.

This way, generic code will call

	protected_guest_has()

or so and be nicely abstracted away from the underlying implementation.

Hohumm, yap, sounds nice to me.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
