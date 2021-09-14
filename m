Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028FA40A974
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhINImJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:42:09 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:38947 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229673AbhINImJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:42:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0UoM7a4X_1631608848;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UoM7a4X_1631608848)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Sep 2021 16:40:49 +0800
Subject: Re: [PATCH 25/24] x86/traps: Rewrite native_load_gs_index in C code
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210902105052.2842-1-jiangshanlai@gmail.com>
 <bfeb0b12-5b95-46c9-8ea3-6a4a5bf59076@www.fastmail.com>
 <4ecf191a-6642-6d59-cf10-6fe51e261b28@linux.alibaba.com>
 <YUBZ3J4Jy3x0VDkX@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <9da66eea-15e2-4e3f-b720-bafed292751f@linux.alibaba.com>
Date:   Tue, 14 Sep 2021 16:40:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUBZ3J4Jy3x0VDkX@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/14 16:14, Peter Zijlstra wrote:
> On Tue, Sep 14, 2021 at 10:04:47AM +0800, Lai Jiangshan wrote:
>> I think Peter is still working on reworking the patchset and may be
>> including improving this patch.  I'm Okay if this patch is dropped.
> 
> No I am not.


I'm sorry.

> 
> I said I have interest, I also said you shouldn't repost after a single
> bit of feedback -- there's nothing more annoying than trying to review a
> large-ish and complicated series of patches when you get a new version
> every other day >
> But please do work on it, because I really don't have the bandwidth to
> carry this atm.  By now there's been a fair amount of feedback, so a new
> version might be appropriate.

Thank you, I will revise the patchset and send it.

> 
> I really do think you've got some very good things here. Please work on
> it. I will try and review :-)
> 
