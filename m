Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052C73F6D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 04:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbhHYCPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 22:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbhHYCPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 22:15:17 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16A0C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 19:14:27 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id t2-20020a4ae9a2000000b0028c7144f106so6073309ood.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 19:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EqCJDw6pwwqcA3u963UfsU6r31LKcgwNEuHo0x3pVt4=;
        b=PHELEcFGD+KCRb+ykFErfan7cTCGvFBynYZyiUM07izhx1J9Dq48E13dItIRSbzf9x
         mmKfAhGY3hJVqpeCLG7FVGeNzdNi/MugPEQFQqpNWcXzD6B7Ab7VXgW/PicyapTAAyF9
         DdnTKClFljT2/ZCX45WzsUVpEA8I0CaevOmLhY9joRwuYZR/jJ3VAevFyest4vAK3eSn
         1BXS9KeFieeeVlpfVRdUeYDe1U9Gk9y+zjK+V0TAaeOjhnkDK4SIrWetY4U0kHnQKIZc
         mFJsFVl8X5oia0wgoD0RwQRu2rVd3CtAVyWR9pr6G5fcbfdN+wNY830dyECo+EuBM7UE
         CX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EqCJDw6pwwqcA3u963UfsU6r31LKcgwNEuHo0x3pVt4=;
        b=ix0+2rSn5aRq8yl5eXaBCI5DVYomX+QqSIdUHaHQFkaudQxuhmoxBtyf0Lc9W3k3Iw
         rXZgtnfH6BlZbiTLtxyIp38+AAlLPLpw1YLfOCw1JyTU0lKMCScYP7GaC8XI8qnp+HTz
         OxNNa00DqyN1lA1aDXIyVUs9nrBYfUiv/05IEag9EvaPfbrtucvWYdad3jACF3QSIpG/
         wQihONpJnGPdaSu4HbqeGvivSBmuHC5x9mB6xR4Jw4WpG9gR8gW3D6JCp+k1gOJdZ6Vs
         WNbkfRvng4h/bso6nnaMZ4NMeb+asV657xXPnELAJwFAvjv1pSjU88Npkm0fl7ptumn5
         ++/w==
X-Gm-Message-State: AOAM532ZaSYo7HCEWOphDfpGczLk3/RMJtJxHEk9HcKdvqPVQgxCjbXd
        cRMsLr5HMNBqkV5X2TI7VUCQ36UED3nbbuvGVW2XwQ==
X-Google-Smtp-Source: ABdhPJwGdyLaOrvtYRVGttPSukOVCRVyx+hg8mPlVBNhC/K0UG/FYc5Wa1O4T8axKx/aN0mDFUp1YoufiSBg5dsuJnI=
X-Received: by 2002:a4a:754b:: with SMTP id g11mr32762267oof.10.1629857667201;
 Tue, 24 Aug 2021 19:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210617220229.7352-1-zev@bewilderbeest.net>
In-Reply-To: <20210617220229.7352-1-zev@bewilderbeest.net>
From:   Lei Yu <yulei.sh@bytedance.com>
Date:   Wed, 25 Aug 2021 10:14:16 +0800
Message-ID: <CAGm54UEvQG9_AiL_o9R3ZVpF4oT0Te7DC+oHLWsNGrwVuCfJJw@mail.gmail.com>
Subject: Re: [Phishing Risk] [External] [PATCH v3] media: aspeed-video: ignore
 interrupts that aren't enabled
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Eddie James <eajames@linux.ibm.com>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        openbmc <openbmc@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 6:02 AM Zev Weiss <zev@bewilderbeest.net> wrote:
>
> As partially addressed in commit 65d270acb2d6 ("media: aspeed: clear
> garbage interrupts"), the ASpeed video engine sometimes asserts
> interrupts that the driver hasn't enabled.  In addition to the
> CAPTURE_COMPLETE and FRAME_COMPLETE interrupts dealt with in that
> patch, COMP_READY has also been observed.  Instead of playing
> whack-a-mole with each one individually, we can instead just blanket
> ignore everything we haven't explicitly enabled.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>
> Changes since v2 [1]:
>  - minor commit message improvements
>
> Changes since v1 [0]:
>  - dropped error message
>  - switched to a blanket-ignore approach as suggested by Ryan
>
> [0] https://lore.kernel.org/linux-arm-kernel/20201215024542.18888-1-zev@bewilderbeest.net/
> [1] https://lore.kernel.org/openbmc/20210506234048.3214-1-zev@bewilderbeest.net/
>
>  drivers/media/platform/aspeed-video.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index 7bb6babdcade..77611c296a25 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -563,6 +563,12 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
>         struct aspeed_video *video = arg;
>         u32 sts = aspeed_video_read(video, VE_INTERRUPT_STATUS);
>
> +       /*
> +        * Hardware sometimes asserts interrupts that we haven't actually
> +        * enabled; ignore them if so.
> +        */
> +       sts &= aspeed_video_read(video, VE_INTERRUPT_CTRL);
> +

Without the patch, the driver gets an unhandled IRQ in a few hours
after the KVM page is opened.
This patch is tested on Bytedance's OpenBMC system and the issue has
not been reproduced anymore.

Tested-by: Lei YU <yulei.sh@bytedance.com>

-- 
BRs,
Lei YU
