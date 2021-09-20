Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB02C41184C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241701AbhITPdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:33:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241638AbhITPdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:33:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 415E3610FB;
        Mon, 20 Sep 2021 15:32:03 +0000 (UTC)
Date:   Mon, 20 Sep 2021 16:32:00 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 5/5] kasan: Extend KASAN mode kernel parameter
Message-ID: <YUipcLV5CZ4x1i+1@arm.com>
References: <20210913081424.48613-1-vincenzo.frascino@arm.com>
 <20210913081424.48613-6-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913081424.48613-6-vincenzo.frascino@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 09:14:24AM +0100, Vincenzo Frascino wrote:
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 21dc03bc10a4..7f43e603bfbe 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -194,14 +194,20 @@ additional boot parameters that allow disabling KASAN or controlling features:
>  
>  - ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
>  
> -- ``kasan.mode=sync`` or ``=async`` controls whether KASAN is configured in
> -  synchronous or asynchronous mode of execution (default: ``sync``).
> +- ``kasan.mode=sync``, ``=async`` or ``=asymm`` controls whether KASAN
> +  is configured in synchronous, asynchronous or asymmetric mode of
> +  execution (default: ``sync``).
>    Synchronous mode: a bad access is detected immediately when a tag
>    check fault occurs.
>    Asynchronous mode: a bad access detection is delayed. When a tag check
>    fault occurs, the information is stored in hardware (in the TFSR_EL1
>    register for arm64). The kernel periodically checks the hardware and
>    only reports tag faults during these checks.
> +  Asymmetric mode: a bad access is detected immediately when a tag
> +  check fault occurs during a load operation and its detection is
> +  delayed during a store operation. For the store operations the kernel
> +  periodically checks the hardware and only reports tag faults during
> +  these checks.

Nitpick: I'd simply refer to the sync/async which already describe what
the kernel and hardware does, something like the tag checks synchronous
on reads and asynchronous on writes.

Otherwise:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
