Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E8045EFC1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 15:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353541AbhKZOVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 09:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348631AbhKZOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 09:19:41 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FE3C08EA7E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 05:32:21 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id j18so5593244ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 05:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BihJj1qpi6FzzYvrNJZtab4h849IlijBgKxFTqdVcok=;
        b=lE+PYnpDr4XYfE0rLaRAQtWaz2Ks2mMu9n1rZVymx2rgHoJAITvz559plBVApGYtUZ
         5INIqFHDmCIP9B/+nDcxBK28yZiP6c8COBl7Aa0hcA5X5B3jL+HCF+3qHnaEquoLrwdz
         aMnCviANj/UutBT84isZSwj3tz8Yt4qD+Y2YOVWzf6D8AZL0xAr8lvG9Zn7JegsUqeU2
         5mn9kTy0lPf34z/6whn0mN3eQcxWdds2i+mORvr6lTpxL161CTeKsZVkyTA8WKy0G6IN
         tBGjA4e+W3F+K+thIQ7cHZRMFUNkf9qUb3Gpapa+HwOPMOXdnqeKS3cCoFqg6zJCgYUC
         532w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BihJj1qpi6FzzYvrNJZtab4h849IlijBgKxFTqdVcok=;
        b=7dztd8DzglB8sDydfDVz1eldJPJm3gWltRqvUlKJnEcZIM4kaw0HvwjgTskes35Toq
         SP+KWzaJYcq97v1IMaaEWxhCX0UZeJnMxtK8GUn9PRVVsB15sJmU5muKvEQu3Lz3G2Wb
         GWVIOkyDKn5EwiJwTKn50Swi14KoBu7XhqyFdaWOGqgEFBBJL+wv4x2NQxec4l4CRVLv
         uu3Cow2WUmf1sB47IWtJI3KXy9lWDjrVmk90gmKo/lquJ8jZ754JLOZGu3LJfq312xyF
         2eaZBvKvSz6RhfBx4EjB9S5B4ga9EYphsF25kFqXjbn4zYDzmbt/Yp+r6uItZvYsPmwh
         EexQ==
X-Gm-Message-State: AOAM530qKTBfJFQRw/H+5BXkuDrCCIrOdVLTN61mAhG8LSPxpsXZVxOH
        /tapp1CNa8E4zrav0UN6TT3r6khjrUR3Xtv2en0sHLrgIMk=
X-Google-Smtp-Source: ABdhPJzywiDDQKC6yFc3WwKw4jiKbh02+WUllDWYJLGKGv2knX9b5u54YH9Xh2KPDV4cD5Ewh2BWBkykMbYrS9LL70c=
X-Received: by 2002:a2e:a22a:: with SMTP id i10mr31783402ljm.16.1637933539553;
 Fri, 26 Nov 2021 05:32:19 -0800 (PST)
MIME-Version: 1.0
References: <20211124184603.3897245-1-john@metanate.com> <CAPDyKFr=ok3uKXS8bWtZPvyLOeA2cF_4Z2c7ROcoMfBF2G1uhA@mail.gmail.com>
In-Reply-To: <CAPDyKFr=ok3uKXS8bWtZPvyLOeA2cF_4Z2c7ROcoMfBF2G1uhA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 26 Nov 2021 14:31:43 +0100
Message-ID: <CAPDyKFo8c51KR+1ju+WCp2xk7_uYKzS+_vBjWxnB7Y3zGYasFg@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: dw_mmc: start deprecating mshcN aliases
To:     John Keeping <john@metanate.com>
Cc:     linux-mmc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 at 20:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 24 Nov 2021 at 19:46, John Keeping <john@metanate.com> wrote:
> >
> > This series is prompted by discussion on a previous patch set [1] but is
> > a totally different approach and only a partial solution.
> >
> > With these patches, the dependency on the mshcN alias is totally removed
> > from dw_mmc-hi3798cv200 and dw_mmc-rockchip and dw_mmc-exynos moves
> > towards being able to consider the mshcN aliases deprecated.
> >
> > I haven't changed dw_mci_hi6220_caps here, although it looks like it's
> > possible to apply MMC_CAP_CMD23 to all controllers there with no change
> > in behaviour as the final entry is SDIO for which CMD23 is not
> > applicable IIUC.  But I'm not familiar with that hardware and don't feel
> > confident making that change.
> >
> > [1] https://lore.kernel.org/all/20211116190244.1417591-1-john@metanate.com/
> >
> > John Keeping (4):
> >   mmc: dw_mmc: add common capabilities to replace caps
> >   mmc: dw_mmc: hi3798cv200: use common_caps
> >   mmc: dw_mmc: rockchip: use common_caps
> >   mmc: dw_mmc: exynos: use common_caps
> >
> >  drivers/mmc/host/dw_mmc-exynos.c      |  9 +++++----
> >  drivers/mmc/host/dw_mmc-hi3798cv200.c |  9 +--------
> >  drivers/mmc/host/dw_mmc-rockchip.c    | 11 +----------
> >  drivers/mmc/host/dw_mmc.c             |  3 +++
> >  drivers/mmc/host/dw_mmc.h             |  3 +++
> >  5 files changed, 13 insertions(+), 22 deletions(-)
> >
> > --
> > 2.34.0
> >
>
> This looks good to me, I intend to apply this later this week, unless
> objections of course.
>
> In the meantime, I will continue to look at what we can do to resolve
> the exynos/k3 issues around this.

Let's consider additional changes to be on top of this, as this is
certainly a nice step forward.

So, applied for next, thanks!

Kind regards
Uffe
