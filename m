Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38624368542
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 18:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhDVQxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 12:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhDVQw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:52:58 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A52FC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 09:52:23 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id p3so31607111ybk.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOkRs5K237gbs6NB3+gfmjX34Dy4iq9wMXif+x22Iz8=;
        b=AHzAwu6MBDObX75VQhBcdu7RnDvM5vAUMIR/iHS3V5/BGi9W0n4jx03qZJz9U37uiE
         0kjuqZ1M3x6N18PncMR6LQEJytpJFhqDncy0wwwgKh9z/3nhj/HjRwvpr0BztWP0Uktf
         BP2IFGgc2e6S/WH/c63V1MVNvz50Z2b/XoIbhm2GYd93GkT1MOLuuPuL1jh50VJTjl/u
         NJrdA0HBBiRSeAWozu0nDRi9+fuAw1m1T+A8EoZJCw00oohwMDdIvq46PiW/AF3L8q7j
         42MkrEAoTDt0FmVcBA03wCazvRoq/LRai8HRo/6JH/a8ImJsIhz6L6gw1xvesmkzLop6
         mrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOkRs5K237gbs6NB3+gfmjX34Dy4iq9wMXif+x22Iz8=;
        b=YiBSuYVmGWiKAjDN/aubeRsR2He5b9L7z0NrGaBl+Wpe7x5o58l90S2kiPa4Fhmc0g
         739XusMLatQAz/k0I3AhiaMSZ7BuTGgAzVCwv5nvZv7vVDUfdNVKIrG+aa/46/lRslT5
         QgpvFqpwD/fbAtThf3ys6sp+hkqO5s73zsc/LQVWdMkUmJuxtavOEip87WqjPGohJN68
         gEU9QiVpXL+GsZvO9JjTIytEoU9xUJRXAZizOANPdjohhY859dXygmIqlj0jnERol7CW
         N6b9PAdXkjJT6YCh9HFUpiWl7GZoHUsqkjTRdquBhIPFdcwFuEUj/IcP7+mHHbYVcd++
         HIWQ==
X-Gm-Message-State: AOAM531OuSqL2SIHhyhAvmJNcDeQigh3OjL6uKywHRZY8CrgUaRdFdDi
        n2pqd/3lVkBHp6HPP/e+qgZXbEh/IXQXepFBZlknuQ==
X-Google-Smtp-Source: ABdhPJy7j5HYC4iKiLboV+WKi7D6pJIZJzjC0yhQZJogGQAWyxpptaIBXGKrobDExKxmRatAdTWCv/YoDx+RzKzdcCY=
X-Received: by 2002:a25:4883:: with SMTP id v125mr6306231yba.253.1619110342298;
 Thu, 22 Apr 2021 09:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210421231100.7467-1-phil@philpotter.co.uk> <20210422003942.GF4841@breakpoint.cc>
 <YIGeVLyfa2MrAZym@hog>
In-Reply-To: <YIGeVLyfa2MrAZym@hog>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 22 Apr 2021 18:52:10 +0200
Message-ID: <CANn89iJSy82k+5b-vgSE-tD7hc8MhM6Niu=eY8sg-b7LbULouQ@mail.gmail.com>
Subject: Re: [PATCH] net: geneve: modify IP header check in geneve6_xmit_skb
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     Florian Westphal <fw@strlen.de>,
        Phillip Potter <phil@philpotter.co.uk>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 6:04 PM Sabrina Dubroca <sd@queasysnail.net> wrote:
>
> 2021-04-22, 02:39:42 +0200, Florian Westphal wrote:
> > Phillip Potter <phil@philpotter.co.uk> wrote:
> > > Modify the check in geneve6_xmit_skb to use the size of a struct iphdr
> > > rather than struct ipv6hdr. This fixes two kernel selftest failures
> > > introduced by commit 6628ddfec758
> > > ("net: geneve: check skb is large enough for IPv4/IPv6 header"), without
> > > diminishing the fix provided by that commit.
> >
> > What errors?
> >
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > > ---
> > >  drivers/net/geneve.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> > > index 42f31c681846..a57a5e6f614f 100644
> > > --- a/drivers/net/geneve.c
> > > +++ b/drivers/net/geneve.c
> > > @@ -988,7 +988,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
> > >     __be16 sport;
> > >     int err;
> > >
> > > -   if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
> > > +   if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
> > >             return -EINVAL;
> >
> > Seems this is papering over some bug, this change makes no sense to
> > me.  Can you please explain this?
>
> I'm not sure the original commit (6628ddfec758 ("net: geneve: check
> skb is large enough for IPv4/IPv6 header")) is correct either. GENEVE
> isn't limited to carrying IP, I think an ethernet header with not much
> else on top should be valid.

Maybe, but we still attempt to use ip_hdr() in this case, from
geneve_get_v6_dst()

So there is something fishy.
