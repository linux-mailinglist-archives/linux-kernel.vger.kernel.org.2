Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA2C3FE507
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhIAVlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344905AbhIAVlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:41:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D071C061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 14:40:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id x11so2388342ejv.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8R5nb1aeTJ3ns8dBCSRYtGDb21lrE9rr+79sQCQT80=;
        b=lceJUcTDFESBP3oN2FuTdNO5BP1gJaIGCWNaz9fEMs0L8lMoXCVbTnJyEwEJs6ic57
         yEJ65qmZXvZHGoFDjHNtcOA1VrcqwVCNg/njVRBwoLmg8yGQtGc6W7e7KgaKuiz87hgj
         sB7Wce70kR4SmBWKusaLfsjgROIXHWIQKRgSLZYB1kYG6yl0zdYXNydgiVaoLJZk7xXS
         PrT6bRapPF97P5XNoB//HYGu5A6ciTd3yGusZtL8IyjHVf/Kple/Hy3BgUvcv+a0xH95
         kThesPR2ygaY3ZRji1F0bfYDFQHnoHX6api6tGy0z5QqwYteeqbctiVcbXxoq0qzqwu/
         mwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8R5nb1aeTJ3ns8dBCSRYtGDb21lrE9rr+79sQCQT80=;
        b=B90zMMzLNdrPbhcasy72fkefg//6EdeDGa4p0WI/2HsnqKR4mq0VpvrtXvUgh10Ft/
         k/GUgyY7tmiGr89RsOTEUbyk4P3pi4QL5zsS4f455eCPPMH1xklSJeWkGh7XDj8QQeWy
         ApMP8xVlMwV1K3ktwbdWEGG/cwxRsy0H5mNj+J+0cDB0Ki4ppUcZWBKcXXSNqsYqYgwc
         gblH686EZwfV7lLvtVlsV5sIlxhdGJHPIuzEwHUjwGIbUx6zg4Y2mG8ulBQeT3w2W3n+
         ocUHo16p7+1RzUFOCXJ802ceDkjgokVxV6BzXxoDiN3JY3S+N3dskB2n2rgsGFI5Lrw/
         VeXQ==
X-Gm-Message-State: AOAM531hLgLlfk74aO7FAx6pYgmfNNyCC2/t9pF4S1O/TyGJpPxti0eD
        1fXwZ9hgLm8p/bNvElB1LA2EVjKJ40BaBw==
X-Google-Smtp-Source: ABdhPJzQD2VWIxRDMOMBY+UY8+s9B/WNmkcX43imYYBssxJlEh0RAKFuQJkFD39fRfyjg/Xt7x5a5g==
X-Received: by 2002:a17:906:144e:: with SMTP id q14mr1745649ejc.19.1630532424619;
        Wed, 01 Sep 2021 14:40:24 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id e19sm423712eja.48.2021.09.01.14.40.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 14:40:23 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id o39-20020a05600c512700b002e74638b567so649155wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:40:23 -0700 (PDT)
X-Received: by 2002:a1c:2bc6:: with SMTP id r189mr1380207wmr.183.1630532422682;
 Wed, 01 Sep 2021 14:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210819100447.00201b26@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210821071425.512834-1-chouhan.shreyansh630@gmail.com> <CA+FuTSeWY-0+VtERqAxNwmHAwmarYh_HQUoF3b0wHiwAaL+h+A@mail.gmail.com>
 <YS9puVgl/exGgrr3@shredder> <CA+FuTSfTCufYmJg5Vum1Q-ndUYh+1P1hLecFht9Qd1-AdnHmaQ@mail.gmail.com>
 <YS+h/tqCJJiQei+W@shredder>
In-Reply-To: <YS+h/tqCJJiQei+W@shredder>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 1 Sep 2021 17:39:45 -0400
X-Gmail-Original-Message-ID: <CA+FuTScx8cCQEOqsmj1eazMkRPqfb-EaqrqH+kmS_sKCFfr7kg@mail.gmail.com>
Message-ID: <CA+FuTScx8cCQEOqsmj1eazMkRPqfb-EaqrqH+kmS_sKCFfr7kg@mail.gmail.com>
Subject: Re: [PATCH 1/2 net] ip_gre: add validation for csum_start
To:     Ido Schimmel <idosch@idosch.org>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>,
        davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, pshelar@nicira.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+ff8e1b9f2f36481e2efc@syzkaller.appspotmail.com,
        Edward Cree <ecree@solarflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 11:53 AM Ido Schimmel <idosch@idosch.org> wrote:
>
> Thanks for the quick reply, Willem.
>
> On Wed, Sep 01, 2021 at 09:46:48AM -0400, Willem de Bruijn wrote:
> > Thanks for the detailed report, Ido.
> >
> > This is a gre tunnel device with csum/ocsum enabled, correct?
>
> Correct.
>
> >
> > How was this packet generated: does it come from the local stack or is
> > it a custom packet injected from userspace, e.g., with a packet socket
> > with vnet_hdr?
>
> The packet is received by a physical port and injected to the kernel's
> Rx path by mlxsw (which does not support checksumming). The IPv4 routing
> code then forwards the packet to the GRE tunnel.
>
> I was able to reproduce the issue using veth pairs and a packet socket
> [1]. Running the reproducer with the debug patch from before, I get the
> following output [2].

Thanks for that device independent repro.

As expected, the following fixes it for these packets:

-       if (csum && skb_checksum_start(skb) < skb->data)
+       if (csum && skb->ip_summed == CHECKSUM_PARTIAL &&
+           skb_checksum_start(skb) < skb->data)

The question is whether we're doing the right thing when CHECKSUM_PARTIAL
is set.

Local checksum offload allows for cheap calculation of outer checksums, by
relying on the fact that the inner packet with the checksum field filled in will
sum to zero. It relies on checksum offload to compute this inner checksum,
so expects csum_start and csum_off to point after the GRE header.

If so, then the existing fix won't break correctly configured skbs as it only
drops packets for which this does not hold.
