Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED409314D82
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhBIKvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:51:02 -0500
Received: from foss.arm.com ([217.140.110.172]:49366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231923AbhBIKhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:37:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 060BF101E;
        Tue,  9 Feb 2021 02:37:04 -0800 (PST)
Received: from [10.37.8.18] (unknown [10.37.8.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FE4D3F73B;
        Tue,  9 Feb 2021 02:37:00 -0800 (PST)
Subject: Re: [PATCH v12 6/7] arm64: mte: Save/Restore TFSR_EL1 during suspend
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
References: <20210208165617.9977-1-vincenzo.frascino@arm.com>
 <20210208165617.9977-7-vincenzo.frascino@arm.com>
 <20210208185635.GA13187@e121166-lin.cambridge.arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <a6ac58ef-f437-8a77-d288-c4de3316692f@arm.com>
Date:   Tue, 9 Feb 2021 10:41:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210208185635.GA13187@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

thank you for your review.

On 2/8/21 6:56 PM, Lorenzo Pieralisi wrote:
>>  u64 gcr_kernel_excl __ro_after_init;
>>  
>> +static u64 mte_suspend_tfsr_el1;
> IIUC you need this per-CPU (core loses context on suspend-to-RAM but also
> CPUidle, S2R is single threaded but CPUidle runs on every core idle
> thread).
> 
> Unless you sync/report it on enter/exit (please note: I am not familiar
> with MTE so it is just a, perhaps silly, suggestion to avoid
> saving/restoring it).
> 

I thought about making it per cpu, but I concluded that since it is an
asynchronous tag fault it wasn't necessary.

But thinking at it from the statistical point of view what you are saying is
completely right, because we might end up in scenario in which we report the
fault on multiple cores when it happens on one or in a scenario in which we do
not report the potential fault at all.

I am going to update my code accordingly in the next version.

Thanks!

> Lorenzo
> 

-- 
Regards,
Vincenzo
