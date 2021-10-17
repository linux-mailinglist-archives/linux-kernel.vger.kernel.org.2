Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C8A430922
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343580AbhJQMuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245744AbhJQMuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:50:23 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD3EC061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 05:48:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i12so35786524wrb.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=me2TIHQV0+mexzAz+QSM8aL7ERExKXxDrQ4Wy7szewk=;
        b=ZC3VhWctorrkUnyZigLBDwV7NrY2xSJIyFY33Ce3Qt1lqOUqb8SwsWG2s33Tf8c6Gk
         Yjxi1rgSu0aRUXYfHrJQnqsDHJedFrkmxYqtb+OYLvX4W40T8VyGx8l3SK4b9a3qsnLe
         RIDxrPnzN6v4cf9ZSIpGknDjVMtItcd1YThD6Kg5+0UpwVoSp8wzfLZo/XjpU7GpEwGw
         06km0E1IE7rzpcjOY293skLrg7SE1F7xDFbL46cM8XDevLWZjt7aXCCPAuSEGSq8urxb
         LCN79dXGPhBp9VMZi2hph1ELm5/6cWGspxsBUFGinn0rQLddSBb7sQXK1qRhGoNxjDH/
         rrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=me2TIHQV0+mexzAz+QSM8aL7ERExKXxDrQ4Wy7szewk=;
        b=frOY3Tq1irus7IUwLjHkaXmkgQ47c0Epn01USpZa92s/e6esprFhIS8u/1l/j+9WSb
         0CTm3w3hI6T5EhM0A5GiwYFnJ5iAWGsIPmwPRBrYkHAFUJizmiKGM+ffob4EOPTdpgZO
         Zz5i5f+sZPjX32M7j8mlstK/EjdX6lxqIWMX1vcwNP7tEoXVmF4MPi5brJJNI7EdghBF
         movYe3VTY3YHOV1YyTqITIrh2aybfx0jFvLLXSIqm10C9/sm0L7vJiD5+MG2lx58HTyi
         KJ+6Ia6LT7N+KsUHEuBzCCyzIGRq8NBVBui99TNmMgynG3A4hXIq6zVQHLsclQOQ9Xgd
         9+uA==
X-Gm-Message-State: AOAM530zvrsr2DtGxE/oNJTkvoj6FfLB+7S/JWYw9PyITgIoXnYkM2fl
        Yx6VTxvNQB6Bnnv4MQ8jedj0sOEJfVU=
X-Google-Smtp-Source: ABdhPJzDrQhfqQlwnp5//tKCEb2Y59T77LZVehz5SmrozGokJMAUocwtCcZgKx1pv7rnbs5CShrZLA==
X-Received: by 2002:a5d:6e07:: with SMTP id h7mr28750509wrz.316.1634474891998;
        Sun, 17 Oct 2021 05:48:11 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::d7f0? ([2a02:8108:96c0:3b88::d7f0])
        by smtp.gmail.com with ESMTPSA id r4sm12454719wrz.58.2021.10.17.05.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 05:48:11 -0700 (PDT)
Message-ID: <7c86d763-930d-ec80-3ad1-f3d056c27291@gmail.com>
Date:   Sun, 17 Oct 2021 14:48:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/3] staging: r8188eu: daemonize is not defined
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211016181343.3686-1-martin@kaiser.cx>
 <20211016181343.3686-3-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211016181343.3686-3-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/21 20:13, Martin Kaiser wrote:
> Remove dead code that depends on daemonize.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/include/osdep_service.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
> index d148137adf39..ee8a64bb3126 100644
> --- a/drivers/staging/r8188eu/include/osdep_service.h
> +++ b/drivers/staging/r8188eu/include/osdep_service.h
> @@ -162,9 +162,6 @@ static inline unsigned char _cancel_timer_ex(struct timer_list *ptimer)
>   
>   static __inline void thread_enter(char *name)
>   {
> -#ifdef daemonize
> -	daemonize("%s", name);
> -#endif
>   	allow_signal(SIGTERM);
>   }
>   
> 

Acked-by: Michael Straube <straube.linux@gmail.com>
