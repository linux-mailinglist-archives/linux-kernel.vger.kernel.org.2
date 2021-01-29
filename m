Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41195308CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhA2Sni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:43:38 -0500
Received: from foss.arm.com ([217.140.110.172]:52864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232012AbhA2Snb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:43:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50C0813A1;
        Fri, 29 Jan 2021 10:42:46 -0800 (PST)
Received: from [10.37.12.11] (unknown [10.37.12.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97AF73F885;
        Fri, 29 Jan 2021 10:42:43 -0800 (PST)
Subject: Re: [PATCH v9 3/4] kasan: Add report for async mode
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Branislav Rankov <Branislav.Rankov@arm.com>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20210126134603.49759-1-vincenzo.frascino@arm.com>
 <20210126134603.49759-4-vincenzo.frascino@arm.com>
 <CAAeHK+xAbsX9Zz4aKXToNTrbgrrYck23ohGJHXvgeSTyZy=Odg@mail.gmail.com>
 <e5582f87-2987-a258-350f-1fac61822657@arm.com>
 <CAAeHK+x5O595yU9q03G8xPvwpU_3Y6bQhW=+09GziOuTPZNVHw@mail.gmail.com>
 <f1ad988d-6385-45e0-d683-048bfca0b9c0@arm.com>
Message-ID: <8021dbc4-8745-2430-8d52-6236ae8c47c7@arm.com>
Date:   Fri, 29 Jan 2021 18:46:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f1ad988d-6385-45e0-d683-048bfca0b9c0@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 1/29/21 6:16 PM, Vincenzo Frascino wrote:
> What I meant is instead of:
> 
> if (addr) trace_error_report_end(...);
> 
> you might want to do:
> 
> if (!IS_ENABLED(CONFIG_KASAN_HW_TAGS)) trace_error_report_end(...);
> 
> because, could make sense to trace 0 in other cases?
> 
> I could not find the implementation of trace_error_report_end() hence I am not
> really sure on what it does.

I figured it out how trace_error_report_end() works. And in doing that I
realized that the problem is sync vs async, hence I agree with what you are
proposing:

if (addr) trace_error_report_end(...);

I will post v10 shortly. If we want to trace the async mode we can improve it in
-rc1.

-- 
Regards,
Vincenzo
