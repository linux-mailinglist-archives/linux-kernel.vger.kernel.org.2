Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5245A324544
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 21:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbhBXUd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 15:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbhBXUdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 15:33:23 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E43C061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 12:32:43 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 17so1898885pli.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 12:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=erKUdffAM3F5huUC4FQIYg8RAIvLdOL+DyshS4q8nGY=;
        b=H/+3WVeTU77f/r9XgYsKu6ikAyhaaXZFJ5G7H3yfsURPxDGY+qi0vZ6j/LsqcPcxPs
         FYAbSbt7ryauf3olMsOc9mHWKt3Bk5mAjLPsk4kSIXODu4Y8Vj8XfY+JZNFzdlv5Mc9u
         FOdX/FSdtNbg0Htp65PoH6yaUmGKYCSASxE9BbMHCeR3q3RQl/dCqi3xWodJ4U5i+8eg
         ZKs4YA+YOpvc78mMluLBDUMBUIc6VF6p2h2bg4QHniyHza9ku8IloFNu1LCR9jZLv578
         3RoS9EdlDqRfPTEthop532muh/GQjHYQxF8RJe+yoRYk4tGY4ZH+e8z6YitIGjNmPClb
         52ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=erKUdffAM3F5huUC4FQIYg8RAIvLdOL+DyshS4q8nGY=;
        b=tvQpVX6X0cq4qoQFVE6ABemeae94S0pS1FxdziaTqh4mOE3w87m+RwJC5IHGuwBxYr
         psuBZ/QCVFbIZwV6muDpoiJOrAxG1hufsLcTJ/k2CiPKglomp+Tr0mD3Wdhx2bxRExbA
         M5Gj879v8myJbt3PEJGmnZL+44Y8LPiNxD/VGqYqAOmZZDva21lKg1ev5SY1GzbMVEoF
         t12NtiX1LzLyfS8uDljWHbm9m3pcIQe2TFMlc7fzDuGkrpEpbr4IE5MgaNVSd0QRC34D
         yEFP7o4IyX7bJ3T5BZaYYJb5T4Zt3GS18I2OgM+DxP15h5O0NMFHcWj7AQ0T4kA+15Ps
         K98A==
X-Gm-Message-State: AOAM532uT1R/4mVxXYV7qk5ZUueSPuJ9YQj51SnTul+L3Xr4PHcj0PtN
        VXy8F0tTRPfGVZ8W2xiLnuT68D600iwqUQ==
X-Google-Smtp-Source: ABdhPJwlEM1ksnGB9rn6NHo9aS17OOewNS+m1QpFQK5YQefYAo0qpxD7HQvcQNedMN4ZDsJdiiCluA==
X-Received: by 2002:a17:90a:db90:: with SMTP id h16mr6403792pjv.2.1614198762587;
        Wed, 24 Feb 2021 12:32:42 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id q23sm3776645pfn.213.2021.02.24.12.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 12:32:42 -0800 (PST)
Date:   Wed, 24 Feb 2021 13:32:40 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: pru: Replace DEFINE_SIMPLE_ATTRIBUTE with
 DEFINE_DEBUGFS_ATTRIBUTE
Message-ID: <20210224203240.GA3512860@xps15>
References: <1614154829-42461-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614154829-42461-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 04:20:29PM +0800, Yang Li wrote:
> Fix the following coccicheck warning:
> ./drivers/remoteproc/pru_rproc.c:247:0-23: WARNING:
> pru_rproc_debug_ss_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/remoteproc/pru_rproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index 2667919..04a9d99 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -244,7 +244,7 @@ static int pru_rproc_debug_ss_get(void *data, u64 *val)
>  
>  	return 0;
>  }
> -DEFINE_SIMPLE_ATTRIBUTE(pru_rproc_debug_ss_fops, pru_rproc_debug_ss_get,
> +DEFINE_DEBUGFS_ATTRIBUTE(pru_rproc_debug_ss_fops, pru_rproc_debug_ss_get,
>  			pru_rproc_debug_ss_set, "%llu\n");

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>


>  
>  /*
> -- 
> 1.8.3.1
> 
