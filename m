Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4733F4528
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 08:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbhHWGni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 02:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbhHWGnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 02:43:37 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A2FC061757
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 23:42:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id i28so29563585ljm.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFJ5qArshzVHf3q7jRlOWQagxpfLOrv79VSjCdNEbCA=;
        b=Zf7g29E3w/mMGEQGTHke0IP1vIqXBP/xGjiHyLab7RfdnbLe9ZNKiyevv6kO2oi89n
         3wsWr3eIiIFkS8ODwd2HPqhiTr/XmNhM2RqeP8M7oo/E8+KI1mkd/dwW5x0YHqVVg7ii
         Gbc8dt9O4AM7OBaotSD53oVjK7yj0Ezk2OaJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFJ5qArshzVHf3q7jRlOWQagxpfLOrv79VSjCdNEbCA=;
        b=PeQWPTZyullx0GFLvdRC90JAgwTYT3QnmmSzRyjEpXOYg31g0MOFryxjyLedOhjJWK
         5syFGwiAyUduiKY8UDw3ZP7tKKRByvGcvomtk3e3htCu7PDaRYMJqsI0+PC2Z19jCePM
         WU34ocSNY15xFSSoxPOQdby15/o6SOBwaEREeuxnOk+/3ktyFKP1HNehCOU2kE/5HFlm
         4XWtez5Y+HAlFf6lPwGtz3qZXkSQDxtjTXXGJlzkwZ6a80wkfe8ehSwlQBzvdcCDDTmE
         3dBzB1eu1Z7iOEsz5d827swbnJJ3eGyMWuPtMm8aRyTVo3Wz1/nrgThxvC7bsa5g6pwn
         l/qA==
X-Gm-Message-State: AOAM5309izTuVeOsY6AFNZSxt1xJElqK7Pxf5kECjJurXOwPH63DXbWl
        /EXKLMnzRawVe0zio7/gocoo87aqrwwFlbKOMdJflQ==
X-Google-Smtp-Source: ABdhPJxTuOEDNkFKHBotXobJuIjH4Z7qG0KV3mS8Xf0E+WOygl2HTPZPkLpJ47L2eJAse8NeczQkwyQsSN8xFb81ERI=
X-Received: by 2002:a05:651c:211a:: with SMTP id a26mr12902308ljq.305.1629700973307;
 Sun, 22 Aug 2021 23:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210820111504.350-1-chun-jie.chen@mediatek.com> <20210820111504.350-6-chun-jie.chen@mediatek.com>
In-Reply-To: <20210820111504.350-6-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 23 Aug 2021 14:42:42 +0800
Message-ID: <CAGXv+5EReMTGS02SgVO_yrpChOiw++3rwfc0Jx66CBzuDHOXAQ@mail.gmail.com>
Subject: Re: [v2 05/24] clk: mediatek: Fix resource leak in mtk_clk_simple_probe
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 7:19 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Release clock data when clock driver probe fail to fix
> possible resource leak.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  drivers/clk/mediatek/clk-mtk.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index c3d385c0cfcb..74890759e98c 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -314,7 +314,15 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
>
>         r = mtk_clk_register_gates(node, mcd->clks, mcd->num_clks, clk_data);

Note for future reference: there is no unregister counterpart for
mtk_clk_register_*.


>         if (r)
> -               return r;
> +               goto free_data;
>
> -       return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +       r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +       if (r)
> +               goto free_data;
> +
> +       return r;
> +
> +free_data:
> +       mtk_free_clk_data(clk_data);
> +       return r;
>  }
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
