Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1000403246
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 03:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346639AbhIHBkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 21:40:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38025 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235180AbhIHBkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 21:40:36 -0400
Received: from hanvin-mobl2.amr.corp.intel.com ([192.55.54.55])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 1881csTI3985246
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 7 Sep 2021 18:38:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 1881csTI3985246
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631065136;
        bh=SWU8siwqoXV59+HvsvFd3sZ1A9vEq4Keh/dISQ/R4sE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UYz377kBdi+iTpQ/uskG4QQlDadzlRcb5tBpdkiqrubEQJ8kOCySO//ZdCXCiKr49
         IJ+++jmNwGPkaVw3V13yS68CevLqQ1rLPGtjr8wjE7WW8j+fQ1ZcriGheRCI43g8ow
         QKc6lGF0Xg3cZOfbS7riwAzrUowHW9upH2YNQuuuRNtqKlRTflD9TCVJTFpeLawi1Y
         4qjsjLCnaG0gT94JQKgBNMkvSWRyF7gYOIKPjOzU6TnNXuzFJ6U8qzsAg2TrZjba9g
         Wjmc7VMWTDxQPEzby2MlEHLrD7KEpLu3Xe+PNulszt65xtTeDew6eR/n/AJDLYgzDI
         /pkTkYEk3sCjw==
Subject: Re: [PATCH 25/24] x86/traps: Rewrite native_load_gs_index in C code
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210902105052.2842-1-jiangshanlai@gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <9fdb04b1-dbb8-069d-f5ef-d4e8c0f2a83e@zytor.com>
Date:   Tue, 7 Sep 2021 18:38:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210902105052.2842-1-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/21 3:50 AM, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> There is no constrain/limition to force native_load_gs_index() to be in
> ASM code.

Hi,

First of all, let me say I really like your patchset, and I will try to
review it in detail ASAP (most of the initial read pass looks very sane
to me.

However, I would like to object in part this specific patch. It adds a
fair bit of extra code to the exception path, and adds jumps between
files which makes the code much harder to read.

You end up doing one swapgs in assembly and one in C, which would seem
to be a very good indication that really isn't an improvement.

Note that this entire sequence is scheduled to be obsoleted by a single
atomic hardware instruction, LKGS, which will replace ALL of
native_load_gs_index(); it will no longer be necessary even to disable
interrupts as there is no non-atomic state. In that sense, doing this as
an out-of-line C function (with some inline assembly) is great, because
it makes it far easier to use LKGS as an alternative; the only (small)
disadvantage is that it ends up clobbering a lot of registers
unnecessarily (in assembly it can be implemented clobbering only two
registers; one if one uses pushf/popf to save the interrupt flag.)

noinstr void native_load_gs_index(unsigned int selector)
{
	unsigned long flags;

	local_irq_save(flags);
	native_swapgs();
redo:
	asm goto("1: movl %0,%%gs\n",
		   "2:\n"
		   _ASM_EXTABLE(%1)
		   : : "r" (selector) : "i" (&&bad_seg);
	alternative("", "mfence", X86_BUG_SWAPGS_FENCE);
	native_swapgs();
	local_irq_restore(flags);
	return;

bad_seg:
	/* Exception entry will have restored kernel GS */
	native_swapgs();
	
	if (static_cpu_has(X86_BUG_NULL_SEG)) {
		asm volatile("movl %0,%%gs"
			: : "r" (__USER_DS));
	}
	selector = 0;
	goto redo;
}

	-hpa
