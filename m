Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6F83B973B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 22:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhGAU2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 16:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbhGAU2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 16:28:14 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953FBC061762;
        Thu,  1 Jul 2021 13:25:43 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id t24-20020a9d7f980000b029046f4a1a5ec4so7862387otp.1;
        Thu, 01 Jul 2021 13:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HKqWSYAw82wkbQb4Q9rpOf6Rzfc8rpUQdtixYTB6Xug=;
        b=K6Wop/WYm3LBArGs2St5nHMQ6E/PjbobEcxSA5D+GHCcQuVq5Do1OwPJKzz9JvfarD
         rSpANKv+DJk5rGRpTWVPNOa5ecr/2f7h+N32TlAXgYXBTFzJxVxLpalpEPuiPL+2WcoZ
         fvsAMDEQHCl/RMF7bDSQ5EbuieQiXB7I/a02KdGfJRuDF7mAEIYFpbuifQUkWYlIO3nF
         YkbtMk6s7DrY79xfEKz3DdOdlnbejiHyvt/W2AtzwYoolQ9nGt+nFSv+7uvMOpbZxVTG
         G7/Fz4sTqGEYOeb6Q4/zpQQS8lNXEdC+ReukjRBWgrgLdZFyPgaRAeg71tUiGnikJF7o
         7ZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HKqWSYAw82wkbQb4Q9rpOf6Rzfc8rpUQdtixYTB6Xug=;
        b=XfLh/s7bYGd+qqYRb6Rcu3IhN2t0gQEb/f+ZNWQoOlyi497VYD1PHA00iQ8MjVp7xU
         sNKHbkfylPUflU6tssqghqkxSuZeUXb6fSlgIJkf5H95xasXqRRQgd1dvpwVPoLAzNdt
         aGO6UKcAx3/QBeVYsh95yYBDH+Vew16DZDF0vHodmWdVtkqDNPtDcCARamRpDaAK80ca
         nW+4wJOv9C4RiEVcAnkHiyCRejzkdWIPM8v9W09yenS2wF19bxVljf5PtygEJwoWwxdJ
         kDjfE1qOdDtA1ikFG8rjm2//ryMsd5uphPlMyRmLpd9s+D6IPF0LqhrU5Ni4r/qym3N5
         qOEQ==
X-Gm-Message-State: AOAM533IQ5e4x08sMARht0zT2M9lwkFconx0BFDmPB09InvWmpFxyuo7
        5obD4RIG3PfgzJi904/T8GpQuk40LsQ=
X-Google-Smtp-Source: ABdhPJxbB5Kww3hYnu7vJrtKW5rPQ5KozsuVH/SGKSsrpAlj+tPI1lYQs2ly5JQ3p0izlW1T70B9GA==
X-Received: by 2002:a05:6830:241d:: with SMTP id j29mr1477463ots.371.1625171142913;
        Thu, 01 Jul 2021 13:25:42 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y5sm159294otq.5.2021.07.01.13.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 13:25:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 1 Jul 2021 13:25:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] clk: divider: Switch from .round_rate to
 .determine_rate by default
Message-ID: <20210701202540.GA1085600@roeck-us.net>
References: <20210627223959.188139-1-martin.blumenstingl@googlemail.com>
 <20210627223959.188139-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627223959.188139-3-martin.blumenstingl@googlemail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 12:39:58AM +0200, Martin Blumenstingl wrote:
> .determine_rate is meant to replace .round_rate. The former comes with a
> benefit which is especially relevant on 32-bit systems: since
> .determine_rate uses an "unsigned long" (compared to a "signed long"
> which is used by .round_rate) the maximum value on 32-bit systems
> increases from 2^31 (or approx. 2.14GHz) to 2^32 (or approx. 4.29GHz).
> Switch to a .determine_rate implementation by default so 32-bit systems
> can benefit from the increased maximum value as well as so we have one
> fewer user of .round_rate.
> 
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

In next-20210701:

    0.000000] 8<--- cut here ---
