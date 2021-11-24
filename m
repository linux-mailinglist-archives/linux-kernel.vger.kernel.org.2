Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1517D45CBB2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243936AbhKXSDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:03:22 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:50969 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241542AbhKXSDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:03:19 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Hzpgr06S0z9sSd;
        Wed, 24 Nov 2021 19:00:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ejOeD01wWWP3; Wed, 24 Nov 2021 19:00:07 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Hzpgq6T6Wz9sSW;
        Wed, 24 Nov 2021 19:00:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C983B8B778;
        Wed, 24 Nov 2021 19:00:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ClHnKbCP8Ky3; Wed, 24 Nov 2021 19:00:07 +0100 (CET)
Received: from [192.168.203.221] (unknown [192.168.203.221])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 267C48B763;
        Wed, 24 Nov 2021 19:00:07 +0100 (CET)
Message-ID: <dc0ceed5-1db5-294f-9f17-1990fb2dd5e4@csgroup.eu>
Date:   Wed, 24 Nov 2021 19:00:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 0/8] Convert powerpc to default topdown mmap layout
Content-Language: fr-FR
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Nicholas Piggin <npiggin@gmail.com>, alex@ghiti.fr,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <cover.1637570556.git.christophe.leroy@csgroup.eu>
 <1637759994.e3mppl4ly7.astroid@bobo.none>
 <e1fea487-8014-658d-84cd-ea1d7c89ee08@csgroup.eu>
In-Reply-To: <e1fea487-8014-658d-84cd-ea1d7c89ee08@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/11/2021 à 14:40, Christophe Leroy a écrit :
> 
> 
> Le 24/11/2021 à 14:21, Nicholas Piggin a écrit :
>> Excerpts from Christophe Leroy's message of November 22, 2021 6:48 pm:
>>> This series converts powerpc to default topdown mmap layout.
>>>
>>> powerpc provides its own arch_get_unmapped_area() only when
>>> slices are needed, which is only for book3s/64. First part of
>>> the series moves slices into book3s/64 specific directories
>>> and cleans up other subarchitectures.
>>>
>>> Then a small modification is done to core mm to allow
>>> powerpc to still provide its own arch_randomize_brk()
>>>
>>> Last part converts to default topdown mmap layout.
>>
>> A nice series but will clash badly with the CONFIG_HASH_MMU
>> series of course. One will have to be rebased if they are
>> both to be merged.
>>
> 
> No worry, it should be an issue.
> 
> If you already forsee that series being merged soon, I can rebase my 
> series on top of it just now.
> 

In patchwork, v3 is flagged as superseded and I can't find a v4. Do you 
have it somewhere ?

Christophe
