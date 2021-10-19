Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9617C432C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 05:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhJSDHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 23:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhJSDHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 23:07:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0D4C061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 20:05:08 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i24so4095201lfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 20:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2RwHxSx3TiJnEJ/9dbX2TWefdd9wWbyowa5HQ0W9C7Q=;
        b=mNGO7s6puZSQ2VapweLJ0fNTY5XwkSE3LnLZo/QEeCE630qcjlF/cihEYJZW/EVF/5
         CbZj0rMMLs7/50AMBAyFCryuVy8QXuRza6IR2f/QIphmxiEqQtGKaJHDsLXqHxFYyWda
         ymrNT2gwMDK3w6Dnxva0EYDnEa8VwkywyW93o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2RwHxSx3TiJnEJ/9dbX2TWefdd9wWbyowa5HQ0W9C7Q=;
        b=lNE6YTqNa6m4TVbzaAdx9+9h2iolnv5CvQuwJWJTaZAFUY9Pf9W9Rz1NP9W3K/JLmt
         oTsLSRj2SUaTNfcItPUGwoSQeuqXXHviTaV9tyOxxdV4WfIbFaPjUsgqHZ/R9gPQhXH/
         0xLNQdFI7i0+wmZNvG9L7VLJKqrbuKwUj5umsxg+jnVvflifj1kAeFSHl6+jH+Sb+am4
         3oY3xCacr1XRjwiY4tv/WzUoLeYbAB33WPCYYWDzU3bndtUKhXTXKueXdG7fpaSWn/DR
         L7iXzrOv/WgeU+UBiPvXLHk5MhPdtuxYW0eMUsUdh0+5CvjjZRQa2R9a4tSOCMm1d4uF
         omew==
X-Gm-Message-State: AOAM533eZSOZliZoOMVpC4qfW4vG6f7RsA3jHdGYhvOsSSskJIoElHaf
        iYwnmtJZAdU39MNMwagLAEkwYyUgHBa2tf/Zzzul+A==
X-Google-Smtp-Source: ABdhPJwD3DifPQ8LZU5dqzif2r7i/5I93Q/94pY/t9RnGIA9JJT3zvS/eJXVikSsp2wvgoZh14V0Jm3BISb9j6i55vs=
X-Received: by 2002:ac2:58ec:: with SMTP id v12mr3496440lfo.371.1634612706009;
 Mon, 18 Oct 2021 20:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211019013759.970600-1-ran.jianping@zte.com.cn>
In-Reply-To: <20211019013759.970600-1-ran.jianping@zte.com.cn>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 19 Oct 2021 11:04:55 +0800
Message-ID: <CAGXv+5G5JAOgvPatqto45daQsxL+OqTHboLXZwCc-nPY9saT6w@mail.gmail.com>
Subject: Re: [PATCH clk:mediatek] clk:mediatek: remove duplicate include in clk-mt8195-imp_iic_wrap.c
To:     cgel.zte@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        ran.jianping@zte.com.cn, linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 9:38 AM <cgel.zte@gmail.com> wrote:
>
> From: Ran Jianping <ran.jianping@zte.com.cn>
>
> 'dt-bindings/clock/mt8195-clk.h' included in
> '/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c' is duplicated.It is
> also included on the 13 line.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Ran Jianping <ran.jianping@zte.com.cn>
> ---
>  drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
> index 0e2ac0a30aa0..1aa5afc05929 100644
> --- a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
> +++ b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
> @@ -10,7 +10,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/platform_device.h>
>
> -#include <dt-bindings/clock/mt8195-clk.h>
> +

Just drop the line. Don't need the extra empty line.
