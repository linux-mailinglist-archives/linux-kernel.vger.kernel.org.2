Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047FE31520F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhBIOvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:51:05 -0500
Received: from foss.arm.com ([217.140.110.172]:52806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232262AbhBIOu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:50:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9B54101E;
        Tue,  9 Feb 2021 06:50:11 -0800 (PST)
Received: from [10.37.8.18] (unknown [10.37.8.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0F223F73D;
        Tue,  9 Feb 2021 06:50:09 -0800 (PST)
Subject: Re: [PATCH v12 6/7] arm64: mte: Save/Restore TFSR_EL1 during suspend
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
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
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <2a551330-111b-4cb4-51d1-190f2c6d8493@arm.com>
Date:   Tue, 9 Feb 2021 14:54:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209143328.GA27791@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/21 2:33 PM, Lorenzo Pieralisi wrote:
>> Do we need a similar fix for TFSRE0_EL1? We get away with this if
>> suspend is only entered on the idle (kernel) thread but I recall we
>> could also enter suspend on behalf of a user process (I may be wrong
>> though).
> Yes, when we suspend the machine to RAM, we execute suspend on behalf
> on a userspace process (but that's only running on 1 cpu, the others
> are hotplugged out).
> 
> IIUC (and that's an if) TFSRE0_EL1 is checked on kernel entry so I don't
> think there is a need to save/restore it (just reset it on suspend
> exit).
> 
> TFSR_EL1, I don't see a point in saving/restoring it (it is a bit
> per-CPU AFAICS) either, IMO we should "check" it on suspend (if it is
> possible in that context) and reset it on resume.
> 
> I don't think though you can "check" with IRQs disabled so I suspect
> that TFSR_EL1 has to be saved/restored (which means that there is a
> black out period where we run kernel code without being able to detect
> faults but there is no solution to that other than delaying saving the
> value to just before calling into PSCI). Likewise on resume from low
> power.
> 

Ok, based on what you are saying it seems that the most viable solution here is
to save and restore TFSR_EL1. I will update my code accordingly.

> Thanks,
> Lorenzo
> 

-- 
Regards,
Vincenzo
