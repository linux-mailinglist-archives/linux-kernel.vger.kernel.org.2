Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E67424005
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbhJFO0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:26:47 -0400
Received: from foss.arm.com ([217.140.110.172]:57154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231600AbhJFO0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:26:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F5EC6D;
        Wed,  6 Oct 2021 07:24:54 -0700 (PDT)
Received: from [10.57.43.152] (unknown [10.57.43.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 378173F66F;
        Wed,  6 Oct 2021 07:24:51 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] kasan: Extend KASAN mode kernel parameter
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20211004202253.27857-1-vincenzo.frascino@arm.com>
 <20211004202253.27857-6-vincenzo.frascino@arm.com>
 <CA+fCnZfuu3MLgeSJONqKaXMzkBsGxTQYjTtF0_=fMf4dGGQZCw@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <a0cb9136-186e-77f2-8f5f-ead2209cbf6e@arm.com>
Date:   Wed, 6 Oct 2021 16:25:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+fCnZfuu3MLgeSJONqKaXMzkBsGxTQYjTtF0_=fMf4dGGQZCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/21 2:19 PM, Andrey Konovalov wrote:
>> +static inline bool kasan_sync_fault_possible(void)
>> +{
>> +       return !kasan_flag_async | kasan_flag_asymm;
> This should be just !kasan_flag_async.
> 
> It seems that choosing one exclusive option out of 3 via two bools is
> confusing. How about an enum?
> 
> enum kasan_mode {
>   KASAN_MODE_SYNC,
>   KASAN_MODE_ASYNC,
>   KASAN_MODE_ASYMM,
> };
> 
> enum kasan_mode kasan_mode __ro_after_init;
> EXPORT_SYMBOL_GPL(kasan_mode);

Fine by me. I will change the code in v3.

Thanks!

-- 
Regards,
Vincenzo
