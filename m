Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4534233B0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhCOLPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhCOLOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:14:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADDC364E61;
        Mon, 15 Mar 2021 11:14:36 +0000 (UTC)
Date:   Mon, 15 Mar 2021 11:14:34 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: arm64: kernel/sys.c - silence initialization warnings.
Message-ID: <20210315111433.GA22897@arm.com>
References: <162859.1615542946@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <162859.1615542946@turing-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 04:55:46AM -0500, Valdis Klētnieks wrote:
> Building arch/arm64/kernel/sys.o with W=1 throws over 300 warnings:
> 
> /usr/src/linux-next/arch/arm64/kernel/sys.c:56:40: warning: initialized field overwritten [-Woverride-init]
>    56 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
>       |                                        ^~~~~~~~
> /usr/src/linux-next/include/uapi/asm-generic/unistd.h:29:37: note: in expansion of macro '__SYSCALL'
>    29 | #define __SC_COMP(_nr, _sys, _comp) __SYSCALL(_nr, _sys)
>       |                                     ^~~~~~~~~
> /usr/src/linux-next/include/uapi/asm-generic/unistd.h:34:1: note: in expansion of macro '__SC_COMP'
>    34 | __SC_COMP(__NR_io_setup, sys_io_setup, compat_sys_io_setup)
>       | ^~~~~~~~~
> 
> We know that's pretty much the file's purpose in life, so tell the
> build system to not remind us.  This makes the 1 other warning a
> lot more noticeable. 
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> 
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index ed65576ce710..916b21d2b35b 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -8,6 +8,7 @@ CFLAGS_armv8_deprecated.o := -I$(src)
>  CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_insn.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_return_address.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_sys.o += $(call cc-disable-warning, override-init)

We do similar initialisation in arch/arm64/kernel/sys32.c and
arch/arm64/kernel/traps.c for example. It's a pretty common pattern
throughout the kernel.

So we either treat W=1 output as diff against the vanilla kernel when
checking new patches or we remove override-init altogether from W=1.
Mark Rutland pointed me to an older thread:

https://lore.kernel.org/linux-arm-kernel/20190809083251.GA48423@lakrids.cambridge.arm.com/

-- 
Catalin
