Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312CF42C850
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbhJMSG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJMSGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:06:49 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB4DC061570;
        Wed, 13 Oct 2021 11:04:46 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id 64so6210517uab.12;
        Wed, 13 Oct 2021 11:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5JZ6j7pYu0Wx/PJu3hozdlLGPftJkPZScKEEfc29Dvo=;
        b=dJBTHItFFnYUxSqezPmcOIaOJhKF9pfKGq5xP5so++hgKwgNebGpoUCqlFg/2HGIuH
         Fect8/cA0qmd61q9CeSUzLdj3aiajliCmVpZeFJDnVgFbM8C2B1n49NcbpRnmmEuYl0T
         xMjDLiCnYNlli1mnLn/mbwUMfioU9AWvIBUOHnVd28wss0fucLXctERv33Z9JALbVHfe
         8mRTaE8+x548nM8JSZ+M6PQGxk3EFmBfR3F5GBB8eShnmnrZFx32xfFIjwtXiOwlSSz9
         1dEH1BKeYgzUfpUKFRt+tdCzs2MYtumECWyfg6DgrQ+DN8ZkspYWkq0060Z2KQsEiNDs
         2DVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JZ6j7pYu0Wx/PJu3hozdlLGPftJkPZScKEEfc29Dvo=;
        b=p1OAp1Q+IYq4t+RXdb5OeuOvag0kMvr5JTRBZcGccKd6VlqQHQgW/m7J0pbKqv5G4/
         k2QeiqfVwscKX1yqVbKFsWDIvJGE5k8wxlGk5ppsFdS5SsHX0z6V0+0vVNXTilz2KD/z
         dS8KAO11y42Zqfypez7a77VotrcUnxliE0MTUoNKUcypMIE2rA6OQNmY6E2QcnXVQYwR
         cZh36zJ0xzP2pkiY7pvGXZjUYVtE3VbATt9zvtfFMuKCYiLBacuXzuo0XGdq6SMbjgj9
         bOWXzTWAqANtX6QKazpKvdp/XhjiAkUA4po+ywfHpFffAIolxUU22SFgd4KChqGYNLVn
         kiDg==
X-Gm-Message-State: AOAM531mQd8wSwW0bLmQ1p53IFKKDboemrAqvflJTRP+ImjaSgDURjdm
        tvhXXCJjWSLM1ebFk3OmRG65If1vWRERgLqh1Y/Ga9us
X-Google-Smtp-Source: ABdhPJzBo5SUMd80RaY0zpZIHofCvRfJhJU8tn13Vy0zRYJKYJ/bUQYowsTNI+YubATd4+JICySn65L1ODruaN6mr5g=
X-Received: by 2002:a67:e28a:: with SMTP id g10mr740508vsf.5.1634148284580;
 Wed, 13 Oct 2021 11:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211013172042.10884-1-semen.protsenko@linaro.org>
In-Reply-To: <20211013172042.10884-1-semen.protsenko@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 13 Oct 2021 15:04:33 -0300
Message-ID: <CAOMZO5CT+5=py=TBUMOZKRDsacNnGWV2TPBE7RtnZ3ocBBVReA@mail.gmail.com>
Subject: Re: [PATCH v6] clk: Add write operation for clk_parent debugfs node
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Wed, Oct 13, 2021 at 2:20 PM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
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
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

This is useful, thanks:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
