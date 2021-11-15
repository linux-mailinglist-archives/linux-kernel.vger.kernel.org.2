Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74961451C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355008AbhKPAR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355258AbhKOXkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 18:40:36 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B29C079783
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 14:39:19 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id k1so18311073ilo.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 14:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yUwYNrMRiIW2ymDJW4VJI2eBOXEvnHxjYgLtMFL5dtU=;
        b=Mo/no1eO3vUwMxvosgyzBvyvml0KAnKn/aMS3fSt247ikjoAu4SCRvsIfJlkpuh+9B
         tG//C1fmSb74+p6D17IuHCFggu0q3Qzh+L6Jb5N5Fsj0gGT0MEK5G7Ib+USRXDKR0ed2
         NDX1ksAU2ZxMRsfrBtwXwHJ+/Irzw+yiGRyM3YWngxcstF0+cEw6V50qtli576exi6+2
         zbCjdAXUAXWfIKDZxSepAsTyF0Oa8pGle7gJyIyv5Eq/1Y31zklmfsDdXdqCgXclhRVO
         R9nUxATXHCKISlMsT9vOtnYnPMTEmXJO/wiT6ib2Z9Oqyo7AtyvpuQMy/pHQHoPCrmAE
         qRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUwYNrMRiIW2ymDJW4VJI2eBOXEvnHxjYgLtMFL5dtU=;
        b=oS4gDr19BfvjyPDw6ELqOIARucKfaIzs7dXTE/VVsfcv55XdJBafQ9FFfTlP7BK5x4
         yThE29isXuV56p8aRb7Kc6xuqwGfXGO7lUKuWpFZMsuYv6O6J2+mJYoQZv2zHGUnPGci
         Cckcn5p8Fdx6U0KB32K+DNSlWiLIdAuW0/KggjUuej60IF9UtxBfdtLmVv3RCROBgu/x
         kiw9ZwVbkm0xkzg7QfLq0dWgwWblrZE9CRcHz97BDMn1KuEUxMc91BAbFVWNXFvLtcjO
         3oSVe1t0T9s+948VYZqfd8o9GVVHqcAP/G1mI5OjbRAO30eXJnVrPeTIfkyzAXouBGPR
         Sjxw==
X-Gm-Message-State: AOAM533ZsGpRIalwmsRkeUMHvF0+O6UWkAbYlXNbVGIVq7/l09Gfwnas
        Ir6qsu816uoSqVtjVIEOjlSipOE1PZmepcNBizW4CQ==
X-Google-Smtp-Source: ABdhPJxa2fag4jC2rjJuDGd7c5qYustjXIyKp92upm3FPQdlPFxwFtSLX6D9aLUQpOE0tQ99ZytDTyAFtZtQWiNAhbA=
X-Received: by 2002:a92:6b0b:: with SMTP id g11mr1585697ilc.146.1637015959237;
 Mon, 15 Nov 2021 14:39:19 -0800 (PST)
MIME-Version: 1.0
References: <20211113154412.91134-1-minhquangbui99@gmail.com> <20211115131633.81e1879e36aed4a0290e6f0c@linux-foundation.org>
In-Reply-To: <20211115131633.81e1879e36aed4a0290e6f0c@linux-foundation.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 15 Nov 2021 14:39:08 -0800
Message-ID: <CAHS8izOogXwHAcrvL6HtXFh56EbD+mUJ6cAaq4ADqtQngKEzZQ@mail.gmail.com>
Subject: Re: [PATCH] hugetlb: fix hugetlb cgroup refcounting during mremap
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Bui Quang Minh <minhquangbui99@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 1:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sat, 13 Nov 2021 22:44:10 +0700 Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>
> > When hugetlb_vm_op_open() is called during copy_vma(), we may take the
> > reference to resv_map->css. Later, when clearing the reservation pointer
> > of old_vma after transferring it to new_vma, we forget to drop the
> > reference to resv_map->css. This leads to a reference leak of css.
> >
> > Fixes this by adding a check to drop reservation css  reference in
> > clear_vma_resv_huge_pages()
>
> Thanks.  I added cc:stable to this (550a7d60bd5e35a was merged a year
> ago) and I've queued it for 5.16-rc2, pending suitable reviewer feedback.
>

Thanks,

Reviewed-by: Mina Almasry <almasrymina@google.com>
