Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8A443371F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhJSNem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbhJSNei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:34:38 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0555C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:32:23 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id n201so10308572vkn.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8VTzO2VtQyI7pa9ECzIuQcqfVd9XYwvhSUdsnki7qKo=;
        b=gZJGzhC73ekiMSFsm5NIbAOtA95yvj+swmFDW6M2YYj/wxCed6cORyTNTGha9LMEDe
         6w4cZxFX3fOTYL2GqgHYEjCCD8umZ7gaJ6Q1qpIE6ZU9BWiq45YZRJrIhl/oFaQYvNHy
         s5JPzUPAxIplPZgpKEPgvB1hvTEO57b8WaOhqm3LLlbFlNMrilKaDqdl+T7vsqn+Kl52
         x4dL1au5eXgs4sLlu3s/2Ngpk5kwnsxkOLjNOmn4GlVaEYY7eCZ52tjAaUJFHjU6yiMK
         x8mK/xoeJdhAtjzNxT+aOD5DC8aX1ySNPMYisUntkO3tK8flRWrHzjX9yUpQ2Ih7GYG2
         Xsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8VTzO2VtQyI7pa9ECzIuQcqfVd9XYwvhSUdsnki7qKo=;
        b=48NiB2bf3AGAFvrP8k45jhKKq6GKX31kyYYewe+WrJYg1XPlV5lwZWgDwwT1lRo9lE
         4m82VGKfAL/ClK0sF5zWARVIxbZ4fL5QJFKyvyZMbMIpC/Y7LzI/Z8H6dkEKB38Oc4Xx
         SxvXr2SU+e8+Tr/+XZZA7/Xi5JBShpA0UCXimNgK2lTb6iHWRkwLgZdTk3m7movjadtS
         QABuyQRHGysV2O/hINhv0PHwjLv+Se3EoqT6PkrMyrCrYnH9BxFQqOU3wPcKbcFpO9hK
         SB+JZSoVirxGqx/HMJgy1dEAGlzzzMSfX+AXBLkZAHAaK7rK0M5QjkAl5IRrq60mWqEO
         NNXA==
X-Gm-Message-State: AOAM530r1tdsiJIIfThiMbUb/umR15/ItvX14fOlNj6FQPBOuj5o12qY
        vKubMkANM+/9mShNZR6+9yce418xoEcTUcZONmXgyA==
X-Google-Smtp-Source: ABdhPJz4nT4MxuzgoAPrLyC34MY5LSNfJXsoPN+d8GNkU+s2goXBE4nSrJKRDLzRHP+lZXbPPbGtUsf9iBlp3p5FLuM=
X-Received: by 2002:a05:6122:da0:: with SMTP id bc32mr32144871vkb.4.1634650342790;
 Tue, 19 Oct 2021 06:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211013172042.10884-1-semen.protsenko@linaro.org> <CAOMZO5CT+5=py=TBUMOZKRDsacNnGWV2TPBE7RtnZ3ocBBVReA@mail.gmail.com>
In-Reply-To: <CAOMZO5CT+5=py=TBUMOZKRDsacNnGWV2TPBE7RtnZ3ocBBVReA@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 19 Oct 2021 16:32:11 +0300
Message-ID: <CAPLW+4ne9xDxDW=RCzjXURujGCwbCU5mOrfPJ6bn2wY41jstiw@mail.gmail.com>
Subject: Re: [PATCH v6] clk: Add write operation for clk_parent debugfs node
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 at 21:04, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Sam,
>
> On Wed, Oct 13, 2021 at 2:20 PM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> >
> > Useful for testing mux clocks. One can write the index of the parent to
> > be set into clk_parent node, starting from 0. Example
> >
> >     # cd /sys/kernel/debug/clk/mout_peri_bus
> >     # cat clk_possible_parents
> >       dout_shared0_div4 dout_shared1_div4
> >     # cat clk_parent
> >       dout_shared0_div4
> >     # echo 1 > clk_parent
> >     # cat clk_parent
> >       dout_shared1_div4
> >
> > CLOCK_ALLOW_WRITE_DEBUGFS has to be defined in drivers/clk/clk.c in
> > order to use this feature.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> This is useful, thanks:
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Hi Michael, Stephen,

If there are no outstanding comments, can you please take this one?

Thanks!
