Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FCA346345
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhCWPsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbhCWPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:47:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53B9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:47:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b9so21277465wrt.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fYMBj6/IMSxvxgJtHVxG8cOfRV6m9fbE20SeyDsdi6k=;
        b=bgJH9Opvs3jZZ3m8WRWhlSEKivxKX2Z7Vc1VOH8sWpIUZDi2xfPnb0WpriTz1LQ/iU
         9jO8dezYMJgkcbpZkvJqykcPq+vWihlffhn7WqraS4GzSfuPrl9I0czjbIMFAXLnA8sr
         TT+V+2qmPtLzJJF0P2nqAs+74tGXa+OEnZEos4TzgJ7GF735amq9qX2J45yRE6PTB5tk
         EVv4gtlbFoVR6GhzVqMycCaI6luK5Z4/uClP8rVG84ZoM3LgaQmZE6L1HYPHE1UIZQXE
         adVXPyBrLyQSR9wQCMy1AAoAWNcvu2E0M9ukWaMMVNVGECzHo8fHAdg4b3MHBbEdcK8O
         Dx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fYMBj6/IMSxvxgJtHVxG8cOfRV6m9fbE20SeyDsdi6k=;
        b=NXdQd2xRKJ5bLjnl6ra/d9KAlnYlIj9X40JvESoe2j1T1sxkUbobXV3a3ssb/DNEU/
         MXArFx1ng92JS2wLzK2wojzpTQYHg3axhsUN8qW8aa5qf/snkONmZYJ9mKOQGwUSE9vh
         2IpXZiOYynMGIg94qbjB4uljPaGBRYEgT5MmUlLK7+jUXa1SZu5Oet1+WFKX7WHe/fOi
         hG9UlDJP1YChUmmzeIb2vcl6ZNdV2AkpKzzKhVZrLRkYLDkjnWkr2dZg5l5X1UQy8tf6
         GFNCKcp520XMyzNKFmt8JCR4vHD+P+PxTEJvmjVUfqXgtp0e79J7aNfnTaDpzyIiTdrU
         rthg==
X-Gm-Message-State: AOAM533ReI3Gikj7y3rTvCMS5VLWkWT9gjMIC6STFo2ya5LOamCaVRJ0
        jHDU683cX5rtBFdGjQz/LdkLrw==
X-Google-Smtp-Source: ABdhPJx4afetwvLZFDakPri6wWu0W1IIsWXwjBdTnv6yCwF/EckjOAzZ1NtHs1nmGipg1wu9jr6Yxw==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr4811082wrr.161.1616514469526;
        Tue, 23 Mar 2021 08:47:49 -0700 (PDT)
Received: from enceladus (ppp-94-64-113-158.home.otenet.gr. [94.64.113.158])
        by smtp.gmail.com with ESMTPSA id p12sm23860088wrx.28.2021.03.23.08.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 08:47:49 -0700 (PDT)
Date:   Tue, 23 Mar 2021 17:47:46 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        David Ahern <dsahern@gmail.com>,
        Saeed Mahameed <saeed@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 0/6] page_pool: recycle buffers
Message-ID: <YFoNoohTULmcpeCr@enceladus>
References: <20210322170301.26017-1-mcroce@linux.microsoft.com>
 <20210323154112.131110-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323154112.131110-1-alobakin@pm.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 03:41:23PM +0000, Alexander Lobakin wrote:
> From: Matteo Croce <mcroce@linux.microsoft.com>
> Date: Mon, 22 Mar 2021 18:02:55 +0100
> 
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > This series enables recycling of the buffers allocated with the page_pool API.
> > The first two patches are just prerequisite to save space in a struct and
> > avoid recycling pages allocated with other API.
> > Patch 2 was based on a previous idea from Jonathan Lemon.
> >
> > The third one is the real recycling, 4 fixes the compilation of __skb_frag_unref
> > users, and 5,6 enable the recycling on two drivers.
> >
> > In the last two patches I reported the improvement I have with the series.
> >
> > The recycling as is can't be used with drivers like mlx5 which do page split,
> > but this is documented in a comment.
> > In the future, a refcount can be used so to support mlx5 with no changes.
> >
> > Ilias Apalodimas (2):
> >   page_pool: DMA handling and allow to recycles frames via SKB
> >   net: change users of __skb_frag_unref() and add an extra argument
> >
> > Jesper Dangaard Brouer (1):
> >   xdp: reduce size of struct xdp_mem_info
> >
> > Matteo Croce (3):
> >   mm: add a signature in struct page
> >   mvpp2: recycle buffers
> >   mvneta: recycle buffers
> >
> >  .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |  2 +-
> >  drivers/net/ethernet/marvell/mvneta.c         |  4 +-
> >  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 17 +++----
> >  drivers/net/ethernet/marvell/sky2.c           |  2 +-
> >  drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  2 +-
> >  include/linux/mm_types.h                      |  1 +
> >  include/linux/skbuff.h                        | 33 +++++++++++--
> >  include/net/page_pool.h                       | 15 ++++++
> >  include/net/xdp.h                             |  5 +-
> >  net/core/page_pool.c                          | 47 +++++++++++++++++++
> >  net/core/skbuff.c                             | 20 +++++++-
> >  net/core/xdp.c                                | 14 ++++--
> >  net/tls/tls_device.c                          |  2 +-
> >  13 files changed, 138 insertions(+), 26 deletions(-)
> 
> Just for the reference, I've performed some tests on 1G SoC NIC with
> this patchset on, here's direct link: [0]
> 

Thanks for the testing!
Any chance you can get a perf measurement on this?
Is DMA syncing taking a substantial amount of your cpu usage?

Thanks
/Ilias

> > --
> > 2.30.2
> 
> [0] https://lore.kernel.org/netdev/20210323153550.130385-1-alobakin@pm.me
> 
> Thanks,
> Al
> 
