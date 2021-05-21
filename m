Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B07138C970
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbhEUOrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbhEUOrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:47:07 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61968C061763
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 07:45:44 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b12so17018352ljp.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 07:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOsFDhv1c3rYeM/biOU1mt6E1GzqKW1CDuSDPJ87gBg=;
        b=n2qwyuP1LnEDqSwud8bOvkR68TEYaKqXc8oI/yr+qYo1V/9Y7mIX2FSlKzA192fIGi
         6R9nTLo1mKi0Z4iB8pCvyOf2RZBFi0wFr/Gg1P73WEDCGXJHPLuCTa2fs3wBjmGZ7oF6
         FyjzcW9iyakYrXjWjqP9cRvwkkjeloZ2tUrQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOsFDhv1c3rYeM/biOU1mt6E1GzqKW1CDuSDPJ87gBg=;
        b=jPa3n+XsyNMv2aSwfhqlyOW8nYQsbZRkUhmXc9IAioi7B1M3O3pXPbe2EVU026u2ps
         SYTA3QwHxQgGWQ40JM/p/ebqknroaFHrfu84eKMyMzcjvhojHXBMhGXsb3DBDY+vlgUd
         JxkCu0sNQRbmedX/1NtKPmWppKrpywB1XtNpnJWeRZdNhodQsbeOeDueaMSToOgiDRVD
         84JUZqWdGP7AJuN53uHzUZTc95aiLcJq4UoHxbYsB+O8845PrBzLReB+wGmGBq2TPDcj
         0iCZXpnxPFoXEr40S1x4wRs4B09U6HYKm+iuHdYl8hWKFDr3s6en/Hw3aXSKbBwn8yq6
         RdYg==
X-Gm-Message-State: AOAM532F2O2Ms9kVj1KuAFufQju0hML3EgojVCNAQI9QKzDKwPctlVL0
        dS7qmuOZYvQqf3w7LtQU7X99/GEDrU7DULVoqyXthQ==
X-Google-Smtp-Source: ABdhPJxANzTqCdHdUqkIIdiznQKltNQSijCrMEhvOw7yhFmeXbFanluhc0vMVcUKNnP3g3gOLA7OjrpUhlHnmL9o4SY=
X-Received: by 2002:a2e:a554:: with SMTP id e20mr6930274ljn.23.1621608342766;
 Fri, 21 May 2021 07:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210521200038.v14.1.I9f45f5c1f975422d58b5904d11546349e9ccdc94@changeid>
In-Reply-To: <20210521200038.v14.1.I9f45f5c1f975422d58b5904d11546349e9ccdc94@changeid>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 21 May 2021 22:45:31 +0800
Message-ID: <CAGXv+5HX+Hw-S=8SQOy5hjMUxFM-oBFFESzh3LQTEVpy=54Aeg@mail.gmail.com>
Subject: Re: [PATCH v14] arm64: dts: mt8183: Add node for the Mali GPU
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        hoegsberg@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        boris.brezillon@collabora.com,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        fshao@chromium.org, hsinyi@chromium.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resent to all recipients)

On Fri, May 21, 2021 at 8:01 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> Add a basic GPU node for mt8183, as well as OPP table.
>
> Note that with the current panfrost driver, devfreq is not
> actually functional, as the we do not have platform-specific
> support for >1 supplies. Also, we are missing code to handle
> frequency change, as the GPU frequency needs to be switched
> away to a stable 26Mhz clock during the transition.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> The binding we use with out-of-tree Mali drivers includes more
> clocks, this is used for devfreq: the out-of-tree driver switches
> clk_mux to clk_sub_parent (26Mhz), adjusts clk_main_parent, then
> switches clk_mux back to clk_main_parent:
> (see https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.19/drivers/gpu/arm/midgard/platform/mediatek/mali_kbase_runtime_pm.c#423)
> clocks =
>         <&topckgen CLK_TOP_MFGPLL_CK>,
>         <&topckgen CLK_TOP_MUX_MFG>,
>         <&clk26m>,
>         <&mfgcfg CLK_MFG_BG3D>;
> clock-names =
>         "clk_main_parent",
>         "clk_mux",
>         "clk_sub_parent",
>         "subsys_mfg_cg";
> (based on discussions, this probably belongs in the clock core)
>
> This only matters for devfreq, that is disabled anyway as we don't
> have platform-specific code to handle >1 supplies.

Yes. This can be done with clk_notifiers. See

    https://elixir.bootlin.com/linux/latest/source/drivers/clk/sunxi-ng/ccu_mux.c#L261

for such an example.


ChenYu
