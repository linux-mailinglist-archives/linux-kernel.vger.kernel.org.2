Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BA835DF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 14:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbhDMM5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53214 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231834AbhDMM5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618318642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CGdwfriCpxNBhbPG+KcQagWdq9VjocpFCOeQG5SkOJI=;
        b=YMc3BcMlPgv22SXuzuZR4h/isNtFp6Ci7tfNPCpmEU16BGwQufeCx6cNfD71G/adxVJnMT
        m5z/FVJaadhl9RL2jWh3SPs787s2AClpfV0UgkyvSY0K+eNC7+V59dbRuYN3+JOcVi2zBB
        2dGPz7Vp1gPkFaTxhvbqvgUsdisNm2k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-KgKkdPj5OVKTi62214FQQg-1; Tue, 13 Apr 2021 08:57:21 -0400
X-MC-Unique: KgKkdPj5OVKTi62214FQQg-1
Received: by mail-wm1-f72.google.com with SMTP id u11-20020a05600c00cbb029012a3f52677dso1094204wmm.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 05:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CGdwfriCpxNBhbPG+KcQagWdq9VjocpFCOeQG5SkOJI=;
        b=dNqn0k3sXsC1yv+9Ocw/DWmdaLX/dbHXEbwoyDzZ6xTx8VUgZeCsHUVlMeLy3vYlO/
         pybfiiAhfpwdNEPsUeLS+Nlp/wmhnWpNZEYGoPuSay/qdGzpGhwlIo/Ymjq8WRObK6XU
         3rZyMNd51ivQeCsydL/ygwVmNrBr/EKC/ySVkShue64ZjTpUxHJMxFQAIFIlpeKnbRGX
         4z/7x+VLCMksyZ4v1yh6NvPyHbfi9DRtpVFWNLBb/AUPDpn9fCF0di9O22xk5p339etp
         XZ3OhZT2B7xcVJhJRfGd/7dp8kZ6208jpgY5MMsg05284CkGRGFa0HjIRwhQVw/xYX07
         UPuA==
X-Gm-Message-State: AOAM532kAzTF8p33kNzz/YZLPq7hwOioicejF0c82JP69EqD2fkYaTcC
        Zx2xn2FFgm8JvLrMnsia8kH5UCb85aFNXrGdtXUhH0R1e2UY6b15LYXssgY5WymjSk5K4QLTckY
        wMh5EJ63zsSlil2zoYM7/SvGl
X-Received: by 2002:a1c:7f14:: with SMTP id a20mr4048474wmd.55.1618318639946;
        Tue, 13 Apr 2021 05:57:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyE5bQOiSmUuOjAUNN/pnSM+l0t9DKV+51aOrCFNcJkl/OEg6P21v5nk0OTBdlrQGI0N5ZukQ==
X-Received: by 2002:a1c:7f14:: with SMTP id a20mr4048463wmd.55.1618318639803;
        Tue, 13 Apr 2021 05:57:19 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
        by smtp.gmail.com with ESMTPSA id b1sm20228546wru.90.2021.04.13.05.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 05:57:19 -0700 (PDT)
Date:   Tue, 13 Apr 2021 08:57:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Subject: Re: Linux 5.12-rc7
Message-ID: <20210413085538-mutt-send-email-mst@kernel.org>
References: <CAHk-=wiHGchP=V=a4DbDN+imjGEc=2nvuLQVoeNXNxjpU1T8pg@mail.gmail.com>
 <20210412051445.GA47322@roeck-us.net>
 <CAHk-=whYcwWgSPxuu8FxZ2i_cG7kw82m-Hbj0-67C6dk1Wb0tQ@mail.gmail.com>
 <CANn89iK2aUESa6DSG=Y4Y9tPmPW2weE05AVpxnDbqYwQjFM2Vw@mail.gmail.com>
 <CANn89i+sYS_x8D5hASKNgmc-k3P7B9JGY9mU1aBwhqHuAkwnBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+sYS_x8D5hASKNgmc-k3P7B9JGY9mU1aBwhqHuAkwnBQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 06:47:07PM +0200, Eric Dumazet wrote:
> On Mon, Apr 12, 2021 at 6:31 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Mon, Apr 12, 2021 at 6:28 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Sun, Apr 11, 2021 at 10:14 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> > > > Qemu test results:
> > > >         total: 460 pass: 459 fail: 1
> > > > Failed tests:
> > > >         sh:rts7751r2dplus_defconfig:ata:net,virtio-net:rootfs
> > > >
> > > > The failure bisects to commit 0f6925b3e8da ("virtio_net: Do not pull payload in
> > > > skb->head"). It is a spurious problem - the test passes roughly every other
> > > > time. When the failure is seen, udhcpc fails to get an IP address and aborts
> > > > with SIGTERM. So far I have only seen this with the "sh" architecture.
> > >
> > > Hmm. Let's add in some more of the people involved in that commit, and
> > > also netdev.
> > >
> > > Nothing in there looks like it should have any interaction with
> > > architecture, so that "it happens on sh" sounds odd, but maybe it's
> > > some particular interaction with the qemu environment.
> >
> > Yes, maybe.
> >
> > I spent few hours on this, and suspect a buggy memcpy() implementation
> > on SH, but this was not conclusive.
> >
> > By pulling one extra byte, the problem goes away.
> >
> > Strange thing is that the udhcpc process does not go past sendto().
> 
> This is the patch working around the issue. Unfortunately I was not
> able to root-cause it (I really suspect something on SH)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0824e6999e49957f7aaf7c990f6259792d42f32b..fd890a951beea03bdf24406809042666eb972655
> 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -408,11 +408,17 @@ static struct sk_buff *page_to_skb(struct
> virtnet_info *vi,
> 
>         /* Copy all frame if it fits skb->head, otherwise
>          * we let virtio_net_hdr_to_skb() and GRO pull headers as needed.
> +        *
> +        * Apparently, pulling only the Ethernet Header triggers a bug
> on qemu-system-sh4.
> +        * Since GRO aggregation really cares of IPv4/IPv6, pull 20 bytes
> +        * more to work around this bug : These 20 bytes can not belong
> +        * to UDP/TCP payload.
> +        * As a bonus, this makes GRO slightly faster for IPv4 (one less copy).
>          */

Question: do we still want to do this for performance reasons?
We also have the hdr_len coming from the device which is
just skb_headlen on the host.

>         if (len <= skb_tailroom(skb))
>                 copy = len;
>         else
> -               copy = ETH_HLEN + metasize;
> +               copy = ETH_HLEN + sizeof(struct iphdr) + metasize;
>         skb_put_data(skb, p, copy);
> 
>         if (metasize) {

