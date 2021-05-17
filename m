Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE12C382E13
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 15:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbhEQN7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 09:59:50 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:58467 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232924AbhEQN7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 09:59:48 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FkLMB5gl4z9sYQ;
        Mon, 17 May 2021 15:58:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Kki3eKxYEEqF; Mon, 17 May 2021 15:58:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FkLMB4h80z9sYK;
        Mon, 17 May 2021 15:58:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7D71A8B7A1;
        Mon, 17 May 2021 15:58:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZgcPxZlbLKOZ; Mon, 17 May 2021 15:58:30 +0200 (CEST)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2E5D78B79C;
        Mon, 17 May 2021 15:58:30 +0200 (CEST)
Subject: Re: [PATCH 1/2] powerpc/interrupt: Refactor
 interrupt_exit_user_prepare() and syscall_exit_prepare()
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cd0634769e5fea397411a0f833db52749852c6f8.1620980916.git.christophe.leroy@csgroup.eu>
 <1621237386.33q9uyrpc3.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <96329062-9e00-28a7-749e-b57a34beb56c@csgroup.eu>
Date:   Mon, 17 May 2021 15:57:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1621237386.33q9uyrpc3.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/05/2021 à 09:44, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of May 14, 2021 6:28 pm:
>> Last part of interrupt_exit_user_prepare() and syscall_exit_prepare()
>> are identical.
>>
>> Create a __interrupt_exit_user_prepare() function that is called by
>> both.
>>
>> Note that it replaces a local_irq_save(flags) by local_irq_disable().
>> This is similar because the flags are never used. On ppc 8xx it is
>> more efficient because it doesn't require reading MSR.
> 
> Can these cleanups go after my interrupt performance improvements?
> I posted them for last series but were dropped due to crashes without
> time to resubmit. I'm working on them again now.
> 

Euh ... ok why not, but at the time being interrupt_exit_user_prepare() and syscall_exit_prepare() 
are very similar. Which makes sense because both of them are returning from kernel to user so they 
are to do the same preparation.

If you are doing the same changes to both of them, maybe it is worst including this refactor at the 
begining of your series. Or are you making them diverge with that series ?

Christophe
