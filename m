Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D75C33FF69
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 07:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhCRGMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 02:12:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61356 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhCRGLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 02:11:51 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F1GrP2Rf7z9tvx3;
        Thu, 18 Mar 2021 07:11:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id A7Ylsf76FtmC; Thu, 18 Mar 2021 07:11:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F1GrP1YNxz9tvx7;
        Thu, 18 Mar 2021 07:11:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0EC1D8B8A3;
        Thu, 18 Mar 2021 07:11:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dktncMvcH3Oh; Thu, 18 Mar 2021 07:11:49 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 73C5A8B881;
        Thu, 18 Mar 2021 07:11:49 +0100 (CET)
Subject: Re: [PATCH v2] smp: kernel/panic.c - silence warnings
To:     "heying (H)" <heying24@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     frederic@kernel.org, paulmck@kernel.org, clg@kaod.org,
        qais.yousef@arm.com, johnny.chenyi@huawei.com,
        linux-kernel@vger.kernel.org
References: <20210316084150.75201-1-heying24@huawei.com>
 <20210317094908.GB1724119@gmail.com>
 <9691919b-d014-7433-3345-812c9b19a677@csgroup.eu>
 <YFH0sDpUIUmdpNkQ@hirez.programming.kicks-ass.net>
 <fa3f9880-eb05-f18e-ae7f-4735209f4c94@csgroup.eu>
 <YFI+YMo7zml+spKc@hirez.programming.kicks-ass.net>
 <20210317200922.GC3830960@gmail.com>
 <d94077e7-8599-a3c1-af76-65e588ea8d33@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <aa53f274-b10c-f44e-0da8-6307b366d50e@csgroup.eu>
Date:   Thu, 18 Mar 2021 07:11:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d94077e7-8599-a3c1-af76-65e588ea8d33@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/03/2021 à 03:56, heying (H) a écrit :
> 
> 在 2021/3/18 4:09, Ingo Molnar 写道:
>> * Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>> Now, the C people figured that distinction was useless and allowed
>>> sloppiness. But I still think there's merrit to that. And as
>>> mentioned earlier, it is consistent with variable declarations.
>> Fully agreed, and my other point was that it's also consistent with
>> the other existing externs were used *in the same header file*
>> already.
>>
>> I.e. there's nothing more sloppy than mixing different styles within
>> the same header. Checkpatch needs to be fixed or ignored here.
> 
> Thank you all for the reply!
> 
> There are already mixing different styles within linux/smp.h. I mean 'extern' and
> 
> non 'extern' func declarations both exist in this header. Since two of you three
> 
> think that 'extern' is needed, I'll add it and resend my patch.
> 
> 

As you are pointing, there are already non 'extern' func protoypes in the file, the conversion has 
already started, so flagging new prototypes with 'extern' would be a step backwards.
