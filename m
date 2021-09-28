Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B5441A99E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbhI1HXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239191AbhI1HXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:23:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56832611CE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632813685;
        bh=1vCeBFREgFqNmjnqSD8QSqzhTQtP23m82uhe/dRbgLQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YqfrqX7ZlSlofL7C1/wQ7IUwrJkTw9CqpPRHZslW+FIRaAAScuwi5ZoaDEPbs4U41
         XBEF7TUGLtAQ4/BiNhR4eDgNbN/gEBHR7LxnvLatWkO/rInZn8g7uFphgZ4UBe/vSq
         oy5z12/P74uYyMAkbW8C1++uBkW32hUkAhxbhS9ivzd1mffMrif11WqmJ5humpwVn2
         Wsif7bwPlOkWNOOXkk5tfwoPW4+ceVWQh91U1AFCgQS7CQMkxyuyf0WY757Ugq9gwY
         b2LLUkqpCy2sj3SSfCWLYaH7nDc4h9IAff4jlktkEkfzpX02YbrDIZLSqc6ovb7GOd
         iOKZoGkbSXWkA==
Received: by mail-wm1-f48.google.com with SMTP id t16-20020a1c7710000000b003049690d882so1273479wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 00:21:25 -0700 (PDT)
X-Gm-Message-State: AOAM532WA47E7lrZ7jVsrctBaTnh/uhtFLgSRw+Cs6+yYAeCTkucgdU2
        5Y82GcYjikwfRlwI8qtcOrCsJotJGWkXl8r1gtg=
X-Google-Smtp-Source: ABdhPJwbCQmeMFRTHAfW2rGv1bv9smZcCJCl+Hvbj4Ep77VpYBu11sQ4eO26bqF2GKn8LVbqwYZX9/dKQFvdi0VtGIw=
X-Received: by 2002:a05:600c:22d4:: with SMTP id 20mr3210797wmg.82.1632813683951;
 Tue, 28 Sep 2021 00:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210927141045.1597593-1-arnd@kernel.org> <CACRpkdbirEZiKQxSWSsiwwvpui5Pw6vON-C-=BLJei0s8znLxg@mail.gmail.com>
In-Reply-To: <CACRpkdbirEZiKQxSWSsiwwvpui5Pw6vON-C-=BLJei0s8znLxg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 28 Sep 2021 09:21:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1=u+iUXshuGu72N63ME5cD4PX_H2C1+rtTOEtN_rdddg@mail.gmail.com>
Message-ID: <CAK8P3a1=u+iUXshuGu72N63ME5cD4PX_H2C1+rtTOEtN_rdddg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] mtd: fixup CFI on ixp4xx
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 1:28 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Sep 27, 2021 at 4:10 PM Arnd Bergmann <arnd@kernel.org> wrote:

> > Any other ideas for how to address it?
>
> We will "soon" have IXP4xx transitioned to device tree and then
> physmap-ixp4xx.c is used instead, and this entire driver can be
> deleted. I will get there, we just need to remember to mop of cruft
> like this at the end of it.

Ah, perfect. In that case I'm not worried about my patch doing anything
wrong at all, and we can just backport that to stable kernels after it's
merged, while future kernels will won't even need it.

      Arnd
