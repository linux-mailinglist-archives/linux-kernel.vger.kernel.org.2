Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C4B439ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 20:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhJYTBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 15:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhJYTBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:01:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C166C061767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 11:59:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id u13so3358289edy.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 11:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kryo-se.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxuT1NwkP5IbWIr54rvIZPXE4zt4zjt7xvPTnRqKIv8=;
        b=dJ/vRMx2Do21S1kpEwvTxGKyNyWN9lNXIziYRko7J1MoUiH3xWWq4X9QC1G/1W0Y12
         REVFkLZtkUmugxEFfEbqzKAQZUHSEFd6IQWVKTqmXkzXZkcfDl0SaBSJh+E4qmGmUAjM
         VELx+Mr/vZ/zINimTn8pVRu9oqUY9VHIew7l0cvUzJAgiA9i/xh8Z2BBrmeKuU0R6RLU
         dH5toKX9kxkVK+jhNh/vZcUviJRrImeOMty7HkXI3eijQMZnJnymMZ3HzeuClhca01W+
         82dRVp7DN+g66SyTB2r/fvlwp9Gg9nIH8CYeVYbzk8BHq8zcMRpnmvO7Cc9aCWiwQh/z
         gNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxuT1NwkP5IbWIr54rvIZPXE4zt4zjt7xvPTnRqKIv8=;
        b=RVLFzEZLJh45IFUMdUS6l7f2Voi7TO3DnV7MfNJEPJPLHoGg+xUpvavepJ9d4QmrPb
         DdirjBPD3/SeFXGAcCOTjKCH50aVORj6KGinW4AdI/JyaYyVykk2p3qhrcE0CR1B3t/Q
         LayWxLQQIhxdtmiLTRc6ByR+aS5dLQHD399IP5oxL7fitPUuB6fQzHwe3U41CPk8QmoK
         NUryPt6W6u4mUvSu5k3BzpC+HPNR0mjxabVCSMoiIld8jghvMoK4CYgLfXO4I8OihTEG
         hTxvgwv4n3N7A/qTQqWg3OXl6pjDOoXtdwxJASUOSkY/hhnSs4oN19K7nl1PcgqdLyo2
         Za9g==
X-Gm-Message-State: AOAM531PRzGfcnyRS0bPgavY3IJ/3T9aFJOHqbrpOdN3pwfuuQQB2m7+
        n5rLDIwzEvjN+iGDGVhH17uzyl2gwh8a5T/9wBiCVQ==
X-Google-Smtp-Source: ABdhPJxMQx6FZcgMoVNwZXE/W7Ov4TexphWjFXzcupB71pTOWnEz66ydI/ZgvcYP0Zh3Kea44L4B0DfVpUr5otEvzYo=
X-Received: by 2002:a50:e686:: with SMTP id z6mr30202339edm.311.1635188338446;
 Mon, 25 Oct 2021 11:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211017171657.85724-1-erik@kryo.se> <YW7idC0/+zq6dDNv@lunn.ch>
 <CAGgu=sCBUU29tkjqOP9j7EZJL-T4O6NoTDNB+-PFNhUkOTdWuw@mail.gmail.com> <YW8OiIpcncIaANzN@lunn.ch>
In-Reply-To: <YW8OiIpcncIaANzN@lunn.ch>
From:   Erik Ekman <erik@kryo.se>
Date:   Mon, 25 Oct 2021 20:58:47 +0200
Message-ID: <CAGgu=sD=cuqTEK3760wGFELLBgy3S6QgY_776KeDDDZV8GvZNQ@mail.gmail.com>
Subject: Re: [PATCH] sfc: Fix reading non-legacy supported link modes
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 at 20:29, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Oct 19, 2021 at 07:41:46PM +0200, Erik Ekman wrote:
> > On Tue, 19 Oct 2021 at 17:21, Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > On Sun, Oct 17, 2021 at 07:16:57PM +0200, Erik Ekman wrote:
> > > > Everything except the first 32 bits was lost when the pause flags were
> > > > added. This makes the 50000baseCR2 mode flag (bit 34) not appear.
> > > >
> > > > I have tested this with a 10G card (SFN5122F-R7) by modifying it to
> > > > return a non-legacy link mode (10000baseCR).
> > >
> > > Does this need a Fixes: tag? Should it be added to stable?
> > >
> >
> > The speed flags in use that can be lost are for 50G and 100G.
> > The affected devices are ones based on the Solarflare EF100 networking
> > IP in Xilinx FPGAs supporting 10/25/40/100-gigabit.
> > I don't know how widespread these are, and if there might be enough
> > users for adding this to stable.
> >
> > The gsettings api code for sfc was added in 7cafe8f82438ced6d ("net:
> > sfc: use new api ethtool_{get|set}_link_ksettings")
> > and the bug was introduced then, but bits would only be lost after
> > support for 25/50/100G was added in
> > 5abb5e7f916ee8d2d ("sfc: add bits for 25/50/100G supported/advertised speeds").
> > Not sure which of these should be used for a Fixes tag.
>
> I would you this second one, since that is when it becomes visible to
> users.
>
Thanks

I found that the SFC9250 is also affected (it supports 10/25/40/50/100G)

Fixes: 5abb5e7f916ee8 ("sfc: add bits for 25/50/100G
supported/advertised speeds")

/Erik
