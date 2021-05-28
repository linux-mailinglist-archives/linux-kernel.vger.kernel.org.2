Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D97F394640
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 19:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbhE1RPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 13:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhE1RPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 13:15:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95338613B6;
        Fri, 28 May 2021 17:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622222037;
        bh=btu1XKYl/SxptLijDHm9O5VtHEC06LI6a/VkclgT8tE=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=o0O+4tmo1e3pS1ydtGlw+kn/keT9AcWAQQMJE+kzkkp6aXqL6LN9KCGW3u0msJJsr
         UdXTfQSR737WilcuaFQ5JkMeVw2w8zyGDzFxM6z9SNZiulb2+YlJ0vAs84eoNzmlsI
         TBHNe574uCR3h7DvAAGTjFlXpioNQ7Xvy+4DO0SiPvNonDoxS/o4NJU5CvBr2IJAWx
         Tvr2kVWadNIEFHCdA5msCESZ6VishJPDfFMMFWuhbGqiEz7lviMgRO0DSFgQsG4Vd+
         RSHGjm7+6zjTyo3VjIkYOLOscQ7Gu0cIYBlo1+Tf8CS7J7ogEX2nhJDxFVowDJTcjr
         /w/fBViEKDw7A==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 97B1327C0054;
        Fri, 28 May 2021 13:13:55 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Fri, 28 May 2021 13:13:55 -0400
X-ME-Sender: <xms:0SSxYBNhLLEQhbE5DlCdjIGAyc9hsbxC88yUOT8kiJNc-79KkN_ErQ>
    <xme:0SSxYD-Dlo4OwdnTb9LhWVsB5TmvH6bMtUBT4Nby4DknY5hnYDzWU6Mhd_QogPfd4
    q3ZwhuLBHfRAMXbgFk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekjedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
    gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:0SSxYATUdIenlKMLAPrg3ZlMLp6CCWhFef7S9ts1Z1KwHGgGWsVBFQ>
    <xmx:0SSxYNtJzdNZLuD9AN8onvkX235_vbNUV3WOxikkpBbKHXEt9TlcOw>
    <xmx:0SSxYJf46tqmrSAugiHt6K14v0Lq-MOLy1gwKJsT4Tfu6x-jl58qkA>
    <xmx:0ySxYKXebEBWDDxDG6P_oBXOkEF1Hoj-mhn_Suz3FSF2FCO5syMBsvwvicCtyH26>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 014BB51C0060; Fri, 28 May 2021 13:13:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-468-gdb53729b73-fm-20210517.001-gdb53729b
Mime-Version: 1.0
Message-Id: <3781d3ec-6d1b-4d04-8bed-19985115153d@www.fastmail.com>
In-Reply-To: <4c3bfc27-a542-8e91-7ccf-4be8b1e6c844@intel.com>
References: <20210527235109.B2A9F45F@viggo.jf.intel.com>
 <87eedq7u2b.ffs@nanos.tec.linutronix.de>
 <4c3bfc27-a542-8e91-7ccf-4be8b1e6c844@intel.com>
Date:   Fri, 28 May 2021 10:13:32 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Dave Hansen" <dave.hansen@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, linux-mm@kvack.org
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>, shuah@kernel.org,
        "Babu Moger" <babu.moger@amd.com>, dave.kleikamp@oracle.com,
        linuxram@us.ibm.com, bauerman@linux.ibm.com
Subject: Re: [PATCH 0/5] x86/pkeys: PKRU manipulation bug fixes and cleanups
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, May 28, 2021, at 9:11 AM, Dave Hansen wrote:
> On 5/28/21 8:32 AM, Thomas Gleixner wrote:
> >>
> >> This series:
> >>  * Moves the PKRU manipulation to a more appropriate location,
> >>    away from the page table code
> >>  * Wraps get_xsave_addr() with more structured, less error-prone
> >>    interfaces.
> >>  * Conditionally hides a pkey debugfs file, eliminating the need
> >>    for new runtime checks to work with the new interface.
> >>  * Add a selftest to make it more likely to catch bugs like this
> >>    in the future.  This improved selftest catches this issue on
> >>    Intel CPUs.  Without the improvement, it only triggers on AMD.
> > I think all of this is fundamentaly wrong.
> > 
> > Contrary to FPU state, PKRU has to be updated at context switch
> > time. There is absolutely no point in having PKRU XSAVES managed.
> > 
> > It's broken in several ways. Anything which clears and loads the FPU
> > will load the wrong PKRU value. Go figure...
> > 
> > So the right thing is to disable PKRU in XCR0 and on sched out simply do
> > 
> >    task->thread.pkru = read_pkru();
> > 
> > and on sched in
> > 
> >    write_pkru(task->thread.pkru);
> > 
> > Simple, trivial and not going to be wreckaged by anything which fiddles
> > with xstates. We all know by now that xstates is a trainwreck and not
> > having stuff like that in there is making the fixes I'm doing way
> > simpler.
> 
> As for the general sentiment that PKRU is not suitable for management
> with XSAVE, I'm with you.
> 
> I have a few concerns about moving away from XSAVE management, though.
> I'm not nixing the whole idea, but there are some things we need to resolve.
> 
> First is that there _may_ be ABI concerns.  

I tend to think that, for -stable, we should fix the bug without an ABI change.
