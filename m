Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB793FAF32
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 02:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhH3ASp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 20:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhH3ASo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 20:18:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA86C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 17:17:51 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x19so3821730pfu.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 17:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YyjNDu1HBv7DaFaJvN576gJvcx+mkQzf4by1fYHwuLw=;
        b=ipAby8fSNns1CCeCy/dslLv9tEUMUO+AVpxomMVz1L9HMJ9aTSzOIYaSkMfCX/ZBi2
         XdxefGLBvLTbyI6JVhUY8rSFrngkK7nxk7wpIukmZvSXj4dbIPa7+AtqEyXgFwWJ0/7Z
         NdPhZrKT6l+5bMBRNBZwW61i2UwMm9lkooJFqgC5kYtiRAQaA2zJ1OyQqULGkeo+d1zS
         aZZtTx9fODPOjQW5UydGNkUQi81fkVjCZzspX89szAMFIQqEVQ7SSrU8VhyFidysA7Ra
         qe84dg9jIZNT33E8zevPPmJCxS/wKjxddLlyIRkMk4Dv7OtlkgKn2xnE9vIV5+S+IAxn
         f5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YyjNDu1HBv7DaFaJvN576gJvcx+mkQzf4by1fYHwuLw=;
        b=oqxzn6AIMbf0fbglW/Pex4zd/bjndxtF8CbNHJr+27mbEPYrctwgF9CzdN2XA+ajKD
         itPiI2gJQTnQ1iB29lN/S7A8FDrxq1OH8FMrNeh52s6jZD03nHsC3gPZMV0hor3YZBeo
         OjGnsU0YgLowM2L3cEbOqI1hwrhZbYSYOB0FR6vjRAg1tD8XD4tpZaXnyGwO1hY/zMRu
         53J17b7W3OrWHGXYac66Z5/dYlbEviJAvgXYUarzj6KC8soP5SMHhoE6CsOQGG2cGJyU
         TbgsZ/fQic7UH7Sh77nwB7GtC+qUa7fKxs7XMbRBDqXAmuLqrv6nQu8OJmzNMYnofLu8
         8XtQ==
X-Gm-Message-State: AOAM533vvPntEj7H/VI8Nhs2rCHX4djp8owwHzM5W6EObma6yc6iXWPc
        SuUlge0ypZ+HFoc07y3nWZMi+BoUKPF7bFy8Wdx9Hg==
X-Google-Smtp-Source: ABdhPJxGKXm/SahkdjxmMWqpsKHAwTCfZL8bpLVRRD4CQ36xFk20PSupXzsL7+4trXTWQTe8ipSStmQse7cSWsR6RkA=
X-Received: by 2002:a63:aa43:: with SMTP id x3mr19221781pgo.208.1630282671525;
 Sun, 29 Aug 2021 17:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210829175624.5915-1-straube.linux@gmail.com>
In-Reply-To: <20210829175624.5915-1-straube.linux@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 30 Aug 2021 01:17:40 +0100
Message-ID: <CAA=Fs0maUfQ9ZybeaifcNHyzzCGPS-UPhPMFY_14v9xZ=to8JA@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: r8188eu: remove local variable Indexforchannel
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
> The local variable Indexforchannel in function
> odm_TXPowerTrackingCallback_ThermalMeter_8188E() is initilaized to 0
> and never changed. Remove the variable and replace its usage with 0.
>
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> index 356885e27edd..1b0e1e7307cd 100644
> --- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> +++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> @@ -110,7 +110,6 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
>         bool is2t = false;
>
>         u8 OFDM_min_index = 6, rf; /* OFDM BB Swing should be less than +3.0dB, which is required by Arthur */
> -       u8 Indexforchannel = 0/*GetRightChnlPlaceforIQK(pHalData->CurrentChannel)*/;
>         s8 OFDM_index_mapping[2][index_mapping_NUM_88E] = {
>                 {0, 0, 2, 3, 4, 4,              /* 2.4G, decrease power */
>                 5, 6, 7, 7, 8, 9,
> @@ -280,8 +279,8 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
>
>                                 /* Adujst OFDM Ant_A according to IQK result */
>                                 ele_D = (OFDMSwingTable[(u8)OFDM_index[0]] & 0xFFC00000) >> 22;
> -                               X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][0];
> -                               Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][1];
> +                               X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][0];
> +                               Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][1];
>
>                                 /*  Revse TX power table. */
>                                 dm_odm->BbSwingIdxOfdm          = (u8)OFDM_index[0];
> @@ -315,8 +314,8 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
>                                         ele_D = (OFDMSwingTable[(u8)OFDM_index[1]] & 0xFFC00000) >> 22;
>
>                                         /* new element A = element D x X */
> -                                       X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][4];
> -                                       Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][5];
> +                                       X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][4];
> +                                       Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][5];
>
>                                         if ((X != 0) && (*dm_odm->pBandType == ODM_BAND_2_4G)) {
>                                                 if ((X & 0x00000200) != 0)      /* consider minus */
> --
> 2.33.0
>

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
