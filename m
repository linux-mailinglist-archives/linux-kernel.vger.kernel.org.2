Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2773E87A7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 03:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhHKB2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 21:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhHKB2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 21:28:37 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB0BC061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 18:28:14 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so1451549oth.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 18:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EI4+iDTUxFQwGasNdMOSZonXlfe7O3WRGPJ1aTgYbiA=;
        b=BonCPtNUTrifYKdWnUaMchxI10JeqAzFuvwXxxahhZxDymjdXZWVcj6XaSrJElcpXn
         spFH7YDpOI8WDIkWRXxlubrhQsEhp5tDTqMFhI82vMnG7wf8dvY6EJiWofj+eWhTi/qi
         sudtB+f2uoLsfBB4cTv6sffjoqkShIaSRd+DMJdekcJRRmRZoB/PFbcMClxOHyL9UYf2
         mEPjucsLActzMbBavZtN8cLKJJcokNokCWmVQZUy91xgwQ9JFE8V6gXcaqXhx4GN4UGm
         P4b5rIj2+IrGOI5ZNrnXSA0/xx4accqr25DD4tkg96/A9oAGePmws6FsQFc0F87IokUc
         jh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EI4+iDTUxFQwGasNdMOSZonXlfe7O3WRGPJ1aTgYbiA=;
        b=KWcWnZfzjOaG0e3KAI8SXPot4785DS4gzu5FOReub7PI90CQinwkJyDyHyvqww25nf
         ziOTByK0Im9s86+E24K4c+j8Jz8q6BJIWtgGwOALW9LefEILLb8GHGgmqOanw71gPwuc
         fERA6meHUgDJ1j+4xszf2p/2pq5a+spKCLZZFUfybHbBNbiWDwz7sQZSxnDBSRtt77Ng
         VrQPYieGgPtFT5UnVoIs+lR88aZQePw+6dj808MPjYgMc0hk5GiRcb52tbeCIMy7Nenb
         zOFfB81tc/OxKnKedytwQ9ViMWAFeJnn3d5aXfCdq16+W/2ZBdQ7DPQNeSukObgzYSsC
         wUyQ==
X-Gm-Message-State: AOAM533ZlRsNBNqyuEiVzFt/oCKfHlTkOnIncNOfWXQBWbzMTiL60wt1
        dk+Kp05TaNPhXmZOwPRAWHUw/TLBMCc=
X-Google-Smtp-Source: ABdhPJwXSKFk8opl6Bx5+tWJl/GoJAy9+/Gwqc8q54HKF1DUUU4gyjkpzaBzz4HG88trJ+WZkCe0Ag==
X-Received: by 2002:a9d:588a:: with SMTP id x10mr4485063otg.153.1628645293722;
        Tue, 10 Aug 2021 18:28:13 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id s12sm1792220otk.21.2021.08.10.18.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 18:28:13 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH] staging: r8188eu: os_dep: Hoist vmalloc.h include into
 osdep_service.h
To:     Nathan Chancellor <nathan@kernel.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210811005505.3953122-1-nathan@kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <73f88d2c-7907-8897-4120-edf5fda97704@lwfinger.net>
Date:   Tue, 10 Aug 2021 20:28:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811005505.3953122-1-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 7:55 PM, Nathan Chancellor wrote:
> After commit 71f09c5ae9d2 ("staging: r8188eu: Remove wrapper around
> vfree"), the driver fails to build on Hexagon due to an implicit
> declaration in several different files:
> 
> drivers/staging/r8188eu/core/rtw_mlme.c:129:3: error: implicit
> declaration of function 'vfree'
> [-Werror,-Wimplicit-function-declaration]
>                  vfree(pmlmepriv->free_bss_buf);
>                  ^
> 1 error generated.
> 
> Previously, vfree() was only called in osdep_service.c, which includes
> vmalloc.h for vmalloc() and vfree(). Now, the driver relies on vfree()
> getting implicitly included from another file.
> 
> Hoist the vmalloc.h include from osdep_service.c to osdep_service.h so
> that the driver continues to build fine on all architectures.
> 
> Fixes: 71f09c5ae9d2 ("staging: r8188eu: Remove wrapper around vfree")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   drivers/staging/r8188eu/include/osdep_service.h | 1 +
>   drivers/staging/r8188eu/os_dep/osdep_service.c  | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
> index 7e002009f9a0..0d1419af8274 100644
> --- a/drivers/staging/r8188eu/include/osdep_service.h
> +++ b/drivers/staging/r8188eu/include/osdep_service.h
> @@ -39,6 +39,7 @@
>   #include <linux/interrupt.h>	/*  for struct tasklet_struct */
>   #include <linux/ip.h>
>   #include <linux/kthread.h>
> +#include <linux/vmalloc.h>
>   
>   #include <linux/usb.h>
>   #include <linux/usb/ch9.h>
> diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
> index 910da0f0004a..9ea4e1a7c45f 100644
> --- a/drivers/staging/r8188eu/os_dep/osdep_service.c
> +++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
> @@ -6,7 +6,6 @@
>   #include "../include/osdep_service.h"
>   #include "../include/drv_types.h"
>   #include "../include/recv_osdep.h"
> -#include "../include/linux/vmalloc.h"
>   #include "../include/rtw_ioctl_set.h"
>   
>   /*
> 
> base-commit: ae7471cae00a432d1c9692452b1b9175a8f3c1b3
> 

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

For some reason this header is pulled in on x86_64. What CPU does Hexagon use?

Larry

