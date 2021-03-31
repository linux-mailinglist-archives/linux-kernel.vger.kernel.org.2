Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026E93501F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 16:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbhCaOM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:12:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:59031 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235959AbhCaOMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:12:14 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F9Stg5l9Cz9tyxm;
        Wed, 31 Mar 2021 16:12:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1HGotb5q2Doe; Wed, 31 Mar 2021 16:12:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F9Stg4vQFz9v328;
        Wed, 31 Mar 2021 16:12:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C8AE38B828;
        Wed, 31 Mar 2021 16:12:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vMVCrlZfARoR; Wed, 31 Mar 2021 16:12:12 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 363738B80D;
        Wed, 31 Mar 2021 16:12:12 +0200 (CEST)
Subject: Re: [PATCH] powerpc/8xx: Load modules closer to kernel text
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jordan Niethe <jniethe5@gmail.com>
References: <db20abbecb129c49d3c663de67dac6a87501ac0b.1617001615.git.christophe.leroy@csgroup.eu>
 <87czvf788t.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <e50f8127-3a87-92eb-d88a-72aa1557ffe7@csgroup.eu>
Date:   Wed, 31 Mar 2021 16:12:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87czvf788t.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 31/03/2021 à 15:39, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> On the 8xx, TASK_SIZE is 0x80000000. The space between TASK_SIZE and
>> PAGE_OFFSET is not used.
>>
>> Use it to load modules in order to minimise the distance between
>> kernel text and modules and avoid trampolines in modules to access
>> kernel functions or other module functions.
>>
>> Define a 16Mbytes area for modules, that's more than enough.
> 
> 16MB seems kind of small.
> 
> At least on 64-bit we could potentially have hundreds of MBs of modules.
> 

Well, with a 16 MB kernel and 16 MB modules, my board is full :)

Even on the more recent board that has 128 MB, I don't expect more than a few MBs of modules in 
addition to the kernel which is approx 8M.


But ok, I'll do something more generic, though it will conflict with Jordan's series.

Christophe
