Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F3738E8C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 16:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhEXOcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 10:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhEXOcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:32:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB72CC061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 07:30:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q5so28751179wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 07:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=orAplirkWFknLWPMzVptcilNsNkdO+txSDeVHlyUIIY=;
        b=V1WeL0MdBuCjmtFOYJ/om7yQj6y8yOrb//GjPqdgtk11rQZN/7yPBrAKAd/KfOCJ0I
         2WYh2Nt60DVeJBFIWJnwC3DNvXM4xds6aIHEnePxhR11BvHfE21Etz6M5wwejVyGKDSS
         CWS38FMFysxoXrQ5oJ1JLluJahFCeX0r7+HhPxQOEyPfLSwB47xlTmPIRZN55VXAGHWJ
         5kUEYuoGeYdZz1VmRv6UMlCO7pLVftxou+XWpXXc1a+TyhXpJ9vpLff/WQYh5Kllqrcv
         kLwBHK9JWAA5r8czTK/6eteUnG0qFjxxMoVGz1JNQQ4C1qSOFR4hoNkrBAYgVyW5aXR9
         Xi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=orAplirkWFknLWPMzVptcilNsNkdO+txSDeVHlyUIIY=;
        b=j+L/HBpNsVrIhcUQRtHYLgj1yzlfaPVcBQxG1DPoRiHMcwvwJ4YCraCVEshdfaZXJp
         d8Av5khclL9tBhHVxZmebD6qDjB6jTzUskCd3X1+VO5FgZqeByaqhssPPgIl3J6HsP8t
         wUARdP0eqV8jjSDQDjNFj2TPVWpqbaUIruKey+QNibUyPJAWCBL41BfkrpWuaRnPMa9W
         PVmMVMmG7ZxN1OYxNoOcjyMRQto3QyAKqN5oPPo1I46RpO+5nEGaYrh/cKBsWAJV+FnT
         ORYaHix6+3PfYoEp5NgxYLJQsGwwvoKrKTmG026IS627ZbeYN3bWLrQutfXHqNoGAMze
         MSOA==
X-Gm-Message-State: AOAM533I6y+PqzKVRZjR9pY7hXWYN4Zg/G1zCp7+KMXAH3ZqdGBNu/7m
        sIc4yaeRURpiXf/uPJsG3ngrXQ==
X-Google-Smtp-Source: ABdhPJzzflD8S1xyzfWbn0VxC6DWx5C3QgvKTnnhg286AVQN/zJPEz8HFWusZWy6bjUPluSQDZc3Jg==
X-Received: by 2002:a5d:6e03:: with SMTP id h3mr10890801wrz.138.1621866638160;
        Mon, 24 May 2021 07:30:38 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id c194sm8192606wme.46.2021.05.24.07.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 07:30:37 -0700 (PDT)
References: <20210524134517.687089-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        khilman@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: meson: meson8b: Use CLK_SET_RATE_NO_REPARENT
 for vclk{,2}_in_sel
In-reply-to: <20210524134517.687089-1-martin.blumenstingl@googlemail.com>
Message-ID: <1jmtskb3w2.fsf@starbuckisacylon.baylibre.com>
Date:   Mon, 24 May 2021 16:30:37 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 24 May 2021 at 15:45, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Use CLK_SET_RATE_NO_REPARENT for the vclk{,2}_in_sel clocks. The only
> parent which is actually used is vid_pll_final_div. This should be set
> using assigned-clock-parents in the .dts rather than removing some
> "unwanted" clock parents from the clock driver.
>
> Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> After a hint from Jerome (thanks) this is the improved version of
> "clk: meson: meson8b: Don't use MPLL1 as parent of vclk_in_sel" from [0]
>
>
> [0] https://patchwork.kernel.org/project/linux-clk/patch/20210524104533.555953-1-martin.blumenstingl@googlemail.com/
>
>
>  drivers/clk/meson/meson8b.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index a844d35b553a..0f8bd707217a 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -1175,7 +1175,7 @@ static struct clk_regmap meson8b_vclk_in_sel = {
>  		.ops = &clk_regmap_mux_ro_ops,

I just noticed that these muxes are read-only ATM.
It does not make this change (or the previous one) wrong but it does not
make much sense as the mux won't ever change.

I suppose you make this mutable with another patch later on ?


>  		.parent_hws = meson8b_vclk_mux_parent_hws,
>  		.num_parents = ARRAY_SIZE(meson8b_vclk_mux_parent_hws),
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
>  	},
>  };
>  
> @@ -1358,7 +1358,7 @@ static struct clk_regmap meson8b_vclk2_in_sel = {
>  		.ops = &clk_regmap_mux_ro_ops,
>  		.parent_hws = meson8b_vclk_mux_parent_hws,
>  		.num_parents = ARRAY_SIZE(meson8b_vclk_mux_parent_hws),
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
>  	},
>  };

