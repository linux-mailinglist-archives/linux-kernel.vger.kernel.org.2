Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5576F4063DD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 02:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243267AbhIJAtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 20:49:55 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:36237 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233498AbhIJAUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 20:20:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0UnpwgrP_1631233127;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UnpwgrP_1631233127)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Sep 2021 08:18:49 +0800
Subject: Re: [PATCH 17/24] x86/entry: Introduce struct ist_regs
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <jroedel@suse.de>,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-18-jiangshanlai@gmail.com>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <eb294b5d-82f2-be80-b3e3-db556c155d95@linux.alibaba.com>
Date:   Fri, 10 Sep 2021 08:18:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210831175025.27570-18-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/1 01:50, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> struct ist_regs is the upmost stack frame for IST interrupt, it
> consists of struct pt_regs and other fields which will be added in
> later patch.
> 
> Make vc_switch_off_ist() take ist_regs as its argument and it will switch
> the whole ist_regs if needed.
> 
> Make the frame before calling paranoid_entry() and paranoid_exit() be
> struct ist_regs.
> 
> This patch is prepared for converting paranoid_entry() and paranoid_exit()
> into C code which will need the additinal fields to store the results in
> paranoid_entry() and to use them in paranoid_exit().

This patch was over designed.

In ASM code, we can easily save results in the callee-saved registers.
For example, rc3 is saved in %r14, gsbase info is saved in %rbx.

And in C code, we can't save results in registers.  And I thought there was
no place to save the results because the CR3 and gsbase are not kernel's.
So I extended the pt_regs to ist_regs to save the results.

But it was incorrect.  The results can be saved in percpu data at the end of
paranoid_entry() after the CR3/gsbase are settled down.  And the results
can be read at the beginning of paranoid_exit() before the CR3/gsbase are
switched to the interrupted context's.

sigh.

> 
> The C interrupt handlers don't use struct ist_regs due to they don't need
> the additional fields in the struct ist_regs, and they still use pt_regs.
> 

