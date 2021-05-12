Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EFD37C084
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhELOoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:44:55 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:53807 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231380AbhELOoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:44:54 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FgHbh5mDJz9sdw;
        Wed, 12 May 2021 16:43:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XhpERfMAMcjt; Wed, 12 May 2021 16:43:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FgHbh4nsRz9sdc;
        Wed, 12 May 2021 16:43:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 83D6C8B7F4;
        Wed, 12 May 2021 16:43:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KNm8b5FGVtrW; Wed, 12 May 2021 16:43:44 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 10B2E8B7F3;
        Wed, 12 May 2021 16:43:44 +0200 (CEST)
Subject: Re: [PATCH] powerpc: Force inlining of csum_add()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <f7f4d4e364de6e473da874468b903da6e5d97adc.1620713272.git.christophe.leroy@csgroup.eu>
 <20210511105154.GJ10366@gate.crashing.org>
 <e996ef13-c25c-5e9c-edd2-444eded88802@csgroup.eu>
 <20210512143105.GW10366@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <2623fe98-7a73-f7a2-bcba-2d668d00ffd0@csgroup.eu>
Date:   Wed, 12 May 2021 16:43:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210512143105.GW10366@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/05/2021 à 16:31, Segher Boessenkool a écrit :
> On Wed, May 12, 2021 at 02:56:56PM +0200, Christophe Leroy wrote:
>> Le 11/05/2021 à 12:51, Segher Boessenkool a écrit :
>>> Something seems to have decided this asm is more expensive than it is.
>>> That isn't always avoidable -- the compiler cannot look inside asms --
>>> but it seems it could be improved here.
>>>
>>> Do you have (or can make) a self-contained testcase?
>>
>> I have not tried, and I fear it might be difficult, because on a kernel
>> build with dozens of calls to csum_add(), only ip6_tunnel.o exhibits such
>> an issue.
> 
> Yeah.  Sometimes you can force some of the decisions, but that usually
> requires knowing too many GCC internals :-/
> 
>>>> And there is even one completely unused instance of csum_add().
>>>
>>> That is strange, that should never happen.
>>
>> It seems that several .o include unused versions of csum_add. After the
>> final link, one remains (in addition to the used one) in vmlinux.
> 
> But it is a static function, so it should not end up in any object file
> where it isn't used.

Well .... did I dream ?

Now I only find one extra .o with unused csum_add() : That's net/ipv6/exthdrs.o
It matches the one found in vmlinux.

Are you interested in -fdump-tree-einline-all for that one as well ?

Christophe
