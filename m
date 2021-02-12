Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80723319C58
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhBLKG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:06:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhBLKGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:06:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2637564DC3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 10:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613124328;
        bh=A92+uCaUJaeUmE7/YrYlYqVO58s0/eZ3nhtJ7cWKios=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F7i41KrQ/h5EHm7kTdHWQRT/CnJgiY1niD64K7SPugXOrCK2tr6VA9ASYU3tpV8W5
         d+JeedXWwKSjVfxBLf5eKQ0/VlSPIwTFHE/9oRSh0ww04a/V0YgFiB0rO5MHfxF6pb
         nkf/f3Hts+yOs6t8mqXsj9Eoom+kfJZriwUmHylCYACVJKbZFlmmy/jhtVCRcydUYi
         5TfgSnx53DV8v1MNavydfTNgTRA3m4nPsCVQTt4S5SFcTUKMasetembXkgApWolRdF
         /xw2PCGiJZynx/MN/TB4Wkjq1oVfu9A432aHY/v6j6Pb4TBCXWq06S4ByNpJK4FSfK
         OmlI27eFQsH+Q==
Received: by mail-ot1-f50.google.com with SMTP id s107so7871181otb.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 02:05:28 -0800 (PST)
X-Gm-Message-State: AOAM532XngabnYqs9RXTnvCC0Hu4mRHWWpoRWTO/TVb0pZauABrwufSA
        KAzeNk+OhS4mdDWANwzXFYwgogKHlbcUj0WltZQ=
X-Google-Smtp-Source: ABdhPJx2zIOL1vmnx2eBqdnwRXZboLDLDNzRy6dCgdmNxNR6CpQgwveHVazesC4ubNtulb9z1eTwwlY5niETKviiyms=
X-Received: by 2002:a9d:6c11:: with SMTP id f17mr1490157otq.210.1613124327386;
 Fri, 12 Feb 2021 02:05:27 -0800 (PST)
MIME-Version: 1.0
References: <202102121331.d4C0ShlS-lkp@intel.com>
In-Reply-To: <202102121331.d4C0ShlS-lkp@intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 12 Feb 2021 11:05:11 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3uM7rCbnJP9r2SFEjm0D7oy2YsXw7VcGzkg5tq7mQbag@mail.gmail.com>
Message-ID: <CAK8P3a3uM7rCbnJP9r2SFEjm0D7oy2YsXw7VcGzkg5tq7mQbag@mail.gmail.com>
Subject: Re: arch/m68k/68000/dragen2.c:73:16: error: 'screen_bits' undeclared
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 6:48 AM kernel test robot <lkp@intel.com> wrote:
>
> FYI, the error/warning still remains.

>          |             ^~~~~~~~~~~~
>    arch/m68k/68000/dragen2.c: In function 'init_dragen2':
> >> arch/m68k/68000/dragen2.c:73:16: error: 'screen_bits' undeclared (first use in this function)
>       73 |  LSSA = (long) screen_bits;
>          |                ^~~~~~~~~~~
>    arch/m68k/68000/dragen2.c:73:16: note: each undeclared identifier is reported only once for each function it appears in

This problem existed before my patch, I just moved the line to another file.
To fix it, one needs to test on real hardware and figure out what is supposed
to go in there.

The bug was apparently introduced in linux-2.5.70 in this commit:

commit 2b1a7e97c8c2d6330a432cbcaf83a0ef5fab848e
Author: gerg <gerg>
Date:   Mon May 26 16:45:57 2003 +0000

    [PATCH] fix m68knommu DragonEngine2 target setup code

    Numerous fixes for the m68knommu DragonEngine2 setup code.

    It was out of date relative to more recent kernels.  Original patches
    from Georges Menie.

    BKrev: 3ed244c5dPVeFKP63b4kkeS_rEshag


      Arnd
