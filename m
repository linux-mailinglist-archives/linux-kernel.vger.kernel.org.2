Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEA531A37D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 18:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhBLRXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 12:23:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229796AbhBLRXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 12:23:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3912064E42;
        Fri, 12 Feb 2021 17:22:27 +0000 (UTC)
Date:   Fri, 12 Feb 2021 17:22:24 +0000
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
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v13 7/7] kasan: don't run tests in async mode
Message-ID: <20210212172224.GF7718@arm.com>
References: <20210211153353.29094-1-vincenzo.frascino@arm.com>
 <20210211153353.29094-8-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211153353.29094-8-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 03:33:53PM +0000, Vincenzo Frascino wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Asynchronous KASAN mode doesn't guarantee that a tag fault will be
> detected immediately and causes tests to fail. Forbid running them
> in asynchronous mode.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  lib/test_kasan.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index f8c72d3aed64..77a60592d350 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -51,6 +51,10 @@ static int kasan_test_init(struct kunit *test)
>  		kunit_err(test, "can't run KASAN tests with KASAN disabled");
>  		return -1;
>  	}
> +	if (kasan_flag_async) {
> +		kunit_err(test, "can't run KASAN tests in async mode");
> +		return -1;
> +	}

I think we have time to fix this properly ;), so I'd rather not add this
patch at all.

-- 
Catalin
