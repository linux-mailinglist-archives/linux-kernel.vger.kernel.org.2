Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E2641FBCD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 14:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhJBMkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 08:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhJBMkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 08:40:05 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFD1C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 05:38:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so1095068pjc.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 05:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P6qFBggDbUbYVolP3u2ZDXe489MEX4kV8HKAIWuNb9Q=;
        b=LArsdtKCRVn3qXwzRpX3ns9MPpOkKw/M9whS5PtOH2bbHqfvWy/jGztHzCCU3dsW3V
         u01XXbGa2PqSUN5C8hviQD6OPRrSfReTqtKSqPOSjQV8IxlKbpeHu83OAIu91b5V/mDe
         kT/lXP/r5z0gWnNrKgNS+0KmoQJokQuhHmhRF9uPzHYkf6iRl6N+R9dlFyCpHSFbTnPQ
         oaId6C4BdMuBr1ejJhCFdHJ69iqNJJnmpgwFctdnCaLzMm1Zg8L5wmfrKp9JusJ1p80O
         HgpbR64Zn0TV2dlRiLUdUP65O1psuoljP36ScI8aieptd8dkPxyoVl5E588LZ0gsoiGS
         pGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P6qFBggDbUbYVolP3u2ZDXe489MEX4kV8HKAIWuNb9Q=;
        b=V/BDaus5SIsCdsS6pMq/mXTw64rivWNpjeJ6GA3L81Dnk7lxkw+Jg/Y22Y0b6wbkEE
         45qGsKT9HiuFxCBTCRVWJARkRr5hzh1yFAZN7D/eoc8Arcwwp0LnoDrwnCqynU4YjoLd
         HIkCkl8cQgIBGvllqfGEVBa7wzrEN3VYg1Qbxy1/A6E4u9DZHsRJNY3Sk8O9fLUM9cEa
         XTsdfoXBDMIyRy8CZDm/GZevW3HBlGKgKoC/tePQm6QLXC5bK7fex+lqAGOVAjBFAivG
         AXmmdLpttRtuU9gWS6+YK6bonpbEV+XF9ip7gePtBlBrYvHCEcvk+bnI5x7zWd8KEYlX
         JxZQ==
X-Gm-Message-State: AOAM532pTUQCsvqT7iL+/0OrmvQCZAXLavT0qHHqzABkSwnVbm6KHL48
        hrTYK0GJFOSXx6TgBUCNpT4=
X-Google-Smtp-Source: ABdhPJyzOShZpfenGoc/Ai07w5jAUABN8v2uRvEI7/QpnmEqT5fEhLHFOePYPoe9/4yIJ3zx7CRpew==
X-Received: by 2002:a17:90b:3ec3:: with SMTP id rm3mr17943544pjb.93.1633178299288;
        Sat, 02 Oct 2021 05:38:19 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id on9sm8725333pjb.3.2021.10.02.05.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 05:38:18 -0700 (PDT)
Date:   Sat, 2 Oct 2021 21:38:16 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] openrisc: time: don't mark comment as kernel-doc
Message-ID: <YVhSuFFMnlQm+x+8@antec>
References: <20211001021101.18225-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001021101.18225-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 07:11:01PM -0700, Randy Dunlap wrote:
> Fix a kernel-doc warning by unmarking the comment as being in
> kernel-doc notation.
> 
> Fixes this warning:
> arch/openrisc/kernel/time.c:137: warning: expecting prototype for Clocksource(). Prototype was for openrisc_timer_read() instead
> 
> Fixes: b731fbbd246e ("OpenRISC: Timekeeping")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc@lists.librecores.org
> ---
>  arch/openrisc/kernel/time.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20210930.orig/arch/openrisc/kernel/time.c
> +++ linux-next-20210930/arch/openrisc/kernel/time.c
> @@ -127,7 +127,7 @@ irqreturn_t __irq_entry timer_interrupt(
>  	return IRQ_HANDLED;
>  }
>  
> -/**
> +/*
>   * Clocksource: Based on OpenRISC timer/counter
>   *
>   * This sets up the OpenRISC Tick Timer as a clock source.  The tick timer

Hi Randy,

This looks good to me, thank you.  I am queuing it.

-Stafford
