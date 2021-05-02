Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CD0370E4D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 19:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhEBR4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 13:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhEBR4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 13:56:12 -0400
Received: from mail.stusta.mhn.de (mail.stusta.mhn.de [IPv6:2001:4ca0:200:3:200:5efe:8d54:4505])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8C4C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 10:55:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.stusta.mhn.de (Postfix) with ESMTPSA id 4FYDKD16tGz4c;
        Sun,  2 May 2021 19:55:11 +0200 (CEST)
Date:   Sun, 2 May 2021 20:55:10 +0300
From:   Adrian Bunk <bunk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tom Stellard <tstellar@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Subject: Re: Very slow clang kernel config ..
Message-ID: <20210502175510.GB4522@localhost>
References: <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com>
 <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <20210502093123.GC12293@localhost>
 <CAHk-=wgdUMt_n84mq93LZKA6jOGqZpD+=KeVzA3YmvJ6=JPyhw@mail.gmail.com>
 <20210502164542.GA4522@localhost>
 <CAHk-=winSraiwc4gC5WFWSehFq+s7AqCJZoMqUuHLX0nYVG0nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=winSraiwc4gC5WFWSehFq+s7AqCJZoMqUuHLX0nYVG0nQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2021 at 09:49:44AM -0700, Linus Torvalds wrote:
> On Sun, May 2, 2021 at 9:45 AM Adrian Bunk <bunk@kernel.org> wrote:
> >
> > Mesa and PostgreSQL are among the packages that do use libLLVM.so,
> > this is a popular library for implementing compilers and JITs.
> 
> Yes, and it's entirely reasonable to update those packages if it turns
> out libLLVM has a bug in it.
> 
> Because we're talking about a small handful of packages, not some kind
> of "everything" model.
> 
> So again, what's your point?

Two dozen other packages are linking directly with libLLVM.so.

Are you happy about libclang.so being a shared library?
libclang.so uses libLLVM.so, which adds another 10 indirect users.

Debian ships 30k source packages that build 60k binary packages,
with 3 years of security support (plus 2 years LTS).

It makes things a lot easier from a distribution point of view if a bug 
in libLLVM can be fixed just there, instead of having to additionally 
find and rebuild the 30 or more source packages building binary packages 
that use libLLVM in a security update for a stable release of a distribution.

>              Linus

cu
Adrian
