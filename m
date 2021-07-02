Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A5F3B9EC8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 12:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhGBKHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 06:07:48 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:56083 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231302AbhGBKHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 06:07:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yaohuiwang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UeT3pAQ_1625220302;
Received: from Dillions-MBP-16.local(mailfrom:yaohuiwang@linux.alibaba.com fp:SMTPD_---0UeT3pAQ_1625220302)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 02 Jul 2021 18:05:03 +0800
Subject: Re: [PATCH v3 1/2] x86/ioremap: fix the pfn calculation mistake in
 __ioremap_check_ram()
To:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de
Cc:     luto@kernel.org, peterz@infradead.org, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        luoben@linux.alibaba.com, Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <20210621123419.2976-1-yaohuiwang@linux.alibaba.com>
 <20210621123419.2976-2-yaohuiwang@linux.alibaba.com>
 <94a38542-b639-37e4-1b53-29b59c5ea655@intel.com>
From:   Yaohui Wang <yaohuiwang@linux.alibaba.com>
Message-ID: <34bae667-180f-ce97-ee55-12e13ff28ca0@linux.alibaba.com>
Date:   Fri, 2 Jul 2021 18:05:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <94a38542-b639-37e4-1b53-29b59c5ea655@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/7/1 22:41, Dave Hansen wrote:
> Was this issue found by inspection, or is it causing an actual problem
> in practice?

This issus truly caused terrible perforamnce downgrade in the practice.
When developing an out of tree module in our testing environment,
invoking ioremap() on normal RAM causes apparent CLI lag. The Unixbench
score also decreases a lot (5x slowdown in the worst case).

Debugging such performance issue is extremely difficult, especially when
the code of the faulty module itself is already very complex. I tested
the system in many aspects before finally located this problem.

> Also, it would be really nice to include the original authors when you
> send Fixes: for patches.  BTW, scripts/get_maintainer.pl would have done
> this for you.  I've added Tom and Brijesh.  Please cc them in the future.

I'll pay attention to this in the future. Thank you for your time and
patience!
