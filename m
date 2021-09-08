Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652D4403C69
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349584AbhIHPVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhIHPVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:21:36 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20581C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 08:20:29 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso3428697ots.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OZ2P9mw3evJ0P/P4xOie79/DsuG4DubNBUve1ewYQ78=;
        b=iHH0KMk+8RMxSZ9tk2OCzj07ySk6EOxzZLq1IU/f8ptYk4eWvbW5lL1rco4I+WLD6Z
         llGmb0VyUwqJRCQZq6y1AxvYW6i/RqNx96pDOYCHXCro4R6GssOj5m5ELxQTLqfbnul7
         2BhPFjP1yYykUEojCKqtPk2e4VEzwuxytb//SuMxCCfiOdIwkivLdmCJ4PeIra02Woe3
         Z6Hw8YjSgVF371GmFia0IMMAzseDloXzERhqveZSS6AvVH+Jqkn+taLdzFJ5aOVu1ADh
         p1/AUYyXCa6MiVPG6UhcyOpA/5rgeoTlcio4iyKppypq0ji/4ed9l3mWpv8aDw5SaUXz
         x94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OZ2P9mw3evJ0P/P4xOie79/DsuG4DubNBUve1ewYQ78=;
        b=1z6Csbcptogy1izwGdaohKOB5zrFHNJrNxYW/m0gFPNCfxvwnGuAd9LPogU7vMSaWS
         viUHAffNsRB2vyQlk9d4JfNhr15O+qeO3/xXA/mxJtmz9iD9lMOZdtEYMnL6N/FMrd5O
         w88eqy4F8Y5hv5QhGbauuP3TPOQ6hTO8yyvVNTzQJrq5HRmulOX090uimlUrmQfV+s3h
         cHu/bdxnWwXkVmv+bS8xPvnppfMWbzfm5T7ItwoZSdrunoYwsRFs4CWamZTvTP3JZnYM
         51uBrv7UuR/3/LMHU3jnZkrsQXOCditx/ooYPbgeH0se3wckVi0/BQskx1Q11xhb8/aw
         7UwQ==
X-Gm-Message-State: AOAM530n6Rt8hFnfet1yQz3e/J7uuLerTtrdasc1zUHkbDUZbqaAjrs2
        w6SjUMNjUCYimjRlPgwmS7w=
X-Google-Smtp-Source: ABdhPJykU+BnKFSX2H2eEnY5PXaRYHIodrFLISD1QZbpXa9HVxp9M4KhIjMn/qQWqR66X/w4qbACPA==
X-Received: by 2002:a9d:4605:: with SMTP id y5mr3465775ote.171.1631114428478;
        Wed, 08 Sep 2021 08:20:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l3sm489631otd.79.2021.09.08.08.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:20:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 8 Sep 2021 08:20:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greentime Hu <green.hu@gmail.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nds32/setup: remove unused memblock_region variable in
 setup_memory()
Message-ID: <20210908152026.GA389642@roeck-us.net>
References: <20210712125218.28951-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712125218.28951-1-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 03:52:18PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> kernel test robot reports unused variable warning:
> 
> cppcheck possible warnings: (new ones prefixed by >>, may not real
> problems)
> 
> >> arch/nds32/kernel/setup.c:247:26: warning: Unused variable: region
> >> [unusedVariable]
>     struct memblock_region *region;
>                             ^
> 
> Remove the unused variable.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>

This is now fatal.

arch/nds32/kernel/setup.c: In function 'setup_memory':
arch/nds32/kernel/setup.c:247:26: error: unused variable 'region'

Anyone care to apply it ?

Guenter

> ---
>  arch/nds32/kernel/setup.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
> index 41725eaf8bac..b3d34d646652 100644
> --- a/arch/nds32/kernel/setup.c
> +++ b/arch/nds32/kernel/setup.c
> @@ -244,7 +244,6 @@ static void __init setup_memory(void)
>  	unsigned long ram_start_pfn;
>  	unsigned long free_ram_start_pfn;
>  	phys_addr_t memory_start, memory_end;
> -	struct memblock_region *region;
>  
>  	memory_end = memory_start = 0;
>  
> 
> base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
> -- 
> 2.28.0
> 
