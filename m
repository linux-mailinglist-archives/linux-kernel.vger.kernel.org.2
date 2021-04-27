Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AFA36CD5E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 22:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbhD0U60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 16:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbhD0U6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 16:58:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC8AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 13:57:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g10so3656814edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 13:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5mcuDXZg50oHuBsNQdQxM5CN9VGwiDIz4IEF7rEKvL4=;
        b=LwiSk0gcQuTgh0shmC1wawB6cPEsfHSoPh9yM/jbcsDjoMB7x29BSL6Hs+5Kbue6uZ
         reHQ7lyfMO3rdelk1z9jevpglP1I1GCM5RFdQXVq1yn2uNf5VMbKMK9upmijcbTFaA8+
         sPZ4Fu5XcJCE4M4wjpky2fuVz7gjU0VGgtfE4ozoiJv8QGxxvWWnK9tun1BFAznA3r4k
         3xTxut6vgkRSEc9Iocgte4Y0wpEU/Cazo3aRSi1UBRlgpHGypibF5QYTZh0L+Ri+dfFM
         33OK6Ci37IL8SLUPA+lQvjNd36ohl+dMF/F67oX5s1vpn/WrR8cDE2XSlwqGst8HrYLG
         YwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5mcuDXZg50oHuBsNQdQxM5CN9VGwiDIz4IEF7rEKvL4=;
        b=L+KX9a5xsaV5b8XXweyCqiy2ud8OZdeUDkXDtYyAlnH8G5n6Lmtl0Fwcq8WP7DPRLa
         Ej9VHXNAtp76cGTOz01jzO2hw2z3mkSdEPPUEsIi7qodXjxxcFb4k/pJNSgvzF0XJoF4
         LasSSsicNXhEhsUbxqUcvJrFH1yP1tE05JR7Ws4GjBy2i1NZXsl83rDfyIK8ulFD9w0T
         5I9mU2JnoCCnk8EXv/e4VXESHxaOf1/dwJFPxAVSewCize3iVopG8pa7uNtXNOEMN6pv
         C7g1VoQJHuIfTrP7vvj/DE8iU5EcjMautKiPyWyZLHOX2+ac7HA/MxS9X/Oz+7+XvWof
         BhAA==
X-Gm-Message-State: AOAM531rv5ccmEP69Ut0lKchyg5pK+n30cc7fUpU0B53pJTVYHHiB+oT
        avVTgIcbzPguFCoTibcuTgdRJjyNYP/h6Y8UCZQ=
X-Google-Smtp-Source: ABdhPJwoqgdpHEb6Ku8QnZR6UAedR1QS5GfyNbMw4h6sPbSV4b2heZyqiGZUEsc0tnF7zmHyF0QrpUxkK3x0othw1fM=
X-Received: by 2002:a05:6402:1907:: with SMTP id e7mr6677629edz.313.1619557059450;
 Tue, 27 Apr 2021 13:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210427133214.2270207-1-linmiaohe@huawei.com> <20210427133214.2270207-2-linmiaohe@huawei.com>
In-Reply-To: <20210427133214.2270207-2-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 27 Apr 2021 13:57:27 -0700
Message-ID: <CAHbLzkoPA475tiopHwDxcJGoRRCk6O3++7i30r3Ozh6uLDeR5w@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm/huge_memory.c: remove dedicated macro HPAGE_CACHE_INDEX_MASK
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        william.kucharski@oracle.com, Matthew Wilcox <willy@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        aneesh.kumar@linux.ibm.com, Ralph Campbell <rcampbell@nvidia.com>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 6:32 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Rewrite the pgoff checking logic to remove macro HPAGE_CACHE_INDEX_MASK
> which is only used here to simplify the code.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/huge_mm.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 9626fda5efce..0a526f211fec 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -152,15 +152,13 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>
>  bool transparent_hugepage_enabled(struct vm_area_struct *vma);
>
> -#define HPAGE_CACHE_INDEX_MASK (HPAGE_PMD_NR - 1)
> -
>  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>                 unsigned long haddr)
>  {
>         /* Don't have to check pgoff for anonymous vma */
>         if (!vma_is_anonymous(vma)) {
> -               if (((vma->vm_start >> PAGE_SHIFT) & HPAGE_CACHE_INDEX_MASK) !=
> -                       (vma->vm_pgoff & HPAGE_CACHE_INDEX_MASK))
> +               if (!IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
> +                               HPAGE_PMD_NR))
>                         return false;
>         }
>
> --
> 2.23.0
>
>
