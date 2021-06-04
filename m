Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD67339B8D2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 14:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhFDMOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 08:14:08 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:44658 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhFDMOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 08:14:07 -0400
Received: by mail-vs1-f48.google.com with SMTP id i29so4673658vsr.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 05:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KQXWWLT5RQ01iYXrL3I6svphgBdijbU/3J0LL0eegpg=;
        b=y7LP51U0YcEky4gv642q0QUU2JYMNeoO4KxLeBONC9s1eHDOsXIBjajOKgug9Xu/GU
         4B+dQMFcYSCjV+dKFqYuzNMqbFVHO8a9sSeQ9BojpOYZOdhzZVB7K2+PMgq+NcRWYCsf
         eWxAKCrop5AfOKLqtygq8mRWCapXlH4YALzhlLGMANuUsC1dJcAnFOn6qcQYML3HbpHI
         KDwqq04OGSeM0jZum8P6TJ6S9dxZM2kEqvdPB5SKmsrHTw50d87WOM2GYI6Zi9M8qjpy
         z20H+JZvWXafVHsSe2mvuyyzskXFluGFlkhrPkMg7S8FPDpBsxg2QLG54scRSaxlNUPz
         Jggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KQXWWLT5RQ01iYXrL3I6svphgBdijbU/3J0LL0eegpg=;
        b=DUUTTT3wyO5OxN9zupcMOMK+ZOHeDULFdmnel9KhoY6brWXrZE+yHsonFNZKHyulBG
         i3NB4dekxS1qNdCVf9gkBRymaNFtX6+n7+kHYcKSndCNOxrV6ppuwgaY7xbK956qyw1l
         YvSdvGnUcU/02++J/0zexHismfJZUk4XW0r61QyVJ7zEOAcz5mQpBHDpcwFTXYiuC9wE
         h/0rVuFbk9KsUpWMoVl2uTnv9VkNabwO6u5OkfhYlSbpCwAfaDly9K54wu3nGBWRWLn4
         MTLT0q08THsRmOAeR9lymJr8CsPk/wT1d3Eiwcs42ZBeDoSU066M8Cl4c74oguqjgDH6
         BT6Q==
X-Gm-Message-State: AOAM533juqU0G3wVidiZJMAMlqZ6C0CJ1h3K0pl73iMJMxhHAXTQywmg
        cMHQ9PqwJp0g/ikrn5d/4nenkLtBHGYULH80h8ZHPrt0qGzREQ==
X-Google-Smtp-Source: ABdhPJyKQ0RL5S/5QNho2NFAvPLDRm/Kgm6BnWjs1SAGW8VTZ/Lmltet/mkhoUZci+3FgXaz7bPQnfLBNpUTPWTyxA0=
X-Received: by 2002:a05:6102:3023:: with SMTP id v3mr1834711vsa.19.1622808672999;
 Fri, 04 Jun 2021 05:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CWXP265MB26803AE79E0AD5ED083BF2A6C4529@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB26803AE79E0AD5ED083BF2A6C4529@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Jun 2021 14:10:36 +0200
Message-ID: <CAPDyKFq_eM0EvLk_M2nGhJMv4nouZLKnhowtyHbH-MM8U5Awpw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: enable UHS voltage switch for SDSC if supported
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

On Wed, 12 May 2021 at 18:03, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> Ignore the reported capacity if the card otherwise reports UHS support.
>
> Let SDSC cards reporting UHS support (except for the CCS) attempt the
> voltage switch.
> Up until now such cards would be initialized as UHS,
> supporting UHS features SDSC cards are otherwise barred from,
> but skip the voltage switch.
> While strictly speaking a SDSC card cannot support UHS in compliance
> with the standard, there is no good reason to throttle them that way.
> Especially for pSLCs in practice such cards benefit greatly,
> as they can be new and UHS supporting, but must not lie about their CCS.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Apologize for the delay. I have tested a bunch of my old (and new)
SD/uSD cards, this seems to work fine.

I have applied this for next, but I think this actually should be
considered as bug fix. I let it cook in linux-next for a while, then I
will probably add a stable tag for it.

Thanks and kind regards
Uffe

> ---
>  drivers/mmc/core/sd.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 2c48d6504101..62d02f1dc924 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -847,11 +847,17 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, =
u32 *cid, u32 *rocr)
>                 return err;
>
>         /*
> -        * In case CCS and S18A in the response is set, start Signal Volt=
age
> +        * In case S18A in the response is set, start Signal Voltage
>          * Switch procedure. SPI mode doesn't support CMD11.
> +        * Strictly speaking, S18A is not valid if CCS is not set (=3D no=
t SDSC),
> +        * so one would have to OCR for 0x41000000.
> +        * We choose to ignore this as SDSC cards that report UHS voltage
> +        * support should not be throttled artificially by the standard t=
his
> +        * way.
> +        * SDSC cards that 'accidentally' reporting UHS support by settin=
g the
> +        * reserved bits don't seem to be an issue in practice.
>          */
> -       if (!mmc_host_is_spi(host) && rocr &&
> -          ((*rocr & 0x41000000) =3D=3D 0x41000000)) {
> +       if (!mmc_host_is_spi(host) && rocr && (*rocr & 0x01000000)) {
>                 err =3D mmc_set_uhs_voltage(host, pocr);
>                 if (err =3D=3D -EAGAIN) {
>                         retries--;
> @@ -1109,7 +1115,14 @@ static int mmc_sd_init_card(struct mmc_host *host,=
 u32 ocr,
>                 }
>         }
>
> -       /* Initialization sequence for UHS-I cards */
> +       /* Initialization sequence for UHS-I cards
> +        * Strictly speaking, S18A in the OCR is only valid if CCS is set=
, too.
> +        * So SDSC cards should be excluded. We choose to deviate from th=
e
> +        * standard here to allow SDSC cards to utilize UHS if they repor=
t
> +        * supporting it.
> +        * Fortunately, SDSC cards reporting S18A and the related bus spe=
ed
> +        * modes on accident, by setting reserved bits, don't seem to exi=
st.
> +        */
>         if (rocr & SD_ROCR_S18A && mmc_host_uhs(host)) {
>                 err =3D mmc_sd_init_uhs_card(card);
>                 if (err)
> --
> 2.31.1
>
> Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> Managing Directors: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
