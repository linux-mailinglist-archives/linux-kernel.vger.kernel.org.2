Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F0543CCBC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbhJ0Oxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:53:41 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:60064 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhJ0OxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:53:13 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4HfWp413gwz1rk5Y;
        Wed, 27 Oct 2021 16:50:36 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4HfWp4017Qz1qqkD;
        Wed, 27 Oct 2021 16:50:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id mvw_Vf1g8ae4; Wed, 27 Oct 2021 16:50:34 +0200 (CEST)
X-Auth-Info: uyeUEsOYKs8g0PlgbxUncJma1HMUm74E4sgRZWggIapnCF9LPFgALkqIfuqoYU9Q
Received: from igel.home (ppp-46-244-163-205.dynamic.mnet-online.de [46.244.163.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 27 Oct 2021 16:50:34 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id C36B92C28AC; Wed, 27 Oct 2021 16:50:33 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Saleem Abdulrasool <abdulras@google.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3] riscv: explicitly use symbol offsets for VDSO
References: <20210804173214.1027994-1-abdulras@google.com>
X-Yow:  I've got to get these SNACK CAKES to NEWARK by DAWN!!
Date:   Wed, 27 Oct 2021 16:50:33 +0200
In-Reply-To: <20210804173214.1027994-1-abdulras@google.com> (Saleem
        Abdulrasool's message of "Wed, 4 Aug 2021 17:32:14 +0000")
Message-ID: <874k92a5dy.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 04 2021, Saleem Abdulrasool wrote:

> The current implementation of the `__rt_sigaction` reference computed an
> absolute offset relative to the mapped base of the VDSO.  While this can
> be handled in the medlow model, the medany model cannot handle this as
> it is meant to be position independent.  The current implementation
> relied on the BFD linker relaxing the PC-relative relocation into an
> absolute relocation as it was a near-zero address allowing it to be
> referenced relative to `zero`.
>
> We now extract the offsets and create a generated header allowing the
> build with LLVM and lld to succeed as we no longer depend on the linker
> rewriting address references near zero.  This change was largely
> modelled after the ARM64 target which does something similar.
>
> Signed-off-by: Saleem Abdulrasool <abdulras@google.com>

I think this broke out-of-tree module builds.

https://build.opensuse.org/package/live_build_log/openSUSE:Factory:RISCV/rtl8812au/standard/riscv64

+ make -j4
make ARCH=riscv CROSS_COMPILE= -C /usr/src/linux-obj/riscv64/default M=/home/abuild/rpmbuild/BUILD/rtl8812au-5.9.3.2+git20210427.6ef5d8f/obj/default  modules
make[1]: Entering directory '/usr/src/linux-5.14.14-1-obj/riscv64/default'
mkdir: cannot create directory 'arch/riscv/kernel': Permission denied
  LDS     arch/riscv/kernel/vdso/vdso.lds
  AS      arch/riscv/kernel/vdso/rt_sigreturn.o
  CC      arch/riscv/kernel/vdso/vgettimeofday.o
  AS      arch/riscv/kernel/vdso/getcpu.o
mkdir: cannot create directory 'arch/riscv/kernel': Permission denied
  LDS     arch/riscv/kernel/vdso/vdso.lds
  AS      arch/riscv/kernel/vdso/rt_sigreturn.o
  CC      arch/riscv/kernel/vdso/vgettimeofday.o
  AS      arch/riscv/kernel/vdso/getcpu.o
cc1: fatal error: opening output file arch/riscv/kernel/vdso/vdso.lds: No such file or directory
compilation terminated.
make[3]: *** [/usr/src/linux-5.14.14-1/scripts/Makefile.build:366: arch/riscv/kernel/vdso/vdso.lds] Error 1

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
