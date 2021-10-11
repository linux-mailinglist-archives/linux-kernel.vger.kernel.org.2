Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D0F428D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbhJKNFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:05:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36896 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236762AbhJKNFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:05:38 -0400
Received: from zn.tnic (p200300ec2f08bb00608dded251e09f1b.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:bb00:608d:ded2:51e0:9f1b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 33ADC1EC01B7;
        Mon, 11 Oct 2021 15:03:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633957417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WQJBaM7J4im4aersWjHYUFTBv+zcQxdAIOV9RzgqHPI=;
        b=giZ8cDDaB5SOk6RboAFl3IZ3tFilkVLny0IHum6NNi77bO2/ddmoXgnKRFkYnVbk7k3pRd
        K5H0LA4LZHR7WgZ2uBCriMYrVt/67f9NPwTZha/8Dcmg+zpgLMx0BmPN4ARRAsHVaIwaDO
        gKsnPm8SNBZuRZjLdsavyM6U/8iA468=
Date:   Mon, 11 Oct 2021 15:03:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
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
Message-ID: <YWQ2JqkLKoDMYO/W@zn.tnic>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YWFG7+QqVGZ5ZdG9@zn.tnic>
 <6584b4d5-b7a1-2dbb-1a27-10f9c7949be9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6584b4d5-b7a1-2dbb-1a27-10f9c7949be9@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2021 at 01:56:12PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> I thought the above issues warranted a re-submission. I know that it is a mistake
> from my end. But I did not want you to review code changes that might go away
> due to rebase.

That's fine - most of the time I do notice when code is changing and I
even warn submitters about it.

> I have sent v10 within few hours of v9 submission to fix a static inline issue.
> 
> I did not catch it my compilation test because, it happens only with a
> TDX disabled config.

For that you need to write yourself a script which does:

ARCHES=('i386' 'x86_64')

	...

        for a in "${ARCHES[@]}"
        do
                for cfg in "allnoconfig" "defconfig" "allmodconfig" "allyesconfig"
                do
                        build_kernel $a $cfg
                done
        done

then find a big fat machine at Intel - I don't think that would post as
a particularly hard problem :-) - and run it in tmpfs, on your patchset.

Then you collect build logs and grep them for errors. And for additional
coverage, when you're done with the above configs, you do randconfigs.
That's what I do all the time with patchsets and it catches pretty much
every build error.

> Sorry for the trouble again. Please ignore the v9 version. I will try
> not to repeat this in future.

Thanks for that - very much appreciated.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
