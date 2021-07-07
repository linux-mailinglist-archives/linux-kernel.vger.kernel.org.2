Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B753BEC9B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhGGQxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhGGQxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:53:38 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FACDC061764
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 09:50:57 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q16so2609047qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+l8T0NV1W2EFm1dKAG471xyxn7DWyeb0DjrbpB/+e3k=;
        b=FeKmsw2+/cti+7XaCDgvJURDocUATJdLYv3FDD/2Y1khq8vDyglm6gIN1jBFXwBgwB
         oEsuqrSJn0o6PZ8XKKantmakJcS42as18I5GSOfewmfqycZ2tZ483gndigPuq7tThC48
         5WU0Fq9Hktr8c4EVqVIc3H/cWvsOicXQf41e8uUGuymx2Mg8tX9d+W+oIL2wiLSLR9ju
         rOeukSo28QD43WY+hVMr1piMVGhyI3SkWXx/no5+P2IKQNiK83UgnF9Iuo20AovmFKDX
         50dvBf1FoQKCXKQjZCIx1Jq+aI5DzJLa3MJy9crg7qMnSOscw/+RJsJdEA2QB9Zh+H8k
         awTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+l8T0NV1W2EFm1dKAG471xyxn7DWyeb0DjrbpB/+e3k=;
        b=cRHefLsEeJlyEgbIDJciCsAuEwNETDNnKnGdw3+KytzRr1QqC7pPIx3VxbzNk8mktW
         9k0Zs0RH7DvGxFdnDQnrDXK+R4Pfp5qdnScmhBBMtIha0Q/Db2pYv38b1qos3fa7It1Q
         xEl3gHTH2E1ZXvWt3J0Y+UfnBYUnA+PDpDHS3bH6BEE/abXg1Y9xTfZoaeRAlvD46haV
         /FhakSNuJjWr3c/gmrCagsLAFRYQLuZVC7KI6im0idNE8DweVkrQ6DBZnN6D1PD+xMGO
         RwUUjb5DvRq7HAP5LUpaRyHawX5CFRTyLKulmhKzB0IYBkyNUaBWItolnjKn1u37CPsH
         xvtg==
X-Gm-Message-State: AOAM5328dxnzLlpIJghFaTYKjqYFU/ORhzp75FMyvHZWHMzUQiPCCJS1
        GJ0f4EbebZ/8jzbOirGJy8RKq50xW7Jj0ONYVY+b+A==
X-Google-Smtp-Source: ABdhPJz27A76SeAyJWGygXJLAWImPup40+dr2a2Qng83jiPEyrMFJhB2OOcqXf5MT8M+UbL3ZLlBgKHZhBYaKRgrBL4=
X-Received: by 2002:a37:c52:: with SMTP id 79mr18962846qkm.295.1625676656506;
 Wed, 07 Jul 2021 09:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <1625044676-12441-1-git-send-email-linyunsheng@huawei.com>
 <20210702153947.7b44acdf@linux.microsoft.com> <20210706155131.GS22278@shell.armlinux.org.uk>
 <CAFnufp1hM6WRDigAsSfM94yneRhkmxBoGG7NxRUkbfTR2WQvyA@mail.gmail.com>
In-Reply-To: <CAFnufp1hM6WRDigAsSfM94yneRhkmxBoGG7NxRUkbfTR2WQvyA@mail.gmail.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 7 Jul 2021 18:50:49 +0200
Message-ID: <CAPv3WKdQ5jYtMyZuiKshXhLjcf9b+7Dm2Lt2cjE=ATDe+n9A5g@mail.gmail.com>
Subject: Re: [PATCH net-next RFC 0/2] add elevated refcnt support for page pool
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Sven Auhagen <sven.auhagen@voleatech.de>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linuxarm@openeuler.org,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Roman Gushchin <guro@fb.com>, Peter Xu <peterx@redhat.com>,
        feng.tang@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Matteo Croce <mcroce@microsoft.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Willem de Bruijn <willemb@google.com>,
        wenxu <wenxu@ucloud.cn>, Cong Wang <cong.wang@bytedance.com>,
        Kevin Hao <haokexin@gmail.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Marco Elver <elver@google.com>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


=C5=9Br., 7 lip 2021 o 01:20 Matteo Croce <mcroce@linux.microsoft.com> napi=
sa=C5=82(a):
>
> On Tue, Jul 6, 2021 at 5:51 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Fri, Jul 02, 2021 at 03:39:47PM +0200, Matteo Croce wrote:
> > > On Wed, 30 Jun 2021 17:17:54 +0800
> > > Yunsheng Lin <linyunsheng@huawei.com> wrote:
> > >
> > > > This patchset adds elevated refcnt support for page pool
> > > > and enable skb's page frag recycling based on page pool
> > > > in hns3 drvier.
> > > >
> > > > Yunsheng Lin (2):
> > > >   page_pool: add page recycling support based on elevated refcnt
> > > >   net: hns3: support skb's frag page recycling based on page pool
> > > >
> > > >  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  79 +++++++-
> > > >  drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   3 +
> > > >  drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   1 +
> > > >  drivers/net/ethernet/marvell/mvneta.c              |   6 +-
> > > >  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   2 +-
> > > >  include/linux/mm_types.h                           |   2 +-
> > > >  include/linux/skbuff.h                             |   4 +-
> > > >  include/net/page_pool.h                            |  30 ++-
> > > >  net/core/page_pool.c                               | 215
> > > > +++++++++++++++++---- 9 files changed, 285 insertions(+), 57
> > > > deletions(-)
> > > >
> > >
> > > Interesting!
> > > Unfortunately I'll not have access to my macchiatobin anytime soon, c=
an
> > > someone test the impact, if any, on mvpp2?
> >
> > I'll try to test. Please let me know what kind of testing you're
> > looking for (I haven't been following these patches, sorry.)
> >
>
> A drop test or L2 routing will be enough.
> BTW I should have the macchiatobin back on friday.

I have a 10G packet generator connected to 10G ports of CN913x-DB - I
will stress mvpp2 in l2 forwarding early next week (I'm mostly AFK
this until Monday).

Best regards,
Marcin
