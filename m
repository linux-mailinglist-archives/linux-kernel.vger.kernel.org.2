Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3671635E409
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346011AbhDMQeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:34:22 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:26114 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345952AbhDMQeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:34:16 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FKWQ85jTzz9tyy6;
        Tue, 13 Apr 2021 18:33:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0dXyJCLmzTLu; Tue, 13 Apr 2021 18:33:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FKWQ84QPdz9v20H;
        Tue, 13 Apr 2021 18:33:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ED1198B7AC;
        Tue, 13 Apr 2021 18:33:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hU_iZ0QrHbVB; Tue, 13 Apr 2021 18:33:53 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7453D8B75F;
        Tue, 13 Apr 2021 18:33:53 +0200 (CEST)
Subject: Re: [PATCH v1 1/2] powerpc/bitops: Use immediate operand when
 possible
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <09da6fec57792d6559d1ea64e00be9870b02dab4.1617896018.git.christophe.leroy@csgroup.eu>
 <20210412215428.GM26583@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <ecb1b1a5-ae92-e8a3-6490-26341edfbccb@csgroup.eu>
Date:   Tue, 13 Apr 2021 18:33:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210412215428.GM26583@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/04/2021 à 23:54, Segher Boessenkool a écrit :
> Hi!
> 
> On Thu, Apr 08, 2021 at 03:33:44PM +0000, Christophe Leroy wrote:
>> For clear bits, on 32 bits 'rlwinm' can be used instead or 'andc' for
>> when all bits to be cleared are consecutive.
> 
> Also on 64-bits, as long as both the top and bottom bits are in the low
> 32-bit half (for 32 bit mode, it can wrap as well).

Yes. But here we are talking about clearing a few bits, all other ones must remain unchanged. An 
rlwinm on PPC64 will always clear the upper part, which is unlikely what we want.

> 
>> For the time being only
>> handle the single bit case, which we detect by checking whether the
>> mask is a power of two.
> 
> You could look at rs6000_is_valid_mask in GCC:
>    <https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=gcc/config/rs6000/rs6000.c;h=48b8efd732b251c059628096314848305deb0c0b;hb=HEAD#l11148>
> used by rs6000_is_valid_and_mask immediately after it.  You probably
> want to allow only rlwinm in your case, and please note this checks if
> something is a valid mask, not the inverse of a valid mask (as you
> want here).

This check looks more complex than what I need. It is used for both rlw... and rld..., and it 
calculates the operants. The only thing I need is to validate the mask.
I found a way: By anding the mask with the complement of itself rotated by left bits to 1, we 
identify the transitions from 0 to 1. If the result is a power of 2, it means there's only one 
transition so the mask is as expected.

So I did that in v2.


> 
> So yes this is pretty involved :-)
> 
> Your patch looks good btw.  But please use "n", not "i", as constraint?

Done.

Christophe
