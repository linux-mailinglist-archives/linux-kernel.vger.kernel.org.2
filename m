Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4738D30BC57
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhBBKrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:47:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhBBKrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:47:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 086A764D9C;
        Tue,  2 Feb 2021 10:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612262784;
        bh=gfOQNZ7G78RU5qq+yafqTPPx1P9+C1SAieHv2S8LSFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=maVk3g8jWAQtT35U+1bb5uuYJNlw1sZebL6JbZSh5THuX8IG0VuSXq60U/4iBuvZl
         ZJLsY7exmv5UV6pD84cGj/uZfvSd7a68sYoyZlbef82f4jpQ4zoPFmaunyw2QjgwhA
         BqtILb+MOsS8lBPRpTOhP8TdJc38D+nJbb6JDTiQfCYO/YUnQSiL/fPyrHcDFSSZyN
         n6qmEHQLwdSGjePXCY7B064FQbq5D2oqAJQPtNqfYLICqls+++BnuY2fvGiJpMD40T
         bcbcOPGqLt9MlKbCllS4n9r2rnrtEW8vHUSKwfSFYbFBeTyfym/5rGhaBOZAiFN3dU
         SvC/ywhw2OIMg==
Date:   Tue, 2 Feb 2021 10:46:18 +0000
From:   Will Deacon <will@kernel.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>
Subject: Re: [PATCH 12/12] arm64: kasan: export MTE symbols for KASAN tests
Message-ID: <20210202104618.GA16723@willie-the-truck>
References: <cover.1612208222.git.andreyknvl@google.com>
 <d128216d3b0aea0b4178e11978f5dd3e8dbeb590.1612208222.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d128216d3b0aea0b4178e11978f5dd3e8dbeb590.1612208222.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:43:36PM +0100, Andrey Konovalov wrote:
> Export mte_enable_kernel() and mte_set_report_once() to fix:
> 
> ERROR: modpost: "mte_enable_kernel" [lib/test_kasan.ko] undefined!
> ERROR: modpost: "mte_set_report_once" [lib/test_kasan.ko] undefined!
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/kernel/mte.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 8b27b70e1aac..2c91bd288ea4 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -120,6 +120,7 @@ void mte_enable_kernel_sync(void)
>  {
>  	__mte_enable_kernel("synchronous", SCTLR_ELx_TCF_SYNC);
>  }
> +EXPORT_SYMBOL(mte_enable_kernel_sync);
>  
>  void mte_enable_kernel_async(void)
>  {
> @@ -130,6 +131,7 @@ void mte_set_report_once(bool state)
>  {
>  	WRITE_ONCE(report_fault_once, state);
>  }
> +EXPORT_SYMBOL(mte_set_report_once);

EXPORT_SYMBOL_GPL ?

Will
