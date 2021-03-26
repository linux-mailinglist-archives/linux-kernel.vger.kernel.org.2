Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E237634A4AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhCZJjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhCZJit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:38:49 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218D9C0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:38:49 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id i144so5267997ybg.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PpOJ1wOLMIvyWjoFEm2gN2wKrQqTCqPen/GVvlMH/A4=;
        b=lcn0qzmbY6xZLOZP1F5KaNogmEW6du15pcDXTKZJue3mlVdfib1f+j4d+F9IhTdGCn
         ZkO0m2sWfW0FbAKnTV7arESl1Z7PGlfqRjUqfmxLoRDP7koyYhjDbdZ0Uqaq8f35WObS
         EMBni5WQ7GQtnZ2d2ZK5poAOnLbPK29pgZHD4EIYDyyZVi7Yifg8syQ/u7W8WYAbtrA0
         x4/5/FBpO6JUWdzFeTH216ISxzpjiJcAaeIXZs/Kfe9uFCwLjnWWfLyt6sS1opULCKiY
         oB4RYg1eZ0yxK+9wWlrjB3gxMZ+LIQiNHZWlsmzCGO5b/IpSQ3nGXvDZ5Wkr7ki0lVBw
         ly2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PpOJ1wOLMIvyWjoFEm2gN2wKrQqTCqPen/GVvlMH/A4=;
        b=Xr4AJQTFHfZqnIkqV7l24DZsi3UtkjK4X3B92tjU6J5MtUIce7oJmZxxIjLuj5CcMG
         YboaCvupZO5Qi7qGI4kMNbi19T+cnPEVp9H8NwwjHHo1F/hUCIWOu+gKyCyBoiCjvO9P
         bb2+t2I4Uy2/mWQHqSiUACm6isOdmHCB4HYIWPrzlzKaom94xp5Uq0sOCHHebi/rfoIy
         nXP3pcvHuOhPXr/tHDgsCiW7obN+2xt5XR/CpcH1++KSaeoQfNfTv1P3dtaQmnCbcfTi
         THRylJhYYrscnRf9FQIG293dgkCuoC3nkrCbYG9bvUgfUoOpDQmedHEbOE0Z3eQ0uLdB
         er3A==
X-Gm-Message-State: AOAM531FCrekwICM1fgawg2cYUNr4pAOTIIVPjyZLSAiTU5+b5aeIC+J
        DxbYWjks0q3D3HRmBV4ULXr1m7+KmxGMbCXFFT931KUSbBE=
X-Google-Smtp-Source: ABdhPJwHVGRxsbNUDDOeUsdR4tqmqMB/cwoV91gMJB5TVxe2rgRuQpTPhJL3FCF9GeufsbOzkzsT3kMsrpmVq4LeikU=
X-Received: by 2002:a25:4d84:: with SMTP id a126mr18940697ybb.193.1616751516685;
 Fri, 26 Mar 2021 02:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210326022128.71727-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20210326022128.71727-1-tianjia.zhang@linux.alibaba.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Fri, 26 Mar 2021 12:38:25 +0300
Message-ID: <CAOtvUMfSC02o03c=Q-8d7vy8KS3QmNTBc59An=-m4BmNzt8_GA@mail.gmail.com>
Subject: Re: [PATCH] crypto: sm3 - use the more precise type u32 instead of
 unsigned int
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch!

On Fri, Mar 26, 2021 at 5:21 AM Tianjia Zhang
<tianjia.zhang@linux.alibaba.com> wrote:
>
> In the process of calculating the hash, use the more accurate type
> 'u32' instead of the original 'unsigned int' to avoid ambiguity.

I don't think there is any ambiguity here, as both forms are always
the same size.

Generally, I tend to use the convention of using 'u32' as denoting
variables where the size is meaningful - e.g. mathematical operations
that are defined in the standard on 32 bit buffers,  versus using
plain 'int' types where it isn't - e.g. loop counters etc.

Having said that, even under my own definition possibly the w and wt
arrays in sm3_trandform() should be changed to u32.
I don't object to changing those if it bugs you :-)

Cheers,
Gilad


> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  crypto/sm3_generic.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/crypto/sm3_generic.c b/crypto/sm3_generic.c
> index 193c4584bd00..562e96f92f64 100644
> --- a/crypto/sm3_generic.c
> +++ b/crypto/sm3_generic.c
> @@ -36,17 +36,17 @@ static inline u32 p1(u32 x)
>         return x ^ rol32(x, 15) ^ rol32(x, 23);
>  }
>
> -static inline u32 ff(unsigned int n, u32 a, u32 b, u32 c)
> +static inline u32 ff(u32 n, u32 a, u32 b, u32 c)
>  {
>         return (n < 16) ? (a ^ b ^ c) : ((a & b) | (a & c) | (b & c));
>  }
>
> -static inline u32 gg(unsigned int n, u32 e, u32 f, u32 g)
> +static inline u32 gg(u32 n, u32 e, u32 f, u32 g)
>  {
>         return (n < 16) ? (e ^ f ^ g) : ((e & f) | ((~e) & g));
>  }
>
> -static inline u32 t(unsigned int n)
> +static inline u32 t(u32 n)
>  {
>         return (n < 16) ? SM3_T1 : SM3_T2;
>  }
> @@ -54,7 +54,7 @@ static inline u32 t(unsigned int n)
>  static void sm3_expand(u32 *t, u32 *w, u32 *wt)
>  {
>         int i;
> -       unsigned int tmp;
> +       u32 tmp;
>
>         /* load the input */
>         for (i =3D 0; i <=3D 15; i++)
> @@ -123,8 +123,8 @@ static void sm3_compress(u32 *w, u32 *wt, u32 *m)
>
>  static void sm3_transform(struct sm3_state *sst, u8 const *src)
>  {
> -       unsigned int w[68];
> -       unsigned int wt[64];
> +       u32 w[68];
> +       u32 wt[64];
>
>         sm3_expand((u32 *)src, w, wt);
>         sm3_compress(w, wt, sst->state);
> --
> 2.19.1.3.ge56e4f7
>


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
