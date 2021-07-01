Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AABD3B8C65
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 04:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbhGACrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 22:47:20 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:45518 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238056AbhGACrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 22:47:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yaohuiwang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UeDiCxH_1625107487;
Received: from Dillions-MBP-16.local(mailfrom:yaohuiwang@linux.alibaba.com fp:SMTPD_---0UeDiCxH_1625107487)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 01 Jul 2021 10:44:48 +0800
From:   Yaohui Wang <yaohuiwang@linux.alibaba.com>
Subject: Re: [PATCH v3 0/2] x86/ioremap: fix boundary calculation and boundary
 judgment issues for ioremap()
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, yaohuiwang@linux.alibaba.com
References: <20210621123419.2976-1-yaohuiwang@linux.alibaba.com>
Message-ID: <55fa4f7e-356b-8b41-0e06-efa5a065277a@linux.alibaba.com>
Date:   Thu, 1 Jul 2021 10:44:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210621123419.2976-1-yaohuiwang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, maintainers,

It's been 10 days since I sent the patches at Jun 21st. Would you please
help to review them? Wish to hear your feedbacks, Thanks!


Yaohui

On 2021/6/21 20:34, Yaohui Wang wrote:
> ioremap_xxx() functions should fail if the memory address range contains
> normal RAM. But due to some boundary calculation and boundary judgment
> issues, the RAM check may be omitted for the very start or the very end
> page in the memory range. As a consequence, ioremap_xxx() can be applied
> to normal RAM pages by mistake. This raises the risk of misusing
> ioremap_xxx() functions on normal RAM ranges, and may incur terrible
> performance issues.
> 
> For example, suppose [phys_addr ~ phys_addr + PAGE_SIZE - 1] is a normal
> RAM page. Calling ioremap(phys_addr, PAGE_SIZE-1) will succeed (but it
> should not). This will set the cache flag of the phys_addr's directing
> mapping pte to be PCD. What's worse, iounmap() won't revert this cache
> flag in the directing mapping. So the pte in the directing mapping keeps
> polluted until workarounds are applied (by invoking ioremap_cache() on
> phys_addr) to fix the cache bit. If there is important data/code in the
> polluted page, which is accessed frequently, then the performance of the
> machine will drop terribly.
> 
> These two patches aim to address this issue.
> 
> Yahui Wang (2):
>    x86/ioremap: fix the pfn calculation mistake in __ioremap_check_ram()
>    kernel/resource: fix boundary judgment issues in find_next_iomem_res()
>      and __walk_iomem_res_desc()
> 
>   arch/x86/mm/ioremap.c | 16 ++++++++--------
>   kernel/resource.c     |  4 ++--
>   2 files changed, 10 insertions(+), 10 deletions(-)
> 
> 
> base-commit: 13311e74253fe64329390df80bed3f07314ddd61
> 
