Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB45419683
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhI0OkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:40:18 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:51265 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234706AbhI0OkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:40:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UpqZ8xo_1632753514;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UpqZ8xo_1632753514)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Sep 2021 22:38:35 +0800
Subject: Re: [PATCH V2 02/41] x86/traps: Remove stack-protector from traps.c
To:     Borislav Petkov <bp@alien8.de>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Juergen Gross <jgross@suse.com>, Chester Lin <clin@suse.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
 <20210926150838.197719-3-jiangshanlai@gmail.com> <YVGalJLOyK235XvG@zn.tnic>
 <d4e653e7-1f23-eec9-4db7-964298fc1dc5@linux.alibaba.com>
 <YVGkhlaDBwASW7dZ@zn.tnic>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <fb9b6013-8281-9864-d48f-e23ca651a20d@linux.alibaba.com>
Date:   Mon, 27 Sep 2021 22:38:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVGkhlaDBwASW7dZ@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/27 19:01, Borislav Petkov wrote:
> On Mon, Sep 27, 2021 at 06:49:16PM +0800, Lai Jiangshan wrote:
>> Using only "-fno-stack-protector" is enough to disable stack protector with
>> my .config, I'm not so sure about other configuration.
> 
> What does the gcc manpage say about it?
>

In gcc's code, all the -f[no-]stack-protector* argument overwrites the
same flag_stack_protect variable, so the last one takes effect.

 > fstack-protector
 > Common Var(flag_stack_protect, 1) Init(-1) Optimization
 > Use propolice as a stack protection method.
 >
 > fstack-protector-all
 > Common RejectNegative Var(flag_stack_protect, 2) Init(-1) Optimization
 > Use a stack protection method for every function.
 >
 > fstack-protector-strong
 > Common RejectNegative Var(flag_stack_protect, 3) Init(-1) Optimization
 > Use a smart stack protection method for certain functions.
 >
 > fstack-protector-explicit
 > Common RejectNegative Var(flag_stack_protect, 4) Optimization
 > Use stack protection method only for functions with the stack_protect attribute.

In linux kernel's scripts/Makefile.lib, CFLAGS_traps.o is the last flags for
gcc invocation, so only "CFLAGS_traps.o += -fno-stack-protector" must be enough.

 > _c_flags       = $(filter-out $(CFLAGS_REMOVE_$(target-stem).o), \
 >                     $(filter-out $(ccflags-remove-y), \
 >                         $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) $(ccflags-y)) \
 >                     $(CFLAGS_$(target-stem).o))
