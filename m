Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0190E3FBF55
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 01:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbhH3XSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 19:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbhH3XSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 19:18:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A297C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 16:17:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630365466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=waBPSOtEtKCExNwq33nlht3Z/W5y12JWVi4ROsYUn4o=;
        b=VdMYJwvdoHcxtCr53N6CTe6+RXI/dJQD4aoXzaK7kxvqupSiDzpZ+jGsOu4OIHsNaPESH1
        36CFlYXCQ6d9y1ecHnURZikTaevqx+Te5hD0AUT/+25OapiFAp42p/QNER1KUh7WLh0qAs
        efcRXZQltSG58N/dX0haH6pRBMdS0XKMDKdlhx8U9zsBDt2sa3Ie0HemL9axWum8bA/xHP
        B6fTDfcn5UWrtoBMnwokQKpe9i/0rj7+4vs8wy3URVbkCzPXSmroGgKDqXvNnIF1TjnRIu
        bv84JhcufiuiMzjQQFkGTR8qP6PJ/TBTuKafrTZZlUPzzAaXxV9AFlGesyQYpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630365466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=waBPSOtEtKCExNwq33nlht3Z/W5y12JWVi4ROsYUn4o=;
        b=KRwTD0VUCAgK8yGHAjQtM9hIAXF9SbLYvHYdJpU5mf5cvbP3NyQGSokq2ZMEAFHoZwtv6N
        l0hPjqepuM3Hz0CA==
To:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mike Rapoport <rppt@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ARM: select HAVE_FUTEX_CMPXCHG
In-Reply-To: <20210830213846.2609349-1-ndesaulniers@google.com>
References: <20210830213846.2609349-1-ndesaulniers@google.com>
Date:   Tue, 31 Aug 2021 01:17:45 +0200
Message-ID: <87czpufrom.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30 2021 at 14:38, Nick Desaulniers wrote:

> tglx notes:
>   This function [futex_detect_cmpxchg] is only needed when an
>   architecture has to runtime discover whether the CPU supports it or
>   not.  ARM has unconditional support for this, so the obvious thing to
>   do is the below.
>
> Fixes linkage failure from Clang randconfigs:
> kernel/futex.o:(.text.fixup+0x5c): relocation truncated to fit: R_ARM_JUMP24 against `.init.text'
> and boot failures for CONFIG_THUMB2_KERNEL.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/325
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
