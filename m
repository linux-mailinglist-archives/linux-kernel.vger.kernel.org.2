Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5673322E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhCIKWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:22:37 -0500
Received: from foss.arm.com ([217.140.110.172]:51000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230266AbhCIKWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:22:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A70FA31B;
        Tue,  9 Mar 2021 02:22:32 -0800 (PST)
Received: from [10.37.8.8] (unknown [10.37.8.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91BBD3F71B;
        Tue,  9 Mar 2021 02:22:29 -0800 (PST)
Subject: Re: [PATCH v14 5/8] arm64: mte: Enable TCO in functions that can read
 beyond buffer limits
To:     Mark Rutland <mark.rutland@arm.com>
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
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210308161434.33424-1-vincenzo.frascino@arm.com>
 <20210308161434.33424-6-vincenzo.frascino@arm.com>
 <20210308180910.GB17002@C02TD0UTHF1T.local>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <42b39ecc-4f97-63bf-cdab-2ba4817b8610@arm.com>
Date:   Tue, 9 Mar 2021 10:26:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210308180910.GB17002@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/21 6:09 PM, Mark Rutland wrote:
>> +DECLARE_STATIC_KEY_FALSE(mte_async_mode);
> Can we please hide this behind something like:
> 
> static inline bool system_uses_mte_async_mode(void)
> {
> 	return IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&
> 		static_branch_unlikely(&mte_async_mode);
> }
> 
> ... like we do for system_uses_ttbr0_pan()?
>

I agree, it is a cleaner solution. I will add it to v15.

> That way the callers are easier to read, and kernels built without
> CONFIG_KASAN_HW_TAGS don't have the static branch at all. I reckon you
> can put that in one of hte mte headers and include it where needed.

-- 
Regards,
Vincenzo
