Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61ECE347303
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbhCXHvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbhCXHun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:50:43 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9D8C0613DC
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 00:50:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id bx7so26482316edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 00:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ucKUL7iMatk7vTisuYcyzNJBOpR+UxZZYm65lQLYZls=;
        b=Ia4rAy6/CRAcazlKVyXoBKI+rOLARYe4Qy5/+rQTfMBPd4MhXiVp4LxLtC9QeE2+1x
         ZTuJbxcAW++8NZSNqis9TovwZ2XsOWsxjKLM2ta8ne9U6CnYYuiIikTdNCxq5plTUlWf
         CfxIlYK5UedW4QSLjQ2VsNdZBHjetmmaZy6kipcTCvXBpxw2wr0SXWer5ow622EnL1si
         +6ykPb9hcwqcWFZDZG2IIItVl7ZRagSyycMax0f2UnV9rFlSlXBh4u79ypgmc8HuJa5J
         aH2j/xYa+tnZAMqf3CgMni5LyE1TcnyurPUVYtwKhut/BYM4f2Gxdi+jemijpZXgRtw3
         yYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ucKUL7iMatk7vTisuYcyzNJBOpR+UxZZYm65lQLYZls=;
        b=Sd8QTeyqwk79/dSjQAmKehmu564bTwEQ0jDakY+0cO/Ppo6BOSK9EYKGCxSVOAyvBx
         NNO2UJnkVly3z6VQM/5+3VPKXuGDaWY3E86qy6uJUxqunb7mJSS/F1cHI4QiiPytBZ5L
         KUOXqBsQYB71vLLLGNNqm1qG7MDqu+3gt8opPmnVCNBabpAVXsOF177pSCiP7p94qiVB
         5dIc77KNItCu99m+aHjym7dZNBuRLIRwAnFWg67MPNcnMb2mVofG/a7UuEAGWXUJSj0c
         BcfBjiL5DBLZa65x0EH3pOZK7LuzHJLVM6WXLbKcz4mgRpIGL5rhOjaqkLG5qX+sCo+n
         QFkA==
X-Gm-Message-State: AOAM5338h/G6Ztn9nckyptv/bggyr41Je82NUuJECIHY2wNC1/nhX5ZC
        8iRNbaSyMYFLUWQNnp65brW5Hw==
X-Google-Smtp-Source: ABdhPJx4XejJFyzFDnQ7Opja2fDfJWvD/ZUx+ym48TZWB6BJSUtNSx1rT6ECiDm63v3y2GtCuVD1WA==
X-Received: by 2002:aa7:cc03:: with SMTP id q3mr2048413edt.366.1616572241765;
        Wed, 24 Mar 2021 00:50:41 -0700 (PDT)
Received: from enceladus (ppp-94-64-113-158.home.otenet.gr. [94.64.113.158])
        by smtp.gmail.com with ESMTPSA id i11sm521296ejf.76.2021.03.24.00.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 00:50:41 -0700 (PDT)
Date:   Wed, 24 Mar 2021 09:50:38 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        David Ahern <dsahern@gmail.com>,
        Saeed Mahameed <saeed@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 0/6] page_pool: recycle buffers
Message-ID: <YFrvTtS8E/C5vYgo@enceladus>
References: <20210322170301.26017-1-mcroce@linux.microsoft.com>
 <20210323154112.131110-1-alobakin@pm.me>
 <YFoNoohTULmcpeCr@enceladus>
 <20210323170447.78d65d05@carbon>
 <YFoTBm0mJ4GyuHb6@enceladus>
 <CAFnufp1K+t76n9shfOZB_scV7myUWCTXbB+yf5sr-8ORYQxCEQ@mail.gmail.com>
 <20210323165523.187134-1-alobakin@pm.me>
 <YFofANKiR3tD9zgm@enceladus>
 <20210323200338.578264-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323200338.578264-1-alobakin@pm.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Tue, Mar 23, 2021 at 08:03:46PM +0000, Alexander Lobakin wrote:
> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Date: Tue, 23 Mar 2021 19:01:52 +0200
> 
> > On Tue, Mar 23, 2021 at 04:55:31PM +0000, Alexander Lobakin wrote:
> > > > > > > >
> >
> > [...]
> >
> > > > > > >
> > > > > > > Thanks for the testing!
> > > > > > > Any chance you can get a perf measurement on this?
> > > > > >
> > > > > > I guess you mean perf-report (--stdio) output, right?
> > > > > >
> > > > >
> > > > > Yea,
> > > > > As hinted below, I am just trying to figure out if on Alexander's platform the
> > > > > cost of syncing, is bigger that free-allocate. I remember one armv7 were that
> > > > > was the case.
> > > > >
> > > > > > > Is DMA syncing taking a substantial amount of your cpu usage?
> > > > > >
> > > > > > (+1 this is an important question)
> > >
> > > Sure, I'll drop perf tools to my test env and share the results,
> > > maybe tomorrow or in a few days.
> 
> Oh we-e-e-ell...
> Looks like I've been fooled by I-cache misses or smth like that.
> That happens sometimes, not only on my machines, and not only on
> MIPS if I'm not mistaken.
> Sorry for confusing you guys.
> 
> I got drastically different numbers after I enabled CONFIG_KALLSYMS +
> CONFIG_PERF_EVENTS for perf tools.
> The only difference in code is that I rebased onto Mel's
> mm-bulk-rebase-v6r4.
> 
> (lunar is my WIP NIC driver)
> 
> 1. 5.12-rc3 baseline:
> 
> TCP: 566 Mbps
> UDP: 615 Mbps
> 
> perf top:
>      4.44%  [lunar]              [k] lunar_rx_poll_page_pool
>      3.56%  [kernel]             [k] r4k_wait_irqoff
>      2.89%  [kernel]             [k] free_unref_page
>      2.57%  [kernel]             [k] dma_map_page_attrs
>      2.32%  [kernel]             [k] get_page_from_freelist
>      2.28%  [lunar]              [k] lunar_start_xmit
>      1.82%  [kernel]             [k] __copy_user
>      1.75%  [kernel]             [k] dev_gro_receive
>      1.52%  [kernel]             [k] cpuidle_enter_state_coupled
>      1.46%  [kernel]             [k] tcp_gro_receive
>      1.35%  [kernel]             [k] __rmemcpy
>      1.33%  [nf_conntrack]       [k] nf_conntrack_tcp_packet
>      1.30%  [kernel]             [k] __dev_queue_xmit
>      1.22%  [kernel]             [k] pfifo_fast_dequeue
>      1.17%  [kernel]             [k] skb_release_data
>      1.17%  [kernel]             [k] skb_segment
> 
> free_unref_page() and get_page_from_freelist() consume a lot.
> 
> 2. 5.12-rc3 + Page Pool recycling by Matteo:
> TCP: 589 Mbps
> UDP: 633 Mbps
> 
> perf top:
>      4.27%  [lunar]              [k] lunar_rx_poll_page_pool
>      2.68%  [lunar]              [k] lunar_start_xmit
>      2.41%  [kernel]             [k] dma_map_page_attrs
>      1.92%  [kernel]             [k] r4k_wait_irqoff
>      1.89%  [kernel]             [k] __copy_user
>      1.62%  [kernel]             [k] dev_gro_receive
>      1.51%  [kernel]             [k] cpuidle_enter_state_coupled
>      1.44%  [kernel]             [k] tcp_gro_receive
>      1.40%  [kernel]             [k] __rmemcpy
>      1.38%  [nf_conntrack]       [k] nf_conntrack_tcp_packet
>      1.37%  [kernel]             [k] free_unref_page
>      1.35%  [kernel]             [k] __dev_queue_xmit
>      1.30%  [kernel]             [k] skb_segment
>      1.28%  [kernel]             [k] get_page_from_freelist
>      1.27%  [kernel]             [k] r4k_dma_cache_inv
> 
> +20 Mbps increase on both TCP and UDP. free_unref_page() and
> get_page_from_freelist() dropped down the list significantly.
> 
> 3. 5.12-rc3 + Page Pool recycling + PP bulk allocator (Mel & Jesper):
> TCP: 596
> UDP: 641
> 
> perf top:
>      4.38%  [lunar]              [k] lunar_rx_poll_page_pool
>      3.34%  [kernel]             [k] r4k_wait_irqoff
>      3.14%  [kernel]             [k] dma_map_page_attrs
>      2.49%  [lunar]              [k] lunar_start_xmit
>      1.85%  [kernel]             [k] dev_gro_receive
>      1.76%  [kernel]             [k] free_unref_page
>      1.76%  [kernel]             [k] __copy_user
>      1.65%  [kernel]             [k] inet_gro_receive
>      1.57%  [kernel]             [k] tcp_gro_receive
>      1.48%  [kernel]             [k] cpuidle_enter_state_coupled
>      1.43%  [nf_conntrack]       [k] nf_conntrack_tcp_packet
>      1.42%  [kernel]             [k] __rmemcpy
>      1.25%  [kernel]             [k] skb_segment
>      1.21%  [kernel]             [k] r4k_dma_cache_inv
> 
> +10 Mbps on top of recycling.
> get_page_from_freelist() is gone.
> NAPI polling, CPU idle cycle (r4k_wait_irqoff) and DMA mapping
> routine became the top consumers.

Again, thanks for the extensive testing. 
I assume you dont use page pool to map the buffers right?
Because if the ampping is preserved the only thing you have to do is sync it
after the packet reception

> 
> 4-5. __always_inline for rmqueue_bulk() and __rmqueue_pcplist(),
> removing 'noinline' from net/core/page_pool.c etc.
> 
> ...makes absolutely no sense anymore.
> I see Mel took Jesper's patch to make __rmqueue_pcplist() inline into
> mm-bulk-rebase-v6r5, not sure if it's really needed now.
> 
> So I'm really glad we sorted out the things and I can see the real
> performance improvements from both recycling and bulk allocations.
> 

Those will probably be even bigger with and io(sm)/mu present

[...]

Cheers
/Ilias
