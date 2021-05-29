Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7117C394C44
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 14:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhE2Mr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 08:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhE2Mr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 08:47:56 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD46C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 05:46:17 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y15so5313222pfn.13
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 05:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=q2WQb6X7gSDL5fCT6m0PosKh8nct9yQ+snRn6XzZdWo=;
        b=ZWtID4dGN+4PWpIahT59tuqEjJOQ9mzTMM8RVS8nDJ/ffCdKr+3K4UjcevRdOMO3FZ
         aGdKJdrmA/YZNgz01LrkOfqYphzdKgTTVBGouUWx+yzWmVMk34XdSGY3y6WkPvKCwZEy
         b4wxKS1k0Xwdj7RzQHEFeDug8Tj9wTTii2hD6/Yb37/4Yuvdm+xY42JjiIQF9rpSuW/2
         jn2CCKYYtw5Yh+DilXNpEhLgPPwhYNqGQpLaLC5+m0l67NqDirGQaOTHg/bdymQ17W/C
         /evXPcUFXVdCRFw+WTwf9dNFsEiWvIhK1oU+God+RChcDDZt87Fs/WBrUHQa3H95Omm1
         0Y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=q2WQb6X7gSDL5fCT6m0PosKh8nct9yQ+snRn6XzZdWo=;
        b=dnk3wk76NifnXde+w37JW+xVq15y2WnGmVbX7xQBVcug5uuk9LkEFtmC7rUUpPIWU5
         OA8rTTeFn9z0xvAVqvTAzeqLi3sW5u4NbJl621KjwGlm/NAg77fPxbA53zPzXH4gBHi5
         c+A344wVOeFSDwW9jK5Ctyun9aaKYnoXDmNzswtusK7RhzV3TtSMoF/wwGp/FXWTPd+9
         +inTDFX/QcQznOsmeKbPG1CuIVPL0Pg8EtYcxNn5JVIQTmz65a/bDFBeH9mPpVwzi026
         hT+c4B0ADYUKYS8pUSyxrFCTVW5pru8vnTeG7BNlrTKQL+CnyGDbIVFw/S0Hp7AgmvAb
         finQ==
X-Gm-Message-State: AOAM532Tv/E5Nuf/CbFFnbk5qXJCnPtS5uNxIJ2MBDfbLh1nN3h2JnZ3
        vlXDep/NKTWaCFcoQ1KQrxIuDgDo2D3J6A==
X-Google-Smtp-Source: ABdhPJyTISm9ZwCFE3HdXhDPYiT3p2pN/rNjFJtytGsllZgOrJ/eLekfEpFeA7u+E/K+gIEZUYyTmA==
X-Received: by 2002:a65:4689:: with SMTP id h9mr13808278pgr.347.1622292376296;
        Sat, 29 May 2021 05:46:16 -0700 (PDT)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id i5sm1939012pfc.139.2021.05.29.05.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 05:46:15 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 11/15] powerpc: convert to setup_initial_init_mm()
In-Reply-To: <20210529105504.180544-12-wangkefeng.wang@huawei.com>
References: <20210529105504.180544-1-wangkefeng.wang@huawei.com>
 <20210529105504.180544-12-wangkefeng.wang@huawei.com>
Date:   Sat, 29 May 2021 18:16:11 +0530
Message-ID: <87y2bxemi4.fsf@fossix.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kefeng Wang <wangkefeng.wang@huawei.com> writes:

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
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
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

This function definition is not visible for those who have subscribed only to
linuxppc-dev mailing list. I had to do a web-search with the ID. 

Thanks,
Santosh

>  
>  	mm_iommu_init(&init_mm);
>  	irqstack_early_init();
> -- 
> 2.26.2
