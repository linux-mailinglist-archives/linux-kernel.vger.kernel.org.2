Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931FD3809C8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbhENMm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbhENMm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:42:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E18BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:41:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h16so159552edr.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nHv2uj1+b6Ls/HccEvEXRYAb530bVVnX88BdEJ3onyc=;
        b=JlbCbr+YSBBjvbbbmMPif0StXP8x9Sxq9ELa6SgM1G0kYcX/aIh4JSE6TkY1gvFPZC
         oPISoTLPEx5aGEjpM+0bT0wKgwoB3HbE0vAcOj8RK2WFaInrRRWm/u5MorFhdML5hbNG
         746ZpknFLLN8aghQRMLmsdXwSaBNImQxakLzLtlqPJVERgHXcndGg4SOXwNQYsDlRi2g
         wHH1XtlRo99XtFWmsCiA5ApAAAgdM0sOT1s7vJR7bJMMvU+5nhh+oA5Q1PdNRUz05/mT
         7TlOTQRLY8OsQBfvRG6JH3jbd0GiLN+sZWK/aUoPMgMZdgRj7mp639G32eFGVPj4DjKf
         lOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHv2uj1+b6Ls/HccEvEXRYAb530bVVnX88BdEJ3onyc=;
        b=n7CQQfjPthJ4GTMDiaLlgzPFS9jdOYoWEFttkAs8BgG3RypCtu7Ib7+cKi1XxSUSmw
         kzCSPder53AbCs2wAKNYiRc9B89SS7mcEMB3k91A1LpLDm2+cExSUgs4HIgwp3VMfhON
         NOz+DXVFp0RxDR0z/tO5OI+ah/70nb6e9rjMBMW7EY5tqnNmSEB9Y4Bd1/WBeX0VQQrz
         7rwrdP8CoPXKQvFAZaiI2eFoJ2IxVhhscsC6vR7xJ8JJg+Nspj7IOcHNVxtJ6BM+ejTF
         hY1P6vIHtd5fj2TgfynOyl6PrFUUaun8/ptuKfqnO5ZlNXJct210lGFJ/8XEBh0/jwdC
         E/mA==
X-Gm-Message-State: AOAM533RlCHoPAqMlxKjCupnuIu0NoMRnulNNgPsDRAT/80mdap3D7jL
        NtuXLo/5PMy/Vn6NH+mad1a7YTPpFDOg/Q==
X-Google-Smtp-Source: ABdhPJzX92HxiRtLQqO91htA4a/xe/qwh8KAoyso2eu4DTYPldOqqyYfnlW7z3gLAiwuWs76MtLlAA==
X-Received: by 2002:a05:6402:1a48:: with SMTP id bf8mr15789385edb.150.1620996105608;
        Fri, 14 May 2021 05:41:45 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id t2sm1651263edd.58.2021.05.14.05.41.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 05:41:43 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id s8so29932648wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:41:43 -0700 (PDT)
X-Received: by 2002:a5d:64cf:: with SMTP id f15mr56760401wri.327.1620996102914;
 Fri, 14 May 2021 05:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-5-yuri.benditovich@daynix.com> <eb8c4984-f0cc-74ee-537f-fc60deaaaa73@redhat.com>
 <CAOEp5OdrCDPx4ijLcEOm=Wxma6hc=nyqw4Xm6bggBxvgtR0tbg@mail.gmail.com>
 <89759261-3a72-df6c-7a81-b7a48abfad44@redhat.com> <CAOEp5Ocm9Q69Fv=oeyCs01F9J4nCTPiOPpw9_BRZ0WnF+LtEFQ@mail.gmail.com>
 <CACGkMEsZBCzV+d_eLj1aYT+pkS5m1QAy7q8rUkNsdV0C8aL8tQ@mail.gmail.com>
 <CAOEp5OeSankfA6urXLW_fquSMrZ+WYXDtKNacort1UwR=WgxqA@mail.gmail.com>
 <CACGkMEt3bZrdqbWtWjSkXvv5v8iCHiN8hkD3T602RZnb6nPd9A@mail.gmail.com>
 <CAOEp5Odw=eaQWZCXr+U8PipPtO1Avjw-t3gEdKyvNYxuNa5TfQ@mail.gmail.com>
 <CACGkMEuqXaJxGqC+CLoq7k4XDu+W3E3Kk3WvG-D6tnn2K4ZPNA@mail.gmail.com>
 <CAOEp5OfB62SQzxMj_GkVD4EM=Z+xf43TPoTZwMbPPa3BsX2ooA@mail.gmail.com>
 <CACGkMEu4NdyMoFKbyUGG1aGX+K=ShMZuVuMKYPauEBYz5pxYzA@mail.gmail.com>
 <CA+FuTScV+AJ+O3shOMLjUcy+PjBE8uWqCNt0FXWnq9L3gzrvaw@mail.gmail.com>
 <CACGkMEuUF1vDNWbL9dRr1ZM4vFTLwc3j9uB-66451U1NvQ+2EA@mail.gmail.com> <CAOEp5OcozfSWszTm9VArOAH+wm2Fo8tH1QJDsLPZD8ieBLtg-g@mail.gmail.com>
