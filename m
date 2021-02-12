Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7197F319D52
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 12:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhBLLXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 06:23:17 -0500
Received: from foss.arm.com ([217.140.110.172]:35392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230470AbhBLLWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 06:22:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2594D113E;
        Fri, 12 Feb 2021 03:21:37 -0800 (PST)
Received: from [10.37.8.13] (unknown [10.37.8.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D593A3F719;
        Fri, 12 Feb 2021 03:21:34 -0800 (PST)
Subject: Re: [PATCH v13 3/7] kasan: Add report for async mode
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, kbuild-all@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kernel test robot <lkp@intel.com>
References: <20210211153353.29094-4-vincenzo.frascino@arm.com>
 <202102120313.OhKsJZ59-lkp@intel.com>
 <CAAeHK+yB4GLCn2Xu4z7FRLNOkVDFr0xXN3-D34BdJbRmWLpSxA@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <23dcb10a-7fc2-375d-2234-49f48461a612@arm.com>
Date:   Fri, 12 Feb 2021 11:25:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+yB4GLCn2Xu4z7FRLNOkVDFr0xXN3-D34BdJbRmWLpSxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 2/11/21 8:13 PM, Andrey Konovalov wrote:
>>>> riscv64-linux-ld: report.c:(.text+0x5c4): undefined reference to `kasan_flag_async'
> Let's do something like this (untested):
> 
> https://github.com/xairy/linux/commit/91354d34b30ceedbc1b6417f1ff253de90618a97

Could you reproduce this? I tried yesterday before posting the patches and my
conclusion was that kbuild robot is testing on the wrong tree.

I give it another go today, if you have more details based on your testing feel
free to share.

-- 
Regards,
Vincenzo
