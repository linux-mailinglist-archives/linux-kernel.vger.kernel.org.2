Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E95743E52A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 17:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhJ1PdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 11:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhJ1PdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:33:24 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF31CC061745
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 08:30:57 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id x27-20020a9d459b000000b0055303520cc4so9068492ote.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vmF8DHes66y0D6bkeVt45MrAZccysrE4T4j7MJnrwvE=;
        b=Huc2Zrjo6z0iwbYk8DioOG9Pm+zlxXOwfJ8Ss6Rb+VN/ekRe343lZ/Y7CpNBPrlmtx
         +orAU7/1hDglc+1P1b7rSwVO4v6EFqyrtT5HJgGRDZiAZpWIllS8VRuAO0aZ9rzKaE2e
         ZFtblQC7EygW5g9z6y/E37ey3YQMZxmXEczTsACSyV52XOsThaMpvp5D0LCoBztMDArL
         GW0ib2bcC9LEyrfG2/jF8Bo3bw6GJJM+0rKXkoSc9haNYCaXnCKHVRv17ycb9dM8d9zv
         lOoJPAUattmOMJLM3FAYaYyz2jz8dX7b/n6c17HGdz61Wu8qTvUrjJYjGxPc64nSl6fj
         BdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vmF8DHes66y0D6bkeVt45MrAZccysrE4T4j7MJnrwvE=;
        b=TsgiGgf79YD8TWB0f/w/9ULQOYSMIpJSXyLig7PkyICdbREMC4uHfRjYovxzox75Y4
         mfyavzl4FHzrLLzpCEF3YEiPJXE6jREj0cd2g5c6Sq7EDCz6PNLEVqg3iUwWCWSln8vW
         UTqWseAauGA2v0FI5HAM28mhB3EAX7biRJ9zn9enIPTkJCCogxJbKSXajfX2AoPFDXYS
         XcJ24WUAjjJ0Gz3ol19Dx6bJLC5Suf1BMHfV9M6KrLc9k9MMVPshgT7HmzedsG/BfFYk
         4f2qb/eHQHmPXtlZqi/1EQYLI8tSpZdLm2f5GtiJ//L0eDKR1/hWpPXdJFey8rLSdMga
         ZvEg==
X-Gm-Message-State: AOAM532e4nzC9KvpHBS6EjOFjYTLl0al1mkBj+z/WAJz/CY3cG/SvKlq
        fVtJCczmfhj5QpCG+4UIfN9kenpEQYw=
X-Google-Smtp-Source: ABdhPJzMlJQewZEPQvSHMAgBZVi/p465XfAm2EXJiqQ+nqegXW4ycqvBDE4JzQuXrg+GoyKG6zh8bQ==
X-Received: by 2002:a9d:6e0a:: with SMTP id e10mr4025811otr.360.1635435057290;
        Thu, 28 Oct 2021 08:30:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l7sm1036431oog.22.2021.10.28.08.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 08:30:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Oct 2021 08:30:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] delay: Replace kernel.h with the necessary
 inclusions
Message-ID: <20211028153055.GA440866@roeck-us.net>
References: <20211027150324.79827-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027150324.79827-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 06:03:24PM +0300, Andy Shevchenko wrote:
> When kernel.h is used in the headers it adds a lot into dependency hell,
> especially when there are circular dependencies are involved.
> 
> Replace kernel.h inclusion with the list of what is really being used.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

In next-20211028:

Building riscv32:defconfig ... failed
--------------
Error log:
arch/riscv/lib/delay.c: In function '__delay':
arch/riscv/lib/delay.c:77:17: error: implicit declaration of function 'cpu_relax'

Building riscv:defconfig ... failed
--------------
Error log:
arch/riscv/lib/delay.c: In function '__delay':
arch/riscv/lib/delay.c:77:17: error: implicit declaration of function 'cpu_relax'

Building s390:defconfig ... failed
--------------
Error log:
<stdin>:1559:2: warning: #warning syscall futex_waitv not implemented [-Wcpp]
In file included from arch/s390/pci/pci_insn.c:12:
arch/s390/include/asm/facility.h: In function '__stfle':
arch/s390/include/asm/facility.h:98:22: error: implicit declaration of function 'min_t'

bisect to this patch. Probably more, but it is difficult to find out
since -next is too badly broken and has build failures all over the place.

Guenter

> ---
>  include/linux/delay.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/delay.h b/include/linux/delay.h
> index 1d0e2ce6b6d9..8eacf67eb212 100644
> --- a/include/linux/delay.h
> +++ b/include/linux/delay.h
> @@ -19,7 +19,7 @@
>   *   https://lists.openwall.net/linux-kernel/2011/01/09/56
>   */
>  
> -#include <linux/kernel.h>
> +#include <linux/math.h>
>  
>  extern unsigned long loops_per_jiffy;
>  
> -- 
> 2.33.0
> 
