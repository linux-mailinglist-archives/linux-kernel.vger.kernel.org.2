Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2AF33907D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhCLO4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:56:38 -0500
Received: from foss.arm.com ([217.140.110.172]:55026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231987AbhCLO4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:56:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE5171FB;
        Fri, 12 Mar 2021 06:56:10 -0800 (PST)
Received: from [10.37.8.6] (unknown [10.37.8.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0B0A3F7D7;
        Fri, 12 Mar 2021 06:56:08 -0800 (PST)
Subject: Re: [PATCH v15 8/8] kasan, arm64: tests supports for HW_TAGS async
 mode
To:     Andrey Konovalov <andreyknvl@google.com>
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
References: <20210312142210.21326-1-vincenzo.frascino@arm.com>
 <20210312142210.21326-9-vincenzo.frascino@arm.com>
 <CAAeHK+yoeLfkztNCifJuZooBwe+9np98ch50-ToOGKi1swC1vw@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <8da687d6-9aa3-f419-0efe-b460c3ef3952@arm.com>
Date:   Fri, 12 Mar 2021 14:56:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+yoeLfkztNCifJuZooBwe+9np98ch50-ToOGKi1swC1vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/12/21 2:49 PM, Andrey Konovalov wrote:
> On Fri, Mar 12, 2021 at 3:22 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> From: Andrey Konovalov <andreyknvl@google.com>
>>
>> This change adds KASAN-KUnit tests support for the async HW_TAGS mode.
>>
>> In async mode, tag fault aren't being generated synchronously when a
>> bad access happens, but are instead explicitly checked for by the kernel.
>>
>> As each KASAN-KUnit test expect a fault to happen before the test is over,
>> check for faults as a part of the test handler.
>>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> I believe this needs your Signed-off-by as well, Vincenzo.
> 

Ah yes, in case I do not need to repost:

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

-- 
Regards,
Vincenzo
