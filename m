Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED55343CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCVJ0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:26:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhCVJ0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:26:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD61A60233;
        Mon, 22 Mar 2021 09:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616405174;
        bh=E2bivXSoDRMs7r3zMZVSaMr3GBidjFUkYCkNU0ecnDs=;
        h=In-Reply-To:References:Subject:Cc:From:To:Date:From;
        b=gnV0wWkuwrUy4FWlG4rSqyC7z+OLCTzeqSL7gEv2kIA/p8ycJHV9+S0Dsklnv4QbU
         +SmVeBy8+KaUSfWOnGa+dQXgXZrNm4cyYNmOSRXisLoT+PLM4Zyt8WzubUgBldxEe/
         M/mQdFQh8sPBOkPUbBz+Bkz0+xCC8aoq9Wx73xhNlQrt4JfyAZIXhArxZLTS/RZ5uj
         vjZ3quCo/y393PCXarHrJWBKOQFIJBNpBEZFQfpT2cVBbgFhDc6WaFNz6DyfDAs/T8
         veh/Rx3ad7qNigCXWfVj73lRNZSbXbKv+SRlDG2QCpMWfXn9rhiUjQgw8w1vxXUhUe
         bV8Xid8fmCmQQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210322090536.GK1719932@casper.infradead.org>
References: <20210322083553.GI32426@xsang-OptiPlex-9020> <161640335063.3537.6668586361113979688@kwain.local> <20210322090536.GK1719932@casper.infradead.org>
Subject: Re: [net]  5478fcd0f4: BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h
Cc:     kernel test robot <oliver.sang@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, ltp@lists.linux.it
From:   Antoine Tenart <atenart@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Message-ID: <161640517096.3021.7957377947074787708@kwain.local>
Date:   Mon, 22 Mar 2021 10:26:11 +0100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthew Wilcox (2021-03-22 10:05:36)
> On Mon, Mar 22, 2021 at 09:55:50AM +0100, Antoine Tenart wrote:
> > I only had a quick look at this, but I think the issue should be fixed
> > with:
> >=20
> > diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> > index e16d54aabd4c..3ae3c20eb64c 100644
> > --- a/net/core/net-sysfs.c
> > +++ b/net/core/net-sysfs.c
> > @@ -1378,7 +1378,7 @@ static ssize_t xps_queue_show(struct net_device *=
dev, unsigned int index,
> >         nr_ids =3D dev_maps ? dev_maps->nr_ids :
> >                  (type =3D=3D XPS_CPUS ? nr_cpu_ids : dev->num_rx_queue=
s);
> > =20
> > -       mask =3D bitmap_zalloc(nr_ids, GFP_KERNEL);
> > +       mask =3D bitmap_zalloc(nr_ids, GFP_ATOMIC);
> >         if (!mask) {
> >                 rcu_read_unlock();
> >                 return -ENOMEM;
>=20
> sysfs isn't a good reason to use GFP_ATOMIC.
>=20
> try something like this:
>=20
> -       mask =3D bitmap_zalloc(nr_ids, GFP_KERNEL);
> +       mask =3D bitmap_zalloc(nr_ids, GFP_NOWAIT);
>         if (!mask) {
> +               int new_nr_ids;
> +
>                 rcu_read_unlock();
> -               return -ENOMEM;
> +               mask =3D bitmap_zalloc(nr_ids, GFP_KERNEL);
> +               if (!mask)
> +                       return -ENOMEM;
> +               rcu_read_lock();
> +               dev_maps =3D rcu_dereference(dev->xps_maps[type]);
> +               /* if nr_ids shrank while we slept, do not overrun array.
> +                * if it increased, we just won't show the new ones
> +                */
> +               new_nr_ids =3D dev_maps ? dev_maps->nr_ids :
> +                       (type =3D=3D XPS_CPUS ? nr_cpu_ids : dev->num_rx_=
queues);
> +               if (new_nr_ids < nr_ids)
> +                       nr_ids =3D new_nr_ids;

Thanks for the suggestion, I'll look into that. We could also just
return -ENOMEM if the first allocation fails, retrying adds a lot of
complexity.

Antoine
