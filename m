Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A22307815
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhA1Oaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:30:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231563AbhA1OaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:30:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AB4764DE1;
        Thu, 28 Jan 2021 14:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611844169;
        bh=KBjN8q3mMJRlZhvQryfNCm4f61GPKpVCwN7pH9ADCTU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uKvkO3BhkTD4e3twptTdvfucYn/gg1Eq3X0d74Ssnoy8K3sz5T0Qn55Cqa5O01rCX
         lca4aua3exXDpXxMvSuyaJWvUgpXlZV3T03tm7jP6/yn5L+oIulmidg0RBsYy6kheV
         DXAa7uECMlzAjeiSoozTbcttuC7YZE4dnUjwrEvqnCKv1N83hmWuqLFAnWxNjloSWe
         gYttDKbcVvyW6tye1TF6JejXhsHxAr2T3/CHBT8fUMh32gn0wI+m0N2ZX0xXRyxZk2
         sPd5iqtCKMIN0Ot5gMOiYtDfRHwM5EbQt8jwuXiFbFwS0b1p3Vwm63XKRLWiQmg4xp
         EJVY9WvDVk12w==
Received: by mail-oo1-f42.google.com with SMTP id n127so1444305ooa.13;
        Thu, 28 Jan 2021 06:29:29 -0800 (PST)
X-Gm-Message-State: AOAM532ZgZcs5W4sSz5AJb3asI8vZYWdqvilXbhKNN2UE1V9/L3gxbUR
        admRTk83738PQwFB3oj0EDIqRm1znFV4PKRC3n4=
X-Google-Smtp-Source: ABdhPJyE7pTmoGSVWTeD0pXYBDZ0WFZf158irr7xUNd6Z1QRS7e2GGFcwq87tnobHzsruRxDsYVrcHKFSvxe9Ys1CbQ=
X-Received: by 2002:a4a:9c01:: with SMTP id y1mr11511239ooj.15.1611844168744;
 Thu, 28 Jan 2021 06:29:28 -0800 (PST)
MIME-Version: 1.0
References: <20210116032740.873-1-thunder.leizhen@huawei.com> <20210116032740.873-2-thunder.leizhen@huawei.com>
In-Reply-To: <20210116032740.873-2-thunder.leizhen@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 28 Jan 2021 15:29:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a09ypz4HjJUofFaV2NZd_3=0woC6es6w+E1_cvE=9K4UQ@mail.gmail.com>
Message-ID: <CAK8P3a09ypz4HjJUofFaV2NZd_3=0woC6es6w+E1_cvE=9K4UQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] ARM: LPAE: Use phys_addr_t instead of unsigned
 long in outercache hooks
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
>
> The outercache of some Hisilicon SOCs support physical addresses wider
> than 32-bits. The unsigned long datatype is not sufficient for mapping
> physical addresses >= 4GB. The commit ad6b9c9d78b9 ("ARM: 6671/1: LPAE:
> use phys_addr_t instead of unsigned long in outercache functions") has
> already modified the outercache functions. But the parameters of the
> outercache hooks are not changed. This patch use phys_addr_t instead of
> unsigned long in outercache hooks: inv_range, clean_range, flush_range.
>
> To ensure the outercache that does not support LPAE works properly, do
> cast phys_addr_t to unsigned long by adding a group of temporary
> variables. For example:
> -static void l2c220_inv_range(unsigned long start, unsigned long end)
> +static void l2c220_inv_range(phys_addr_t pa_start, phys_addr_t pa_end)
>  {
> +       unsigned long start = pa_start;
> +       unsigned long end = pa_end;
>
> Note that the outercache functions have been doing this cast before this
> patch. So now, the cast is just moved into the outercache hook functions.
>
> No functional change.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
