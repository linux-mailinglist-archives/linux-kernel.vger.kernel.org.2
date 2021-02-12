Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D02319D53
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 12:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhBLLXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 06:23:39 -0500
Received: from foss.arm.com ([217.140.110.172]:35452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhBLLXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 06:23:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4061B11B3;
        Fri, 12 Feb 2021 03:22:24 -0800 (PST)
Received: from [10.37.8.13] (unknown [10.37.8.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3CFB3F719;
        Fri, 12 Feb 2021 03:22:21 -0800 (PST)
Subject: Re: [PATCH v13 2/7] kasan: Add KASAN mode kernel parameter
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210211153353.29094-1-vincenzo.frascino@arm.com>
 <20210211153353.29094-3-vincenzo.frascino@arm.com>
 <CAAeHK+zefPsq6pzO-bTz-xOXQrNkwuCS8i9L7EXLxH=SkKAgJw@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <913e2b39-9cd4-5310-df27-999c65b8d76d@arm.com>
Date:   Fri, 12 Feb 2021 11:26:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+zefPsq6pzO-bTz-xOXQrNkwuCS8i9L7EXLxH=SkKAgJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/21 5:50 PM, Andrey Konovalov wrote:
> Let's default to KASAN_ARG_MODE_DEFAULT like for other args:
> 
> if (!arg)
>   return -EINVAL;
> 
> kasan_init_hw_tags_cpu()/kasan_init_hw_tags() already handle
> KASAN_ARG_MODE_DEFAULT properly.

Ok, no problem, I will take care of it in the next version.

-- 
Regards,
Vincenzo
