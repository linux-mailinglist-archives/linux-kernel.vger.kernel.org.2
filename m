Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DBF3C5D81
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhGLNnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 09:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26466 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234464AbhGLNnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626097229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7j3Zqroi+dqqNki2TrXDNIqb1hRewMOgWdvC95TlAw4=;
        b=UvpVkaAvYItzA9SOOv0Au3xabLo2+b03ed0JF9qglgEbVT7Z7ozlFEMKOa+elPVDIY8QiD
        iqoMu33tighbH+5fbD3drU6+8xYgvKAh/p0DQoMcSbjWbcJJJ8DtA17do+CEwsIkwiecJu
        uPAqSHmlp/WWpoqctsl3ucB7S7YeMdc=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-Uz_gX2JyPMiGotl6U1OwMQ-1; Mon, 12 Jul 2021 09:40:28 -0400
X-MC-Unique: Uz_gX2JyPMiGotl6U1OwMQ-1
Received: by mail-io1-f69.google.com with SMTP id m14-20020a5d898e0000b02904f7957d92b5so11820556iol.21
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7j3Zqroi+dqqNki2TrXDNIqb1hRewMOgWdvC95TlAw4=;
        b=Gp2lwqhlypwx7p3AZklgrGSxtPTCe2JG25c1IWDmKQ3A6taQGAnUlwMQ4W/+Pp95sa
         k1B40VVRQruYy14wrNAeC/ZslGhRBtCGwvbrXkw3H9bZ1aWir0urXxF2Jt/9h95+USu4
         PS+GkfXvByKlHtBHZbgbIQ3tWqoJpJZFfFTmI7G5yGOpUPvII8UHbXMrxMc5FY8U3bkU
         uk2LkM0fEQBvR6gX46YEz0p4nu4kFclnX4Q7G4Y7axXgfaC/VDxPy6YxxrddiqkKji7w
         CiN/JuBjNaVSWXitRULBIDyy6UrJN0gN8jLHQ2rAUVGfh8/dUyfR6GVBIHZ8dzsgp1wL
         K9Gg==
X-Gm-Message-State: AOAM530watmotS4TnGQHQwj/3QJXEcZuD/F4Enn0oi2CZxe3U9z4n13h
        Cym/Vb62VO38ys5o8iAQ21PTr4HCSOCAgIYUTORp2gLofMrXf6YeaMsJKfAz0DkhFFZyaXjsGF7
        3keWogWMBUcof2q4SvV4febE13LfFwn/rA1z58m6W
X-Received: by 2002:a92:260f:: with SMTP id n15mr8265677ile.143.1626097227980;
        Mon, 12 Jul 2021 06:40:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfc0W1sFidpJPASHwOsE17RqYxxjyIGxVFfkMTLr2WOqSSl55D5m6gqjbHqp2J7YG9zZkt8Cj5rerAbl/VfV0=
X-Received: by 2002:a92:260f:: with SMTP id n15mr8265657ile.143.1626097227727;
 Mon, 12 Jul 2021 06:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210707081642.95365-1-ihuguet@redhat.com> <0e6a7c74-96f6-686f-5cf5-cd30e6ca25f8@gmail.com>
 <CACT4oudw=usQQNO0dL=xhJw9TN+9V3o=TsKGvGh7extu+JWCqA@mail.gmail.com>
 <20210707130140.rgbbhvboozzvfoe3@gmail.com> <CACT4oud6R3tPFpGuiyNM9kjV5kXqzRcg8J_exv-2MaHWLPm-sA@mail.gmail.com>
 <b11886d2-d2de-35be-fab3-d1c65252a9a8@gmail.com> <4189ac6d-94c9-5818-ae9b-ef22dfbdeb27@redhat.com>
In-Reply-To: <4189ac6d-94c9-5818-ae9b-ef22dfbdeb27@redhat.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Mon, 12 Jul 2021 15:40:16 +0200
Message-ID: <CACT4ouf-0AVHvwyPMGN9q-C70Sjm-PFqBnAz7L4rJGKcsVeYXA@mail.gmail.com>
Subject: Re: [PATCH 1/3] sfc: revert "reduce the number of requested xdp ev queues"
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Edward Cree <ecree.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ivan@cloudflare.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, brouer@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 9, 2021 at 5:07 PM Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:
> > I think it's less about that and more about avoiding lock contention.
> > If two sources (XDP and the regular stack) are both trying to use a TXQ=
,
> >   and contending for a lock, it's possible that the resulting total
> >   throughput could be far less than either source alone would get if it
> >   had exclusive use of a queue.
> > There don't really seem to be any good answers to this; any CPU in the
> >   system can initiate an XDP_REDIRECT at any time and if they can't eac=
h
> >   get a queue to themselves then I don't see how the arbitration can be
> >   performant.  (There is the middle-ground possibility of TXQs shared b=
y
> >   multiple XDP CPUs but not shared with the regular stack, in which cas=
e
> >   if only a subset of CPUs are actually handling RX on the device(s) wi=
th
> >   an XDP_REDIRECTing program it may be possible to avoid contention if
> >   the core-to-XDP-TXQ mapping can be carefully configured.)
>
> Yes, I prefer the 'middle-ground' fallback you describe.  XDP gets it's
> own set of TXQ-queues, and when driver detect TXQ's are less than CPUs
> that can redirect packets it uses an ndo_xdp_xmit function that takes a
> (hashed) lock (happens per packet burst (max 16)).

That's a good idea, which in fact I had already considered, but I had
(almost) discarded because I still see there 2 problems:
1. If there are no free MSI-X vectors remaining at all,
XDP_TX/REDIRECT will still be disabled.
2. If the amount of free MSI-X vectors is little. Then, many CPUs will
be contending for very few queues/locks, not for normal traffic but
yes for XDP traffic. If someone wants to intensively use
XDP_TX/REDIRECT will get a very poor performance, with no option to
get a better tradeoff between normal and XDP traffic.

We have to consider that both scenarios are very feasible because this
problem appears on machines with a high number of CPUs. Even if
support for more channels and queues per channel is added, who knows
what crazy numbers for CPU cores we will be using in a few years? And
we also have to consider VFs, which usually have much less MSI-X
vectors available, and can be assigned to many different
configurations of virtual machines.

So I think that we still need a last resort fallback of sharing TXQs
with network stack:
1. If there are enough resources: 1 queue per CPU for XDP
2. If there are not enough resources, but still a fair amount: many
queues dedicated only to XDP, with (hashed) locking contention
3. If there are not free resources, or there are very few: TXQs shared
for network core and XDP

Of course, there is always the option of tweaking driver and hardware
parameters to, for example, increase the amount of resources
available. But if the user doesn't use it I think we should give them
a good enough tradeoff. If the user doesn't use XDP, it won't be
noticeable at all. If he/she intensively uses it and doesn't get the
desired performance, he/she will have to tweak parameters.

Jesper has tomorrow a workshop in netdevconf where they will speak
about this topic. Please let us know if you come up with any good new
idea.

Regards
--=20
=C3=8D=C3=B1igo Huguet

