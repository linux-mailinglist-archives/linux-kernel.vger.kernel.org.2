Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3563AAF60
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhFQJP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:15:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:1789 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231390AbhFQJP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:15:57 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G5GZN2HqvzB1V5;
        Thu, 17 Jun 2021 11:13:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fPAq3z6Fi_8g; Thu, 17 Jun 2021 11:13:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G5GZN1H1qz9ss4;
        Thu, 17 Jun 2021 11:13:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F3BB78B807;
        Thu, 17 Jun 2021 11:13:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id w7U1uPE8ElHy; Thu, 17 Jun 2021 11:13:47 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 014858B804;
        Thu, 17 Jun 2021 11:13:46 +0200 (CEST)
Subject: Re: [PATCH v3 00/23] Add generic vdso_base tracking
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20210611180242.711399-1-dima@arista.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c9d24f64-4c34-703f-2223-113076e07b46@csgroup.eu>
Date:   Thu, 17 Jun 2021 11:13:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/06/2021 à 20:02, Dmitry Safonov a écrit :
> v3 Changes:
> - Migrated arch/powerpc to vdso_base
> - Added x86/selftest for unmapped vdso & no landing on fast syscall
> - Review comments from Andy & Christophe (thanks!)
> - Amended s/born process/execed process/ everywhere I noticed
> - Build robot warning on cast from __user pointer
> 
> I've tested it on x86, I would appreciate any help with
> Tested-by on arm/arm64/mips/powerpc/s390/... platforms.

I tried it on powerpc, normal use still works.

What tests can be done exactly ?

We have a selftest in powerpc 
(https://github.com/linuxppc/linux/blob/master/tools/testing/selftests/powerpc/signal/sigreturn_vdso.c) 
but it doesn't work anymore since the split of VDSO into VDSO+VVAR.

Christophe
