Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAAA34BBC0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 11:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhC1JEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 05:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhC1JER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 05:04:17 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797ADC061762
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 02:04:14 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4F7VBg4Xxdz1ryX8;
        Sun, 28 Mar 2021 11:04:11 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4F7VBg49LBz1qv9k;
        Sun, 28 Mar 2021 11:04:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Dwm1-YOpFPBY; Sun, 28 Mar 2021 11:04:10 +0200 (CEST)
X-Auth-Info: GHbqMtjSwlyx6Vu7Da4AbOxh0KCBSD4DJSv1SvMweZQtYqezPHy9gMmMgFXypTRY
Received: from hase.home (ppp-46-244-175-213.dynamic.mnet-online.de [46.244.175.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 28 Mar 2021 11:04:10 +0200 (CEST)
Received: by hase.home (Postfix, from userid 1000)
        id 7E92F102A8B; Sun, 28 Mar 2021 11:04:09 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Julian Braha <julianbraha@gmail.com>
Cc:     akpm@linux-foundation.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS
References: <20210328041359.50149-1-julianbraha@gmail.com>
X-Yow:  It don't mean a THING if you ain't got that SWING!!
Date:   Sun, 28 Mar 2021 11:04:08 +0200
In-Reply-To: <20210328041359.50149-1-julianbraha@gmail.com> (Julian Braha's
        message of "Sun, 28 Mar 2021 00:13:59 -0400")
Message-ID: <87lfa7ved3.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mär 28 2021, Julian Braha wrote:

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2779c29d9981..8d53ed423899 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1665,7 +1665,7 @@ config LATENCYTOP
>  	depends on DEBUG_KERNEL
>  	depends on STACKTRACE_SUPPORT
>  	depends on PROC_FS
> -	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> +	select FRAME_POINTER if MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86

That doesn't look correct.  It reverses the condition without reversing
the result, which means the result is probably the opposite than intended.

The same expression occurs two more times in this file.  Do those need
to be changed as well?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
