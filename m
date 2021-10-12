Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAD842ABCB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhJLSX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231586AbhJLSX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:23:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37ACB60D07;
        Tue, 12 Oct 2021 18:21:24 +0000 (UTC)
Date:   Tue, 12 Oct 2021 19:21:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     will@kernel.org, ryabinin.a.a@gmail.com, andreyknvl@gmail.com,
        dvyukov@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, elver@google.com,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 1/3] vmalloc: Choose a better start address in
 vm_area_register_early()
Message-ID: <YWXSIOm0u58vBfJ6@arm.com>
References: <20210910053354.26721-1-wangkefeng.wang@huawei.com>
 <20210910053354.26721-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910053354.26721-2-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 01:33:52PM +0800, Kefeng Wang wrote:
> There are some fixed locations in the vmalloc area be reserved
> in ARM(see iotable_init()) and ARM64(see map_kernel()), but for
> pcpu_page_first_chunk(), it calls vm_area_register_early() and
> choose VMALLOC_START as the start address of vmap area which
> could be conflicted with above address, then could trigger a
> BUG_ON in vm_area_add_early().
> 
> Let's choose a suit start address by traversing the vmlist.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
