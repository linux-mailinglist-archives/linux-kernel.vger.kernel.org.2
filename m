Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9CD322A67
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhBWMTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:19:03 -0500
Received: from foss.arm.com ([217.140.110.172]:46614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231403AbhBWMTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:19:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9676831B;
        Tue, 23 Feb 2021 04:18:15 -0800 (PST)
Received: from [10.37.8.9] (unknown [10.37.8.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C54B63F70D;
        Tue, 23 Feb 2021 04:18:12 -0800 (PST)
Subject: Re: [PATCH v13 4/7] arm64: mte: Enable TCO in functions that can read
 beyond buffer limits
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
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210211153353.29094-1-vincenzo.frascino@arm.com>
 <20210211153353.29094-5-vincenzo.frascino@arm.com>
 <20210212172128.GE7718@arm.com>
 <c3d565da-c446-dea2-266e-ef35edabca9c@arm.com>
 <20210222175825.GE19604@arm.com>
 <6111633c-3bbd-edfa-86a0-be580a9ebcc8@arm.com>
 <20210223120530.GA20769@arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <6865788c-7e63-fbd7-bb88-ba01eafb2f63@arm.com>
Date:   Tue, 23 Feb 2021 12:22:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210223120530.GA20769@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/23/21 12:05 PM, Catalin Marinas wrote:
>> I totally agree on this point. In the case of runtime switching we might need
>> the rethink completely the strategy and depends a lot on what we want to allow
>> and what not. For the kernel I imagine we will need to expose something in sysfs
>> that affects all the cores and then maybe stop_machine() to propagate it to all
>> the cores. Do you think having some of the cores running in sync mode and some
>> in async is a viable solution?
> stop_machine() is an option indeed. I think it's still possible to run
> some cores in async while others in sync but the static key here would
> only be toggled when no async CPUs are left.
> 

In such a case we might need to track the state based on cpuid() and have a mask
that tells us when cpus are all sync.
Not as expensive as stop_machine() but still requires a valid use case to be
introduced according to me.

-- 
Regards,
Vincenzo
