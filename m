Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E6E39AD70
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 00:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhFCWJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 18:09:08 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:33606 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhFCWJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 18:09:08 -0400
Received: by mail-ed1-f45.google.com with SMTP id f5so3840417eds.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 15:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u1tlwNvgMK6HDkbzCbRrxIHsT2mloTx7ykpfpBmaMA0=;
        b=nbHY1PV1SLGjG+b/ZqVO2Y+L5GYBOYqCA8RXJRsiWjEUYVCKtFajPZ1nvKxCcDcLf1
         /GTOlyTfe1nDDR8MAKDVYj97GlJ3cQ/T9SyzQlRbD1ulhLfpp46JbkubYXN+vo0ANPpK
         C8uhf5c4bkB7N4AkNIOYUfXJbe6bQIV5TXdwie2vnsvSHXkj8LnrZa545RWWGmSrd1KW
         S593SvG+od8ttC/tp19kfPvurTNlV/3wfpMOkTjw1CwYo8Ha55r2OfTCd8radlQ+9y7I
         FQotCJXeJEGWfSLJvkG/TN/VtRipfPu10vVAg9riVmNhHxzUPSGIXRcSPNKga5FFCxkf
         samw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1tlwNvgMK6HDkbzCbRrxIHsT2mloTx7ykpfpBmaMA0=;
        b=oRdQmxCodPa+ZaV28oYSWAKluh1xzWQiaTzcfhYZnWZ5t0MpYS8vffX1hbCPJOes33
         ZIu5re6EK8qy5xQE+vhIH3UYP6N1V4BRZ/jjootAOYikqGqKO4joCZG5KRHWyEgYtQeh
         A6Sh5dWMKyEtwpa/4oG5o1oeJU0/2wRt0WKliwI5hPk1bii9TZyLhAnXQH5rELd0q2Zc
         DSvNcPnvKOkUcBNr8gJKmN26LPBzk2gcMgNggjm4ASp0M679x/OeuMFimQSqWmgjeYI3
         rz1xSkJS2abNxG5SOOvVTB8MtJzfhDNcE9l0qsKWoRIKuMUd/SHUbxJm/qEX9Xxp/VUu
         IX4w==
X-Gm-Message-State: AOAM5339qKSJAcFBCiz1svoYT/59OdYo8sVHA0TY5mEmL50HWtgYo3o2
        20vQJlv5V56gHA0B9ZB2NZl92fiH5+iAUylZaws=
X-Google-Smtp-Source: ABdhPJy5tcNmtBjOEe53PFEOp8BmQ21C1hdKaX/CIPNuMFm5M8qRylXlT4ZD6fDK2mLZMDof33vts+CxB15fPfyy2XQ=
X-Received: by 2002:a05:6402:42d2:: with SMTP id i18mr1488267edc.168.1622757973907;
 Thu, 03 Jun 2021 15:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils> <alpine.LSU.2.11.2106011409390.2148@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2106011409390.2148@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 3 Jun 2021 15:06:01 -0700
Message-ID: <CAHbLzkp0g5sveHfQoWQAWd6qfFaiNEVfYgFsBf7vOiMQm8uc8Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] mm/thp: fix page_address_in_vma() on file THP tails
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 2:11 PM Hugh Dickins <hughd@google.com> wrote:
>
> From: Jue Wang <juew@google.com>
>
> Anon THP tails were already supported, but memory-failure may need to use
> page_address_in_vma() on file THP tails, which its page->mapping check did
> not permit: fix it.
>
> hughd adds: no current usage is known to hit the issue, but this does fix
> a subtle trap in a general helper: best fixed in stable sooner than later.
>
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Signed-off-by: Jue Wang <juew@google.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/rmap.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 144de54efc1c..e05c300048e6 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -716,11 +716,11 @@ unsigned long page_address_in_vma(struct page *page, struct vm_area_struct *vma)
>                 if (!vma->anon_vma || !page__anon_vma ||
>                     vma->anon_vma->root != page__anon_vma->root)
>                         return -EFAULT;
> -       } else if (page->mapping) {
> -               if (!vma->vm_file || vma->vm_file->f_mapping != page->mapping)
> -                       return -EFAULT;
> -       } else
> +       } else if (!vma->vm_file) {
> +               return -EFAULT;
> +       } else if (vma->vm_file->f_mapping != compound_head(page)->mapping) {
>                 return -EFAULT;
> +       }
>
>         return vma_address(page, vma);
>  }
> --
> 2.32.0.rc0.204.g9fa02ecfa5-goog
>
>
