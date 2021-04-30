Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEB436F34A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 02:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhD3Axh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 20:53:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhD3Axh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 20:53:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0165861264;
        Fri, 30 Apr 2021 00:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619743970;
        bh=K5IBWra87J8wUjGBcJk1YPVpoR5q+8lnzOJzz7Z0dFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oF/1+OWEBgDxc8NSV5JVB0xUYR+zgyviW9vzvLQUaG/aaRepyWkOPifzjc70GoarN
         WA7T6dCRcVGg+PeeR7v5SBUuMw87lDJFu9NEvItvXFwB+TKsgZu8+IEbF+d59hOm1L
         BcJH9dPR+npkvLBlAFWIE63uFRH2gSeo0m+0yGMFEDsDXocyqVOTYHBjoYql+u740Y
         IjrNTqPqKCVl9WmkJ/ZW894SJo0UhW1IoH5YWk3WUT1qlmeQe67JKtXjOsarBCyk97
         005cLbDT4JgYsMDyXRghCfsp6nqXAWfjDs++99Xt6T+MSsk6UtRpFv1+lDcL3vpJDN
         Eb2IV8uoXX8Lg==
Date:   Thu, 29 Apr 2021 17:52:45 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: Very slow clang kernel config ..
Message-ID: <YItU3YrFi8REwkRA@archlinux-ax161>
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 02:53:08PM -0700, Linus Torvalds wrote:
> I haven't looked into why this is so slow with clang, but it really is
> painfully slow:
> 
>    time make CC=clang allmodconfig
>    real 0m2.667s
> 
> vs the gcc case:
> 
>     time make CC=gcc allmodconfig
>     real 0m0.903s
> 
> Yeah, yeah, three seconds may sound like "not a lot of time, but
> considering that the subsequent full build (which for me is often
> empty) doesn't take all that much longer, that config time clang waste
> is actually quite noticeable.
> 
> I actually don't do allmodconfig builds with clang, but I do my
> default kernel builds with it:
> 
>     time make oldconfig
>     real 0m2.748s
> 
>     time sh -c "make -j128 > ../makes"
>     real 0m3.546s
> 
> so that "make oldconfig" really is almost as slow as the whole
> "confirm build is done" thing. Its' quite noticeable in my workflow.
> 
> The gcc config isn't super-fast either, but there's a big 3x
> difference, so the clang case really is doing something extra wrong.
> 
> I've not actually looked into _why_. Except I do see that "clang" gets
> invoked with small (empty?) test files several times, probably to
> check for command line flags being valid.
> 
> Sending this to relevant parties in the hope that somebody goes "Yeah,
> that's silly" and fixes it.
> 
> This is on my F34 machine:
> 
>      clang version 12.0.0 (Fedora 12.0.0-0.3.rc1.fc34)
> 
> in case it matters (but I don't see why it should).
> 
> Many many moons ago the promise for clang was faster build speeds.
> That didn't turn out to be true, but can we please at least try to
> make them not painfully much slower?

Hi Linus,

I benchmarked this with your latest tree
(8ca5297e7e38f2dc8c753d33a5092e7be181fff0) with my distribution versions
of clang 11.1.0 and gcc 10.2.0 and I saw the same results, benchmarking
with hyperfine.

$ hyperfine -L comp_var "","CC=clang " -r 100 -S /bin/sh -w 5 'make {comp_var}allmodconfig'
Benchmark #1: make allmodconfig
  Time (mean ± σ):      1.490 s ±  0.012 s    [User: 1.153 s, System: 0.374 s]
  Range (min … max):    1.462 s …  1.522 s    100 runs

Benchmark #2: make CC=clang allmodconfig
  Time (mean ± σ):      4.001 s ±  0.020 s    [User: 2.761 s, System: 1.274 s]
  Range (min … max):    3.939 s …  4.038 s    100 runs

Summary
  'make allmodconfig' ran
    2.69 ± 0.03 times faster than 'make CC=clang allmodconfig'

It was also reproducible in a Fedora Docker image, which has newer
versions of those tools than my distro does (GCC 11.1.0 and clang
12.0.0):

$ hyperfine -L comp_var "","CC=clang " -r 100 -S /bin/sh -w 5 'make {comp_var}allmodconfig'
Benchmark #1: make allmodconfig
  Time (mean ± σ):     989.9 ms ±   3.5 ms    [User: 747.0 ms, System: 271.1 ms]
  Range (min … max):   983.0 ms … 998.2 ms    100 runs

Benchmark #2: make CC=clang allmodconfig
  Time (mean ± σ):      3.328 s ±  0.005 s    [User: 2.408 s, System: 0.948 s]
  Range (min … max):    3.316 s …  3.343 s    100 runs

Summary
  'make allmodconfig' ran
    3.36 ± 0.01 times faster than 'make CC=clang allmodconfig'

Unfortunately, I doubt there is much that can be done on the kernel side
because this is reproducible just invoking the compilers without any
source input.

Clang 11.1.0 and GCC 10.2.0:

$ hyperfine -i -L compiler gcc,clang -r 5000 -S /bin/sh -w 5  'echo | {compiler} -x c -c -o /dev/null -'
Benchmark #1: echo | gcc -x c -c -o /dev/null -
  Time (mean ± σ):       9.6 ms ±   1.0 ms    [User: 6.5 ms, System: 3.4 ms]
  Range (min … max):     5.8 ms …  12.7 ms    5000 runs

Benchmark #2: echo | clang -x c -c -o /dev/null -
  Time (mean ± σ):      33.0 ms ±   0.8 ms    [User: 22.4 ms, System: 10.9 ms]
  Range (min … max):    30.3 ms …  36.0 ms    5000 runs

Summary
  'echo | gcc -x c -c -o /dev/null -' ran
    3.45 ± 0.39 times faster than 'echo | clang -x c -c -o /dev/null -'

$ hyperfine -i -L compiler gcc,clang -r 5000 -S /bin/sh -w 5  'echo | {compiler} -Werror -Wflag-that-does-not-exit -x c -c -o /dev/null -'
Benchmark #1: echo | gcc -Werror -Wflag-that-does-not-exit -x c -c -o /dev/null -
  Time (mean ± σ):      11.9 ms ±   1.1 ms    [User: 10.5 ms, System: 1.8 ms]
  Range (min … max):     8.2 ms …  15.1 ms    5000 runs

  Warning: Ignoring non-zero exit code.

Benchmark #2: echo | clang -Werror -Wflag-that-does-not-exit -x c -c -o /dev/null -
  Time (mean ± σ):      31.0 ms ±   0.8 ms    [User: 20.3 ms, System: 10.9 ms]
  Range (min … max):    27.9 ms …  33.8 ms    5000 runs

  Warning: Ignoring non-zero exit code.

Summary
  'echo | gcc -Werror -Wflag-that-does-not-exit -x c -c -o /dev/null -' ran
    2.62 ± 0.26 times faster than 'echo | clang -Werror -Wflag-that-does-not-exit -x c -c -o /dev/null -'

Clang 12.0.0 and GCC 11.1.0:

$ hyperfine -i -L compiler gcc,clang -r 5000 -S /bin/sh -w 5  'echo | {compiler} -x c -c -o /dev/null -'
Benchmark #1: echo | gcc -x c -c -o /dev/null -
  Time (mean ± σ):       8.5 ms ±   0.3 ms    [User: 5.6 ms, System: 3.3 ms]
  Range (min … max):     7.6 ms …   9.8 ms    5000 runs

Benchmark #2: echo | clang -x c -c -o /dev/null -
  Time (mean ± σ):      27.4 ms ±   0.4 ms    [User: 19.6 ms, System: 8.1 ms]
  Range (min … max):    26.4 ms …  29.1 ms    5000 runs

Summary
  'echo | gcc -x c -c -o /dev/null -' ran
    3.22 ± 0.13 times faster than 'echo | clang -x c -c -o /dev/null -'

$ hyperfine -i -L compiler gcc,clang -r 5000 -S /bin/sh -w 5  'echo | {compiler} -Werror -Wflag-that-does-not-exit -x c -c -o /dev/null -'
Benchmark #1: echo | gcc -Werror -Wflag-that-does-not-exit -x c -c -o /dev/null -
  Time (mean ± σ):      12.2 ms ±   0.3 ms    [User: 11.5 ms, System: 1.0 ms]
  Range (min … max):    11.7 ms …  13.9 ms    5000 runs

  Warning: Ignoring non-zero exit code.

Benchmark #2: echo | clang -Werror -Wflag-that-does-not-exit -x c -c -o /dev/null -
  Time (mean ± σ):      26.3 ms ±   0.5 ms    [User: 19.1 ms, System: 7.5 ms]
  Range (min … max):    25.2 ms …  28.1 ms    5000 runs

  Warning: Ignoring non-zero exit code.

Summary
  'echo | gcc -Werror -Wflag-that-does-not-exit -x c -c -o /dev/null -' ran
    2.16 ± 0.06 times faster than 'echo | clang -Werror -Wflag-that-does-not-exit -x c -c -o /dev/null -'

Seems that GCC is faster to complete when it does not have to parse
warning flags while clang shows no major variance. Thinking more about,
cc-option gives clang an empty file so it should not have to actually
parse anything so I do not think '-fsyntax-only' will gain us a whole
ton because we should not be dipping into the backend at all.

Tangentially, my version of clang built with Profile Guided Optimization
gets me closed to GCC. I am surprised to see this level of gain.

$ hyperfine -i -L compiler gcc,clang -r 5000 -S /bin/sh -w 5  'echo | {compiler} -x c -c -o /dev/null -'
Benchmark #1: echo | gcc -x c -c -o /dev/null -
  Time (mean ± σ):       9.6 ms ±   1.0 ms    [User: 6.4 ms, System: 3.5 ms]
  Range (min … max):     5.6 ms …  12.9 ms    5000 runs

Benchmark #2: echo | clang -x c -c -o /dev/null -
  Time (mean ± σ):       8.7 ms ±   1.3 ms    [User: 4.3 ms, System: 4.9 ms]
  Range (min … max):     4.9 ms …  12.1 ms    5000 runs

  Warning: Command took less than 5 ms to complete. Results might be inaccurate.

Summary
  'echo | clang -x c -c -o /dev/null -' ran
    1.10 ± 0.20 times faster than 'echo | gcc -x c -c -o /dev/null -'

$ hyperfine -L comp_var "","CC=clang " -r 100 -S /bin/sh -w 5 'make {comp_var}allmodconfig'
Benchmark #1: make allmodconfig
  Time (mean ± σ):      1.531 s ±  0.011 s    [User: 1.180 s, System: 0.388 s]
  Range (min … max):    1.501 s …  1.561 s    100 runs

Benchmark #2: make CC=clang allmodconfig
  Time (mean ± σ):      1.828 s ±  0.015 s    [User: 1.209 s, System: 0.760 s]
  Range (min … max):    1.802 s …  1.872 s    100 runs

Summary
  'make allmodconfig' ran
    1.19 ± 0.01 times faster than 'make CC=clang allmodconfig'

I think that we should definitely see what we can do to speed up the front end.

Cheers,
Nathan
