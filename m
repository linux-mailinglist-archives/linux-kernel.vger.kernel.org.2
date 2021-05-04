Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4B1372922
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 12:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhEDKlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 06:41:40 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:53765 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhEDKlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 06:41:39 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FZGZz2zDSz9sVs;
        Tue,  4 May 2021 12:40:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0E2klIs5KUQ6; Tue,  4 May 2021 12:40:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FZGZz22Nyz9sVq;
        Tue,  4 May 2021 12:40:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 02E7E8B7A2;
        Tue,  4 May 2021 12:40:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id n--sAVAbfbtx; Tue,  4 May 2021 12:40:42 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A8FA8B7A1;
        Tue,  4 May 2021 12:40:42 +0200 (CEST)
Subject: Re: [PATCH 1/2] powerpc/asm-offset: Remove unused items related to
 paca
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <f38728dbe96df5fef84c868640def5f6d7c114bc.1620060357.git.christophe.leroy@csgroup.eu>
 <1620121538.q0b7uiea5y.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9b07e9c1-b004-a814-278b-c6a1f7b616e3@csgroup.eu>
Date:   Tue, 4 May 2021 12:40:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1620121538.q0b7uiea5y.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 04/05/2021 à 12:14, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of May 4, 2021 2:46 am:
>> PACA_SIZE, PACACONTEXTID, PACALOWSLICESPSIZE, PACAHIGHSLICEPSIZE,
>> PACA_SLB_ADDR_LIMIT, MMUPSIZEDEFSIZE, PACASLBCACHE, PACASLBCACHEPTR,
>> PACASTABRR, PACAVMALLOCSLLP, MMUPSIZESLLP, PACACONTEXTSLLP,
>> PACALPPACAPTR, LPPACA_DTLIDX and PACA_DTL_RIDX are not used anymore
>> by ASM code.
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
> Also I think SIGSEGV, NMI_MASK, THREAD_DBCR0, KUAP?, TI_FLAGS,
> TI_PREEMPT, [ID]CACHEL1*, STACK_REGS_KUAP, EXC_LVL_SIZE, KVM_NEED_FLUSH,
> KVM_FWNMI, VCPU_DEC, VCPU_SPMC, HSTATE_XICS_PHYS, HSTATE_SAVED_XIRR,
> PPC_DBELL_MSGTYPE I think. While we're cleaning it up.

Yes, thanks for checking.

I think we can safely remove KUAP.

But we can't remove EXC_LVL_SIZE, it is used in kernel/head_booke.h which is probably included in 
head_44x.S and head_fsl_booke.S

Christophe
