Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC17314EA3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhBIMEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:04:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhBIMDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:03:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C57E64DB1;
        Tue,  9 Feb 2021 12:02:44 +0000 (UTC)
Date:   Tue, 9 Feb 2021 12:02:42 +0000
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
Subject: Re: [PATCH v12 7/7] kasan: don't run tests in async mode
Message-ID: <20210209120241.GF1435@arm.com>
References: <20210208165617.9977-1-vincenzo.frascino@arm.com>
 <20210208165617.9977-8-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208165617.9977-8-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 04:56:17PM +0000, Vincenzo Frascino wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Asynchronous KASAN mode doesn't guarantee that a tag fault will be
> detected immediately and causes tests to fail. Forbid running them
> in asynchronous mode.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

That's missing your SoB.

> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 7285dcf9fcc1..f82d9630cae1 100644
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
>  
>  	multishot = kasan_save_enable_multi_shot();
>  	hw_set_tagging_report_once(false);

I think we can still run the kasan tests in async mode if we check the
TFSR_EL1 at the end of each test by calling mte_check_tfsr_exit().

-- 
Catalin