[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    0.000000] pgd = (ptrval)
[    0.000000] [00000000] *pgd=00000000
[    0.000000] Internal error: Oops: 80000005 [#1] SMP ARM
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.13.0-next-20210701 #1
[    0.000000] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[    0.000000] PC is at 0x0
[    0.000000] LR is at clk_core_determine_round_nolock+0xb4/0xe0
[    0.000000] pc : [<00000000>]    lr : [<c07be330>]    psr: a00000d3
[    0.000000] sp : c1701e48  ip : 00000000  fp : c1f6b340
[    0.000000] r10: c1f6b33c  r9 : d082007c  r8 : c1709a18
[    0.000000] r7 : 05e69ec0  r6 : 00000000  r5 : c1701e58  r4 : c2090480
[    0.000000] r3 : 00000000  r2 : c1701e64  r1 : 05e69ec0  r0 : c208fe80
[    0.000000] Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment none
[    0.000000] Control: 10c5387d  Table: 8000406a  DAC: 00000051
[    0.000000] Register r0 information: slab kmalloc-64 start c208fe80 pointer offset 0 size 64
[    0.000000] Register r1 information: non-paged memory
[    0.000000] Register r2 information: non-slab/vmalloc memory
[    0.000000] Register r3 information: NULL pointer
[    0.000000] Register r4 information: slab kmalloc-192 start c2090480 pointer offset 0 size 192
[    0.000000] Register r5 information: non-slab/vmalloc memory
[    0.000000] Register r6 information: NULL pointer
[    0.000000] Register r7 information: non-paged memory
[    0.000000] Register r8 information: non-slab/vmalloc memory
[    0.000000] Register r9 information: 0-page vmalloc region starting at 0xd0820000 allocated at of_iomap+0x4c/0x68
[    0.000000] Register r10 information: non-slab/vmalloc memory
[    0.000000] Register r11 information: non-slab/vmalloc memory
[    0.000000] Register r12 information: NULL pointer
[    0.000000] Process swapper/0 (pid: 0, stack limit = 0x(ptrval))
[    0.000000] Stack: (0xc1701e48 to 0xc1702000)
[    0.000000] 1e40:                   c2090480 c1700000 00000000 c07c5480 05e69ec0 00000000
[    0.000000] 1e60: ffffffff 179a7b00 c208d500 e6ff0344 c208ff00 05e69ec0 d0820080 00000000
[    0.000000] 1e80: 0000001c c07c55c0 c1f6b324 c2012c04 d0820080 c163c310 c1f6b340 00000000
[    0.000000] 1ea0: 00000804 d0820074 0000001c 00000000 c186052c c109a5b0 c186052c c0caf26c
[    0.000000] 1ec0: cbdc67ac d0820000 c2012c04 d0820060 d0820048 d0820028 cbdcc0cc d0820018
[    0.000000] 1ee0: d0820020 d0820038 d0820030 c2012c04 c1701f1c 00000000 c2005e80 c1701f1c
[    0.000000] 1f00: 00000004 c2005e88 cbdcc0cc cbdcc138 00000001 c162a4e4 c1700000 c1700000
[    0.000000] 1f20: 00000000 c2005e88 c2005e88 cbdc5884 00000000 c1701fc8 c17093cc c0838f44
[    0.000000] 1f40: c1600dd0 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.000000] 1f60: 00000000 00000000 00000000 00000000 00000000 e6ff0344 00000000 c1902000
[    0.000000] 1f80: c1663a80 00000012 c1700000 c1709380 00000000 c170caa8 c14cb424 c1604d34
[    0.000000] 1fa0: c1902000 c1600e0c ffffffff ffffffff 00000000 c1600588 00000000 c1700000
[    0.000000] 1fc0: 00000000 c1663a80 e6fa0e44 00000000 00000000 c1600330 00000051 10c0387d
[    0.000000] 1fe0: ffffffff 8833b000 410fc075 10c5387d 00000000 00000000 00000000 00000000
[    0.000000] [<c07be330>] (clk_core_determine_round_nolock) from [<c07c5480>] (clk_core_set_rate_nolock+0x184/0x294)
[    0.000000] [<c07c5480>] (clk_core_set_rate_nolock) from [<c07c55c0>] (clk_set_rate+0x30/0x64)
[    0.000000] [<c07c55c0>] (clk_set_rate) from [<c163c310>] (imx6ul_clocks_init+0x2798/0x2a44)
[    0.000000] [<c163c310>] (imx6ul_clocks_init) from [<c162a4e4>] (of_clk_init+0x180/0x26c)
[    0.000000] [<c162a4e4>] (of_clk_init) from [<c1604d34>] (time_init+0x20/0x30)
[    0.000000] [<c1604d34>] (time_init) from [<c1600e0c>] (start_kernel+0x4c8/0x6cc)
[    0.000000] [<c1600e0c>] (start_kernel) from [<00000000>] (0x0)
[    0.000000] Code: bad PC value
[    0.000000] ---[ end trace 7009a0f298fd39e9 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!

Bisct points to this patch as culprit. Reverting it fixes the problem.

Guenter
