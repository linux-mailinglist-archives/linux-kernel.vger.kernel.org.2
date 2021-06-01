Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B69396BA0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 04:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhFACzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 22:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhFACzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 22:55:46 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADD6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 19:54:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id t15so6305529eju.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 19:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=knN8PuwxMBMRUW0OyIkUMzniIsTf65LkkSfLXCcSzrY=;
        b=SvSffryegS+ysrvJelHxE0GDMIqYsiauOEAlrh+QIGJ4/aDIqhLCDQp2geMHP0p4EI
         o4sGgoCoODwCdY8h/iz7IjvTCxCzB07KIFYilnJ0a2ObrIdreIO9MOhx0UqE1X2eGufH
         /r7H7u+lQ2oOsS7H1+vMdNDI2SzPH6XNLpEIxDThc/aaGQSl61QvOXHwZ1dz4Q6RA7ee
         dqNy10UwQqXOMlDaCRQ13VjmQu/cFkSAcxY7UWJ43rVbLw/DyyxRYIch12GlLQr6yLHn
         wBDhSj5MCRhSyWb2Cpg1ZmjCvQoC5IFHyff1F4lSqgNZZASoNgUJ94Qku7CmF9xnUrWC
         p2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=knN8PuwxMBMRUW0OyIkUMzniIsTf65LkkSfLXCcSzrY=;
        b=ORYyrcp+ovERF0oFIIYIhWkpdtepCr5XZldsNnq7iPLKfKeBcOm+x6C/fuIuGbl3Ci
         WNiHWGmwMDd2sAHDe1rAc8bnKHnuWs8drB0w300GuDjoGFSHi52DfhJlbBtxSqbb1rwi
         Y8wSiRoA5ZiOYBdSfc+sFe58TcOWlnbxQ5H5qxuFEyP/MvVlrbfYHuNQ5cQ0XrQOfynR
         Cq+4ohb8Z6c154urRKrgh3Sdn3hL22PPWSPawcgJeF72HGtJY3rtpNeIN52DbA8Z5GsK
         oDfZJwAQvGQK+t5RWu22u3qmVOWnTebO3GVKA6S0ovI2Pqgjq/QDwB1lXqG8jrX4BtG5
         lAIA==
X-Gm-Message-State: AOAM532YeijYY91VNVeayhTQAt9Gr0M8tbXV8nPTiBPRm02Hkt+BsjBN
        sy5Ta8DCIQm7cpGiSY3p/POQ0z9w1lc=
X-Google-Smtp-Source: ABdhPJxQw1zf7LjWImpFrhWCETIx5bzJXfhkrEgu9n58L1h7dOLFeFu9V4k9A45MmF74hjVRlzJGFA==
X-Received: by 2002:a17:906:c1ca:: with SMTP id bw10mr26490442ejb.512.1622516044295;
        Mon, 31 May 2021 19:54:04 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id p25sm6628933eja.35.2021.05.31.19.54.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 19:54:03 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id n2so12661084wrm.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 19:54:02 -0700 (PDT)
X-Received: by 2002:adf:fa04:: with SMTP id m4mt4367691wrr.275.1622516042429;
 Mon, 31 May 2021 19:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210526082423.47837-1-mst@redhat.com> <CA+FuTScp-OhBnVzkXcsCBWxmq51VO6+8UGpSU5i3AJQV84eTLg@mail.gmail.com>
In-Reply-To: <CA+FuTScp-OhBnVzkXcsCBWxmq51VO6+8UGpSU5i3AJQV84eTLg@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 31 May 2021 22:53:26 -0400
X-Gmail-Original-Message-ID: <CA+FuTSf09nOJ=St4-3318oXy2ey0qRKkti8FvwheEUdiHSK0HA@mail.gmail.com>
Message-ID: <CA+FuTSf09nOJ=St4-3318oXy2ey0qRKkti8FvwheEUdiHSK0HA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] virtio net: spurious interrupt related fixes
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Wei Wang <weiwan@google.com>,
        David Miller <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 11:34 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Wed, May 26, 2021 at 4:24 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> >
> > With the implementation of napi-tx in virtio driver, we clean tx
> > descriptors from rx napi handler, for the purpose of reducing tx
> > complete interrupts. But this introduces a race where tx complete
> > interrupt has been raised, but the handler finds there is no work to do
> > because we have done the work in the previous rx interrupt handler.
> > A similar issue exists with polling from start_xmit, it is however
> > less common because of the delayed cb optimization of the split ring -
> > but will likely affect the packed ring once that is more common.
> >
> > In particular, this was reported to lead to the following warning msg:
> > [ 3588.010778] irq 38: nobody cared (try booting with the
> > "irqpoll" option)
> > [ 3588.017938] CPU: 4 PID: 0 Comm: swapper/4 Not tainted
> > 5.3.0-19-generic #20~18.04.2-Ubuntu
> > [ 3588.017940] Call Trace:
> > [ 3588.017942]  <IRQ>
> > [ 3588.017951]  dump_stack+0x63/0x85
> > [ 3588.017953]  __report_bad_irq+0x35/0xc0
> > [ 3588.017955]  note_interrupt+0x24b/0x2a0
> > [ 3588.017956]  handle_irq_event_percpu+0x54/0x80
> > [ 3588.017957]  handle_irq_event+0x3b/0x60
> > [ 3588.017958]  handle_edge_irq+0x83/0x1a0
> > [ 3588.017961]  handle_irq+0x20/0x30
> > [ 3588.017964]  do_IRQ+0x50/0xe0
> > [ 3588.017966]  common_interrupt+0xf/0xf
> > [ 3588.017966]  </IRQ>
> > [ 3588.017989] handlers:
> > [ 3588.020374] [<000000001b9f1da8>] vring_interrupt
> > [ 3588.025099] Disabling IRQ #38
> >
> > This patchset attempts to fix this by cleaning up a bunch of races
> > related to the handling of sq callbacks (aka tx interrupts).
> > Somewhat tested but I couldn't reproduce the original issues
> > reported, sending out for help with testing.
> >
> > Wei, does this address the spurious interrupt issue you are
> > observing? Could you confirm please?
>
> Thanks for working on this, Michael. Wei is on leave. I'll try to reproduce.

The original report was generated with five GCE virtual machines
sharing a sole-tenant node, together sending up to 160 netperf
tcp_stream connections to 16 other instances. Running Ubuntu 20.04-LTS
with kernel 5.4.0-1034-gcp.

But the issue can also be reproduced with just two n2-standard-16
instances, running neper tcp_stream with high parallelism (-T 16 -F
240).

It's a bit faster to trigger by reducing the interrupt count threshold
from 99.9K/100K to 9.9K/10K. And I added additional logging to report
the unhandled rate even if lower.

Unhandled interrupt rate scales with the number of queue pairs
(`ethtool -L $DEV combined $NUM`). It is essentially absent at 8
queues, at around 90% at 14 queues. By default these GCE instances
have one rx and tx interrupt per core, so 16 each. With the rx and tx
interrupts for a given virtio-queue pinned to the same core.

Unfortunately, commit 3/4 did not have a significant impact on these
numbers. Have to think a bit more about possible mitigations. At least
I'll be able to test the more easily now.
