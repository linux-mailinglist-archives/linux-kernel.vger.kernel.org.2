Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5AE438942
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 15:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhJXNyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 09:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhJXNye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 09:54:34 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735FFC061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 06:52:13 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id o42so3868239vkf.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 06:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=id1p4qGVhAju1dNKS9ewXd/BAGNoNoVxYAeg/MMzZkk=;
        b=S7J2ND/kmDgFgy4AH1WOhj0CUNoHlN2y+ArUyM1B26rKOQ8Ax8jXgz8ou6NJqRrH5X
         VQcJJIZ1OJBzSD7cW03ffYhT5wnSiG02IY8lj3QReK9OmkiIgUcVqfnRMlAwAGw5V7xy
         Sfp0M9wvNWJnH6aO1HhKwXg8uIpani44NbMRtNLbxZBf95TyIpc9Kd1dcYUWJ37R+/jQ
         7Pm3jQc8CodMCVtUMzgbHxXuEqZh3sgOAlDJNgoSvK/D+wRx4yM1viMwDxHPj6+Jtk8S
         jEyOe6gFlDpwZ9HrUsiaW2etn7WeNTRQwET3c5kzxi7uaAhWGwYTVIGtFwur6YjO25/6
         0K7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=id1p4qGVhAju1dNKS9ewXd/BAGNoNoVxYAeg/MMzZkk=;
        b=mTpGopt+8UW+lYqwMVwmWMFa4QrI7UlK69cPHvYyHbAZ3kvE2awYywfNFRAQMHRUkZ
         0Tgzq24ygkITB9EDy0s2ZYKA9RHPVtBP1CS7T1M4g2yxKzZk5i+u4qpNkf/vRY0xNuxY
         Fi2FVnQ2nLMAFexqq+lRfCvKRjSIZPIT/Tj18xR7jiLxeys/iuYq+nejwerilv46I4kW
         KZrYCS4CiOLD9beFaMaJsPLa8h95wpzHvwuOC+HktWEL2EJwT/tRfHuqz0NCxLnI4Swg
         9GUk4gDCTDRts7XjZQztDQibVGpJjd3uG5mqCZYO3Ddt4jke124HI5ptUITLUKgE6N7p
         aqIg==
X-Gm-Message-State: AOAM532iOQrYC+W3cb+UHIJeDn/IV7/KXScYsSQAI1IVmscJAlNsg00b
        Mqr3heAPMcabtFb18uGSugdSqCFzWXA=
X-Google-Smtp-Source: ABdhPJwD/h8kn75KG4zXyVvvtv3guEsahStyDel6AouTIS6PGxiPa0eGiyGCxy3nAxj9JWgfNelTGw==
X-Received: by 2002:a05:6122:2029:: with SMTP id l41mr10703566vkd.10.1635083532605;
        Sun, 24 Oct 2021 06:52:12 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 10sm7880219vkl.55.2021.10.24.06.52.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 06:52:12 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id e2so16883988uax.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 06:52:12 -0700 (PDT)
X-Received: by 2002:a67:e0d1:: with SMTP id m17mr10843041vsl.22.1635083531874;
 Sun, 24 Oct 2021 06:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <fb712f802228ab4319891983164bf45e90d529e7.1635076200.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <fb712f802228ab4319891983164bf45e90d529e7.1635076200.git.christophe.jaillet@wanadoo.fr>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 24 Oct 2021 09:51:35 -0400
X-Gmail-Original-Message-ID: <CA+FuTSftgpOGxAxRE5u9o6gT_exaLtC2JkBz=iq21qe+tTTomA@mail.gmail.com>
Message-ID: <CA+FuTSftgpOGxAxRE5u9o6gT_exaLtC2JkBz=iq21qe+tTTomA@mail.gmail.com>
Subject: Re: [PATCH] gve: Fix a possible invalid memory access
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jeroendb@google.com, csully@google.com, awogbemila@google.com,
        davem@davemloft.net, kuba@kernel.org, bcf@google.com,
        gustavoars@kernel.org, edumazet@google.com, jfraker@google.com,
        yangchun@google.com, xliutaox@google.com, sagis@google.com,
        lrizzo@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 7:52 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> It is spurious to allocate a bitmap for 'num_qpls' bits and record the
> size of this bitmap with another value.
>
> 'qpl_map_size' is used in 'drivers/net/ethernet/google/gve/gve.h' with
> 'find_[first|next]_zero_bit()'.
> So, it looks that memory after the allocated 'qpl_id_map' could be
> scanned.

find_first_zero_bit takes a length argument in bits:

    /**
     * find_first_zero_bit - find the first cleared bit in a memory region
     * @addr: The address to start the search at
     * @size: The maximum number of bits to search

qpl_map_size is passed to find_first_zero_bit.

It does seem roundabout to compute first the number of longs needed to
hold num_qpl bits

    BITS_TO_LONGS(num_qpls)

then again compute the number of bits in this buffer

    * sizeof(unsigned long) * BITS_PER_BYTE

Which will simply be num_qpls again.

But, removing BITS_PER_BYTE does not arrive at the right number.


>
> Remove the '* BITS_PER_BYTE' to have allocation and length be the same.
>
> Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is completely speculative and un-tested!
> You'll be warned.
> ---
>  drivers/net/ethernet/google/gve/gve_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 7647cd05b1d2..19fe9e9b62f5 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -866,7 +866,7 @@ static int gve_alloc_qpls(struct gve_priv *priv)
>         }
>
>         priv->qpl_cfg.qpl_map_size = BITS_TO_LONGS(num_qpls) *
> -                                    sizeof(unsigned long) * BITS_PER_BYTE;
> +                                    sizeof(unsigned long);
>         priv->qpl_cfg.qpl_id_map = kvcalloc(BITS_TO_LONGS(num_qpls),
>                                             sizeof(unsigned long), GFP_KERNEL);
>         if (!priv->qpl_cfg.qpl_id_map) {
> --
> 2.30.2
>
