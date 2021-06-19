Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4253ADBB8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 22:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFSUnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 16:43:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35824 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhFSUno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 16:43:44 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624135292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pzh1DyExfIq0Y7Pu0XOsv12S409B+VC12R0cmnhOOts=;
        b=tEhckMapSVimxmEW8jhnm39F9FRzyVnl5yG7d2WAeK7Z7EJ1NwRs7XIT02tlR1Y974CUgE
        NZO5nXq6If/Ka7ZEroOkO0PaZ4e/zMNnOc9D1vwCvYIWMAOWIWJni6E1bsB6szZKKn7OdK
        dcV2OUTCi29fftY/FtwDp60nJTDd/vuJ7gC8QflK6pAAVcQBEW7BeFhZynV0aJMFJGSjkY
        BaUp37udo62mz5fVyG0kMKlXHOAsqCnC67MJjsHvXarSbTf6uSvLftQ+SdDSu6W6DeoaBW
        IIiMdHukacX5ONO4B3xKmUZ/2BU5s6JYBlbGxDappjXH8A8eihd+gZaMuEKlEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624135292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pzh1DyExfIq0Y7Pu0XOsv12S409B+VC12R0cmnhOOts=;
        b=Mk08qu1KM9kLKsJVgt6qdszwMyPLW5gnQ0xN3h2wki58H9xx8kq/HgY2GtMsBidbaoZ9xD
        Rygiu4m6rrtcnyDQ==
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v3 01/23] x86/elf: Check in_x32_syscall() in compat_arch_setup_additional_pages()
In-Reply-To: <20210611180242.711399-2-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com> <20210611180242.711399-2-dima@arista.com>
Date:   Sat, 19 Jun 2021 22:41:31 +0200
Message-ID: <87tulth9j8.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11 2021 at 19:02, Dmitry Safonov wrote:
> Partly revert commit 3316ec8ccd34 ("x86/elf: Use e_machine to check for
> x32/ia32 in setup_additional_pages()") and commit 9a29a671902c ("elf:
> Expose ELF header on arch_setup_additional_pages()".
> Both patches did a good thing: removed usage of TIF_X32, but with
> a price of additional macros ARCH_SETUP_ADDITIONAL_PAGES() and ifdeffs.
>
> Instead, use in_x32_syscall() - the first thing load_elf_binary() does
> after parsing and checking new ELF binary. It's done that early after
> exec() that mmap() code already uses it straight away, which is needed
> to know which mmap_base to use (see arch_pick_mmap_layout()).
> Add comments to describe how it works.

I still have no idea what this is trying to solve. All you describe is
what this does.

Thanks,

        tglx
