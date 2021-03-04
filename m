Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C2332CFC2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbhCDJeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:34:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237631AbhCDJdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:33:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59D2964F04;
        Thu,  4 Mar 2021 09:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614850392;
        bh=leFZ6+rQ3M5M41gnG29LCPTANBQM6a16TQ6x79aIuuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J95mr2zCFdpJxGKZgvAyv6aSHQ5f/H1S/UXrY5Bw/MkJ25v9SpJGgH8zXXqmuG1rD
         O2oM38s0sGewM4E0c/2k3gFb2LMZDDx+tjW7u59rbgKJshaUaUnlea2rWbQi5r/m6w
         i5BIWEe3M541DR2gHB2oSfkdweaXlEnodNzPfgyIfxKzEyHYVmQJS7te3IAa0HunKj
         nlm9FGFkQlmb857S3frvhyOPONpq/KgnunzuOCLsKAsxUIeHaaGFm1jQ1h0IYUr3dJ
         6+faT0Y8HupdkR/koBdd1ebYlxSpupb+AF//PK/ZtfyFiZebV8X/wTAbNcgK5Arur2
         RgpxS6j87p6FA==
Date:   Thu, 4 Mar 2021 09:33:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Max Uvarov <muvarov@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: cpufeatures: Fix handling of
 CONFIG_CMDLINE for idreg overrides
Message-ID: <20210304093306.GA20721@willie-the-truck>
References: <20210303134927.18975-1-will@kernel.org>
 <20210303134927.18975-2-will@kernel.org>
 <CAL_JsqLengGX9S0fMUWPR=q6Ng5=JmJXENNqi8Jamv+w0E58bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLengGX9S0fMUWPR=q6Ng5=JmJXENNqi8Jamv+w0E58bg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 04:30:21PM -0600, Rob Herring wrote:
> On Wed, Mar 3, 2021 at 7:50 AM Will Deacon <will@kernel.org> wrote:
> >
> > The built-in kernel commandline (CONFIG_CMDLINE) can be configured in
> > three different ways:
> >
> >   1. CMDLINE_FORCE: Use CONFIG_CMDLINE instead of any bootloader args
> >   2. CMDLINE_EXTEND: Append the bootloader args to CONFIG_CMDLINE
> >   3. CMDLINE_FROM_BOOTLOADER: Only use CONFIG_CMDLINE if there aren't
> >      any bootloader args.
> >
> > The early cmdline parsing to detect idreg overrides gets (2) and (3)
> > slightly wrong: in the case of (2) the bootloader args are parsed first
> > and in the case of (3) the CMDLINE is always parsed.
> >
> > Fix these issues by moving the bootargs parsing out into a helper
> > function and following the same logic as that used by the EFI stub.
> >
> > Reviewed-by: Marc Zyngier <maz@kernel.org>
> > Fixes: 33200303553d ("arm64: cpufeature: Add an early command-line cpufeature override facility")
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/kernel/idreg-override.c | 44 +++++++++++++++++-------------
> >  1 file changed, 25 insertions(+), 19 deletions(-)
> 
> It bothers me a bit having command line handling here. It means how
> the command line is assembled in 2 places.

It's more than 2 places, it's also done in the EFI stub; see efi_pe_entry()
in drivers/firmware/efi/libstub/efi-stub.c. That's why I'm pushing on this,
because at the moment the command-line reported by /proc/cmdline doesn't
match the command-line that was parsed there because they stitch it together
in opposite orders when CMDLINE_EXTEND is used.

> I guess if we get rid of ambiguous 'extend' then it's better, but perhaps
> a better implementation would be an api get a specific command line
> parameter.  The main downside would be searching the DT again for each
> parameter if we can't store any data in between calls, but there's ways
> around that. PowerPC also needs similar functionality in
> disabled_on_cmdline().

Christophe's patches at least aim to put the assembling all in one place,
although we'll have to see whether or not it can be used in the EFI stub
environment.

Will
