Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBBC42CF1B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 01:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhJMXVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 19:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhJMXVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 19:21:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42529C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 16:19:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634167164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FQeajS/gHzahm5PmF7K4RWwLcohD4yW2rXA0QIwJ2+E=;
        b=uvpMOuzzcn3Xfm472s0QrUB1f8qnvbBv6skedMrLboF7glJojpJqAdHKpcDfQov4NQnXnI
        wUmPIuCpssr65P1yOl6a/pWthHSzd79cMZ2ySJaSpQTKJ3wAsVKktqlQ1COkZwxAHK0cQ0
        AreBTyp5qrsSgZ3UOQgxo7KMaToTaIuh0q3QygI+QKHAVvWmOAXEJ39H8dxi/Zy5Q3iQCQ
        MKndyJxfASPkA3cCKUDleEQnyyOcIgmMDYgUgJiWiB7c5N3v9jL2fs4IO9G7Uy05L6CZUq
        eNldcF9h5RX5e/EjdYsSiepc/FpDEFxYQZk5CbtYh/4SApq8DsROeJbm6uZdzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634167164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FQeajS/gHzahm5PmF7K4RWwLcohD4yW2rXA0QIwJ2+E=;
        b=6kfJDnlUQGUIqOqAUa1TkTkP+YDGSlZgaNWBlykesmYDN4LMkzbIfKhrc0eBeNghuRL5RU
        vRR5N99Ta8TbyXDA==
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
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
Subject: Re: [PATCH v10 03/11] x86/cpufeatures: Add TDX Guest CPU feature
In-Reply-To: <20211013194251.ndbyj45egz6msl63@treble>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YWaWSmWn6AZ6OLx+@zn.tnic> <20211013194251.ndbyj45egz6msl63@treble>
Date:   Thu, 14 Oct 2021 01:19:23 +0200
Message-ID: <87wnmg7bt0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13 2021 at 12:42, Josh Poimboeuf wrote:
> On Wed, Oct 13, 2021 at 10:18:18AM +0200, Borislav Petkov wrote:
>> > +#include <asm/tdx.h>
>> > +
>> > +bool is_tdx_guest(void)
>> > +{
>> > +	static int tdx_guest = -1;
>> 
>> Put that one at the top of the file because such static variables do not
>> belong among the automatic function vars.
>
> I disagree, this prevents confusion and misuse by making it clear that
> the scope of the static variable is limited to this function.

I kinda agree under the assumption that a static variable is only used
in a particular context and there is a reasonable requirement to do so.

The above does not qualify as I pointed out in my other reply. Just
because it looks like strict local usage at the first glance does not
make an argument, really.

I'm amazed that it's so hard to see that this

    use()
    init()

pattern is broken to begin with.

So why are you arguing about the placement of this variable in the first
place instead of actually looking at the code, wondering about the
obscenity and then asking about the call ordering?

In case that I might miss something important here due to my lack of CS
education, please let me know.

Thanks,

        tglx


