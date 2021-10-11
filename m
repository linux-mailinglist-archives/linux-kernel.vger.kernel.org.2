Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1BC429526
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 19:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhJKRG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 13:06:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49736 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232477AbhJKRG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:06:28 -0400
Received: from zn.tnic (p200300ec2f08bb0030636ca0dab1dbfc.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:bb00:3063:6ca0:dab1:dbfc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 119F81EC03CA;
        Mon, 11 Oct 2021 19:04:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633971867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Uhi/0mTMQPF1j9oov8A9eUPIu6iaQITd864TbmJf0ic=;
        b=VpRMYRDncvudkgca57mLLE1vfHN8/99rwHWDnPfp8AZawRrDgEDQRTJXdWxzsFGDRFlfLX
        FE/bOWMSVvo5PaGcSrl0dRJ5qIM4ItzMqSW9zl7y4eWuX57EiamHACh4p1oueVCsxxNdSu
        0xkQJ0tm0nDvYIG3TZfhZLAoWKY8J5A=
Date:   Mon, 11 Oct 2021 19:04:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/11] Add TDX Guest Support (Initial support)
Message-ID: <YWRum+BdErvg6874@zn.tnic>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YWFG7+QqVGZ5ZdG9@zn.tnic>
 <6584b4d5-b7a1-2dbb-1a27-10f9c7949be9@linux.intel.com>
 <YWQ2JqkLKoDMYO/W@zn.tnic>
 <1a8898d2-9ac9-f053-23a6-63fb40e2c9dc@intel.com>
 <1c6ee36e-e42a-bca1-1642-a85a3888144b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c6ee36e-e42a-bca1-1642-a85a3888144b@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 09:48:40AM -0700, Dave Hansen wrote:
> On 10/11/21 9:33 AM, Dave Hansen wrote:
> > FWIW, if you're in search of funky Kconfigs for compiling x86, I've got
> > a big bundle of them. 
> 
> In case anyone's interested, here's a bundle of them:
> 
> 	https://sr71.net/~dave/intel/configs-5.15.tar.gz
> 
> Nothing magic here, just a list of configs that have caused me problems
> over the years.  These tend to be tweaked a *bit* away from their
> namesake.  For instance, "allnoconfig" is typically a "make
> allnoconfig", with a few things added back so it has a chance of booting
> somewhere.
> 
> These, once untarred, are in a directory structure so you can easily:
> 
> 	make O=/path/to/build/64bit menuconfig
> 
> or whatever.

Yap, looks good. Lemme add them to my pile of build-test machinery.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
