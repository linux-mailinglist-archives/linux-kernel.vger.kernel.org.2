Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBBA3FCD03
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 20:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhHaSkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 14:40:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:27012 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhHaSkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:40:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="218592117"
X-IronPort-AV: E=Sophos;i="5.84,367,1620716400"; 
   d="scan'208";a="218592117"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 11:39:23 -0700
X-IronPort-AV: E=Sophos;i="5.84,367,1620716400"; 
   d="scan'208";a="498399794"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 11:39:22 -0700
Date:   Tue, 31 Aug 2021 11:39:21 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
Message-ID: <20210831183921.GA1687448@agluck-desk2.amr.corp.intel.com>
References: <20210830154702.247681585@linutronix.de>
 <20210830162545.374070793@linutronix.de>
 <YS0ylo9nTHD9NiAp@zn.tnic>
 <87zgsyg0eg.ffs@tglx>
 <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
 <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
 <YS1OE6FRi4ZwEF8j@zeniv-ca.linux.org.uk>
 <CAHk-=wh57tMaJxcH=kWE4xdKLjayKSDEVvMwHG4fKZ5tUHF6mg@mail.gmail.com>
 <87zgsye9kn.ffs@tglx>
 <YS3cskpK9Uoq3Wc4@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS3cskpK9Uoq3Wc4@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 09:39:30AM +0200, Borislav Petkov wrote:
> On Tue, Aug 31, 2021 at 02:34:16AM +0200, Thomas Gleixner wrote:
> No no, the great way to do error injection is the ACPI-spec'ed, firwmare
> implemented
> 
> drivers/acpi/apei/einj.c
> 
> Yap, you heard me right, firmware. And when you hear firmware, you can
> imagine how it all works in practice... Yeap, exactly.

You can imagine all you want. And if your imagination is based
on experiences with very old systems like Haswell (launched in 2015)
then you'd be right to be skeptical of firmware capabilities.

> We even wrote documentation what to do:
> 
> Documentation/firmware-guide/acpi/apei/einj.rst
> 
> But but, this is firmware so
> 
> - it is f*cking broken in all ways imaginable

s/is/was/

> 
> - if it works, it doesn't support the error type which you wanna inject

Memory errors now have very good coverage. Still some issues with PCIe injection.

> - if it does, enterprise sh*t hw has added value crap which analyzes and
> looks at hardware errors first</me rolls eyes, trying to remain serious>
> so you might get the error report if you get lucky.

Turn off eMCA in BIOS to avoid this.

> > The HW injection mechanisms definitely exist, but without documentation
> > they are useless. Intel still thinks that the secrecy around that stuff
> > is valuable and they can get away with those untestable mechanisms even
> > for their endeavours in the safety critical space.

The injection controls in the memory controller can only be accessed
in SMM mode. Some paranoia there that some ring0 attack could inject
errors at random intervals causing major costs to diagnose and replace
"failing" DIMMs. So documentation wouldn't help Linux because it just
can't twiddle the necessary bits in the h/w.

> My impression with error injection with hw people is just like what they
> do with perf counters: it counts *something* right? You should be happy
> that it does.

This was true <= Haswell. But definitely not true now. The h/w groups
now have validation teams that depend on ACPI/EINJ for many of their
system level tests. Those guys are serious about this stuff. While I'll
just inject 1000 errors on a single machine and call it good if it all
goes as expected, those folks have (small) clusters running injection
tests 24x7 for weeks at a time.

Downsides of ACPI/EINJ today:
1) Availability on production machines. It is always disabled by default
in BIOS. OEMs may not provide a setup option to turn it on (or may have
deleted the code to support it completely). Intel's pre-production servers
always have the code, and the setup option to enable.
2) Doesn't inject to 3D-Xpoint (that has its own injection method, but
it is annoying to have to juggle two methods).
3) Hard/impossible to inject into SGX memory (because BIOS is untrusted
and isn't allowed to do a store to push the poison data to DDR).

-Tony
