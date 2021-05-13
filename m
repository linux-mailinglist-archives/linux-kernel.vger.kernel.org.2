Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A4C37FF4A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 22:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhEMUgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 16:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhEMUgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 16:36:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B83AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 13:35:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l4so41666859ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 13:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OSP4b7wpVi2J0VIXLzXQpYaouwViNp+zix3X51TtRM=;
        b=jULfFAQdup+JfQHyGNJe5gViVXOpfKZCPJbE4aABtwAQlIyYMLruaAymHorBENW7LV
         6pvAO2R4lC6uUDYEOkb2xu40DTKaKml5fQajfG2EmM0hS3O2NAa5kfec62L5iXXKfqk8
         mqweY9rc4duXqwNVSuQ00GtNYGEYr+fgr50a0i+d39Y7eXE6EO6UN/Kj22auNPrFs0wM
         srFbcdTcD2IwBZ/hLxi0+ZbitC9kx2/VlUk8HznczXbBSgHNbdP+GYBk/XrDDqgDpbS6
         F8hKcswHBIqwzalmTMSBhA24UZj/r8952Si6xy8qs1KARhQWn9VNADNoH33CF1+R40hc
         eWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OSP4b7wpVi2J0VIXLzXQpYaouwViNp+zix3X51TtRM=;
        b=UitiXl+WOyl7GA7xrJg2TQFYWS7AoJiucBxPUFY5XXAlpsP72MPLO/g2Gb7IjLGZEY
         WL1Vq72u+eR9uwH+EVq8KUdxHfRjz3IDg1fQHDXMCi0ycc+WCZ2rWHD3ixtLHLYWl2yy
         kprwnUOB1+J7Qix5ExbROTpX5QLFUxHYl0mzsjWjPCTNOaokCc4bBaCRRimC8kh52mw/
         GBqjFuvCHz/WFaI/+01JEAEnLvVMiXpbjEtvYEYig24ofA8DsB/tin1USrov6GRlpZxf
         AqRNtEzK76cTwhFD4eaMSxE3/8cwGFJGJiEslO7kBMgeYPas6N+Rmw0pS0UH3eziVrzr
         zBqQ==
X-Gm-Message-State: AOAM532KmWdOQjS+zOwnVsLSb3LtDkLUB5NpQxb0bizcwzFcyMnRoKWS
        Om5cEmwllMkRUbCxgtJ3jE1McV6kT6SYLQ==
X-Google-Smtp-Source: ABdhPJz/hvawcXZuyUTopONAwxBFP1SLf6l54sy/fiYe3Jbm39W43leNUa2sGo+CQ0JoNQmTKPv5og==
X-Received: by 2002:a17:906:14c1:: with SMTP id y1mr46567490ejc.481.1620938138493;
        Thu, 13 May 2021 13:35:38 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id hz15sm2376001ejc.57.2021.05.13.13.35.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 13:35:36 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id y124-20020a1c32820000b029010c93864955so401255wmy.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 13:35:35 -0700 (PDT)
X-Received: by 2002:a7b:c94b:: with SMTP id i11mr34607045wml.120.1620938135207;
 Thu, 13 May 2021 13:35:35 -0700 (PDT)
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
 <CAOEp5OfB62SQzxMj_GkVD4EM=Z+xf43TPoTZwMbPPa3BsX2ooA@mail.gmail.com> <CACGkMEu4NdyMoFKbyUGG1aGX+K=ShMZuVuMKYPauEBYz5pxYzA@mail.gmail.com>
In-Reply-To: <CACGkMEu4NdyMoFKbyUGG1aGX+K=ShMZuVuMKYPauEBYz5pxYzA@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 13 May 2021 16:34:57 -0400
X-Gmail-Original-Message-ID: <CA+FuTScV+AJ+O3shOMLjUcy+PjBE8uWqCNt0FXWnq9L3gzrvaw@mail.gmail.com>
Message-ID: <CA+FuTScV+AJ+O3shOMLjUcy+PjBE8uWqCNt0FXWnq9L3gzrvaw@mail.gmail.com>
Subject: Re: [PATCH 4/4] tun: indicate support for USO feature
To:     Jason Wang <jasowang@redhat.com>
Cc:     Yuri Benditovich <yuri.benditovich@daynix.com>,
        Yan Vugenfirer <yan@daynix.com>, davem <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, mst <mst@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > But surprisingly when TUN receives TUN_F_UFO it does not propagate it
> > anywhere, there is no corresponding NETIF flag.
>
> (It looks like I drop the community and other ccs accidentally, adding
> them back and sorry)
>
> Actually, there is one, NETIF_F_GSO_UDP.
>
> Kernel used to have NETIF_F_UFO, but it was removed due to bugs and
> the lack of real hardware support. Then we found it breaks uABI, so
> Willem tries to make it appear for userspace again, and then it was
> renamed to NETIF_F_GSO_UDP.
>
> But I think it's a bug that we don't proporate TUN_F_UFO to NETIF
> flag, this is a must for the driver that doesn't support
> VIRTIO_NET_F_GUEST_UFO. I just try to disable all offloads and
> mrg_rxbuf, then netperf UDP_STREAM from host to guest gives me bad
> length packet in the guest.
>
> Willem, I think we probably need to fix this.

We had to add back support for the kernel to accept UFO packets from
userspace over tuntap.

The kernel does not generate such packets, so a guest should never be
concerned of receiving UFO packets.

Perhaps i'm misunderstanding the problem here.
