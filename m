Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6E9378DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240290AbhEJMxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344135AbhEJMPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 08:15:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDCC5613DE;
        Mon, 10 May 2021 12:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620648845;
        bh=oknEwHzMPPkZFWU6MwSCyhExTODJFvqRKxvu9Eb200o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJ6/jLvdm6YhTwXdMGvB7/9B+BfWqISXnm+3EVe2cWW6i+77kI6CIOXAx2e8MxFsW
         HVFYzRPElSJczZ3kBCsuDMK7DF39mKCeupzZNJ4LY95xpv3hYEjpRnUjL9oNYACUHf
         nHYFuE/jwEJwNBM/ZBudGeQjuJRvlUWmZJa9R3Et/eiwIlwdrT8XGWqeMGRA3PbpBU
         7Ji9yZxHqcxooDVXxYng4faMkWHVr4HNE8p4WZIQc2bruSV3/wU1Rn/a08AP1mknk7
         +sbAl7WmaladIJXZtH4rsP5pkRrZx5BcZp9nq9SQ+BFJ+iDqTCb8RB+sCXU/Nzcida
         i6fo0o/BMIf4A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 77B1C4034C; Mon, 10 May 2021 09:14:01 -0300 (-03)
Date:   Mon, 10 May 2021 09:14:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/perf: build issues with Clang on arm64 and CFLAGS
Message-ID: <YJkjibvlIOwfaQ+u@kernel.org>
References: <162037766527.94840.4323848545957010011.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162037766527.94840.4323848545957010011.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 07, 2021 at 05:54:25PM +0900, Masami Hiramatsu escreveu:
> Hi Arnaldo,
> 
> Recently, I tested the perf build by clang on arm64 and found an issue

Cross building? What toolchain? I regularly build perf with lots of
clang versions, but cross building with clang isn't yet performed in my
tests.

> in arch/arm64/util/kvm-stat.c, related to missing-field-initializers warning.
> 
> ----
>  tools/perf $ make CC=clang LLVM=1 
> ...
> arch/arm64/util/kvm-stat.c:74:9: error: missing field 'ops' initializer [-Werror,-Wmissing-field-initializers]
>         { NULL },
>                ^
> 1 error generated.
> ----
> 
> That error itself can be fixed easily by just adding field initializers
> [1/1] Note that I didn't add Fixes tag, because I'm not sure clang build
> of perf is officially supported or not, and this seems correct C code
> to initialize a data structure with zero.(*)

I'd say it is supported, at least by me, for quite a while, as can be
seen in all pull requests I send upstream, for instance:

