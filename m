Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267354277DF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 09:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhJIHka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 03:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhJIHkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 03:40:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479E4C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 00:38:29 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1e220071dfbf03a8036444.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:2200:71df:bf03:a803:6444])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E75B1EC047E;
        Sat,  9 Oct 2021 09:38:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633765107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qmwSpK5n/52Nbx+LHauAcoGj7Nk39lsvcR0objnyrNY=;
        b=gf/P9uesWOOY52BMtXXVxYxj2LjYfKTp4FgrN/O0abe63FGEz3SxULuQKtBaoXDynVV5Vr
        gVmUKc8WZ0+gb+1o0VGLfx3jI7uIm10uzjTmV0kN/0hUrzTn5/0c7iVCxKf3Ex9C8lmKQM
        OjfFSkGCSWOnlp/o2nmfFilnOMBdCe8=
Date:   Sat, 9 Oct 2021 09:38:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/11] Add TDX Guest Support (Initial support)
Message-ID: <YWFG7+QqVGZ5ZdG9@zn.tnic>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 10:37:36PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Hi All,

Now let's see: you sent this particular patchset on Monday, 4th. The
usual process is that you wait at least a week for review comments,
incorporate them into your next revision and then you send it. We were
still reviewing v8...

But I see already a v9 in my mbox from yesterday and *also* a v10. v9
you probably didn't build-test enough so you had to hastily do a v10. 4
days later!

And because that's not enough, there are a bunch of other TDX patchsets
from you flying in constantly.

Now, please explain to me how you imagine this whole review thing is
supposed to work?

You hammer people with patchsets until they go in? Forget proper review?

Or people should drop the other things they have to do for their jobs
and deal only with your patchsets?

How about we trade places: you review and try to get sh*t to work and I
hammer you with patchsets every 3-4 days?

For chrissakes, please calm down with that constant hammering and try to
put yourself in the maintainer's shoes for once. Also, try to realize
that hammering people with patchsets will get you the *opposite* of what
you're trying to achieve - you will get ignored.

Geez.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
