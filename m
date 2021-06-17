Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EADE3AA977
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 05:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhFQDWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 23:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhFQDVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 23:21:36 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE16C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 20:19:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h12so2181175plf.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 20:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iFVLECFtJa6z+5iDHjjAb/nMR79VOYEhHHFYpSqArPU=;
        b=PRcjbFuEqv29GCxozJu3+QbfEpJ5FdOemn0LYPjNZyx4iVX1Izsu0nrZObWYR/Tgsp
         eTh7XiBoPup+OC0i2nGEfrPJzrq2Q2ruVNA6PyuZAf0Gzv1GXz9pdGy1sscHCDuUnzqf
         DirDTAN46cc7ZVi8G0TT4uXkOU0Lv825XRaHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iFVLECFtJa6z+5iDHjjAb/nMR79VOYEhHHFYpSqArPU=;
        b=gXDuSgg7VNJAqvnYpBcB277k2YH8NFEar7bMxrUihsSqZbWRP3WXgLkA6TPVGZKjaa
         GmseD4eiX79EAmkTtGfU5Py+jt/whv6sPepxG4BLWMaLrAM5fTbkK01didKnrMFFmJAV
         SB7dnH6OdoAQcgC5SD8SHGWJNK8WPI3ttmnHRe5Nl9uTK23l4j0//OKVP9wSOasaYlQI
         6/sjmqMU/FQ0nWNtCmexTw2Q6ChODnLngKRO0LmLLFEPFoS7DIoP9qZIzf1c4ylEnAJ9
         bt1j1NjVu3hMB9bmHwyhDKmCumFTLCtD3dZAl+Xj0PBJxV8v4DUaf0enN7WmbmxsOrUw
         nUyA==
X-Gm-Message-State: AOAM531HzfmKtzc7LY9sETG6r2FydVKq43+muDeqeFhGy3hv5Ykr1v9M
        qB89cXpBmd3g+GBykrtpATybpA==
X-Google-Smtp-Source: ABdhPJzJpQ6Ff+MbOGqCd7ssMBtr85WA96hcLpiugXps9DG0brQ8k1NQ4+BY4vwIpBY9HbZJpanohw==
X-Received: by 2002:a17:90a:ee85:: with SMTP id i5mr8532501pjz.156.1623899967512;
        Wed, 16 Jun 2021 20:19:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w142sm3590040pff.154.2021.06.16.20.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 20:19:26 -0700 (PDT)
Date:   Wed, 16 Jun 2021 20:19:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pu Lehui <pulehui@huawei.com>
Cc:     anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, zhangjinhao2@huawei.com
Subject: Re: [PATCH -next] pstore/blk: Fix return value check in
 pstore_blk_init()
Message-ID: <202106162019.1766DA0@keescook>
References: <20210617005424.182305-1-pulehui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617005424.182305-1-pulehui@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 08:54:24AM +0800, Pu Lehui wrote:
> Fix the return value check which testing the wrong variable
> in pstore_blk_init().
> 
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  fs/pstore/blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
> index ccfb11ee4d50..d5e22e6209a6 100644
> --- a/fs/pstore/blk.c
> +++ b/fs/pstore/blk.c
> @@ -287,7 +287,7 @@ static int __init pstore_blk_init(void)
>  		struct pstore_device_info *best_effort_dev;
>  
>  		best_effort_dev = kzalloc(sizeof(*best_effort_dev), GFP_KERNEL);
> -		if (!best_effort) {
> +		if (!best_effort_dev) {
>  			ret = -ENOMEM;
>  			goto unlock;
>  		}

Whoops; thanks!

-- 
Kees Cook
