Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B9C3E3D8B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 03:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhHIBbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 21:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhHIBbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 21:31:50 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E69C061757
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 18:31:30 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id x15so21362676oic.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 18:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sBZ9DyBAW8D3kMNMwZLbPeooIyLhBukrSO0BSiX2HYE=;
        b=BD32fLoMbHrRPxoIdnL6fH2OOAbBF/nh4LZS+R9qOB6RnRG3lfan7hdWJ/WzCVu0lU
         gzpd3Lh3ClNB8DVEyW9ACh4q8SrPqJN/F4hWQAODcgUM0uXZ/DW9PKHYlH6FgJ2Dw+jo
         4ALCSw7lCAKuasHQHiyxZMkaKd625st/Vx97hI4T8y93hsTvGtlR9MZ6z09gdDbFA4hE
         Xg342mEhVKwixPh+z0pgZN+shhVtXVZY4MoM3/J1DUVtD3OtVPHvaCty9c4owzKIL5XQ
         4CmijclMR65liFDW7H40kdpngCgiUSIGjA5v9C1r29dO6oOwczfToldGogfWjk47P5ek
         jfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sBZ9DyBAW8D3kMNMwZLbPeooIyLhBukrSO0BSiX2HYE=;
        b=AveYBtw58UATtUi71ge1PbJTEvos0fryR7+XDcv/dDEBxsBJl1nwbubIGu02BvaRvl
         TgHoZKCxVJtQq2CZOyHUVLaRUfhkt8mZSMKGcje/2agJTMTP/xOlx/a1YrndP5lrgsPb
         8SGp/IAuKPoUmMuoQ4Y7j64OvU8oRyVlXon7QnMZH0OyWm9Fn5wHq+ipIUVkny5i9Oqz
         XQpJXRHbaR9PL1GBn8LG3/1ps6maMJjbFE94sp9LcRB3+BWuBmTtvglPkKbOmdiOynHs
         +2q7K2BwyfkKEEOZv6JQqBfJkipj8PRD6AERhaDZGfadvBF/uTmj9bUKZAGfbj/nEDA1
         EtuQ==
X-Gm-Message-State: AOAM531AeTNpFbu/RL4scypvCvExkqE7iqvG4NqREEjTruglke0r8D0y
        kof1Z67EEI3+YlkgAxl7UOU=
X-Google-Smtp-Source: ABdhPJyMZhKcRuwwku2wYrbJEnlLYOMrpvcsBzIVEz6hgEQr71hxsHzTNXNx5CLlxltbKMrj+Rot/Q==
X-Received: by 2002:aca:f089:: with SMTP id o131mr14205066oih.37.1628472689724;
        Sun, 08 Aug 2021 18:31:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o13sm2933666otl.58.2021.08.08.18.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 18:31:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 8 Aug 2021 18:31:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        kernel test robot <lkp@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] openrisc: Fix compiler warnings in setup
