Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E273EC40A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 19:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbhHNRQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 13:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbhHNRQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 13:16:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E1EC061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:15:50 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n12so15277798plf.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DDDi2ITyznJdEvYgoFlgdqKOsOTi4UGXz+quqcdg0tw=;
        b=PqX39jo+Ze3T0CQ3dTZICSBpo0FBjV604nKhrbpkSZ+jBfbu9fOZ98qXVOyancXZeg
         L2xAWeA9IMb3Yp4AqjXhKou2FEVmIX4JMEBhcbBHvmOj8MDsF3PxG72wlhPBrQopWA1N
         2um+1NuPOW6cm8+caR2uvpYK9o5vfKNxtejLsPMvZ0T9rSb2fC35rpDF+t0/xxreF5Hl
         W4OnA3PNzjnGgWe5NnyRngMkjIDTaWiQgTW3ernDSTFnQCF4GHtVY8w/LsunPmI/BYS7
         qOEIR9oDfG3IsjZzX6zXmRP5dolYsqc4IJ9dFdvWRadWzyuufyzcsHWGBUal83Kpvbi0
         QNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DDDi2ITyznJdEvYgoFlgdqKOsOTi4UGXz+quqcdg0tw=;
        b=aSHzzrFM8QeMgJhgfdFOadVj+45iy3zyort8EdfX0B/Kvm1HQ4rcsJhGAAIe0CaxcK
         L075SzWFokyjwj/YH77HLHxOBp3dmCE3Sm6sjRhFlIHAVCAcvhhCz8F92bz3Cv/aDJBe
         YAO6ozSo6KathWS/sVPKekQVm2o8phwWrr0xah9NbPXAzeLOSIBOyDH7hUAZM8gJIjGC
         5zhdBvFVKu9c9k0fOptRYBSUseVM91K0FY3qXm2YysLQbdcMGIsxy30cOGuSXQu4kggu
         yVOE/fWFaMMOeFni1OuBh2Z6e7GDRMqQ6gj3zyK5AMq+OMvulVbPSTaHRCZgH6GNU2gX
         A7RA==
X-Gm-Message-State: AOAM530vLuLvLPhZ6czKuL4Xc64bE6aeG4x79SsvqW3Z9BWHnZVkU7eE
        zBqMbzCIJzfeV1eo7QFUYAe5bfipOnI/GnKarSJkNw==
X-Google-Smtp-Source: ABdhPJxBiHJ+QcorDH5wOzManRua9hxJKXtjxeHWpyDLpTerb964YjW8uz54MQJhgWj4y3mzFWFJTM3GaFati4ckNi8=
X-Received: by 2002:a17:902:f704:b029:11a:cdee:490 with SMTP id
 h4-20020a170902f704b029011acdee0490mr6421510plo.37.1628961349449; Sat, 14 Aug
 2021 10:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210813160812.17603-1-fmdefrancesco@gmail.com>
In-Reply-To: <20210813160812.17603-1-fmdefrancesco@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 14 Aug 2021 18:15:38 +0100
Message-ID: <CAA=Fs0m8nh318ox0s2sg+fMtaqqdn7anev5a9pLbM0yUvkXajA@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: Remove variables and simplify PHY_SwChnl8188E()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2021 at 17:08, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> Remove "bResult" and "tmpchannel" and all tests and assignments that
> are related to them in the code of PHY_SwChnl8188E().
>
> "bResult" was always true, therefore its test led to a null statement.
> "tmpchannel" was used only to restore "pHalData->CurrentChannel" to its
> previous value only if _PHY_SwChnl8192C() was not called; therefore
> assign "channel" to "pHalData->CurrentChannel" if and only if
> _PHY_SwChnl8192C() is to be executed (and get rid of that temporary
> storage).
>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
> index 02955b8c4005..9af91ec92d36 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
> @@ -1091,8 +1091,6 @@ void PHY_SwChnl8188E(struct adapter *Adapter, u8 channel)
>  {
>         /*  Call after initialization */
>         struct hal_data_8188e   *pHalData = GET_HAL_DATA(Adapter);
> -       u8 tmpchannel = pHalData->CurrentChannel;
> -       bool  bResult = true;
>
>         if (pHalData->rf_chip == RF_PSEUDO_11N)
>                 return;         /* return immediately if it is peudo-phy */
> @@ -1100,17 +1098,8 @@ void PHY_SwChnl8188E(struct adapter *Adapter, u8 channel)
>         if (channel == 0)
>                 channel = 1;
>
> -       pHalData->CurrentChannel = channel;
> -
>         if ((!Adapter->bDriverStopped) && (!Adapter->bSurpriseRemoved)) {
> +               pHalData->CurrentChannel = channel;
>                 _PHY_SwChnl8192C(Adapter, channel);
> -
> -               if (bResult)
> -                       ;
> -               else
> -                       pHalData->CurrentChannel = tmpchannel;
> -
> -       } else {
> -               pHalData->CurrentChannel = tmpchannel;
>         }
>  }
> --
> 2.32.0
>

Dear Fabio,

Good stuff, thanks.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
