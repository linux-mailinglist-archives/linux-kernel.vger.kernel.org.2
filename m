Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDED3116C3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhBEXMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:12:23 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:43285 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhBEOaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:30:15 -0500
Received: by mail-oi1-f177.google.com with SMTP id d20so7916595oiw.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pa2z99CDmoKgXcEOAulWGlRKNiLQ7DeYHjbsElCag00=;
        b=cTlKhkoWhGCg/RWu0vE4wvhZ3fmyiAQ+Cjhy28QhFbqCC/aMbkJznm/EU12xItuPR3
         8Aa/fr0wEgecx+hflAzVjq2rmBqd90laCgFMcZGpFUyVgXMYcHsmKVzhA0PT7MJzqdLz
         9Gmmk1CjQPL3yl+JBokAia+XU6fTY4UKox1tTzMuPlRDeB0qqdL0JOaSlO4FERbuDL8K
         F2V3UVWJJPXwWkdSzhfaCkuhcRVFqcyiK7EzaaVIaPlrzryKsSjJeQ4Y4N1ZqBtFg0oP
         H4TvMVVdUX2VM6oZqh5OQYu/xXj0/EYhlYnriY1ruNfX99H5cUu0gcVUrWlMbmGipuvl
         NZDQ==
X-Gm-Message-State: AOAM533Rpx8h5UZgqXa4dknWXCWW4Lpq7zYpb5VqwIHzVc5bPIxs6DTt
        Q97T/eSgH5hVU8MuOI6LhEOjCAC1HWu1InMf2yo=
X-Google-Smtp-Source: ABdhPJzD/U89LOC50U+ufH6Lv7RqyWymOkXEkh1VHlWJ5xXAB+Dqmi4QpOFXFGwfYCXPBX2Rs3JFfJAvrexNYFwwwjg=
X-Received: by 2002:a54:4e88:: with SMTP id c8mr3365501oiy.148.1612541282637;
 Fri, 05 Feb 2021 08:08:02 -0800 (PST)
MIME-Version: 1.0
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
 <20210129221643.GZ2002709@lianli.shorne-pla.net> <2a018afc-d797-3a91-ffab-e55ae3b0a795@rwth-aachen.de>
 <20210130230310.GC2002709@lianli.shorne-pla.net> <d9f4aafc-4d65-38b0-dde0-5e155836aee1@rwth-aachen.de>
 <20210131212752.GG2002709@lianli.shorne-pla.net> <6dbc27f8-5261-59c5-acba-70f6c6a74ba1@rwth-aachen.de>
 <20210205144317.GK2002709@lianli.shorne-pla.net>
In-Reply-To: <20210205144317.GK2002709@lianli.shorne-pla.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 5 Feb 2021 17:07:51 +0100
Message-ID: <CAMuHMdXzr4c4=Cg1_Lmw41cmxmMrG4P=dV0yVjuXvuR5pqyh0Q@mail.gmail.com>
Subject: Re: [PATCH v2] openrisc: use device tree to determine present cpus
To:     Stafford Horne <shorne@gmail.com>
Cc:     Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Openrisc <openrisc@lists.librecores.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

On Fri, Feb 5, 2021 at 3:43 PM Stafford Horne <shorne@gmail.com> wrote:
> On Mon, Feb 01, 2021 at 12:49:31PM +0100, Jan Henrik Weinstock wrote:
> > Use the device tree to determine the present cpus instead of assuming all
> > CONFIG_NRCPUS are actually present in the system.
> >
> > Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
>
> Hi Jan,
>
> I cannot apply this patch, it seems you somehow sent it signed as a multipart
> message via Thunderbird.
>
> This causes errors when trying to apply, even after I tried to manually fix the
> patch mail:
>
>     Applying: openrisc: use device tree to determine present cpus
>     error: sha1 information is lacking or useless (arch/openrisc/kernel/smp.c).
>     error: could not build fake ancestor
>     Patch failed at 0001 openrisc: use device tree to determine present cpus
>
> Can you send this using 'git send-email?'
>
> If not I can get it applied with some work, otherwise you can point me to a git
> repo which I can pull it from.

"b4 am 6dbc27f8-5261-59c5-acba-70f6c6a74ba1@rwth-aachen.de" works
fine for me.

git://git.kernel.org/pub/scm/utils/b4/b4.git

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
