Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A1C4016B4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 09:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbhIFHEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 03:04:55 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:33168 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhIFHEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 03:04:54 -0400
Received: from madeliefje.horms.nl (tulip.horms.nl [83.161.246.101])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 8B29025B7C9;
        Mon,  6 Sep 2021 17:03:48 +1000 (AEST)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
        id E618D41AB; Mon,  6 Sep 2021 09:03:46 +0200 (CEST)
Date:   Mon, 6 Sep 2021 09:03:46 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>, Jay Lan <jlan@sgi.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] ia64: Fix #endif comment for reserve_elfcorehdr()
Message-ID: <20210906070346.GB19281@vergenet.net>
References: <cover.1629884459.git.geert+renesas@glider.be>
 <77b4c0648f200cab7e1c2c5171c06763e09362aa.1629884459.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77b4c0648f200cab7e1c2c5171c06763e09362aa.1629884459.git.geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 01:48:27PM +0200, Geert Uytterhoeven wrote:
> The definition of reserve_elfcorehdr() depends on CONFIG_CRASH_DUMP, not
> CONFIG_PROC_VMCORE.
> 
> Fixes: d9a9855d0b06ca6d ("always reserve elfcore header memory in crash kernel")
> Fixes: 17c1f07ed70afa4f ("[IA64] Reserve elfcorehdr memory in CONFIG_CRASH_DUMP")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms@verge.net.au>

> ---
>  arch/ia64/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
> index dd595fbd800651fe..fbd931f1eb270d98 100644
> --- a/arch/ia64/kernel/setup.c
> +++ b/arch/ia64/kernel/setup.c
> @@ -546,7 +546,7 @@ int __init reserve_elfcorehdr(u64 *start, u64 *end)
>  	return 0;
>  }
>  
> -#endif /* CONFIG_PROC_VMCORE */
> +#endif /* CONFIG_CRASH_DUMP */
>  
>  void __init
>  setup_arch (char **cmdline_p)
> -- 
> 2.25.1
> 
