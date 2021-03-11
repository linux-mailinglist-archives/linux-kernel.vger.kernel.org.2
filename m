Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2F9337350
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhCKNBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:01:33 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44]:36588 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbhCKNBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:01:11 -0500
Received: by mail-pj1-f44.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so9040990pjh.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 05:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fkuG5au6qThpVo2vTa3qhvtLmsbYvgjHYrjfL1pZJfw=;
        b=CY9VzVn8CrR6nF/V19rJlQD2TG/L7lSyq2QkBfaAqAWdh5Cv6+FVBe2JLXDxjhQr/L
         AI/oZ3SnrFGO4aqIQNBHFZi2hRC0LdrJQKCde1a+ACjPpHfMkKDydTbHMCfDiaUw3JCf
         VIefM0pCK4hnU8KT2HH7aj9zDptBy++pCpK9WMh8AwUjucPcxcBTSUM/rGGYS13zbgsU
         Ojru5vw7dF4dNpVHCqebmiIzgz2TRMdiWTT9mPoC3WufTZNhwktL/31rWA/TxPAnFB7D
         icOyrpgtrl9Ddf6pU5TEYKvjEMJxsD5SMNT8lrXdySDaCknJXl2Fx21OV7TxoCpOBR1n
         K+Sg==
X-Gm-Message-State: AOAM5308hXUaVCJlEpmzys3OwSKbmAbRyhz5QLa0Lo9Xkhav5QXjna/V
        n6gHlJUTMD1Y4aTt7hE8G0o=
X-Google-Smtp-Source: ABdhPJxO1pDzTHYaB+2LTKfbIUWN5p9cc2ms6j8s1u6L46wZmSejU9F3SUhPgTrS/qeFoCqgMNp/3g==
X-Received: by 2002:a17:902:b08b:b029:e4:deb:69a9 with SMTP id p11-20020a170902b08bb02900e40deb69a9mr7654386plr.35.1615467671014;
        Thu, 11 Mar 2021 05:01:11 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g21sm2309113pjl.28.2021.03.11.05.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 05:01:09 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E54924024E; Thu, 11 Mar 2021 13:01:08 +0000 (UTC)
Date:   Thu, 11 Mar 2021 13:01:08 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/test_kmod: Fix a use after free in
 register_test_dev_kmod
Message-ID: <20210311130108.GS4332@42.do-not-panic.com>
References: <20210311080246.11635-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311080246.11635-1-lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 12:02:46AM -0800, Lv Yunlong wrote:
> In register_test_dev_kmod, it calls free_test_dev_kmod() to free
> test_dev. But free_test_dev_kmod() can't set the original pointer
> test_dev to NULL, because the test_dev was passed by it's value
> not reference.

Did you actually get a crash or something? If so can you supply the
actual log? If this is just an observation and you think this is an
issue, specifying that would help during patch review.

  Luis

> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  lib/test_kmod.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_kmod.c b/lib/test_kmod.c
> index 38c250fbace3..aa8a2a563d7e 100644
> --- a/lib/test_kmod.c
> +++ b/lib/test_kmod.c
> @@ -1124,7 +1124,6 @@ static void free_test_dev_kmod(struct kmod_test_device *test_dev)
>  		free_test_dev_info(test_dev);
>  		kmod_config_free(test_dev);
>  		vfree(test_dev);
> -		test_dev = NULL;
>  	}
>  }
>  
> @@ -1149,6 +1148,7 @@ static struct kmod_test_device *register_test_dev_kmod(void)
>  	if (ret) {
>  		pr_err("could not register misc device: %d\n", ret);
>  		free_test_dev_kmod(test_dev);
> +		test_dev = NULL;
>  		goto out;
>  	}
>  
> -- 
> 2.25.1
> 
> 
