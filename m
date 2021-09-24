Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8DE4170DB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 13:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343490AbhIXLa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 07:30:58 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:41684 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244457AbhIXLax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 07:30:53 -0400
Received: by mail-ua1-f42.google.com with SMTP id f24so6345808uav.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 04:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xb4E71PLRVwAgc7nxTvHtPqOviEnsfHRocCh1h1TNpU=;
        b=hNrxuNBmijgAghJDX/nXFVCw2QuR5mu4GOtQZ4IwhuOU2EN16s6HE/qItyel0w7KRE
         oay5SdmJQ1E23Y/b+vdZzfeXW1ANvSnPhM2Lmty4jZGibdcYEBJeiXENLqe6g8MEF20q
         0k/RzqLsKZtN9KRjqlwHop8qmbGP2MU2CIR6vjUVcQbVmugVuj2njQaFc3mfSOVVfLjf
         yPGhc2j4QwRuBkADhp3iZecakY/3J1cSuh8jLr4nE+f7zDhhaQV55luMoTgnHJ8QWUYW
         GyCODN9zFCeaEbA2YZ/lCQ7dgMA2Gj0B3ABAQn7gQAPwbuSopOfpLUg3+d2WebAsRrhs
         Brmg==
X-Gm-Message-State: AOAM5327ygNZrCCEazuq/xStiHXTHNspVZGdfrslrpL0L2UN1F+/rKA6
        8bNQkAvWdnNagxFaiNIgw92jvKZPXU3mmdC1w8dX0HSG
X-Google-Smtp-Source: ABdhPJz3tf5Uuih13QoXr/+WiaUJFLErVwra6v83B0+Z+LkdV1BQqgZUmWZw8z25y996cRukWMEezFzll0NRKknW/74=
X-Received: by 2002:ab0:7d5:: with SMTP id d21mr8830579uaf.78.1632482960571;
 Fri, 24 Sep 2021 04:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142413.130774-1-wangborong@cdjrlc.com>
In-Reply-To: <20210906142413.130774-1-wangborong@cdjrlc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 24 Sep 2021 13:29:09 +0200
Message-ID: <CAMuHMdUYMabCK7aknqTMSOqZrLkwJ1uRTPPyqn7AXLQ7VXeg2w@mail.gmail.com>
Subject: Re: [PATCH] m68k: Add a missing SPDX license header
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Mon, Sep 6, 2021 at 4:24 PM Jason Wang <wangborong@cdjrlc.com> wrote:
> Add the missing SPDX license header to arch/m68k/q40/q40ints.c.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Thanks for your patch!

> ---
>  arch/m68k/q40/q40ints.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Is there any specific reason you only updated this file?
There are 209 other files under arch/m68k/ lacking an SPDX license
header.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
