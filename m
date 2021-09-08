Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC0B4035B8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347275AbhIHHvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:51:38 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:34769 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347679AbhIHHv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:51:26 -0400
Received: by mail-vs1-f49.google.com with SMTP id x137so1244601vsx.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 00:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHWQ+YyUIuf6+g8aXLRSEFfZyfK8saLLBSTNrZfo+jo=;
        b=bIfITnvxGCDoX5EpppMe4+Y1jO/ZR6EX93lxae4APCoz1BNzPXJ4A2hbXZ5pYwp94x
         gv7qI9Y8OuQRBYoJT3ubtNIfuieBxEKUfvh6koIhXC+MAt/TmCG+77y2GfsxrgJ0R9Yq
         HUsLcornBpWjxIQuzX4q8W2aPGCPxKZobHVhO8FY26lc09NsovDPsqNRv0/h/J0AXvHj
         KHbMzTDsp2rSDEK74mz4cdUyTRWBMwo2l626fMl29doC3PepMfIr0tV2E5nQolrI+r+E
         egm+bajHHBveYRzNYiFAA57cQo7rZrfu3xyBySxfxxuEQGFSPxlzxsWHzsl9LSmsDEoH
         zNvw==
X-Gm-Message-State: AOAM5325tmUT9KL1HlhvP8Te/Gu8aH48lcqcnrj4cWlQmrSwM/2Ztx8Y
        SRkTw73VyMhidUYQIvXPLzMLdgddViFXen8Jm04=
X-Google-Smtp-Source: ABdhPJzZ13uplSALu72VGeSdNO7WsRIeqAR995jKHWoEGX3nQiJ+8n3lNsb/Zgcr1zA1dw25X+AvmXOyH3YgMmSVK0Y=
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr1206374vsl.9.1631087418281;
 Wed, 08 Sep 2021 00:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210904060908.1310204-1-keithp@keithp.com> <20210907220038.91021-1-keithpac@amazon.com>
 <2d5e3f95-77ce-cd26-9020-3c1a8a65e799@canonical.com> <CAMj1kXF8X0j7Be_+3Z4uHcq0ZHKxsB5hW-7PEVb4dB54HFJgOg@mail.gmail.com>
In-Reply-To: <CAMj1kXF8X0j7Be_+3Z4uHcq0ZHKxsB5hW-7PEVb4dB54HFJgOg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Sep 2021 09:50:06 +0200
Message-ID: <CAMuHMdXX+-vbxvSt5oA3_SM7bJGeY97bKWt+KCZjGzEHbhw5ng@mail.gmail.com>
Subject: Re: [PATCH 0/7] ARM: support THREAD_INFO_IN_TASK (v3)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Keith Packard <keithpac@amazon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jens Axboe <axboe@kernel.dk>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Russell King <linux@armlinux.org.uk>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Wed, Sep 8, 2021 at 9:47 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> Also, this ended up in my GMail spam folder, likely due to some
> antispam ID header being set incorrectly?

I have a rule to never mark as spam email with "patch" in the subject.
So far only one false positive in all these years ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
