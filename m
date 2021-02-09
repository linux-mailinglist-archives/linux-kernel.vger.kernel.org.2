Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7013231538D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhBIQOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:14:33 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:23375 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232788AbhBIQOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:14:17 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZnxl0tRtz9v0Jx;
        Tue,  9 Feb 2021 17:13:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id VNxI6Xy2d8lS; Tue,  9 Feb 2021 17:13:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZnxk6yd8z9v0JL;
        Tue,  9 Feb 2021 17:13:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7ED6B8B764;
        Tue,  9 Feb 2021 17:13:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SpEj3Si2q6SX; Tue,  9 Feb 2021 17:13:32 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BE8778B7EA;
        Tue,  9 Feb 2021 17:13:31 +0100 (CET)
Subject: Re: [PATCH v5 16/22] powerpc/syscall: Avoid stack frame in likely
 part of system_call_exception()
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
 <981edfd50d4c980634b74c4bb76b765c499a87ec.1612796617.git.christophe.leroy@csgroup.eu>
 <1612834634.qle1lc7n6y.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <f2b17529-e1b6-3d2c-a38b-51e91841e438@csgroup.eu>
Date:   Tue, 9 Feb 2021 17:13:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1612834634.qle1lc7n6y.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/02/2021 à 02:55, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
>> When r3 is not modified, reload it from regs->orig_r3 to free
>> volatile registers. This avoids a stack frame for the likely part
>> of system_call_exception()
> 
> This doesn't on my 64s build, but it does reduce one non volatile
> register save/restore. With quite a bit more register pressure
> reduction 64s can avoid the stack frame as well.

The stack frame is not due to the registers because on PPC64 you have the redzone that you don't 
have on PPC32.

As far as I can see, this is due to a call to .arch_local_irq_restore().

On ppc32 arch_local_irq_restore() is just a write to MSR.


> 
> It's a cool trick but quite code and compiler specific so I don't know
> how worthwhile it is to keep considering we're calling out into random
> kernel C code after this.
> 
> Maybe just keep it PPC32 specific for the moment, will have to do more
> tuning for 64 and we have other stuff to do there first.
> 
> If you are happy to make it 32-bit only then

I think we can leave without this, that's only one or two cycles won.

> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
