Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598F9325D68
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 07:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhBZGFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 01:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhBZGFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 01:05:42 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F5AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 22:05:02 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o6so5461982pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 22:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vOwskXf5E/zqFeTb0cZmdbSVwqtehnt9sy6Yhq96cQ8=;
        b=KeVwC8sblLSKIhYnBp9slNvx6FgaKBavbHbbEmG8a3SnEpyPYDDYH8Q2BbrTRUBozQ
         8BB8FGXSsWTumGNQiRzLjtJrioDAjVRSrIAVHXzVPnLxKmH9oTVTa6fg33X2eAPdncGu
         fh6SdsIbCZyeuN/oef0tB9+H60IMjh5IRcAe6q3g9VEG1z5t73JTHxsR56FacPcTjQwy
         wS+7LaZLSD7O0/SYGPSXEBDMHn/V/OomFSmylMHGR+Ax/iJmZh0iYMlyluxH3FjUIxBN
         /tyu5nM6mZMNGx7dKlsGN9lcDa4SAMf4dv8YD5zk9eNMKLCDvTcAvC/IF0oL3IBVY//d
         0LCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vOwskXf5E/zqFeTb0cZmdbSVwqtehnt9sy6Yhq96cQ8=;
        b=MR4IQPzwHAMePLMZp/fCLkKEX+UXojLrWuhDsGRrMlx8YmG5s8Clvk1CdU0pkVGxAT
         QBu/4ifp8jXpb/FyDQ1vUIcuzY0LdvVzaEMxRkaESq8sXVhcpQKw2apse8msLxbA8CND
         +Jw+E1Q3hETyNBaa336yAP0KQadwfYD0+HbzYYRDdQ3CYU9xThAxZEm7EyiBOSuvpnc8
         jrHtET7k2+d5aqqDA3JiRe4nGyxrNE8Dmr/D9cypMeVCZKTXrc6CWEBLhwT3++yAabvq
         mMyiTmDQ/Ti6SEDJCTAI3pLSYE8BdIPv6SG/rLnu1ZxPXmpbSlSwBrvztfYIk09s8wEi
         /x6A==
X-Gm-Message-State: AOAM532MJdnkED6RPv+Jy1GIrqcU91WYzQyy+LID7WHf3/b9D81EDp68
        /5xJx/8Xks1EXJq9Ufby7XBzvqPTBtlqew==
X-Google-Smtp-Source: ABdhPJzSQY963oRrF37F9wn90mTcMZTJJFmg1Jn5Cj/06HB01xOqgwkkDaE4csPrx5EzV3jOde0K9g==
X-Received: by 2002:a17:90a:66cd:: with SMTP id z13mr1762857pjl.171.1614319501028;
        Thu, 25 Feb 2021 22:05:01 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id w202sm8514005pff.198.2021.02.25.22.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 22:05:00 -0800 (PST)
Subject: Re: [PATCH] extcon: Fix error handling in extcon_dev_register
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210119081055.13207-1-dinghao.liu@zju.edu.cn>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <f2df2547-3e11-7472-de15-645101944bde@gmail.com>
Date:   Fri, 26 Feb 2021 15:04:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119081055.13207-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21. 1. 19. 오후 5:10, Dinghao Liu wrote:
> When devm_kcalloc() fails, we should execute device_unregister()
> to unregister edev->dev from system.
> 
> Fixes: 046050f6e623e ("extcon: Update the prototype of extcon_register_notifier() with enum extcon")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>   drivers/extcon/extcon.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 0a6438cbb3f3..e7a9561a826d 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1241,6 +1241,7 @@ int extcon_dev_register(struct extcon_dev *edev)
>   				sizeof(*edev->nh), GFP_KERNEL);
>   	if (!edev->nh) {
>   		ret = -ENOMEM;
> +		device_unregister(&edev->dev);
>   		goto err_dev;
>   	}
>   
> 

Thanks for fixup. Applied it.

Thanks,
Chanwoo Choi
