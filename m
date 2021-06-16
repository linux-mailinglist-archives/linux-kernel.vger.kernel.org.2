Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54933A99DF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhFPMFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 08:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbhFPMFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:05:50 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88110C061767
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 05:03:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h12so2049867pfe.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 05:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8I4Y9wOWt0L9Wjhz/UCy2dwBA6LBFaECPMUl0PK0S+Y=;
        b=iOp03LxUSsUIVfOPyK6+qrON59uFFnI+lLpZQNmg4K7I4gv9z25zZiFLkHse5fxWi3
         gOQHyvMLemnvxyNSaqv/1j6jgvBTx8Bcn1+UcislZdN2rXbDI53R1R4r/8SbawsCWatn
         vtVAr0XYGAq2oMqIrPwY8TW+piDJvRIrDtXc8yC9MM1Q8lNqKBdol2Gxbs9N0OaqioLR
         5aeecQv4c9yxOi9lABNXJcmUavzPvw5mwmUxXQzARxk8KuU0yey9GzG11/6YCV2tNg2R
         DtQPtH0uCEsnWDDlVOMJ62BOnMhtNhZMMYyzfY0YJ1Y7GjSsUcSAplDsb9qlUrvo+7Dq
         vEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8I4Y9wOWt0L9Wjhz/UCy2dwBA6LBFaECPMUl0PK0S+Y=;
        b=F3e8zYlCLfc88vISUsPlQVcDVyZJpcYM1XgvoDm0qyyXonL8h5E17bXzAgH9jLoPCH
         fS4cIB3a1Ap8JvfEyWX2cgKmVfbWHn8RqyAlldqcvHeXVlT+LMxSQLVuF6XeQoF6C/MG
         Mu82HRf68vovdVCJFoy8IQQjY9BJQmlGTngi9N7zXQ0rfvQQ7RhbSR/L1tc6NsM/SLwj
         g/UshB/e4P9yCtUPMdAHiIJ4Jcvz7QX5Wk6UH0aUOKvK2lHJM+qsqMN0kvOHttRp5KGl
         YcDfLX2RbCEf1JCJ2wIFMXM6zblxu2ebwrNOMBjM7MsaF9bvauKMBkI9FZ/6VOzJFqCz
         4UTg==
X-Gm-Message-State: AOAM5309tOZ1f0tagvgjcAJ+2Aklll6E2EkeYks3fxdilO7rpscUa5qw
        kuxxlfsxTVj6Y9rXfSLG8EqTQ/GcYbiVGknwwFqd7g==
X-Google-Smtp-Source: ABdhPJzACOhUT8Swsb7rdD3D3OgQRthCK6TgJyy6RebksECPcC41qgjbK3tbJX6LYcSA6xiPPw77mA14Ipfdys8YUQ8=
X-Received: by 2002:a62:1b91:0:b029:2fd:2904:938a with SMTP id
 b139-20020a621b910000b02902fd2904938amr3131409pfb.18.1623845024015; Wed, 16
 Jun 2021 05:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210616034448.34919-1-yujiahua1@huawei.com>
In-Reply-To: <20210616034448.34919-1-yujiahua1@huawei.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 16 Jun 2021 14:03:32 +0200
Message-ID: <CAG3jFyuJBFM-2KbJM_3FOisD1B8fz=AkAykW5KZfnbROyn3FQQ@mail.gmail.com>
Subject: Re: [PATCH -next] drivers: gpu: add missing MODULE_DEVICE_TABLE in anx7625.c
To:     Yu Jiahua <yujiahua1@huawei.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.co>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Yu,

Thank you for submitting this, it looks good to me and I pulled into
drm-misc-next.

https://cgit.freedesktop.org/drm/drm-misc/commit/?id=ad5fd900a69b1ae24e6b22506dea637b6bbbdb55

On Wed, 16 Jun 2021 at 05:44, Yu Jiahua <yujiahua1@huawei.com> wrote:
>
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
>
> Signed-off-by: Yu Jiahua <yujiahua1@huawei.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 65cc05982f82..beb01364af4d 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1830,6 +1830,7 @@ static const struct of_device_id anx_match_table[] = {
>         {.compatible = "analogix,anx7625",},
>         {},
>  };
> +MODULE_DEVICE_TABLE(of, anx_match_table);
>
>  static struct i2c_driver anx7625_driver = {
>         .driver = {
> --
> 2.17.1
>
