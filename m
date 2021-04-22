Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF39368352
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbhDVPa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:30:28 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:12447 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236357AbhDVPa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:30:27 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FR1Z63sbxz9v4h8;
        Thu, 22 Apr 2021 17:29:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PXz2z_EasiGH; Thu, 22 Apr 2021 17:29:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FR1Z630KCz9v4gH;
        Thu, 22 Apr 2021 17:29:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 94CFF8B846;
        Thu, 22 Apr 2021 17:29:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XVqJnCmN8KZl; Thu, 22 Apr 2021 17:29:51 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 01DF98B845;
        Thu, 22 Apr 2021 17:29:50 +0200 (CEST)
Subject: Re: [PATCH 2/2] powerpc: Print esr register when hitting Program
 Interrupt
To:     Xiongwei Song <sxwjean@me.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        ravi.bangoria@linux.ibm.com, mikey@neuling.org,
        aneesh.kumar@linux.ibm.com, 0x7f454c46@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
References: <20210422151022.17868-1-sxwjean@me.com>
 <20210422151022.17868-2-sxwjean@me.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <ac6cf0ae-7565-180e-03b2-5e72f89a823a@csgroup.eu>
Date:   Thu, 22 Apr 2021 17:29:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210422151022.17868-2-sxwjean@me.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22/04/2021 à 17:10, Xiongwei Song a écrit :
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> The esr register has the details of Program Interrupt on BookE/4xx cpus,
> printing its value is helpful.
> 
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>   arch/powerpc/kernel/process.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 5c3830837f3a..664aecf8ee2e 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1459,6 +1459,7 @@ static bool interrupt_detail_printable(int trap)
>   	case INTERRUPT_MACHINE_CHECK:
>   	case INTERRUPT_DATA_STORAGE:
>   	case INTERRUPT_ALIGNMENT:
> +	case INTERRUPT_PROGRAM:

With this, it will also print the DSISR on 8xx/6xx so it will print garbage.

8xx/6xx provide the information in SRR1. If you want to proceed, you have to do the same as in ISI: 
Copy the content of SRR1 into regs->dsisr in the assembly handler in head_book3s_32.S and in the 
instruction TLB error handler in head_8xx.S

>   		return true;
>   	default:
>   		return false;
> 
