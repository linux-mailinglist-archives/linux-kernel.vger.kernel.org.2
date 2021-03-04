Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2539832CDA2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 08:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhCDHdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 02:33:50 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:12250 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230045AbhCDHdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 02:33:42 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DrjJW42bKz9v1CH;
        Thu,  4 Mar 2021 08:32:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Ad7PxQ5yUtUO; Thu,  4 Mar 2021 08:32:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DrjJW2W77z9v1DM;
        Thu,  4 Mar 2021 08:32:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C69468B773;
        Thu,  4 Mar 2021 08:33:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iw7dwOrwWfIZ; Thu,  4 Mar 2021 08:33:00 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1D9388B7F6;
        Thu,  4 Mar 2021 08:33:00 +0100 (CET)
Subject: Re: [PATCH v3] powerpc/uprobes: Validation for prefixed instruction
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au
Cc:     jniethe5@gmail.com, oleg@redhat.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, paulus@samba.org,
        sandipan@linux.ibm.com, naveen.n.rao@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
References: <20210304050529.59391-1-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <ac7aa126-59dd-31be-1084-6d3a2f0e4eb4@csgroup.eu>
Date:   Thu, 4 Mar 2021 08:32:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304050529.59391-1-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 04/03/2021 à 06:05, Ravi Bangoria a écrit :
> As per ISA 3.1, prefixed instruction should not cross 64-byte
> boundary. So don't allow Uprobe on such prefixed instruction.
> 
> There are two ways probed instruction is changed in mapped pages.
> First, when Uprobe is activated, it searches for all the relevant
> pages and replace instruction in them. In this case, if that probe
> is on the 64-byte unaligned prefixed instruction, error out
> directly. Second, when Uprobe is already active and user maps a
> relevant page via mmap(), instruction is replaced via mmap() code
> path. But because Uprobe is invalid, entire mmap() operation can
> not be stopped. In this case just print an error and continue.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
> v2: https://lore.kernel.org/r/20210204104703.273429-1-ravi.bangoria@linux.ibm.com
> v2->v3:
>    - Drop restriction for Uprobe on suffix of prefixed instruction.
>      It needs lot of code change including generic code but what
>      we get in return is not worth it.
> 
>   arch/powerpc/kernel/uprobes.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
> index e8a63713e655..c400971ebe70 100644
> --- a/arch/powerpc/kernel/uprobes.c
> +++ b/arch/powerpc/kernel/uprobes.c
> @@ -41,6 +41,14 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
>   	if (addr & 0x03)
>   		return -EINVAL;
>   
> +	if (!IS_ENABLED(CONFIG_PPC64) || !cpu_has_feature(CPU_FTR_ARCH_31))

cpu_has_feature(CPU_FTR_ARCH_31) should return 'false' when CONFIG_PPC64 is not enabled, no need to 
double check.

> +		return 0;
> +
> +	if (ppc_inst_prefixed(auprobe->insn) && (addr & 0x3F) == 0x3C) {

Maybe 3C instead of 4F ? : (addr & 0x3C) == 0x3C

What about

(addr & (SZ_64 - 4)) == SZ_64 - 4 to make it more explicit ?

Or ALIGN(addr, SZ_64) != ALIGN(addr + 8, SZ_64)

> +		pr_info_ratelimited("Cannot register a uprobe on 64 byte unaligned prefixed instruction\n");
> +		return -EINVAL;
> +	}
> +
>   	return 0;
>   }
>   
> 

Christophe
