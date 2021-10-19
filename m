Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B19B433189
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhJSIty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbhJSItw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:49:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41049C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 01:47:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so1447869pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 01:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=znWZG2M98SQpNWFciGHdUDcSpYrmNay3HXZ/Xgvx0nQ=;
        b=hEkwiTfRoPxhHXNChWGHFpjXsRoCzFgOhcDJVcFb2EUxBXvPL7YNM8vzDqEaxifEWt
         XyRsaOLf513n3Hm4cwHeZ3PNg1jzY05CvpllA4duP87gf31xWcixHlMPT1KNTTUSklSo
         TxKcopEN7uwFOndGqsIxBJvcAZsL0LPoc84zRBq28ske+f60EbSlDD7vieQOOA84dtO3
         AjyF/oEsSWufzljc/T1xKLjQwfiPSEFkDlSg+HkfoMzQE6/ItzxefQSjo7m/1Kjsr2k9
         iHKJK3rtoZp7ygnxscq++fK5OCElm4OJPbqnvGI92ogkFL9tHfMFSJc2Gt/gQh34Fzw0
         8PzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=znWZG2M98SQpNWFciGHdUDcSpYrmNay3HXZ/Xgvx0nQ=;
        b=ZmD+2fxD3xlI4Te/NcyvI45iBTL/R9nuJwGBxcx59ShmkPA7+2nt9PKYu81aIVgAp3
         2Q3Rrye0QM7POJZjS3AKFbXhK9/7shSfUg5etdaF7A2ofaLy8bho2L6Nk9v6fsHOV3+t
         CKOuxaCvOA4QQCjPuTQT+cJD521kw7/B/5ZQYB6Nq2S0hGwLwygEaK4aMQJt1Z/jZLG/
         8Hg8+DTZ0HBNF0YT5goEOw/2Ha8wrKRqr6KBe2yzKKaC8PtIcnSCLIoiT1d9cIK5Emax
         gcLZmVMDLFFUEu8TzKC1rTT1h+Kt7X9knllvh/n/LliBR3hmNZX/PcYZid6KkNK9yWED
         0hiw==
X-Gm-Message-State: AOAM531gYZx9ihG99KucuvW8jTARrDgGIwhUP2JNjAhef2R3uBzLXrqs
        AwN3VESq5qOcsb+CAznJ5K26jXM5vNV0XtXKxZCviQ==
X-Google-Smtp-Source: ABdhPJwJ5xzkp1s6vmtXEwTN3PMELy5xyWA5fOFd8eRIT/kgvNpG/hpMer48La8Bi54Wv63ViFaFTb4JBmjnj9bdod0=
X-Received: by 2002:a17:90b:4c0d:: with SMTP id na13mr5003522pjb.232.1634633259748;
 Tue, 19 Oct 2021 01:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211002233447.1105-1-digetx@gmail.com> <20211002233447.1105-2-digetx@gmail.com>
In-Reply-To: <20211002233447.1105-2-digetx@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 19 Oct 2021 10:47:28 +0200
Message-ID: <CAG3jFyuYjCgUZWbksYvfw0iSOi-hTuFqvbwSamU+9HFG5MxHBQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] drm/bridge: tc358768: Enable reference clock
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Dmitry,

Thanks for submitting this series.

On Sun, 3 Oct 2021 at 01:35, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> The driver assumes that reference clock is always-enabled, but this is
> hardware-dependent and not true for ASUS Transformer TF700T. Make driver
> enable / disable the reference clock.
>
> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # Asus TF700T
> Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> #TF700T
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index a3db532bbdd1..18ae6605a803 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -237,6 +237,10 @@ static void tc358768_hw_enable(struct tc358768_priv *priv)
>         if (priv->enabled)
>                 return;
>
> +       ret = clk_prepare_enable(priv->refclk);
> +       if (ret < 0)
> +               dev_err(priv->dev, "error enabling refclk (%d)\n", ret);
> +
>         ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
>         if (ret < 0)
>                 dev_err(priv->dev, "error enabling regulators (%d)\n", ret);
> @@ -274,6 +278,8 @@ static void tc358768_hw_disable(struct tc358768_priv *priv)
>         if (ret < 0)
>                 dev_err(priv->dev, "error disabling regulators (%d)\n", ret);
>
> +       clk_disable_unprepare(priv->refclk);
> +
>         priv->enabled = false;
>  }
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
