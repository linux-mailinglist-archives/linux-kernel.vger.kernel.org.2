Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1125E447024
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 20:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhKFTf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 15:35:57 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36406 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234937AbhKFTfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 15:35:55 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mjRR5-0000Nv-9C; Sat, 06 Nov 2021 20:33:07 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Cedric Roux <sed@free.fr>, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sam Van Den Berge <sam.van.den.berge@telenet.be>,
        Lihua Yao <ylhuajnu@outlook.com>
Subject: Re: [RFC PATCH] ARM: s3c: mark as deprecated and schedule removal after 2022
Date:   Sat, 06 Nov 2021 20:33:06 +0100
Message-ID: <4062510.I3n91tvSNF@diego>
In-Reply-To: <08c8f447-dcae-83b4-e5b3-a13704a5b158@canonical.com>
References: <20211102110519.142434-1-krzysztof.kozlowski@canonical.com> <c4bcafd0-f614-78c8-4d72-5d2b672f7e32@free.fr> <08c8f447-dcae-83b4-e5b3-a13704a5b158@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 6. November 2021, 19:20:05 CET schrieb Krzysztof Kozlowski:
> On 05/11/2021 18:49, Cedric Roux wrote:
> > On 11/2/21 12:05 PM, Krzysztof Kozlowski wrote:
> >> If there are any users, they might respond and postpone the removal.
> > 
> > Hi Krzysztof,
> > 
> > I use a mini2440 (which is s3c2440) as an http server at home.
> > I don't have much time but I can do some testing from time to
> > time, but my setup is very custom so I don't know how helpful
> > that would be for the community (if there is one).
> 
> We just need to know whether the kernel behaves properly on the
> hardware. The setup itself should not matter, but what matters more is
> that you do not run a new kernel at all. There is a lot of untested code
> there.
> 
> > 
> > I would be sad to see official support disappear, but I know
> > how hard it is to maintain stuff, and I think I can keep going
> > with the current kernel I use (which is not even 5.xx I think),
> > so that would not be a big damage for me. And if I have special
> > needs in the future (very doubtful) I guess I could hack something
> > on my own.
> > 
> > Anyway, there is at least one s3c2440 server on Earth powered
> > by the linux kernel. Now you know! :)
> 
> Thanks for coming back! We will see how much of feedback we gather.

I do believe all (or at least most) of s3c24xx could run with a devicetree
base with core peripherals enabled.

So one possible alternative way could be to just deprecate (and then drop)
all the board-files + their platform-data parts in mach-s3c.

Heiko


