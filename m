Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C6344EB66
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhKLQeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbhKLQd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:33:59 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEE6C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:31:07 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id z8so19574027ljz.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=10KMDDU+DaSIDbG4KLnwkKUabZtwZOoBI/YHPLaepm8=;
        b=lYNoIGAzCqLDgiOPcZXWaYhuk/NMieSo8L8NBUujzpvCzpizz14ynUgsIxWJcABFNm
         Cq0aN7F7xjXniy9tNJkGxfAqeNdm0h95Gcs227oq6Voho3VXszHNiDQQnMxEFIymhbs9
         zAChlzCteZjM3TczYklsTCBRn+3oS0q+HCHSpN5DttFGk88SLrxEmH9ZGmOYEQ5QzBs0
         r6SWULmqSbHlM02KHy2gVbLsVL7Bzegy9tkGPnX0RTjbPNelawMPoNOygkXtfEK1qWAa
         gRMSx7cZe70hHKC1TLbq7ivHgpWakRWBp/AdYGxFhptGD17yl+gMNQOgbA5Y8pZegw8Z
         Jt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=10KMDDU+DaSIDbG4KLnwkKUabZtwZOoBI/YHPLaepm8=;
        b=qO+8bbzyGArEh/k/BW5Lqc81R8JIL/DEQPNH9uYfXvh6QegeRQmC4ZoDdxYMYn+tM0
         AC2pQ6CuftG/YIBkEpDq+jn4VrPgdIJO0Vm5dyCuLuHWlsveAy/t81mHgHAU/UwsFlsh
         WxT+leJJYswQabqQHTKjDPT1C7ixk1v5W7OVm/nXJQuOvrJEVrHNAFXKPyUrkb25mMTk
         mkVX+0Is7wg5y64/t9jwZFOabisZ24XiqVUffVZr9L/miTm2WSANiWlO5KKFFKn6iRv6
         cEhmMC5cqbSSgwLusrbEXeQedX5j+xJqwh/cMORGheOxWoQnud6xcVlOnR8a70+tNyxv
         4Wrw==
X-Gm-Message-State: AOAM530J40qep94i2r+SrCY2D5ZkHmKjdP+UJbpEJwEpeZmWIfCMDrUF
        +e/w2JJpWB5InjywOjpm+Ao=
X-Google-Smtp-Source: ABdhPJwvss7U2lYl+ogC+1ZI1w3j7qlIWufbl8KUwKR9aUXGd9w3OK2jiJR1ZGGt8o4ZhFSXp2nmAQ==
X-Received: by 2002:a05:651c:891:: with SMTP id d17mr16605087ljq.199.1636734665752;
        Fri, 12 Nov 2021 08:31:05 -0800 (PST)
Received: from [192.168.1.11] ([94.103.224.112])
        by smtp.gmail.com with ESMTPSA id n3sm600479ljc.92.2021.11.12.08.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 08:31:05 -0800 (PST)
Message-ID: <afe0a4bb-c6fe-8eeb-6077-dde7839537e9@gmail.com>
Date:   Fri, 12 Nov 2021 19:31:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] staging: r8188eu: remove unneeded variable
Content-Language: en-US
To:     cgel.zte@gmail.com, phil@philpotter.co.uk
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        linux@roeck-us.net, martin@kaiser.cx, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211112131830.11418-1-deng.changcheng@zte.com.cn>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211112131830.11418-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/21 16:18, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Fix the following coccicheck review:
> ./drivers/staging/r8188eu/core/rtw_ap.c: 1094: 5-8: Unneeded variable
> 
> Remove unneeded variable used to store return value.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>   drivers/staging/r8188eu/core/rtw_ap.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
> index c78feeb9c862..d103a92ee2f1 100644
> --- a/drivers/staging/r8188eu/core/rtw_ap.c
> +++ b/drivers/staging/r8188eu/core/rtw_ap.c
> @@ -1091,7 +1091,6 @@ u8 ap_free_sta(struct adapter *padapter, struct sta_info *psta,
>   int rtw_sta_flush(struct adapter *padapter)
>   {
>   	struct list_head *phead, *plist;
> -	int ret = 0;


None of the existing callers check the return value of this function. 
Make it void, please.



With regards,
Pavel Skripkin
