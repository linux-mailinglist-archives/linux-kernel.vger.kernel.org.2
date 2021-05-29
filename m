Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2AA394D14
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 18:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhE2QNk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 29 May 2021 12:13:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19813 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229693AbhE2QNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 12:13:39 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Fsmlk146wzBCPP;
        Sat, 29 May 2021 18:12:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9sZhn_teJbZ1; Sat, 29 May 2021 18:12:02 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Fsmlk099zzBCNt;
        Sat, 29 May 2021 18:12:02 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id B06C317A; Sat, 29 May 2021 18:16:30 +0200 (CEST)
Received: from 37.167.209.238 ([37.167.209.238]) by messagerie.c-s.fr (Horde
 Framework) with HTTP; Sat, 29 May 2021 18:16:30 +0200
Date:   Sat, 29 May 2021 18:16:30 +0200
Message-ID: <20210529181630.Horde.rvXKyt8t9f8DiqTVTuSKUw3@messagerie.c-s.fr>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 11/15] powerpc: convert to setup_initial_init_mm()
References: <20210529105504.180544-1-wangkefeng.wang@huawei.com>
 <20210529105504.180544-12-wangkefeng.wang@huawei.com>
In-Reply-To: <20210529105504.180544-12-wangkefeng.wang@huawei.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kefeng Wang <wangkefeng.wang@huawei.com> a écrit :

> Use setup_initial_init_mm() helper to simplify code.
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/powerpc/kernel/setup-common.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kernel/setup-common.c  
> b/arch/powerpc/kernel/setup-common.c
> index 046fe21b5c3b..c046d99efd18 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -928,10 +928,7 @@ void __init setup_arch(char **cmdline_p)
>
>  	klp_init_thread_info(&init_task);
>
> -	init_mm.start_code = (unsigned long)_stext;
> -	init_mm.end_code = (unsigned long) _etext;
> -	init_mm.end_data = (unsigned long) _edata;
> -	init_mm.brk = klimit;
> +	setup_initial_init_mm(_stext, _etext, _edata, _end);

This looks wrong, should be klimit instead of _end IIUC

>
>  	mm_iommu_init(&init_mm);
>  	irqstack_early_init();
> --
> 2.26.2


