Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D7A30BA34
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhBBIp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:45:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232631AbhBBIpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:45:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 996BD64F5D;
        Tue,  2 Feb 2021 08:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612255505;
        bh=rNUWAU7WB2qCwoMniuXQ9F6TztiN6ongQBU64cqQadA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ewm9ejQ6tcU5JfvZeWB1hhJ5CdJzfm6d85hCGRX4320zfhd4QQnFenKfrob9LuY7K
         uk4pfakYa+hyb1GUOGfGTSuJvmHbhVft5K1+FIRkkRZv6hj9HjLyOb4A6aHvj+eDDu
         xbZgqoTH+bKcwynO80wQe0z4YWswv0ydfoHkxOwkEf3hWrSrQQnXkEuhn/0jaMulAT
         Qf2m6Ckf3CB9T5UTSUjdzX5OnHxpn9nYRu1ojn+AWvjlcbBRtILAzt+TYuF4+4ejAy
         8fLZi2fIKuA3TIgcp6inuNAm1m4HFJ83RghqIuUJODsCfRyKeZzt5WemaeMpfBuwxA
         ryDCabnFAwOZw==
Received: by mail-ot1-f44.google.com with SMTP id i30so19114219ota.6;
        Tue, 02 Feb 2021 00:45:05 -0800 (PST)
X-Gm-Message-State: AOAM531KQFeTomOpXr4CUnOf2bflZAyrhECbKzxXDLw4CSxt+80YEGFE
        Ixuf4jsjLAGKFnMpSY8mzLoNq3nFVqxPDxtDqGI=
X-Google-Smtp-Source: ABdhPJwetjqfByTE0czjCuve4ubOMYkcyMqS7kmg6+ElcmPElxSW2W18YbOKF2my9u+Lb/PPkez7UdujeynlAwTVYIY=
X-Received: by 2002:a05:6830:1256:: with SMTP id s22mr1091206otp.251.1612255504732;
 Tue, 02 Feb 2021 00:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20210202071648.1776-1-thunder.leizhen@huawei.com> <20210202071648.1776-5-thunder.leizhen@huawei.com>
In-Reply-To: <20210202071648.1776-5-thunder.leizhen@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 2 Feb 2021 09:44:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1HuXx7qpOPAdcGadtWCkNOp75bgO8cLSpXnobULHU6ZQ@mail.gmail.com>
Message-ID: <CAK8P3a1HuXx7qpOPAdcGadtWCkNOp75bgO8cLSpXnobULHU6ZQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] ARM: Add support for Hisilicon Kunpeng L3 cache controller
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

On Tue, Feb 2, 2021 at 8:16 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> +
> +/*
> + * All read and write operations on L3 cache registers are protected by the
> + * spinlock, except for l3cache_init(). Each time the L3 cache operation is
> + * performed, all related information is filled into its registers. Therefore,
> + * there is no memory order problem when only _relaxed() functions are used.

Thank you for including the text.

I don't think the explanation with the spin_lock() explains why this
can be considered safe though, as spin_lock() only contains serialization
against other CPUs (smp_mb()) rather than the stronger DMA barriers
implied by readl and writel. As Russell previously explained, these
barriers are the L1 cache operations (e.g. v7_dma_inv_range) do
include stronger barriers, so it would be better to come up with a
justification based on those.

> + * This can help us achieve some performance improvement:
> + * 1) The readl_relaxed() is about 20ns faster than readl().
> + * 2) The writel_relaxed() is about 123ns faster than writel().

These are not really the performance numbers I asked for, as a
low-level benchmark comparing the instructions is rather meaningless.
The time spent waiting for the barrier depends on what else is going
on around the barrier. Also, most of the time would likely be
spent spinning in the loop around readl() while the cache operations
are in progress, so the latency of a single readl() is not necessarily
significant.

To have a more useful performance number, try mentioning the
most performance sensitive non-coherent DMA master on one
of the chips that has this cache controller, and a high-level
performance number such as "1.2% more network packets per
second" if that is something you can measure easily.

Of course, if all high-speed DMA masters on this chip are
cache coherent, there is no need for performance numbers, just
mention that we don't care about speed in that case.

        Arnd
