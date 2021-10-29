Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F16743F6D8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 07:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhJ2Fz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 01:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhJ2Fz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 01:55:58 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3894C061570;
        Thu, 28 Oct 2021 22:53:29 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id a6so21469257ybq.9;
        Thu, 28 Oct 2021 22:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/vSuXsboymS/IgpBF9knJfz3TVx/mAj7z1ArPgdizjI=;
        b=YOSdiYDPna3naFx1R6UjtVwYbyaJDrQD0isSgwS7yDBmHs8l0633OLtBLdGZdil/TM
         6dWhEg7S0NjtqvwZYX7tJ6kmufifUyEsCBZ3T5NR6r+lTFF+4YliqgbNqpSYGLFCPnIc
         63kQo9ZVCpGhOJjvhO4+XCfmV8oIjS0MhJ7SHonzwa5B91APGzuLAsLw+N10yC/YeEnv
         JMyp971+Be/WEYtK8PtAvDll0XWvtwa4gwXp0UNxF8c+NEPJIOFSKqKgAOtNeodTVA0U
         MaGNfijGHoFgsMdltgUJvbJD8HBBdw6PQk5VbLk1vRdZj7p6+jciFWsA8ca+MsMwbuqX
         ojrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vSuXsboymS/IgpBF9knJfz3TVx/mAj7z1ArPgdizjI=;
        b=souWHQGv+yvpNPJCJcNj64xQxBSJZVbN+Hr7P+TLPrrzDh3st8FXQOwP+uUeWuY7fY
         GFhf7CL36JKGPj0AGfrcs19Hfa75CT62csPnL34j/w8q410lDM0NpMNoWNVDH5v/G2/0
         VPaPWjYLpHDXPQDOKesJC6xrSDPlOR7E+1aaemK2PDfloxoX0dNr/cbjaYL3/rUpuiV6
         cssCWyux9ZcbkmSWbh7Ps411eftIymTr4gKRMgHofo4JFDPeS3G5+RXx9aD9vIpxmnnx
         5O+VewyKSGXmv0IJFGwbJVWRK3gCktsIBL/MOCrD0EjrWnIVIxNXOvVrhrLjZTTyzLmo
         tZxA==
X-Gm-Message-State: AOAM532LVJC42x11KzgbHK42B9OPIfZesOtkd1NSwGfwxkCJ/AjEb1Gv
        Glm0CUQJ8JYZM47STLKfX9YgDuGxa5e+FugrtuLljPZU
X-Google-Smtp-Source: ABdhPJyaDlFoQq08g4YGXVSCxLxGN/EmlAplDZR3KAUzA0+ijsxzW6j44WCrZVqFPjLqsiVYlKPnbzBLVnyA+o64mDI=
X-Received: by 2002:a25:3787:: with SMTP id e129mr9141363yba.91.1635486809154;
 Thu, 28 Oct 2021 22:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
 <20211028141938.3530-5-lukas.bulwahn@gmail.com> <CAK8P3a2LhGWer=GXMW_KT-8=nqBeS0xhu6si7Z57WAF0wE_TUA@mail.gmail.com>
 <YXrDTMLBAy0Ftai/@shell.armlinux.org.uk>
In-Reply-To: <YXrDTMLBAy0Ftai/@shell.armlinux.org.uk>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 29 Oct 2021 07:53:17 +0200
Message-ID: <CAKXUXMzqqtM02wJrb+ONVdmS3j+YRej4Fd34Pc5M3ex871ONtQ@mail.gmail.com>
Subject: Re: [PATCH 04/13] arm: drop an obsolete ifdef with the removed config PCI_HOST_ITE8152
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
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

On Thu, Oct 28, 2021 at 5:35 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Oct 28, 2021 at 04:46:38PM +0200, Arnd Bergmann wrote:
> > On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > >
> > > Commit 6da5238fa384 ("ARM: 8993/1: remove it8152 PCI controller driver")
> > > removes the config PCI_HOST_ITE8152, but left a dangling obsolete ifndef
> > > in ./arch/arm/kernel/bios32.c.
> > >
> > > Hence, ./scripts/checkkconfigsymbols.py warns:
> > >
> > > PCI_HOST_ITE8152
> > > Referencing files: arch/arm/kernel/bios32.c
> > >
> > > Remove this obsolete ifndef.
> > >
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> >
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> >
> > I wonder if we should just remove this function and use the
> > (non-empty) default version instead.
> >
> > 96c5590058d7 ("PCI: Pull PCI 'latency timer' setup up into the core")
> > introduced that generic version, and I suspect the arm version
> > was left out by mistake, but it's not clear from that patch.
>
> That was because PCI_HOST_ITE8152 needed something different from the
> "do nothing" default (setting the PCI latency timer to default to 64
> as the new generic code did.)
>

So, can we just drop the empty pcibios_set_master() function in
bios32.c and the pci handling will now (after the removal of
PCI_HOST_ITE8152) just do The Right Thing(TM)?

If you can confirm that, I will send an updated patch here.

Thanks,

Lukas
