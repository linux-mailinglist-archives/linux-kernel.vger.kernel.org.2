Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB34032E3FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 09:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhCEIys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 03:54:48 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:52688 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhCEIy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 03:54:27 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DsM406713z9twsP;
        Fri,  5 Mar 2021 09:54:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id T8CJAndR9POI; Fri,  5 Mar 2021 09:54:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DsM405JP6z9twsN;
        Fri,  5 Mar 2021 09:54:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B77808B78B;
        Fri,  5 Mar 2021 09:54:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ODY3hqu1EVFa; Fri,  5 Mar 2021 09:54:25 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D8ED8B818;
        Fri,  5 Mar 2021 09:54:25 +0100 (CET)
Subject: Re: [PATCH v5 05/22] powerpc/irq: Add helper to set regs->softe
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
 <5f37d1177a751fdbca79df461d283850ca3a34a2.1612796617.git.christophe.leroy@csgroup.eu>
 <1612832745.vhjk6358hf.astroid@bobo.none>
 <5987787e-ee80-ed0e-0c34-9884f6aad3c5@csgroup.eu>
 <1612856863.0x6ebz3hce.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <d243672c-ea47-2d0c-bfe4-e6eed5460868@csgroup.eu>
Date:   Fri, 5 Mar 2021 09:54:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1612856863.0x6ebz3hce.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/02/2021 à 08:49, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of February 9, 2021 4:18 pm:
>>
>>
>> Le 09/02/2021 à 02:11, Nicholas Piggin a écrit :
>>> Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
>>>> regs->softe doesn't exist on PPC32.
>>>>
>>>> Add irq_soft_mask_regs_set_state() helper to set regs->softe.
>>>> This helper will void on PPC32.
>>>>
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>> ---
>>>
>>> You could do the same with the kuap_ functions to change some ifdefs
>>> to IS_ENABLED.
>>>
>>> That's just my preference but if you prefer this way I guess that's
>>> okay.
>>>
>>
>>
>> That's also my preference on the long term.
>>
>> Here it is ephemeral, I have a follow up series implementing interrupt exit/entry in C and getting
>> rid of all the assembly kuap hence getting rid of those ifdefs.
> 
> I thought it might have been because you hate ifdef more tha most :)
>   
>> The issue I see when using IS_ENABLED() is that you have to indent to the right, then you interfere
>> with the file history and 'git blame'
> 
> Valid point if it's just going to indent back the other way in your next
> series.
> 
>> Thanks for reviewing my series and looking forward to your feedback on my series on the interrupt
>> entry/exit that I will likely release later today.
> 
> Cool, I'm eager to see them.
> 

Hi Nick, have you been able to look at it ?

https://patchwork.ozlabs.org/project/linuxppc-dev/cover/cover.1612864003.git.christophe.leroy@csgroup.eu/

Thanks
Christophe
