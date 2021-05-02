Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA78370AE9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 11:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhEBJh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 05:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhEBJh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 05:37:27 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 May 2021 02:36:36 PDT
Received: from mail.stusta.mhn.de (mail.stusta.mhn.de [IPv6:2001:4ca0:200:3:200:5efe:8d54:4505])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6A5C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 02:36:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.stusta.mhn.de (Postfix) with ESMTPSA id 4FY17x3YVmz58;
        Sun,  2 May 2021 11:31:25 +0200 (CEST)
Date:   Sun, 2 May 2021 12:31:23 +0300
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
Message-ID: <20210502093123.GC12293@localhost>
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com>
 <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2021 at 09:32:25AM -0700, Linus Torvalds wrote:
>...
> Yes, it can save on disk use, but unless it's some very core library
> used by a lot of things (ie particularly things like GUI libraries
> like gnome or Qt or similar), the disk savings are often not all that
> big - and disk is cheap. And the memory savings are often actually
> negative (again, unless it's some big library that is typically used
> by lots of different programs at the same time).
>...
> I think people have this incorrect picture that "shared libraries are
> inherently good". They really really aren't. They cause a lot of
> problems, and the advantage really should always be weighed against
> those (big) disadvantages.
>...

Disk and memory usage is not the biggest advantage.

The biggest advantage of shared libraries is that they enable 
distributions to provide security fixes.

Distributions try hard to have only one place to patch and one package  
to rebuild when a CVE has to be fixed.

It is not feasible to rebuild all users of a library in a
distribution every time a CVE gets published for a library.

Some of the new language ecosystems like Go or Rust do not offer
shared libraries.

At the end of this email are some of the recent CVEs in Rust.

Q:
What happens if you use a program provided by your distribution that is 
written in Rust and handles untrusted input in a way that it might be 
vulnerable to exploits based on one of these CVEs?

A:
The program has a known vulnerability that will likely stay unfixed.

This is of course not a problem for the rare software like Firefox or 
the kernel that have CVEs themselves so regularly that they get rebuilt 
all the time.

>                         Linus

cu
Adrian


CVE-2020-36317  In the standard library in Rust before 1.49.0,
String::retain() function has a panic safety problem. It allows creation
of a non-UTF-8 Rust string when the provided closure panics. This bug
could result in a memory safety violation when other string APIs assume
that UTF-8 encoding is used on the same string.

CVE-2020-36318  In the standard library in Rust before 1.49.0,
VecDeque::make_contiguous has a bug that pops the same element more than
once under certain condition. This bug could result in a use-after-free
or double free.

CVE-2020-36323  In the standard library in Rust before 1.52.0, there is
an optimization for joining strings that can cause uninitialized bytes
to be exposed (or the program to crash) if the borrowed string changes
after its length is checked.

CVE-2021-28875  In the standard library in Rust before 1.50.0,
read_to_end() does not validate the return value from Read in an unsafe
context. This bug could lead to a buffer overflow.

CVE-2021-31162  In the standard library in Rust before 1.53.0, a double
free can occur in the Vec::from_iter function if freeing the element
panics.

