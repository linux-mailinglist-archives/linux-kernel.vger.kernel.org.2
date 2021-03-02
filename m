Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABA032AB47
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582055AbhCBUTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442213AbhCBRaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:30:05 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C231C0611BC
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 08:24:22 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p21so32152260lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 08:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=spDqAabTsp4LqzJSCuCF/LplY6jTXds7B6hpNsRhkM4=;
        b=o5gwQ4yZ8YTvEOf5qcO+EU9Zhnf2Uvz/xYHgt6qfyvwsR9pU+d9URb+5QLO2PiynAK
         LuVS8fyQImGGVPUwoWMFxfamLRbRwL2aIeadk8cA8o8oULaWDaIbCLxzEGTlEu/ked4G
         lI8Gd0xfbzaxd0uv9owFO0QT/wgAMXOSsw0pIST6ou8Yz6clXyXPWsu7txWLQI73Yhop
         BSnGyXQh5hhjy5SlteD/ab8bng/KmWetDld2Hmxptjm83wF0Q+7dQikrMNsdFpxJxyHF
         kNEj+5WwSGRbQyzO9GEAFylxPIiUfY9mmoE9m6nP9yT+SSY8yKrh5hMcAVPd6YM2aCiY
         5gwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=spDqAabTsp4LqzJSCuCF/LplY6jTXds7B6hpNsRhkM4=;
        b=r0+biCEEpIGRvrg8BEJqUxXYxNZ5jOAaI/YLMkFTxOvDu+/J2/b0EfBLBgdDaWpe28
         Dp5/4NnvnR9dKnlSc83EPsZp7t6kpLJewov2z/TR4F727Zlz1kbMDGUKfepDDMaGC+Ff
         T6DIHaCuhcdATajtieE9ACBSJ3Wi69C6L60kKmDMMI3TXE9zSMGbxGTfFaLY0poTwlj+
         f6DOQwNmyB9e63rPe8hXYMkd9JOvRE1fiW4gT35H+prr1f9icdbVtSgp8sd9E4ULx3Xn
         kxaXlTedsbGwvBHFsyfc6RiSiNu1ncS3cLlu1BFBqhOmEmPDd65U54u9AUs+bXy3x4Q4
         B8qQ==
X-Gm-Message-State: AOAM530tXXZ6cl5iVIaCXSfutQZ23BCcm1BSKcdT3hZKzmuLNL8HnluV
        IadxXR5xrW/vz5A9mzidC59K4/BU8q31YWmwFauf/w==
X-Google-Smtp-Source: ABdhPJwc752qfzLhHXNFNl2brHU8Umz8JE1YiOOWV/JR3gN5px83aOEgiqJ6qgDyygXSnltEUC8hg0CLdY6Fp2/ljtg=
X-Received: by 2002:a05:6512:74a:: with SMTP id c10mr12928022lfs.586.1614702260058;
 Tue, 02 Mar 2021 08:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20210224061205.23270-1-dqfext@gmail.com> <CACRpkdZykWgxM7Ge40gpMBaVUoa7WqJrOugrvSpm2Lc52hHC8w@mail.gmail.com>
 <CALW65jYRaUHX7JBWbQa+y83_3KBStaMK1-_2Zj25v9isFKCLpQ@mail.gmail.com>
 <CACRpkdZW1oWx-gnRO7gBuOM9dO23r+iifQRm1-M8z4Ms8En9cw@mail.gmail.com> <20210302161140.l3jtvkcm3tvlv5q3@skbuf>
In-Reply-To: <20210302161140.l3jtvkcm3tvlv5q3@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 17:24:08 +0100
Message-ID: <CACRpkdZuUc=fw1sRhdpUGoEo_87_uLuDfEu4uLAL43phR04k7A@mail.gmail.com>
Subject: Re: [RFC net-next] net: dsa: rtl8366rb: support bridge offloading
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     DENG Qingfang <dqfext@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 5:11 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> On Tue, Mar 02, 2021 at 05:05:00PM +0100, Linus Walleij wrote:
> > On Tue, Mar 2, 2021 at 4:58 AM DENG Qingfang <dqfext@gmail.com> wrote:
> > > On Mon, Mar 1, 2021 at 9:48 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > > With my minor changes:
> > > > Tested-by: Linus Walleij <linus.walleij@linaro.org>
> > >
> > > How about using a mutex lock in port_bridge_{join,leave} ?
> > > In my opinion all functions that access multiple registers should be
> > > synchronized.
> >
> > That's one way, in some cases the framework (DSA) serialize
> > the accesses so I don't know if that already happens on a
> > higher level? Since it is accessed over a slow bus we should go
> > for mutex in that case indeed.
>
> DSA does not serialize this. The .port_bridge_join and
> .port_bridge_leave calls are initiated from the NETDEV_CHANGEUPPER net
> device event, which is called under rtnl_mutex (see call_netdevice_notifiers).
> This is pretty fundamental and I don't think it will ever change.
>
> However, if you still want to add an extra layer of locking (with code
> paths that for some reason are not under the rtnl_mutex), then go ahead,
> I suppose. It will be challenging to make sure they do something that
> isn't snake oil, though.

Nah, just didn't know if was already in place.

I suggest Qingfang go with a driver-local mutex (it may already be needed in
more places).

Yours,
Linus Walleij
