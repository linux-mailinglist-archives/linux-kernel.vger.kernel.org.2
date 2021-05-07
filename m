Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1C63766DF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237519AbhEGOMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 10:12:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:40338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230251AbhEGOMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 10:12:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08408B16D;
        Fri,  7 May 2021 14:11:14 +0000 (UTC)
Date:   Fri, 7 May 2021 16:11:03 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/perf: Simplify Makefile
Message-ID: <20210507141103.GA12700@kitsune.suse.cz>
References: <d37f61afca55b5b33787b643890e061ae1c18f5f.1620396045.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d37f61afca55b5b33787b643890e061ae1c18f5f.1620396045.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 02:01:09PM +0000, Christophe Leroy wrote:
> arch/powerpc/Kbuild decend into arch/powerpc/perf/ only when
> CONFIG_PERF_EVENTS is selected, so there is not need to take
> CONFIG_PERF_EVENTS into account in arch/powerpc/perf/Makefile.

So long as CONFIG_PERF_EVENTS stays boolean.
If it were tristate the result is less clear.

Reviewed-by: Michal Suchánek <msuchanek@suse.de>

Thanks

Michal
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/perf/Makefile | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
> index c02854dea2b2..2f46e31c7612 100644
> --- a/arch/powerpc/perf/Makefile
> +++ b/arch/powerpc/perf/Makefile
> @@ -1,9 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -obj-$(CONFIG_PERF_EVENTS)	+= callchain.o callchain_$(BITS).o perf_regs.o
> -ifdef CONFIG_COMPAT
> -obj-$(CONFIG_PERF_EVENTS)	+= callchain_32.o
> -endif
> +obj-y				+= callchain.o callchain_$(BITS).o perf_regs.o
> +obj-$(CONFIG_COMPAT)		+= callchain_32.o
>  
>  obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o bhrb.o
>  obj64-$(CONFIG_PPC_PERF_CTRS)	+= ppc970-pmu.o power5-pmu.o \
> -- 
> 2.25.0
> 
