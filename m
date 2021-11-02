Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FAC442DA5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 13:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhKBMRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 08:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhKBMRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:17:45 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E3FC061714;
        Tue,  2 Nov 2021 05:15:10 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id s3so19248391ybs.9;
        Tue, 02 Nov 2021 05:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H0Nynl9KYEos60TLF3kMyaTZRdbJ2IJWnWt8dmgsZ8o=;
        b=Oy4e08YQ+S5kroIaoipFHcseTK3NpOCo+MSIUrjmGs+88S/D2FVe1zsab/MobPaAsJ
         PQSblcw2EVBRG7rlaelIkp5D00fsyXAEz5c56YjBeOkuUcgFksHHayttv/PlUy02IcOw
         4nYDu8pQY0a/1NAAIM0hgPWQF9DdZl0/SwbFRVd+BQBVuUxAasx1nyiEcz9r94hfjt4X
         iSf84fPNvSvJrMBzzKbo04BZXEl5kI6YVUB2vTaEDy+Oc9rXn8V6WHlcLml1QSj6+70S
         GCa4ByRWzS8yR6FfDveQEFkp41ZSXZByjoP+diuB7jYpeUlZhqJDZQrUwxjxKLSg3zQX
         wD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H0Nynl9KYEos60TLF3kMyaTZRdbJ2IJWnWt8dmgsZ8o=;
        b=P5INML07dtu9jeoy/aoQscXZf13gUFKThjXynMXFQhllUBkNwRPpCgPBLH4pF/MofN
         jkTQZnJXzmjes2cKXLH9gd5WBIWGpUcatSoUWK48p5Wlm39DBW0JSGefo5+UdOgzTzW3
         ipdM2I+KtEF1cOcDaRgX/GWVIZ/pBqorOAf3TJNrxokIqaR/A9zSWD1BGqmXjO60PVnn
         UrHhVXTBWFDRHPDfO64d/FRCidlR6sj3wLKc6Y7TDefzDGikdUK/sysvfltev9lE8c1Z
         dNTB6h2jjaRtfpwMVCPCsReD68lzhDx/zWvkoirnT6LmYlaUSt8nfH8YnXA5QpHkC1SX
         FApA==
X-Gm-Message-State: AOAM533cXMfkXe8LAUC55CjH5P+VVrZAUffU0jYfNGeVkPPYaWcNp7cb
        5AS/WJj1Quiuf76DtWANVIrsFEakQ0RTWqOrk/8zLuBAqmc=
X-Google-Smtp-Source: ABdhPJxLjg53nX46gv9ag9zyfyZJr3b9fP3tgKwpwWhIuIrPOLIV5FCJQF8aI+BgAh5o6cQY+rn/rGbzr6eUr7UoMbk=
X-Received: by 2002:a25:71c3:: with SMTP id m186mr37252318ybc.434.1635855309301;
 Tue, 02 Nov 2021 05:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
 <20211028141938.3530-12-lukas.bulwahn@gmail.com> <CAK8P3a0Nq9hLbGiPCQTjVTiGFPR9-tdhN8Tf06Q=cWTgMK78yw@mail.gmail.com>
 <CACPK8XfiN5qziPHLU6J=bC34mcjz+ix7jjSX=xk9zsr7+vyTdw@mail.gmail.com>
 <CAKXUXMyrhrM2o-OEW_qTTKjfKgxt-Z6Nt69geU80AoFnM1OuMA@mail.gmail.com> <CAK8P3a2N3zNkGzXQD8Pbs-8pDL7mv6rneJop-C_p_+d7-_sNqA@mail.gmail.com>
In-Reply-To: <CAK8P3a2N3zNkGzXQD8Pbs-8pDL7mv6rneJop-C_p_+d7-_sNqA@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 2 Nov 2021 13:14:58 +0100
Message-ID: <CAKXUXMzeTE11Qfces6sHLb7F_0sSSCOr91aivZmnqCS4cZM-VQ@mail.gmail.com>
Subject: Re: [PATCH 11/13] arm: npcm: drop selecting non-existing ARM_ERRATA_794072
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Joel Stanley <joel@jms.id.au>, Tomer Maimon <tmaimon77@gmail.com>,
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

On Tue, Nov 2, 2021 at 9:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Nov 2, 2021 at 8:31 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > On Fri, Oct 29, 2021 at 8:36 AM Joel Stanley <joel@jms.id.au> wrote:
> > > On Thu, 28 Oct 2021 at 14:57, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > > https://lore.kernel.org/all/6be32e0b5b454ed7b609317266a8e798@BLUPR03MB358.namprd03.prod.outlook.com/
> > >
> > > It looks like it's the same workaround as ARM_ERRATA_742230, which the
> > > kernel does implement.
> > >
> > > It would be good to hear from the Nuvoton people, or an Arm person.
> >
> > I will happily update the patch to select ARM_ERRATA_742230 instead of
> > the dead non-existing ARM_ERRATA_794072.
> >
> > In contrast to the current patch that basically only cleans up "dead
> > config" and has no effective functional change, the new patch would
> > change the behaviour. I cannot test this patch (beyond some basic
> > compile test) on the hardware; so, we certainly need someone to have
> > that hardware, knows how to test it or confirm otherwise that we
> > should select the ARM_ERRATA_742230 fix for this hardware.
> >
> > The current patch should be subsumed by the new patch; the submission
> > of the new patch is deferred until that person shows up. Let's see.
>
> I'd prefer to leave the broken Kconfig symbol in place as a reminder until it
> gets fixed properly then.
>

Agree, this patch here should not be integrated. I rather expect that
Avi or others at Nuvoton will provide a proper patch to act
appropriately for the ARM_ERRATA_794072, or after proper analysis can
determine that there is no change in the kernel required.

Lukas