In-Reply-To: <CAOEp5OcozfSWszTm9VArOAH+wm2Fo8tH1QJDsLPZD8ieBLtg-g@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 14 May 2021 08:41:06 -0400
X-Gmail-Original-Message-ID: <CA+FuTSeqzN0SPKNEyD=ZntYb6q4u0u_p=VsPfux4mFpPBZzCxQ@mail.gmail.com>
Message-ID: <CA+FuTSeqzN0SPKNEyD=ZntYb6q4u0u_p=VsPfux4mFpPBZzCxQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] tun: indicate support for USO feature
To:     Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>,
        davem <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        mst <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 3:39 AM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> On Fri, May 14, 2021 at 10:16 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Fri, May 14, 2021 at 4:35 AM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > > > But surprisingly when TUN receives TUN_F_UFO it does not propagate it
> > > > > anywhere, there is no corresponding NETIF flag.
> > > >
> > > > (It looks like I drop the community and other ccs accidentally, adding
> > > > them back and sorry)
> > > >
> > > > Actually, there is one, NETIF_F_GSO_UDP.
> > > >
> > > > Kernel used to have NETIF_F_UFO, but it was removed due to bugs and
> > > > the lack of real hardware support. Then we found it breaks uABI, so
> > > > Willem tries to make it appear for userspace again, and then it was
> > > > renamed to NETIF_F_GSO_UDP.
> > > >
> > > > But I think it's a bug that we don't proporate TUN_F_UFO to NETIF
> > > > flag, this is a must for the driver that doesn't support
> > > > VIRTIO_NET_F_GUEST_UFO. I just try to disable all offloads and
> > > > mrg_rxbuf, then netperf UDP_STREAM from host to guest gives me bad
> > > > length packet in the guest.
> > > >
> > > > Willem, I think we probably need to fix this.
> > >
> > > We had to add back support for the kernel to accept UFO packets from
> > > userspace over tuntap.
> > >
> > > The kernel does not generate such packets, so a guest should never be
> > > concerned of receiving UFO packets.
> >
> > That's my feeling as well.
> >
> > But when I:
> >
> > 1) turn off all guest gso feature and mrg rx buffers, in this case
> > virtio-net will only allocate 1500 bytes for each packet
> > 2) doing netperf (UDP_STREAM) from local host to guest, I see packet
> > were truncated in the guest
>
> Is it possible that the virtio-net does not disable UFO offload?
> IMO it sets NETIF_F_LRO too bravely.

After we removed UFO completely, we found that guests may be migrated
from old hosts with UFO support to newer without. And that they do not
renegotiate features, so will continue to send UFO packets.

I added back the absolute minimum support for UFO: for a host to be
able to accept such UFO packets from userspace. But no device can
advertise or negotiate the NETIF_F_USO feature again. If these packets
arrive on the egress path, they will be immediately software segmented
(or fragmented) in skb_segment. So the host will not forward such
packets to another guest.

The behavior that Jason is experiencing, truncated packets received in
a guest from the host, sound unrelated to this feature to me. Can you
see what the original UDP datagram length is? Are these packets just
marginally larger, or indeed clearly U[SF]O packets well beyond any
reasonable MTU size?

Another option is that this is related to the host stack support for
UDP_GRO. The stack can now build large packets, segments these on
demand if needed (e.g., if such a packet arrives at a local socket
that does not advertise UDP_GRO). Perhaps somehow such packets escape
un-segmented to a guest. Do any devices where these packets may
originate have features NETIF_F_GRO_UDP_FWD or NETIF_F_GRO_FRAGLIST
enabled?
