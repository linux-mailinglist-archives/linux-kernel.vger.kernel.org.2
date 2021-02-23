Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E49D32327D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhBWUws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:52:48 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:34858 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbhBWUub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:50:31 -0500
Date:   Tue, 23 Feb 2021 20:49:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1614113387; bh=b6K9n2VrdVy+2EiLHTIR/SAICycUS8q6OJquatFdjug=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=V3Nj1iHilz85jaB1r1udLi5FbvC8cqqO6yRX9+QjO7QecGboRyW0D1GZtq2xzFS5b
         FgBz7QSohCnqLIdOiOkAdbqj7ls+3FydUEAeM/llXLiFZJ/fKliW8a+dKpK1rWrcwS
         2VS/0evLOQY8GryR32TWPmxqCI5L/grxeNXtTaCPnAvlH8l50DZqYde2g3gBFd4luX
         QOqalW3kSY+E8O0s/ulEsn73LXPN8tMDfydAmpEaZuinIqTLfvZqI4Sjf4olAA6BOl
         jBfnkaM+NeeBNehRwc3J6VuMz3XSbLMWLDYg43npBLgiRUE4lXksWObyc2yXJJyRXf
         oZuvVpEbAFGEQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <morbo@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        George Burgess IV <gbiv@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [GIT PULL v2] clang-lto for v5.12-rc1
Message-ID: <20210223204919.549167-1-alobakin@pm.me>
In-Reply-To: <CAHk-=wgQ=oaLD_ybzhOP+8LFNZH3Qzpc-dp4XB4cXxXLReCdnQ@mail.gmail.com>
References: <202102221504.0418BE2D1@keescook> <CAHk-=wgUS-vqCk_d0wwBWgk4tRgFpYvfyob5y28c85msqpbjuw@mail.gmail.com> <CAHk-=wgQ=oaLD_ybzhOP+8LFNZH3Qzpc-dp4XB4cXxXLReCdnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Feb 2021 12:33:05 -0800

> On Tue, Feb 23, 2021 at 9:49 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, Feb 22, 2021 at 3:11 PM Kees Cook <keescook@chromium.org> wrote=
:
> > >
> > > While x86 LTO enablement is done[1], it depends on some objtool
> > > clean-ups[2], though it appears those actually have been in linux-nex=
t
> > > (via tip/objtool/core), so it's possible that if that tree lands [..]
> >
> > That tree is actually next on my list of things to merge after this
> > one, so it should be out soonish.
>
> "soonish" turned out to be later than I thought, because my "build
> changes" set of pulls included the module change that I then wasted a
> lot of time on trying to figure out why it slowed down my build so
> much.

I guess it's about CONFIG_TRIM_UNUSED_KSYMS you disabled in your tree.
Well, it's actually widely used, mostly in the embedded world where
there are often no out-of-tree modules, but a need to save as much
space as possible.
For full-blown systems and distributions it's almost needless, right.

> But it's out now, as pr-tracker-bot already noted.
>
>               Linus

Thanks,
Al

