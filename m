Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C171403BFC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351797AbhIHO75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 10:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbhIHO74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:59:56 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C9AC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 07:58:48 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id j12so4007073ljg.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 07:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7ctzyqeUORnBgzeTvVfI+qTP2OEJKYVtguuxCX7NuxM=;
        b=zFA0ZaBgmO5LxN1vr2QeBoXbpnRWzRS0LHNbEmhSdjv4YQmk8kdw7UioMtotKRf9RP
         Y7lTMX7xmKkcvYRKt6xW9JeAjFHC0+VgNR3FjdWQs8QT7CxVpticq1ts+ZkIKv6wHYxj
         8O9hfsakmeTwu20Lhu883yh2hFmfbI30eEpyJGkkL06J/Dv9Xg9AmNP/GyZf2nmgjnSi
         wlmusu2SUFJTsosf9oGy7szL6oCIgYivENkT8UzxUD33T6oPU+6hHF3mVlKRE9KkeuYi
         N0yfNwEeCsciTZaHQ6DWGsYSo84lyV7USAi+2enL1SlyJmlybf3dTXQzJeiQ4c2ndGMa
         PD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ctzyqeUORnBgzeTvVfI+qTP2OEJKYVtguuxCX7NuxM=;
        b=rfj3ivJjR+lkkQcSBbLR612xLEaEqm8rctmEAIqa2fuPcmpDJnHXZ4AXickNS0l6BA
         QOF/LVJ8krrThqwc+auehrStzO7ssbcq2tdLp4JNtnmrVl0rKtQPm0XexlWD5uS1oXt0
         HFZ3nH70EcpyXn+giqjbRY54kIvdIGjcebEJ9w7VkGGFAlIEajU6OUKWt7hKDk6J1nwF
         9gC5ndkNKVwTskqi1zv5bVAWFBboZuAwwcS6Hhh9iQ5gZ/WiC6zRlV6wZjrgJlpABmwi
         3BPqaePICQyZEyhPyp+5MhJH1hOiJWUcMdIlB/74cRJllFxqKwNNugRZ5UHO3JzFI87H
         GP2A==
X-Gm-Message-State: AOAM530I62OxoEn8RU0iIc0aNua+XkqXi3ygEvUje0uIdsv5NZIyuavK
        gvSTy6NoL3oeq5sGfz4bhEK/kaz8+hMoCg==
X-Google-Smtp-Source: ABdhPJyTH3Ocl2mWgKQz+uDdKdKdPGDlx7IKI6iwhxK2uCiTqm0MmvrkHlwK0IL46lI19PhlSIadsA==
X-Received: by 2002:a2e:b8d2:: with SMTP id s18mr3085498ljp.529.1631113126303;
        Wed, 08 Sep 2021 07:58:46 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n25sm212456lfe.125.2021.09.08.07.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 07:58:45 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7BD21102F38; Wed,  8 Sep 2021 17:58:44 +0300 (+03)
Date:   Wed, 8 Sep 2021 17:58:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Liu Yuntao <liuyuntao10@huawei.com>
Cc:     hughd@google.com, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wuxu.wu@huawei.com,
        liusirui@huawei.com, windspectator@gmail.com
Subject: Re: [PATCH] fix judgment error in shmem_is_huge()
Message-ID: <20210908145844.wqkyfuizqaj5mmrj@box>
References: <20210908102648.2326917-1-liuyuntao10@huawei.com>
 <20210908102648.2326917-2-liuyuntao10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908102648.2326917-2-liuyuntao10@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 06:26:48PM +0800, Liu Yuntao wrote:
> In the case of SHMEM_HUGE_WITHIN_SIZE, the page index is not rounded
> up correctly. When the page index points to the first page in a huge
> page, round_up() cannot bring it to the end of the huge page, but
> to the end of the previous one.
> 
> an example:
> HPAGE_PMD_NR on my machine is 512(2 MB huge page size).
> After allcoating a 3000 KB buffer, I access it at location 2050 KB.
> In shmem_is_huge(), the corresponding index happens to be 512.
> After rounded up by HPAGE_PMD_NR, it will still be 512 which is
> smaller than i_size, and shmem_is_huge() will return true.
> As a result, my buffer takes an additional huge page, and that
> shouldn't happen when shmem_enabled is set to within_size.
> 
> Fixes: f3f0e1d2150b2b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> Signed-off-by: Liu Yuntao <liuyuntao10@huawei.com>
> ---
>  mm/shmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 88742953532c..5747572859d1 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -490,7 +490,7 @@ bool shmem_is_huge(struct vm_area_struct *vma,
>  	case SHMEM_HUGE_ALWAYS:
>  		return true;
>  	case SHMEM_HUGE_WITHIN_SIZE:
> -		index = round_up(index, HPAGE_PMD_NR);
> +		index = round_up(index + 1, HPAGE_PMD_NR);
>  		i_size = round_up(i_size_read(inode), PAGE_SIZE);
>  		if (i_size >= HPAGE_PMD_SIZE && (i_size >> PAGE_SHIFT) >= index)

With the change, the condition can be simplified to

		if (i_size >> PAGE_SHIFT >= index)

right?

>  			return true;
> -- 
> 2.23.0
> 

-- 
 Kirill A. Shutemov
