Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5BF30F342
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbhBDMgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:36:00 -0500
Received: from foss.arm.com ([217.140.110.172]:57632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235990AbhBDMf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:35:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B58ABD6E;
        Thu,  4 Feb 2021 04:35:11 -0800 (PST)
Received: from [10.37.8.15] (unknown [10.37.8.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B65A63F73B;
        Thu,  4 Feb 2021 04:35:08 -0800 (PST)
Subject: Re: [PATCH 10/12] arm64: kasan: simplify and inline MTE functions
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1612208222.git.andreyknvl@google.com>
 <17d6bef698d193f5fe0d8baee0e232a351e23a32.1612208222.git.andreyknvl@google.com>
 <20210201144407.dd603ec4edcd589643654057@linux-foundation.org>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <f87043c9-6126-c87b-a5c6-b48f28556b92@arm.com>
Date:   Thu, 4 Feb 2021 12:39:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201144407.dd603ec4edcd589643654057@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 2/1/21 10:44 PM, Andrew Morton wrote:
> On Mon,  1 Feb 2021 20:43:34 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:
> 
>> This change provides a simpler implementation of mte_get_mem_tag(),
>> mte_get_random_tag(), and mte_set_mem_tag_range().
>>
>> Simplifications include removing system_supports_mte() checks as these
>> functions are onlye called from KASAN runtime that had already checked
>> system_supports_mte(). Besides that, size and address alignment checks
>> are removed from mte_set_mem_tag_range(), as KASAN now does those.
>>
>> This change also moves these functions into the asm/mte-kasan.h header
>> and implements mte_set_mem_tag_range() via inline assembly to avoid
>> unnecessary functions calls.
>>
>> Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> Co-developed-by requires a Signed-off-by: as well.  Vincenzo, please
> send us one?
> 
> 

I added my Signed-off-by to the patch.

-- 
Regards,
Vincenzo
