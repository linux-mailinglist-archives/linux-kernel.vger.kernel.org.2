Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CB538D96C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 09:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhEWHVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 03:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhEWHVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 03:21:23 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B950C061574;
        Sun, 23 May 2021 00:19:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id s20so13050500plr.13;
        Sun, 23 May 2021 00:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5A5S+RKS0kUf+LqhvtKnvzrJXq02s4KC6DCjB0ObcnU=;
        b=P8WVd6VXguHoXPoUfjgD9Rt1DH3RjXpbtLfzI1EIWNS/2+ch2a4rvp6C6l+f0dBJ3R
         p++VgGOcaOVwSqvAK3+NMj50sM82PMyiSFpDZkmHsCx0+7i6hxaq0TOcm/z1U+ueE596
         9FYqFqpJznJv3exAcRia29sOT3kbn5YjNbfzlTYGbkJBxNBH0UVGQ/hx4BBoszjIpE6N
         k+I8oxD7pJ9SpQm/XqgOdwCW5S8d3UqkRmucohvqh65jCFPuoZVuLL+KlIP6mRYNwBu3
         tbU5zBSqLIhWl9tmEYMP6OI9YpRG4JdtuxElSZTdrxtyymvmUmQ5lJjeMGnKtCgoV0y3
         G+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5A5S+RKS0kUf+LqhvtKnvzrJXq02s4KC6DCjB0ObcnU=;
        b=CVdI30fvzrG17+/XDx/1sHqh9WOq0uO4t+8NsXJeJI92Otv8jWIPcMezhNnYJW0fxy
         DWCv4SdMpCFYo/0GTJDmxy+7QwBxHzdUHsG1oWGpKMMmzcgUfHlgmQMcTyFxIkg6OlKH
         LEQDAlPcrMhu8wBZPrNMnEBXOblUqjHIyC+TtG9QT9zVP2rjwiayYssy0CHa02Yr8iya
         RB0gDXdfUpdz3zUOz7wzZNscNgS8++pBnPvp8GcgfMOS+YD+Pz3V/0m0EhC/m/7d2yPQ
         oWVw9eh07d73jxPchQHrdacvyq3ZB62Ms4Qv+ahr45m6JkQ6aRWqnX+bGBc9H8j9W5yT
         MlaQ==
X-Gm-Message-State: AOAM533FmIAZwx1EDq0Rqm37tfaazFZPfqRTmsIcDb8jv25lw/J0ktXj
        I0bj7DTz6w2FwBpIc4vfVRT7sd3SOMh3Xg==
X-Google-Smtp-Source: ABdhPJwD7iKzJuiQE6Rm5uCsl5JPoT2LkLm1o3VA3UHiDDHPXU5v09uP7zBYzDGiWbYZPT8GdiwtMA==
X-Received: by 2002:a17:90a:e014:: with SMTP id u20mr19019732pjy.200.1621754395599;
        Sun, 23 May 2021 00:19:55 -0700 (PDT)
Received: from [172.28.99.179] ([119.28.155.243])
        by smtp.gmail.com with ESMTPSA id s3sm9026029pgs.62.2021.05.23.00.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 May 2021 00:19:55 -0700 (PDT)
Subject: Re: [PATCH] docs/zh_CN: Add Chinese translations for new contents
To:     Hu Haowen <src.res@email.cn>, alexs@kernel.org, corbet@lwn.net,
        siyanteng@loongson.cn, bobwxc@email.cn, jaixun.yang@flygoat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210522080214.88050-1-src.res@email.cn>
From:   Alex Shi <seakeel@gmail.com>
Message-ID: <07b671fd-af37-8cd4-bc3c-2c0b2b206591@gmail.com>
Date:   Sun, 23 May 2021 15:19:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210522080214.88050-1-src.res@email.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alex Shi <alexs@kernel.org>

On 2021/5/22 下午4:02, Hu Haowen wrote:
> A document updated in commit 1c31f0b67cfa6d4cd41d ("module: add printk
> formats to add module build ID to stacktraces"), hence add Chinese
> translations for it.
> 
> Signed-off-by: Hu Haowen <src.res@email.cn>
> ---
>  .../translations/zh_CN/core-api/printk-formats.rst       | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/translations/zh_CN/core-api/printk-formats.rst b/Documentation/translations/zh_CN/core-api/printk-formats.rst
> index 624a090e6ee5..116abc046bfe 100644
> --- a/Documentation/translations/zh_CN/core-api/printk-formats.rst
> +++ b/Documentation/translations/zh_CN/core-api/printk-formats.rst
> @@ -122,6 +122,15 @@ seq_printf()，而不是printk()）由用户空间进程读取，使用下面描
>  ``B`` 占位符的结果是带有偏移量的符号名，在打印堆栈回溯时应该使用。占位符将考虑编译器优化
>  的影响，当使用尾部调用并使用noreturn GCC属性标记时，可能会发生这种优化。
>  
> +如果占位符是在一个模块之中，可在占位符末尾添加 ``b`` 以在符号名后打印模块名称和可选构建ID。
> +
> +::
> +        %pS     versatile_init+0x0/0x110 [module_name]
> +        %pSb    versatile_init+0x0/0x110 [module_name ed5019fdf5e53be37cb1ba7899292d7e143b259e]
> +        %pSRb   versatile_init+0x9/0x110 [module_name ed5019fdf5e53be37cb1ba7899292d7e143b259e]
> +                (with __builtin_extract_return_addr() translation)
> +        %pBb    prev_fn_of_versatile_init+0x88/0x88 [module_name ed5019fdf5e53be37cb1ba7899292d7e143b259e]
> +
>  来自BPF / tracing追踪的探查指针
>  ----------------------------------
>  
> 
