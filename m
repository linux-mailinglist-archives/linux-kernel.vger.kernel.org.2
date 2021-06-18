Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1383AD203
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 20:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbhFRSWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 14:22:14 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:42513 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhFRSWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 14:22:12 -0400
Received: by mail-io1-f54.google.com with SMTP id v3so2228180ioq.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 11:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xjOKNXx7mcvWVB9xbLB4nqglFfMMl1pNP/S9NAh2kJ4=;
        b=nH+FblCoFrtlskj3POK0Mz30dgNifz2kIsrUu1DvG4GT/qxyAnNFuHrBVawlnjQdz+
         OyDdNocn0/b+A0aS+RUmB/nW8TFDi7fqSDZTgHS8XDgI4s4ag3X5x6GdMQtBBHVSKmlW
         dSZYHWn8soE9nzUBuTdtKOIb+jVTswvSwzMmgw6gKkKoEYkop5uf24ii4n3qR2zkMikp
         aGoXC9nh+XiNlaUNrFAdNlaYkSh3CSJDwt8A6cwkAbNQIBbVDsp0ec/uWlIW1teJubj6
         xC7dGW38GGCwNYAOJco3LCx0Dopawu0f++XzwY25bvLUTAMeBNLMU6ztSxSJQ/Mm+T43
         7pgg==
X-Gm-Message-State: AOAM532v2RZQVgsi/strc42vZgmKBtmmwGXy5rbJ9JusojzeDz+JKp7F
        TCxtLyoIT/GQOQTHxWS0CzBFn/Sx4Z8=
X-Google-Smtp-Source: ABdhPJydgA71BB/n2LEtmsw0Da6q0F7D6SyzH0sA53awOujaw5hdeV6E1TWu3uz7IHTdPsjjra3x3A==
X-Received: by 2002:a6b:e018:: with SMTP id z24mr3292117iog.206.1624040403042;
        Fri, 18 Jun 2021 11:20:03 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id y27sm4849431iox.17.2021.06.18.11.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:20:02 -0700 (PDT)
Date:   Fri, 18 Jun 2021 18:20:01 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] mm/percpu: Fix gfp flag in pcpu_balance_populated
Message-ID: <YMzj0V8CVte/Pynx@google.com>
References: <20210618151436.38217-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618151436.38217-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jun 18, 2021 at 11:14:36PM +0800, Wan Jiabing wrote:
> Fix coccicheck warning:
> 
> ./mm/percpu.c:2045:19-29: ERROR: function pcpu_balance_populated
> called on line 2232 inside lock on line 2228 but uses GFP_KERNEL
> 
> When pcpu_balance_populated() is called in pcpu_balance_workfn(),
> it helds spin_lock but use GFP_KERNEL to alloc mem, which is unsafe.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  mm/percpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index b4cebeca4c0c..4031f32e6975 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2042,7 +2042,7 @@ static void pcpu_balance_free(bool empty_only)
>  static void pcpu_balance_populated(void)
>  {
>  	/* gfp flags passed to underlying allocators */
> -	const gfp_t gfp = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
> +	const gfp_t gfp = GFP_ATOMIC | __GFP_NORETRY | __GFP_NOWARN;
>  	struct pcpu_chunk *chunk;
>  	int slot, nr_to_pop, ret;
>  
> -- 
> 2.30.2
> 

In both places gfp flags are passed, the pcpu_lock is dropped. So I
think this is an issue with coccicheck. Regardless, the fix wouldn't be
to switch to GFP_ATOMIC but to make the locking correct.

Thanks,
Dennis
