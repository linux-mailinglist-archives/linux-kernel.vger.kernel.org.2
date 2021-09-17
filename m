Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EBE40F249
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhIQG0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233358AbhIQG0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:26:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B596A60F4A;
        Fri, 17 Sep 2021 06:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631859891;
        bh=ep0WqNlH3FcYvBeuK2z77yvpeGPGF3DSSxCj7FbzDFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YM10PzX6rsQUuBkuM0H3EQI2w45jjuLM6MrWsbgJPrGeJ9ueBqjPak2AGztME7Yph
         zWhQArvoNq/mlEBkmSongDgpNC2D2EP0/gZrv0xNa8bIVeLzTgOPdXUgP5pQqkdIHk
         kkc5lzSjBEX+AKb1We6bX6PW2ptbRZPFRWQyC81w=
Date:   Fri, 17 Sep 2021 08:24:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, ryabinin.a.a@gmail.com,
        andreyknvl@gmail.com, dvyukov@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, elver@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 0/3] arm64: support page mapping percpu first chunk
 allocator
Message-ID: <YUQ0sFeM4xqmaNG6@kroah.com>
References: <20210910053354.26721-1-wangkefeng.wang@huawei.com>
 <c06faf6c-3d21-04f2-6855-95c86e96cf5a@huawei.com>
 <YUNlsgZoLG3g4Qup@kroah.com>
 <525cb266-ecfc-284e-d701-4a8b40fe413b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <525cb266-ecfc-284e-d701-4a8b40fe413b@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 09:11:38AM +0800, Kefeng Wang wrote:
> 
> On 2021/9/16 23:41, Greg KH wrote:
> > On Wed, Sep 15, 2021 at 04:33:09PM +0800, Kefeng Wang wrote:
> > > Hi Greg and Andrew， as Catalin saids，the series touches drivers/ and mm/
> > > but missing
> > > 
> > > acks from both of you，could you take a look of this patchset(patch1 change
> > > mm/vmalloc.c
> > What patchset?
> 
> [PATCH v4 1/3] vmalloc: Choose a better start address in
> vm_area_register_early()  <https://lore.kernel.org/linux-arm-kernel/20210910053354.26721-2-wangkefeng.wang@huawei.com/>
> [PATCH v4 2/3] arm64: Support page mapping percpu first chunk allocator  <https://lore.kernel.org/linux-arm-kernel/20210910053354.26721-3-wangkefeng.wang@huawei.com/>
> [PATCH v4 3/3] kasan: arm64: Fix pcpu_page_first_chunk crash with
> KASAN_VMALLOC  <https://lore.kernel.org/linux-arm-kernel/20210910053354.26721-4-wangkefeng.wang@huawei.com/>
> [PATCH v4 0/3] arm64: support page mapping percpu first chunk allocator  <https://lore.kernel.org/linux-arm-kernel/c06faf6c-3d21-04f2-6855-95c86e96cf5a@huawei.com/>
> 
> > > and patch2 changes drivers/base/arch_numa.c).
> patch2 ：
> 
> [PATCH v4 2/3] arm64: Support page mapping percpu first chunk allocator  <https://lore.kernel.org/linux-arm-kernel/20210910053354.26721-3-wangkefeng.wang@huawei.com/#r>
> 
> > that file is not really owned by anyone it seems :(
> > 
> > Can you provide a link to the real patch please?
> 
> Yes， arch_numa.c is moved into drivers/base to support riscv numa, it is
> shared by arm64/riscv,
> 
> my changes(patch2) only support NEED_PER_CPU_PAGE_FIRST_CHUNK on ARM64.
> 
> here is the link:
> 
> https://lore.kernel.org/linux-arm-kernel/20210910053354.26721-1-wangkefeng.wang@huawei.com/

Now reviewed.

