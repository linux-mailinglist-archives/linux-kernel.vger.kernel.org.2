Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E443E36F839
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 11:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhD3J5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 05:57:16 -0400
Received: from mail-qv1-f41.google.com ([209.85.219.41]:37592 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhD3J5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 05:57:14 -0400
Received: by mail-qv1-f41.google.com with SMTP id z1so4241967qvo.4;
        Fri, 30 Apr 2021 02:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oRPEHfS+vSYCIONrVawXpCs4yEHxp0IL6Y97k0y3PeI=;
        b=VVVMWjWVQdwWCdB6T5uzYgcLFeXyN3YNdSA++4j6dYNXU/lKb+O7yeztgOL1Dr1h4X
         ALNrVlKQvA/Mh5m9Sqtsje8bvIfs/wTJsR929RBw4pnFPws8u1/U/DaE301tWFiWK9v7
         F9jgBFOoNOMFYX3uUUw5KVCef+9/eb8REyPG3bH/DsPs9fK+YK3SdBVqCDo0SKnOxWvq
         Yz09sC06nHKARNxissS9QN68+DLy9yhz9occ1q9dHaRNDiMwkYOJbN0Gl6zSpLO+q925
         g8Elmb5dzsgzxjPsPWBV6tzASB1/dAInmok0j8jQ9n4Hk5rIdkyYFKq3OUc+dRyY3fdR
         tXDA==
X-Gm-Message-State: AOAM531DkvZIDTQPsrIrGlh2Tt5JVRnoayxdenUPhcQGiIvwxDp23QM0
        MbClK+0kAuVNs/BdwzRr0KeYfXTCJyU=
X-Google-Smtp-Source: ABdhPJzOYGorbPzGAxEiYXUPKFui1fN65UVJpDH6MaQo2iG3DPbut20gFn07dkzrPFAMXvg8WkLJBg==
X-Received: by 2002:ad4:59c7:: with SMTP id el7mr4536296qvb.26.1619776586182;
        Fri, 30 Apr 2021 02:56:26 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id e10sm995465qka.56.2021.04.30.02.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 02:56:24 -0700 (PDT)
Subject: Re: [PATCH] floppy: Remove redundant assignment to nr_sectors
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1619774805-121562-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <691dcf37-a771-26f1-cd6d-ee49226550a3@linux.com>
Date:   Fri, 30 Apr 2021 12:56:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1619774805-121562-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/30/21 12:26 PM, Jiapeng Chong wrote:
> Variable nr_sectors is set to zero but this value is never
> read as it is overwritten later on, hence it is a redundant
> assignment and can be removed.
> 
> Clean up the following clang-analyzer warning:
> 
> drivers/block/floppy.c:2333:2: warning: Value stored to 'nr_sectors' is
> never read [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Looks good, applied.
https://github.com/evdenis/linux-floppy/commit/a2d3f991fb51beb1376fb257a316e9b9e3c99737

I slightly changed the title. I guess this will go with other cleanup patches
to 5.14 release. Jens already merged 5.13 patches to master.

Thanks,
Denis

> ---
>  drivers/block/floppy.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 8a9d222..e96ad5b 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -2330,7 +2330,6 @@ static void rw_interrupt(void)
>  	if (!drive_state[current_drive].first_read_date)
>  		drive_state[current_drive].first_read_date = jiffies;
>  
> -	nr_sectors = 0;
>  	ssize = DIV_ROUND_UP(1 << raw_cmd->cmd[SIZECODE], 4);
>  
>  	if (reply_buffer[ST1] & ST1_EOC)
> 
