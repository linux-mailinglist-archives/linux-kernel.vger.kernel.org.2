Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F9B4452BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 13:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhKDMPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 08:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhKDMP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 08:15:28 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BAEC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 05:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gLU9WggaZavg+6NyQ3hpyjOtksdpJ/TShOqK7GdkMw4=; b=Z0s4jwh7ri7f1H2RLWUNQfj9WV
        +L4ndFTUgnQrayPC5Dx38K+Vu4rja35u9z2PJ3BXQjnGUfpyTQ+GYNBQFBBPqB5eFcwEgToC3JjxF
        cd2QjXqPRWiEVf+2bcDdvFz5ycY4EkE036ibD7/ECOOBY4YyZdFQPHC3Cb4Eb1Tpkonl6m0CoLtsR
        APK1tOlluPOpCd355uSHhw2EQoCqhUJRWm5nfHCZgykoUjDq29AA0Xga6xQQ6930Ce6XM+ojz6nLn
        tFx6DJRO7PgnnGMSeMZRH7/L4/BF3+45HDc3+6ZkKuG4QB6v9sBZVKoImCOFp0zeaqUKltelE/rx8
        GKMI9XsQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55470)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mibbo-0005vP-O8; Thu, 04 Nov 2021 12:12:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mibbl-0007Jg-Gu; Thu, 04 Nov 2021 12:12:41 +0000
Date:   Thu, 4 Nov 2021 12:12:41 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2 0/3] ARM: Support KFENCE feature
Message-ID: <YYPOObm72VH2l/AT@shell.armlinux.org.uk>
References: <20211103133845.78528-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211103133845.78528-1-wangkefeng.wang@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM tree is closed; we're in the mainline merge window. Please
resend after -rc1 is released.

On Wed, Nov 03, 2021 at 09:38:42PM +0800, Kefeng Wang wrote:
> This patchset supports Kfence feature, tested the kfence_test on ARM QEMU
> with or without ARM_LPAE and all passed.
> 
> V2:
> - drop patch4 in v1, which is used a new way to skip kfence test
>   see commit c40c6e593bf9 ("kfence: test: fail fast if disabled at boot")
> - fix some issue about NO MMU
>   - drop useless set_memory_valid() under no mmu
>   - fix implicit declaration of function ‘is_write_fault’ if no mmu
> - make KFENCE depends on !XIP_KERNEL, no tested with xip
> 
> v1:
> https://lore.kernel.org/linux-arm-kernel/20210825092116.149975-1-wangkefeng.wang@huawei.com/
> 
> Kefeng Wang (3):
>   ARM: mm: Provide set_memory_valid()
>   ARM: mm: Provide is_write_fault()
>   ARM: Support KFENCE for ARM
> 
>  arch/arm/Kconfig                  |  1 +
>  arch/arm/include/asm/kfence.h     | 53 +++++++++++++++++++++++++++++++
>  arch/arm/include/asm/set_memory.h |  1 +
>  arch/arm/mm/fault.c               | 16 ++++++++--
>  arch/arm/mm/pageattr.c            | 42 ++++++++++++++++++------
>  5 files changed, 100 insertions(+), 13 deletions(-)
>  create mode 100644 arch/arm/include/asm/kfence.h
> 
> -- 
> 2.26.2
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
