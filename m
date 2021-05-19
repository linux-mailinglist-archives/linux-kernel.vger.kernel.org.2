Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13381389308
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346820AbhESPyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346862AbhESPyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:54:03 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E5DC061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:52:43 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cu11-20020a17090afa8bb029015d5d5d2175so3736151pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AjaxYg4bUUARP67WdGinpCbYpxiblugMhlcvL7HjH8s=;
        b=exnK+d2N5ecA63XuVyOCKzjR4/cye2CMBz3pcMSTaRcM9gs5Ic38YZqMewJJFd16MT
         p0x7DhlXbr/+0VixgDfqq+En4zwXPeji2FA+ulvWQVxzmUldfdo2e5AwOMJ/Cw2EV4oY
         x3Y/nGHpsqOaI9GDwedwIJWbklq13gbzEENJgnvabAJquqBHI4IivPX3XPntBMDd1IUb
         bYOXHrIBxfyouKSWEnaeCawybiTYK/murqLNxF+VzIyNbtFHbAJA7cVZBkDQzhKODo+K
         977ADWL9KRjFVmDH4i0jL3MaQi+mjoNfaOItgTT2V8h88glq7/WacRl3u1mclRFsneSH
         we5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjaxYg4bUUARP67WdGinpCbYpxiblugMhlcvL7HjH8s=;
        b=SsJrHstzrkpvPoD5pKSCExH00D9h5rZceLQfhxxf8spWltBsLrbVKRy+E1W0YUu4Zj
         2NJ8CxFeMYTiNgkHT8W3mOrgLyBPE+TyaOwP1j2Hdf6D3TXao2/09b57mqHda/aqvaXl
         JsTwN8DbxdVdYCt9XdBfY2TNGpVTSwEo24N5iAdBKi8VwQSthkQ6Xc6hx6ZmVNufbxSn
         +rZSq0IG7RBvoxaWxK9b9SxSVaaCJpfwT0cK2F52bdS3JCU8Iu3wgNf0u/DcNpwn2Zoe
         D69Uj0dDeJtIkSOh40F5ktdyDYxAnkxN64hDVep2lzGDeBHkyVij/wft/HZTs13zIR17
         WqlA==
X-Gm-Message-State: AOAM531CzZUcEayzQ1BeLQC6I8sVC2tlZjb+ugckX4mm+ZYXlR68Ffu1
        /FUX5CIK5FWbTQQ1NyJWk3xz4VkEDAuQfs+PTpHT+Q==
X-Google-Smtp-Source: ABdhPJznYOweZXIKYDgZ3nLOZlhjx+oq97Yjw8fXxaWJMMRlfhU/ljaNm1YJbtniMdzPJeCNQ4PYsRKhN4xoAo/Jfkk=
X-Received: by 2002:a17:90a:b38d:: with SMTP id e13mr11507026pjr.222.1621439562957;
 Wed, 19 May 2021 08:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210511180728.23781-1-jonathan@marek.ca> <20210511180728.23781-3-jonathan@marek.ca>
In-Reply-To: <20210511180728.23781-3-jonathan@marek.ca>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 19 May 2021 17:52:31 +0200
Message-ID: <CAG3jFyvx3szAdUFJWyQCe6DndQX6YEY3M=xWM585ujSv1ro6VQ@mail.gmail.com>
Subject: Re: [PATCH 02/17] media: camss: csiphy-3ph: disable interrupts
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:QUALCOMM CAMERA SUBSYSTEM DRIVER" 
        <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 at 20:08, Jonathan Marek <jonathan@marek.ca> wrote:
>
> The driver does nothing with the interrupts, so set the irq mask registers
> to zero to avoid wasting CPU time for thing.
>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  .../qcom/camss/camss-csiphy-3ph-1-0.c         | 35 ++-----------------
>  1 file changed, 3 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> index 5948abdcd220..783b65295d20 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> @@ -352,38 +352,9 @@ static void csiphy_lanes_enable(struct csiphy_device *csiphy,
>         else if (csiphy->camss->version == CAMSS_845)
>                 csiphy_gen2_config_lanes(csiphy, settle_cnt);
>
> -       val = 0xff;
> -       writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(11));
> -
> -       val = 0xff;
> -       writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(12));
> -
> -       val = 0xfb;
> -       writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(13));
> -
> -       val = 0xff;
> -       writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(14));
> -
> -       val = 0x7f;
> -       writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(15));
> -
> -       val = 0xff;
> -       writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(16));
> -
> -       val = 0xff;
> -       writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(17));
> -
> -       val = 0xef;
> -       writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(18));
> -
> -       val = 0xff;
> -       writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(19));
> -
> -       val = 0xff;
> -       writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(20));
> -
> -       val = 0xff;
> -       writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(21));
> +       /* IRQ_MASK registers - disable all interrupts */
> +       for (i = 11; i < 22; i++)
> +               writel_relaxed(0, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(i));
>  }
>
>  static void csiphy_lanes_disable(struct csiphy_device *csiphy,

Reviewed-by: Robert Foss <robert.foss@linaro.org>
