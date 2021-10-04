Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5404212F7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbhJDPrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:47:17 -0400
Received: from foss.arm.com ([217.140.110.172]:53644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235455AbhJDPrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:47:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E436FD6E;
        Mon,  4 Oct 2021 08:45:26 -0700 (PDT)
Received: from [10.57.53.1] (unknown [10.57.53.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6701A3F70D;
        Mon,  4 Oct 2021 08:45:24 -0700 (PDT)
Subject: Re: [PATCH 5/5] kasan: Extend KASAN mode kernel parameter
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210913081424.48613-1-vincenzo.frascino@arm.com>
 <20210913081424.48613-6-vincenzo.frascino@arm.com>
 <CANpmjNN5atO1u6+Y71EiEvr9V8+WhdOGzC_8gvviac+BDkP+sA@mail.gmail.com>
 <f789ede2-3fa2-8a50-3d82-8b2dc2f12386@arm.com>
 <CA+fCnZe-gogW1yMuiHhXmKXTsmfkb+-iWp1Vf9K6ZY9madtxfw@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <3e6a5797-4690-ea54-c14b-75d6ca58e744@arm.com>
Date:   Mon, 4 Oct 2021 17:45:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+fCnZe-gogW1yMuiHhXmKXTsmfkb+-iWp1Vf9K6ZY9madtxfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 10/3/21 7:16 PM, Andrey Konovalov wrote:
> Hi Vincenzo,
> 
> Up till now, the code assumes that not having the async mode enabled
> means that the sync mode is enabled. There are two callers to
> kasan_async_mode_enabled(): lib/test_kasan.c and mm/kasan/report.c.
> Assuming tests support will be added later, at least the second one
> should be adjusted.
> 
> Maybe we should rename kasan_async_mode_enabled() to
> kasan_async_fault_possible(), make it return true for both async and
> asymm modes, and use that in mm/kasan/report.c. And also add
> kasan_sync_fault_possible() returning true for sync and asymm, and use
> that in lib/test_kasan.c. (However, it seems that the tests don't work
> with async faults right now.)
> 

It is ok by me, I will add the changes you are mentioning in v2.

> Thanks!

-- 
Regards,
Vincenzo
