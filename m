Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F7D3FEB22
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245381AbhIBJW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:22:56 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:33287 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245139AbhIBJWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:22:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Un.S-zH_1630574511;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Un.S-zH_1630574511)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Sep 2021 17:21:51 +0800
Subject: Re: [PATCH 02/24] x86/traps: Move arch/x86/kernel/traps.c to
 arch/x86/entry/
To:     Joerg Roedel <jroedel@suse.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chester Lin <clin@suse.com>, Juergen Gross <jgross@suse.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-3-jiangshanlai@gmail.com> <YTCGov+vvAMvso7q@suse.de>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <1f327579-e62a-df65-0763-e88243829db3@linux.alibaba.com>
Date:   Thu, 2 Sep 2021 17:21:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTCGov+vvAMvso7q@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/2 16:09, Joerg Roedel wrote:
> On Wed, Sep 01, 2021 at 01:50:03AM +0800, Lai Jiangshan wrote:
>>   arch/x86/entry/Makefile            | 5 ++++-
>>   arch/x86/{kernel => entry}/traps.c | 0
>>   arch/x86/kernel/Makefile           | 5 +----
>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>   rename arch/x86/{kernel => entry}/traps.c (100%)
> 
>  From looking over the patch-set I didn't spot the reason for putting the
> entry C code into traps.c. Can you explain that please? Otherwise I'd
> prefer to create a new file, like arch/x86/entry/entry64.c.


I agree, and I think Peter is handling it.

Thanks
Lai
