Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAC33099EF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 03:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhAaCJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 21:09:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhAaCJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 21:09:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59BCE64E1B;
        Sun, 31 Jan 2021 02:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612058927;
        bh=3xx8TxmA2gyZeZoXMG+7SVI7SSrkFWvs9+2r9Zf9QRc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BexwFh0UZjD/MDkHQlx3LAHdIrG72RIa5g2QskzKvkLMTAq/RElWBJcJY+FZHg0xG
         renDgcUEjaV4TIwjL8qLq4ch2tGV4shORnPoMA6Me4wQwTTzSG4whXRyN3T2oiWUj0
         b5/3iHeMbGDLgAvnu+gVJU7BsY8PO8bhuEurCZ5XPswz8tG7BcqGbHSTxgnI11ZHXO
         sB/x1m2yxs2QHygppMrWgy4Wl33VO4n+pbuQPbOAQF55NJ6vw/2Pw2qSPJng37gk4I
         87P/R9mrqWIbnRhSqktts1MR0OcvMb8ft3euBsIj/H9g25EGY0zYlnFstX8a22dSVG
         cyvac44CTdpHQ==
Received: by mail-lf1-f50.google.com with SMTP id m22so17946870lfg.5;
        Sat, 30 Jan 2021 18:08:47 -0800 (PST)
X-Gm-Message-State: AOAM531SDVSXxKJ4S5b5xRucCDt+9f/xyyH+XuyMc2QEHK2Y50b2MNgR
        5ajUPPyO31ufinBJrXLHYLUPOa0x7/fK91lN5Yw=
X-Google-Smtp-Source: ABdhPJwG5EEsXTAkRktbcPgJ+2WpcojmwU3MKgiO4woMGgiI1IAhUnHK26iX8F90zDbQs+2STBLedI78m+5xCp3puRs=
X-Received: by 2002:ac2:4436:: with SMTP id w22mr5282197lfl.41.1612058925675;
 Sat, 30 Jan 2021 18:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20210130234949.21090-1-rdunlap@infradead.org>
In-Reply-To: <20210130234949.21090-1-rdunlap@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 31 Jan 2021 10:08:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR9pdgmYv8tV9ncjHYQ-LAA75f_Yc0BMyOQjiR-TAW4TA@mail.gmail.com>
Message-ID: <CAJF2gTR9pdgmYv8tV9ncjHYQ-LAA75f_Yc0BMyOQjiR-TAW4TA@mail.gmail.com>
Subject: Re: [PATCH] csky: change a Kconfig symbol name to fix e1000 build error
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Guo Ren <guoren@linux.alibaba.com>, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by

Thx

On Sun, Jan 31, 2021 at 7:50 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> e1000's #define of CONFIG_RAM_BASE conflicts with a Kconfig symbol in
> arch/csky/Kconfig.
> The symbol in e1000 has been around longer, so change arch/csky/
> to use DRAM_BASE instead of RAM_BASE to remove the conflict.
> (although e1000 is also a 2-line change)
>
> Not tested: I don't have a build toolchain for CSKY.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org
> Cc: Guo Ren <guoren@linux.alibaba.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: linux-csky@vger.kernel.org
> ---
> IMO "CONFIG_" namespace should belong to Kconfig files, not
> individual drivers, but e1000 isn't the only driver that uses
> CONFIG_ symbols.
>
>  arch/csky/Kconfig            |    2 +-
>  arch/csky/include/asm/page.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> --- linux-next-20210129.orig/arch/csky/include/asm/page.h
> +++ linux-next-20210129/arch/csky/include/asm/page.h
> @@ -28,7 +28,7 @@
>  #define SSEG_SIZE      0x20000000
>  #define LOWMEM_LIMIT   (SSEG_SIZE * 2)
>
> -#define PHYS_OFFSET_OFFSET (CONFIG_RAM_BASE & (SSEG_SIZE - 1))
> +#define PHYS_OFFSET_OFFSET (CONFIG_DRAM_BASE & (SSEG_SIZE - 1))
>
>  #ifndef __ASSEMBLY__
>
> --- linux-next-20210129.orig/arch/csky/Kconfig
> +++ linux-next-20210129/arch/csky/Kconfig
> @@ -314,7 +314,7 @@ config FORCE_MAX_ZONEORDER
>         int "Maximum zone order"
>         default "11"
>
> -config RAM_BASE
> +config DRAM_BASE
>         hex "DRAM start addr (the same with memory-section in dts)"
>         default 0x0
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
