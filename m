Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1628130A1E0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 07:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhBAGFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 01:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhBAFzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 00:55:47 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279B5C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:55:01 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id p8so14507140ilg.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xcfxkt2vV5vJ2sVl9SMRfKcWT/mJaBdrOn2baNl2lbU=;
        b=Np24UsS622Zxz/Kxc02jkiK1zbQNj933ufob5jR1NflrLnK0miPPqnTH5v3KmuCrjf
         8xVFSqNeSXt6is+1OLFRx6zZUKB/c69HOqq+HwB1V968zOEr15a1WcrSpvgWWaaTQOmX
         HJbpgyFlWLU86r9jPBX6p3WyZ27VQ25ZIVjVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xcfxkt2vV5vJ2sVl9SMRfKcWT/mJaBdrOn2baNl2lbU=;
        b=PTimg+v/L5CFXfcDmpmmrS8iLXmb1jo2SzeEYie7tue9zfvcSHQZb9rdv+MQd/XZ0T
         uJ0DhF458FGkg6Dr82ZbOOINcYcGjF6/hEHIRyK2mmwNFOnEZsbOAOyTh5I00MxU1thr
         XK5WXsrnluqJ/O9Y7ceLIQFKQpl+ymkwOqATQz0+n88U7vZmpnmdaT3YRXK2sOzWRmeB
         xRHu916vr4VBXdcyb17PoU1Yf6ipNwuSncGU8UgtcdZY5ms34e35SFnk6m3meTh/gGFL
         mvxjELDs7p1O0fspMxBaKPuvDnvVytSlxEHcuylIVq0qQK3Rj0yjWiIZTIYh8R7TLneL
         9Zgw==
X-Gm-Message-State: AOAM530yDXUW7k53yJ/6hGvWaHGD7Sq9PzrN1pS6pmiLPNis+RsFAXq0
        Z415ix2pBbeeKl21zo+D4IFb0vmM76gFgyL4LFGaVj2S47N94g==
X-Google-Smtp-Source: ABdhPJyQcc5xV2+Kc+LtL1d25ukxRhKQ6G5J8rLlYWaJCj+IIQLKqJetSVUCQIMP5vaiD3q2SZmzGF52Dlt+oDjGO3o=
X-Received: by 2002:a05:6e02:509:: with SMTP id d9mr12085058ils.150.1612158900584;
 Sun, 31 Jan 2021 21:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20210201054542.1470695-1-Bilal.Wasim@imgtec.com> <20210201054542.1470695-3-Bilal.Wasim@imgtec.com>
In-Reply-To: <20210201054542.1470695-3-Bilal.Wasim@imgtec.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 1 Feb 2021 13:54:34 +0800
Message-ID: <CAJMQK-h-HzSSaLw5nuEYLTZkOER70nU-0GG+y9z5x6i+_VODcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: mediatek: pm-domains: Add domain_supply cap for
 mfg_async PD
To:     Bilal Wasim <bilalwasim676@gmail.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 1:45 PM Bilal Wasim <bilalwasim676@gmail.com> wrote:
>
> The mfg_async power domain in mt8173 is used to power up imgtec
> gpu. This domain requires the da9211 regulator to be enabled before
> the power domain can be enabled successfully.
>
> Signed-off-by: Bilal Wasim <Bilal.Wasim@imgtec.com>

Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

> ---
>  drivers/soc/mediatek/mt8173-pm-domains.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soc/mediatek/mt8173-pm-domains.h b/drivers/soc/mediatek/mt8173-pm-domains.h
> index 3e8ee5dabb43..065b8195e7d6 100644
> --- a/drivers/soc/mediatek/mt8173-pm-domains.h
> +++ b/drivers/soc/mediatek/mt8173-pm-domains.h
> @@ -63,6 +63,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
>                 .ctl_offs = SPM_MFG_ASYNC_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = 0,
> +               .caps = MTK_SCPD_DOMAIN_SUPPLY,
>         },
>         [MT8173_POWER_DOMAIN_MFG_2D] = {
>                 .sta_mask = PWR_STATUS_MFG_2D,
> --
> 2.25.1
>
