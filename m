Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D6E309522
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 13:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhA3Mhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 07:37:42 -0500
Received: from foss.arm.com ([217.140.110.172]:35990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231252AbhA3Mhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 07:37:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F28FED1;
        Sat, 30 Jan 2021 04:36:53 -0800 (PST)
Received: from [10.37.8.6] (unknown [10.37.8.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AA313F71B;
        Sat, 30 Jan 2021 04:36:50 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v10 0/4] arm64: ARMv8.5-A: MTE: Add async mode support
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
        Branislav Rankov <Branislav.Rankov@arm.com>
References: <20210129184905.29760-1-vincenzo.frascino@arm.com>
 <CAAeHK+w5hHcN-4Q8KYpMnG1rQvz9N_kXc7=uY07nH=937MUTjA@mail.gmail.com>
Message-ID: <4e14f83d-26a6-b06a-7ef6-f11dcd5457d2@arm.com>
Date:   Sat, 30 Jan 2021 12:40:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+w5hHcN-4Q8KYpMnG1rQvz9N_kXc7=uY07nH=937MUTjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 1/29/21 7:21 PM, Andrey Konovalov wrote:
>> The series is based on linux-next/akpm.
>>
>> To simplify the testing a tree with the new patches on top has been made
>> available at [1].
>>
>> [1] https://git.gitlab.arm.com/linux-arm/linux-vf.git mte/v10.async.akpm
>>
>> Changes:
>> --------
>> v10:
>>   - Rebase on the latest linux-next/akpm
>>   - Address review comments.
> Thinking again about this: properly fixing that tracing issue is
> similar to fixing the issue with the tests. Let's do both as a part of
> this series.
> 
> Here's a tree with the fixes. I've marked the ones that need to be
> squashed with "fix!". PTAL, and if the additions look good, please
> send v11 with them included.
> 
> https://github.com/xairy/linux/commits/vf-v10.async.akpm-fixes

I checked your code this morning and it seems OK (very similar to my proposal in
logic but done in KASAN code as you anticipated).

I am fine to add the changes to my patches but before then that I would like to
conduct some testing, hence I will most likely have v11 sometimes this
afternoon/evening UK time.

-- 
Regards,
Vincenzo
