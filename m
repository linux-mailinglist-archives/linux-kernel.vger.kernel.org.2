Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0876315745
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 21:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhBITzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 14:55:53 -0500
Received: from foss.arm.com ([217.140.110.172]:55224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233237AbhBISWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 13:22:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FE53113E;
        Tue,  9 Feb 2021 10:21:29 -0800 (PST)
Received: from [10.37.8.18] (unknown [10.37.8.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94D513F73B;
        Tue,  9 Feb 2021 10:21:27 -0800 (PST)
Subject: Re: [PATCH v12 6/7] arm64: mte: Save/Restore TFSR_EL1 during suspend
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
        Andrey Konovalov <andreyknvl@google.com>
References: <20210208165617.9977-1-vincenzo.frascino@arm.com>
 <20210208165617.9977-7-vincenzo.frascino@arm.com>
 <20210209115533.GE1435@arm.com>
 <20210209143328.GA27791@e121166-lin.cambridge.arm.com>
 <20210209172821.GI1435@arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <89c95a1e-cfd2-7840-3175-deaeb336190b@arm.com>
Date:   Tue, 9 Feb 2021 18:25:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209172821.GI1435@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/21 5:28 PM, Catalin Marinas wrote:
>> I don't think though you can "check" with IRQs disabled so I suspect
>> that TFSR_EL1 has to be saved/restored (which means that there is a
>> black out period where we run kernel code without being able to detect
>> faults but there is no solution to that other than delaying saving the
>> value to just before calling into PSCI). Likewise on resume from low
>> power.
> It depends on whether kasan_report can be called with IRQs disabled. I
> don't see why not, so if this works I'd rather just call mte_check_async
> (or whatever it's called) on the suspend path and zero the register on
> resume (mte_suspend_exit). We avoid any saving of the state.

Fine by me, I tried a quick test and can confirm that kasan_report can be
invoked with IRQ disabled.

-- 
Regards,
Vincenzo
