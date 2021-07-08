Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F167F3BF513
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 07:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhGHFag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 01:30:36 -0400
Received: from verein.lst.de ([213.95.11.211]:39235 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhGHFag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 01:30:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB4DC68C4E; Thu,  8 Jul 2021 07:27:51 +0200 (CEST)
Date:   Thu, 8 Jul 2021 07:27:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Brian Cain <bcain@codeaurora.org>,
        Sid Manning <sidneym@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: how can we test the hexagon port in mainline
Message-ID: <20210708052751.GA18789@lst.de>
References: <20210623141854.GA32155@lst.de> <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org> <CAK8P3a28_0KJpcLRQrDhFk8-ndxmfk7-Q2_qcRRiYkyh-NNZUQ@mail.gmail.com> <08e101d76842$94f78a60$bee69f20$@codeaurora.org> <20210623151746.GA4247@lst.de> <CAK8P3a2bG64ARjpwQ0ZhQ9P0g8B-=AwcHHAbYBXBS4B6Fy9pQw@mail.gmail.com> <YNQE0YJzC2xmWg+2@Ryzen-9-3900X.localdomain> <20210707141054.GA24828@lst.de> <1ee8fc44-3e8c-91c0-7909-a636757dbda4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ee8fc44-3e8c-91c0-7909-a636757dbda4@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 10:42:27AM -0700, Nathan Chancellor wrote:
>> hch@brick:~/work/linux$ make -j4 ARCH=hexagon
>> CROSS_COMPILE=hexagon-unknown-linux-musl LLVM=1 LLVM_IAS=1 defconfig all
>> HOSTCC  scripts/basic/fixdep
>> clang: error while loading shared libraries: libtinfo.so.5: cannot open shared object file: No such file or directory
>
> Hmmm, is that with libtinfo5 installed (or whatever the ncurses-compat 
> equivalent is on your distribution installed)? I had that problem on Debian 
> until I insta

I did install libtinfo5, which just gets me to the next error:

hch@brick:~/work/linux$ export PATH=/opt/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/:$PATH
hch@brick:~/work/linux$ make -j4 ARCH=hexagon CROSS_COMPILE=hexagon-unknown-linux-musl LLVM=1 LLVM_IAS=1 defconfig all
  HOSTCC  scripts/basic/fixdep
clang: error while loading shared libraries: libc++.so.1: cannot open shared object file: No such file or directory
make[2]: *** [scripts/Makefile.host:95: scripts/basic/fixdep] Error 127
make[1]: *** [Makefile:543: scripts_basic] Error 2
make: *** [Makefile:346: __build_one_by_one] Error 2

