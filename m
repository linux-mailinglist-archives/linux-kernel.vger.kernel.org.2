Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C84D342CA2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhCTL6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhCTL6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:58:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D545619A4;
        Sat, 20 Mar 2021 09:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616232190;
        bh=DMICtap81nrcNevqRi6mOgs+0SnC17i8Miyqc73XLEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=anyNSC41S9k/EEJL7nC3xZD4kvzHe6L3dkBjG90FlKbISz6y5bC/wewYOgNaZxgWx
         k2GeTApNpYEIR0GOo550TKNcNBdzxpz5K2TncRBCqpE8OszXWOVouEsGVuULXSRdrz
         XnGQhuyhHm9Siti/jP6TC7VM4+mNph36W7cVGYJrSCrFa41SdYep/ZSj49TnEqvKoN
         6Amt2mps3Go35txs1gFAxtLyrbTxMGF9slqTkiv5l19QLVgEvKC7NtymhVtYTFCoYM
         Li05cLplSfmzrcradDW2yHrJChDH9HckUYTtj7SBzwNnKqRZMt+NSmiXZX2gjDiZ5M
         63hPpNsccZjwA==
Date:   Sat, 20 Mar 2021 11:23:05 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH master] module: remove never implemented
 MODULE_SUPPORTED_DEVICE
Message-ID: <YFW++S+TTCK/3dfO@unreal>
References: <20210317104547.442203-1-leon@kernel.org>
 <CAHk-=wj+Bsc1T41qziHxf9DvrBrYSBWKj27hEL0EbysCGRPzTA@mail.gmail.com>
 <YFMHYUbPmpS+Kzcj@unreal>
 <CAHk-=wgdHxuQmhKR9oAS5bhahmo5CFj3x6YdHVPBCGhbSz6rEg@mail.gmail.com>
 <YFOSpQcrfP1UvqoL@unreal>
 <CAHk-=wjZoOr4yqAAxricTsachacAUvcKt6HOfxyReCyMN0V=QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjZoOr4yqAAxricTsachacAUvcKt6HOfxyReCyMN0V=QQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:55:51AM -0700, Linus Torvalds wrote:
> On Thu, Mar 18, 2021 at 10:49 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > No, I opened patch and added the note manually, so it is definitely my VIM.
> > Most likely this part of my .vimrc caused it.
> 
> Ok, that would do it.
> 
> Yeah, whitespace is easy to "fix" at patch application time, but it
> really is meaningful and you never should change whitespace for
> patches.
> 
> Maybe you can limit your rules to just particular file types
> (although, honestly, I think it's bad for headers and C files too when
> it then causes entirely irrelevant and independent changes - you only
> want your own _new_ edits to be whitespace-clean, not fix other random
> issues).
> 
> Better yet, maybe not "fix whitespace" at all, but have some code
> coloring logic that just points out bad whitespace? I use "git diff"
> myself, with colorization being default for tty operations:
> 
>     [color]
>         ui=auto
> 
> so that then "git diff" will show you your (new) evil whitespace
> errors when you review your changes, but won't complain about existing
> whitespace issues..

Yeah, my color.ui is "always", so I will simply remove the problematic
line from VIM and won't change whitespaces at all.

Thanks

> 
>                       Linus
