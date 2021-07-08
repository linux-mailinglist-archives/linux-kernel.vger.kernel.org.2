Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD083BF9E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhGHMPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhGHMPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:15:03 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480C3C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 05:12:21 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id j8so3488014vsd.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 05:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=74IJmH2QOykPmJGuffsoKEUZ/+2Y969fvLtQrP2crS8=;
        b=qsUzl9LuVVs31f2p2N+5FDKJIVdBSGTKmilQcBklUBWzcfLxem9wLrc5JqbrUk8ItT
         ia5nwKG5PLcGSh1vFhOE3SJGs4l4jRSUjlrPmKuSJoT3UFUghN3OS5U3+NOuFufDnQD9
         Rvo/Y7GwXNgACHTD0Rd0VpOZthsXsvi8/MSZe9A9Xw+4T9UOppfwzi2qdbQ/EtAxBxW6
         0fcHXGKYP+wP+Di4elb5VFNdAL+cZoP7Zd4xCvGw1ctVhUnOmXdbcd1+gve2ZgFeilNW
         d84Jbdb059jMbfBs6+ZCXn/XPouW9sjUNt0zy2bHtzjmruzkxSYKJQkXsIPgSjC2gS2J
         L2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74IJmH2QOykPmJGuffsoKEUZ/+2Y969fvLtQrP2crS8=;
        b=ZfUlVi5rvwghMak7HgpXY8942lWRwfWN+B0StKrXY2IGIwKECVys70rwNu304y8exs
         X8FWGieDTc0X16qlobpnNzCbpnLpTAKNbacd1l7tlEYdZkddEfvvw2aNxPecwagbwtHx
         mBOFv5vGckkOPH8Jm8MfRph/SsOKVD6e/ReC2J7aqOJAt2EFFQKmHnmf+9JhPnNraWTe
         xGyW/CdwoM8gVmSaltn7FwTq+iym1LPP1fmbS59XL7mKms1d/P4jm7kmMqUNKMmKlWMP
         DZmGIecFVYQNjSeUXGn8QczAFUr7sFsCTIuSzh/2KIyEYQWZf1abVz6krNqBrmdE7IUY
         PUDA==
X-Gm-Message-State: AOAM530X4RzK5zBCvVnoyovI0ktqFo3b7F51hPisHE+Ibs1c52u14ddy
        cHcO8ipxXPUHK0YuAipVQdBkI799R4w01eUvuUQe0Q==
X-Google-Smtp-Source: ABdhPJz5qXBkYjOlV4N1RGqbTLijRshQKc1z2Yw7EU94BW5+ZsEbGwsZEibUUF8kltbRyJggYBt0M7qyOrdXOwn24dc=
X-Received: by 2002:a67:ee54:: with SMTP id g20mr27453162vsp.55.1625746340485;
 Thu, 08 Jul 2021 05:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210623075002.1746924-1-swboyd@chromium.org>
In-Reply-To: <20210623075002.1746924-1-swboyd@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jul 2021 14:11:44 +0200
Message-ID: <CAPDyKFozrrtwOEzBeKctD5fRM=D0dg9N=kFsvdXXDO-zD51Diw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Two mmc fixes for IDA and KASAN issues
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sujit Kautkar <sujitka@chromium.org>,
        Zubin Mithra <zsm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021 at 09:50, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Here's a followup to a thread I sent a couple months ago[1]. They're only
> marginally related to each other, but I have bundled them here into one
> series to make it easier to track. Resending to restart the discussion.
>
> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Sujit Kautkar <sujitka@chromium.org>
> Cc: Zubin Mithra <zsm@chromium.org>
>
> [1] https://lore.kernel.org/r/20210413003621.1403300-1-swboyd@chromium.org
>
> Stephen Boyd (2):
>   mmc: block: Use kref in place of struct mmc_blk_data::usage
>   mmc: core: Don't allocate IDA for OF aliases
>
>  drivers/mmc/core/block.c | 35 +++++++++++++++++++++--------------
>  drivers/mmc/core/host.c  | 20 ++++++++++----------
>  2 files changed, 31 insertions(+), 24 deletions(-)
>

My apologies for the delay! The changes look very good to me, thanks
for helping out!

FYI, I did some more thorough analysis of how the block device
reference counting/locking should be managed, from a generic point of
view. Your change in patch1 fixes the immediate problem with the KASAN
splat I reported, but also moves the code in the right direction.

However, there are lots of additional improvements that deserve to be
made (another possible KASAN splat) for this related mmc code. I am
looking into this and will keep you posted. :-)

So, this series is applied for fixes and stable tags added for both
patches. Again, thanks for helping out!

Kind regards
Uffe
