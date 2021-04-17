Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4AC363031
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbhDQNK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 09:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbhDQNI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 09:08:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFD3C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 06:08:29 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f6-20020a17090a6546b029015088cf4a1eso218385pjs.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 06:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ycx1hdJpKp75Jqh1zODIx7B8QWF+7Q+i8IS+TiHaRno=;
        b=gU9m+YXrGMu9goxT7Cn1aTspyvZfC9PsROZJ53n9eByTMU43+WMHzchlCIa75FACI9
         Xl4MEdj1JqzCHq+e6tW7gZ+gzdWYOkTFRx6c5oisSWrQDsufkNHPfOoeyo/TVCnQnXiU
         v96ISYixeTGBgIF/2nJSY7IKG38oBFD3pKGpDyvHwilo5/rU7bYRI6vJOBHJwjAk8W3n
         jEWc9OeLwSOJmjiKn667JCq3Ere0TA26p9OQZye2Xztd/HuYgmNILGukxr3i9+7q5xsl
         9Va/4YgpvYNLFF/szz5LlbnjgzOTf5PV0N3cZlZJvhTcTgQy59nESk1lJe7rpTKEMr5W
         YKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ycx1hdJpKp75Jqh1zODIx7B8QWF+7Q+i8IS+TiHaRno=;
        b=Skx1aVJwqITWAVRgkSwsa8Bepo+iCQ896JfpPRmyFWQa9jSItq6JxkFjE80yuN2iHF
         Z917tO5evENPJjtP5XPmb4nbs37rvo8hON1+YDNDM0spX9Nc0jtHSC8rLbrPIRIvONAe
         pGpKB0XtmsRxToe3NQdj1e/xgRWj+Dziz0KLeiBm4EMLBXWKgqD9y3HkcNYTd2Hi5QlX
         EE40G7tHjEqLtGCrLenbUVXrlVfr7G1mZgRmrI3inZnrJXrHfFjgyJ/ZV6gMjZafKH7J
         +SjfZ8aRaNY2X7/HBx4nom1d6UdGZa43X2Wg992v3xzxj74k/O6r5rWhTe/fy4L2Qbef
         NzDg==
X-Gm-Message-State: AOAM533ZMkIXhMOBd/YINEkWDSfHGyzB+YopLu9VRjTAJFPyT9qJzLBc
        jpQ8SpuzhTGbA+o/65ZICe+16Pb/mguJigt9cXYGBlBuhMRFog==
X-Google-Smtp-Source: ABdhPJwzbhZfJuUQqx9lyTf7c3oWGtxEow4Szero3dyusNLccQFzd4Kkx/KIrD6BXzqq2jQP6WQqJb4QiRWm6Y8NSSw=
X-Received: by 2002:a17:902:d482:b029:ec:9091:d099 with SMTP id
 c2-20020a170902d482b02900ec9091d099mr1847117plg.34.1618664908762; Sat, 17 Apr
 2021 06:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210417104032.5521-1-peter.enderborg@sony.com>
In-Reply-To: <20210417104032.5521-1-peter.enderborg@sony.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 17 Apr 2021 21:07:52 +0800
Message-ID: <CAMZfGtWZwXemox5peP738v2awsHxABcpYeqccPunLCZzRXynBQ@mail.gmail.com>
Subject: Re: [External] [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
To:     Peter Enderborg <peter.enderborg@sony.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mike Rapoport <rppt@kernel.org>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 6:41 PM Peter Enderborg
<peter.enderborg@sony.com> wrote:
>
> This adds a total used dma-buf memory. Details
> can be found in debugfs, however it is not for everyone
> and not always available. dma-buf are indirect allocated by
> userspace. So with this value we can monitor and detect
> userspace applications that have problems.
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  drivers/dma-buf/dma-buf.c | 13 +++++++++++++
>  fs/proc/meminfo.c         |  5 ++++-
>  include/linux/dma-buf.h   |  1 +
>  3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index f264b70c383e..197e5c45dd26 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -37,6 +37,7 @@ struct dma_buf_list {
>  };
>
>  static struct dma_buf_list db_list;
> +static atomic_long_t dma_buf_global_allocated;
>
>  static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
>  {
> @@ -79,6 +80,7 @@ static void dma_buf_release(struct dentry *dentry)
>         if (dmabuf->resv == (struct dma_resv *)&dmabuf[1])
>                 dma_resv_fini(dmabuf->resv);
>
> +       atomic_long_sub(dmabuf->size, &dma_buf_global_allocated);
>         module_put(dmabuf->owner);
>         kfree(dmabuf->name);
>         kfree(dmabuf);
> @@ -586,6 +588,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>         mutex_lock(&db_list.lock);
>         list_add(&dmabuf->list_node, &db_list.head);
>         mutex_unlock(&db_list.lock);
> +       atomic_long_add(dmabuf->size, &dma_buf_global_allocated);
>
>         return dmabuf;
>
> @@ -1346,6 +1349,16 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
>  }
>  EXPORT_SYMBOL_GPL(dma_buf_vunmap);
>
> +/**
> + * dma_buf_allocated_pages - Return the used nr of pages
> + * allocated for dma-buf
> + */
> +long dma_buf_allocated_pages(void)
> +{
> +       return atomic_long_read(&dma_buf_global_allocated) >> PAGE_SHIFT;
> +}
> +EXPORT_SYMBOL_GPL(dma_buf_allocated_pages);

dma_buf_allocated_pages is only called from fs/proc/meminfo.c.
I am confused why it should be exported. If it won't be called
from the driver module, we should not export it.

Thanks.

> +
>  #ifdef CONFIG_DEBUG_FS
>  static int dma_buf_debug_show(struct seq_file *s, void *unused)
>  {
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 6fa761c9cc78..ccc7c40c8db7 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -16,6 +16,7 @@
>  #ifdef CONFIG_CMA
>  #include <linux/cma.h>
>  #endif
> +#include <linux/dma-buf.h>
>  #include <asm/page.h>
>  #include "internal.h"
>
> @@ -145,7 +146,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>         show_val_kb(m, "CmaFree:        ",
>                     global_zone_page_state(NR_FREE_CMA_PAGES));
>  #endif
> -
> +#ifdef CONFIG_DMA_SHARED_BUFFER
> +       show_val_kb(m, "DmaBufTotal:    ", dma_buf_allocated_pages());
> +#endif
>         hugetlb_report_meminfo(m);
>
>         arch_report_meminfo(m);
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index efdc56b9d95f..5b05816bd2cd 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -507,4 +507,5 @@ int dma_buf_mmap(struct dma_buf *, struct vm_area_struct *,
>                  unsigned long);
>  int dma_buf_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
>  void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
> +long dma_buf_allocated_pages(void);
>  #endif /* __DMA_BUF_H__ */
> --
> 2.17.1
>
