Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D273EC409
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 19:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbhHNRN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 13:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbhHNRNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 13:13:55 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC06AC061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:13:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id e19so15924604pla.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZdlSu+dxBgBNyDJIPOwKBeQJU2RsDPsbPH09vbpsfE=;
        b=jPZn0kMjXsEWkNzcvEvpypJrWNk7r1wa3GW06+21pqAxyUF5xx5EGz7b9L71aZKrpj
         bTI6/n66xaDAWDO1ifM9/uQtBvHSr9jKsP5yjqdz/1mWXGB/YRUQOKqqPH07pe5y5MrH
         Zn+6dXRMgUrd2SmhUgLc5nJE5sBJ03bZyCNmysgwWZ4PTN1JnQeShrBSX0v1QRXms2dZ
         QJTmyAmVxslRvAAgoKnKEhVtnn1SFo6uZw2pCNa1uEMKah/18LfU3TlS3dNLFtqlNkqR
         iX+6nIl+1jiFYZKr7nmWRK0f4p73Zcruqk58FF3zrOtG2RplPxlml7ph8/7ZQknsnYUN
         Rw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZdlSu+dxBgBNyDJIPOwKBeQJU2RsDPsbPH09vbpsfE=;
        b=CRVI5EkXcTENAqBA96w4KwK6b8u/lA0L9ZCK20681YhfbfrpDx0QKFsfrdybfiNm9A
         7En4dWkTrorRSr7pgjJOYrpvFhcQUTnzoEwDqR3/sfJlUfEWWlcibhjbrTmrkRPKzp3o
         bL6jVSyCMPUlXkT6dwzkUhBxHlLQ+zM0lCtGrcV44L7+fPjJfRA8qDa3XqJA7tN05Cdu
         eq6HbBkKid8Va4SFirsN2xctN3Py70LtdXt2h6LVCF618nH/e1lErMps/+xVA7Th4Tlv
         z8w5jtB8nBdff92tw5wPOFsvcJHbx+iuB0kyHHlDnfS699YHkonEjfpHII9oArMY2qQh
         oRLA==
X-Gm-Message-State: AOAM530ixdh2xW0dJ9ifXY/lGxoXU/TxGKKt7YoPtFBu8nj6pTEuQX9R
        ACJaEbsjSPtLDGZDUd51lacJ4zGZJMhEmxrD7nChqw==
X-Google-Smtp-Source: ABdhPJzyzZ/e1km0VD5ChlgIUMAEyb76zPROBxmeQVG1rOT4VYcAMNdopaJ8o4oKy2NVfsfhdPEgMVa+9hOayKy27Jk=
X-Received: by 2002:a17:902:8c81:b029:12c:ee37:3f58 with SMTP id
 t1-20020a1709028c81b029012cee373f58mr6405719plo.45.1628961206255; Sat, 14 Aug
 2021 10:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210813073109.25609-1-straube.linux@gmail.com> <20210813073109.25609-5-straube.linux@gmail.com>
In-Reply-To: <20210813073109.25609-5-straube.linux@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 14 Aug 2021 18:13:15 +0100
Message-ID: <CAA=Fs0kdfVMDJPZpZC-eE2MJJsvEqMjVYGO_PNJq6zJVDgWrUQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] staging: r8188eu: rename Hal_GetChnlGroup88E()
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
> Rename Hal_GetChnlGroup88E() to avoid camel case.
> HalGetChnlGroup88E -> hal_get_chnl_group_88e
>
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> index 07ba5f0eecc2..24a82fc41872 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> @@ -2060,7 +2060,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
>         }
>  }
>
> -static void Hal_GetChnlGroup88E(u8 chnl, u8 *group)
> +static void hal_get_chnl_group_88e(u8 chnl, u8 *group)
>  {
>         if (chnl < 3)                   /*  Channel 1-2 */
>                 *group = 0;
> @@ -2114,7 +2114,7 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
>
>         for (rfPath = 0; rfPath < pHalData->NumTotalRFPath; rfPath++) {
>                 for (ch = 0; ch < CHANNEL_MAX_NUMBER; ch++) {
> -                       Hal_GetChnlGroup88E(ch, &group);
> +                       hal_get_chnl_group_88e(ch, &group);
>
>                         pHalData->Index24G_CCK_Base[rfPath][ch] = pwrInfo24G.IndexCCK_Base[rfPath][group];
>                         if (ch == 14)
> --
> 2.32.0
>

Dear Michael,

Looks good to me, thanks.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
