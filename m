Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD1E3B5659
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 02:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhF1Aik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 20:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhF1Aij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 20:38:39 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32115C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 17:36:14 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id k21so1951217ljh.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 17:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gaVCDaYqtt9b3KVihy9mfeTRmIqBNx++UINpmJ3IlGo=;
        b=ewfww11LZVv3L1/XDYvF41JFKOeUxXAJrE0cxkokTyX5A/WOVyjJvC/gPRep56Ec6Z
         kcdbwGmb2AfXCuco2oNp2Ae9BtQTGaNzFDbQfMz4dnh/KYf1TWTa+5UTJqkX7O5MLGu2
         DsNLTZ1Dxu4oKIlYZL4zHrb0bOXc4mw9dIgP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gaVCDaYqtt9b3KVihy9mfeTRmIqBNx++UINpmJ3IlGo=;
        b=euzHVY9Dljexdtq41MrYpG982oEpPkh2OaQMxvoX3NAuWIY0cosXrVAjv4KZhO+qNz
         zgvCP1XaJmjVICCVJ9gK2E1vk0VFyagvtYtSXbE2WqQZB4PWAYaYuuVV6CSY/hWaFOQc
         HMIcBKceq3Zayzk0hXBdU53ka71pqnFmjWTzo5MYG3QEv6I0I7U8LIQgdPAB3wcNUnbO
         R6cneGycGwjQKoZh88QUv5je+vaaEp9gIU/7VZy+qPE8Xb+thnFNJcje021iSUfWkkN5
         uczAZD5USoxi0lsspbHsdUx3fCrJx3mWE7OMZL9X963OU//lMS0k6VCw/G0S16ChgyWt
         JiNQ==
X-Gm-Message-State: AOAM533oHmzgbCrQ3JT1F3fIVY6kQXwZJgUXxwB4L1eKlv0dQ1OWmgQs
        70fbqR87M2Zdew+PjaUFNfEz56dK6thkqFQhMOw=
X-Google-Smtp-Source: ABdhPJzR9Ee3tj6hJNTI2reNle7GbT6/2QMAl1jghyS9MPj7NuY39qdGObqmPSBpI7kNJgmMKLwFDg==
X-Received: by 2002:a2e:9088:: with SMTP id l8mr17375510ljg.144.1624840572142;
        Sun, 27 Jun 2021 17:36:12 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id j24sm1381803ljg.46.2021.06.27.17.36.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jun 2021 17:36:11 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id h15so28900689lfv.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 17:36:11 -0700 (PDT)
X-Received: by 2002:a05:6512:331a:: with SMTP id k26mr14837143lfe.152.1624840571313;
 Sun, 27 Jun 2021 17:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210625062448.3462177-1-enric.balletbo@collabora.com>
In-Reply-To: <20210625062448.3462177-1-enric.balletbo@collabora.com>
From:   Eizan Miyamoto <eizan@chromium.org>
Date:   Mon, 28 Jun 2021 10:35:54 +1000
X-Gmail-Original-Message-ID: <CAOak1e8uJum7Wf6Z6CO_w5+aKvbm5JvwRYuT+Rzp2LwTOh_vQw@mail.gmail.com>
Message-ID: <CAOak1e8uJum7Wf6Z6CO_w5+aKvbm5JvwRYuT+Rzp2LwTOh_vQw@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: mmsys: Fix missing UFOE component in
 mt8173 table routing
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        CK Hu <ck.hu@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Enric,

Thanks so much for your hard work bisecting and crafting this patch.

I have verified that it fixes the DRM issues we were seeing on MT8173
with Linux 5.12.

Tested: Eizan Miyamoto <eizan@chromium.org>
On Fri, Jun 25, 2021 at 4:24 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> The UFOE (data compression engine) component needs to be enabled to have
> the imgtec gpu driver working. If we don't enable it we see a black screen.
> Looks like when we switched to use and array for setting the routing
> registers in commit 440147639ac7 ("soc: mediatek: mmsys: Use an array for
> setting the routing registers") we missed to add this component in the new
> routing table, it was present before taht commit, so fix it by adding
> this component in the mt8173 routing table.
>
> Fixes: 440147639ac7 ("soc: mediatek: mmsys: Use an array for setting the routing registers")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/soc/mediatek/mtk-mmsys.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
> index a760a34e6eca..11388961dded 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.h
> +++ b/drivers/soc/mediatek/mtk-mmsys.h
> @@ -209,6 +209,9 @@ static const struct mtk_mmsys_routes mmsys_default_routing_table[] = {
>         }, {
>                 DDP_COMPONENT_RDMA2, DDP_COMPONENT_DSI3,
>                 DISP_REG_CONFIG_DSIO_SEL_IN, DSI3_SEL_IN_RDMA2
> +       }, {
> +               DDP_COMPONENT_UFOE, DDP_COMPONENT_DSI0,
> +               DISP_REG_CONFIG_DISP_UFOE_MOUT_EN, UFOE_MOUT_EN_DSI0,
>         }
>  };
>
> --
> 2.30.2
>
