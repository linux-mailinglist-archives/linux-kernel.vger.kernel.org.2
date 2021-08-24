Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DADD3F5F21
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbhHXN1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:27:02 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:39237 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237680AbhHXN0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:26:52 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Gv8y61vsKz9sVp;
        Tue, 24 Aug 2021 15:26:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W-FZZ7Hovc6V; Tue, 24 Aug 2021 15:26:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Gv8y60tq4z9sVf;
        Tue, 24 Aug 2021 15:26:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ED4B68B80A;
        Tue, 24 Aug 2021 15:26:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id o_wlUGlayvSR; Tue, 24 Aug 2021 15:26:05 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E91E38B824;
        Tue, 24 Aug 2021 15:26:04 +0200 (CEST)
Subject: Re: [PATCH v2] powerpc/audit: Convert powerpc to
 AUDIT_ARCH_COMPAT_GENERIC
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <dc14509a28a993738b1325211f412be72a4f9b1e.1629701132.git.christophe.leroy@csgroup.eu>
 <877dgbc6vx.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <953a60d7-1004-676d-240e-17ddc3d4942d@csgroup.eu>
Date:   Tue, 24 Aug 2021 15:26:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <877dgbc6vx.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/08/2021 à 15:24, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
>> targets") added generic support for AUDIT but that didn't include
>> support for bi-arch like powerpc.
>>
>> Commit 4b58841149dc ("audit: Add generic compat syscall support")
>> added generic support for bi-arch.
>>
>> Convert powerpc to that bi-arch generic audit support.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>> v2:
>> - Missing 'git add' for arch/powerpc/include/asm/unistd32.h
>> - Finalised commit description
>> ---
>>   arch/powerpc/Kconfig                |  5 +-
>>   arch/powerpc/include/asm/unistd32.h |  7 +++
>>   arch/powerpc/kernel/Makefile        |  3 --
>>   arch/powerpc/kernel/audit.c         | 84 -----------------------------
>>   arch/powerpc/kernel/compat_audit.c  | 44 ---------------
>>   5 files changed, 8 insertions(+), 135 deletions(-)
>>   create mode 100644 arch/powerpc/include/asm/unistd32.h
>>   delete mode 100644 arch/powerpc/kernel/audit.c
>>   delete mode 100644 arch/powerpc/kernel/compat_audit.c
> 
> This looks OK, but I don't know much about audit.
> 
> Can you resend with the audit maintainers on Cc?
> 

Sure.
