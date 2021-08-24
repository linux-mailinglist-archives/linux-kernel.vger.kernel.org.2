Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1050E3F691C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbhHXSfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhHXSfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:35:30 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2C6C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:34:46 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso33770879ota.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=MpSjVxSMjJK4OJw4oTKLD3JL0PWvQPTVS0fPqXZYl3g=;
        b=n/JcnajTDuWMOgB1dqCLhqVz/SK9+IAgpIc6Z5Dlx0X3Bz7NVcegvqK2cpm3DNJbPQ
         10DZqlRko41kmEobXSLmA4zrYTieEAA4vI1y7bwkO66KsdU7sMqstshTU6BpT0hdAZfy
         i6kXOJtX6evRy9U7I6Sp6+LA4yS0fHqGvNoOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=MpSjVxSMjJK4OJw4oTKLD3JL0PWvQPTVS0fPqXZYl3g=;
        b=PEoL39Ggkzs+1ZXfCcaxeg+N3194be7yomA/DiWBAbDEoKTlYD5Q97qQyJeo5+wblO
         DCOIgpyVVyCYfZvjlSCrFGCjYtU50zCVGSsTUw85U8uSMV6XUSsYqv9+z+0jh1gELgng
         wRxER/rcz+j1j1TmzSBNQ34IxG3Ow5dY7m4YNqpvj3o6W7Q5ZtwsnowprYNeE4X6efZZ
         Ha7MO50FXtVTdyacATLUlA8A0NLD7CXiYukok0ppQSqxATP9wweOxAp/4hucXNcWQdfE
         HGZWzmxPpR9LoPK6cfA1sjXx4hr+IIgHYndiwaGuSC/bPCgdk46bAK6Ywh4NGhls+uhc
         hJNQ==
X-Gm-Message-State: AOAM5303WLGy3VJi4yg6vx7BV6kwZUGBByQRyFLL/FZab3WwmxwicaSK
        1xK8w0WX8kt9OgvzRO9qWXlzhEjI5yif/PbrsNbYFQ==
X-Google-Smtp-Source: ABdhPJzRH/Uc7RJJIpCbxFsIdbJBiPfb7rT9/hLjX1Vp9cEqoF/t87EH1mDk73cPqGvQmJ4MtwBCUJQX8YPNs8ZHDkQ=
X-Received: by 2002:a05:6808:180e:: with SMTP id bh14mr3854642oib.19.1629830085691;
 Tue, 24 Aug 2021 11:34:45 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Aug 2021 11:34:45 -0700
MIME-Version: 1.0
In-Reply-To: <1629113954-14084-2-git-send-email-deesin@codeaurora.org>
References: <1629113954-14084-1-git-send-email-deesin@codeaurora.org> <1629113954-14084-2-git-send-email-deesin@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 24 Aug 2021 11:34:45 -0700
Message-ID: <CAE-0n50G_OYqR6R8+K5RkrCBvdQW-E-zDoMZ-yyAoEJW2WyxcA@mail.gmail.com>
Subject: Re: [PATCH V6 1/2] soc: qcom: aoss: Expose send for generic usecase
To:     Deepak Kumar Singh <deesin@codeaurora.org>,
        bjorn.andersson@linaro.org, clew@codeaurora.org,
        sibis@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Deepak Kumar Singh (2021-08-16 04:39:13)
> Not all upcoming usecases will have an interface to allow the aoss
> driver to hook onto. Expose the send api and create a get function to
> enable drivers to send their own messages to aoss.
>
> Signed-off-by: Chris Lew <clew@codeaurora.org>
> Signed-off-by: Deepak Kumar Singh <deesin@codeaurora.org>
> ---

With one nit below

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
> index 934fcc4..a43c22c 100644
> --- a/drivers/soc/qcom/qcom_aoss.c
> +++ b/drivers/soc/qcom/qcom_aoss.c
> @@ -515,6 +521,48 @@ static void qmp_cooling_devices_remove(struct qmp *qmp)
>                 thermal_cooling_device_unregister(qmp->cooling_devs[i].cdev);
>  }
>
> +/**
> + * qmp_get() - get a qmp handle from a device
> + * @dev: client device pointer
> + *
> + * Return: handle to qmp device on success, ERR_PTR() on failure
> + */
> +struct qmp *qmp_get(struct device *dev)
> +{
> +       struct platform_device *pdev;
> +       struct device_node *np;
> +       struct qmp *qmp;
> +
> +       if (!dev || !dev->of_node)
> +               return ERR_PTR(-EINVAL);
> +
> +       np = of_parse_phandle(dev->of_node, "qcom,qmp", 0);
> +       if (!np)
> +               return ERR_PTR(-ENODEV);
> +
> +       pdev = of_find_device_by_node(np);
> +       of_node_put(np);
> +       if (!pdev)
> +               return ERR_PTR(-EINVAL);
> +
> +       qmp = platform_get_drvdata(pdev);
> +
> +       return qmp ? qmp : ERR_PTR(-EPROBE_DEFER);
> +}
> +EXPORT_SYMBOL(qmp_get);
> +
> +/**
> + * qmp_put() - Match get_device() inside of_find_device_by_node()
> + *            in qmp_get()

I meant to put this comment next to the put_device() call. This should
say something like "release a qmp handle" and then the existing comment
moved down to the if below.

> + * @qmp: qmp handle obtained from qmp_get()
> + */
> +void qmp_put(struct qmp *qmp)
> +{
> +       if (!IS_ERR_OR_NULL(qmp))
> +               put_device(qmp->dev);
> +}
> +EXPORT_SYMBOL(qmp_put);
> +
>  static int qmp_probe(struct platform_device *pdev)
>  {
>         struct resource *res;
