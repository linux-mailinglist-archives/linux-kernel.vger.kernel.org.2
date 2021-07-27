Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C653D76F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbhG0Nj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhG0Nj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:39:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3094CC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 06:39:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d1so8534123pll.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 06:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0EuAdJ2j3Xy0wD/MXKwZ/PwZTNMmcTB1bfhzXbegpT8=;
        b=OeyAi2UTKTWbVp/qMcrINmfyO/LiUfMC5mKML0fs/Se/Osx2AXIKqsFoml0FtAfvZU
         wXu2X/iGWw/iqftzqKLG9r5kHy4YXAJZEwh2FIJw1FPF20pxUpihuExFJS3XkxJKEJg5
         cIPdejsvCQ1OI1oR0AAcM8cXthGlaeC+ZHA60kPxdItf4zktXNVg8FwQHl9d45gqr6RW
         Trva3LvqGr4yfXLnZy+LhWKmQ6OR/Oykg1QMcJk9Ncwy0kc4XZu0BnpUmRnDjaX4m9Gx
         ONNtIo8lA8GfBiJgpRjloIHldM1SN7Q2JdkUz54XQFS/NT924wl+TzlSOPU4zLtVj6mh
         Ej2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0EuAdJ2j3Xy0wD/MXKwZ/PwZTNMmcTB1bfhzXbegpT8=;
        b=N4HYQeW7CpoK3nkpgqeQYXxri0gZIZziq79bN6EsRkpkLu94Zoolye8NcjWFfF00au
         NCiL6XeYNKDH5/RDJyK3A74ocLteq79S4ExpSZ8zujOfw4zBuI7l+bbrG9VN/X5dD3EX
         +Ck6K/HeAjbSbxLoD5oaSBfmHkbVbgbCBjI0Qa8kCaW4atIJUVRzkeK68mm76Dbewsdj
         N6O/rlmB/ojfNjb5mpp2gE3aJ+CUHZK+kiSCnz0lGLJyI1KGBi1hCyYK71+MoNarzpf1
         XtFruclYpV9KLHiFM202UW3Q5CgDKP4FvId37WiMNVthsWys3Y8ZrvvYDdNnDRgigstx
         1TPQ==
X-Gm-Message-State: AOAM533S+to0qQMj2OFGohTZDol9CgX12MiLLD6sG+eIGhQjlVifbMa3
        F7nYocRhXmcaCn7x5qzLH27Cx3pzXwAyiHXso1bMjw==
X-Google-Smtp-Source: ABdhPJzBfHNbdE8QZCQo1KfFkwCTH8KqVgtlNH0zqRZJ1iKnUGTO5j5NK3RgzPw2/D0tchJpoenEbqHB1cxeOgLzLhQ=
X-Received: by 2002:a17:902:6ac9:b029:12c:3bac:8d78 with SMTP id
 i9-20020a1709026ac9b029012c3bac8d78mr5117123plt.34.1627393195692; Tue, 27 Jul
 2021 06:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com> <20210718043034.76431-4-zhengqi.arch@bytedance.com>
In-Reply-To: <20210718043034.76431-4-zhengqi.arch@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 27 Jul 2021 21:39:17 +0800
Message-ID: <CAMZfGtWjunhRYQNW4u4Rea8N+csKPvzUmKfgUBnWBdJdagjs-g@mail.gmail.com>
Subject: Re: [PATCH 3/7] mm: remove redundant smp_wmb()
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2021 at 12:31 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>
> The smp_wmb() which is in the __pte_alloc() is used to
> ensure all ptes setup is visible before the pte is made
> visible to other CPUs by being put into page tables. We
> only need this when the pte is actually populated, so
> move it to pte_install(). __pte_alloc_kernel(),
> __p4d_alloc(), __pud_alloc() and __pmd_alloc() are similar
> to this case.
>
> We can also defer smp_wmb() to the place where the pmd entry
> is really populated by preallocated pte. There are two kinds
> of user of preallocated pte, one is filemap & finish_fault(),
> another is THP. The former does not need another smp_wmb()
> because the smp_wmb() has been done by pte_install().
> Fortunately, the latter also does not need another smp_wmb()
> because there is already a smp_wmb() before populating the
> new pte when the THP use preallocated pte to split huge pmd.

s/use/uses a/g
s/split huge/split a huge/g

>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
