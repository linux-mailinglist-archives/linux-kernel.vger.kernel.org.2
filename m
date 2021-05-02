Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D765D370E15
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 18:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhEBQqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 12:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhEBQqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 12:46:44 -0400
Received: from mail.stusta.mhn.de (mail.stusta.mhn.de [IPv6:2001:4ca0:200:3:200:5efe:8d54:4505])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C5AC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 09:45:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.stusta.mhn.de (Postfix) with ESMTPSA id 4FYBn53n2Nz4c;
        Sun,  2 May 2021 18:45:45 +0200 (CEST)
Date:   Sun, 2 May 2021 19:45:42 +0300
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
Message-ID: <20210502164542.GA4522@localhost>
References: <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com>
 <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <20210502093123.GC12293@localhost>
 <CAHk-=wgdUMt_n84mq93LZKA6jOGqZpD+=KeVzA3YmvJ6=JPyhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgdUMt_n84mq93LZKA6jOGqZpD+=KeVzA3YmvJ6=JPyhw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2021 at 09:12:37AM -0700, Linus Torvalds wrote:
> On Sun, May 2, 2021 at 2:31 AM Adrian Bunk <bunk@kernel.org> wrote:
> >
> > The biggest advantage of shared libraries is that they enable
> > distributions to provide security fixes.
> 
> Adrian - you're ignoring the real argument, to the point that the
> above is basically a lie.
> 
> The argument was never that things like libc or the core GUI libraries
> shouldn't be shared.
> 
> The argument was that the "one-off" libraries shouldn't be shared.
> 
> Things very much like libLLVM.so.
>...

Mesa and PostgreSQL are among the packages that do use libLLVM.so,
this is a popular library for implementing compilers and JITs.

>             Linus

cu
Adrian
