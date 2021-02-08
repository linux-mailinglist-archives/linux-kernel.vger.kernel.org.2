Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE19313E85
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhBHTI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:08:59 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:15845 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230318AbhBHRsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:48:23 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZD4f5pD4zB09Zg;
        Mon,  8 Feb 2021 18:47:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 98utEWZnOp6Q; Mon,  8 Feb 2021 18:47:30 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZD4f4ktfzB09Zc;
        Mon,  8 Feb 2021 18:47:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F24F8B7B3;
        Mon,  8 Feb 2021 18:47:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7udkGwZC5Tcc; Mon,  8 Feb 2021 18:47:36 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C82888B7B2;
        Mon,  8 Feb 2021 18:47:35 +0100 (CET)
Subject: Re: [PATCH v4 11/23] powerpc/syscall: Rename syscall_64.c into
 syscall.c
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1611585031.git.christophe.leroy@csgroup.eu>
 <ff9dd4accdc897013594768833d54444e4823bf9.1611585031.git.christophe.leroy@csgroup.eu>
 <1611656343.yaxha7r2q4.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <fcf185e1-7c76-aa1c-1773-ac71c191189a@csgroup.eu>
Date:   Mon, 8 Feb 2021 18:47:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1611656343.yaxha7r2q4.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/01/2021 à 11:21, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of January 26, 2021 12:48 am:
>> syscall_64.c will be reused almost as is for PPC32.
>>
>> Rename it syscall.c
> 
> Could you rename it to interrupt.c instead? A system call is an
> interrupt, and the file now also has code to return from other
> interrupts as well, and it matches the new asm/interrupt.h from
> the interrupts series.
> 

Done in v5

Christophe
