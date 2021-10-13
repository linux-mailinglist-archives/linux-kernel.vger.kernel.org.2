Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799EE42C0DB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhJMNC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:02:58 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:42552 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhJMNC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:02:57 -0400
Received: by mail-ua1-f53.google.com with SMTP id j8so4240925uak.9;
        Wed, 13 Oct 2021 06:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ROb25SRHrlctqcwYNmk5SZxRis47NqhPR1W/F6S4hc=;
        b=E7QqFJl6uynC1r5yt8BlnCYLRTtscpLNDIY+txTEbs1exxAW0Ic5l+I0wQ3DoyylO8
         uz0O2b44py0/a4713QSjMOd2l4Dxkdcw9pY5VoPcVAMgXgsGwl3UGWgwQMZpk8uX1m96
         oKHQ8VD/MOt+SyaQhw70pq21EHvDF61arAMnFeSgP7S8rTC9jwRZSL0Scl4TjknIWccD
         skRilaV7awLVSsutGOobSK4f/o6tfNrqz1Bs4J+F03x/kcRP4dVl4LnlcDfkgKgwHtOX
         DzyILvJrjxJ5LiPzp+BwvgNnb2hRQPNrab6x3KTQUo6CiQPW4xHcCCREoAI1dOV6vWWN
         cjAw==
X-Gm-Message-State: AOAM531sphkuSGHxwaKPJx3BvUt30X0+p2py6THOHt3C688Y4+WIm/XF
        PAo43CrJnBs1JKvD0j6qc+dZcSG31cJoJ7VfbPDYGw3V
X-Google-Smtp-Source: ABdhPJxLkApOC7yMyBdbfgVEppF7bfWIBh7G+fA1a8AE2efhgNQ3zXaJXtAdx0jG9P3V77HkHsz1i+mp8XWK0KAeY4Q=
X-Received: by 2002:a67:d111:: with SMTP id u17mr37472705vsi.37.1634130053857;
 Wed, 13 Oct 2021 06:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211007182158.7490-1-semen.protsenko@linaro.org>
In-Reply-To: <20211007182158.7490-1-semen.protsenko@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Oct 2021 15:00:42 +0200
Message-ID: <CAMuHMdU+N071GCb6OepwBu_2fTununksguD26nxY3f-BqzjsQg@mail.gmail.com>
Subject: Re: [PATCH v5] clk: Add write operation for clk_parent debugfs node
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 8:22 PM Sam Protsenko <semen.protsenko@linaro.org> wrote:
> Useful for testing mux clocks. One can write the index of the parent to
> be set into clk_parent node, starting from 0. Example
>
>     # cd /sys/kernel/debug/clk/mout_peri_bus
>     # cat clk_possible_parents
>       dout_shared0_div4 dout_shared1_div4
>     # cat clk_parent
>       dout_shared0_div4
>     # echo 1 > clk_parent
>     # cat clk_parent
>       dout_shared1_div4
>
> CLOCK_ALLOW_WRITE_DEBUGFS has to be defined in drivers/clk/clk.c in
> order to use this feature.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
