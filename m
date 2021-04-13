Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BE335E0F8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbhDMOJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhDMOJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:09:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4AEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:09:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w18so19637199edc.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5CizpbO31FtejMNYjXuvc8L275/b2XFa53SLVJcUKq0=;
        b=d7rHSyX5FYqvYlUwaaFx6Cem28DMQMUp8Wv0FRZ9jb0O8CwlLq01rbCgyEQxp7Gs30
         lKPsSc8nvZeDxcR0U+wzjIqCeG2udUGUvSL4Qh/O0Zwq28I1bh2gdzZFrqe9d3072Qdj
         Q3URSx5mp2RCWFS0xm67XKNz8HjPomZ75ooaa9No/dlBf14Q53mxMbQ8Lhdso/91oPqw
         kM21HVpgFwLl7ZiMlaTP7ouOzx49Imb8zIalR/JaD4KAHedjiAI5P9xQp0um2fX8Yq/E
         9ysXejvNssC6iiF5ReY9A/m0mfi3FvuqBM9W4/QtLkVFMwqcwysapMh1n6YotvsA5udo
         PykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5CizpbO31FtejMNYjXuvc8L275/b2XFa53SLVJcUKq0=;
        b=NG9TrrzVEhwNZJYuuFU/WkqpVZy7UU5Htpx/oPrVO8HdI93GOLDTg+I1UpFa5N+b48
         sffomLwQRDE5Iib/GuMvFg0Oo7kmdWLnaFnKkoQN0xB3DoQYM/pwZrOuLwZGa4zIYsIt
         AIexUS1yA4KFmlaEiNZ/7e11Zji/1zsbE8+bVl+E1hL3l8o/FXcX9Wx0WFvB5UI81tK7
         9KPyUHuJDkFd2Dk1HMemDveSIgSpBRrI4uvnl/ehTMJj4Y3JK8Fiox9Qwk27n6upHtNM
         FW0OEwbtsSFOvhAebOp09FMLk+7kk7zAFy9Ga/M2+LtfAvkqJpgS/OQOSNWzazGvY6fE
         CzpQ==
X-Gm-Message-State: AOAM533I/kOUMBJmSPL508rWsYtI0nS4VyE7Dn05fMmkaSjwUizIBG6J
        wogQcLdYH3/TevRA8JfOzpJkdkQ2WkP9DA==
X-Google-Smtp-Source: ABdhPJzIHPfjQ3RfGyIgVidserW8YJhVjjzVH+9I0B2hKR//rqHDuBo9egipHY87NwNH6yMY8OF8Ng==
X-Received: by 2002:aa7:cd07:: with SMTP id b7mr35621061edw.293.1618322953605;
        Tue, 13 Apr 2021 07:09:13 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id g25sm9277765edp.95.2021.04.13.07.09.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 07:09:13 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id a4so16630982wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:09:12 -0700 (PDT)
X-Received: by 2002:a5d:510d:: with SMTP id s13mr37397046wrt.12.1618322952421;
 Tue, 13 Apr 2021 07:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210413054733.36363-1-mst@redhat.com> <20210413054733.36363-3-mst@redhat.com>
 <43db5c1e-9908-55bb-6d1a-c6c8d71e2315@redhat.com>
In-Reply-To: <43db5c1e-9908-55bb-6d1a-c6c8d71e2315@redhat.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 13 Apr 2021 10:08:34 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdt6udHb7V4Xcj=OQ3M-iRazgOMWJinCbLJyof=ttB=Cw@mail.gmail.com>
Message-ID: <CA+FuTSdt6udHb7V4Xcj=OQ3M-iRazgOMWJinCbLJyof=ttB=Cw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/4] virtio_net: disable cb aggressively
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Wei Wang <weiwan@google.com>,
        David Miller <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 4:53 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/4/13 =E4=B8=8B=E5=8D=881:47, Michael S. Tsirkin =E5=86=99=
=E9=81=93:
> > There are currently two cases where we poll TX vq not in response to a
> > callback: start xmit and rx napi.  We currently do this with callbacks
> > enabled which can cause extra interrupts from the card.  Used not to be
> > a big issue as we run with interrupts disabled but that is no longer th=
e
> > case, and in some cases the rate of spurious interrupts is so high
> > linux detects this and actually kills the interrupt.
> >
> > Fix up by disabling the callbacks before polling the tx vq.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   drivers/net/virtio_net.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 82e520d2cb12..16d5abed582c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1429,6 +1429,7 @@ static void virtnet_poll_cleantx(struct receive_q=
ueue *rq)
> >               return;
> >
> >       if (__netif_tx_trylock(txq)) {
> > +             virtqueue_disable_cb(sq->vq);
> >               free_old_xmit_skbs(sq, true);
> >               __netif_tx_unlock(txq);
>
>
> Any reason that we don't need to enable the cb here?

This is an opportunistic clean outside the normal tx-napi path, so if
disabling the tx interrupt here, it won't be reenabled based on
napi_complete_done.

I think that means that it stays disabled until the following start_xmit:

        if (use_napi && kick)
                virtqueue_enable_cb_delayed(sq->vq);

But that seems sufficient.
