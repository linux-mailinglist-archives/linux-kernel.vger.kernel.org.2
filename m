Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAAE412EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhIUHE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:04:27 -0400
Received: from foss.arm.com ([217.140.110.172]:58548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhIUHEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:04:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67C2D106F;
        Tue, 21 Sep 2021 00:02:57 -0700 (PDT)
Received: from [192.168.1.131] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C4BF3F719;
        Tue, 21 Sep 2021 00:02:53 -0700 (PDT)
Subject: Re: [PATCH 0/5] arm64: ARMv8.7-A: MTE: Add asymm mode support
To:     Peter Collingbourne <pcc@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210913081424.48613-1-vincenzo.frascino@arm.com>
 <CAMn1gO5sUhDkx4w-Kk8hw0xLbXmr129xeJa6YhxOeJ-v83hp6w@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <ab5615ef-b4f4-28be-3e2b-2b592e11580a@arm.com>
Date:   Tue, 21 Sep 2021 09:03:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMn1gO5sUhDkx4w-Kk8hw0xLbXmr129xeJa6YhxOeJ-v83hp6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/21 11:29 PM, Peter Collingbourne wrote:
> On Mon, Sep 13, 2021 at 1:21 AM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> This series implements the asymmetric mode support for ARMv8.7-A Memory
>> Tagging Extension (MTE), which is a debugging feature that allows to
>> detect with the help of the architecture the C and C++ programmatic
>> memory errors like buffer overflow, use-after-free, use-after-return, etc.
> 
> Unless I'm missing something, it looks like this only includes KASAN
> support and not userspace support. Is userspace support coming in a
> separate patch?
> 
> The fact that this only includes KASAN support should probably be in
> the commit messages as well.
> 

Good catch, I forgot to mention that this series is meant only for in-kernel
support. I will update the cover in the next iteration.

Thanks!

> Peter
> 

-- 
Regards,
Vincenzo
