Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF13403111
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 00:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346229AbhIGWbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 18:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344382AbhIGWbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 18:31:13 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BE1C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 15:30:05 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q68so356532pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mP/IIf+MJPppx6rdwrLf1UIeleriTJ/3EK8yRMv6DsY=;
        b=OKiv359hU6qwhV0SwGATvX1niwWqBdt0iGVarRgaeolD4hzPmJDltZkhIaBcjrxj1g
         8yqQPMtR9hTicQqC8UdXe3yUS0N3dSxGGrPc9IrbaA8rPIH2uFWArfsiBL9gxZ02lRzt
         O663f/s9A0fsw5delQpKcLC6q9liiTEMIJmqOnSV4JrDPkBPxQQHSCSRa7lf0B3HHtvO
         S2DsnYxaJMzK2N+LCiesfvt4mPCPfFTZnVl2wK3EVkfJcPHs3Nk4T0Ny9h0NU6woqGE2
         pMUBvw488luPIt/5A6pXMXJSoXQMjUu3cDYu7Ve4Rziy5iIwyrF7OU90trUnnzjOpEPq
         V48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mP/IIf+MJPppx6rdwrLf1UIeleriTJ/3EK8yRMv6DsY=;
        b=ZljiGyQ6RWVueu54zJo5y+KupzaM0wwg2JCo9sSJGuysXQs8nzsGxWJ5GHerJ81gtk
         Kd88J6XsPCWFNSPmdSjEn9LZk5YiVtDN8n5ibSdSf9XCc8TokF8jjZ8tHBzaSIA01LVQ
         aFYfyaaw2WJt2YQyU+Yer5VimbejPwKh7ES9L7sCt0KXw6PL/JLprCd5adq8NsuGyFav
         IQzM39sLKacURdPK/JE9zJtLpGhrzSMFySMOR9uth9foWiaa0GtPxEs3S3S5aVlAU08P
         M1kLe4qM0QT+0FP40/4YsQT7GBxNt7E59uOSZp5VXKJd3mI+pN7fGNHl7nzfAH/geHb+
         Le/g==
X-Gm-Message-State: AOAM532FDX2BxO4BWM3EdnQZHENiClhGc++1QiVG7voYNPSz/FhoJwJc
        PgZCZhFzBfHqnS8fPJgrxD07Yp+wKoLvwf3/YI1gqA==
X-Google-Smtp-Source: ABdhPJzgkyotWqm/GhDUt9M4xwX5X+VVZD0hVUEAJ1Bsel6IlV6f5bjhhHaFaC6IFBLXBU7Canbhv3p1uWvFRkEaI7g=
X-Received: by 2002:a63:dd46:: with SMTP id g6mr528777pgj.347.1631053804832;
 Tue, 07 Sep 2021 15:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210907210924.22287-1-straube.linux@gmail.com>
In-Reply-To: <20210907210924.22287-1-straube.linux@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Tue, 7 Sep 2021 23:29:53 +0100
Message-ID: <CAA=Fs0mg7ZjgK-NeeGehEVKczyfH2ZsruWe_nneroBJw6kz=zw@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove unused function Hal_ProSetCrystalCap()
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sept 2021 at 22:09, Michael Straube <straube.linux@gmail.com> wrote:
>
> Remove unused function Hal_ProSetCrystalCap().
>
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_mp.c    | 9 ---------
>  drivers/staging/r8188eu/include/rtw_mp.h | 1 -
>  2 files changed, 10 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
> index dabdd0406f30..82268f754da0 100644
> --- a/drivers/staging/r8188eu/core/rtw_mp.c
> +++ b/drivers/staging/r8188eu/core/rtw_mp.c
> @@ -924,12 +924,3 @@ void _rtw_mp_xmit_priv(struct xmit_priv *pxmitpriv)
>  exit:
>         ;
>  }
> -
> -void Hal_ProSetCrystalCap(struct adapter *pAdapter, u32 CrystalCapVal)
> -{
> -       CrystalCapVal = CrystalCapVal & 0x3F;
> -
> -       // write 0x24[16:11] = 0x24[22:17] = CrystalCap
> -       PHY_SetBBReg(pAdapter, REG_AFE_XTAL_CTRL, 0x7FF800,
> -                    (CrystalCapVal | (CrystalCapVal << 6)));
> -}
> diff --git a/drivers/staging/r8188eu/include/rtw_mp.h b/drivers/staging/r8188eu/include/rtw_mp.h
> index b2befe09d944..73fb6974d076 100644
> --- a/drivers/staging/r8188eu/include/rtw_mp.h
> +++ b/drivers/staging/r8188eu/include/rtw_mp.h
> @@ -466,7 +466,6 @@ void Hal_TriggerRFThermalMeter(struct adapter *pAdapter);
>  u8 Hal_ReadRFThermalMeter(struct adapter *pAdapter);
>  void Hal_SetCCKContinuousTx(struct adapter *pAdapter, u8 bStart);
>  void Hal_SetOFDMContinuousTx(struct adapter *pAdapter, u8 bStart);
> -void Hal_ProSetCrystalCap (struct adapter *pAdapter , u32 CrystalCapVal);
>  void _rtw_mp_xmit_priv(struct xmit_priv *pxmitpriv);
>  void MP_PHY_SetRFPathSwitch(struct adapter *pAdapter ,bool bMain);
>
> --
> 2.33.0
>

Looks good Michael, many thanks.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
