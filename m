Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553323BB518
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 04:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhGECOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 22:14:11 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:36056 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhGECOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 22:14:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=yaohuiwang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UegSsAS_1625451092;
Received: from Dillions-MBP-16.local(mailfrom:yaohuiwang@linux.alibaba.com fp:SMTPD_---0UegSsAS_1625451092)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 05 Jul 2021 10:11:33 +0800
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
 <34bae667-180f-ce97-ee55-12e13ff28ca0@linux.alibaba.com>
 <663229c2-1957-2af5-678c-5d553507f5f3@intel.com>
From:   Yaohui Wang <yaohuiwang@linux.alibaba.com>
Message-ID: <a857aeae-6507-d418-8798-83980cff3135@linux.alibaba.com>
Date:   Mon, 5 Jul 2021 10:11:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <663229c2-1957-2af5-678c-5d553507f5f3@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/7/2 22:49, Dave Hansen wrote:
> Do you know why this check:
> 
>> 	if ((res->flags & IORESOURCE_SYSTEM_RAM) != IORESOURCE_SYSTEM_RAM)
>> 		return false;
> 
> did not catch your out-of-tree driver's errant ioremap()?
>
If ioremap() is invoked on an area that contains normal memory, then:

	(res->flags & IORESOURCE_SYSTEM_RAM) == IORESOURCE_SYSTEM_RAM)

is true, so the original check is false. The code following the check
will continue to scan whether this area contains any page that is not
PageReserved (i.e. that is truly normal RAM).

Your idea should be:

	if ((res->flags & IORESOURCE_SYSTEM_RAM) == IORESOURCE_SYSTEM_RAM)
	return IORES_MAP_SYSTEM_RAM;

But this check is too strict as IORESOURCE_SYSTEM_RAM area may contain
PageReserved pages, and PageReserved pages should be ioremap-able. So
the checking logic of the original __ioremap_check_ram() function is
reasonable.

