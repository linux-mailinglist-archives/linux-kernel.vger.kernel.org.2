Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2ED30A353
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 09:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhBAIc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 03:32:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232285AbhBAIcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:32:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 614CB64E34;
        Mon,  1 Feb 2021 08:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612168302;
        bh=J1P1joLDR0nqRCk/zFl2Cn6sO+3Nciht4h/kZRq/Wys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E/YY4r9v2WgviDwUNuAXIgg+TT+BcJ9BDjWOyw7aDgiF3W4uNjzgFv55WcfGM1km1
         lMG/xTDB50GuvvCVL98jmcdAO4eAGLIHm8l1AymLDK9tNinm1ELTtlY4LQtPjLphjV
         yY2jK7VCLMIZmr6J+K3fRcGNzVm/4ggOPTCJloZpiYc1Bc4Iq2Vw9CxyxxaMl80hJ2
         /MuSyUr165gf99tPInWAnvQtQ06gk1tkuo+jGs6d57+bisYL2PbnMOv5mdN10w4iuF
         hbYkiT+MFWBT7ls9rALWHkKFtmihawPkHTnyK5W91UtK1F1C7J1FFRSbdydI6kceHm
         pLJCDTZ6/KK9A==
Received: by mail-ot1-f46.google.com with SMTP id f6so15446702ots.9;
        Mon, 01 Feb 2021 00:31:42 -0800 (PST)
X-Gm-Message-State: AOAM533DxbqNPeWBOL7ku3Ru2Bn54E/TY7eziBILaW0zoiHAbN8g+tV8
        mIpvyY1MY2Csdct+9eccFAfBxQ4GWDBj0yC5mHs=
X-Google-Smtp-Source: ABdhPJz50h3GDHMu07uDYuvXiTFDDTml8zpx3oYtdZFPj3MP5bRTMMhCZRCDQlO05lqBYoDZe2WyGcDvWxa0qMukpPk=
X-Received: by 2002:a9d:3bb7:: with SMTP id k52mr11523053otc.251.1612168301459;
 Mon, 01 Feb 2021 00:31:41 -0800 (PST)
MIME-Version: 1.0
References: <20210201033601.1642-1-thunder.leizhen@huawei.com> <20210201033601.1642-5-thunder.leizhen@huawei.com>
In-Reply-To: <20210201033601.1642-5-thunder.leizhen@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 1 Feb 2021 09:31:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0=Aj0Ss3xbgh1ELyB+4d94ybugbza_xUqW_=yVsMwEqg@mail.gmail.com>
Message-ID: <CAK8P3a0=Aj0Ss3xbgh1ELyB+4d94ybugbza_xUqW_=yVsMwEqg@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] ARM: Add support for Hisilicon Kunpeng L3 cache controller
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 4:36 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Add support for the Hisilicon Kunpeng L3 cache controller as used with
> Kunpeng506 and Kunpeng509 SoCs.
>
> These Hisilicon SoCs support LPAE, so the physical addresses is wider than
> 32-bits, but the actual bit width does not exceed 36 bits. When the cache
> operation is performed based on the address range, the upper 30 bits of
> the physical address are recorded in registers L3_MAINT_START and
> L3_MAINT_END, and ignore the lower 6 bits cacheline offset.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

If you add one more thing:

> +static void l3cache_maint_common(u32 range, u32 op_type)
> +{
> +       u32 reg;
> +
> +       reg = readl_relaxed(l3_ctrl_base + L3_MAINT_CTRL);
> +       reg &= ~(L3_MAINT_RANGE_MASK | L3_MAINT_TYPE_MASK);
> +       reg |= range | op_type;
> +       reg |= L3_MAINT_STATUS_START;
> +       writel(reg, l3_ctrl_base + L3_MAINT_CTRL);
> +
> +       /* Wait until the hardware maintenance operation is complete. */
> +       do {
> +               cpu_relax();
> +               reg = readl(l3_ctrl_base + L3_MAINT_CTRL);
> +       } while ((reg & L3_MAINT_STATUS_MASK) != L3_MAINT_STATUS_END);
> +}
> +
> +static void l3cache_maint_range(phys_addr_t start, phys_addr_t end, u32 op_type)
> +{
> +       start = start >> L3_CACHE_LINE_SHITF;
> +       end = ((end - 1) >> L3_CACHE_LINE_SHITF) + 1;
> +
> +       writel_relaxed(start, l3_ctrl_base + L3_MAINT_START);
> +       writel_relaxed(end, l3_ctrl_base + L3_MAINT_END);
> +
> +       l3cache_maint_common(L3_MAINT_RANGE_ADDR, op_type);
> +}

As mentioned, I'd like to see a code comment that explains the use
the of relaxed() vs non-relaxed MMIO accessors, as it will be impossible
for a reader to later understand why you picked a mix of the two,
and it also ensures that you have considered which one is the best
option to use here and that your explanation matches what you do.

Based on Russell's comments, I had expected that you would use
only relaxed accessors, plus explicit barriers if you change it, matching
what l2x0 does (l2x0 has to do it because of __l2c210_cache_sync(),
while you don't have a sync callback and don't need to).

      Arnd
