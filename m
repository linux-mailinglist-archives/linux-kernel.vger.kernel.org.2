Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FA033FF16
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 06:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhCRFyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 01:54:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:31043 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhCRFxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:53:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F1GRX4sC9z9tvtv;
        Thu, 18 Mar 2021 06:53:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id oB0Ub6KcefCg; Thu, 18 Mar 2021 06:53:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F1GRX3xNTz9tvtt;
        Thu, 18 Mar 2021 06:53:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3CE8B8B884;
        Thu, 18 Mar 2021 06:53:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id cKB2rdsh--uZ; Thu, 18 Mar 2021 06:53:44 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DC9D38B75F;
        Thu, 18 Mar 2021 06:53:41 +0100 (CET)
Subject: Re: [PATCH v2] smp: kernel/panic.c - silence warnings
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, He Ying <heying24@huawei.com>,
        frederic@kernel.org, paulmck@kernel.org, clg@kaod.org,
        qais.yousef@arm.com, johnny.chenyi@huawei.com,
        linux-kernel@vger.kernel.org
References: <20210316084150.75201-1-heying24@huawei.com>
 <20210317094908.GB1724119@gmail.com>
 <9691919b-d014-7433-3345-812c9b19a677@csgroup.eu>
 <YFH0sDpUIUmdpNkQ@hirez.programming.kicks-ass.net>
 <fa3f9880-eb05-f18e-ae7f-4735209f4c94@csgroup.eu>
 <YFI+YMo7zml+spKc@hirez.programming.kicks-ass.net>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <f6cb47a6-45c9-ad8f-6657-90958a86c3e1@csgroup.eu>
Date:   Thu, 18 Mar 2021 06:53:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFI+YMo7zml+spKc@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/03/2021 à 18:37, Peter Zijlstra a écrit :
> On Wed, Mar 17, 2021 at 06:17:26PM +0100, Christophe Leroy wrote:
>>
>>
>> Le 17/03/2021 à 13:23, Peter Zijlstra a écrit :
>>> On Wed, Mar 17, 2021 at 12:00:29PM +0100, Christophe Leroy wrote:
>>>> What do you mean ? 'extern' prototype is pointless for function prototypes
>>>> and deprecated, no new function prototypes should be added with the 'extern'
>>>> keyword.
>>>>
>>>> checkpatch.pl tells you: "extern prototypes should be avoided in .h files"
>>>
>>> I have a very strong preference for extern on function decls, to match
>>> the extern on variable decl.
>>
>> You mean you also do 'static inline' variable declarations ?
> 
> That's a func definition, not a declaration. And you _can_ do static
> variable definitions in a header file just fine, although that's
> typically not what you'd want. Although sometimes I've seen people do:
> 
> static const int my_var = 10;
> 
> inline is an attribute that obviously doesn't work on variables.
> 
>> Using the extern keyword on function prototypes is superfluous visual
>> noise so suggest removing it.
> 
> I don't agree; and I think the C spec is actually wrong there (too).
> 
> The thing is that it distinguishes between a forward declaration of a
> function in the same TU and an external declaration for a function in
> another TU.
> 
> That is; if I see:
> 
> void ponies(int legs);
> 
> I expect that function to be defined later in the same TU. IOW it's a
> forward declaration. OTOH if I see:
> 
> extern void ponies(int legs);
> 
> I know I won't find it in this TU and the linker will end up involved.

Yes I can understand that for a .c file where you want to distinguish between forward declaration of 
functions defined in the file and functions declared outside. There, it is definitely an added value.

But in .h, all functions must be defined somewhere else, otherwise you have another problem. So all 
functions would have the 'extern' keyword according to your reasoning. Therefore that's just useless 
and I fully agree with Checkpatch's commit that in that case that's "superfluous visual noise" 
impeding readability and making it more difficult to fit the prototype on a single line.


> 
> Now, the C people figured that distinction was useless and allowed
> sloppiness. But I still think there's merrit to that. And as mentioned
> earlier, it is consistent with variable declarations.
> 
