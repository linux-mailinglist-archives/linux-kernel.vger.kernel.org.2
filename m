Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029213B2387
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 00:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFWWWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 18:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhFWWWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 18:22:30 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAFEC061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 15:20:11 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id q190so9325316qkd.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 15:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J0o69ZpxKlT1ALV6x4fn+6s1AcHCCKWZKDnuPxJmTV0=;
        b=M32nuub7utJPjcnDhjTbeGhLaiYx37NognHb9zlFGO8qCxvDDxHTaeDCkfycW8V9jJ
         l2LomWfxefoSUGDPirxMjo4GLgReQ2P2qYRSoj0lm1y5X1zu1ZesG703lbfwrtAcTVv9
         cQ+dlMT0m3s2+Yg7gerWlJcWOAHGpKbzOjNgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0o69ZpxKlT1ALV6x4fn+6s1AcHCCKWZKDnuPxJmTV0=;
        b=jIV2rxzgGlntyfa61pcsI6fnbeyQmyV2OGyjy0nTsJfgzvP8wE/mYU/HPwznNzqsxE
         QuM3K5sS+9ODYbqCTPPNk1NvfO6+0L7fW1NRzXMaStkE6vPCAcIvBE3VxufF0ArMDCqG
         dxgxeCg7QIU0JRM6KRC80yeC8rSqtjvwttkgeWslii57nFeLZjMzBZNF1Kzxye5L1Inq
         5vkncboEKHIaoUzT9r6c34Y3qRWjyLYI4QCR5jcdvf6AyQdrQiTSCAuWhELYSQ8vJF57
         YwQ6zL02se9oc0c8fDN4SsxGRr+9fU7P51j6+2EaTSxca19/yzPvpVoSqBs4XPBn0iR/
         um3g==
X-Gm-Message-State: AOAM531hAyyW/YYaWiEJgj55xgGS53FZEqe+TzAceSgyEJOqZyHfwe+k
        7erax9mTQgMmzlu67dM5psU1H6cjUvmgFg==
X-Google-Smtp-Source: ABdhPJwYk1QlBIaWGCNZyxpLo5SL7QISzhLbOYGM7jmi7Bk0TWG7ZHKnwl7mHFRYUcX4Vht7uGlTwg==
X-Received: by 2002:a37:84c3:: with SMTP id g186mr2355565qkd.276.1624486809956;
        Wed, 23 Jun 2021 15:20:09 -0700 (PDT)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com. [209.85.222.173])
        by smtp.gmail.com with ESMTPSA id l23sm912081qtp.28.2021.06.23.15.20.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 15:20:08 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id bm25so9485941qkb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 15:20:07 -0700 (PDT)
X-Received: by 2002:a25:60c1:: with SMTP id u184mr393689ybb.343.1624486807505;
 Wed, 23 Jun 2021 15:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210623032755.1170809-1-bjorn.andersson@linaro.org>
In-Reply-To: <20210623032755.1170809-1-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 23 Jun 2021 15:19:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VbWu-zK=uuuYRBnddao4X5ELT29L=Dn_mBLG57kzuK4A@mail.gmail.com>
Message-ID: <CAD=FV=VbWu-zK=uuuYRBnddao4X5ELT29L=Dn_mBLG57kzuK4A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] pwm: Introduce single-PWM of_xlate function
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pwm <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 22, 2021 at 8:28 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The existing pxa driver and the upcoming addition of PWM support in the
> TI sn565dsi86 DSI/eDP bridge driver both has a single PWM channel and
> thereby a need for a of_xlate function with the period as its single
> argument.
>
> Introduce a common helper function in the core that can be used as
> of_xlate by such drivers and migrate the pxa driver to use this.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v3:
> - None
>
> Changes since v2:
> - None
>
>  drivers/pwm/core.c    | 26 ++++++++++++++++++++++++++
>  drivers/pwm/pwm-pxa.c | 16 +---------------
>  include/linux/pwm.h   |  2 ++
>  3 files changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index a42999f877d2..5e9c876fccc4 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -152,6 +152,32 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
>  }
>  EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
>
> +struct pwm_device *
> +of_pwm_single_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)

It's probably up to PWM folks, but to make it symmetric to
of_pwm_xlate_with_flags() I probably would have named it with the
"_with_flags" suffix.


> +{
> +       struct pwm_device *pwm;
> +
> +       if (pc->of_pwm_n_cells < 1)
> +               return ERR_PTR(-EINVAL);
> +
> +       /* validate that one cell is specified, optionally with flags */
> +       if (args->args_count != 1 && args->args_count != 2)
> +               return ERR_PTR(-EINVAL);

I don't know all the rules for attempted forward compatibility, but
unless there's a strong reason I'd expect to match the rules for
of_pwm_xlate_with_flags(). That function doesn't consider it to be an
error if either "pc->of_pwm_n_cells" or "args->args_count" is bigger
than you need. Unless there's a reason to be inconsistent, it seems
like we should be consistent between the two functions. That would
make the test:

if (args->args_count < 1)
  return ERR_PTR(-EINVAL);


> +
> +       pwm = pwm_request_from_chip(pc, 0, NULL);
> +       if (IS_ERR(pwm))
> +               return pwm;
> +
> +       pwm->args.period = args->args[0];
> +       pwm->args.polarity = PWM_POLARITY_NORMAL;
> +
> +       if (args->args_count == 2 && args->args[2] & PWM_POLARITY_INVERTED)

Similar to above, should this be ">= 2" rather than "== 2" ?

I also notice that in commit cf38c978cf1d ("pwm: Make
of_pwm_xlate_with_flags() work with #pwm-cells = <2>") Uwe added a
check for "pc->of_pwm_n_cells" in of_pwm_xlate_with_flags() right
around here. You're not checking it in your function.

I _think_ your code is fine because I can't see how "args->args_count"
could ever be greater than "pc->of_pwm_n_cells" but maybe I'm not
seeing something. Assuming your code is correct then maybe the right
thing to do is to remove the extra check from
of_pwm_xlate_with_flags() to make the two functions more similar.


-Doug
