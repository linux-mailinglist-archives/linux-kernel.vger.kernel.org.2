Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83C23EC405
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 19:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbhHNRNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 13:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbhHNRNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 13:13:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F60C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:12:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so20711827pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VdKAaRZxxkRIA05Ty5L/4FVj6WOO13hTinZZVlmEIJg=;
        b=bAHQ5GxNALnf4e9cspmUmSmWB/Hdup2my6zXcaC1erzYmR8Upwx9wulaWbokksUgGZ
         VhUjD8cIK+TusJM6QHrTeGy1SnodJ6Dw0WOK2e7m8dExceCfP4NW5TM8QQzv/foBxfgA
         9Wu1w3HMfDg2OFs77gX7RibsR/AfbYRUMakwgRkGfVgZtjpYOlcSBLUnYXecWBjt8xxq
         VSmnsPgIzQWar7RBC9/kMQblso6ur+4pxQUh/zF3nPdv7a41UUjlv7CQX1EpyrqrqvNu
         mruFu84fj7VRqrmpF+ZpABNYfk6smddokwm2r3HK7Y3i7Lqiwh4jFsa41voloxSxbPzS
         0OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VdKAaRZxxkRIA05Ty5L/4FVj6WOO13hTinZZVlmEIJg=;
        b=mLSHZjvqgnho5FwLvHvABxV0qThAljU4nm9Os7ay+jjmM5oD0d6ZrBYAYGCGI+uKXv
         +N0zJ4zApEPdMNY+ezaI+Dzgh7PP3pRYif7TESqyKn5C9wN+WihByImYb1oxHvgfsfzk
         KHBrplAMcIatHd8RPhvqLjKWack1SKIHX7ZGp/7T9PpNC18JsmqmHuYRGgg9fBhd9/sG
         C2CryCeNMz0uuIMAamX+jFdt/5zXcgLf+76VtY87fkrp//AhXDK50J2MeKYqMKExyhKs
         S6mbxUSJQdnQfsXxG9JZeQYWlWq1QLECZ2mpgl6FwIcQC3vioWBLiYO9gFpEzec9DK6Q
         cAyw==
X-Gm-Message-State: AOAM532UYxafNxw0prey0T0OhdjZNscQ44XVn7KJ5/GGj60cfdgfvo5L
        RLse8v11airg1pu5+v0k3jr2jQbKKw75csIvAP/Ncg==
X-Google-Smtp-Source: ABdhPJwiUn0eaPjggEnzqFd/YWJIKYsTjnohWqXXBAxhQYnNK3iitjJTPB8+yMhCN82XxHxES0cExP60bSmbLZtoQms=
X-Received: by 2002:a17:902:ac87:b029:12d:3e59:cb7d with SMTP id
 h7-20020a170902ac87b029012d3e59cb7dmr6468862plr.22.1628961158535; Sat, 14 Aug
 2021 10:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210813073109.25609-1-straube.linux@gmail.com> <20210813073109.25609-3-straube.linux@gmail.com>
In-Reply-To: <20210813073109.25609-3-straube.linux@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 14 Aug 2021 18:12:27 +0100
Message-ID: <CAA=Fs0mfUYvDo6jEHVbOz7MkFDpKd_M+xwyELd0jdw-8TP3i6g@mail.gmail.com>
Subject: Re: [PATCH 2/4] staging: r8188eu: convert return type of
 Hal_GetChnlGroup88E() to void
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2021 at 08:32, Michael Straube <straube.linux@gmail.com> wrote:
>
> After the removal of 5GHz code from Hal_GetChnlGroup88E() the function
> always returns true now. Convert the return type to void and change the
> only user Hal_ReadTxPowerInfo88E() accordingly.
>
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 30 ++++++++-----------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> index 634a0a022727..d3345fa0eb60 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> @@ -2060,7 +2060,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
>         }
>  }
>
> -static u8 Hal_GetChnlGroup88E(u8 chnl, u8 *pGroup)
> +static void Hal_GetChnlGroup88E(u8 chnl, u8 *pGroup)
>  {
>         if (chnl < 3)                   /*  Channel 1-2 */
>                 *pGroup = 0;
> @@ -2074,8 +2074,6 @@ static u8 Hal_GetChnlGroup88E(u8 chnl, u8 *pGroup)
>                 *pGroup = 4;
>         else if (chnl == 14)            /*  Channel 14 */
>                 *pGroup = 5;
> -
> -       return true;
>  }
>
>  void Hal_ReadPowerSavingMode88E(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
> @@ -2107,7 +2105,7 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
>         struct hal_data_8188e   *pHalData = GET_HAL_DATA(padapter);
>         struct txpowerinfo24g pwrInfo24G;
>         u8 rfPath, ch, group;
> -       u8 bIn24G, TxCount;
> +       u8 TxCount;
>
>         Hal_ReadPowerValueFromPROM_8188E(&pwrInfo24G, PROMContent, AutoLoadFail);
>
> @@ -2116,19 +2114,17 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
>
>         for (rfPath = 0; rfPath < pHalData->NumTotalRFPath; rfPath++) {
>                 for (ch = 0; ch < CHANNEL_MAX_NUMBER; ch++) {
> -                       bIn24G = Hal_GetChnlGroup88E(ch, &group);
> -                       if (bIn24G) {
> -                               pHalData->Index24G_CCK_Base[rfPath][ch] = pwrInfo24G.IndexCCK_Base[rfPath][group];
> -                               if (ch == 14)
> -                                       pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][4];
> -                               else
> -                                       pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][group];
> -                       }
> -                       if (bIn24G) {
> -                               DBG_88E("======= Path %d, Channel %d =======\n", rfPath, ch);
> -                               DBG_88E("Index24G_CCK_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_CCK_Base[rfPath][ch]);
> -                               DBG_88E("Index24G_BW40_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_BW40_Base[rfPath][ch]);
> -                       }
> +                       Hal_GetChnlGroup88E(ch, &group);
> +
> +                       pHalData->Index24G_CCK_Base[rfPath][ch] = pwrInfo24G.IndexCCK_Base[rfPath][group];
> +                       if (ch == 14)
> +                               pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][4];
> +                       else
> +                               pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][group];
> +
> +                       DBG_88E("======= Path %d, Channel %d =======\n", rfPath, ch);
> +                       DBG_88E("Index24G_CCK_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_CCK_Base[rfPath][ch]);
> +                       DBG_88E("Index24G_BW40_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_BW40_Base[rfPath][ch]);
>                 }
>                 for (TxCount = 0; TxCount < MAX_TX_COUNT; TxCount++) {
>                         pHalData->CCK_24G_Diff[rfPath][TxCount] = pwrInfo24G.CCK_Diff[rfPath][TxCount];
> --
> 2.32.0
>

Dear Michael,

Looks good to me, thanks.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
