Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C6D3ED42A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhHPMmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 08:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbhHPMk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:40:59 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C69C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:40:27 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id j186so8181884vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNwNXBDUCMkICc2Rzv/9tnwKQF1vpl085cudEYRntr8=;
        b=eJ2Z9oE5XSxgvUeoUoyA/QJ3fbSbHxOql3/ikT40/h43t83u9YAwm5tAMJnIaEyg9f
         44FiyWb/5H3WGR/ajGF13MxeUzFqLItwt44K/lzpxpI/Ptn8oIfP5knni2Y24xqOF7p2
         ktZnZyUFYQrCyls8vP166RJWV3FxOzNTr149i/UL1H8No7CEqSHsNMaCWckYipyM5Q1y
         UvvXuTrGbqS/jwtjW/VMb/bbJ7k5HrOfPPNAVyCcFMzKfLLTNbMsU01qcOvZ4zgekOsa
         u4QlGOSN67FvIzBkrcTUMJwEiCvyjvLOuefHSogxy7lhHe4ou6SKfToph75Pp7xyWPwx
         hJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNwNXBDUCMkICc2Rzv/9tnwKQF1vpl085cudEYRntr8=;
        b=DvNmhOyTwZXt18qiYePn+GQ7ChC5MbUsc12Pn10hzYF3vpeAc23KY+3l9CopHFK3ju
         31evWMMTJ07mxhvQSFcrqYF4RxwLPoka/VznruisfCUlknL8VHE2p5t0ifzRX65+5lo/
         hK+DFDO5GYc8J+udRLxuSxC7HBtGbepsLd12RYF6duTtjSXaaUgSM4/NkT45uEEAfqTi
         ze6qnRvdbRu6P04wmraHs15sAjRQqmb6UUCG2tJMh27PQir1h8aWf6g+cX8ywfht6RtL
         E2Qi5WixKgjsHVHxBLg0cQAjZ9IGmwdaJbr6rjbJLDcs5Xa13vlwPGuUzKr34BzmIXuh
         QAoA==
X-Gm-Message-State: AOAM532rhr2uz7ks0rtADX1FGRPdjLWpiCtsJtAt3xwEWVuykXeJWSkX
        X6G7wppShnCg1lshWuU5t/YgNk6SCvsyy8cllgmZtA==
X-Google-Smtp-Source: ABdhPJwnIQS+cXgSTOG+a52nR/Nh2oBLImU+hFLKk4wPBtJQC0PSnWjuzP3Uv4Ytu64uB5g5788/5QHxin3DbwAOFZU=
X-Received: by 2002:a67:7cc9:: with SMTP id x192mr9550967vsc.42.1629117626325;
 Mon, 16 Aug 2021 05:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210816032003.1162779-1-jay.xu@rock-chips.com> <20210816032003.1162779-5-jay.xu@rock-chips.com>
In-Reply-To: <20210816032003.1162779-5-jay.xu@rock-chips.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Aug 2021 14:39:50 +0200
Message-ID: <CAPDyKFqYPfYqmFWHy818EKam7AOk1gNs99JAy3=W5cDGeE1QrQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] soc: rockchip: io-domain: do more thing about
 regulator notify
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, zhangchangzhong@huawei.com,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2021 at 05:20, Jianqun Xu <jay.xu@rock-chips.com> wrote:
>
> Do a fix to rockchip io-domain, follow this orders:
>
> * system running state
>   -> io-domain vsel to 3.3V
>     -> regulator_enable
>       -> vsel change according to regulator voltage
>
> * system running state
>   -> io-domain vsel to 3.3V
>     -> regulator_disable
>
> Found on some Rockchip SoCs, the regulator enable or disable without
> care about the io-domain maybe caused soc damaged.

Can you please try to elaborate on the problem a bit more, as I don't
quite get the problem.

What regulator is causing this problem? Who is the consumer of the regulator?

Kind regards
Uffe

>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> ---
>  drivers/soc/rockchip/io-domain.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/soc/rockchip/io-domain.c b/drivers/soc/rockchip/io-domain.c
> index cf8182fc3642..af5fb11ad9a3 100644
> --- a/drivers/soc/rockchip/io-domain.c
> +++ b/drivers/soc/rockchip/io-domain.c
> @@ -123,6 +123,12 @@ static int rockchip_iodomain_notify(struct notifier_block *nb,
>         } else if (event & (REGULATOR_EVENT_VOLTAGE_CHANGE |
>                             REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE)) {
>                 uV = (unsigned long)data;
> +       } else if (event & REGULATOR_EVENT_PRE_ENABLE) {
> +               uV = MAX_VOLTAGE_3_3;
> +       } else if (event & REGULATOR_EVENT_PRE_DISABLE) {
> +               uV = MAX_VOLTAGE_3_3;
> +       } else if (event & REGULATOR_EVENT_ENABLE) {
> +               uV = (unsigned long)data;
>         } else {
>                 return NOTIFY_OK;
>         }
> --
> 2.25.1
>
>
>
