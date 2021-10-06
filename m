Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D8D423FF9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbhJFOYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:24:17 -0400
Received: from foss.arm.com ([217.140.110.172]:56704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231356AbhJFOYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:24:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18B136D;
        Wed,  6 Oct 2021 07:22:24 -0700 (PDT)
Received: from [10.57.43.152] (unknown [10.57.43.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 012703F66F;
        Wed,  6 Oct 2021 07:22:20 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] kasan: Extend KASAN mode kernel parameter
To:     Marco Elver <elver@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20211004202253.27857-1-vincenzo.frascino@arm.com>
 <20211004202253.27857-6-vincenzo.frascino@arm.com>
 <YV2J8/i7C/FYf4F1@elver.google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <53a2d27a-57f7-a5c8-d8d0-17c78d95decd@arm.com>
Date:   Wed, 6 Oct 2021 16:22:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YV2J8/i7C/FYf4F1@elver.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/21 1:35 PM, Marco Elver wrote:
>> +static inline bool kasan_sync_fault_possible(void)
>> +{
>> +	return !kasan_flag_async | kasan_flag_asymm;
>>  }
> Is the choice of bit-wise OR a typo? Because this should probably have
> been logical OR. In this case, functionally it shouldn't matter, but is
> unusual style.

Good catch!

This is clearly a typo and a copy-paste of a typo ;)

-- 
Regards,
Vincenzo
