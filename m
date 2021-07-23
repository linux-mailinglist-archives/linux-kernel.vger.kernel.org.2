Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D9B3D4327
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 00:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhGWWLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 18:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhGWWLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 18:11:12 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9E8C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 15:51:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id m9so3477744ljp.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 15:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4HCYw5NOde3g0l5ZK6C4CEhaJpOnGk3xLhiohruDlKI=;
        b=e94pb9KK7d240/xJAprT09EB9LknVJlSRUpo+5OzKREm0YslQ4XR9WmWDwGhkRErua
         Oey1lFWiof8IpPonwzdqJ8mWdNNAt8HtIqBLyaLZQL06WH6rdr4cS/wz5uGWvKT0unST
         lvzXBjJLpx++wkSIf74FxFuWTFQnmfa3FpwB1p78Dv0I9QsLx/nIcLmFKUWnd1IrHab2
         Rw5NvdvXL+mpogp0xEMiN5p2Tm7tzWWTL42CSUH3MLPxQSJjr631LO/5c2o9qywl9O5z
         Le0pFUGlPKRUy5rMNXQD5zUr8eURZjaknYyp/GO8BdRiDwRbD3GzcMbM87iuDyrGeN/f
         JYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HCYw5NOde3g0l5ZK6C4CEhaJpOnGk3xLhiohruDlKI=;
        b=NOVvNBnN5OPjRTmD5x31Ys9vT4WCl2V8f0w8iVuPK6hJ9FFAPF0Mj9CWBGX476DT5M
         7n0aO6tMimoW8xlzIHgf9LkDmOXcO58gI6LgWZFE3liUkSWdvlfWSYa56owVDSBsgMUc
         D1KnmJ/IXpoO8z3dzpUbdCaFbSM6JItx2/ORpHEmTat7JBfzc5EukRY2B55oQemoBazX
         BX/Ejh4pnNVvIIsvm3UYD0k5fDyz1qy5CbnBLkCwjdWFTaUV5QBC1CcObTPAq7/LaLRR
         gUdD/QVlMXVO3W237m9e+y5Z8pZWg6+Dus8ASbRt1KGOqAR6mQFV0TenVzCJFP/bh5tB
         77ZA==
X-Gm-Message-State: AOAM53186OGcyCVfbTJRadY8Qq42NpwZGmLLXOOvyauxhgmuM0AYXvKQ
        4isXJz+Q9pg9AuiL/qcpKkzTqMdSvT0pfCZwLrLO7A==
X-Google-Smtp-Source: ABdhPJxl+uDo/OTRC9mQH3UC8EV6VKvLrc7lEaFTUluCJJQHU2SNWnoB+56eazUSYmGAF2ttd/FpqI9v1LBAdi/edUI=
X-Received: by 2002:a05:651c:160e:: with SMTP id f14mr4710051ljq.273.1627080702856;
 Fri, 23 Jul 2021 15:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210721151706.2439073-1-arnd@kernel.org>
In-Reply-To: <20210721151706.2439073-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 24 Jul 2021 00:51:32 +0200
Message-ID: <CACRpkdb3DMvof3-xdtss0Pc6KM36pJA-iy=WhvtNVnsDpeJ24Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: kasan: work around LPAE build warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 5:17 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> pgd_page_vaddr() returns an 'unsigned long' address, causing a warning
> with the memcpy() call in kasan_init():
>
> arch/arm/mm/kasan_init.c: In function 'kasan_init':
> include/asm-generic/pgtable-nop4d.h:44:50: error: passing argument 2 of '__memcpy' makes pointer from integer without a cast [-Werror=int-conversion]
>    44 | #define pgd_page_vaddr(pgd)                     ((unsigned long)(p4d_pgtable((p4d_t){ pgd })))
>       |                                                 ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                                  |
>       |                                                  long unsigned int
> arch/arm/include/asm/string.h:58:45: note: in definition of macro 'memcpy'
>    58 | #define memcpy(dst, src, len) __memcpy(dst, src, len)
>       |                                             ^~~
> arch/arm/mm/kasan_init.c:229:16: note: in expansion of macro 'pgd_page_vaddr'
>   229 |                pgd_page_vaddr(*pgd_offset_k(KASAN_SHADOW_START)),
>       |                ^~~~~~~~~~~~~~
> arch/arm/include/asm/string.h:21:47: note: expected 'const void *' but argument is of type 'long unsigned int'
>    21 | extern void *__memcpy(void *dest, const void *src, __kernel_size_t n);
>       |                                   ~~~~~~~~~~~~^~~
>
> Avoid this by adding an explicit typecast.
>
> Fixes: 5615f69bc209 ("ARM: 9016/2: Initialize the mapping of KASan shadow memory")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I can't think of anything better.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Will you add this patch to Russell's patch tracker?

Yours,
Linus Walleij
