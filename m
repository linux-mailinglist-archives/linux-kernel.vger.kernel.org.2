Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895CF40B491
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhINQ1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:27:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhINQ1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:27:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60D98610F9;
        Tue, 14 Sep 2021 16:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631636763;
        bh=xX1AwWALuEqDvNiRE20sZBFCcz35ddef9yjN595pBYI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C0uphVOHv6qLAJsFKY0KRYV379dxtTaXLzr3XqGFHHCS3xHb8S1OZsMKvQWHXYcKq
         F4TC+GkEN/Xo0pzRayxTxiUcprjXSJLzSzafAvWelFhSp1UGo0S5sk7bsNjiG6Mubo
         efoJRKSLp37JpaLhtChHfRh5PoigdfLME68wCdsIsBabKXyy8e0jRYw0h5zbNPBRCz
         ov2mj4WyktVsBB2LctVE6QPjhLBzUBMdqxRexEt0kjRrJHtXavn+3LtZZz2wrNIJ3X
         RNrrI7U+SNBDysi2tkDatAJq97ssFoMg7o9LGaQ1vpKyNxfJRNVCYO80jktLe7Q7cV
         eayKLFHTKaPeA==
Subject: Re: linux: build faulure: error: "__has_attribute" is not defined
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <c1b1a299-c60d-28a4-07ab-1ecd211d6da9@i-love.sakura.ne.jp>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <3bf6f4f4-9c96-6e0c-951d-5509175dddfe@kernel.org>
Date:   Tue, 14 Sep 2021 09:26:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c1b1a299-c60d-28a4-07ab-1ecd211d6da9@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tetsuo,

On 9/14/2021 6:41 AM, Tetsuo Handa wrote:
> Hello.
> 
> With gcc (GCC) 8.3.1 20190311 (Red Hat 8.3.1-3) on d0ee23f9d78be553 ("tools:
> compiler-gcc.h: Guard error attribute use with __has_attribute"), I get
> 
>    CC      /usr/src/linux/tools/objtool/exec-cmd.o
> In file included from /usr/src/linux/tools/include/linux/compiler_types.h:36:0,
>                   from /usr/src/linux/tools/include/linux/compiler.h:5,
>                   from exec-cmd.c:2:
> /usr/src/linux/tools/include/linux/compiler-gcc.h:19:5: error: "__has_attribute" is not defined [-Werror=undef]
>   #if __has_attribute(__error__)
>       ^
> /usr/src/linux/tools/include/linux/compiler-gcc.h:19:20: error: missing binary operator before token "("
>   #if __has_attribute(__error__)
>                      ^
> cc1: all warnings being treated as errors
> make[5]: *** [/usr/src/linux/tools/objtool/exec-cmd.o] Error 1
> make[4]: *** [/usr/src/linux/tools/objtool/libsubcmd-in.o] Error 2
> make[3]: *** [/usr/src/linux/tools/objtool/libsubcmd.a] Error 2
> make[2]: *** [objtool] Error 2
> make[1]: *** [tools/objtool] Error 2
> make: *** [__sub-make] Error 2

Sorry for the breakage :(

This is the most reasonable close that I can get to that compiler version:

# gcc --version | head -1
gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1)

and after I install all of the dependencies, the kernel builds just fine:

# dnf update -y
...

# dnf group install -y "Development Tools"
...

# dnf install -y bc openssl-devel
...

# make -j"$(nproc)" distclean defconfig bzImage
...
   OBJCOPY arch/x86/boot/vmlinux.bin
   AS      arch/x86/boot/header.o
   LD      arch/x86/boot/setup.elf
   OBJCOPY arch/x86/boot/setup.bin
   BUILD   arch/x86/boot/bzImage
Kernel: arch/x86/boot/bzImage is ready  (#1)

Maybe something with your configuration? Although that seems unlikely 
given it is happening in objtool, whose build does not depend on 
configuration options within it. What does V=1 show as the command for 
exec-cmd.o so that I can try to just run that locally?

Cheers,
Nathan
