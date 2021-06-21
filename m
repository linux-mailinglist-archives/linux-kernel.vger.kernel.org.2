Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D5B3AE303
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 08:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhFUGPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 02:15:07 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:41013 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229479AbhFUGPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 02:15:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yaohuiwang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Ud48tDx_1624255969;
Received: from Dillions-MBP-16.local(mailfrom:yaohuiwang@linux.alibaba.com fp:SMTPD_---0Ud48tDx_1624255969)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Jun 2021 14:12:50 +0800
Subject: Re: [PATCH v2 2/2] mm: fix boundary judgment issues in
 kernel/resource.c
To:     Thomas Gleixner <tglx@linutronix.de>, dave.hansen@linux.intel.com
Cc:     luto@kernel.org, peterz@infradead.org, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        Ben Luo <luoben@linux.alibaba.com>,
        yaohuiwang@linux.alibaba.com
References: <20210611042147.80744-1-yaohuiwang@linux.alibaba.com>
 <20210611042147.80744-3-yaohuiwang@linux.alibaba.com>
 <87k0mph54i.ffs@nanos.tec.linutronix.de>
From:   Yaohui Wang <yaohuiwang@linux.alibaba.com>
Message-ID: <4422c930-6d0e-6031-1f25-bbd8f0b327bc@linux.alibaba.com>
Date:   Mon, 21 Jun 2021 14:12:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87k0mph54i.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas

Thanks for your detailed reply, and your patience for a kernel newbie.

I'll carefully address the formal issues in the next version of patch.


Thanks,

         Yaohui

On 2021/6/20 06:16, Thomas Gleixner wrote:
> Yaohui!
> 
> On Fri, Jun 11 2021 at 12:21, Yaohui Wang wrote:
> 
> The same formal issues as with patch #1
> 
>> The original boundary judgment may ignore @end if @end equals @start. For
> 
> May means it can but it must not. But this is not the case here. end
> equals start is always ignored.
> 
> Also 'original' is meaningless here. Before the patch is applied the
> code is that way.
> 
>   find_next_iomem_res() and __walk_iomem_res_desc() require that the
>   provided end address is larger than the start address, which ...
> 
> 
>> example, if we call ioremap(phys, 1), then @end == @start, and the memory
>> check will not be applied on the page where @end lives, which is
>> unexpected.
> 
> Please avoid 'we' and 'I':
> 
>   is incorrect when ioremap() is invoked with length=1.
> 
>> In kernel/resource.c:find_next_iomem_res, the mem region is a closed
> 
> See the reply to #1 vs. function names. Also please write out 'memory',
> there is no shortage of space in change logs.
> 
>> interval (i.e. [@start..@end]). So @start == @end should be allowed.
> 
> closed interval reads strange. The usual terminology is: The end address
> is inclusive.
> 
>    Resources are described with the start address and the inclusive end
>    address, which means for a resource with 1 byte length the start
>    address is the same as the end address.
> 
>    find_next_iomem_res() and __walk_iomem_res_desc() ignore resources
>    with 1 byte length, which prevents that ioremap(phys, 1) is checked
>    whether it touches non ioremappable resources.
> 
>    ...
> 
> Thanks,
> 
>          tglx
> 
