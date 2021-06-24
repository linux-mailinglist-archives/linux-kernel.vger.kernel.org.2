Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A48F3B2600
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 06:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFXEJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 00:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbhFXEJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 00:09:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A64EF613CC;
        Thu, 24 Jun 2021 04:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624507604;
        bh=AVYk9Kjb9YIUzHPE+Uh15GvFa4yhwq2OwBOq0u9InVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tsBrCdUL+zOx7kt1L45LH0oVSMjebFmX8uELfzFhQ6ZrqEU0nqRjdlo2N7BAmE8ZC
         qo+FOqRJueMBU5neX87YnnK327OutYHXWascl2eWFZiE3QZuMdFr/txlOBj8KQUjGW
         jB3dj5IjH0J8WoTDw09sVl18ahtrbc5nqed12D2Smi40duK6/wNkF0WO47r6OhT8l+
         w/cyTX1TBRZqLVOi1rnBw/SbLuNpEMZONt/JJ2C/vZGIVE3sKFiYeEDZRY+WUJmLqR
         +TNNauHerq7PuFEpCpM0AMywg1XfR3MXEj7gbVeIku3ZgpUybKiwKTWQ9fQy7EW2SC
         T0AjD+VN7aodw==
Date:   Wed, 23 Jun 2021 21:06:41 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>, Brian Cain <bcain@codeaurora.org>,
        Sid Manning <sidneym@codeaurora.org>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: how can we test the hexagon port in mainline
Message-ID: <YNQE0YJzC2xmWg+2@Ryzen-9-3900X.localdomain>
References: <20210623141854.GA32155@lst.de>
 <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org>
 <CAK8P3a28_0KJpcLRQrDhFk8-ndxmfk7-Q2_qcRRiYkyh-NNZUQ@mail.gmail.com>
 <08e101d76842$94f78a60$bee69f20$@codeaurora.org>
 <20210623151746.GA4247@lst.de>
 <CAK8P3a2bG64ARjpwQ0ZhQ9P0g8B-=AwcHHAbYBXBS4B6Fy9pQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2bG64ARjpwQ0ZhQ9P0g8B-=AwcHHAbYBXBS4B6Fy9pQw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 05:35:38PM +0200, Arnd Bergmann wrote:
> On Wed, Jun 23, 2021 at 5:17 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > It seem like it still isn't complete enought for a kernel build, though:
> >
> > $ export CROSS_COMPILE=/opt/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/hexagon-unknown-linux-musl-
> > $ make ARCH=hexagon LLVM=1 oldconfig
> > ...
> > scripts/Kconfig.include:40: linker 'ld.lld' not found
> 
> I tried this using the prebuilt binaries from apt.llvm.org:
> 
> $ make ARCH=hexagon LLVM=1 O=obj-hexagon CROSS_COMPILE=hexagon-linux-
> LLVM_IAS=1 CC=llvm-12 defconfig modules vmlinux
> <stdin>:1515:2: warning: syscall clone3 not implemented [-W#warnings]
> #warning syscall clone3 not implemented
>  ^
> 1 warning generated.
> 
> Doing the same thing with allmodconfig results in an internal error
> with clang-12
> while compiling kernel/locking/lockdep.c. Same thing with clang-13.
> After turning
> off lock debugging, it seems fine.

I've reported this upstream with you on CC:

https://bugs.llvm.org/show_bug.cgi?id=50838

Christoph, that toolchain should work (I had to install libtinfo5 and
libc++1-7 on Debian Buster):

$ export PATH=$HOME/tmp/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin:$PATH

$ make -skj"$(nproc)" ARCH=hexagon CROSS_COMPILE=hexagon-unknown-linux-musl LLVM=1 LLVM_IAS=1 defconfig all

CROSS_COMPILE is really only used to set the '--target=' flag when
LLVM=1 LLVM_IAS=1 are used, it can even be just 'hexagon-linux'.

As Arnd points out, https://apt.llvm.org is also an option, that is what
we use in our continuous integration:

https://github.com/ClangBuiltLinux/continuous-integration2

Cheers,
Nathan
