Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7AF33D968
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237708AbhCPQ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238731AbhCPQ1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:27:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43B0B6508E;
        Tue, 16 Mar 2021 16:27:48 +0000 (UTC)
Date:   Tue, 16 Mar 2021 16:27:45 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Fangrui Song <maskray@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: vmlinux.lds.S: keep .entry.tramp.text section
Message-ID: <20210316162745.GA20565@arm.com>
References: <20210226140352.3477860-1-arnd@kernel.org>
 <202102261256.AF256702@keescook>
 <20210227043257.k3aernmnzsvitp7c@google.com>
 <20210316104530.GA7309@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316104530.GA7309@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 10:45:32AM +0000, Catalin Marinas wrote:
> On Fri, Feb 26, 2021 at 08:32:57PM -0800, Fangrui Song wrote:
> > On 2021-02-26, Kees Cook wrote:
> > > On Fri, Feb 26, 2021 at 03:03:39PM +0100, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > 
> > > > When building with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION,
> > > > I sometimes see an assertion
> > > > 
> > > >  ld.lld: error: Entry trampoline text too big
> > > 
> > > Heh, "too big" seems a weird report for having it discarded. :)
> > > 
> > > Any idea on this Fangrui?
> > > 
> > > ( I see this is https://github.com/ClangBuiltLinux/linux/issues/1311 )
> > 
> > This diagnostic is from an ASSERT in arch/arm64/kernel/vmlinux.lds
> > 
> >   ASSERT((__entry_tramp_text_end - __entry_tramp_text_start) == (1 << 16),
> >    "Entry trampoline text too big")
> 
> Can we not change the ASSERT to be <= PAGE_SIZE instead?

Ah, that won't work as I suspect we still need the trampoline section.

Arnd, do you know why this section disappears? I did a simple test with
defconfig + LD_DEAD_CODE_DATA_ELIMINATION and the trampoline section is
still around.

-- 
Catalin
