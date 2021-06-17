Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3403ABEDD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 00:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhFQW0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 18:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbhFQW0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 18:26:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01432C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 15:24:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id nb6so12428348ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 15:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T50KbAThdeevR6uB4Id+cbtEC5Z15njRViPF/2u5PCs=;
        b=Qkg/tIGdoJHarCmVrz02bhylDw6IuiZyhNKw+H0gSWcHJRB/YG0gHleAptmrer6rSV
         /hv9Y94OKoq4xycsRpuyRMdw4rpHsEGT/RRgrL7Oyksd+V4hkhKtEVND6fjMxhoP/b+e
         3Gl18bAkR13OPvp3GQ8tO/Fsm2pEKt7ykqz15UL5YyE3UNQH3U9kcJ4o3ai4b6h0zlZ8
         PyJbwvWNWn2g4X5AaHJ4MBE/Cnx3U2Ss3uCGOqiCX6peFidW/kx84GagopBeZFwCXMGm
         ceX1RdcIM4zIhsW1fGEJt1pSvfK4+CJsG3yy8TsVBO1JRvOAlp5llXGFmPXkDPEmvROv
         jTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T50KbAThdeevR6uB4Id+cbtEC5Z15njRViPF/2u5PCs=;
        b=Lq5+Ax+gaPzVqk2myb/oDzMKLms0hkYLKWQVXRMagS+T0YY0bsye3JFzZj6cmgY681
         LWNStrOB3xKEt7PDMNLjFeiShdLTvw9K4yPL7SnNHeNQj97HJH8uqB2Jibf6Fio7nL2V
         PbqUpzoPJwdMkPsUGs3knhQ3EhSvDmFxBrxsZkTdD5baQN/OSj7sAR1thzz11AjWRFjZ
         ATsrfUiEbbQRpWE8nlWwscKpjsPP/9Qk+cUEqiWM3Rvdo496W9iKppx5Gp+C+o18Q8Oa
         J8FXmcjSIXSPzXXLDJ0+rGTV61gAdYF10tARHsM5SCxQj9zoc0i4gCGzd4DMAx3XlXRa
         Ozow==
X-Gm-Message-State: AOAM531LZhEzYk/R7lWyFEu8XcOoAbt+0QiZatYf39P/mOTB/pdVB19S
        FW3ImlqOhOj2CUhdwYWynN4epmE5TdpsBH2yoDg=
X-Google-Smtp-Source: ABdhPJwrZod3kcnlN/pabK+bk5akynewCBmBuwQ8at429BZSEKzc0v/foDCSUvXSgXNf79VWmHNi7NTa+NIqa0VBSKQ=
X-Received: by 2002:a17:906:2c52:: with SMTP id f18mr7610434ejh.258.1623968675568;
 Thu, 17 Jun 2021 15:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-7-linux.amoon@gmail.com>
In-Reply-To: <20210617194154.2397-7-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Jun 2021 00:24:24 +0200
Message-ID: <CAFBinCCE+6G7QtDoxfbcZVVRf-MDX-epSo=_k_PJZgWX+_Whvg@mail.gmail.com>
Subject: Re: [RFCv1 6/8] phy: amlogic: meson8b-usb2: Use phy reset callback function
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Thu, Jun 17, 2021 at 9:44 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> +static int phy_meson8b_usb2_reset(struct phy *phy)
> +{
> +       struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
> +       int ret;
> +
> +       if (priv->is_enabled) {
> +               ret = reset_control_reset(priv->reset);
> +               if (ret) {
> +                       dev_err(&phy->dev, "Failed to trigger USB reset\n");
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
will this reset change the register values back to some kind of default?
If it does then we're not re-applying our desired register values
afterwards - which is probably asking for trouble.

For shared resets (like the one we have here) reset_control_reset will
only trigger the reset line once until all drivers using that reset
line are unloaded.
So effectively this new phy_ops.reset callback will be a no-op.

[...]
> -       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> +       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, "phy");
I think this breaks compatibility with existing .dtbs and our
dt-bindings (as we're not documenting a "reset-names" property).
What is the goal of this one?


Best regards,
Martin
