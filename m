Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFA03214DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhBVLOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:14:40 -0500
Received: from foss.arm.com ([217.140.110.172]:41600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhBVLOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:14:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07FDF1FB;
        Mon, 22 Feb 2021 03:13:43 -0800 (PST)
Received: from [10.37.8.9] (unknown [10.37.8.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 226B23F73B;
        Mon, 22 Feb 2021 03:13:39 -0800 (PST)
Subject: Re: [PATCH v13 7/7] kasan: don't run tests in async mode
To:     Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210211153353.29094-1-vincenzo.frascino@arm.com>
 <20210211153353.29094-8-vincenzo.frascino@arm.com>
 <20210212172224.GF7718@arm.com>
 <CAAeHK+zg5aoFfi1Q36NyoaJqorES+1cvn+mRRcZ64uW8s7kAmQ@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <fbc215de-82f0-cc6f-c6f3-9ea639af65d2@arm.com>
Date:   Mon, 22 Feb 2021 11:17:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+zg5aoFfi1Q36NyoaJqorES+1cvn+mRRcZ64uW8s7kAmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 9:44 PM, Andrey Konovalov wrote:
>> I think we have time to fix this properly ;), so I'd rather not add this
>> patch at all.
> Yeah, this patch can be dropped.
> 
> I have a prototype of async support for tests working. I'll apply it
> on top of the next version Vincenzo posts and share the patch.
> 
> Vincenzo, when you post the next version, please make sure you rebase
> on top of the mm tree version that includes "kasan: export HW_TAGS
> symbols for KUnit tests" (linux-next/akpm doesn't yet have it).

Fine by me, I will drop this patch when I will repost in -rc1.

@Andrey: If you want me to test the series all together, you can send me your
tree before I repost and then I can send the patches as single series. What do
you think?

-- 
Regards,
Vincenzo
