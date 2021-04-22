Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DCD367DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbhDVJai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbhDVJah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:30:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF94CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 02:30:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id f11-20020a17090a638bb02901524d3a3d48so638836pjj.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 02:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WAiVfU9pZKNLnj0iPV+xV/3yJrODjw+qUqRtrLT7Odc=;
        b=K/G5gIH2tX122xjHBh6PNpLcYghJ072WSysjKABS1xlNUDPHEtJIuh+4OFz7aQacgg
         V2Xwyu3/pe7Y6HAqq64ttspX8rmbgc9Abh+qVyS0DxBJvFgm4gph+VELvLIA6MkoKHKT
         gJIBLV9D3q4Wm/eH7sbullADHRJhNtQ77MykJtLVVcagxQM5qja+oVPkXil1HvfRcF5/
         4vaNYLAY8t7eNCYJZi60d5DkDFIi955NDPWp95NVUoNsy4CEz0zdozBMxxFCrQOmkjsi
         nuO6iCm98FdimXko4Nn5Vmo7cBBBcdTxzZGa1PwSV+9DgT9xKKxjxjahoOYX+XFKbYTZ
         xNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WAiVfU9pZKNLnj0iPV+xV/3yJrODjw+qUqRtrLT7Odc=;
        b=h/JpMkdj4LgXbWwJ/wL4OqIdQax9FnNUoh3G4/1LpHMZ32X5tzUAUZLh2wHNESS6b+
         6jNbhq1t41vhc1CdJGKIOf6tPgg/qbYjAREnROyh6lhD3n2e2X945k6jZWXdYgPxogSF
         rM+8isxZ78ULRFz99UB8IB67YhXY4CVYRvXid5X49hvdGQ47MZ5UGdiwr9x69bQyjMVc
         4+CsWIrCb7Jbu+dnMLfFQv+rW2kzZrfTPRQJrFq+6yGYyT1PizXaR1Qlxby7PS2Yjo1l
         gvYDCi9FibnEUWOWSMq64lL2k3nhDSoMWoBRKCg48ApQ1S89K2WWUSiMZFV1HV48nKxK
         L68w==
X-Gm-Message-State: AOAM533o5pTIVAG1Hxw8pv7O7qJqiTD+7DJbPv4DuzlVLkUlhZxl8DUM
        /ONBZEsUCOPLQfN7w/CvXV4=
X-Google-Smtp-Source: ABdhPJzQB7yIG4rtpzNAeePr0K+hw2lUJwWy6oJwbOFiBPkmh6oaTNQ9e16Y7j76ODTQyqkCl+d3+A==
X-Received: by 2002:a17:90b:1bd0:: with SMTP id oa16mr2937519pjb.49.1619083801252;
        Thu, 22 Apr 2021 02:30:01 -0700 (PDT)
Received: from [127.0.0.1] ([222.112.70.84])
        by smtp.gmail.com with ESMTPSA id o5sm1771070pgq.58.2021.04.22.02.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 02:30:00 -0700 (PDT)
Subject: Re: [PATCH] x86/mm: Fix copy&paste error in comments
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
References: <20210420053432.4842-1-jojing64@gmail.com>
From:   Ts'o <jojing64@gmail.com>
Message-ID: <82c81cd7-bced-d533-56f3-1d75c9f4593b@gmail.com>
Date:   Thu, 22 Apr 2021 17:29:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210420053432.4842-1-jojing64@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/4/2021 1:34 pm, Cao jin wrote:
> Direct page mapping in bottom-up way will allocate memory from low
> address for page structures in a range, which is the *bottom*,
> not the *end*.
> 
> Signed-off-by: Cao jin <jojing64@gmail.com>
> ---
>   arch/x86/mm/init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index e26f5c5c6565..bc2f871c75f1 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -663,7 +663,7 @@ static void __init memory_map_bottom_up(unsigned long map_start,
>   	/*
>   	 * We start from the bottom (@map_start) and go to the top (@map_end).
>   	 * The memblock_find_in_range() gets us a block of RAM from the
> -	 * end of RAM in [min_pfn_mapped, max_pfn_mapped) used as new pages
> +	 * bottom of RAM in [min_pfn_mapped, max_pfn_mapped) used as new pages
>   	 * for page table.
>   	 */

FYI: There is exactly the same sentence in memory_map_top_down(), looks 
like a copy & paste error to me.

--
Cao jin
