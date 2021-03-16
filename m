Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7922E33DC45
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbhCPSLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:11:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44578 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234468AbhCPSKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:10:32 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F0LtQ5qpxz9v0hq;
        Tue, 16 Mar 2021 19:10:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id b9cIQnu_A5rj; Tue, 16 Mar 2021 19:10:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F0LtQ3h1Nz9v0hm;
        Tue, 16 Mar 2021 19:10:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2FFD98B7EE;
        Tue, 16 Mar 2021 19:10:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pg33Skpor4nr; Tue, 16 Mar 2021 19:10:24 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B55658B7E1;
        Tue, 16 Mar 2021 19:10:23 +0100 (CET)
Subject: Re: [PATCH] net: ethernet: fs-enet: remove casting dma_alloc_coherent
To:     David Laight <David.Laight@ACULAB.COM>,
        Xu Wang <vulab@iscas.ac.cn>,
        "pantelis.antoniou@gmail.com" <pantelis.antoniou@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201211085212.85457-1-vulab@iscas.ac.cn>
 <34548188-67f4-d3ef-c2e3-871fc520e838@csgroup.eu>
 <6fc4b62ee7754d78b8f7b9c2275bc47e@AcuMS.aculab.com>
 <4a1c2852-781f-e125-afcb-69387660b6af@csgroup.eu>
 <3f31140339c94652b1e7116e91cfd9c8@AcuMS.aculab.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <7f322df3-80b6-dfd0-caf2-afc2ca3950b1@csgroup.eu>
Date:   Tue, 16 Mar 2021 19:10:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3f31140339c94652b1e7116e91cfd9c8@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/12/2020 à 17:55, David Laight a écrit :
> From: Christophe Leroy
>> Sent: 11 December 2020 16:43
>>
>> Le 11/12/2020 à 17:07, David Laight a écrit :
>>> From: Christophe Leroy
>>>> Sent: 11 December 2020 15:22
>>>>
>>>> Le 11/12/2020 à 09:52, Xu Wang a écrit :
>>>>> Remove casting the values returned by dma_alloc_coherent.
>>>>
>>>> Can you explain more in the commit log ?
>>>>
>>>> As far as I can see, dma_alloc_coherent() doesn't return __iomem, and ring_base member is __iomem
>>>
>>> Which is probably wrong - that is the kernel address of kernel memory.
>>> So it shouldn't have the __iomem marker.
>>
>> That's where the buffer descriptors are, the driver accesses to the content of the buffer
>> descriptors using the IO accessors in_be16()/out_be16(). Is it not correct ?
> 
> I've just been looking at the crap in there.
> My understanding is that IO accessors are for IO devices (eg addresses
> from io_remap() etc).
> 
> Buffers allocated by dma_alloc_coherent() are normal kernel memory
> and don't need any accessors.
> Now you might need some barriers - mostly because an ethernet chip
> can typically read a ring entry without being prodded.
> IIRC there is a barrier in writel() to ensure the dma master will
> 'see' all memory writes done before the IO write that kicks it into
> doing some processing.

As far as I can see, writel() is using __iomem memory, see 
https://elixir.bootlin.com/linux/v5.12-rc2/source/include/asm-generic/io.h#L221

> 
> The fact that the driver contains so many __iomem casts (eg in
> tx_restart) is an indication that something is badly awry.
> __iomem exists to check you are using the correct type of pointer.
> Any __iomem casts are dubious.

I agree, but what else can we do to guarantee proper access to that memory ?

Christophe
