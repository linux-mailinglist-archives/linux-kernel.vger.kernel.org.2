Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F5C4209F4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhJDLUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:20:25 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:47018 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbhJDLUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:20:24 -0400
Received: by mail-ua1-f46.google.com with SMTP id u5so9072557uao.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 04:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f00Zs4J4gfx8iX7+J4LOkonrw2VpufCcl1Fh+328R7Y=;
        b=hIi71syTeJ7XO2h/VGaxNhxSDR/WA4fzWFKZBvA1iCRPO9HYHnWGZfTUR1S/+pSdbM
         s+somIEEEPnGNnON/oc3of2P5I1RCIqnl1aldzP6pvqCgUev45WEntNoHZJCx3fHuiCT
         iCQ3b2E9eTh66drNhm0O2+yTrOvpRR+wQ0A0xaCJnkPb5yaVTK9uvr0Fz53507JV9c3u
         uwEZ363Hath+dVAOiQNDOYFmXwoAY7tlxLVGteclaeTMvyJ8uYbI3YnuZUCr9ltvaLxu
         s3WNy9vTT2R72n5lwpfNHS9X0czg7GH6l/ipTc8SEEekVaAWBeV3x1vMfKGPD4QXXwH8
         KDhQ==
X-Gm-Message-State: AOAM533F/6Sb3q6dpnSpNwjmdD9wdvWNylitxvTXe0qNGlq97yh3LL4o
        tVGcMm8mUPoNLiwkZAXR9fV1E1NWSp2Z+0SkV9ySgYjM4KM=
X-Google-Smtp-Source: ABdhPJzH3dEgAVJ0TwVm3UwGxCLp+rCY7gxoHCX74NqyJZ+QS7TNRAm52FsStQJMv/t6qQ9T9zUkj1xQxBG8ciRoeYE=
X-Received: by 2002:ab0:58c1:: with SMTP id r1mr5838360uac.89.1633346314602;
 Mon, 04 Oct 2021 04:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211004111224.941450-1-geert@linux-m68k.org>
In-Reply-To: <20211004111224.941450-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Oct 2021 13:18:23 +0200
Message-ID: <CAMuHMdXA-4Y0obSTmwkavauwpMrM8LXxnofeNXtGuC7N=bu5Uw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.15-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-um <linux-um@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 1:15 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.15-rc4[1] to v5.15-rc3[3], the summaries are:
>   - build errors: +1/-4

  + /kisskb/src/drivers/video/fbdev/nvidia/nvidia.c: error: passing
argument 1 of 'iounmap' discards 'volatile' qualifier from pointer
target type [-Werror=discarded-qualifiers]:  => 1439:10, 1414:10

um-x86_64/um-allyesconfig (fix available)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9e1ff307c779ce1f0f810c7ecce3d95bbae40896/ (90 out of 182 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/5816b3e6577eaa676ceb00a848f0fd65fe2adc29/ (90 out of 182 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
