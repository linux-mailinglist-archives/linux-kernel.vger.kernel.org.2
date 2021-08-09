Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E303E4869
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhHIPPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:15:50 -0400
Received: from mail-ua1-f52.google.com ([209.85.222.52]:43785 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbhHIPPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:15:49 -0400
Received: by mail-ua1-f52.google.com with SMTP id 91so7168477uas.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehvDAZzdXJSc27GvA0fWut4GARnIXIBF9w/5HJVeQDw=;
        b=OPGiktWWhZK3HBFovlxH5mOCPdWuDe2UhtoBm4OMBAbs0bBcW8m5ldCbPpg+qqT3+6
         J1GcAuywUush/ohjOHXWRuWgJ2PwcA1BA3KjXxWTO8biBlCvZne2Fr1jehlTPKF/OgPp
         uAaEnuGgWiob/Lor/Jd/Cm/feDg+HAaIrJk6iAQxorp1uyDi5ixbA6Vs2sGe4zbu8S83
         4dQu++vpa+8cMu602TYfoYgp8dfJ7LFos823UoIrwM+/O+m4A7I2vUTRdc7xXbLCUMhr
         ikeuaM1yogcuN5oikw6LeWyB8hazlmTIYfr81hm97wDw4DGXWxU3Ya44IvIbI+NvDcoE
         BLKA==
X-Gm-Message-State: AOAM533M2AryM5csrl/v1FMQn+SX4wT+OV9v36R+juEr87IaE/Feys+o
        Tf6haV7lm+Bu1F/GQKSgyThSD8LceixTKdFZFrc=
X-Google-Smtp-Source: ABdhPJx13QvlWE82lmqYd1A4xsQv/vLk/nFwWnXoXrYRwmZu/glnNQK2zXj/Aai5Ut2bimNcDxzESJb0alo4cTnqPzg=
X-Received: by 2002:ab0:1d05:: with SMTP id j5mr1649669uak.2.1628522129038;
 Mon, 09 Aug 2021 08:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210803155452.435812-1-lee.jones@linaro.org> <20210803155452.435812-2-lee.jones@linaro.org>
In-Reply-To: <20210803155452.435812-2-lee.jones@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Aug 2021 17:15:17 +0200
Message-ID: <CAMuHMdXpYV+pbiOwiCjZ+aZYR-xPDGkeANfLt0fwhg4zevAKgg@mail.gmail.com>
Subject: Re: [PATCH 1/3] arch: Export machine_restart() instances so they can
 be called from modules
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 5:56 PM Lee Jones <lee.jones@linaro.org> wrote:
> A recent attempt to convert the Power Reset Restart driver to tristate
> failed because of the following compile error (reported once merged by
> Stephen Rothwell via Linux Next):
>
>   ERROR: "machine_restart" [drivers/power/reset/restart-poweroff.ko] undefined!
>
> This error occurs since some of the machine_restart() instances are
> not currently exported for use in modules.  This patch aims to rectify
> that.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

> NB: If it's safe to omit some of these, let me know and I'll revise the patch.

How do you plan to handle that? Isn't this an all-or-nothing export?

>  arch/m68k/kernel/process.c         | 1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
