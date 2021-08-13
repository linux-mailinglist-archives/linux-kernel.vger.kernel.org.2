Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018D83EAE94
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 04:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238310AbhHMC2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 22:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238165AbhHMC2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 22:28:45 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCEFC061756;
        Thu, 12 Aug 2021 19:28:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gm6st5f1Mz9t23;
        Fri, 13 Aug 2021 12:28:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1628821695;
        bh=jlHWtsgYmZ30B2WJN0Jw5XD8BZs0Z7qm5rWOQviWRxQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iQqdFqNsp0RRZI3qzmEc8DvXwIl+xP6sqn6MkAu1yNyVEEqSByPkt7fyHM+X9Mkc1
         H5RsYWUWRX8EIeuJJ4pqVwfnttonPEDoUI6iLblU3xQm7I/dYs830ptXGtqFnm8msw
         bQaEGG6Y/DzH1CN1Mvvb00KGwJKu//Dz61HaxwsLpsn/iRop+KxRmApjk7hRSxfG8F
         cG79DxTOVkrHCCl0Z+JjvfFI1Us2ePvxaJcd/q1n8XQPkD29Snt/5eadLOKqEw4s5I
         wyuWWaQ6HM0csDFNLWQbGqs6kWuET5VesHnFV3cwA2hGTS/6dU1L+U6SqYdZgv1Mhm
         jRnaImnD2vgxw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
        linux-mm@kvack.org
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <palmerdabbelt@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -next] trap: Cleanup trap_init()
In-Reply-To: <20210812123602.76356-1-wangkefeng.wang@huawei.com>
References: <20210812123602.76356-1-wangkefeng.wang@huawei.com>
Date:   Fri, 13 Aug 2021 12:27:58 +1000
Message-ID: <87czqim635.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kefeng Wang <wangkefeng.wang@huawei.com> writes:
> There are some empty trap_init() in different ARCHs, introduce
> a new weak trap_init() function to cleanup them.
>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Paul Walmsley <palmerdabbelt@google.com>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arc/kernel/traps.c      | 5 -----
>  arch/arm/kernel/traps.c      | 5 -----
>  arch/h8300/kernel/traps.c    | 4 ----
>  arch/hexagon/kernel/traps.c  | 4 ----
>  arch/nds32/kernel/traps.c    | 5 -----
>  arch/nios2/kernel/traps.c    | 5 -----
>  arch/openrisc/kernel/traps.c | 5 -----
>  arch/parisc/kernel/traps.c   | 4 ----
>  arch/powerpc/kernel/traps.c  | 5 -----

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
