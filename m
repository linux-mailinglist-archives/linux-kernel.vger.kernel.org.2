Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D8238E874
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 16:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhEXONa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 10:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhEXONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:13:14 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CC3C06138C
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 07:11:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w33so32919777lfu.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 07:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m9TQta/QWmtE8jsxsWMQFJ3ws/ti47t8fXgwLG9HD/I=;
        b=yaSVC5r2H4+Jb6XAZ22WZsyVh4uCJhRTrZ7FoI6hDuzWt7hyzIBOUwehOgCl+U9FK4
         VkT3o7ew3hxO5p6dEGNnjHCnzwlKkLYLVTgZ1BCvrgdWy+/zc7Q4nYPWHZ76qOR1gH5A
         RA3sK1LhHcXkPDeYih+aWQaleJq+kbE0uxVYburpXmboR216E8C/lIJTNIEbJKAB0nD8
         QXGEYzJcU+4AnI8nGq2pegagUjRPyR2sK81G1dCnuTXrnRA2V7cnnaafAfoAfwCiPbi1
         5UqddMcOpiKZVlOU6fv9K9VIieiNVCPK2y57EMc5CuHMOuwqW5NFoSHnmooEAnhAZCvr
         RMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m9TQta/QWmtE8jsxsWMQFJ3ws/ti47t8fXgwLG9HD/I=;
        b=DRtin6xO5/qUpz3tcTM6PcMfgPGSaS+GVyVVC9KCrA2DzjSPlXX96iXqw9tRWjM5UE
         yhAWoCS1bBb6Qyhe/uVTt8b4ZlKXWp49AC0gv+LSL+PI9XwjRyoeO0KKeHiPTOq2kDYG
         mJpxL9x/rpYMnUMeohKOROcd8D+fPIQSaKlSDHwPZwBeIb4CYZgPMCKftXFniZQbmtkl
         Ua5jcoTkvS/RQtpItA/R568eaM/iUr86RLDCC2aQEpxzp/J50N21y6uiIkrAUbBwRipY
         KG3QF4uov7XNf199r8XTzryrjFwtfV77W5bZJOWCrnJI5Z67XixE4LVYnlxWKNsuNg9W
         7/4A==
X-Gm-Message-State: AOAM530/G4foxP7k0ZDe4L/qJ9OG23c7dVhTvtNNY8KaBunuK5+N8/VV
        Yf6GrzR6YmJ9FNehTlaKbwF09MByFZEX2MZsmpRk1Q==
X-Google-Smtp-Source: ABdhPJyca77dNeXLxWCBq81HpNkv55TNmbVC6ws5IelbcnzJpm29Yn+XRdC2MhiwEYc933RD4U6pMLpP1o2D+yaSPbg=
X-Received: by 2002:a05:6512:1150:: with SMTP id m16mr10577037lfg.486.1621865504561;
 Mon, 24 May 2021 07:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210523155914.5200-1-shiv14112001@gmail.com>
In-Reply-To: <20210523155914.5200-1-shiv14112001@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:11:05 +0200
Message-ID: <CAPDyKFptp7cJ1zq8nHCWoY5D+AJ8uzs2MiqnUGdT8d8eq3Rw_Q@mail.gmail.com>
Subject: Re: [PATCH] This commit fixes the Error or Warning about missing or
 incorrect SPDX license headers.
To:     Aviral Gupta <shiv14112001@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Zhan Liu <zliua@micron.com>, Avri Altman <avri.altman@wdc.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Luca Porzio <porzio@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 May 2021 at 18:00, Aviral Gupta <shiv14112001@gmail.com> wrote:
>
> By adding missing SPDX-License-Identifier tag line in drivers/mmc/core/block.c this issue is fixed.
>
>
> Signed-off-by: Aviral Gupta <shiv14112001@gmail.com>

Applied for next, by amending the patch prefix, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 689eb9afeeed..266d62f9dbc8 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Block driver for media (i.e., flash cards)
>   *
> --
> 2.25.1
>
