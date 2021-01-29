Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16884308ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhA2RCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:02:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:47082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231915AbhA2RAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:00:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A127ACB7;
        Fri, 29 Jan 2021 16:59:55 +0000 (UTC)
Subject: Re: [PATCH v2] x86/debug: Fix DR6 handling
To:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        andrew.cooper3@citrix.com, Frederic Weisbecker <fweisbec@gmail.com>
References: <YBMAbQGACujjfz+i@hirez.programming.kicks-ass.net>
 <20210128211627.GB4348@worktop.programming.kicks-ass.net>
 <20210129144816.GB27841@zn.tnic>
From:   Tom de Vries <tdevries@suse.de>
Message-ID: <50670b90-6d53-8c65-b3c8-e76fc9e2a1d3@suse.de>
Date:   Fri, 29 Jan 2021 17:59:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210129144816.GB27841@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/21 3:48 PM, Borislav Petkov wrote:
> On Thu, Jan 28, 2021 at 10:16:27PM +0100, Peter Zijlstra wrote:
>>
>> Tom reported that one of the GDB test-cases failed, and Boris bisected
>> it to commit:
>>
>>   d53d9bc0cf78 ("x86/debug: Change thread.debugreg6 to thread.virtual_dr6")
>>
>> The debugging session led us to commit:
>>
>>   6c0aca288e72 ("x86: Ignore trap bits on single step exceptions")
>>
>> It turns out that TF and data breakpoints are both traps and will be
>> merged, while instruction breakpoints are faults and will not be
>> merged. This means 6c0aca288e72 is wrong, we only need to exclude TF
>> and instruction breakpoints while we can merge TF and data
>> breakpoints.
>>
>> Fixes: d53d9bc0cf78 ("x86/debug: Change thread.debugreg6 to thread.virtual_dr6")
>> Fixes: 6c0aca288e72 ("x86: Ignore trap bits on single step exceptions")
>> Reported-by: Tom de Vries <tdevries@suse.de>
>> Bisected-by: Borislav Petkov <bp@alien8.de>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I guess
> 
> Cc: <stable@vger.kernel.org>
> 
> Also,
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>
> 
> And gdb testsuite is a bit happier:
> 
> --- before
> +++ after
>                  === gdb Summary ===
>  
> -# of expected passes            70822
> -# of unexpected failures        899
> +# of expected passes            70852
> +# of unexpected failures        869
>  # of expected failures          74
>  # of known failures             99
>  # of untested testcases         114
> 
> You just fixed 30(!) testcases.
> 
> :-)
> 

Hi Boris,

thanks for testing this, and just to confirm: the total number of
regressions I see in the gdb testsuite related to watchpoints is indeed 30.

Thanks,
- Tom
