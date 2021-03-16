Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6325733D161
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbhCPKGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:06:52 -0400
Received: from foss.arm.com ([217.140.110.172]:58288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233330AbhCPKGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:06:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92DE3D6E;
        Tue, 16 Mar 2021 03:06:21 -0700 (PDT)
Received: from [10.37.8.5] (unknown [10.37.8.5])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BCF73F70D;
        Tue, 16 Mar 2021 03:06:19 -0700 (PDT)
Subject: Re: [PATCH v16 6/9] arm64: mte: Conditionally compile
 mte_enable_kernel_*()
To:     Catalin Marinas <catalin.marinas@arm.com>
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
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210315132019.33202-1-vincenzo.frascino@arm.com>
 <20210315132019.33202-7-vincenzo.frascino@arm.com>
 <20210315184152.GC22897@arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <3f0b916b-efa5-ad35-b838-34f1edf2ba3a@arm.com>
Date:   Tue, 16 Mar 2021 10:06:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210315184152.GC22897@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/21 6:41 PM, Catalin Marinas wrote:
> On Mon, Mar 15, 2021 at 01:20:16PM +0000, Vincenzo Frascino wrote:
>> mte_enable_kernel_*() are not needed if KASAN_HW is disabled.
>>
>> Add ash defines around the functions to conditionally compile the
>> functions.
>>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> (BTW, Andrey now has a different email address; use the one in the
> MAINTAINERS file)
> 

I did not notice the change, sorry. Than you for updating the address.

-- 
Regards,
Vincenzo
