Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF4A3C9967
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 09:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbhGOHMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 03:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbhGOHM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 03:12:29 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7F1C061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 00:09:36 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id w1so4097186ilg.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 00:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9B+oTQwgmo4p1Ky+jMiYsVX5twnQnFrh+/KabLkfKoM=;
        b=gXX+pNEeNfCIXnvpl5zzg72jHjH+3zkYJyYwbmO1kzh6ft7/OouMUm8xc5cxG1XPp8
         Vfl1oHQrkntzz2y4B62MFB0npJvEz/EllABrsOjYb23ZWwcji9c17WbupAJqSMCKjf0q
         P9puY5/sExP8rW+vR6b7vTTJ9DDQLHDyikWKMFxq6Z+CSp+C0hNwnB5kLycCHNfoPdF0
         ZME0I/BW6gRIqG6XyZirldBU3sEofWoFpeDFdYt+CBSvj2oKp21RqmylUxRHM9lqPuuJ
         Njxiq/CD9vBHyByW1XrAxcB0Y//F+cqnQDlTU5eH2uxU8VpUmofQm/oQOYs4ipZrnaFl
         xsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9B+oTQwgmo4p1Ky+jMiYsVX5twnQnFrh+/KabLkfKoM=;
        b=CjoLZpo9QKOn0wu+knfXvQ4rcNkAzAao7eB3WALQbUhJjzS+6+ISlUJBiyfD5lorJ+
         a0T9enVpFH2nnjQouclGNEZOLtqawIkaSUvfzWa1ZBQ+Re/+o8nlKr5tN3nG3TaOifZ8
         oE/whRX94DdJE1u2Li+oCdqYR+S76CkWKjutXjFJ/OY9fFjzDJxDo5Nb0o21QYmdqVNJ
         UCRwaM6z6DlCoBMfWR44iLWp0aVJtA8edI3emx3sTVH2VehQroR/Zz+r2Oto1tuvOgYY
         7ei/GbsUN6xj+poEK5/O6nv5n6YRjy4cELQUbDO9ouIqP11Nm7wqeFDj9ZQggvhM41gg
         inBg==
X-Gm-Message-State: AOAM533OeEwp3q3PCNKSEIul0J7fYEaru7pB0Tk7e/Vvp+8lkVtRbAy0
        lWCYQmxdKs4bDdcCYWqZxrCWHcskwFIvW8f2E4RG0w==
X-Google-Smtp-Source: ABdhPJwuKUmsa/XevSPh49jg4k4QcER8gMdTrKqp3qt3Rwy5IFwH+L9++y/Wz79S7Mh+BnEstfthYeRZOPSds8h1z9k=
X-Received: by 2002:a92:d990:: with SMTP id r16mr1786919iln.204.1626332975821;
 Thu, 15 Jul 2021 00:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <1626316157-24935-1-git-send-email-kewei.xu@mediatek.com> <1626316157-24935-9-git-send-email-kewei.xu@mediatek.com>
In-Reply-To: <1626316157-24935-9-git-send-email-kewei.xu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Thu, 15 Jul 2021 15:09:25 +0800
Message-ID: <CA+Px+wWNcSkxvsEoUrgBN73+jhq8qjFJodYjQnY1zW2d0a5yRA@mail.gmail.com>
Subject: Re: [PATCH 8/8] i2c: mediatek: modify bus speed calculation formula
To:     Kewei Xu <kewei.xu@mediatek.com>
Cc:     wsa@the-dreams.de, matthias.bgg@gmail.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com, qii.wang@mediatek.com,
        qiangming.xia@mediatek.com, ot_daolong.zhu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 10:32 AM Kewei Xu <kewei.xu@mediatek.com> wrote:
> When clock-div is 0 or greater than 1, the bus speed
> calculated by the old speed calculation formula will be
> larger than the target speed. So we update the formula.
The patch sounds like a fix up.  Need a "Fixes" tag.

>         for (clk_div = 1; clk_div <= max_clk_div; clk_div++) {
>                 clk_src = parent_clk / clk_div;
> +               i2c->ac_timing.inter_clk_div = clk_div - 1;
Using the way to pass the parameter "inter_clk_div" to
mtk_i2c_calculate_speed() looks like a hack.  inter_clk_div is set
again[1] next to the for loop.

[1]: https://elixir.bootlin.com/linux/v5.14-rc1/source/drivers/i2c/busses/i2c-mt65xx.c#L831



I have no domain knowledge of what/how the patch fixes.  But if this
is a standalone fixup patch, suggest separating to an independent
patch.
