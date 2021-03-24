Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1092A3483C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbhCXVcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238489AbhCXVbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:31:55 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E39C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:31:54 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s17so487934ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GXCHwCjIojzQra6Ybo8a6ubZkkqtpIUTfy1bdb9pub8=;
        b=lrwPb0OwRuF4bqws2EJVVX5j0uiXIFTIr2bAgHN/bzUHYfymLk2LM7VDU3LXmidK0i
         bXBwWghuY/RV0QdKb7L8MAAwIiU43qvbC2j3VUGxWhINR97vi0mClUWlb0ugOuvrxVhg
         7yuaV32pEYwNNMeqBAWYrcA7z5P3Df43dTILzg41SoOUOsqOlSJfc599iONwRuVBj34Q
         BAMm3RiVw7hYomiB9gt5kUyXp3qNlW4MOKyrfynVuNeC/FrMV0oCSAgbNTNJLB48wzD5
         aU46LmJe7lbhAxidq8v3T7oj1diu1Qh7UcoP0B2Cn96LwMxVq1tnOCja0Vb0D9ILq17d
         6Fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GXCHwCjIojzQra6Ybo8a6ubZkkqtpIUTfy1bdb9pub8=;
        b=MmUAr/cWfxAL1oPLmsJXVsjVBfFLtpDFTi9wLIWvXTqnEE3mbJFP7tFoQ0CY1Kz2Jh
         v/eRFWmivTlJVdiiE0275nVf1zYFzgNm2/RcOdJJxTe8AJQ0PalBswBIgEvZiK8hSJ7s
         Ows1hCuSdYgRQ/rriF07QT1HLQWuddvHsP1ISNgJkXpXy94H5moprZei5+hduIZfJD2N
         ayGDiFmRWoXw1+xvkuN+zv9zS+DpBJH/jcvRltdUo+OcAWTCwjA2XpTZQGc0YMYfxhJ0
         hJyFbntFWoKRjmyYxeHzUkHnIZw5npHUmmste7vyLCcMb2AkMk7lgzK2hKJdf/MVT4Cv
         v1jw==
X-Gm-Message-State: AOAM530TRZAfoSY3FqxKTzTHQugmSbinXKmQfd9FOYsn7Cyb1tRbrwNx
        naWAJfwTEGGLNUlfJXSpnQU=
X-Google-Smtp-Source: ABdhPJzBtOjhGlUc6Vg44/mMvTfBcv1StLpDGOr8ECeh+GUX875JodrX5Ivs3aMrj//h3c23tXyLUw==
X-Received: by 2002:a2e:700a:: with SMTP id l10mr3362086ljc.368.1616621512815;
        Wed, 24 Mar 2021 14:31:52 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru. [109.252.193.60])
        by smtp.googlemail.com with ESMTPSA id u9sm444852ljd.130.2021.03.24.14.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 14:31:52 -0700 (PDT)
Subject: Re: [PATCH v7] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        jhubbard@nvidia.com, willy@infradead.org,
        Colin Ian King <colin.king@canonical.com>
References: <20210324205503.2132082-1-minchan@kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <65840bfd-4471-7c8d-ce71-c4705baf3bfe@gmail.com>
Date:   Thu, 25 Mar 2021 00:31:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324205503.2132082-1-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.03.2021 23:55, Minchan Kim пишет:
> Since CMA is getting used more widely, it's more important to
> keep monitoring CMA statistics for system health since it's
> directly related to user experience.
> 
> This patch introduces sysfs statistics for CMA, in order to provide
> some basic monitoring of the CMA allocator.
> 
>  * the number of CMA page successful allocations
>  * the number of CMA page allocation failures
> 
> These two values allow the user to calcuate the allocation
> failure rate for each CMA area.
> 
> e.g.)
>   /sys/kernel/mm/cma/WIFI/alloc_pages_[success|fail]
>   /sys/kernel/mm/cma/SENSOR/alloc_pages_[success|fail]
>   /sys/kernel/mm/cma/BLUETOOTH/alloc_pages_[success|fail]
> 
> The cma_stat was intentionally allocated by dynamic allocation
> to harmonize with kobject lifetime management.
> https://lore.kernel.org/linux-mm/YCOAmXqt6dZkCQYs@kroah.com/
> 
> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Suggested-by: Dmitry Osipenko <digetx@gmail.com>

The tags are incorrect, I haven't suggested this change.

> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

> Addresses-Coverity: ("Dereference after null check")

There are no dereferences fixed by this patch.

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
...

>  #include <linux/debugfs.h>
> +#include <linux/kobject.h>
> +
> +struct cma_kobject {
> +	struct cma *cma;
> +	struct kobject kobj;

If you'll place the kobj as the first member of the struct, then
container_of will be a no-op.

...
> +#include <linux/cma.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +
> +#include "cma.h"
> +
> +void cma_sysfs_account_success_pages(struct cma *cma, unsigned long nr_pages)
> +{
> +	atomic64_add(nr_pages, &cma->nr_pages_succeeded);
> +}
> +
> +void cma_sysfs_account_fail_pages(struct cma *cma, unsigned long nr_pages)
> +{
> +	atomic64_add(nr_pages, &cma->nr_pages_failed);
> +}
> +
> +#define CMA_ATTR_RO(_name) \
> +	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)

nit: #defines and inlined helpers typically are placed at the top of the
code, after includes.

> +static inline struct cma *cma_from_kobj(struct kobject *kobj)
> +{
> +	struct cma_kobject *cma_kobj = container_of(kobj, struct cma_kobject,
> +						    kobj);
> +	struct cma *cma = cma_kobj->cma;
> +
> +	return cma;

nit: you can write this as:

return container_of(kobj, struct cma_kobject, kobj)->cma;

> +}
> +
> +static ssize_t alloc_pages_success_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> +{
> +	struct cma *cma = cma_from_kobj(kobj);
> +
> +	return sysfs_emit(buf, "%llu\n",
> +			atomic64_read(&cma->nr_pages_succeeded));

nit: Algnment isn't right, should be better to write it as single line, IMO.

...
> +static int __init cma_sysfs_init(void)
> +{
> +	struct kobject *cma_kobj_root;
> +	struct cma_kobject *cma_kobj;
> +	struct cma *cma;
> +	int i, err;
> +
> +	cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
> +	if (!cma_kobj_root)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < cma_area_count; i++) {
> +		cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
> +		if (!cma_kobj) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
> +
> +		cma = &cma_areas[i];
> +		cma->cma_kobj = cma_kobj;
> +		cma_kobj->cma = cma;
> +		err = kobject_init_and_add(&cma_kobj->kobj, &cma_ktype,
> +				cma_kobj_root, "%s", cma->name);

nit: Previousy algnment of the code was better here.

Otherwise this is okay to me:

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
