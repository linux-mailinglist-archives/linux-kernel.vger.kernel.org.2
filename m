Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFF6328123
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbhCAOmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:42:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236488AbhCAOmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:42:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79ACF6146D;
        Mon,  1 Mar 2021 14:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614609720;
        bh=A8uvgt2qITNiFx+O5TMfvqSj4kp8O0GQYgdE+yNAFZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U32ZnyzNuFxVGAvPJ2ZT4hvEfjXEbHwS4KdUK50MYVWI7Ltxpdi9gqdnA02eLyzqG
         WXoHEWPYP0RwJz6kW6fwXpkGSFRhts1XKAIYsor0N3x4kD1w1zDYRh3OFCJfZg3phY
         H8Ym+mYpq34a7DHpCztHTUqw01RTrNZGItBjy8cGiBsredQgW6ZhRLnreRSX1Y5oN5
         KtMobEll+DtAYzNVHvi/6UX0i+Zo/uvB+C4NB8uXIfrX0KVei4P4OPGMOtz8piINFo
         JThDquLAWOnhV0oYQ95MLdd1OZ/kxVWzKXVyAQX5PhUw81WESpVSgn+PdJDyhohvl5
         X0GZa4HOFjOoQ==
Date:   Mon, 1 Mar 2021 14:41:54 +0000
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
Subject: Re: [PATCH 0/2] Fix CMDLINE_EXTEND handling for FDT "bootargs"
Message-ID: <20210301144153.GA16716@willie-the-truck>
References: <20210225125921.13147-1-will@kernel.org>
 <CAL_JsqJX=TCCs7=gg486r9TN4NYscMTCLNfqJF9crskKPq-bTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJX=TCCs7=gg486r9TN4NYscMTCLNfqJF9crskKPq-bTg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 08:19:32AM -0600, Rob Herring wrote:
> On Thu, Feb 25, 2021 at 6:59 AM Will Deacon <will@kernel.org> wrote:
> > We recently [1] enabled support for CMDLINE_EXTEND on arm64, however
> > when I started looking at replacing Android's out-of-tree implementation [2]
> 
> Did anyone go read the common, reworked version of all this I
> referenced that supports prepend and append. Here it is again[1].
> Maybe I should have been more assertive there and said 'extend' is
> ambiguous.

I tried reading that, but (a) most of the series is not in the mailing list
archives and (b) the patch that _is_ doesn't touch CMDLINE_EXTEND at all.
Right now the code in mainline does the opposite of what it's documented to
do.

> > with the upstream version, I noticed that the two behave significantly
> > differently: Android follows the Kconfig help text of appending the
> > bootloader arguments to the kernel command line, whereas upstream appends
> > the kernel command line to the bootloader arguments. That is, except for
> > the EFI stub, which follows the documented behaviour.
> >
> > I think the documented behaviour is more useful, so this patch series
> > reworks the FDT code to follow that and updates the very recently merged
> > arm64 idreg early command-line parsing as well.
> 
> I can just as easily argue that the kernel having the last say makes
> sense.

Dunno, I'd say that's what CMDLINE_FORCE is for. Plus you'd be arguing
against both the documentation and the EFI stub implementation.

> Regardless, I'm pretty sure there's someone out there relying on current
> behavior. What is the impact of this change to other arches?

On arm64, I doubt it, as Android is the main user of this (where it's been
supported for 9 years with the documented behaviour).

The other option, then, is reverting CMDLINE_EXTEND from arm64 until this is
figured out. I think that's preferable to having divergent behaviour.

As for other architectures, I think the ATAGs-based solution on arch/arm/
gets it right:

  static int __init parse_tag_cmdline(const struct tag *tag)
  {
  #if defined(CONFIG_CMDLINE_EXTEND)
          strlcat(default_command_line, " ", COMMAND_LINE_SIZE);
          strlcat(default_command_line, tag->u.cmdline.cmdline,
                  COMMAND_LINE_SIZE);

For now I think we have two options for arm64: either fix the fdt code,
or revert CMDLINE_EXTEND until the PREPEND/APPEND series is merged. Which
do you prefer?

Will
