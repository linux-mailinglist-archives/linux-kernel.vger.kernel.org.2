Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DC141A028
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbhI0Ucz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235865AbhI0Ucy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:32:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E113D611C2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 20:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632774675;
        bh=L1CRUWVlmuXisCoG0P/PRUVv8Zv/AQDpFetJ+yUiP+M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gsBYFVXNoca1mwpAZVKXKP1CBG5KsEla15qFKtMpt0qmt2bjcHAXPgahT4xTxMizf
         NX8wuQEN3F6PP6zlnsHMJulGltJQvYJMsc2WsPLcik17QSk2f4ZxhmmepVa+bNsazp
         NfNu8Fax6FxMmfr3eIZywKJq9goth+pAtq9cLFHIS2Ac1GLor3yw1oNyvtR9/NFej3
         TLExEhqgJb2dS2ocmmRRAfLxWrY6i3PHghZvNMo50lFZJL0liQphAdmFelO9d1nfSl
         Tal0Aw2PYlSCBF2PLjO6NvfYPJWQZGnattjgsYA71oYNcZJ5yAxTz8Ze0n5Q273oKI
         G61pC3cGCcz8A==
Received: by mail-wr1-f41.google.com with SMTP id g16so54090492wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:31:15 -0700 (PDT)
X-Gm-Message-State: AOAM531JmTH640WgwiBcLNaYIGWLh8RE6QS56bevZyYJCIfFCTJHMJRV
        l8YlYdQcQBNXEb0Yp8ZHYmxFN3JedHWaWMrkjOg=
X-Google-Smtp-Source: ABdhPJwnVTd7oCfk8RB3I87RyL/yPZtwURjxHiKZ57qC0Pl8TeHZ0JDkOYJEO2cMud9+QfVlpEoLFcTyL2ty41RPnJE=
X-Received: by 2002:a5d:4b50:: with SMTP id w16mr2143934wrs.71.1632774674466;
 Mon, 27 Sep 2021 13:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210927141045.1597593-1-arnd@kernel.org> <20210927183328.2f200fc2@xps13>
In-Reply-To: <20210927183328.2f200fc2@xps13>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 27 Sep 2021 22:30:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0WnM7_6o0FE3=iY+0J1-qU5gCGH6qWCfLygGTkH0TA+w@mail.gmail.com>
Message-ID: <CAK8P3a0WnM7_6o0FE3=iY+0J1-qU5gCGH6qWCfLygGTkH0TA+w@mail.gmail.com>
Subject: Re: [PATCH] [RFC] mtd: fixup CFI on ixp4xx
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 6:33 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Arnd,
>
> arnd@kernel.org wrote on Mon, 27 Sep 2021 16:10:37 +0200:
>
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > drivers/mtd/maps/ixp4xx.c requires MTD_CFI_BE_BYTE_SWAP to be set
> > in order to compile.
> >
> > drivers/mtd/maps/ixp4xx.c:57:4: error: #error CONFIG_MTD_CFI_BE_BYTE_SWAP required
> >
> > This patch avoids the #error output by enforcing the policy in
> > Kconfig. Not sure if this is the right approach, but it helps doing
> > randconfig builds.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Any other ideas for how to address it?
>
> I am fine with the approach. Should I wait for someone else's Ack?

Maybe wait a few days to see if there are objections or any better
ideas then. I'd certainly be happy to never run into this problem again.

         Arnd
