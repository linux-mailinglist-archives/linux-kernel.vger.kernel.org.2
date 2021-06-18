Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC853AD242
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 20:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhFRSjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 14:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhFRSjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 14:39:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43239C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 11:37:02 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t7so9872507edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 11:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ekt7Aut3pbPnsGjycKsCk6iV3UU+d516hwM721Obk3Q=;
        b=jBRXPNa0dHbOGnhJdkkRiXiRvCYK3N4Q8EAKJfo7RR/umKj8e/jwD0A07py0jjs1g9
         xo4euodvDf86EF0YWM9A5Jr1RQiHo8Ve46TiqEwIXlpyYC1gr8iBL+UHPeJziS7FfY6K
         B84qIJX+gQHnrQddq9tRwgvOCvF6O3pqIts67MUvEghFcan+bwhuP6rIDbv8k5un1IJt
         nN3YqYg7UTzpwAJGf0HiI2/UN7ONHJr+TGwk2eiYVqFrLtZ+GgwH2lxfV98hLpbCmW76
         J5VpWkwuS0zT6T4SInV2GPBqcLNFYcBdV0krsgZMNwkckGGgIWJrFNiZDYrRo3JMKX7S
         00Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ekt7Aut3pbPnsGjycKsCk6iV3UU+d516hwM721Obk3Q=;
        b=UxPeGZ17L51NIFHnrGNsisgaiiGzMddcm+DnkrNBadOrPMhGV/zTaxV/cWupIO3EC4
         9YdFwFkY4OnS+VViyWso7+mOIv1aYG8pi+TAyBWZXXJYukPGqpqO5vqKVsTlvM3yzbj7
         r/dREYCyv+L2Pbb/1l/juONd20eZyZY5ecM5tpkJFiocprPndusywSBxrg/l6ux6knwg
         CFdao1torazLlBL16AFh/MNTJV9lyCwpzkuXFilikkXHuTFMVaLmxPBMRKTINmJppZo8
         GXQ24TXC0OP79IGD9VAGW3yIHv7tYDDJBwtXbm64adquqAfSxnX/jTeQaLHg4Elhh4RJ
         nIJA==
X-Gm-Message-State: AOAM531/4fga5GaZuqyR8focX3hQE9HsE2JELAntMPVoaI1xKg5bJNDZ
        cxS/ROnkqfH+zzFfoS9qvnpv94E3B8blayyffoY=
X-Google-Smtp-Source: ABdhPJzxFbIUov7kG4A6bLF3AGJlZ813KPZ11AXwRTOmjaQyYGXMb+qVKr5uMq6bYqMFCkvhF/doQS6SsLbFPo7h91I=
X-Received: by 2002:aa7:dc4c:: with SMTP id g12mr7149764edu.258.1624041420817;
 Fri, 18 Jun 2021 11:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210613102229.1424495-1-fbihjmeric@gmail.com> <8974a58823d74d118595d4f8db5ac870@AcuMS.aculab.com>
In-Reply-To: <8974a58823d74d118595d4f8db5ac870@AcuMS.aculab.com>
From:   Jhih Ming Huang <fbihjmeric@gmail.com>
Date:   Sat, 19 Jun 2021 02:36:49 +0800
Message-ID: <CAKgboZ_G+46OL3_foSnJ8ZQ_MOR2nNK_rfuqcXc_AjQN63Qk+A@mail.gmail.com>
Subject: Re: [PATCH] rtw_security: fix cast to restricted __le32
To:     David Laight <David.Laight@aculab.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "fabioaiuto83@gmail.com" <fabioaiuto83@gmail.com>,
        "ross.schm.dev@gmail.com" <ross.schm.dev@gmail.com>,
        "maqianga@uniontech.com" <maqianga@uniontech.com>,
        "marcocesati@gmail.com" <marcocesati@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 4:48 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Jhih-Ming Huang
> > Sent: 13 June 2021 11:22
> >
> > This patch fixes the sparse warning of fix cast to restricted __le32.
> >
> > Signed-off-by: Jhih-Ming Huang <fbihjmeric@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_security.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c
> > b/drivers/staging/rtl8723bs/core/rtw_security.c
> > index a99f439328f1..2f4da67e31c6 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> > @@ -121,7 +121,7 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
> >               arc4_crypt(ctx, payload, payload,  length);
> >
> >               /* calculate icv and compare the icv */
> > -             *((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
> > +             *((u32 *)crc) = le32_to_cpu((__force __le32)~crc32_le(~0, payload, length - 4));
> >
> >       }
> >  }
> > @@ -618,7 +618,8 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
> >                       arc4_setkey(ctx, rc4key, 16);
> >                       arc4_crypt(ctx, payload, payload, length);
>
> Is someone using 'rc4' and 'security' in the same file?
Sorry, I don't get it. Could you explain it more? thanks.

>
> >
> > -                     *((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
> > +                     *((u32 *)crc) = le32_to_cpu((__force __le32)~crc32_le(~0, payload,
> > +                                             length - 4));
> >
> >                       if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
> >                           crc[1] != payload[length - 3] || crc[0] != payload[length - 4])
>
> In both cases the *((u32 *)crc) is also very dubious.
> Casts of pointers to integer types are almost always broken.
> Given the code that follows the second hunk I'm guessing you
> have 'u8 crc[4];' (or equivalent).
> That can be misaligned and then access will panic on some systems.
>
yes, I've sent the v3 PATCH and used Al Viro's suggestions.

> There is a get_unaligned_be32() (or something similar) that can be used
> to read the crc from (payload + length - 4).
I also used memcmp for checking.

thanks.

--jmhuang

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
