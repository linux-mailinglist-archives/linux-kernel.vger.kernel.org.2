Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8B233FF36
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 07:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhCRGEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 02:04:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45399 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhCRGEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 02:04:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F1Gh11tqBz9tvx4;
        Thu, 18 Mar 2021 07:04:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id umrO4-9Ue3pr; Thu, 18 Mar 2021 07:04:33 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F1Gh10xxNz9tvx7;
        Thu, 18 Mar 2021 07:04:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9CF668B8A3;
        Thu, 18 Mar 2021 07:04:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Et8RBiebOB_6; Thu, 18 Mar 2021 07:04:33 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F1ECE8B881;
        Thu, 18 Mar 2021 07:04:32 +0100 (CET)
Subject: Re: [PATCH v2] smp: kernel/panic.c - silence warnings
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     He Ying <heying24@huawei.com>, frederic@kernel.org,
        paulmck@kernel.org, clg@kaod.org, qais.yousef@arm.com,
        johnny.chenyi@huawei.com, linux-kernel@vger.kernel.org
References: <20210316084150.75201-1-heying24@huawei.com>
 <20210317094908.GB1724119@gmail.com>
 <9691919b-d014-7433-3345-812c9b19a677@csgroup.eu>
 <YFH0sDpUIUmdpNkQ@hirez.programming.kicks-ass.net>
 <fa3f9880-eb05-f18e-ae7f-4735209f4c94@csgroup.eu>
 <YFI+YMo7zml+spKc@hirez.programming.kicks-ass.net>
 <20210317200922.GC3830960@gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <55ca1d7c-3920-8ea0-e1de-1bf04088db2c@csgroup.eu>
Date:   Thu, 18 Mar 2021 07:04:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210317200922.GC3830960@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/03/2021 à 21:09, Ingo Molnar a écrit :
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> Now, the C people figured that distinction was useless and allowed
>> sloppiness. But I still think there's merrit to that. And as
>> mentioned earlier, it is consistent with variable declarations.
> 
> Fully agreed, and my other point was that it's also consistent with
> the other existing externs were used *in the same header file*
> already.
> 
> I.e. there's nothing more sloppy than mixing different styles within
> the same header. Checkpatch needs to be fixed or ignored here.
> 

As pointed by He there are already many prototypes not flagged 'extern' in that header. Blaming the 
file shows that most remaining 'extern' are from the old days.

So adding new function prototypes with the 'extern' keywork wouldn't make the file less sloppy but 
would be a step backwards.

I think there is a will to make all those unneccessary 'extern' flags disappear on the long term. To 
achieve that there are two ways: Either smoothly do it on every function prototype modified or added 
or at a point in time big-bang convert the entire file. The later hinders blamability of the file.

Maybe one day we'll convert all remaining 'extern' away once they have become the minority. To 
achieve that we really need to not add new ones.

Christophe
