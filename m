Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FD237BEC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhELNsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:48:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:42792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231428AbhELNrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:47:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00F8AB1F3;
        Wed, 12 May 2021 13:46:46 +0000 (UTC)
Date:   Wed, 12 May 2021 15:46:39 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] tools/x86: update include of alternative
Message-ID: <YJvcPz1IjGpbZ7BX@zn.tnic>
References: <20210506094335.18281-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506094335.18281-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 05:43:28PM +0800, Wan Jiabing wrote:
> In commit 5e21a3ecad15 ("x86/alternative: Merge include files"),
> arch/x86/include/asm/alternative-asm.h was replaced by
> arch/x86/include/asm/alternative.h. Fix them in tools directory.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  tools/arch/x86/lib/memcpy_64.S | 2 +-
>  tools/arch/x86/lib/memset_64.S | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
> index 1e299ac73c86..1cc9da6e29c7 100644
> --- a/tools/arch/x86/lib/memcpy_64.S
> +++ b/tools/arch/x86/lib/memcpy_64.S
> @@ -4,7 +4,7 @@
>  #include <linux/linkage.h>
>  #include <asm/errno.h>
>  #include <asm/cpufeatures.h>
> -#include <asm/alternative-asm.h>
> +#include <asm/alternative.h>
>  #include <asm/export.h>
>  
>  .pushsection .noinstr.text, "ax"
> diff --git a/tools/arch/x86/lib/memset_64.S b/tools/arch/x86/lib/memset_64.S
> index 0bfd26e4ca9e..9827ae267f96 100644
> --- a/tools/arch/x86/lib/memset_64.S
> +++ b/tools/arch/x86/lib/memset_64.S
> @@ -3,7 +3,7 @@
>  
>  #include <linux/linkage.h>
>  #include <asm/cpufeatures.h>
> -#include <asm/alternative-asm.h>
> +#include <asm/alternative.h>
>  #include <asm/export.h>
>  
>  /*
> -- 

fb24e308b631 ("tools arch: Update arch/x86/lib/mem{cpy,set}_64.S copies used in 'perf bench mem memcpy'")

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
