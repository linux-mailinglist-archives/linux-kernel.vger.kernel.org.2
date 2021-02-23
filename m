Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2FB322DC3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhBWPpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:45:06 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:36457 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbhBWPpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:45:01 -0500
Received: by mail-ot1-f54.google.com with SMTP id 105so9555732otd.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UbWCiU/uRlrhehUgxEm8fWtxaGuzXp2np3xNLjFQURE=;
        b=f3RNysBtX8r2KyVD6X7jH+fErYZ8CoUBiBbmD0DrEF+57tq7e1065ynEtJfVyjbow4
         3XXWhNKqJdhbIPA874bdTRP6lWKK9FgtIhPmd2dUdgPZD1vsJapNYgc3KTJXmFK3F+ai
         kAsNJPS09dfumKWzDpH5hCsMHr4rsQejf7L/EdVw7vwrVPSEO1eMoOgwkf7LoNAwrTl8
         Qxhls3ymXlkMrtXyQX7zvt7LbED6d12kGHT6a52QOd6Wfz4qng9hIj3X5o2bEvRadeCC
         cdUsM/mXJBPlVzJwdvzZXI83OfS0NpqQlu+wEEuRx4iRk6RkkP4po0nA3iEUA5zgge2L
         aKzw==
X-Gm-Message-State: AOAM531umnGASKvQCPE4DFXYbz7H8ZQW39NoEIiJapfhaejUAacjU5ap
        A4FdxOJTIFuywUpB1Awgo914VsqnnDmYRnuHcdo86+7G
X-Google-Smtp-Source: ABdhPJzer95jx+A57/9xHU1nalcRMEIzIOppwc9nf1cqIWHZqIkQ0QbRrUKXSaqUgrig6X1hbytnM1TgwvnrHdMxOlM=
X-Received: by 2002:a05:6830:119:: with SMTP id i25mr20624039otp.107.1614095057509;
 Tue, 23 Feb 2021 07:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20210223152707.408995-1-johannes@sipsolutions.net> <20210223161449.5fbbdace8fea.I7b2fad8378e4fde7f26ef06a03980ae2807d81c9@changeid>
In-Reply-To: <20210223161449.5fbbdace8fea.I7b2fad8378e4fde7f26ef06a03980ae2807d81c9@changeid>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 23 Feb 2021 16:44:06 +0100
Message-ID: <CAMuHMdUU40kv6SncuCYGjattnEWR2k7FG2NS+6ffY6K+D1qsiQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] um: allow disabling NO_IOMEM
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-um <linux-um@lists.infradead.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Tue, Feb 23, 2021 at 4:27 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Adjust the kconfig a little to allow disabling NO_IOMEM in UML. To
> make an "allyesconfig" with CONFIG_NO_IOMEM=n build, adjust a few
> Kconfig things elsewhere and add dummy asm/fb.h and asm/vga.h files.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/um/include/asm/fb.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_UM_FB_H
> +#define _ASM_UM_FB_H
> +
> +static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
> +                                unsigned long off)
> +{
> +}
> +
> +static inline int fb_is_primary_device(struct fb_info *info)
> +{
> +       return 0;
> +}
> +
> +#endif /* _ASM_UM_FB_H */
> diff --git a/arch/um/include/asm/vga.h b/arch/um/include/asm/vga.h
> new file mode 100644
> index 000000000000..0b0e73ccdb28
> --- /dev/null
> +++ b/arch/um/include/asm/vga.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_UM_VGA_H
> +#define _ASM_UM_VGA_H
> +
> +#define VGA_MAP_MEM(x, s)      ((unsigned long) ioremap(x, s))
> +#define vga_readb(a)           readb((u8 __iomem *)(a))
> +#define vga_writeb(v,a)                writeb(v, (u8 __iomem *)(a))
> +
> +#endif /* _ASM_UM_VGA_H */

Can't you just use the asm-generic versions instead?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
