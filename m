Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153A131640B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhBJKjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 05:39:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231309AbhBJKfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:35:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10F2464E2E;
        Wed, 10 Feb 2021 10:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612953299;
        bh=1K3KbJuoIq4iabQNHnrRpJS5tQ/x2No+KUluIejW7Pc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ApRSEIX4DkcNosi6JBGhym3f3lE2MS1mNHWiTHA43HBP6CLiaWmEjOlifUANJD5rp
         FS/4DRsT5eGNrRcGCZwMZnrkDHLnV1VDTUymPsIDMlQbrchGt9XDUndQxw5ijJ/9c7
         csiS+CJ3kpBOikFl2+YIcbeEQqavukH9b4GJEWdij+70tvMW3FIvgshdDO3gYqRiyY
         vAKeHMpOnhiJ/XBkpd2ms0K99MhrJwokEtaOneVfP0fvZItQP2TXkFduEvYvZiJnVL
         1F7xExOHZWIb8w7TllVj2sjCOunc/H5X3Rd/OEgy4EZUTglLK12VtSVI7uMvc9RKGp
         sNSco52+2x9Zw==
Received: by mail-oi1-f171.google.com with SMTP id r75so1449354oie.11;
        Wed, 10 Feb 2021 02:34:59 -0800 (PST)
X-Gm-Message-State: AOAM531kOore39SPczvcIj+Y48Nj6ppud2it45uDO/ZraRFHJF4noEIx
        5sEX5pG/CxPf8eS48VIYRMv0mbfHQIhXO0sAW0k=
X-Google-Smtp-Source: ABdhPJzseKKHEbJC7CnEtbLwFdupZ9GAl1vdMa3N8sPeQgYT+Wi1W+aI+MmSwwkSXkLQsdFrH0EVj4yLjP/H+T3mtu0=
X-Received: by 2002:aca:e103:: with SMTP id y3mr1528656oig.11.1612953298253;
 Wed, 10 Feb 2021 02:34:58 -0800 (PST)
MIME-Version: 1.0
References: <20210118155242.7172-1-jbx6244@gmail.com> <20210118155242.7172-2-jbx6244@gmail.com>
 <CAK8P3a3_uO23Y0tyfdh26tmCVcyp6XM+ur0WUd4khGUoBb32Hw@mail.gmail.com> <6598201.ejJDZkT8p0@diego>
In-Reply-To: <6598201.ejJDZkT8p0@diego>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 10 Feb 2021 11:34:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a25iYksubCnQb1-e5yj=crEsK37RB9Hn4ZGZMwcVVrG7g@mail.gmail.com>
Message-ID: <CAK8P3a25iYksubCnQb1-e5yj=crEsK37RB9Hn4ZGZMwcVVrG7g@mail.gmail.com>
Subject: Re: [PATCH 2/5] ARM: dts: rockchip: assign a fixed index to mmc
 devices on rv1108 boards
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Johan Jonker <jbx6244@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:50 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote=
:
> Am Dienstag, 9. Februar 2021, 23:25:40 CET schrieb Arnd Bergmann:
>
> Hmm, right now I don't see the disadvantage of missing mmc numbers.

It's inconsistent with the normal use of these aliases across other
platforms.

> As similarly we count i2c and serial numbers for a long time, even though
> not all of them appear on every board.

Yes, that is a similar mistake.

> Especially as the main goal is to simply have stable numbers and
> not having the mmc devices swap numbers on every boot.
>
> So right now we're not using them from a userspace POV but
> instead agreed on following the address ordering of the soc.
> so when ordering mmc controllers by their io-address, mmc0
> is the first one, then mmc1, etc.
>
> So just for my understanding, what is different for mmc?
> I guess to guarantee ongoing numbering similar to sd{a,b,c,...}
> Or should all aliases be duplicted in each board dts and not
> live in any soc dtsi?

Each board should have its own aliases node that describes
exactly which of the devices are wired up on that board, and
in which order. If there are connectors on the board that
are labeled in some form, then the aliases are meant to
match what is written on the board or in its documentation.

      Arnd
