Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A833BC329
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 21:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhGETel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 15:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229686AbhGETej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 15:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625513522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P1DGi1LYTetqRgGfrPBWbaHvRrr0YN5Yef/t3KqwiuQ=;
        b=eHJbahAdPZD1rubVh3NgPqDc/YSiBa5iSfP87ZpZcJScVGuembInLUHOQ/LJhI9k/OtCX1
        MS6fMGMi7QFEsP2Bka6HxkciSXTBkPfAT7DQa/za/te/ALRWykP9xwmDy9Hili2TQHgD7j
        1fvfalADJ+2Uif+v5HopIBQNL6mEpqA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-xKv5I0K_NeOP53hkwUqGVQ-1; Mon, 05 Jul 2021 15:32:01 -0400
X-MC-Unique: xKv5I0K_NeOP53hkwUqGVQ-1
Received: by mail-wr1-f70.google.com with SMTP id u13-20020a5d6dad0000b029012e76845945so4456827wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 12:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P1DGi1LYTetqRgGfrPBWbaHvRrr0YN5Yef/t3KqwiuQ=;
        b=sd+/zCxa1YValN+R/NpiObqogQNRwbK+sUT7Imjwno+zt796L4sy6lcHcKzumH3ePa
         MtVAgwEFNQ7fMffjq6FrE1DhYnQCRYXmCNKEspsCVlyL19ZRw+kVY/K77rqAhoM+lDcz
         a24HHGEAi2X0R49dLzeUv2hy4X+tl8irzZX2lH+1ER/XhYSkat4LGtYrYSNRk7Vw5+5G
         sIVFUw+MYed4dLJj0WiJ0Aa0JPR6Lu75TfaiA8IHPtr0I49WkepdT/NdVxilvZoUwEXq
         onNq554hV49DTCvQNqKO7Vb3uL4iIknRFV9yjGzufj3ol/hVvb8T1AZ8TNQ9O9zkpN1C
         l5yg==
X-Gm-Message-State: AOAM532ul6ytYgprqsFadyzSWlM3Hvka7UBsUSwrqYAgtma2K3MWD9WE
        RMJbzaKspyJVOCbPtuF/MNTxHe/HmbH36r5R6bwdrF0Jp3TmTUmc+XEpl7l1mhVMh3ymIqAtnXa
        woSddAjv8VoqKM/jXH7klTdSd
X-Received: by 2002:a7b:cd99:: with SMTP id y25mr640109wmj.184.1625513519966;
        Mon, 05 Jul 2021 12:31:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoXJHOhyGhZ5PgYHKytoExQiMUYlio0qV1cM880wrFo1XDIN/RZvxU08JaKEUvcuuxPrKiuA==
X-Received: by 2002:a7b:cd99:: with SMTP id y25mr640099wmj.184.1625513519797;
        Mon, 05 Jul 2021 12:31:59 -0700 (PDT)
Received: from redhat.com ([2.55.8.91])
        by smtp.gmail.com with ESMTPSA id x4sm403853wmi.22.2021.07.05.12.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 12:31:59 -0700 (PDT)
Date:   Mon, 5 Jul 2021 15:31:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, ndesaulniers@gooogle.com,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 0/2] refactor the ringtest testing for ptr_ring
Message-ID: <20210705153047-mutt-send-email-mst@kernel.org>
References: <1625457455-4667-1-git-send-email-linyunsheng@huawei.com>
 <YOLXTB6VxtLBmsuC@smile.fi.intel.com>
 <c6844e2b-530f-14b2-0ec3-d47574135571@huawei.com>
 <20210705142555-mutt-send-email-mst@kernel.org>
 <YONRKnDzCzSAXptx@smile.fi.intel.com>
 <20210705143952-mutt-send-email-mst@kernel.org>
 <CAHp75VcsUxOqu48E1+RNqn=RhJqfd7XG8e3AKRHyMb3ywzSPrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcsUxOqu48E1+RNqn=RhJqfd7XG8e3AKRHyMb3ywzSPrg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 10:05:30PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 5, 2021 at 9:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jul 05, 2021 at 09:36:26PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jul 05, 2021 at 02:26:32PM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Jul 05, 2021 at 08:06:50PM +0800, Yunsheng Lin wrote:
> > > > > On 2021/7/5 17:56, Andy Shevchenko wrote:
> > > > > > On Mon, Jul 05, 2021 at 11:57:33AM +0800, Yunsheng Lin wrote:
> > > > > >> tools/include/* have a lot of abstract layer for building
> > > > > >> kernel code from userspace, so reuse or add the abstract
> > > > > >> layer in tools/include/ to build the ptr_ring for ringtest
> > > > > >> testing.
> > > > > >
> > > > > > ...
> > > > > >
> > > > > >>  create mode 100644 tools/include/asm/cache.h
> > > > > >>  create mode 100644 tools/include/asm/processor.h
> > > > > >>  create mode 100644 tools/include/generated/autoconf.h
> > > > > >>  create mode 100644 tools/include/linux/align.h
> > > > > >>  create mode 100644 tools/include/linux/cache.h
> > > > > >>  create mode 100644 tools/include/linux/slab.h
> > > > > >
> > > > > > Maybe somebody can change this to be able to include in-tree headers directly?
> > > > >
> > > > > If the above works, maybe the files in tools/include/* is not
> > > > > necessary any more, just use the in-tree headers to compile
> > > > > the user space app?
> > > > >
> > > > > Or I missed something here?
> > > >
> > > > why would it work? kernel headers outside of uapi are not
> > > > intended to be consumed by userspace.
> > >
> > > The problem here, that we are almost getting two copies of the headers, and
> > > tools are not in a good maintenance, so it's often desynchronized from the
> > > actual Linux headers. This will become more and more diverse if we keep same
> > > way of operation. So, I would rather NAK any new copies of the headers from
> > > include/ to tools/include.
> >
> > We already have the copies
> > yes they are not maintained well ... what's the plan then?
> > NAK won't help us improve the situation.
> 
> I understand and the proposal is to leave only the files which are not
> the same (can we do kinda wrappers or so in tools/include rather than
> copying everything?).

I have no idea how we'd do all this. When I did tools/virtio I already
tried to minimize copying. Want to try to do better?

> > I would say copies are kind of okay just make sure they are
> > built with kconfig. Then any breakage will be
> > detected.
> >
> > > > > > Besides above, had you tested this with `make O=...`?
> > > > >
> > > > > You are right, the generated/autoconf.h is in another directory
> > > > > with `make O=...`.
> > > > >
> > > > > Any nice idea to fix the above problem?
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko

