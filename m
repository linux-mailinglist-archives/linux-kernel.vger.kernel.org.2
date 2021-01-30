Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B13309891
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 23:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhA3WIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 17:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhA3WIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 17:08:13 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E75C061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 14:07:33 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id s15so7824230plr.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 14:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=/P/b4VQw8CInKf0Exrq1ninzQwAk3br3MdPWZqjCM5w=;
        b=RnuxL8ThemW1uGFiJS+C2acS9C2US8HUzkp5RgN0kj9o1dwU0VOBcuKG6XOtZssWLQ
         I3RQ7n3hildS5pk9uJaw188Ax4uVQNBeA8cN7tDqnZUpSmxvM7CwSBF4gHnCXdSvKOFc
         t+KTIlRo1kTmTIWzbXPph6cQVhQTNtyVtbLmvVi9QVIzzDG+RfDVpGRLjnxerJIByljY
         GUSp20jDiFJNRUVhpibuvr1hc8VY97QRsVChOp0WFifjy4m1Y5gfDsGkVGM3g/ezfmM3
         dSgBjkLJdPbem0ZO+HR1WpA8thVwubtjK0L0ppbyzgLhkYbF5WYkycJ4pj+4oWIJO4F5
         et3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=/P/b4VQw8CInKf0Exrq1ninzQwAk3br3MdPWZqjCM5w=;
        b=eR3dIIaZcCT09O2adYLCnwb44AQ1p7ocM+iVTXPfF3PzuFruUv8QXkGrhth8/G17Xn
         lzJxBdxZ//LjznYuxGcCJv+SlJvP9VNIh8JujHDmNYxTFpfQV4X0f/hoVMtcjkgnLXe+
         Pqj1D0z06qfXOdPcYCPRrt9pBVgtF86k1BigVkbuvO8HGCdL6Bc2vtNErmUHMbKr8wMk
         aEUxwY9AVZTu/yClP+CJN+wQP0BBEqXDfJcJOJL5mGjNpUFDVzQTOP0SP8NFv9B2HWmT
         B/pWqln5y4wRlll41MB4XdwcwK8fhBmH04q4XXdN3pgnxy31Uff10nvOVBbf96N87x7i
         p+lA==
X-Gm-Message-State: AOAM532irNGzTtgwPUT5PTY13fL3AAWHZQu2ysaIs9PoW1YmX+7K5+Ds
        STrqGyHdLyRdE9uxRhFMGN5iUtcm2JsASg==
X-Google-Smtp-Source: ABdhPJzF4+1uWzCoKE7IesB3JWQ/9H0IiQv7PngPRUVmqwH3eeUfxC9UjmOq+5lDB4sP8lod17N5aA==
X-Received: by 2002:a17:90a:9905:: with SMTP id b5mr10339808pjp.195.1612044452393;
        Sat, 30 Jan 2021 14:07:32 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id b14sm12004292pju.14.2021.01.30.14.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 14:07:31 -0800 (PST)
Date:   Sat, 30 Jan 2021 14:07:30 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlbfs: show pagesize in unit of GB if possible
In-Reply-To: <20210130090339.4378-1-linmiaohe@huawei.com>
Message-ID: <f5ac7d57-6653-aae-f119-b87d72acf192@google.com>
References: <20210130090339.4378-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jan 2021, Miaohe Lin wrote:

> Hugepage size in unit of GB is supported. We could show pagesize in unit of
> GB to make it more friendly to read. Also rework the calculation code of
> page size unit to make it more readable.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 3a08fbae3b53..40a9795f250a 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1014,11 +1014,15 @@ static int hugetlbfs_show_options(struct seq_file *m, struct dentry *root)
>  	if (sbinfo->max_inodes != -1)
>  		seq_printf(m, ",nr_inodes=%lu", sbinfo->max_inodes);
>  
> -	hpage_size /= 1024;
> -	mod = 'K';
> -	if (hpage_size >= 1024) {
> -		hpage_size /= 1024;
> +	if (hpage_size >= SZ_1G) {
> +		hpage_size /= SZ_1G;
> +		mod = 'G';
> +	} else if (hpage_size >= SZ_1M) {
> +		hpage_size /= SZ_1M;
>  		mod = 'M';
> +	} else {
> +		hpage_size /= SZ_1K;
> +		mod = 'K';
>  	}
>  	seq_printf(m, ",pagesize=%lu%c", hpage_size, mod);
>  	if (spool) {

NACK, this can break existing userspace parsing.
