Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C79A3077FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhA1OZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:25:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231499AbhA1OZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:25:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F20B764DD9;
        Thu, 28 Jan 2021 14:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611843878;
        bh=IFq9vpqR5FT1gWJTSY1mRcrK90EYte/9qTdUSp00E20=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FyCvc++PNlxfdHVDADvHTQe0UhndyFM2USRsyxhHyBrkJuM+Lly1QYn6mOD6CExrP
         Ib37ZJ53FE9wKYQvdoipEVQzvPHrkRvoVZM3gf+dU0UiXjsHH2Nzi6OCyZO0hiM/TG
         GrcSii09dmE7F7ZQjzwiMCTzAeBrHPO1NQXkk8j6yV/kRFBNLPzIfcnfvRy2ErWryL
         XimDkuMmG5ncXzJmkxCgKTldU4ihfLOW1b/3E0RBB52jlYyyYbztd4vMBJaFizEwF4
         uX5kW3qw+UIELrPedBsfSEd9bGWNWDuSIz413nqnkVQs6THqHDQZzgFd5yquwpFbcp
         37i1OrAe3BITg==
Received: by mail-ot1-f43.google.com with SMTP id d7so5293462otf.3;
        Thu, 28 Jan 2021 06:24:37 -0800 (PST)
X-Gm-Message-State: AOAM5329qgzJfcX5GBi2XKpc+tYaZYiU8ucwGhwXN302uyVDjtds8ySw
        jYPA2uWr3yJwcOgWRQEXBI/fQzeacf99kcgMeQI=
X-Google-Smtp-Source: ABdhPJyZa8PFWVMcMDD93BJcyrpZNTztUUxS81dsHugIN8S/2CcOdc3k6Yj5Ss8OqDyNEkyGGiQK4erltuiySKq7tgE=
X-Received: by 2002:a9d:3bb7:: with SMTP id k52mr11872539otc.251.1611843877171;
 Thu, 28 Jan 2021 06:24:37 -0800 (PST)
MIME-Version: 1.0
References: <20210116032740.873-1-thunder.leizhen@huawei.com> <20210116032740.873-5-thunder.leizhen@huawei.com>
In-Reply-To: <20210116032740.873-5-thunder.leizhen@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 28 Jan 2021 15:24:20 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1OqUn5A4F4hT4K=bzQwJuifVFZkvFoK6NMg+m9FjoKzw@mail.gmail.com>
Message-ID: <CAK8P3a1OqUn5A4F4hT4K=bzQwJuifVFZkvFoK6NMg+m9FjoKzw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] ARM: Add support for Hisilicon Kunpeng L3 cache controller
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

On Sat, Jan 16, 2021 at 4:27 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
> +
> +static void l3cache_maint_common(u32 range, u32 op_type)
> +{
> +       u32 reg;
> +
> +       reg = readl(l3_ctrl_base + L3_MAINT_CTRL);
> +       reg &= ~(L3_MAINT_RANGE_MASK | L3_MAINT_TYPE_MASK);
> +       reg |= range | op_type;
> +       reg |= L3_MAINT_STATUS_START;
> +       writel(reg, l3_ctrl_base + L3_MAINT_CTRL);

Are there contents of L3_MAINT_CTRL that need to be preserved
across calls and can not be inferred? A 'readl()' is often expensive,
so it might be more efficient if you can avoid that.

> +static inline void l3cache_flush_all_nolock(void)
> +{
> +       l3cache_maint_common(L3_MAINT_RANGE_ALL, L3_MAINT_TYPE_FLUSH);
> +}
> +
> +static void l3cache_flush_all(void)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&l3cache_lock, flags);
> +       l3cache_flush_all_nolock();
> +       spin_unlock_irqrestore(&l3cache_lock, flags);
> +}

I see that cache-l2x0 uses raw_spin_lock_irqsave() instead of
spin_lock_irqsave(), to avoid preemption in the middle of a cache
operation. This is probably a good idea here as well.

I also see that l2x0 uses readl_relaxed(), to avoid a deadlock
in l2x0_cache_sync(). This may also be beneficial for performance
reasons, so it might be helpful to compare performance
overhead. On the other hand, readl()/writel() are usually the
safe choice, as those avoid the need to argue over whether
the relaxed versions are safe in all corner cases.

> +static int __init l3cache_init(void)
> +{
> +       u32 reg;
> +       struct device_node *node;
> +
> +       node = of_find_matching_node(NULL, l3cache_ids);
> +       if (!node)
> +               return -ENODEV;

I think the initcall should return '0' to indicate success when running
a kernel with this driver built-in on a platform that does not have
this device.

> diff --git a/arch/arm/mm/cache-kunpeng-l3.h b/arch/arm/mm/cache-kunpeng-l3.h
> new file mode 100644
> index 000000000000000..9ef6a53e7d4db49
> --- /dev/null
> +++ b/arch/arm/mm/cache-kunpeng-l3.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __CACHE_KUNPENG_L3_H
> +#define __CACHE_KUNPENG_L3_H
> +
> +#define L3_CACHE_LINE_SHITF            6

I would suggest moving the contents of the header file into the .c file,
since there is only a single user of these macros.

          Arnd
