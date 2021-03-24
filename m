Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C065C348485
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhCXWVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238835AbhCXWVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:21:37 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9658C0613DF
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:21:36 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so93961pjv.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIDPF7ri84OLFsNd4OhxmJPSCi5FNfpE4FjtwEiJamI=;
        b=RiBXhaenM9VBbNf7Ikof8uRUzpei4NDWIP7Ov/61XaLR+CqRNKdKd7fevMR7JsPQSn
         dak0k7Il33xba+i95mj9167kOtqh9O/gBnyrBpD3mYXz+NZec2sWUmXXD+jKJMkdYHmZ
         S+kX+o7ONkaASTwWepkBXvtypIYfNzOTkqHPjiHglI7PlYC22lTTYnLEDwcMwTCgkxec
         wRO9mcct/h+YU/KkpwyhIU78PUQXyAKvNNIsc77BBuYWU+MYo1EK/fOQTtdF7aj/WVKb
         qWktnXp87q3dMVTR2qYDoRBCoPIB64pUP9Gyq3wDM/GVZaCK+gv6QQIbZe8N95o3IkGQ
         IQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIDPF7ri84OLFsNd4OhxmJPSCi5FNfpE4FjtwEiJamI=;
        b=SwAYRCLJ9A/T3cGr0FuGIGxVU1lLEAhqxZEC2i06kcjMG9pjsw6U6dEak/zzvNpQKv
         Ui9bfO4R36ZuJcIp2jnRqB9qRaV0YlPiiSdk8cPxNjoApIVMZsHC9cuT6TfgcyxVFCbu
         9nW4MFU/RFIG/cvk+e6n0OGdm3LK4jU3RB3LMh3JLDXn/J1oHSOSHB0JW0WGPMQABjSD
         FKagyBYl1pnE71zIoaZKwAZQX96xFrHVC5Y9AyWkcgviDuZ/DKVjDOlEUG3mweHq5juP
         Hi7irfK+nGMayuVOCFdOPazW+gp4jIGQN6W6L1eZkVmgGVhzaxyaXsJJkrqsieixJwFR
         apWA==
X-Gm-Message-State: AOAM531745BwwCvLFOayGyuLPYqNqXN6p+wguVLdqlR47DHYKbwfEQKw
        tKDq8LEo1YVEcEphtOh/wjl3GXMcLR7V5xa0+Hnc6w==
X-Google-Smtp-Source: ABdhPJxO78gga38eOSSGkRb7JR3LPL4ca3GN3Kg63kSbnkYrOAUmk+vpnbWzVH0WjGPGdqNPQJZhFiJatpAuCeF1xyw=
X-Received: by 2002:a17:90b:947:: with SMTP id dw7mr5682193pjb.178.1616624496196;
 Wed, 24 Mar 2021 15:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210316041645.144249-1-arjunroy.kdev@gmail.com>
 <YFCH8vzFGmfFRCvV@cmpxchg.org> <CAOFY-A23NBpJQ=mVQuvFib+cREAZ_wC5=FOMzv3YCO69E4qRxw@mail.gmail.com>
 <YFJ+5+NBOBiUbGWS@cmpxchg.org> <CAOFY-A17g-Aq_TsSX8=mD7ZaSAqx3gzUuCJT8K0xwrSuYdP4Kw@mail.gmail.com>
 <YFoe8BO0JsbXTHHF@cmpxchg.org> <CAOFY-A2dfWS91b10R9Pu-5T-uT2qF9h9Lm8GaJfV9shfjP4Wbg@mail.gmail.com>
 <CALvZod527EgYmkqWdoLCARj2BD2=YWVCC9Dk87gfQRG8NViX_A@mail.gmail.com>
In-Reply-To: <CALvZod527EgYmkqWdoLCARj2BD2=YWVCC9Dk87gfQRG8NViX_A@mail.gmail.com>
From:   Arjun Roy <arjunroy@google.com>
Date:   Wed, 24 Mar 2021 15:21:25 -0700
Message-ID: <CAOFY-A0GtpeFUrp+eK1__pOm=gkp3ahNXXkm6rztrz_O2FFfeQ@mail.gmail.com>
Subject: Re: [mm, net-next v2] mm: net: memcg accounting for TCP rx zerocopy
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Arjun Roy <arjunroy.kdev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 11:26 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Tue, Mar 23, 2021 at 11:42 AM Arjun Roy <arjunroy@google.com> wrote:
> >
> [...]
> >
> > To summarize then, it seems to me that we're on the same page now.
> > I'll put together a tentative v3 such that:
> > 1. It uses pre-charging, as previously discussed.
> > 2. It uses a page flag to delineate pages of a certain networking sort
> > (ie. this mechanism).
> > 3. It avails itself of up to 4 words of data inside struct page,
> > inside the networking specific struct.
> > 4. And it sets up this opt-in lifecycle notification for drivers that
> > choose to use it, falling back to existing behaviour without.
> >
>
> Arjun, if you don't mind, can you explain how the lifetime of such a
> page will look like?
>
> For example:
>
> Driver:
> page = dev_alloc_page()
> /* page has 1 ref */

Yes, this is the case.

> dev_map_page(page)
> /* I don't think dev_map_page() takes a ref on page, so the ref remains 1. */
>

To be clear, do you mean things like DMA setup here? Or specifically
what do you mean by dev_map_page?

> On incoming traffic the page goes to skb and which then gets assigned
> to a struct sock. Does the kernel increase refcnt of the page on these
> operations?
>

Adding a page to an skb will mean that, when the skb is cleaned up, a
page ref is dropped:
https://github.com/torvalds/linux/blob/master/net/core/skbuff.c#L666

So a driver may bump the refcount for the page, before adding it to the skb:
https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c#L442


> The page gets mapped into user space which increments its refcnt.
>
Yes.

> After processing the data, the application unmaps the page and its
> refcnt will be decremented.
>
Yes.


> __put_page() will be called when refcnt reaches 0, so, the initial
> refcnt which the driver has acquired, has to be transferred to the
> next layer. So, I am trying to understand how that will work?

Ah, I see - there was a miscommunication. Johannes mentioned
__put_page() but I read put_page().
That is where I was planning on adding the interposition for these
network pages.

So in put_page(), if it turns out it's a network page, we do our
handling then as I described in prior emails. Sorry for the confusion.

Thanks,
-Arjun
