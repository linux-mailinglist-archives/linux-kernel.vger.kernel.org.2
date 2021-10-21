Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4AA435DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhJUJ1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:27:01 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:40951 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhJUJ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:27:00 -0400
Received: by mail-ua1-f42.google.com with SMTP id e2so11895908uax.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLs87pkhruiT0vLI68Fa9pl7Yrw7UkOzl0BLz4DGuRk=;
        b=pOy0mc7PKe6PANO4BcCZJ4cyYh5x3F6Vi3B9K5ID2ItA8P+Cksyt87fKJN3v7DaNo5
         DATrgIpb7EFzbX7cIZcq0pBoKqb7DtV/ZcwSf0r2GqwvjAtdp8ynCKbVtADgpNIevrwJ
         cQth7kr/ThPlTofjbgAKUMy4k/9KqSYXr2xbpSg1q+UUoe4Tk8iDUaHG6qnXBjCxI78y
         LYjtAukAV5ik4jxdUI9knPJlF+UQcQMQ+TNsxN9HiV1oPZzdqCHsyc/VJIYswbTHkXTv
         4mmG+mmsZFhi/ufwG831SA8UGOIligBlC6h2/pj9k1/CH5hln53+08P3JAuEZpj5x5yx
         favw==
X-Gm-Message-State: AOAM533ktvAfTdaScpIuxTCaP82Rk1ojNCxeH6lUMKSdYSYVcS8ykOno
        Z+E11Jm9uJa4EUrSk+OtvIZ41dMMzTtMmg==
X-Google-Smtp-Source: ABdhPJxI6whIcjj8d9gp83/NYRg7kgR6nG2KO6tMiqDkLDEbKZ9KiHN0xUpO7gxPYLfegeD5LYKgMA==
X-Received: by 2002:ab0:5a8f:: with SMTP id w15mr4776686uae.10.1634808284263;
        Thu, 21 Oct 2021 02:24:44 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id b3sm2843125vko.20.2021.10.21.02.24.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 02:24:43 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id r22so11834998uat.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:24:43 -0700 (PDT)
X-Received: by 2002:a05:6102:290c:: with SMTP id cz12mr4189190vsb.35.1634808283362;
 Thu, 21 Oct 2021 02:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20160828165815.25647-1-nicolas.iooss_linux@m4x.org>
In-Reply-To: <20160828165815.25647-1-nicolas.iooss_linux@m4x.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Oct 2021 11:24:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVRY2Ge87wS5rZenrLozVruKHv9ft1NsjeVYu=yU-EOaw@mail.gmail.com>
Message-ID: <CAMuHMdVRY2Ge87wS5rZenrLozVruKHv9ft1NsjeVYu=yU-EOaw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ARM: add printf format attribute to early_print()
To:     Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2016 at 6:59 PM Nicolas Iooss
<nicolas.iooss_linux@m4x.org> wrote:
> Adding such an attribute is helpful to detect errors related to printf
> formats at compile-time.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
and submitted to rmk's patch tracker.
https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9147/1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
