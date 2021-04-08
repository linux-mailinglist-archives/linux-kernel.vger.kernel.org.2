Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC0B357BA1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhDHE6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:58:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:21060 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhDHE6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:58:04 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FG8CN0Vj9zB09ZH;
        Thu,  8 Apr 2021 06:57:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id so05TY0S2tCo; Thu,  8 Apr 2021 06:57:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FG8CM6cxdzB09ZG;
        Thu,  8 Apr 2021 06:57:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AEC0D8B7C0;
        Thu,  8 Apr 2021 06:57:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FszZmx3-x-gr; Thu,  8 Apr 2021 06:57:52 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 212808B75F;
        Thu,  8 Apr 2021 06:57:52 +0200 (CEST)
Subject: Re: [PATCH-next] powerpc/interrupt: Remove duplicate header file
To:     johnny.chenyi@huawei.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        aneesh.kumar@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        yuehaibing@huawei.com, heying24@huawei.com
References: <20210408035644.2417002-1-johnny.chenyi@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c42ebf38-c7ea-68bc-01ca-8352581bc33d@csgroup.eu>
Date:   Thu, 8 Apr 2021 06:57:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408035644.2417002-1-johnny.chenyi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 08/04/2021 à 05:56, johnny.chenyi@huawei.com a écrit :
> From: Chen Yi <johnny.chenyi@huawei.com>
> 
> Delete one of the header files <asm/interrupt.h> that are included
> twice.

Guys, we have been flooded with such tiny patches over the last weeks, some changes being sent 
several times by different people.

That one is included in 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210323062916.295346-1-wanjiabing@vivo.com/

And was already submitted a few hours earlier by someone else: 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/1616464656-59372-1-git-send-email-zhouchuangao@vivo.com/

Could you work all together and cook an overall patch including all duplicate removal from 
arch/powerpc/ files ?

Best way would be I think to file an issue at https://github.com/linuxppc/issues/issues , then you 
do a complete analysis and list in the issue all places to be modified, then once the analysis is 
complete you send a full single patch.

Thanks
Christophe

> 
> Signed-off-by: Chen Yi <johnny.chenyi@huawei.com>
> ---
>   arch/powerpc/kernel/interrupt.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index c4dd4b8f9cfa..f64ace0208b7 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -7,7 +7,6 @@
>   #include <asm/asm-prototypes.h>
>   #include <asm/kup.h>
>   #include <asm/cputime.h>
> -#include <asm/interrupt.h>
>   #include <asm/hw_irq.h>
>   #include <asm/interrupt.h>
>   #include <asm/kprobes.h>
> 
