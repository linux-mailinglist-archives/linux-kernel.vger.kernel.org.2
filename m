Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7FF41183D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241547AbhITPdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241519AbhITPdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:33:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80F0E60F58;
        Mon, 20 Sep 2021 15:31:36 +0000 (UTC)
Date:   Mon, 20 Sep 2021 16:31:33 +0100
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
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>
Subject: Re: [PATCH 3/5] arm64: mte: CPU feature detection for Asymm MTE
Message-ID: <YUipVXG/kObqo6MZ@arm.com>
References: <20210913081424.48613-1-vincenzo.frascino@arm.com>
 <20210913081424.48613-4-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913081424.48613-4-vincenzo.frascino@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 09:14:22AM +0100, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index f8a3067d10c6..a18774071a45 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2317,6 +2317,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.sign = FTR_UNSIGNED,
>  		.cpu_enable = cpu_enable_mte,
>  	},
> +	{
> +		.desc = "Asymmetric Memory Tagging Extension",

I'd give this a better name as it's not entirely clear what it does. In
the ARM ARM this is described as "asymmetric Tag Check Fault handling".
Maybe just rename it to "Asymmetric MTE Tag Check Fault". Similarly in
the Kconfig if you added one.

Otherwise:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
