Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98AB34475F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhCVOd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhCVOdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:33:08 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0579AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:33:08 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id d2so15010408ilm.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/cDRTAC1Vc+ZRykhyHXSrcA5favyfg0y6H7wgohyAQ=;
        b=gDrmLkEXOSWQNDk845SNHYSbKVwMnhfJCAiqRKHj6GIAhmr2f6RqYDrPhypk95aXzF
         gUZzLIQo/CbSNasomeR4f1RHkj9GuuMnvMke7FuxRZnTFlsCwijuue7VtzioqT5pvjUc
         8LkexkLrPYrS304Y3wK8pTSRdZ2+HiNmbPtTzkHtJWB8LOtTp4aIScaiW+hXwkvEG7Kj
         Ui3RBcOK7nBbw1HqdRvRN9RG9iFF2unZT+AOWUSHqMDyseDOnFP4AIdcDicD3vDxGGOI
         DRa05+6dPerE1lBeSMObDtwekYhMmeL8E/Xkw5jHahlH8/kCqzYN1iAsP052Cd3r9uzX
         Uvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/cDRTAC1Vc+ZRykhyHXSrcA5favyfg0y6H7wgohyAQ=;
        b=LiM6q0rG0ITylnoajI3IV5TAw5JkUIVrx2vRJTtrnRkE8iKbwcEVQ+DsQSU3csWBr7
         xCPuy/uGhJsuXHExnPACJ4PP2jvVwQN54dQvnKnFCLJz2mZ7y04txC/GJbWsULoi4OpN
         r79RzeKCLrXPI13fn1vUPTmv9hEVEBejf/L77UqTsFJv10Y1nKqeOItdxudH/BkIZlhn
         0aKBHw8Dc2DD3qCWg7d0j6uLt9esLelAIrc/QGZUqucev3Pz/+nAOkRoB04LpX9Nuc5z
         M4/3pNg6td8NoGCkvIyt+Qd3IflP2bIN52KH2p6WahJWXFbLxQ83HHOKGrWaGzgF2faL
         qHLA==
X-Gm-Message-State: AOAM531ecbrhW44J9OumUxKM51+HQR46beaqyTNHD4/TNUwYqxf4krsB
        4c5d/E1jqlgKduz9PNbVKPRq+dW4gNfHNoaEiJ8=
X-Google-Smtp-Source: ABdhPJzzfiZ/qMRGQpJASxVzwtYpebwPvOmU60CU34jlZ8o1+2sYKqsFR/TDMIRtROiECm4+bDqDmQ7siEEoSJyHzfo=
X-Received: by 2002:a05:6e02:1069:: with SMTP id q9mr241580ilj.97.1616423587457;
 Mon, 22 Mar 2021 07:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210322083553.GI32426@xsang-OptiPlex-9020> <161640335063.3537.6668586361113979688@kwain.local>
 <20210322090536.GK1719932@casper.infradead.org> <161640517096.3021.7957377947074787708@kwain.local>
In-Reply-To: <161640517096.3021.7957377947074787708@kwain.local>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 22 Mar 2021 07:32:56 -0700
Message-ID: <CAKgT0UdKtBU22dwnZmkP8+kjDBRhOZHc9-V3PhfsR+4Tt-N3nA@mail.gmail.com>
Subject: Re: [net] 5478fcd0f4: BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h
To:     Antoine Tenart <atenart@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        kernel test robot <oliver.sang@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 2:26 AM Antoine Tenart <atenart@kernel.org> wrote:
>
> Quoting Matthew Wilcox (2021-03-22 10:05:36)
> > On Mon, Mar 22, 2021 at 09:55:50AM +0100, Antoine Tenart wrote:
> > > I only had a quick look at this, but I think the issue should be fixed
> > > with:
> > >
> > > diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> > > index e16d54aabd4c..3ae3c20eb64c 100644
> > > --- a/net/core/net-sysfs.c
> > > +++ b/net/core/net-sysfs.c
> > > @@ -1378,7 +1378,7 @@ static ssize_t xps_queue_show(struct net_device *dev, unsigned int index,
> > >         nr_ids = dev_maps ? dev_maps->nr_ids :
> > >                  (type == XPS_CPUS ? nr_cpu_ids : dev->num_rx_queues);
> > >
> > > -       mask = bitmap_zalloc(nr_ids, GFP_KERNEL);
> > > +       mask = bitmap_zalloc(nr_ids, GFP_ATOMIC);
> > >         if (!mask) {
> > >                 rcu_read_unlock();
> > >                 return -ENOMEM;
> >
> > sysfs isn't a good reason to use GFP_ATOMIC.
> >
> > try something like this:
> >
> > -       mask = bitmap_zalloc(nr_ids, GFP_KERNEL);
> > +       mask = bitmap_zalloc(nr_ids, GFP_NOWAIT);
> >         if (!mask) {
> > +               int new_nr_ids;
> > +
> >                 rcu_read_unlock();
> > -               return -ENOMEM;
> > +               mask = bitmap_zalloc(nr_ids, GFP_KERNEL);
> > +               if (!mask)
> > +                       return -ENOMEM;
> > +               rcu_read_lock();
> > +               dev_maps = rcu_dereference(dev->xps_maps[type]);
> > +               /* if nr_ids shrank while we slept, do not overrun array.
> > +                * if it increased, we just won't show the new ones
> > +                */
> > +               new_nr_ids = dev_maps ? dev_maps->nr_ids :
> > +                       (type == XPS_CPUS ? nr_cpu_ids : dev->num_rx_queues);
> > +               if (new_nr_ids < nr_ids)
> > +                       nr_ids = new_nr_ids;
>
> Thanks for the suggestion, I'll look into that. We could also just
> return -ENOMEM if the first allocation fails, retrying adds a lot of
> complexity.
>
> Antoine

I agree that the retry logic is probably unneeded. In addition we
probably don't need GFP_ATOMIC as GFP_NOWAIT will probably be good
enough as the allocation can fail and just return an -ENOMEM in the
case of low memory.

Thanks.

- Alex
