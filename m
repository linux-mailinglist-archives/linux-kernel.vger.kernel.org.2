Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A3331549B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 18:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhBIRD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 12:03:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233095AbhBIRDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:03:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAB0764E31;
        Tue,  9 Feb 2021 17:02:58 +0000 (UTC)
Date:   Tue, 9 Feb 2021 17:02:56 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm] arm64: kasan: fix MTE symbols exports
Message-ID: <20210209170255.GG1435@arm.com>
References: <dd36936c3d99582a623c8f01345f618ed4c036dd.1612884525.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd36936c3d99582a623c8f01345f618ed4c036dd.1612884525.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 04:32:30PM +0100, Andrey Konovalov wrote:
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index a66c2806fc4d..788ef0c3a25e 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -113,13 +113,17 @@ void mte_enable_kernel(void)
>  	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
>  	isb();
>  }
> +#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
>  EXPORT_SYMBOL_GPL(mte_enable_kernel);
> +#endif
>  
>  void mte_set_report_once(bool state)
>  {
>  	WRITE_ONCE(report_fault_once, state);
>  }
> +#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
>  EXPORT_SYMBOL_GPL(mte_set_report_once);
> +#endif

Do we actually care about exporting them when KASAN_KUNIT_TEST=n? It
looks weird to have these #ifdefs in the arch code. Either the
arch-kasan API requires these symbols to be exported to modules or not.
I'm not keen on such kasan internals trickling down into the arch code.

If you don't want to export them in the KASAN_KUNIT_TEST=n case, add a
wrapper in the kasan built-in code (e.g. kasan_test_enable_tagging,
kasan_test_set_report_once) and conditionally compile them based on
KASAN_KUNIT_TEST.

-- 
Catalin
