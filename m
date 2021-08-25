Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0B73F7C11
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 20:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhHYSMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 14:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230007AbhHYSME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 14:12:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84E3F60EBD;
        Wed, 25 Aug 2021 18:11:16 +0000 (UTC)
Date:   Wed, 25 Aug 2021 19:11:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     will@kernel.org, ryabinin.a.a@gmail.com, andreyknvl@gmail.com,
        dvyukov@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, elver@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/3] arm64: support page mapping percpu first chunk
 allocator
Message-ID: <20210825181112.GK3420@arm.com>
References: <20210809093750.131091-1-wangkefeng.wang@huawei.com>
 <9b75f4e5-a675-1227-0476-43fc21509086@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b75f4e5-a675-1227-0476-43fc21509086@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 02:07:36PM +0800, Kefeng Wang wrote:
> The drivers/base/arch_numa.c is only shared by riscv and arm64,
> 
> and the change from patch2 won't broke riscv.
> 
> Could all patches be merged by arm64 tree? or any new comments?

The series touches drivers/ and mm/ but missing acks from both Greg and
Andrew (cc'ing them).

I'm also happy for the series to go in via the mm tree in case Andrew
wants to take it.

-- 
Catalin
