Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CAD3096F8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 18:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhA3Q6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 11:58:44 -0500
Received: from foss.arm.com ([217.140.110.172]:38484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230045AbhA3Q6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 11:58:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6BCB1042;
        Sat, 30 Jan 2021 08:57:57 -0800 (PST)
Received: from [10.37.8.6] (unknown [10.37.8.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0B243F73D;
        Sat, 30 Jan 2021 08:57:54 -0800 (PST)
Subject: Re: [PATCH v11 5/5] kasan: don't run tests in async mode
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
References: <20210130165225.54047-1-vincenzo.frascino@arm.com>
 <20210130165225.54047-6-vincenzo.frascino@arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <ba95b920-9007-bf10-a09d-59f5d715a8c2@arm.com>
Date:   Sat, 30 Jan 2021 17:01:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210130165225.54047-6-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/21 4:52 PM, Vincenzo Frascino wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Asynchronous KASAN mode doesn't guarantee that a tag fault will be
> detected immediately and causes tests to fail. Forbid running them
> in asynchronous mode.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

With:

[   18.283644] 1..1
[   18.284167]     # Subtest: kasan
[   18.284444]     1..45
[   18.295536]     # kmalloc_oob_right: can't run KASAN tests in async mode
[   18.296873]     # kmalloc_oob_right: failed to initialize: -1
[   18.303714]     not ok 1 - kmalloc_oob_right
[   18.316439]     # kmalloc_oob_left: can't run KASAN tests in async mode
[   18.319466]     # kmalloc_oob_left: failed to initialize: -1
[   18.325001]     not ok 2 - kmalloc_oob_left

Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  lib/test_kasan.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
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
> 

-- 
Regards,
Vincenzo