Message-ID: <20210809013128.GA3698029@roeck-us.net>
References: <20210805030035.2994973-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805030035.2994973-1-shorne@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 12:00:33PM +0900, Stafford Horne wrote:
> This was pointed out with the recent name change of or32_early_setup to
> or1k_early_setup.  Investigating the file I found a few other warnings
> so cleaning them up here.
> 
>     arch/openrisc/kernel/setup.c:220:13: warning: no previous prototype for 'or1k_early_setup' [-Wmissing-prototypes]
>       220 | void __init or1k_early_setup(void *fdt)
> 	  |             ^~~~~~~~~~~~~~~~
> 
> Fix this the missing or1k_early_setup prototype warning by adding an
> asm/setup.h file to define the prototype.
> 
>     arch/openrisc/kernel/setup.c:246:13: warning: no previous prototype for 'detect_unit_config' [-Wmissing-prototypes]
>       246 | void __init detect_unit_config(unsigned long upr, unsigned long mask,
> 	  |             ^~~~~~~~~~~~~~~~~~
> 
> The function detect_unit_config is not used, just remove it.
> 
>     arch/openrisc/kernel/setup.c:221: warning: Function parameter or member 'fdt' not described in 'or1k_early_setup'
> 
> Add @fdt docs to the function comment to suppress this warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Puzzled. This patch gives me:

Building openrisc:or1ksim_defconfig ... failed
------------
Error log:
In file included from ./arch/openrisc/include/asm/page.h:35,
                 from ./include/linux/generic-radix-tree.h:39,
                 from lib/generic-radix-tree.c:3:
./arch/openrisc/include/asm/setup.h:11:13: error:
		expected '=', ',', ';', 'asm' or '__attribute__' before 'or1k_early_setup'
   11 | void __init or1k_early_setup(void *fdt);
      |             ^~~~~~~~~~~~~~~~
make[1]: *** [scripts/Makefile.build:272: lib/generic-radix-tree.o] Error 1

Bisect log attached for completeness.

Guenter

---
# bad: [7999516e20bd9bb5d1f7351cbd05ca529a3a8d60] Add linux-next specific files for 20210806
# good: [c500bee1c5b2f1d59b1081ac879d73268ab0ff17] Linux 5.14-rc4
git bisect start 'HEAD' 'v5.14-rc4'
# bad: [66f67fa46df4630dfcad6bd2d3bb4af20d3a2490] Merge remote-tracking branch 'mlx5-next/mlx5-next'
git bisect bad 66f67fa46df4630dfcad6bd2d3bb4af20d3a2490
# bad: [e2e00a1babe63d45518d967d17f4f17a31b051fa] Merge remote-tracking branch 'cifsd/cifsd-for-next'
git bisect bad e2e00a1babe63d45518d967d17f4f17a31b051fa
# good: [d1af031ab8b8114a190af28e8f70636e8dbbd9d1] Merge remote-tracking branch 'qcom/for-next'
git bisect good d1af031ab8b8114a190af28e8f70636e8dbbd9d1
# bad: [014a079a3d5f4e6426e42659284911abc1ae7b58] Merge remote-tracking branch 'pidfd/for-next'
git bisect bad 014a079a3d5f4e6426e42659284911abc1ae7b58
# good: [4e2cdb3c5c59ae30a2e282734d57d9aeaf428ce1] Merge remote-tracking branch 'clk/clk-next'
git bisect good 4e2cdb3c5c59ae30a2e282734d57d9aeaf428ce1
# good: [e6e9bca186a091f1fbbfe202c65b1e4f099476a2] Merge branch 'features' into for-next
git bisect good e6e9bca186a091f1fbbfe202c65b1e4f099476a2
# good: [dcc54fc624d3a285ccbe97e9bbe3a6b26f1dfc01] Merge remote-tracking branch 'mips/mips-next'
git bisect good dcc54fc624d3a285ccbe97e9bbe3a6b26f1dfc01
# bad: [9dec8a9fb4d32a212290548f166e39d8a1d02e61] Merge remote-tracking branch 'risc-v/for-next'
git bisect bad 9dec8a9fb4d32a212290548f166e39d8a1d02e61
# bad: [a82c3bd806da0fb68319be21f088bdb70712ed6c] Merge remote-tracking branch 'powerpc/next'
git bisect bad a82c3bd806da0fb68319be21f088bdb70712ed6c
# bad: [01315cd759a2c7c1436b661cc1f54c202f127b4a] Merge remote-tracking branch 'parisc-hd/for-next'
git bisect bad 01315cd759a2c7c1436b661cc1f54c202f127b4a
# bad: [19e14f3a81d227f1c8b8d5371de28b3ab3deb556] openrisc: Fix compiler warnings in setup
git bisect bad 19e14f3a81d227f1c8b8d5371de28b3ab3deb556
# good: [11648cbb7b335b7eb54e1ff973fb938939616f46] openrisc: rename or32 code & comments to or1k
git bisect good 11648cbb7b335b7eb54e1ff973fb938939616f46
# first bad commit: [19e14f3a81d227f1c8b8d5371de28b3ab3deb556] openrisc: Fix compiler warnings in setup
