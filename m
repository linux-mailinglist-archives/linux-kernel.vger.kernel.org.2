Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CB537FFE1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 23:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhEMVpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 17:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbhEMVpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 17:45:38 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251C9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 14:44:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t11so1421653pjm.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 14:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ChUZno286ejO4yEFxhnpuo5WufJYwvQ/Qfi7oVlBimM=;
        b=PloDhPaIP6fjxoj3XhX1E9uup5Xhp+ASrfiRB7JyYkg7qSZiWp61Tf3vMKSXP0VTQb
         RlbxZ/OvajHiOqfGl3r4RNYXrTUb6dQ9t93EznbesEtZOODRhto54EpxRzRo5bsrYToD
         sRgFI0NFQi9FLq81bINsiY4oZ7IVXr/j2xpHi7gwAzbBPUennBCOMWhxXBXtzCzsFkgC
         Ex+M9O7hflwNpZuHLKH64IUJH7CbZLIyHGkjtOSSQF9O1W+ZEMIC7BHVZjott/030pfk
         nR+dyEvFdtqwnMhfR/5U11nbKABXu4HpMc33OCjdrx25aSIbxMWAT3J0Ls7BiNXJGh7Y
         XtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ChUZno286ejO4yEFxhnpuo5WufJYwvQ/Qfi7oVlBimM=;
        b=CiTIxjUPSs/4apClOZ2Faalu7nE8A58wwN5R0Ji0YzI/jzAnpwNy5fuwqJC1lnbPwS
         +l4VGeU6rRnJuZxHKEak8ebUuEFDjmNU2URFaH/BID5GMe5Eu9lysB0c2UMCzR8x5ABN
         /cfMMtFP3+wI0j7AObtxSe676KXnUvA8Bag+56+plLz6sEq7j8UxTMOCYf2qjsmiqnO7
         z06UNUeswCA51R1nt/XZZ+wyTG5UopcwjozYUmNkgZ9SpN+KfBzyQc2cVYoNXiSf8cnH
         kHfZ1FGFqGo63fJxFuJ53ALqluMM7ebuZOgYjlQF16Ey3pgiHjI3PwNFksfon17riK5h
         ljSQ==
X-Gm-Message-State: AOAM533FbDcp3W5w55jixhljYBPvnpBWNRkodvoQvJY3/asgxv9yA10u
        Hhrpr+7mUwzdaZ6Lm7iYaJQ=
X-Google-Smtp-Source: ABdhPJxuIb7ZEkNEva5FXbtxq6tv9BGhfyVNI9T0wl05vyin6sQQIv4PrB9pwXIZXlogXypNWGzPcQ==
X-Received: by 2002:a17:90a:8911:: with SMTP id u17mr48528788pjn.165.1620942267633;
        Thu, 13 May 2021 14:44:27 -0700 (PDT)
Received: from localhost (g1.222-224-229.ppp.wakwak.ne.jp. [222.224.229.1])
        by smtp.gmail.com with ESMTPSA id h4sm8565608pjc.12.2021.05.13.14.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 14:44:26 -0700 (PDT)
Date:   Fri, 14 May 2021 06:44:25 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        boqun.feng@gmail.com, peterz@infradead.org, aou@eecs.berkeley.edu,
        arnd@arndb.de, bcain@codeaurora.org, benh@kernel.crashing.org,
        chris@zankel.net, dalias@libc.org, davem@davemloft.net,
        deanbo422@gmail.com, deller@gmx.de, geert@linux-m68k.org,
        green.hu@gmail.com, guoren@kernel.org, ink@jurassic.park.msu.ru,
        James.Bottomley@hansenpartnership.com, jcmvbkbc@gmail.com,
        jonas@southpole.se, ley.foon.tan@intel.com, linux@armlinux.org.uk,
        mattst88@gmail.com, monstr@monstr.eu, mpe@ellerman.id.au,
        nickhu@andestech.com, palmer@dabbelt.com, paulus@samba.org,
        paul.walmsley@sifive.com, rth@twiddle.net,
        stefan.kristiansson@saunalahti.fi, tsbogend@alpha.franken.de,
        vgupta@synopsys.com, ysato@users.sourceforge.jp
Subject: Re: [PATCH 05/33] locking/atomic: openrisc: avoid
 asm-generic/atomic.h
Message-ID: <YJ2dud8alZgKmiQ3@antec>
References: <20210510093753.40683-1-mark.rutland@arm.com>
 <20210510093753.40683-6-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510093753.40683-6-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 10:37:25AM +0100, Mark Rutland wrote:
> OpenRISC is the only architecture which uses asm-generic/atomic.h and
> also provides its own implementation of some functions, requiring
> ifdeferry in the asm-generic header. As OpenRISC provides the vast
> majority of functions itself, it would be simpler overall if it also
> provided the few functions it cribs from asm-generic.
> 
> This patch decouples OpenRISC from asm-generic/atomic.h. Subsequent
> patches will simplify the asm-generic implementation.

This is fine, but just a thought.  If OpenRISC is the only architecture to do
this then after this patch could we remove the ifndefs from
asm-generic/atomic.h as additional cleanup?

> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/openrisc/include/asm/atomic.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/openrisc/include/asm/atomic.h b/arch/openrisc/include/asm/atomic.h
> index b589fac39b92..cb86970d3859 100644
> --- a/arch/openrisc/include/asm/atomic.h
> +++ b/arch/openrisc/include/asm/atomic.h
> @@ -121,6 +121,12 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
>  }
>  #define atomic_fetch_add_unless	atomic_fetch_add_unless
>  
> -#include <asm-generic/atomic.h>
> +#define atomic_read(v)			READ_ONCE((v)->counter)
> +#define atomic_set(v,i)			WRITE_ONCE((v)->counter, (i))
> +
> +#include <asm/cmpxchg.h>
> +
> +#define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
> +#define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))

Acked-by: Stafford Horne <shorne@gmail.com>

>  #endif /* __ASM_OPENRISC_ATOMIC_H */
> -- 
> 2.11.0
> 
