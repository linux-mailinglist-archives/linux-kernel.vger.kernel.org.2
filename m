Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34F0395648
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhEaHji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:39:38 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:36803 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhEaHib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:38:31 -0400
Received: by mail-vs1-f41.google.com with SMTP id x2so5576750vss.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qp64Ff9sQ1XHnXMrMVo5W6iYbCnQOLz2Qij/fbDUp1I=;
        b=ZstdllaaB8Y5kvWgbQw7yPyPWnCoVu7+cWhn29bDbX/SepZAvtsIT/bnXXhLkmlahu
         sKp6eVgyS3UQTog5WM2hR/oDHUw3lNYDHn1cxtPO+878MiW03Rrolnt7Vdj8XNpaTLjn
         kO5qdQqnki+ZUMcvnnA+cgf72FwbqjVU+BR/+Ty63Q519520dPUzx88UkhnLxKOzmqTx
         VQ7iZaO5pCq4bUmBmHwmwUQI2kkRXxODPT37FUZPwGCq6DyzrODySGbCs0x+QMteN5to
         840ISxkxMAvkagg+zv3JKgOyU25Symn6ACdDX2RRYPyC8dtd8gGvuG+NdCrFQvpvdq/f
         iXdw==
X-Gm-Message-State: AOAM530PEnvCcIOtcjSwifyBE8qHaliUmvaKshm4GHBfFkrIFnpdA4eH
        DUuV++kzkkoIK8oSk51iBBTVJsisQzhGTGtA97w=
X-Google-Smtp-Source: ABdhPJwztePBp8J4QSwHBxHluKlJ9Q8Y0f1AlqDWN7Wva0zVsN8M2ODcc8P5vldh9sxhEbxbJvbR8hoUZ9n4ol44DSA=
X-Received: by 2002:a67:b303:: with SMTP id a3mr2648717vsm.40.1622446611736;
 Mon, 31 May 2021 00:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <202105300736.7wVLvXHr-lkp@intel.com> <a0edf640-ec05-524e-9125-44decba27bbb@infradead.org>
 <d4c47108-f4d2-4850-14fd-b4c4bd0e0591@infradead.org>
In-Reply-To: <d4c47108-f4d2-4850-14fd-b4c4bd0e0591@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 31 May 2021 09:36:40 +0200
Message-ID: <CAMuHMdW1xZ-vJe2eOehNSKCP3T=-eq7ji4MBo3D6oGJyPNXGDw@mail.gmail.com>
Subject: Re: ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, Andrew Lunn <andrew@lunn.ch>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rich Felker <dalias@libc.org>,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 3:13 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 5/30/21 5:05 PM, Randy Dunlap wrote:
> > On 5/29/21 4:25 PM, kernel test robot wrote:
> >> First bad commit (maybe != root cause):
> >>
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >> head:   df8c66c4cfb91f2372d138b9b714f6df6f506966
> >> commit: a9770eac511ad82390b9f4a3c1728e078c387ac7 net: mdio: Move MDIO drivers into a new subdirectory
> >> date:   9 months ago
> >> config: sh-allmodconfig (attached as .config)
> >> compiler: sh4-linux-gcc (GCC) 9.3.0
> >> reproduce (this is a W=1 build):
> >>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>         chmod +x ~/bin/make.cross
> >>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a9770eac511ad82390b9f4a3c1728e078c387ac7
> >>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >>         git fetch --no-tags linus master
> >>         git checkout a9770eac511ad82390b9f4a3c1728e078c387ac7
> >>         # save the attached .config to linux build tree
> >>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sh
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> All errors (new ones prefixed by >>, old ones prefixed by <<):
> >>
> >>>> ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!
>
> Should we make this one driver depend on !SUPERH ?

No, we should just fix the driver instead.

+               /* Wait 1000 clocks so we don't saturate the RSL bus
+                * doing reads.
+                */
+               __delay(1000);

As this is used only on Cavium Octeon and Thunder SoCs, running
at 400-600 MHz resp. 1800-2000 Mhz, what about replacing the __delay()
call by a call to udelay(1) or udelay(2)?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
