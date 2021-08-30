Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052543FAF35
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 02:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbhH3AUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 20:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbhH3AUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 20:20:09 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198E8C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 17:19:17 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id x4so11831776pgh.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 17:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9S9BLaYhunvr1offz/aihEqmXq38RBO+7WozhgbjyZ4=;
        b=KyTl8xbYdBAi+7PMNoGtb1o2K+zkndlyEOKp6QHhm3AufWhsBFRIoS1O9kL1kFTsL3
         ukhfn5qS8Bv1X3hHRBLoOdwQCqi48GLeP7ENpfpxpe7KQidHebMN6k5xul5yYysgionR
         b9IBeybMuqs7osUjwZSSrBt5Wsxg5sqJ6Lu5ZzSlgI0tuU2ru0GAiu9/DPnRx0tpD2Rp
         TddoL96HJgTYKmXyJ/1fPW4OslFONtjLnXcfQ3NYP5uAEJKyF/CUKAVyi9nE3nKx4eqg
         u2BG0ioU34NDEt8WNbJr7SnSv9Lqmx5byZ9T66kwkQSs3mGez9t8y89lmckbYT8s5r/+
         QxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9S9BLaYhunvr1offz/aihEqmXq38RBO+7WozhgbjyZ4=;
        b=iQp5w+A6YmQDkFPCI6CqzR1LTtIahoNUfS8WM3p8WITVHGNF5+aRhCT50Ka9B9wTzh
         wN02Cw+i4PwKT/aUT3YKN79/q4ANYK/Gp50xExlNRiW/oZlfC2dj9HfNNPPuDBbCr56Z
         lnhBMKC0UWC74WYfg073xnSgCtoVEXEZLCKnZegoOk7FaETm7v/KsKQj2CKtsvJNyfqJ
         DJA/quimZGbPflYpR5QhKG7TfTFcv7L1f6o27wF48HOdGIbw7kWTINt4Rg8YsB2iOTiN
         +3sJQI0UzVyeiYO/fPaElzBbNSr1rArRW2Z7K2lmC5w1dpQaa8n39x1rXZ9MaFesH9wz
         vj7w==
X-Gm-Message-State: AOAM5332i1rU4WX6DfflxBnF2Sm6xYKRBhyS/RjAxkkxBzWuF4ybsFEO
        HuAg6nRxDqPj8bEVWoM83A23Cb/jR3EmOBftvfDuvg==
X-Google-Smtp-Source: ABdhPJwmJBYEly8fnYU5atmgqpCqesDaOZgjN5cYwzmraTFUWH2gFBq93Y8XXK9XT0wLXQLCKF5QzMToaU4N9dRP88o=
X-Received: by 2002:a65:6a0a:: with SMTP id m10mr19479349pgu.82.1630282756512;
 Sun, 29 Aug 2021 17:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210829175624.5915-1-straube.linux@gmail.com> <20210829175624.5915-2-straube.linux@gmail.com>
In-Reply-To: <20210829175624.5915-2-straube.linux@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 30 Aug 2021 01:19:05 +0100
Message-ID: <CAA=Fs0nkWsKYDCEn_vw1yxTFj6x3ZxngwkD3KTA4+J_atiJVSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: r8188eu: refactor field of struct odm_rf_cal
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

On Sun, 29 Aug 2021 at 18:56, Michael Straube <straube.linux@gmail.com> wrote:
>
> Refactor the field IQKMatrixRegSetting of struct odm_rf_cal to be not
> an array. The driver is for chips that operate in the 2.4 GHz band only.
> So only the first element of the array is used and there is no need for
> an array.
>
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 12 ++++++------
>  drivers/staging/r8188eu/include/odm.h        |  3 +--
>  2 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> index 1b0e1e7307cd..6e0abaf58791 100644
> --- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> +++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> @@ -279,8 +279,8 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
>
>                                 /* Adujst OFDM Ant_A according to IQK result */
>                                 ele_D = (OFDMSwingTable[(u8)OFDM_index[0]] & 0xFFC00000) >> 22;
> -                               X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][0];
> -                               Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][1];
> +                               X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][0];
> +                               Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][1];
>
>                                 /*  Revse TX power table. */
>                                 dm_odm->BbSwingIdxOfdm          = (u8)OFDM_index[0];
> @@ -314,8 +314,8 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
>                                         ele_D = (OFDMSwingTable[(u8)OFDM_index[1]] & 0xFFC00000) >> 22;
>
>                                         /* new element A = element D x X */
> -                                       X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][4];
> -                                       Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][5];
> +                                       X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][4];
> +                                       Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][5];
>
>                                         if ((X != 0) && (*dm_odm->pBandType == ODM_BAND_2_4G)) {
>                                                 if ((X & 0x00000200) != 0)      /* consider minus */
> @@ -1182,8 +1182,8 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
>  /* by sherry 20120321 */
>         if (final_candidate < 4) {
>                 for (i = 0; i < IQK_Matrix_REG_NUM; i++)
> -                       dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][i] = result[final_candidate][i];
> -               dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].bIQKDone = true;
> +                       dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][i] = result[final_candidate][i];
> +               dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.bIQKDone = true;
>         }
>
>         _PHY_SaveADDARegisters(adapt, IQK_BB_REG_92C, dm_odm->RFCalibrateInfo.IQK_BB_backup_recover, 9);
> diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
> index d9041ee576bb..7c8f082930dd 100644
> --- a/drivers/staging/r8188eu/include/odm.h
> +++ b/drivers/staging/r8188eu/include/odm.h
> @@ -260,7 +260,6 @@ struct odm_rate_adapt {
>
>  #define AVG_THERMAL_NUM                8
>  #define IQK_Matrix_REG_NUM     8
> -#define IQK_Matrix_Settings_NUM        1+24+21
>
>  #define        DM_Type_ByFWi           0
>  #define        DM_Type_ByDriver        1
> @@ -664,7 +663,7 @@ struct odm_rf_cal {
>
>         u8      ThermalValue_HP[HP_THERMAL_NUM];
>         u8      ThermalValue_HP_index;
> -       struct ijk_matrix_regs_set IQKMatrixRegSetting[IQK_Matrix_Settings_NUM];
> +       struct ijk_matrix_regs_set IQKMatrixRegSetting;
>
>         u8      Delta_IQK;
>         u8      Delta_LCK;
> --
> 2.33.0
>

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
