Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6899B3FDE9A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343743AbhIAP0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:26:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343727AbhIAP0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630509926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LbMtRgNEu6wcJvmOGHgsCvmtkF0iMKnVXOQQbGFWdA4=;
        b=QVe6yq0aDpPoW/Y5jO7BRXKW2/3GxADiui73yy5axSj9DD6h3E0mrZ8Jm/2vxf3jUGKp9t
        vGDwl+eAuxPeM9wiKic8p3wvvgbl+67fgYuhCETkstklhN7PSArj6MMKpYlCxMleWne94s
        EcLQ4RzeDH6oNUPayDEi2K2XIagB5fE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-3S5nLfbJMTurvkpA5qSQbw-1; Wed, 01 Sep 2021 11:25:25 -0400
X-MC-Unique: 3S5nLfbJMTurvkpA5qSQbw-1
Received: by mail-wr1-f72.google.com with SMTP id b8-20020a5d5508000000b001574e8e9237so9699wrv.16
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 08:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LbMtRgNEu6wcJvmOGHgsCvmtkF0iMKnVXOQQbGFWdA4=;
        b=Rj3sWx9LLsjTRT4UhwKI+pu2CdxaPbjsnt4LKWhmrDsBdvKR6usey4Cm71r8bQapaI
         NBTNfbYxvlW1ZUtG9OBGUi5Xx+fyQNKMU7bfQr1zIRwoAuifcYCc3G8OAAHqh5Mmx5Bf
         YWv1dzPuQGDYkraSI7SDlhNjH9bwKgisAG6yz2fB0yxG64GsO3WzP6kVZ+gCQJ0GJSaZ
         U3qczN2o4l6q7X2CwTa9s50JJSHgYIsLhiwZ9OSlIMWMYeAD0aokWmUHpcs1RMIc8VF2
         zes0mClsae4yiRTVT1kLpIwTM4C1AUQJ1O0kKHd7udGHRaDvJ/XW9zlKS5rWX1+XYPs7
         Xy/Q==
X-Gm-Message-State: AOAM530WhU+GAt5uaY640hee4d6z9VhT3q9xzERNZmNE4zWfZqsnuCsd
        Sy6Hk1QUgBeTd+GMcrJ/kFkpPdffpwYNk5HYkCr3YywiCPAHwlmU7buBMoNpfbjkrDW9UGqcXsL
        VeqgVEMrZdRbeO3Y4DeoQm5du
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr38465532wrx.262.1630509922866;
        Wed, 01 Sep 2021 08:25:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyd4lpd2AFvfgLjXE3GXlhFsPaJTwhhsrpD9tqcy+NNG37vP3+MuiRQrfhe3pXFPQZ2sZQYjw==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr38465493wrx.262.1630509922597;
        Wed, 01 Sep 2021 08:25:22 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id b12sm25212322wrx.72.2021.09.01.08.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 08:25:22 -0700 (PDT)
Message-ID: <c40a178110ee705b2be32272b9b3e512a40a4cae.camel@redhat.com>
Subject: Re: [PATCH net-next] tcp: add tcp_tx_skb_cache_key checking in
 sk_stream_alloc_skb()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        MPTCP Upstream <mptcp@lists.linux.dev>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linuxarm@openeuler.org,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>
Date:   Wed, 01 Sep 2021 17:25:21 +0200
In-Reply-To: <CANn89iKbgtb84Lb4UOxUCb_WGrfB6ZoD=bVH2O06-Mm6FBmwpg@mail.gmail.com>
References: <1630492744-60396-1-git-send-email-linyunsheng@huawei.com>
         <9c9ef2228dfcb950b5c75382bd421c6169e547a0.camel@redhat.com>
         <CANn89iJFeM=DgcQpDbaE38uhxTEL6REMWPnVFt7Am7Nuf4wpMw@mail.gmail.com>
         <CANn89iKbgtb84Lb4UOxUCb_WGrfB6ZoD=bVH2O06-Mm6FBmwpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-01 at 08:16 -0700, Eric Dumazet wrote:
> On Wed, Sep 1, 2021 at 8:06 AM Eric Dumazet <edumazet@google.com> wrote:
> > On Wed, Sep 1, 2021 at 3:52 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > > On Wed, 2021-09-01 at 18:39 +0800, Yunsheng Lin wrote:
> > > > Since tcp_tx_skb_cache is disabled by default in:
> > > > commit 0b7d7f6b2208 ("tcp: add tcp_tx_skb_cache sysctl")
> > > > 
> > > > Add tcp_tx_skb_cache_key checking in sk_stream_alloc_skb() to
> > > > avoid possible branch-misses.
> > > > 
> > > > Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> > > 
> > > Note that MPTCP is currently exploiting sk->sk_tx_skb_cache. If we get
> > > this patch goes in as-is, it will break mptcp.
> > > 
> > > One possible solution would be to let mptcp usage enable sk-
> > > > sk_tx_skb_cache, but that has relevant side effects on plain TCP.
> > > 
> > > Another options would be re-work once again the mptcp xmit path to
> > > avoid using sk->sk_tx_skb_cache.
> > > 
> > 
> > Hmmm, I actually wrote a revert of this feature but forgot to submit
> > it last year.
> > 
> > commit c36cfbd791f62c0f7c6b32132af59dfdbe6be21b (HEAD -> listener_scale4)
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Wed May 20 06:38:38 2020 -0700
> > 
> >     tcp: remove sk_{tr}x_skb_cache
> > 
> >     This reverts the following patches :
> > 
> >     2e05fcae83c41eb2df10558338dc600dc783af47 ("tcp: fix compile error
> > if !CONFIG_SYSCTL")
> >     4f661542a40217713f2cee0bb6678fbb30d9d367 ("tcp: fix zerocopy and
> > notsent_lowat issues")
> >     472c2e07eef045145bc1493cc94a01c87140780a ("tcp: add one skb cache for tx")
> >     8b27dae5a2e89a61c46c6dbc76c040c0e6d0ed4c ("tcp: add one skb cache for rx")
> > 
> >     Having a cache of one skb (in each direction) per TCP socket is fragile,
> >     since it can cause a significant increase of memory needs,
> >     and not good enough for high speed flows anyway where more than one skb
> >     is needed.
> > 
> >     We want instead to add a generic infrastructure, with more flexible per-cpu
> >     caches, for alien NUMA nodes.
> > 
> >     Signed-off-by: Eric Dumazet <edumazet@google.com>
> > 
> > I will update this commit to also remove the part in MPTCP.
> > 
> > Let's remove this feature and replace it with something less costly.
> 
> Paolo, can you work on MPTP side, so that my revert can be then applied ?

You are way too fast, I was still replying to your previous email,
asking if I could help :)

I'll a look ASAP. Please, allow for some latency: I'm way slower!

Cheers,

Paolo

