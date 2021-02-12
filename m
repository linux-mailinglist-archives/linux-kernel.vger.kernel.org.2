Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CF9319F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhBLNM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:12:59 -0500
Received: from foss.arm.com ([217.140.110.172]:36788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232046AbhBLNCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 08:02:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5001D1063;
        Fri, 12 Feb 2021 05:01:11 -0800 (PST)
Received: from [10.37.8.13] (unknown [10.37.8.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57E053F719;
        Fri, 12 Feb 2021 05:01:09 -0800 (PST)
Subject: Re: [PATCH v13 6/7] arm64: mte: Report async tag faults before
 suspend
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Branislav Rankov <Branislav.Rankov@arm.com>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20210211153353.29094-1-vincenzo.frascino@arm.com>
 <20210211153353.29094-7-vincenzo.frascino@arm.com>
 <20210212120015.GA18281@e121166-lin.cambridge.arm.com>
 <20210212123029.GA19585@e121166-lin.cambridge.arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <9d7b4475-dd59-d84f-5835-9222c2758eac@arm.com>
Date:   Fri, 12 Feb 2021 13:05:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210212123029.GA19585@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/21 12:30 PM, Lorenzo Pieralisi wrote:
>> However, I have a question. We are relying on context switch to set
>> sctlr_el1_tfc0 right ? If that's the case, till the thread resuming from
>> low power switches context we are running with SCTLR_EL1_TCF0 not
>> reflecting the actual value.
> Forget this, we obviously restore sctlr_el1 on resume (cpu_do_resume()).
> 
> With the line above removed:
> 
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 

Thanks Lorenzo, I will remove the register write in the next version and add
your tag.

-- 
Regards,
Vincenzo
