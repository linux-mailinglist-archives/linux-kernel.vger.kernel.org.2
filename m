Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3944287D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhKBHe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhKBHe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:34:26 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58F5C0613F5;
        Tue,  2 Nov 2021 00:31:51 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 131so39296064ybc.7;
        Tue, 02 Nov 2021 00:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OluhKtBimmP7E/0/GgG/7vGECz49HSub0BngF4v6Qkk=;
        b=Bvf2fbUNYYZs+yDoofQfIvShNimuZiQJy/Zp9hrH0CGU5n80NwA+7lS4xFoh0aRwPr
         98I/K3k/I6QiAluHUcR1ANMi4gmbQ6FkS2BuJEEBcGZJibMDly8GvavxbysCb/E3DEIu
         1k4jSu2ljyTm6S8gRdiSlJv/d/j37volSZzDeRiMvUyXJ9c0xSQPPgv3juozIUVuuc5w
         GvS68SPhYtUTmL4r6wrh9dGuWad9mhGJzRq94FOmyMsthjYY45dFHbbPidjbsntO+my0
         VgG1ARPTQdmlY9OXrXAU8qdB/wANbnxZGzVxc46++kzxevRN1e+DtE8Aqh++Z6oGkFDA
         uEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OluhKtBimmP7E/0/GgG/7vGECz49HSub0BngF4v6Qkk=;
        b=6N8bSJUliBPKTKsbPGg8pVg/B88po3NsLgftSioAJRrO7DA7vBId7d4F12OUX9BHrS
         0lw7+q1YWWehdx4/BezsMJvVsCs1gTNnsE06u0TMGbiooqSyCby7ywlkw8ohJ1O2nx3J
         uYTwTZiha2ZxPiLqGh9MBycqYqtlsIZAuSHlaIByVVkMT/+pEkJGviJEKhtg9AFA3rCb
         xq+4ipmMRJppiD1fvblXGphSoTLW0xaHRpZ/9Go2eJy/uSYp/Z9h+dQr85JroXkXn+Qq
         DpEY+WaZWtuHuOI34KedLZ8QmEHQQr1K3AM9q/+E16GUNHBNdHzCpDawjwcjnrRhWvBS
         FhMg==
X-Gm-Message-State: AOAM532YTZZ7WEK3eqxeV2Ap/oEq53Ct873ZOp9DvEoDD3chpKPKcbvX
        +T3oK2jeu1Jan1zpfBgs509fb51Kf0tHv5Jz8tg=
X-Google-Smtp-Source: ABdhPJyv6KqPsjyT+qQxOopmtsEESwOY6fY2G6+8d+IXWs3OLmtof/rN/ulyY0nAtjzJEMlBgpC9RIU9jr4hfZlhPYA=
X-Received: by 2002:a25:34d5:: with SMTP id b204mr26987557yba.154.1635838310937;
 Tue, 02 Nov 2021 00:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
 <20211028141938.3530-12-lukas.bulwahn@gmail.com> <CAK8P3a0Nq9hLbGiPCQTjVTiGFPR9-tdhN8Tf06Q=cWTgMK78yw@mail.gmail.com>
 <CACPK8XfiN5qziPHLU6J=bC34mcjz+ix7jjSX=xk9zsr7+vyTdw@mail.gmail.com>
In-Reply-To: <CACPK8XfiN5qziPHLU6J=bC34mcjz+ix7jjSX=xk9zsr7+vyTdw@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 2 Nov 2021 08:31:40 +0100
Message-ID: <CAKXUXMyrhrM2o-OEW_qTTKjfKgxt-Z6Nt69geU80AoFnM1OuMA@mail.gmail.com>
Subject: Re: [PATCH 11/13] arm: npcm: drop selecting non-existing ARM_ERRATA_794072
To:     Joel Stanley <joel@jms.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 8:36 AM Joel Stanley <joel@jms.id.au> wrote:
>
> On Thu, 28 Oct 2021 at 14:57, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > >
> > > There is no and never was a Kconfig for ARM_ERRATA_794072 in the kernel
> > > tree. So, there is no need to select ARM_ERRATA_794072 in
> > > ./arch/arm/mach-npcm/Kconfig.
> > >
> > > Simply drop selecting the non-existing ARM_ERRATA_794072.
> > >
> > > This issue was discovered with ./scripts/checkkconfigsymbols.py.
> > >
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > ---
> >
> > Could this be a typo? Maybe we need to enable a different errata workaround
> > here, or maybe that code is actually needed and has to get sent.
>
> Doing some searching, u-boot had a workaround for something called
> ARM_ERRATA_794072.
>
> https://github.com/u-boot/u-boot/commit/f71cbfe3ca5d2ad20159871700e8e248c8818ba8
>
> Lore has the review history for that patch:
>
> https://lore.kernel.org/all/6be32e0b5b454ed7b609317266a8e798@BLUPR03MB358.namprd03.prod.outlook.com/
>
> It looks like it's the same workaround as ARM_ERRATA_742230, which the
> kernel does implement.
>
> It would be good to hear from the Nuvoton people, or an Arm person.
>

I will happily update the patch to select ARM_ERRATA_742230 instead of
the dead non-existing ARM_ERRATA_794072.

In contrast to the current patch that basically only cleans up "dead
config" and has no effective functional change, the new patch would
change the behaviour. I cannot test this patch (beyond some basic
compile test) on the hardware; so, we certainly need someone to have
that hardware, knows how to test it or confirm otherwise that we
should select the ARM_ERRATA_742230 fix for this hardware.

The current patch should be subsumed by the new patch; the submission
of the new patch is deferred until that person shows up. Let's see.

Lukas
