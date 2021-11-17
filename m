Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A7E454A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbhKQPmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhKQPmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:42:01 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6843DC061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 07:39:02 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y13so12823288edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 07:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/TcUJQTDYWocWle3f9+mogG0dpTJDH1Ke5aeq+Kuctw=;
        b=joPwOVbt1twtXo/4m3BpjAd0tmFyGp+4+AQ7dd3n37c7Fcg8XMqZbwCcm2lzNMKK0U
         iFrBcyuCqSsEiN7nK0VnOyLs0FEbawStKzliiT1aSsl+FDLkeK2p+GmbIQy1yPkhKNIh
         QFIfsanQg3QCCkRIOu3Mf/0tQVC0tVfHpix4n/p399+SBT1hTDO833ZiAZjlS3pbnpmC
         1gTf4IuuU4yZd3WLQ4IiA4AB0+rK8v+57QR0qI02JZXflknZjDBoBlKAaFtdYte439Zg
         Wno2xib9gbE/+xoo+HToxeUscFbz0XqARcOrBxG/eozBG/PUGsfVGY40vZ9gubHTaqCP
         puJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/TcUJQTDYWocWle3f9+mogG0dpTJDH1Ke5aeq+Kuctw=;
        b=hGOAI7j/aFcfKI8oQQ9g6r9ryqeXyAnDKh27gN/overnrAKeo0e5WqPdlHbloHfra1
         NMVz5+/LxF02eKXjFJztmR7SXqxPk/zJ1w7wTQX/ytE7J/SAaNjHchVEsgngbzcnChnW
         YPiRKN+YSkM99L6vhwRr+5a86OoDks2Y2og6lqylUsNuy6TdEybZ/ZGBUhCGJaTQcWS+
         6KMv7WcnXMw/xDMxLOUn6IR8r1cY7HkCgcNfweE12MeRMBmMhc7shWia2zPy28iWlVs6
         rTBsxCZzXk96kN6BPvqGYyxVowvVIyIEzrHc05uX/HiztXlQw1dYXifeX+4/xWa68May
         QwiA==
X-Gm-Message-State: AOAM530S+7RS5IdAvR5nBY2ojIKtmunm11rzpJ3cGyl6+Uhx5OdQIyab
        2yWC9KZJgQ2tv1t7Q8fpXzlHOvxBXHaVmHRCwNEFtw==
X-Google-Smtp-Source: ABdhPJxbO9oM7lYebEc5d09CygmBuYbwNSeVKmi4BSitEspHl+XiObU1tYWWHIftk13/zbdiQ0us7Zx6BT6sQbCaRDU=
X-Received: by 2002:a17:907:3c16:: with SMTP id gh22mr22098760ejc.344.1637163540895;
 Wed, 17 Nov 2021 07:39:00 -0800 (PST)
MIME-Version: 1.0
References: <20211117142115.694316-1-anders.roxell@linaro.org> <YZUY69vfq/RrVWMw@archlinux-ax161>
In-Reply-To: <YZUY69vfq/RrVWMw@archlinux-ax161>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 17 Nov 2021 16:38:50 +0100
Message-ID: <CADYN=9J9L+nY1vMSnPGeam5+KSm-tH37_j1CYokp8etHOP1evA@mail.gmail.com>
Subject: Re: [PATCH] soc/tegra: fuse: fix bitwice vs. logical warning
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        ndesaulniers@google.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 at 16:00, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Wed, Nov 17, 2021 at 03:21:15PM +0100, Anders Roxell wrote:
> > When building with clang-13 the compiler warns about:
> >
> > drivers/soc/tegra/fuse/speedo-tegra20.c:72:9: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
> >                 reg = tegra_fuse_read_spare(i) |
> >                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >                                                ||
> >
> > This should be a logical OR so change it to fix the warning.
> >
> > Fixes: 7e939de1b2bb ("soc/tegra: fuse: Unify Tegra20 and Tegra30 drivers")
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>
> I sent the same patch a couple of weeks ago (but it was right before the
> merge window so I am sure nobody was really paying attention):
>
> https://lore.kernel.org/r/20211021214500.2388146-1-nathan@kernel.org/
>
> I do not particularly care which one gets merged (although I think mine
> explains the warning a little bit better).

I missed that, sorry.
I agree I think your changlog explains the warning better.

Cheers,
Anders

>
> I am not sure your fixes tag is right, I would expect it to be:
>
> Fixes: 25cd5a391478 ("ARM: tegra: Add speedo-based process identification")
>
> With that fixed:
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> > ---
> >  drivers/soc/tegra/fuse/speedo-tegra20.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/soc/tegra/fuse/speedo-tegra20.c b/drivers/soc/tegra/fuse/speedo-tegra20.c
> > index 2546bddbab93..4984246605ae 100644
> > --- a/drivers/soc/tegra/fuse/speedo-tegra20.c
> > +++ b/drivers/soc/tegra/fuse/speedo-tegra20.c
> > @@ -69,7 +69,7 @@ void __init tegra20_init_speedo_data(struct tegra_sku_info *sku_info)
> >
> >       val = 0;
> >       for (i = CPU_SPEEDO_MSBIT; i >= CPU_SPEEDO_LSBIT; i--) {
> > -             reg = tegra_fuse_read_spare(i) |
> > +             reg = tegra_fuse_read_spare(i) ||
> >                       tegra_fuse_read_spare(i + CPU_SPEEDO_REDUND_OFFS);
> >               val = (val << 1) | (reg & 0x1);
> >       }
> > @@ -84,7 +84,7 @@ void __init tegra20_init_speedo_data(struct tegra_sku_info *sku_info)
> >
> >       val = 0;
> >       for (i = SOC_SPEEDO_MSBIT; i >= SOC_SPEEDO_LSBIT; i--) {
> > -             reg = tegra_fuse_read_spare(i) |
> > +             reg = tegra_fuse_read_spare(i) ||
> >                       tegra_fuse_read_spare(i + SOC_SPEEDO_REDUND_OFFS);
> >               val = (val << 1) | (reg & 0x1);
> >       }
> > --
> > 2.33.0
> >
