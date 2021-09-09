Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73441405A04
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 17:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhIIPFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 11:05:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232395AbhIIPFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 11:05:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05E8960F92;
        Thu,  9 Sep 2021 15:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631199874;
        bh=NSlhi/nysT4dmoTdtx+bdm4Cigs68m/xGsjWNtC+bwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHcReHe8//5kzvmHk0evFwsb5QOvFjQQb6oP5IMeEVs7J3u090CUozsR20eWVlmHo
         jGRN7oX7Y3FEdQIEfxGNkMOkxH/EnuwvOGFRWNyG6AGZldfzZwZ2q7KHsFAMMZg/It
         1Trz1lMHN1eSVOcT4EUfswwJvjqPdd7iWJClU1LjnfacUKatZenvuXqicQt+xRRItN
         IVlhNGnvir8RjmqeoYHl+GgwpzuUwsg//14v2HAYe0iWAjAlb+FiWJ1+4yYmz9mSEw
         SvmeZ5x4zmt5hdAo2Sbw4kLxojZQE2eT6EjSaGIjvBwo4lSS9vjLrNDZ8vpr2RtFJG
         Ywq7YIdHhZkRQ==
Date:   Thu, 9 Sep 2021 16:04:29 +0100
From:   Will Deacon <will@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Claire Chang <tientzu@chromium.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [swiotlb]  461021875c: EIP:__dma_direct_alloc_pages
Message-ID: <20210909150428.GA10436@willie-the-truck>
References: <20210908085239.GC839@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908085239.GC839@xsang-OptiPlex-9020>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 04:52:39PM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 461021875c5057b3a408db0aa91b15119064ffa8 ("swiotlb: Add restricted DMA pool initialization")
> https://git.kernel.org/cgit/linux/kernel/git/konrad/swiotlb.git devel/for-linus-5.14
> 
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [  157.633812][    T1] BUG: kernel NULL pointer dereference, address: 00000046
> [  157.636589][    T1] #PF: supervisor read access in kernel mode
> [  157.637641][    T1] #PF: error_code(0x0000) - not-present page
> [  157.637641][    T1] *pde = 00000000
> [  157.643000][    T1] Oops: 0000 [#1] SMP
> [  157.643000][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         5.12.0-rc3-00029-g461021875c50 #1
> [  157.643000][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [  157.650987][    T1] EIP: __dma_direct_alloc_pages+0xee/0x280
> [  157.650987][    T1] Code: d2 f6 c1 20 0f 94 c0 0f 95 c2 d3 e0 d3 e2 83 c0 ff 83 d2 ff 39 f0 89 d0 19 f8 0f 92 c0 0f b6 c0 8d 44 40 01 8b 93 c0 02 00 00 <80> 7a 46 00 74 6c 8b 7d ec 89 d8 89 fa e8 c0 34 00 00 89 c6 85 c0
> [  157.658987][    T1] EAX: 00000004 EBX: c2713884 ECX: 00000018 EDX: 00000000
> [  157.658987][    T1] ESI: ffffffff EDI: 00000000 EBP: c1c43d2c ESP: c1c43d10
> [  157.658987][    T1] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010297
> [  157.666985][    T1] CR0: 80050033 CR2: 00000046 CR3: 1b1da000 CR4: 000406d0
> [  157.666985][    T1] Call Trace:
> [  157.666985][    T1]  dma_direct_alloc+0x50/0x180
> [  157.674977][    T1]  dma_alloc_attrs+0x69/0xc0
> [  157.674977][    T1]  ide_allocate_dma_engine+0x55/0x80

This IDE code doesn't exist upstream any more. See b7fb14d3ac63 ("ide: remove
the legacy ide driver").

Will
