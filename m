Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E483F4EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhHWRIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:08:06 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:55711 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230474AbhHWRGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:06:33 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Gtdt53jKnz9sTr;
        Mon, 23 Aug 2021 19:05:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fbdMG_FqIlnR; Mon, 23 Aug 2021 19:05:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Gtdt52kzjz9sTg;
        Mon, 23 Aug 2021 19:05:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 268CE8B7AD;
        Mon, 23 Aug 2021 19:05:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2xoQtNv-6Qji; Mon, 23 Aug 2021 19:05:49 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BABDA8B7BA;
        Mon, 23 Aug 2021 19:05:48 +0200 (CEST)
Subject: Re: [PATCH] powerpc/booke: Avoid link stack corruption in several
 places
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <d7435e616336fd5f07bb19ec61e97d71e5c53568.1629705153.git.christophe.leroy@csgroup.eu>
 <20210823155837.GX1583@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <67a5be3f-a443-03eb-aa8e-a1fa6c0b3d3f@csgroup.eu>
Date:   Mon, 23 Aug 2021 19:05:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823155837.GX1583@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 23/08/2021 à 17:58, Segher Boessenkool a écrit :
> On Mon, Aug 23, 2021 at 07:53:01AM +0000, Christophe Leroy wrote:
>>   /* Be careful, this will clobber the lr register. */
>>   #define LOAD_REG_ADDR_PIC(reg, name)		\
>> -	bl	0f;				\
>> +	bcl	20,31,0f			\
>>   0:	mflr	reg;				\
>>   	addis	reg,reg,(name - 0b)@ha;		\
>>   	addi	reg,reg,(name - 0b)@l;
> 
> The code ended each line with a semicolon before, for absolutely no
> reason that I can see, but still.  Fixing that would be nice, but only
> doing it on one line isn't good.

Sure, forgetting the semicolon broke the build. That's because the backslash removes the newline.

The cleanest way I found to fix that quite of stuff is by using GAS macro, as I did for 
LOAD_REG_IMMEDIATE() some time ago.

> 
> Btw.  Both the 7450 and the modern cores implementing this really need
> this to be $+4, so it is a lot clearer to write that instead of 1f or
> a named label.

I like that, removing unneeded labels will make it smoother and clearer. I'll do it.

Christophe
