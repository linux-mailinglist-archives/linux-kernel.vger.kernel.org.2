Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2A8374BB4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 01:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhEEXIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 19:08:30 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57908 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhEEXIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 19:08:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 75F7829E62;
        Wed,  5 May 2021 19:07:24 -0400 (EDT)
Date:   Thu, 6 May 2021 09:07:22 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: Drop -fno-strength-reduce from KBUILD_CFLAGS
In-Reply-To: <baa95d7235921dff23bed6320518f3fa90396603.1612681353.git.fthain@telegraphics.com.au>
Message-ID: <edd49c20-2817-3029-127d-c08fcc1af014@nippy.intranet>
References: <baa95d7235921dff23bed6320518f3fa90396603.1612681353.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

On Sun, 7 Feb 2021, Finn Thain wrote:

> This workaround became redundant either when the driver in question was
> removed (in Linux v2.6.23) or when the compiler flag became a no-op
> (in GCC v4.2). Linux has required GCC v4.6 or later since v4.19.
> 
> Link: https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=efa1cdf01850b28c2f6f7035ebd4420259494615
> References: commit 565bae6a4a8f ("[SCSI] 53c7xx: kill driver")
> References: commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  arch/m68k/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
> index ea14f2046fb4..5be4efec173a 100644
> --- a/arch/m68k/Makefile
> +++ b/arch/m68k/Makefile
> @@ -66,8 +66,7 @@ KBUILD_CFLAGS += $(cpuflags-y)
>  KBUILD_CFLAGS += -pipe -ffreestanding
>  
>  ifdef CONFIG_MMU
> -# without -fno-strength-reduce the 53c7xx.c driver fails ;-(
> -KBUILD_CFLAGS += -fno-strength-reduce -ffixed-a2
> +KBUILD_CFLAGS += -ffixed-a2
>  else
>  # we can use a m68k-linux-gcc toolchain with these in place
>  KBUILD_CPPFLAGS += -DUTS_SYSNAME=\"uClinux\"
> 
