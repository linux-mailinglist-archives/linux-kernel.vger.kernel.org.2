Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C31437AD4D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhEKRpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:45:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43719 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231454AbhEKRpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:45:49 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14BHiROf2638597
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 11 May 2021 10:44:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14BHiROf2638597
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620755068;
        bh=I4Nrpc4juIjYCBgtvXLG7yW+fRLX4yY6QBjep1Kuktg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QEGipmfIgGW2WKZWBN/rKm1HxRv59ELISh87mPr5dY/r7cl6GWCeJBtQGsJQAmqwf
         8rjqVVEPHimsnjoVKTNR7jCcmOoDSqWAS9PrQwfd73vRV8Yxl/KJa9itlbZl6nWALt
         kLEvyWNgNIl9nYdzssGkA78bN6M91VEC7BxxyvcFUN0dCCCep3F8K088LFukRe5/nH
         Ppmn4yMFTIoRWXPRW/ieFWw9//WDi23hL42Smqv6SwMyh7izSZEBYKeFyVvJFzw9W7
         cbp1cCsSuRSgPmDmp530of+QrTvLOQ3SJBzpaemq1O6wDvCVOrqRF16XUCdqqKMqJy
         ZNTtqOIsiKDTw==
Subject: Re: [PATCH 4/6] x86/irq: merge common code in
 DEFINE_IDTENTRY_SYSVEC[_SIMPLE]
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210511005531.1065536-1-hpa@zytor.com>
 <20210511005531.1065536-5-hpa@zytor.com>
 <87lf8lfizj.ffs@nanos.tec.linutronix.de>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <d6789f7c-9c44-cb57-2a52-03ac9474d2e2@zytor.com>
Date:   Tue, 11 May 2021 10:44:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87lf8lfizj.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/21 7:22 AM, Thomas Gleixner wrote:
> 
> That's not really making the code more readable. Something like the
> below perhaps?
> 
> #define IDTENTRY_INVOKE_SYSVEC(func, regs, raw)				\
> do {									\
> 	irqentry_state_t state = irqentry_enter(regs);			\
> 									\
> 	instrumentation_begin();					\
> 	kvm_set_cpu_l1tf_flush_l1d();					\
>          if (raw) {							\
> 		__irq_enter_raw();					\
> 		func(regs);						\
> 		__irq_exit_raw();			                \
> 	} else {	                                                \
> 		run_sysvec_on_irqstack_cond(func, regs);	        \
>          }                                                               \
> 	instrumentation_end();						\
>          irqentry_exit(regs, state);					\
> } while (0)								\
> 

Digging more into it, it looks like a *lot* of the macros in 
<asm/irq_stack.h> and <asm/idtentry.h> can be replaced with inlines 
without any change in functionality or generated code.

	-hpa

