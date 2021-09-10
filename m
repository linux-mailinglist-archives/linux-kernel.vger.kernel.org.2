Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF9E40678E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 09:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhIJHQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 03:16:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45759 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231433AbhIJHQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:16:14 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8600:3c70:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 18A7EVYA350052
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 10 Sep 2021 00:14:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 18A7EVYA350052
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631258073;
        bh=eU0ElfVj1/mQmWtKeUyg1o4QluHw1VPYo4/0678CeKs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WIF5D1iEFN+MUrrsHNdEK3BEC2Ojo4cRclKlkyuwPlHygKnt+u9buVEoOgtbm3GjQ
         cNaVS7iWyMz+hZK8WQnYyRhGucKfaPud1gi1Mz9nOEUv4T+pXpsGV2ZXon+mx6Tgu9
         HWDDK5ped4XZaGRL/NEQk1L3Lb+EARIyLDq5qg1+2H8xFRd0h1czi11wAtxpmplMr7
         VtSxk6kuhtnxu1qLwxQwy0JbBNfcGvfl4lDqPF+5tlEKssZ2ey1c6JpUd3qCWN5zjZ
         QkSUiXfYmQp1KhTWXwudKjOcfX8lAlvqCW/UFXF67IdnrjiUqo25XPPaMvDxUV+nBT
         KGfB4AQkm6Rmw==
Subject: Re: [PATCH 17/24] x86/entry: Introduce struct ist_regs
To:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-18-jiangshanlai@gmail.com>
 <eb294b5d-82f2-be80-b3e3-db556c155d95@linux.alibaba.com>
 <9fe0e26b-5fb7-4521-a01e-8edd8d5cb74c@zytor.com>
 <3729bc02-1e4b-d2db-aabb-cb3610d8fd7d@linux.alibaba.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <da955b87-e2d4-6019-72a2-e00da0c8b714@zytor.com>
Date:   Fri, 10 Sep 2021 00:14:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3729bc02-1e4b-d2db-aabb-cb3610d8fd7d@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/21 12:13 AM, Lai Jiangshan wrote:
> 
> 
> On 2021/9/10 12:31, H. Peter Anvin wrote:
>> Note: the examples in this email all compiled with:
>>
>> gcc -O2 -mpreferred-stack-boundary=3 -mcmodel=kernel
>>
>> The disassembly has been slightly simplified.
> 
> Saving results in registers is non-flexible no matter in ASM or hack in 
> C like this.
> 
> Saving CR3 in ist_regs is not different than saving rax in pt_regs, and 
> both of
> ist_regs and embedded pt_regs can be moved when stack is required to 
> switch.
> 
> I prefer to my original design.
> 

I agree. I was having some issues following your arguments.

	-hpa

