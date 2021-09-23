Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDF9415BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbhIWKER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbhIWKEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:04:14 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9347FC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:02:42 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c7so20350958qka.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JSwhP84dj9Z7Ar0pWmSPtqijQIhRwdsFjtrnLmU8Db4=;
        b=NAkjC/auB0cBiJMF2yPmf9rMjSZXC8nuq1zdS5THdGYiOaVNN/DRutxXMMdq0haaRd
         DlzhdequAIUlxq1tmP9KDu19JBZ1ZPz4hoZ+sd8eYGH1mNvaMygtMMGs5yQEGh8KrUXh
         6sD8LhefhlLeNnF7bpprPQAUlqOsZbaYvFEr5bINJBrNCZoYq172woXX6USWUPmThYDR
         diQh5jirJcJzaPKTjyW0yM0tftnBgahncXhCrDqJkqNqgluohN8BF1hn+ABdG8A3bzQJ
         aRpNuPWChDjCXVzgVKTdIUp7ZOkhMHMMmQTvZh4Cdx+CvQUA+wwOZ7Ga+BHCX8tpPdhZ
         iYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSwhP84dj9Z7Ar0pWmSPtqijQIhRwdsFjtrnLmU8Db4=;
        b=nn0Zoh0NvnYCfGS9U2ca3sOb/lTA34uRXxqCEfUkL+YTyEh2MyXGObNyrXGtgbOaw6
         jfiUF5UFcbQMQ+ihSyd2dGdi9Dl2eGfYkBMY5M0ODkDouSgurntuAdjFuEWZV33Z9NNO
         GiIc3l8AOGRlyrAGqtEkLZKrfGvdLseDK6Ku3XfboTcrb8NbZiFNMIuWEOAotj4kKIjW
         aTmsbxb5z3bTelzUlCRZqpgkSqO/pUe2dljPYXguzF1cu7IWuheDvEjo+XkWLOGOV7/j
         4Et2uiFNSj+l0HW7CU/Z4r3XoqralqtSxflbIQdftuFqQGJHiFlIrGiR0Gl5gapW12va
         P9BQ==
X-Gm-Message-State: AOAM5336T8bU8q9VTb0zwmACWRkuYaJeAdT9HKJMCWUlATRVgq+ok/8w
        DTXDy4UHbmJovNedEK/ywvPw9fGlPjorCcSY9YJrAQ==
X-Google-Smtp-Source: ABdhPJz3y+iCPmpiBcpxXC08BGN4AOacvJkrlEarbx8v86Kx9BQo4h/w6sYKgp78xO4eO6nlShQy66z2BxdNDr0+nsU=
X-Received: by 2002:a25:2e0f:: with SMTP id u15mr5053731ybu.133.1632391361781;
 Thu, 23 Sep 2021 03:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210922094131.15625-1-linyunsheng@huawei.com>
 <20210922094131.15625-2-linyunsheng@huawei.com> <0ffa15a1-742d-a05d-3ea6-04ff25be6a29@redhat.com>
In-Reply-To: <0ffa15a1-742d-a05d-3ea6-04ff25be6a29@redhat.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Thu, 23 Sep 2021 13:02:05 +0300
Message-ID: <CAC_iWjJLCQNHxgbQ-mzLC3OC-m2s7qj3YAtw7vPAKGG6WxywpA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/7] page_pool: disable dma mapping support for
 32-bit arch with 64-bit DMA
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linuxarm@openeuler.org, Jesper Dangaard Brouer <hawk@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Willem de Bruijn <willemb@google.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Kevin Hao <haokexin@gmail.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Marco Elver <elver@google.com>, memxor@gmail.com,
        Eric Dumazet <edumazet@google.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        David Ahern <dsahern@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesper,

On Thu, 23 Sept 2021 at 12:33, Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:
>
>
> On 22/09/2021 11.41, Yunsheng Lin wrote:
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index 1a6978427d6c..a65bd7972e37 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -49,6 +49,12 @@ static int page_pool_init(struct page_pool *pool,
> >        * which is the XDP_TX use-case.
> >        */
> >       if (pool->p.flags & PP_FLAG_DMA_MAP) {
> > +             /* DMA-mapping is not supported on 32-bit systems with
> > +              * 64-bit DMA mapping.
> > +              */
> > +             if (sizeof(dma_addr_t) > sizeof(unsigned long))
> > +                     return -EINVAL;
>
> As I said before, can we please use another error than EINVAL.
> We should give drivers a chance/ability to detect this error, and e.g.
> fallback to doing DMA mappings inside driver instead.
>
> I suggest using EOPNOTSUPP 95 (Operation not supported).

I am fine with both.  In any case though the aforementioned driver can
just remove PP_FLAG_DMA_MAP and do it's own mappings.

Regards
/Ilias
>
> -Jesper
>
