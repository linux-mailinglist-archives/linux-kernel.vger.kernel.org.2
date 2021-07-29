Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121503DA886
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhG2QLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbhG2QKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:10:14 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F974C0619C0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:08:03 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id p38so3621912qvp.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7rnfNZ1smkd3MOn2QE94nhDLg5Z3RCUAAhAiNnfRCE4=;
        b=JO+Wc0xx+6zrqWzU8d5m29orUQfNIbr+4Or7rVWWlQ13j9DpUSX3xkJWhtz51wsxdG
         tiaNwM9js+uKQYNP4kt6zhVkU0DN/T9JgTXJUdHwFpFSunFwYIvk03BdYsklBUrYxQ4P
         oCjMOKJ1XcklPD/WBBqk1Xe2qXRuH5g8oUFpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rnfNZ1smkd3MOn2QE94nhDLg5Z3RCUAAhAiNnfRCE4=;
        b=NpC1gMUV/yp3veGqhHQCRjRBmXidVOi9LwH1HTKJCZLfkP/HS5B43xGePucikbuk+w
         idCK995E8014lpWmboiHcWQAPYRnOurMxqx171y8iKGwmoawCb77JZ/NpTuy/pxOyV5d
         SkP0ayKuN3C4dDj5G40Nl/PpPslIPPyF+J2LbYUgFgseoB9sM/RjLlAPkZQy+0aOAzD6
         2qM8vn81JmUSGamJxg1DzpS1ZhB8NvlcJJ345xbKkJuU9HjSbQAnfZFS65jUD+MzEWfU
         FT0AVlRLhgWoli5z5X6IPWcxoJGTBZZ91d3i5wnvnvEyBAplmWPstdqugZp6k9jjXBmT
         d2Lg==
X-Gm-Message-State: AOAM532HQD4psMpllaCk8Xi+9CUvZLR8qrNQH4OBt9FrVdeTcTruSFc9
        ayN/A+Dwe0eKp0btdmRXIzO+w2YgQsrWkg==
X-Google-Smtp-Source: ABdhPJyQXVyD7oyuY5gn60SSAa/YsphTCnRuFVev9dtT16ulnieGbd0vsfu4oE9vqqp2BvpXp0YMlw==
X-Received: by 2002:a0c:8ecd:: with SMTP id y13mr6085234qvb.62.1627574882665;
        Thu, 29 Jul 2021 09:08:02 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id w14sm2025038qkm.81.2021.07.29.09.08.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 09:08:02 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id j77so9080607ybj.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:08:01 -0700 (PDT)
X-Received: by 2002:a25:b845:: with SMTP id b5mr7441639ybm.343.1627574881505;
 Thu, 29 Jul 2021 09:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <1627560036-1626-1-git-send-email-rnayak@codeaurora.org> <1627560036-1626-3-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1627560036-1626-3-git-send-email-rnayak@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Jul 2021 09:07:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wy6iyrty0tmygY42GJdWSNqby9XePjpg6pKpce-9A7fg@mail.gmail.com>
Message-ID: <CAD=FV=Wy6iyrty0tmygY42GJdWSNqby9XePjpg6pKpce-9A7fg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] nvmem: qfprom: sc7280: Handle the additional
 power-domains vote
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Ravi Kumar Bokka (Temp)" <rbokka@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 29, 2021 at 5:01 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> On sc7280, to reliably blow fuses, we need an additional vote
> on max performance state of 'MX' power-domain.
> Add support for power-domain performance state voting in the
> driver.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/nvmem/qfprom.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> index 81fbad5..b5f27df 100644
> --- a/drivers/nvmem/qfprom.c
> +++ b/drivers/nvmem/qfprom.c
> @@ -12,6 +12,8 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/nvmem-provider.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>
> @@ -139,6 +141,9 @@ static void qfprom_disable_fuse_blowing(const struct qfprom_priv *priv,
>  {
>         int ret;
>
> +       dev_pm_genpd_set_performance_state(priv->dev, 0);
> +       pm_runtime_put(priv->dev);

To me it feels as if this should be at the end of the function rather
than the beginning. I guess it doesn't matter (?), but it feels wrong
that we have writes to the register space after we're don't a
pm_runtime_put().


> @@ -420,6 +440,12 @@ static int qfprom_probe(struct platform_device *pdev)
>                         econfig.reg_write = qfprom_reg_write;
>         }
>
> +       ret = devm_add_action_or_reset(dev, qfprom_runtime_disable, dev);
> +       if (ret)
> +               return ret;
> +
> +       pm_runtime_enable(dev);
> +

Swap the order of the two. IOW first pm_runtime_enable(), then
devm_add_action_or_reset(). Specifically the "_or_reset" means that if
you fail to add the action (AKA devm_add_action() fails to allocate
the tiny amount of memory it needs) it will actually _call_ the
action. That means that in your code if the memory allocation fails
you'll call pm_runtime_disable() without the corresponding
pm_runtime_enable().


Other than those two issues this looks good to me. Feel free to add my
Reviewed-by when you fix them.

-Doug
