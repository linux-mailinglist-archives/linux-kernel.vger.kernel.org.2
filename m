Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DF7397D71
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 02:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbhFBAFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 20:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235034AbhFBAFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 20:05:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B963C60FF3;
        Wed,  2 Jun 2021 00:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622592227;
        bh=4lPYA2M7pTYomZj5YtM7N28HqTsauh6KyT/jf1Nbnn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VL+3wyvAV2P0hJF4DBqMoPVdUVBPd2MAVy69uh8MqH0tRpeWrLLMqhUUlwBW7+YmL
         v5j6vn2Zpp4U29X1iWga72p+t0vcK5BIEB9FalC9csoRE+/cN3yg4x/camcn/lCbtX
         ZEOhjFaRdO+gFlT5TkV9Z7Ra18cpHH2iR1YYoH+w=
Date:   Tue, 1 Jun 2021 17:03:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        alexander.h.duyck@linux.intel.com, david@redhat.com,
        shan.gavin@gmail.com
Subject: Re: [RFC PATCH] mm/page_reporting: Adjust threshold according to
 MAX_ORDER
Message-Id: <20210601170347.d78ec4af51b1522305deef4a@linux-foundation.org>
In-Reply-To: <20210601033319.100737-1-gshan@redhat.com>
References: <20210601033319.100737-1-gshan@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Jun 2021 11:33:19 +0800 Gavin Shan <gshan@redhat.com> wrote:

> The PAGE_REPORTING_MIN_ORDER is equal to @pageblock_order, taken as
> minimal order (threshold) to trigger page reporting. The page reporting
> is never triggered with the following configurations and settings on
> aarch64. In the particular scenario, the page reporting won't be triggered
> until the largest (2 ^ (MAX_ORDER-1)) free area is achieved from the
> page freeing. The condition is very hard, or even impossible to be met.
> 
>   CONFIG_ARM64_PAGE_SHIFT:              16
>   CONFIG_HUGETLB_PAGE:                  Y
>   CONFIG_HUGETLB_PAGE_SIZE_VARIABLE:    N
>   pageblock_order:                      13
>   CONFIG_FORCE_MAX_ZONEORDER:           14
>   MAX_ORDER:                            14
> 
> The issue can be reproduced in VM, running kernel with above configurations
> and settings. The 'memhog' is used inside the VM to access 512MB anonymous
> area. The QEMU's RSS doesn't drop accordingly after 'memhog' exits.
> 
>   /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64          \
>   -accel kvm -machine virt,gic-version=host                        \
>   -cpu host -smp 8,sockets=2,cores=4,threads=1 -m 4096M,maxmem=64G \
>   -object memory-backend-ram,id=mem0,size=2048M                    \
>   -object memory-backend-ram,id=mem1,size=2048M                    \
>   -numa node,nodeid=0,cpus=0-3,memdev=mem0                         \
>   -numa node,nodeid=1,cpus=4-7,memdev=mem1                         \
>     :                                                              \
>   -device virtio-balloon-pci,id=balloon0,free-page-reporting=yes
> 
> This tries to fix the issue by adjusting the threshold to the smaller value
> of @pageblock_order and (MAX_ORDER/2). With this applied, the QEMU's RSS
> drops after 'memhog' exits.
>

Sounds promising, but...

> --- a/mm/page_reporting.h
> +++ b/mm/page_reporting.h
> @@ -10,9 +10,10 @@
>  #include <linux/pgtable.h>
>  #include <linux/scatterlist.h>
>  
> -#define PAGE_REPORTING_MIN_ORDER	pageblock_order
> -
>  #ifdef CONFIG_PAGE_REPORTING
> +#define PAGE_REPORTING_MIN_ORDER	\
> +	min_t(unsigned int, pageblock_order, (MAX_ORDER / 2))
> +
>  DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
>  void __page_reporting_notify(void);

Could you please redo this as a regular old static function in
page_reporting.c?  Bonus points for commenting its design ;)
