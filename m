Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F74A3B8CC4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 06:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhGAEFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 00:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhGAEFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 00:05:01 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBF5C0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 21:02:30 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u13so9289239lfk.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 21:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hi2FrhIaizwpDJPwnSinv9W2oMvoHm0CGYALUuuXDs=;
        b=kWWeltzlSYGGc5QRSaAkNEu3wbwvMTyMjx7Hi1Du8rAm3U1ZDS7a2a2e9GB/JtvpeI
         3iWP3ESanAX0jItDlj8NFWAfWGDMbaPHtU+xbFrBLaplzEIJyb0VhMk8diCaNxGaxuzy
         R8XGe8kox80GEpIggg2eFJJwK/ZKq3i11ixHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hi2FrhIaizwpDJPwnSinv9W2oMvoHm0CGYALUuuXDs=;
        b=n2OcA+dk61ONC7esu10sFYDO73S8ynizzWiv+D56dR3yeOJdBXa4xX8dq7K7w9G73n
         2/JLGpqMVDQ0gPGfaloj12ZsVPzQcBSszHyp5K5utuxShKdOoSMM8VyQoVH6A9zZD80N
         oQGqM0OQemGuNWeprsNijGMmEiwtYayAL+NsfDMLbrRsVUD+3Se2r4Y5rMPxdNeeC1Ec
         607iJgDkvj0n7YQbErdY6v1WrwS0Jvw2qmwLbLCUBNtHPPBkek100DyxKHl8i6Vho473
         ucf+UFCnDqBRuHz9M9EuTegK94EMT/Z8hVsjnamEFNHEZS/YuQq/5LjV1bnZ9D2tz7h6
         1cRA==
X-Gm-Message-State: AOAM5302Eoz5CYqTVMMBm6GekahErBsjxVrM0fcEzoR4Ejk6ZAdkBzLs
        DC+nYJmJuxHpLObAIYOAaKJGUZzH/vlNPkjX2ZytOQ==
X-Google-Smtp-Source: ABdhPJw/v6AwK/W5MblRaHBzvNcBF8/BLoJuYBeXADDntlPIgf2Bpc9gBKz0UhSMGyatSQ8BxnhizhHgp4pWwKlsVxw=
X-Received: by 2002:a05:6512:63:: with SMTP id i3mr29997663lfo.587.1625112148504;
 Wed, 30 Jun 2021 21:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
 <20210616224743.5109-4-chun-jie.chen@mediatek.com> <CAGXv+5F2zTcqnjH2ud38vUD149KJtgxhPQME2Mk6-vGtQv+2YQ@mail.gmail.com>
 <ff6179e8-06f9-fbba-c704-a74381c2149a@gmail.com> <CAGXv+5FXuMnhsnytLYKKA9YE97bps7KnkDNADvv8f_wdTqnrfg@mail.gmail.com>
 <be824462-4c2f-3bde-0a3d-c5470a5b0fbb@gmail.com>
In-Reply-To: <be824462-4c2f-3bde-0a3d-c5470a5b0fbb@gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 1 Jul 2021 12:02:17 +0800
Message-ID: <CAGXv+5FSq-cCRR-wB_kp2s+59273r0nrhtkH9006ezN-sUtNzQ@mail.gmail.com>
Subject: Re: [PATCH 03/22] clk: mediatek: Fix corner case of tuner_en_reg
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"On Wed, Jun 30, 2021 at 7:43 PM Matthias Brugger
<matthias.bgg@gmail.com> wrote:
> On 30/06/2021 13:09, Chen-Yu Tsai wrote:
> > On Wed, Jun 30, 2021 at 6:53 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> >> On 30/06/2021 09:31, Chen-Yu Tsai wrote:
> >>> On Thu, Jun 17, 2021 at 7:01 AM Chun-Jie Chen
> >>> <chun-jie.chen@mediatek.com> wrote:
> >>>>
> >>>> On MT8195, tuner_en_reg is moved to register offest 0x0.
> >>>> If we only judge by tuner_en_reg, it may lead to wrong address.
> >>>> Add tuner_en_bit to the check condition. And it has been confirmed,
> >>>> on all the MediaTek SoCs, bit0 of offset 0x0 is always occupied by
> >>>> clock square control.
> >>>>
> >>>> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> >>>
> >>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> >>>
> >>> Though you might want to consider converting these types of checks into feature
> >>> flags.
> >>>
> >>
> >> Yes I think adding a feature flag is the way to go. Luckily there are only a few
> >> SoCs that will need updates at the same time.
> >
> > I also see that the different clock modules are tied together using only clock
> > names written in the drivers, instead of clock references in the device tree.
> >
>
> Not sure I understand what you mean. Do you refer to something like [1]? That's
> because the clock is probed by the DRM driver, as they share the same compatible
> and IP block.

In the example driver you mentioned, most of the registered clocks have the same
parent clock, "mm_sel". This clock is from another hardware block,
"topckgen" [1].

The two are linked together by looking up the clock name. The link should be
explicitly described in the device tree, instead of implicitly by some name
found in two drivers. The consuming driver can fetch the clock name via
of_clk_get_parent_name(), or be migrated to use `struct clk_parent_data`,
which allows specifying local (to the DT node) clock names or clk indices
as parent clk references.

What's more confusing is that the mmsys node actually has "assigned-clocks"
properties [2] referencing the "mm_sel" clock, but not "clock" properties
referencing the same clock. On the surface this looks like the hardware
is trying to configure clocks that it doesn't use.

Also, Maxime Ripard made the argument before that "assigned-clock-rates"
doesn't give any real guarantees that the clock rate won't change. A
better method is to request and "lock" the clock rate in the consuming
driver.

So overall I think there are many improvements that can be made to the
Mediatek clk drivers. They aren't real blockers to new drivers though,
and I think each would take some effort and coordination across all
the SoCs.


Regards
ChenYu

[1] https://elixir.bootlin.com/linux/latest/source/drivers/clk/mediatek/clk-mt8173.c#L545
[2] https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/mediatek/mt8173.dtsi#L996


> Regards,
> Matthias
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/mediatek/clk-mt8173-mm.c?h=v5.13#n139
>
> > Unfortunately reworking this would likely require a lot more work. I previously
> > did a bit of internal reworking for the sunxi drivers. While not the same, I
> > think the plumbing required is comparable.
> >
> > ChenYu
> >
