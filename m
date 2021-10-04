Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09009421277
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhJDPSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:18:41 -0400
Received: from foss.arm.com ([217.140.110.172]:49700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233289AbhJDPSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:18:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16716D6E;
        Mon,  4 Oct 2021 08:16:51 -0700 (PDT)
Received: from [192.168.1.131] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F21133F70D;
        Mon,  4 Oct 2021 08:16:47 -0700 (PDT)
Subject: Re: [PATCH 0/5] arm64: ARMv8.7-A: MTE: Add asymm mode support
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210913081424.48613-1-vincenzo.frascino@arm.com>
 <20210929154907.GC22029@willie-the-truck>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <90cb5600-44cb-1ed5-de4b-d19919090622@arm.com>
Date:   Mon, 4 Oct 2021 17:16:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210929154907.GC22029@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

sorry for the late reply but I am on sabbatical :)

On 9/29/21 5:49 PM, Will Deacon wrote:
> I'm surprised not to see any update to:
> 
> 	Documentation/arm64/memory-tagging-extension.rst
> 
> particularly regarding the per-cpu preferred tag checking modes. Is
> asymmetric mode not supported there?
> 

The document that you are pointing out covers the userspace support, this series
introduces the in-kernel support only for asymmetric MTE. The userspace bits for
asymm will be added with a future series.

The confusion comes from the fact, as Peter correctly pointed already, that I
forgot to mention this vital info in the cover letter. Sorry about that I will
make sure that this is addressed in v2.

Thanks!

> Will

-- 
Regards,
Vincenzo
