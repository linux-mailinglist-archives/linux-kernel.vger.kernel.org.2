Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B1C422320
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhJEKNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbhJEKNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:13:02 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97953C06161C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 03:11:12 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id u11so14441101uaw.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 03:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WR0z3EsOmJ9HchNv/GRdB8LBXEWDht0e0gzzuCF3tHc=;
        b=JJZWoCd9nQOmabGfbOnEyZ9APy4b6iEPrJszzfchPcdEtx4GWnkimEOUuHBi3/BM1x
         2XyVQQgvIm4/5+JCcClvJpzcMA9sHuKxiZqjuyRxYoLN/Ie/R89YpX0AhioR6ysM9urC
         KxhQ149ki9Tp5e4vnAuQhUC1C+JVDGijkuUblUyVvP/q7A3uC/lhnNwNeEBKn4lE4uII
         +jYJ5ZD+P41mkxAbOl8OYmuezPntrdxbQJrdU/lc/yx+mblH0QNSWQd+VgQkv+btna7D
         vynWVsiq+Z1FYV2MxCmpixS92X8YsLJAEGz0ca7VSsjNhHtaQrfOmfSxC2PqFGmnwW+5
         uTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WR0z3EsOmJ9HchNv/GRdB8LBXEWDht0e0gzzuCF3tHc=;
        b=DW9oIYPOWW0DUIRNcyqLQn7WBW2Nb2JMCuM/BU8pzWj2nxMGQ4BY8l6+QBGL2n0OQW
         4mWVmosSUfBtZqRshVGaVOU3gZ3uCb051ZwQvcEBfS7C/4Fv4i1APjHwdgiBYwhI3cd/
         U2l7VpxiDyyzhOQGRpA08EIlIQ/oLzNrReOo69g6CAHxYQNaq/31TZwBcDtrdWvWzv2Z
         G8/6Ka+j4mBKyqfc1xgGywopH1J/kF7WtpdiPVwd1eYQzz0A5OnhU+Iri10g5IOT3drZ
         wZMpuppdpgn9iVFKFuGazGuajV69MGqczJnt6vDwlE2Rp8CPMSthR28iUYLmesDjC5A8
         4RuQ==
X-Gm-Message-State: AOAM533T4P2fag4odZ5+UTq3DiyeLC3Nx8Vywydg96UIq0WAcy1efeey
        k1X409RKkzcF045BqQx0xPWthCPsT6tDxKNoQwuf1tmS75fZzA==
X-Google-Smtp-Source: ABdhPJwlbdUTuDFTe1mcR2LOjzAdw0/QjAuKkTWFCnwwo9qVRJCLkuSG4KWeC721A1cp6A/UqbSPy+bJCy0KgOSRCic=
X-Received: by 2002:ab0:208b:: with SMTP id r11mr639867uak.104.1633428671797;
 Tue, 05 Oct 2021 03:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210914141939.26410-1-semen.protsenko@linaro.org>
In-Reply-To: <20210914141939.26410-1-semen.protsenko@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 5 Oct 2021 13:11:00 +0300
Message-ID: <CAPLW+4mhr4pJAUyGNpfWDnxgTsJ7-fj0hw=ehV8YkqRmaBSnag@mail.gmail.com>
Subject: Re: [PATCH] clk: Add clk_set_parent debugfs node
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sept 2021 at 17:19, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Useful for testing mux clocks. One can write the index of the parent to
> set into clk_set_parent node, starting from 0. Example
>
>     # cat clk_possible_parrents
>       dout_shared0_div4 dout_shared1_div4
>     # cat clk_parent
>       dout_shared0_div4
>     # echo 1 > clk_set_parent
>     # cat clk_parent
>       dout_shared1_div4
>
> Define CLOCK_ALLOW_WRITE_DEBUGFS in drivers/clk/clk.c in order to use
> this feature.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---

+ Adding more folks for review

Guys, can you please review this one?

>  drivers/clk/clk.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 65508eb89ec9..3e5456580db9 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3214,6 +3214,30 @@ static int current_parent_show(struct seq_file *s, void *data)
>  }
>  DEFINE_SHOW_ATTRIBUTE(current_parent);
>
> +#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
> +static int clk_set_parent_set(void *data, u64 val)
> +{
> +       struct clk_core *core = data, *parent;
> +       int ret;
> +
> +       if (val >= core->num_parents)
> +               return -EINVAL;
> +
> +       parent = clk_core_get_parent_by_index(core, val);
> +       if (IS_ERR_OR_NULL(parent))
> +               return PTR_ERR(parent);
> +
> +       clk_prepare_lock();
> +       ret = clk_core_set_parent_nolock(core, parent);
> +       clk_prepare_unlock();
> +
> +       return ret;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(clk_set_parent_fops, NULL, clk_set_parent_set,
> +                        "%llu\n");
> +#endif
> +
>  static int clk_duty_cycle_show(struct seq_file *s, void *data)
>  {
>         struct clk_core *core = s->private;
> @@ -3285,9 +3309,14 @@ static void clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
>                 debugfs_create_file("clk_parent", 0444, root, core,
>                                     &current_parent_fops);
>
> -       if (core->num_parents > 1)
> +       if (core->num_parents > 1) {
>                 debugfs_create_file("clk_possible_parents", 0444, root, core,
>                                     &possible_parents_fops);
> +#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
> +               debugfs_create_file("clk_set_parent", 0200, root, core,
> +                                   &clk_set_parent_fops);
> +#endif
> +       }
>
>         if (core->ops->debug_init)
>                 core->ops->debug_init(core->hw, core->dentry);
> --
> 2.30.2
>
