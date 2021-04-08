Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64253357AEF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 05:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhDHDyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 23:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhDHDyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 23:54:06 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65FEC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 20:53:55 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id z9so613775ilb.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 20:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2W7012bsIfpRy+MP9eZql6DB7ScoxohiHSmP5niLDlE=;
        b=ciN+HMG0IjEpS0j9JpuVYLetEtRmmzUYWqlcPKsKvlQSwwOZKulO6xvWMgmkBdKKHR
         dQZOSQC99RJxUGh+qCCFFvF42MQb95PWYbYrOs/Ql8pNYJBDIjbU0LODxO8o0sM070Qk
         tsv8Ypabqkz+j9zB3BqRiLAnfOmOYkU07v6zmUkYo2f8YOTgDh/CBjMFO7Y7zeymY2sN
         0XwCOx5FuGjpmQbU+mql4LlrQ+mcFA/mc41H2wD7MimNm8rr290VgDczN216c60AcC1U
         T9RNH2pFOG7UuRpfgbLX9t6DPS3D8hoKJ5rMVNp426pxCkbZqHwuvKksUc5X9zaY0Jli
         CfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2W7012bsIfpRy+MP9eZql6DB7ScoxohiHSmP5niLDlE=;
        b=uaMfcUyMr2GEzPcGqETP3Ve8nDdUFb8mYlae5Wl2WDPHzDpv4kZzjrj8ghQdABtCGw
         Qs/JCTbBC2TLTxlVXqndsWJzEiLXYNGrmvorg/DECjn1G+YhTGark/xe506sngJVilMw
         PTnLee8ZIvQlOJlwD7eVozsSa0MUna37hYDjIREeMx5/Lt3AHL5qE7lYje8IRoyJEClK
         dzxLu8AePrx0+eLEbLHruyZXcmwc5Q0+wsHkX00fxb/9/qFkITOH/geWpcOlwHxFACxr
         EbAPmqkpr22SUo5csyJFwK8Rl1ys6xrIeSfafTQwlHPq6BGrBSOPe/xqpsAOzmgHSPjX
         qxvw==
X-Gm-Message-State: AOAM530jOGaGOyHjAqEY58H0dbXddS95axLkZTfv+V3h/xnAeD0krkCz
        zDXt8eMA63ZNNBo2sNefoZ368OBmXOjsXLpSntsnZw==
X-Google-Smtp-Source: ABdhPJx//CkLH61Xww8j3pQhhGFZ0Z/pvJq9S3j4VGvVBlyYQOY64PQR0KUIq7YPJnKRcK4hQjw+ZlacPbmdLQlap9Y=
X-Received: by 2002:a05:6e02:1546:: with SMTP id j6mr4969555ilu.299.1617854034862;
 Wed, 07 Apr 2021 20:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210408131117.7f2f3a29@canb.auug.org.au>
In-Reply-To: <20210408131117.7f2f3a29@canb.auug.org.au>
From:   "Cong Wang ." <cong.wang@bytedance.com>
Date:   Wed, 7 Apr 2021 20:53:44 -0700
Message-ID: <CAA68J_ahKn3eD+QxYDUkJvLCbOzY13isBgLtwwSUwBw=S8YusA@mail.gmail.com>
Subject: Re: [External] linux-next: manual merge of the net-next tree with the
 bpf tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 8:11 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the net-next tree got a conflict in:
>
>   net/core/skmsg.c
>
> between commit:
>
>   144748eb0c44 ("bpf, sockmap: Fix incorrect fwd_alloc accounting")
>
> from the bpf tree and commit:
>
>   e3526bb92a20 ("skmsg: Move sk_redir from TCP_SKB_CB to skb")
>
> from the net-next tree.
>
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Looks good from my quick glance.

Thanks!