https://lore.kernel.org/linux-perf-users/YIxSJ7bdtjv4wHok@kernel.org/

  # export PERF_TARBALL=http://192.168.86.5/perf/perf-5.12.0.tar.xz
  # dm 
   1    72.92 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
   2    74.56 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
   3    81.19 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
   4    90.07 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   5    83.40 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   6    85.30 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   7   110.88 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   8   140.86 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
   9   127.60 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
  10   278.42 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
  11   235.62 alpine:edge                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
  12   161.23 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
  13   390.70 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
  14    95.00 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 10.2.1 20210313 (ALT Sisyphus 10.2.1-alt3) , clang version 10.0.1 
  15    77.78 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
  16   103.23 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-12) , clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
  17    22.16 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease) 
  18    22.10 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease) 
  19    25.74 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23) 
  20    31.40 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44) 
  21    97.31 centos:8                      : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5) , clang version 10.0.1 (Red Hat 10.0.1-1.module_el8.3.0+467+cb298d5b)
  22    60.94 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 10.2.1 20201217 releases/gcc-10.2.0-643-g7cbb07d2fc , clang version 10.0.1 
  23    77.23 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2 , Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  24    82.00 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
  25    75.27 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
  26    74.40 debian:experimental           : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  27    32.81 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  28    28.53 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-3) 10.2.1 20201224 
  29    30.96 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-3) 10.2.1 20201224 
  30    31.13 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 10.2.1-3) 10.2.1 20201224 
  31    29.13 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7) 
  32    29.51 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
  33    68.17 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
  34    80.83 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
  35    26.32 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
  36    82.85 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
  37    94.47 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
  38    96.40 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
  39   108.54 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
  40   113.97 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  41   119.26 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  42    25.92 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
  43   117.82 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  44    97.12 fedora:32                     : Ok   gcc (GCC) 10.2.1 20201125 (Red Hat 10.2.1-9) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  45    94.80 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-2.fc33)
  46    99.46 fedora:34                     : Ok   gcc (GCC) 11.0.1 20210324 (Red Hat 11.0.1-0) , clang version 12.0.0 (Fedora 12.0.0-0.3.rc1.fc34)
  47    98.91 fedora:rawhide                : Ok   gcc (GCC) 11.0.1 20210423 (Red Hat 11.0.1-0) , clang version 12.0.0 (Fedora 12.0.0-1.fc35)
  48    34.11 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 9.3.0-r1 p3) 9.3.0 
  49    66.98 mageia:5                      : Ok   gcc (GCC) 4.9.2 , clang version 3.5.2 (tags/RELEASE_352/final)
  50    83.81 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
  51    48.52 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
          yychar = yylex (&yylval, &yylloc, scanner);
                   ^
    #define yylex           parse_events_lex
                            ^
    1 error generated.
    make[3]: *** [/git/perf-5.12.0/tools/build/Makefile.build:139: util] Error 2
  52   221.66 openmandriva:cooker           : Ok   gcc (GCC) 10.3.0 20210408 (OpenMandriva) , OpenMandriva 12.0.0-1 clang version 12.0.0 (/builddir/build/BUILD/llvm-project-llvmorg-12.0.0/clang b3a1e025e0452bb54d01ab5281bbf509ac4e3c72)
  53   119.19 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
  54   127.85 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  55   117.53 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
  56   131.22 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  57   114.64 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5 , clang version 3.8.0 (tags/RELEASE_380/final 262553)
  58   108.83 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 10.2.1 20200825 [revision c0746a1beb1ba073c7981eb09f55b3d993b32e5c] , clang version 10.0.1 
  59    25.02 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1) 
  60    30.76 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44.0.3) 
  61    95.29 oraclelinux:8                 : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5.0.2) , clang version 10.0.1 (Red Hat 10.0.1-1.0.1.module+el8.3.0+7827+89335dbf)
  62    25.85 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3 , Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final) (based on LLVM 3.0)
  63    29.09 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4 
  64    81.27 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  65    27.09 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  66    27.59 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  67    26.25 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  68    26.87 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  69    27.69 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  70    26.58 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  71    88.21 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  72    28.46 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  73    29.25 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  74    23.59 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  75    27.97 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  76    29.83 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  77    30.41 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  78   172.25 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  79    26.09 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  80    28.18 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  81    26.43 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  82    76.46 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0 , clang version 10.0.0-4ubuntu1 
  83    31.35 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.2.0-5ubuntu1~20.04) 10.2.0 
  84    74.85 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.2.0-13ubuntu1) 10.2.0 , Ubuntu clang version 11.0.0-2
  85    71.63 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-1ubuntu1


But I couldn't find so far, and I haven't researched this lately, a distro that has all the
devel packages cross-built so that I could cross build a full featured perf tool, are you
aware of one? In the -x-ARCH tests above I end up just manually cross-building elfutils and zlib
to get a minimal perf cross build.
 
> And while investigating the error, I found another issue in the Makefile.config.
> 
> It seems to make CFLAGS from CORE_CFLAGS, INC_FLAGS, EXTRA_CFLAGS, EXTRA_WARNINGS
> in the following order;
> 
> CFLAGS = $EXTRA_CFLAGS $EXTRA_WARNINGS $CORE_CFLAGS $INC_FLAGS
> 
> But since CORE_CFLAGS includes -Wall and -Wextra, the other -Wno-XXXX in
> EXTRA_CFLAGS and EXTRA_WARNINGS are overriden and ignored.
> So, I think it is better to define it as
> 
> CFLAGS = $CORE_CFLAGS $INC_FLAGS $EXTRA_CFLAGS $EXTRA_WARNINGS
> 
> But I also saw some configs tweaks CFLAGS directly. I think they should
> modify EXTRA_CFLAGS.
> 
> My question is that this order is intentional or not. I might
> miss something on it.

Oh the joy with Makefiles.. Most likely unintentional, please submit a patch, please reuse
your wording above to justify it.

> (*) BTW, there seems a discussion on the clang warning behavior,
>  because gcc doesn't warn it anymore
>  (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=36750).
>  It might be better to add -Wno-missing-field-initializers in case
>  of CC=clang by default.

Humm, unsure about that, I applied your patch, but I'd say it'd be better to
use the variant that initialized the first field to zero/NULL and then all the
other (not explicitely initialized) ones will be zeroed.

> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (1):
>       tools/perf: Fix a build error on arm64 with clang
> 
> 
>  tools/perf/arch/arm64/util/kvm-stat.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

-- 

- Arnaldo
