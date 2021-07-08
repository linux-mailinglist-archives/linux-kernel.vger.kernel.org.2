Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040EE3C1718
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 18:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhGHQd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 12:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhGHQdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 12:33:54 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D0EC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 09:31:12 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id r135so9981928ybc.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 09:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NMTcg78nKWSJcJfCUjOApxjzs+sPcdCEgZ4uZjz231g=;
        b=z2RNN4Nu5H7/UcFUNCQRgZe9XBD8/tCo9TRGYLjRUtYjwiF9KhEpT6Yh5L8Ub9yaaZ
         PGucGzX5OfnesZpNwTWrT3jsYw1uyo1sg51dl9olR5hakcsj0HlwN+sEVxaj7XM/lCEe
         XNZnZmb06lWZ+YUuyorzzQXalXJ47jKudzjOPLFLbHd1bgUr6I1G7JJsE3zWrz2Z85Bg
         afwd+z9Adk2rZncrNlOT4bqfhHS0SP0qu5gtAeXRU/6tBuS2TkOSR6xBVQbaUT0ujloD
         +e0+vv//EEyhCA9a+Nu0BSfHmZEko5H0WrF0tSTVcHa+G7aoJxFFU2VQMMx3psSlq0fL
         3nWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMTcg78nKWSJcJfCUjOApxjzs+sPcdCEgZ4uZjz231g=;
        b=ZoUv5wZyKm+2fiEH9hbz6Eg+EO58ZEQT8TzZJBSHOsmhGfUaklVPElGgOKGKQuihwn
         +dNFpC4IJHg9QZhCDLxOhurFmLaF+FMwFvH2NDaVO6dw61ibUJfJS0cy6sn3pnIE4l+4
         AML7LBG1ImSNlKcJfNJNOPayAm0yChfOvt4c7RIf7GwH2NgXFNZlp+FTFVW34ZVcXBtG
         ieedUcD2kmWn0qDyRavagqhIW1pEqodlkdPZbHcvxVvCmVpEWYQe/olnLXwjfWKbnJWk
         rYHYnUrS3Cuxmb3YjTNdRKszbpc/2dVErj4JhYOOb4/OXb9FVDERss048JS8OKGm+CfJ
         cVwA==
X-Gm-Message-State: AOAM5338+Mi5NvolOuRPyFU8zQ0QM9Ps6z/24bkdYgRxGXrSWdHz/hH7
        txSW21e0DjL2MRx1XR1G2eFov1M6HX4LF1eBjntReQ==
X-Google-Smtp-Source: ABdhPJyifGeQbMAKWpzpjofrDfJiL8SSZR7E6f1CcjMhjl1jVg3iJx7e0tf4JxyxMAUOwTZ4x03qcSTWAN/yk8BYhu4=
X-Received: by 2002:a25:41c7:: with SMTP id o190mr39204050yba.256.1625761870465;
 Thu, 08 Jul 2021 09:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210708162449.98764-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20210708162449.98764-1-ilias.apalodimas@linaro.org>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Thu, 8 Jul 2021 19:30:31 +0300
Message-ID: <CAC_iWjLsd-hJs1gk3CknJFXb2H4aAeEUUUskzPEugeRHjRuWLg@mail.gmail.com>
Subject: Re: [PATCH] skbuff: Fix a potential race while recycling page_pool packets
To:     Networking <netdev@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Guillaume Nault <gnault@redhat.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc Alexander on his gmail address since the Intel one bounced.

Alexander want me to respin it with you gmail address on the Reported-by?

Sorry for the noise
/Ilias

On Thu, 8 Jul 2021 at 19:24, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> As Alexander points out, when we are trying to recycle a cloned/expanded
> SKB we might trigger a race.  The recycling code relies on the
> pp_recycle bit to trigger,  which we carry that over to cloned SKBs.
> When that cloned SKB gets expanded,  we are creating 2 separate instances
> accessing the page frags.  Since the skb_release_data() will first try to
> recycle the frags,  there's a potential race between the original and
> cloned SKB.
>
> Fix this by explicitly making the cloned/expanded SKB not recyclable.
> If the original SKB is freed first the pages are released.
> If it is released after the clone/expended skb then it can still be
> recycled.
>
> Fixes: 6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB recycling")
> Reported-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  net/core/skbuff.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 12aabcda6db2..0cb53c05ed76 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1718,6 +1718,13 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
>         }
>         off = (data + nhead) - skb->head;
>
> +       /* If it's a cloned skb we expand with frags attached we must prohibit
> +        * the recycling code from running, otherwise we might trigger a race
> +        * while trying to recycle the fragments from the original and cloned
> +        * skb
> +        */
> +       if (skb_cloned(skb))
> +               skb->pp_recycle = 0;
>         skb->head     = data;
>         skb->head_frag = 0;
>         skb->data    += off;
> --
> 2.32.0.rc0
>
