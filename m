Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8D53EC407
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 19:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbhHNRNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 13:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbhHNRNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 13:13:32 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA322C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:13:03 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso20720207pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulnCaxbnm9fxcS4SqwelNUN+wWuJnGF9LyN6HPS3uvE=;
        b=GQl+bA5kUXvs5Nsqc8x8ECr6NzBQNS9CRsZ8Z+fk/lUrrKllQWu0WwTXkihZN5T9oj
         H8ywnnNhPgs0u0PtquXh3jRL2wiD1bO6zDL6xjXevlt3lJ2LCa750l7JoVjjCIWJ3970
         3KgJ4O05/Rs8Vs9pAbg7KHotag2NLtelNnVH/W1C9axQoHzIttytRjcZWtwjH+xtFShZ
         EpmxqokQaqpZ1MzmXsRak7Rw3OitYQD8M+P8QDbtK7ebCbj2sVgg5S2W1jb6svcyoVNR
         R/vPnt3iiWU1+UYjAg6H5Kd6wPirdc+xok2wW3ME/++gyeF11394iaLykpat1YnVgejC
         tZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulnCaxbnm9fxcS4SqwelNUN+wWuJnGF9LyN6HPS3uvE=;
        b=lyj16sfwLDUkla3pgA9Rj5y6q8Qfj1qL+wFVET/JhpK6me0KpvqQxKw3/xrzUrpPaO
         YzBk4Isl6ny6KC27F/oTIteenNnsq9kr5fKzUllmgpuGrW5W9VaHpj2SmsWaLvrSXXyD
         oex+53vCryX/jMcqT8OLUEXECdsifSs3dOf3PQN3HE/T54EmeEBkpaAHQ5hdWIInzlMN
         OC7NejQzxKXvwHuWXMNj1ZQ2XnNnO1veLoi43pjMK/JytzQcFFod/y/jajpLMagu61BZ
         G1dJgVQZZ8/mrh1envsfZJATmU8ncpcgmux3BM97FAMW1tEKH2XPNfi9JcdGpBC4cZWk
         Avlw==
X-Gm-Message-State: AOAM5325ix6biDW82jCxH7QfuQnTXkZ8JiFlfS42AUGe+f9WSJEgvY4C
        7mX0k8Qm6A6b9aM9Rw5LPVA+h4uHQhJ9JeVUxspF6tgGdm6lu8FH
X-Google-Smtp-Source: ABdhPJyipbhFpqVeinMI8fTLh0kGagCCpiKlw7u84bawz1NzjpUge43EOFoIIUqh5f0iTjvs7HKnq/ru7oNIethOIZg=
X-Received: by 2002:a63:aa43:: with SMTP id x3mr7653466pgo.208.1628961183442;
 Sat, 14 Aug 2021 10:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210813073109.25609-1-straube.linux@gmail.com> <20210813073109.25609-4-straube.linux@gmail.com>
In-Reply-To: <20210813073109.25609-4-straube.linux@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 14 Aug 2021 18:12:52 +0100
Message-ID: <CAA=Fs0n=P1hzvHdpe+HRqH8tiL3+V8QG38HRszGnUTMpxaP55g@mail.gmail.com>
Subject: Re: [PATCH 3/4] staging: r8188eu: rename parameter of Hal_GetChnlGroup88E()
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
> Rename parameter of Hal_GetChnlGroup88E() to avoid camel case.
> pGroup -> group
>
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> index d3345fa0eb60..07ba5f0eecc2 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> @@ -2060,20 +2060,20 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
>         }
>  }
>
> -static void Hal_GetChnlGroup88E(u8 chnl, u8 *pGroup)
> +static void Hal_GetChnlGroup88E(u8 chnl, u8 *group)
>  {
>         if (chnl < 3)                   /*  Channel 1-2 */
> -               *pGroup = 0;
> +               *group = 0;
>         else if (chnl < 6)              /*  Channel 3-5 */
> -               *pGroup = 1;
> +               *group = 1;
>         else if (chnl < 9)              /*  Channel 6-8 */
> -               *pGroup = 2;
> +               *group = 2;
>         else if (chnl < 12)             /*  Channel 9-11 */
> -               *pGroup = 3;
> +               *group = 3;
>         else if (chnl < 14)             /*  Channel 12-13 */
> -               *pGroup = 4;
> +               *group = 4;
>         else if (chnl == 14)            /*  Channel 14 */
> -               *pGroup = 5;
> +               *group = 5;
>  }
>
>  void Hal_ReadPowerSavingMode88E(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
> --
> 2.32.0
>

Dear Michael,

Looks good to me, thanks.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
