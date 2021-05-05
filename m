Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45DA37385F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 12:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhEEKLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 06:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhEEKLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 06:11:21 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1431C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 03:10:23 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id v188so808964vsb.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 03:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v7hWLfiP4L8kd/8OkP5+NXOkybUNAwrKCRGGcgcoAgY=;
        b=vn0pSNH+j1spd4Zd9WBHRblPehcqOgqRSDTd6kMUOpLQNoYKf19jGW34SPWIPuYuwd
         Ja/LVFH2ljf2NCEq1Z0t/0yOUv61cbqLuVDlU7msNwlk9IVT09saoM+tAHj1tTRx/Vq+
         iUdGFAjHIQbIY8b3IGr18nWOzPK4Y2KFnHg+R2iXUgjBn59lz9q3jTXziCGQhM6ecVJK
         seIwhANuZLFxLlYsRn7WbieqrgIzZZ2Bve6qGvobN8frdhfEqQbNaoJcVQ1eds/vfSOj
         mvbl0QmQlhb1D2kWmrWbBUqiL43c5aNFH9jK5xuxWWk9SWGjFwkFql0P5+7vM96angpn
         KF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v7hWLfiP4L8kd/8OkP5+NXOkybUNAwrKCRGGcgcoAgY=;
        b=k88fiZ/aMebAkUuiyjlfVjBD+J21UIVpGfEgfOHAq9nB2TyeW5bD9fXM4IY00s1c48
         WD4L06xeKZ6dUtadz+s02U63d5jDvxBi8AmL5ToS+oVSC0KmslmUBa9ka611pUTZzUWc
         0XTjcjAmP85GyAqFCmnq2wjG9mMoV8JWEK8FwSLZ6dHvMwULgVW97YeFUmuQc2hSuvlC
         hiGamvJ8PhgLHOlqUMU7LamIRjR57qxvWFQjwRR3D7vuOz+N8mWtcvN2+vtkOVHTFkAZ
         KRJD15plvRVfCq8zE4uM/mzfNnSyg7YrcxVoTxyd5X842ERKinxku7PM+6LETmSyNJE3
         R+pw==
X-Gm-Message-State: AOAM532Fa2nYr4A0gb4pEvGyw36pdpLIP6wXuB7WCD/M0AL5tqc0x8sf
        cmuk58JaoslUb5AZ5u4GfG0axogr4u6/LJx58Nd/Cg==
X-Google-Smtp-Source: ABdhPJyLNbY7Hr5i/okzHjDMncajNnfX3gDt1hipCJXizf2/YZCQOO0omBnqbNTE17OPjgeF1pcT2RClqXksMGdAAks=
X-Received: by 2002:a67:2c03:: with SMTP id s3mr15767861vss.42.1620209423138;
 Wed, 05 May 2021 03:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 May 2021 12:09:47 +0200
Message-ID: <CAPDyKFqvTgRZ0QEgBXJgbhbEmQvxBqzZuGh2MrZGS1mRyYz9mg@mail.gmail.com>
Subject: Re: [PATCH] mmc: enable UHS voltage switch for SDSC if supported
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "huyue2@yulong.com" <huyue2@yulong.com>,
        "tiantao6@hisilicon.com" <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2021 at 15:18, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> Ignore the reported capacity if the card otherwise reports UHS support.
>
> Currently SDSC cards reporting UHS support except for the CCS do not run
> through the voltage switch.
> While strictly speaking a SDSC card cannot support UHS in compliance
> with the standard, there is no good reason to throttle them that way.

Maybe not, but I think the code just tries to conform to the SD spec.

> Especially for pSLCs in practice such cards benefit greatly by this patch=
,
> as they can be new and UHS supporting, but must not lie about their CCS.

Can you provide some concrete examples of SDSC cards that support UHS-I?

> The behaviour of linux-mmc for SDSC is deviating from the standard anyway
> in such a case, as the card is treated as UHS card not supporting the
> voltage switch in general.
> Such a card will come up as
> mmc0: new ultra high speed SDR25 SD card at address 0001.
> Thus the subsystem will support CMD23 and others to the card.
> But if we deviate from the standard anyway, then we might as well
> not throttle SDSC to 25MB/s.

Not sure I understand this correctly? Can you elaborate a bit more, so
I understand how we deviate from the SD spec here?

As far as I understand the spec, SDSC cards shouldn't support UHS-I.
If we decide to deviate from the spec to support this anyway, at least
we need to know about a couple of cards that actually supports this.

Kind regards
Uffe

>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/sd.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 6fa51a6ed058..281ca2da8e0b 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -841,11 +841,10 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, =
u32 *cid, u32 *rocr)
>                 return err;
>
>         /*
> -        * In case CCS and S18A in the response is set, start Signal Volt=
age
> -        * Switch procedure. SPI mode doesn't support CMD11.
> +        * In case S18A in the response is set, start Signal Voltage Swit=
ch
> +        * procedure. SPI mode doesn't support CMD11.
>          */
> -       if (!mmc_host_is_spi(host) && rocr &&
> -          ((*rocr & 0x41000000) =3D=3D 0x41000000)) {
> +       if (!mmc_host_is_spi(host) && rocr && (*rocr & 0x01000000)) {
>                 err =3D mmc_set_uhs_voltage(host, pocr);
>                 if (err =3D=3D -EAGAIN) {
>                         retries--;
> --
> 2.31.1
>
> Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> Managing Directors: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
