Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682C434B60A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 11:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhC0KS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 06:18:58 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:40346 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhC0KS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 06:18:26 -0400
Received: by sf.home (Postfix, from userid 1000)
        id 536595A22061; Sat, 27 Mar 2021 10:18:18 +0000 (GMT)
Date:   Sat, 27 Mar 2021 10:18:18 +0000
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] ia64: tools: add generic errno.h definition
Message-ID: <YF8GapSa+3zU3fqM@sf>
References: <20210312075136.2037915-1-slyfox@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312075136.2037915-1-slyfox@gentoo.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 07:51:35AM +0000, Sergei Trofimovich wrote:
> Noticed missing header when build bpfilter helper:
> 
>     CC [U]  net/bpfilter/main.o
>   In file included from /usr/include/linux/errno.h:1,
>                    from /usr/include/bits/errno.h:26,
>                    from /usr/include/errno.h:28,
>                    from net/bpfilter/main.c:4:
>   tools/include/uapi/asm/errno.h:13:10: fatal error:
>     ../../../arch/ia64/include/uapi/asm/errno.h: No such file or directory
>      13 | #include "../../../arch/ia64/include/uapi/asm/errno.h"
>         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> CC: linux-kernel@vger.kernel.org
> CC: netdev@vger.kernel.org
> CC: bpf@vger.kernel.org
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>

Any chance to pick it up?

Thanks!

> ---
>  tools/arch/ia64/include/uapi/asm/errno.h | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/arch/ia64/include/uapi/asm/errno.h
> 
> diff --git a/tools/arch/ia64/include/uapi/asm/errno.h b/tools/arch/ia64/include/uapi/asm/errno.h
> new file mode 100644
> index 000000000000..4c82b503d92f
> --- /dev/null
> +++ b/tools/arch/ia64/include/uapi/asm/errno.h
> @@ -0,0 +1 @@
> +#include <asm-generic/errno.h>
> -- 
> 2.30.2
> 

-- 

  Sergei
