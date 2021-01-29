Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F80308BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhA2Rvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:51:42 -0500
Received: from foss.arm.com ([217.140.110.172]:52152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232326AbhA2Ruy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:50:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 444D513A1;
        Fri, 29 Jan 2021 09:50:09 -0800 (PST)
Received: from [10.37.12.11] (unknown [10.37.12.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22A583F885;
        Fri, 29 Jan 2021 09:50:06 -0800 (PST)
Subject: Re: [PATCH v9 0/4] arm64: ARMv8.5-A: MTE: Add async mode support
To:     Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
References: <20210126134603.49759-1-vincenzo.frascino@arm.com>
 <CAAeHK+xTWrdJ2as6kBLX+z64iu3e6JEGppOkN-i_jsH74c6xoA@mail.gmail.com>
 <20210127221939.GA848@willie-the-truck>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <9d619e7c-ab49-987c-2087-f44a47551d7f@arm.com>
Date:   Fri, 29 Jan 2021 17:54:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210127221939.GA848@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 1/27/21 10:19 PM, Will Deacon wrote:
>> Andrew, could you pick this up into mm? The whole series will need to
>> go through mm due to dependencies on the patches that are already
>> there.
> Please can you check that it doesn't conflict with the arm64 for-next/core
> branch first?

I just merged for-next/core and has of today there are no conflicts.

I notice though that with the introduction of:

ceca664b9581 ("kasan: use error_report_end tracepoint")

the interface of end_report() is changed hence my patches do not build anymore.

I will send v10 shortly.

-- 
Regards,
Vincenzo
