Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC84C34BC1D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 13:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhC1LMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 07:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229593AbhC1LMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 07:12:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDE126192F;
        Sun, 28 Mar 2021 11:12:17 +0000 (UTC)
Date:   Sun, 28 Mar 2021 12:12:15 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64: move --fix-cortex-a53-843419 linker test to
 Kconfig
Message-ID: <20210328111213.GA17535@arm.com>
References: <20210324071128.1723273-1-masahiroy@kernel.org>
 <20210326143630.GD5126@arm.com>
 <CAK7LNATGo1NkcRF7qo1wF1w3jrOpTQPJf1XPryUz13L8OpaSxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATGo1NkcRF7qo1wF1w3jrOpTQPJf1XPryUz13L8OpaSxA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 03:59:29PM +0900, Masahiro Yamada wrote:
> On Fri, Mar 26, 2021 at 11:36 PM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Wed, Mar 24, 2021 at 04:11:28PM +0900, Masahiro Yamada wrote:
> > > $(call ld-option, --fix-cortex-a53-843419) in arch/arm64/Makefile is
> > > evaluated every time even for Make targets that do not need the linker,
> > > such as "make ARCH=arm64 install".
> > >
> > > Recently, the Kbuild tree queued up a patch to avoid needless
> > > compiler/linker flag evaluation. I beleive it is a good improvement
> > > itself, but causing a false-positive warning for arm64 installation
> > > in linux-next. (Thanks to Nathan for the report)
> > >
> > > Kconfig can test the linker capability just once, and store it in the
> > > .config file. The build and installation steps that follow do not need
> > > to test the liniker over again.
> > >
> > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > > I was not sure what the preferred CONFIG option name is.
> > > Please suggest a one if you have a better idea.
> > >
> > >
> > >  arch/arm64/Kconfig  | 3 +++
> > >  arch/arm64/Makefile | 2 +-
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > Would you like this patch to go in via the arm64 tree or you will queue
> > it via the kbuild tree?
> 
> I applied this to linux-kbuild with Will's Ack.

Great, I'll cross it off my list. Thanks.

-- 
Catalin
