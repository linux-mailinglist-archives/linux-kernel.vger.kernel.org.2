Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382F4394C5A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 15:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhE2NuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 09:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhE2NuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 09:50:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49442C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 06:48:32 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x188so5417284pfd.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WzEVVVOFU2I7+S66Q1KlYufG1IO5O8QdDvfcHceNhHU=;
        b=awnqRG/Ay1+3Na89+JwutFPnFTHtypg6wCTQM0kZ8dkfOEy1PiwhZpmCZzZfR/2t4x
         Rvn7h+pkZA1O/jnVUbDbLd8Dg9Wd9vy1VmMkUVuk1AN+7Pg5FbFqWJqjugz9dKq5tiHI
         VZX2BE8jdyrjQMy8Nwe9eS4gyiCSn93RAe5HCmENv5JO/S9CCDaUDb4o+SWabYDf2K3M
         228dh3yka4qfzZzwO8dbEKfsRAZTajljJdX3VcRmh1ZeBRs0Yd4jQsDy7B+hwBktP8wm
         J0XnPTwjyHuNQ8XRiDrhmfVteO9HwKF6LLgCdylcOuprkQmBGfurPrx0FUQpobWszATN
         Z1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WzEVVVOFU2I7+S66Q1KlYufG1IO5O8QdDvfcHceNhHU=;
        b=knEos6xHPqkDYbRS7K1nFntv2M4OpmAjyQaJoujCb4REXLSBFlXDYePw2Ff0DdZzvY
         4Dm3wFZs4XCAGtFL31DEr9xnQfLJlW/Sq7gyoiXhzc5EnFV4KY/IVMaEHEAXnUuYSlK+
         K8utzQTUgWhQTu+d5QOuPU4y8wLx4iU5onjAJIG4PJ1Zai4lJomNjX6937cDoBLptyFT
         mO439uD5/2FL5dM7q+FkjHofUkm4yIhi2NdU3u39BTJh8lQWGUbB+anVJC4kjCzJ4qMj
         wTM/ZLvf5ENG5uIjSfN9/xKCRvk27x+GkF6GbYoIwKHsseO37rzQj2HE6RnQPZ8X4ju7
         4AxA==
X-Gm-Message-State: AOAM531aURosG5JqB6x98cltI1SAk+zAL1x6qAP5SGVs1KhSAN4QUstC
        dAaZVUU+qhu4mTw4aAvqlE0=
X-Google-Smtp-Source: ABdhPJyMzUWT4MXHK/Yh8LMQWmZylBbhPUgOi71zVxF1p8YSvWiXrxoTuw98/XlHh675XmOUB23WLQ==
X-Received: by 2002:a63:1465:: with SMTP id 37mr13893915pgu.113.1622296111506;
        Sat, 29 May 2021 06:48:31 -0700 (PDT)
Received: from localhost (g176.222-224-212.ppp.wakwak.ne.jp. [222.224.212.176])
        by smtp.gmail.com with ESMTPSA id w8sm7375325pgf.81.2021.05.29.06.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 06:48:30 -0700 (PDT)
Date:   Sat, 29 May 2021 22:48:28 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH 10/15] openrisc: convert to setup_initial_init_mm()
Message-ID: <YLJGLIODWC3rmJKG@antec>
References: <20210529105504.180544-1-wangkefeng.wang@huawei.com>
 <20210529105504.180544-11-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210529105504.180544-11-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2021 at 06:54:59PM +0800, Kefeng Wang wrote:
> Use setup_initial_init_mm() helper to simplify code.
> 
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc@lists.librecores.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Looks fine to me.

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/kernel/setup.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index c6f9e7b9f7cb..8ae2da6ac097 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -293,10 +293,7 @@ void __init setup_arch(char **cmdline_p)
>  #endif
>  
>  	/* process 1's initial memory region is the kernel code/data */
> -	init_mm.start_code = (unsigned long)_stext;
> -	init_mm.end_code = (unsigned long)_etext;
> -	init_mm.end_data = (unsigned long)_edata;
> -	init_mm.brk = (unsigned long)_end;
> +	setup_initial_init_mm(_stext, _etext, _edata, _end);
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
>  	if (initrd_start == initrd_end) {
> -- 
> 2.26.2
> 
