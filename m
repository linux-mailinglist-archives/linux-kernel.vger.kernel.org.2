Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70D1395677
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhEaHu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:50:28 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:43609 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhEaHuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:50:20 -0400
Received: by mail-ua1-f46.google.com with SMTP id f1so6116087uaj.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44YBbg2fYX/hfgSeWE3KOy+zaexOX+0Aw7Axnd+cQ8E=;
        b=DkLTkfz/NmJBj2f1+EucteYhVl7U1Kc1ny1TKSrYllac+I7/ML1geWDX9EbEb/ouEF
         uYX646VzvezQo6CTJh2HwuSr6bnsHcRiZwHWaEy9jNhucdAOl9UdB345fYMCZQ+9EtYv
         t15xuaJkxA5KybevyCrPPHTUzcwRSx/SwfekXl6asRSb9/ej6HhDceFCrN6cfnYQ3Y2G
         FV7ZCkZDiXeWBVnmMSim3uqEnskreBO7QWXbzJar6qKq44/zjb2hh8j0cWpg0Jjs33g3
         sDw5RcJa9p8V4r2rS+rmpuReaiSX+Etf14ciJC/eZrnbuXsZkIGB/Z8sJy+JxF59MZI0
         FqPA==
X-Gm-Message-State: AOAM533SJ3OczE+wY63ijRmnMD8efmvs6lQyHRFHbSXdPx9J+aHDLhGl
        QobLQya4Ty66HbZtPEXnj4QMYml94c/0krFoXlDggFdBR8Y=
X-Google-Smtp-Source: ABdhPJwxFVdG3TE/UeNQ9DPk4zX/a/VsvjhPOzB4LD00GlG0TMk25UF0idEqyTUFA1IU43hjsVTgF8co7MLPhRGrTMU=
X-Received: by 2002:ab0:7515:: with SMTP id m21mr1655831uap.2.1622447315059;
 Mon, 31 May 2021 00:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210529105504.180544-1-wangkefeng.wang@huawei.com> <20210529105504.180544-8-wangkefeng.wang@huawei.com>
In-Reply-To: <20210529105504.180544-8-wangkefeng.wang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 31 May 2021 09:48:23 +0200
Message-ID: <CAMuHMdVvbA-bJCubhmKaJ_4VbKo+U538x7s34OkZ94kL7z4nrw@mail.gmail.com>
Subject: Re: [PATCH 07/15] m68k: convert to setup_initial_init_mm()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng

(CC Greg for m68knommu)

On Sat, May 29, 2021 at 12:46 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> Use setup_initial_init_mm() helper to simplify code.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Thanks for your patch!

> --- a/arch/m68k/kernel/setup_mm.c
> +++ b/arch/m68k/kernel/setup_mm.c
> @@ -258,10 +258,7 @@ void __init setup_arch(char **cmdline_p)
>                 }
>         }
>
> -       init_mm.start_code = PAGE_OFFSET;
> -       init_mm.end_code = (unsigned long)_etext;
> -       init_mm.end_data = (unsigned long)_edata;
> -       init_mm.brk = (unsigned long)_end;
> +       setup_initial_init_mm((void *)PAGE_OFFSET, _etext, _edata, _end);

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/arch/m68k/kernel/setup_no.c
> +++ b/arch/m68k/kernel/setup_no.c
> @@ -87,10 +87,7 @@ void __init setup_arch(char **cmdline_p)
>         memory_start = PAGE_ALIGN(_ramstart);
>         memory_end = _ramend;
>
> -       init_mm.start_code = (unsigned long) &_stext;
> -       init_mm.end_code = (unsigned long) &_etext;
> -       init_mm.end_data = (unsigned long) &_edata;
> -       init_mm.brk = (unsigned long) 0;
> +       setup_initial_init_mm(_stext, _etext, _edata, (void *)0);

Please use NULL instead of (void *)0.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
