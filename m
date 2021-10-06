Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353F4423FF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbhJFOW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:22:57 -0400
Received: from foss.arm.com ([217.140.110.172]:56484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231438AbhJFOW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:22:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 078996D;
        Wed,  6 Oct 2021 07:21:04 -0700 (PDT)
Received: from [10.57.43.152] (unknown [10.57.43.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4CFC3F66F;
        Wed,  6 Oct 2021 07:21:00 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] arm64: mte: Add asymmetric mode support
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
 <20211004202253.27857-5-vincenzo.frascino@arm.com>
 <CA+fCnZeL48oLd8bbWgxomc6WnS4e53a7K6SwBpKBJND4f03f7A@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <2d03d87b-5ea8-8b2a-eae6-ae70c7e9d855@arm.com>
Date:   Wed, 6 Oct 2021 16:21:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+fCnZeL48oLd8bbWgxomc6WnS4e53a7K6SwBpKBJND4f03f7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/21 2:19 PM, Andrey Konovalov wrote:
>> +               if (!system_uses_mte_async_mode())
>> +                       static_branch_enable(&mte_async_mode);
> Using this variable and function here still looks confusing. Maybe
> naming the variable mte_async_or_asymm_mode? Or
> mte_async_fault_possible similarly to KASAN?
> 
> 

mte_async_or_asymm_mode works for me. I will modify the code in v3.

Thanks.

-- 
Regards,
Vincenzo
