Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519DD3B273A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 08:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFXGP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 02:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhFXGPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 02:15:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBE4C061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 23:13:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gt18so7619470ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 23:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/qcz8m6sT93MT9ppgjUkcdnhc0rZ+kUNJRZSgxYJOi8=;
        b=UiOGjE2gYSJS5G9gMarlHQvvASgaHA/IFQeFw+NEZHffxHZnYTFF72W67acyEMxWdG
         I03Dq14Bk8ph9L4Ybl8Bfn+djzcvhAZkC2NWFJpUWaFHM+rtK0RUo4ZRTKx8IJKyuybH
         R8pFTqwjTAV2nb2/wOxM72rQppHB9S1ev2KsjQRkJzETnEMW65BZY68PLvV7c/WUC2IM
         6HOYGuaDbAlDXNZITsBaP71XSCYxBDQnfEC+RUbVI9XQFRp9rjpEB88K6GHLR/WktZbe
         NvCZORWNSr47AzGH+QHk22ugFER8ojUggESVkhxcJRw7sqg0uyLNFtLHh/0I2pxqY+aX
         sufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/qcz8m6sT93MT9ppgjUkcdnhc0rZ+kUNJRZSgxYJOi8=;
        b=muG8MMHYG4Fs3Kmo+pW7kq6nWRjxWv1L5rWVzVsCJfxoCvGYwTBI3D/P2rMcVJfjLA
         Uyq56vBx5gOI4XhzwZfwdVOr39yZMh3IcRcij5cCtDnMPdCGBMO34XGtaUJ25LlZ5yoK
         cxpjCLjf+iPXvJT/AVpS9UFblWZG0Mwg0E2EQj8YTEkFd+0N6o7oXR67Kcc3VDdwelGI
         6m30ydHPIPxy/paBiiPq6cGjJ39lXBcKD5rQCOm3S+vuwCyUalgxjeDPyyARwZEEDUk8
         KaIWWo6egK49IbNXa0CLGjIFTIsoYrHUC5Sjm1w9ZEbgLKDWCae16MCV+1qhq3YGibSn
         o9qQ==
X-Gm-Message-State: AOAM53107I2eMp8Ecdc18wZFy/+yzYPJINztbghml7MqyGvy8Pr3Do/N
        VFwe5fOQnfLIcKEdupJNAEIswSQxJcWWI9HUTYLDVA==
X-Google-Smtp-Source: ABdhPJwNY5wrcRuED2SLhvImBUBrkNfG+8zjSJ+hU2Zzu2ZwaamS5mm+MmfEBdl/ieCfow5xJATy/vljCcRojegt074=
X-Received: by 2002:a17:906:c211:: with SMTP id d17mr3644755ejz.247.1624515206230;
 Wed, 23 Jun 2021 23:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210624082911.5d013e8c@canb.auug.org.au> <CAPv3WKfiL+sR+iK_BjGKDhtNgjoxKEPv49bU1X9_7+v+ytdR1w@mail.gmail.com>
 <YNPt91bfjrgSt8G3@Ryzen-9-3900X.localdomain>
In-Reply-To: <YNPt91bfjrgSt8G3@Ryzen-9-3900X.localdomain>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 24 Jun 2021 11:43:14 +0530
Message-ID: <CA+G9fYtb07aySOpB6=wc4ip_9S4Rr2UUYNgEOG6i76g--uPryQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcin,

On Thu, 24 Jun 2021 at 07:59, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Thu, Jun 24, 2021 at 12:46:48AM +0200, Marcin Wojtas wrote:
> > Hi Stephen,
> >
> > czw., 24 cze 2021 o 00:29 Stephen Rothwell <sfr@canb.auug.org.au> napis=
a=C5=82(a):
> > >
> > > Hi all,
> > >
> > > Today's linux-next build (x86_64 modules_install) failed like this:
> > >
> > > depmod: ../tools/depmod.c:1792: depmod_report_cycles_from_root: Asser=
tion `is < stack_size' failed.

LKFT test farm found this build error.

Regressions found on mips:

 - build/gcc-9-malta_defconfig
 - build/gcc-10-malta_defconfig
 - build/gcc-8-malta_defconfig

depmod: ERROR: Cycle detected: fwnode_mdio -> of_mdio -> fwnode_mdio
depmod: ERROR: Found 2 modules in dependency cycles!
make[1]: *** [/builds/linux/Makefile:1875: modules_install] Error 1

> > Thank you for letting us know. Not sure if related, but I just found
> > out that this code won't compile for the !CONFIG_FWNODE_MDIO. Below
> > one-liner fixes it:
> >
> > --- a/include/linux/fwnode_mdio.h
> > +++ b/include/linux/fwnode_mdio.h
> > @@ -40,7 +40,7 @@ static inline int fwnode_mdiobus_register(struct mii_=
bus *bus,
> >          * This way, we don't have to keep compat bits around in driver=
s.
> >          */
> >
> > -       return mdiobus_register(mdio);
> > +       return mdiobus_register(bus);
> >  }
> >  #endif
> >
> > I'm curious if this is the case. Tomorrow I'll resubmit with above, so
> > I'd appreciate recheck.

This proposed fix did not work.

> Reverting all the patches in that series fixes the issue for me.

Yes.
Reverting all the (6) patches in that series fixed this build problem.

git log --oneline | head
3752a7bfe73e Revert "Documentation: ACPI: DSD: describe additional MAC
configuration"
da53528ed548 Revert "net: mdiobus: Introduce fwnode_mdbiobus_register()"
479b72ae8b68 Revert "net/fsl: switch to fwnode_mdiobus_register"
92f85677aff4 Revert "net: mvmdio: add ACPI support"
3d725ff0f271 Revert "net: mvpp2: enable using phylink with ACPI"
ffa8c267d44e Revert "net: mvpp2: remove unused 'has_phy' field"
d61c8b66c840 Add linux-next specific files for 20210623

steps to reproduce, config and build log located here in this link,
https://builds.tuxbuild.com/1uNjGjPUAI4XwwcwKFr5FUxkwzy/


# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.


tuxmake --runtime podman --target-arch mips --toolchain gcc-10
--kconfig malta_defconfig


- Naresh
