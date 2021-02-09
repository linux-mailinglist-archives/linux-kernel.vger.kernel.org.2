Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EF731488B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhBIGTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:19:34 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:48528 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhBIGTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:19:32 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZXlR52gxz9vBmS;
        Tue,  9 Feb 2021 07:18:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id uMwsPFVyGa3r; Tue,  9 Feb 2021 07:18:43 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZXlR2dJyz9vBmK;
        Tue,  9 Feb 2021 07:18:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0D6D48B7CB;
        Tue,  9 Feb 2021 07:18:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UWE8sIuMAx0B; Tue,  9 Feb 2021 07:18:43 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7AA778B764;
        Tue,  9 Feb 2021 07:18:43 +0100 (CET)
Subject: Re: [PATCH v5 05/22] powerpc/irq: Add helper to set regs->softe
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
 <5f37d1177a751fdbca79df461d283850ca3a34a2.1612796617.git.christophe.leroy@csgroup.eu>
 <1612832745.vhjk6358hf.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <5987787e-ee80-ed0e-0c34-9884f6aad3c5@csgroup.eu>
Date:   Tue, 9 Feb 2021 07:18:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1612832745.vhjk6358hf.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/02/2021 à 02:11, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
>> regs->softe doesn't exist on PPC32.
>>
>> Add irq_soft_mask_regs_set_state() helper to set regs->softe.
>> This helper will void on PPC32.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
> 
> You could do the same with the kuap_ functions to change some ifdefs
> to IS_ENABLED.
> 
> That's just my preference but if you prefer this way I guess that's
> okay.
> 


That's also my preference on the long term.

Here it is ephemeral, I have a follow up series implementing interrupt exit/entry in C and getting 
rid of all the assembly kuap hence getting rid of those ifdefs.

The issue I see when using IS_ENABLED() is that you have to indent to the right, then you interfere 
with the file history and 'git blame'

Thanks for reviewing my series and looking forward to your feedback on my series on the interrupt 
entry/exit that I will likely release later today.

Christophe
