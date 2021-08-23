Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FEC3F46B7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbhHWIhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:37:12 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:50261 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235594AbhHWIhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:37:10 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GtQZM1wZGz9sWx;
        Mon, 23 Aug 2021 10:36:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BvwU9v0iWPKl; Mon, 23 Aug 2021 10:36:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GtQZM0xMwz9sTv;
        Mon, 23 Aug 2021 10:36:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ED3018B78B;
        Mon, 23 Aug 2021 10:36:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4H0dZqJ3An7z; Mon, 23 Aug 2021 10:36:26 +0200 (CEST)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C28AD8B780;
        Mon, 23 Aug 2021 10:36:26 +0200 (CEST)
Subject: Re: [PATCH] powerpc/syscalls: Remove __NR__exit
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <6457eb4f327313323ed1f70e540bbb4ddc9178fa.1629701106.git.christophe.leroy@csgroup.eu>
 <87y28ssgpx.fsf@igel.home>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <ac141039-ace3-c068-41fa-ec5781750114@csgroup.eu>
Date:   Mon, 23 Aug 2021 10:36:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87y28ssgpx.fsf@igel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 23/08/2021 à 10:33, Andreas Schwab a écrit :
> On Aug 23 2021, Christophe Leroy wrote:
> 
>> __NR_exit is nowhere used. On most architectures it was removed by
> 
> ITYM __NR__exit, which is what you are removing.
> 

Indeed.

Michael, can you fix when applying or do you prefer a new patch ?
