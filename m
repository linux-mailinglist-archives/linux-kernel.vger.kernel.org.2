Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7833882B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 00:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352728AbhERWVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 18:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352722AbhERWVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 18:21:30 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1934C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:20:10 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 131so13262520ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUf9XT5CCu/J0Hg+9JaJkiWdRUNebcIzPzoiO7Euexs=;
        b=cojriOorSV9jnlpm7gCjTmIpC1epvLKbDT76cfaCHIptdXb9gsx9TdmRTwg5hj89iP
         dARDZ9H2Tivs976nEnFnp9wSBdutmcunp0dqJryoPWeLeuvpnB7225Nmrf3GrzNE8JAC
         f2nnC2vXS1s2P2N78ymYCl8kqGuh/HgAbVaj2ziqXbw4kQEVLFaSLX2xjdXq4svKLy4O
         wUJdyKti/FOxbOYt/um2BrCJHKZ2sFJYX9n1RAPalWem3r9tSlrfDsFWoMeRnjQ6kk7l
         HvqKu7lOJHIXEqIg0l+xWSQHmWqgzxRhm16oWfA+n/gy5axoeeff2hUs1pHKWg4NVWm6
         RLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUf9XT5CCu/J0Hg+9JaJkiWdRUNebcIzPzoiO7Euexs=;
        b=aag7kXHUw8W2B6ZEMUwmdcwZpfgEruAeY1UjwQtHCCPAxWSEAIzLJHtsth079+rXA6
         Rb8gN28YbR4mBVoDIzj51rzAXVHL3RbOH3PyJUwVg4ds/MhgJL1NmdBMPvpFXg6GDIW+
         esu92wr/DyxLW4y/hhD4Dqr9Vx/0e3IQgDdD4FeQY9/97fwUbJC1OimTkelK+t6pxwwa
         nRuFVgBQrfwjLXSl5qMp8wQBh9/RDk18d8eJ8DeKCdK0vn8EjByXDdKEw+FnoO/D0ATx
         F1D9/VcWYoT2zfRcUDofZRzkWksqQB5TmOp1PIUwR6b9CpQxk/OVZ8J93UkSCKx4N5+u
         1GlQ==
X-Gm-Message-State: AOAM5309zQVgUW1wzHRC9e/N990O314pWjQqpz30rTTl1i7vEfypKG4d
        MBW6sDvcleX/QLV6fuut7/mAB3jA4ibVDasQnFDuhw==
X-Google-Smtp-Source: ABdhPJyUn5IvLW+2QdnUKt21vKpBlHrbIQXWm+UgcLTWVmVgXLbnfPFmV9LTAa+69jzgp/D6W+NNGCMLk2wfD2GFsNs=
X-Received: by 2002:a2e:90c7:: with SMTP id o7mr5791882ljg.368.1621376409523;
 Tue, 18 May 2021 15:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210518120633.GW12395@shell.armlinux.org.uk> <E1liyda-0005B4-Kk@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1liyda-0005B4-Kk@rmk-PC.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 May 2021 00:19:58 +0200
Message-ID: <CACRpkdbZObW2SXdTUkPrsezjjVU19emts420EN-uhkHWb+4vrA@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: change vmalloc_min to vmalloc_start
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>
Cc:     Yanfei Xu <yanfei.xu@windriver.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hailong liu <carver4lio@163.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 2:15 PM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:

> Change the current vmalloc_min, which is supposed to be the lowest
> address of vmalloc space including the VMALLOC_OFFSET, to vmalloc_start
> which does not include VMALLOC_OFFSET.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> +static unsigned long __initdata vmalloc_start = VMALLOC_END - (240 << 20);

When I first read this it took me some time to figure out what was
going on here, so if you have time, please fold in a comment
with some explanation of that (240 << 20) thing, in some blog
post I described it as "an interesting way to write 0x0f000000"
but I suppose commit 0536bdf33faf chose this way for a
specific reason? (Paging Nico if he can explain it.)

Yours,
Linus Walleij
