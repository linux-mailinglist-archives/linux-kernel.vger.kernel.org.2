Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF5F33F679
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhCQRTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:19:16 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42198 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231496AbhCQRSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:18:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F0xhW4686zB09ZS;
        Wed, 17 Mar 2021 18:18:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1TfmklXGjI7B; Wed, 17 Mar 2021 18:18:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F0xhW2GmDzB09ZR;
        Wed, 17 Mar 2021 18:18:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0F4BB8B865;
        Wed, 17 Mar 2021 18:18:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ejfXgb44Hb8E; Wed, 17 Mar 2021 18:18:52 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6F19C8B862;
        Wed, 17 Mar 2021 18:18:52 +0100 (CET)
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
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <fa3f9880-eb05-f18e-ae7f-4735209f4c94@csgroup.eu>
Date:   Wed, 17 Mar 2021 18:17:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFH0sDpUIUmdpNkQ@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/03/2021 à 13:23, Peter Zijlstra a écrit :
> On Wed, Mar 17, 2021 at 12:00:29PM +0100, Christophe Leroy wrote:
>> What do you mean ? 'extern' prototype is pointless for function prototypes
>> and deprecated, no new function prototypes should be added with the 'extern'
>> keyword.
>>
>> checkpatch.pl tells you: "extern prototypes should be avoided in .h files"
> 
> I have a very strong preference for extern on function decls, to match
> the extern on variable decl.

You mean you also do 'static inline' variable declarations ?

I think you just can't compare variable declarations and function declaration, that's too different.

> 
> Checkpatch is just wrong here.
> 

checkpatch seems rather pragmatic, the commit message says:

  checkpatch: warn when using extern with function prototypes in .h files

Using the extern keyword on function prototypes is superfluous visual
noise so suggest removing it.

Using extern can cause unnecessary line wrapping at 80 columns and
unnecessarily long multi-line function prototypes.

Signed-off-by: Joe Perches <joe@perches.com>
Suggested-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
