Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA94133DD2A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbhCPTJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236915AbhCPTJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:09:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFBDA6513D;
        Tue, 16 Mar 2021 19:09:25 +0000 (UTC)
Date:   Tue, 16 Mar 2021 19:09:23 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: vmlinux.lds.S: keep .entry.tramp.text section
Message-ID: <20210316190921.GB28565@arm.com>
References: <20210226140352.3477860-1-arnd@kernel.org>
 <202102261256.AF256702@keescook>
 <20210227043257.k3aernmnzsvitp7c@google.com>
 <20210316104530.GA7309@arm.com>
 <20210316162745.GA20565@arm.com>
 <CAK8P3a07nPbbP095LJ84Z5hP3Ce53fb_+0Zav8PUA+7R_92gMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a07nPbbP095LJ84Z5hP3Ce53fb_+0Zav8PUA+7R_92gMw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 05:39:27PM +0100, Arnd Bergmann wrote:
> On Tue, Mar 16, 2021 at 5:27 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, Mar 16, 2021 at 10:45:32AM +0000, Catalin Marinas wrote:
> > > On Fri, Feb 26, 2021 at 08:32:57PM -0800, Fangrui Song wrote:
> > > > On 2021-02-26, Kees Cook wrote:
> > > > > On Fri, Feb 26, 2021 at 03:03:39PM +0100, Arnd Bergmann wrote:
> > > > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > > >
> > > > > > When building with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION,
> > > > > > I sometimes see an assertion
> > > > > >
> > > > > >  ld.lld: error: Entry trampoline text too big
> > > > >
> > > > > Heh, "too big" seems a weird report for having it discarded. :)
> > > > >
> > > > > Any idea on this Fangrui?
> > > > >
> > > > > ( I see this is https://github.com/ClangBuiltLinux/linux/issues/1311 )
> > > >
> > > > This diagnostic is from an ASSERT in arch/arm64/kernel/vmlinux.lds
> > > >
> > > >   ASSERT((__entry_tramp_text_end - __entry_tramp_text_start) == (1 << 16),
> > > >    "Entry trampoline text too big")
> > >
> > > Can we not change the ASSERT to be <= PAGE_SIZE instead?
> >
> > Ah, that won't work as I suspect we still need the trampoline section.
> >
> > Arnd, do you know why this section disappears? I did a simple test with
> > defconfig + LD_DEAD_CODE_DATA_ELIMINATION and the trampoline section is
> > still around.
> 
> If I remember correctly, this showed up when CONFIG_ARM_SDE_INTERFACE
> is disabled, which dropped the only reference into this section.
> If that doesn't make sense, I can try digging through the old build logs to
> reproduce the problem.

I suspected this as well but still worked for me when disabling it.

Anyway, I don't think identifying the exact option is necessary. With
CONFIG_UNMAP_KERNEL_AT_EL0=y we need this section around even if only
__entry_tramp_text_start/end are referenced.

In this case we happened to detect this issue because of the ASSERT in
vmlinux.lds.S but I wonder what else the linker drops with this dead
code elimination that we may not notice (it seems to remove about 500KB
from the resulting image in my test).

I'll push these two patches to -next for wider coverage before deciding
on mainline (though the option may not get much testing as it's hidden
behind EXPERT and default n).

-- 
Catalin
