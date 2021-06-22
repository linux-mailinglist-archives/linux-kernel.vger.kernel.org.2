Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A013B0BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhFVRrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 13:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbhFVRrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:47:13 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964D5C061787
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:44:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id df12so22350632edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3XXF94DDFWzdwVcn/7oxDB2/Bw1J6uuLNcT9rS+xq2M=;
        b=MXDbZlU3kteAt+kVzLYvjd/HdK9jiJxTsdScavGGyjiHrMB+Ha7/OSyJam8zpHVISH
         R9/sVFXhHBX1Rk3YnF3lYTNbDvImG6g7JcHgtuyHcSbxQjmLz5VR5cehF23Ly+vem0gU
         SjmddOaTttBluEZ8vfQZ9rPZQjz1nSKcnFhESJ7an4vI3njQnv9BzStoF8c2HAlF0ENo
         dyfBAiWeltvymfT98NHaY/GKRJ4GhrQgaaKjngvwU7Qi/1R3sVToy/zLqmdILNdYZs0B
         0wUibEUBvI472dnfq4vWMFNoR79V/yHEpHlmSq0e3Vup3nLhF9eIYGtgpY7eKgFqGWa/
         OfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3XXF94DDFWzdwVcn/7oxDB2/Bw1J6uuLNcT9rS+xq2M=;
        b=pRdIbQvXenC34Hex/wnArYQKZexm0QiIM2zdN8Yj4Xj1PmddpuYOIxt9FyceY2zDKX
         uq9XBhiK4cXuT+VHeFGXt2FbzGEt6ijB/6rQ+jAdykQxtMi4PUSAbmvkdS4e6fzn9ExH
         qESV0CtU1DBp8iURsGVjSQWg+gccP5kT+NfJi0EqBwaOUe0eN5GQS9qoBWQk1/l1ZggD
         WDowfgGAJUfC79kHIaonfQOMQwZdK57wlg84UrxmGN0aqoMGTSfYYFRPyulxhfSLcq2p
         0N2ia0FW7spRmw7Zf7M5J+zmofXR1/rNnMVmRHjQ3fpff/zSwwK5Y9T/6nn3m/OZrc6v
         UxUg==
X-Gm-Message-State: AOAM532Uy4Ep7W+364LOoYTv1SEiPIqqYEzxxSB2VpNpAjyIFmjDszZt
        5ntLDBqvNwicrsArB0mTaozjIrmS7nkVd3ZCyiU=
X-Google-Smtp-Source: ABdhPJyf0j3dSKDSFU2vAKs1VtWJXKZvhaePvPLJxKB8ONe0F+iiIKMsqrTafhk52ilUL/41TEBzxti3EXhFrjTLrVc=
X-Received: by 2002:aa7:c7c6:: with SMTP id o6mr6747950eds.228.1624383895153;
 Tue, 22 Jun 2021 10:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210622074926.333223-1-gshan@redhat.com> <20210622074926.333223-4-gshan@redhat.com>
In-Reply-To: <20210622074926.333223-4-gshan@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 22 Jun 2021 10:44:44 -0700
Message-ID: <CAKgT0Ue461-yYEYSsSpLo-7xjK8aa3__2aAwJZ+CLy7_waC8Pg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] virtio_balloon: Specify page reporting order if needed
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 10:49 PM Gavin Shan <gshan@redhat.com> wrote:
>
> The page reporting won't be triggered if the freeing page can't come
> up with a free area, whose size is equal or bigger than the threshold
> (page reporting order). The default page reporting order, equal to
> @pageblock_order, is too huge on some architectures to trigger page
> reporting. One example is ARM64 when 64KB base page size is used.
>
>       PAGE_SIZE:          64KB
>       pageblock_order:    13       (512MB)
>       MAX_ORDER:          14
>
> This specifies the page reporting order to 5 (2MB) for this specific
> case so that page reporting can be triggered.
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 510e9318854d..fd419780cc23 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -993,6 +993,23 @@ static int virtballoon_probe(struct virtio_device *vdev)
>                         goto out_unregister_oom;
>                 }
>
> +               /*
> +                * The default page reporting order is @pageblock_order, which
> +                * corresponds to 512MB in size on ARM64 when 64KB base page
> +                * size is used. The page reporting won't be triggered if the
> +                * freeing page can't come up with a free area like that huge.
> +                * So we specify the page reporting order to 5, corresponding
> +                * to 2MB. It helps to avoid THP splitting if 4KB base page
> +                * size is used by host.
> +                *
> +                * Ideallh, the page reporting order is selected based on the

"Ideally"

> +                * host's base page size. However, it needs more work to report
> +                * that value. The hardcoded order would be fine currently.
> +                */
> +#if defined(CONFIG_ARM64) && defined(CONFIG_ARM64_64K_PAGES)
> +               vb->pr_dev_info.order = 5;
> +#endif
> +
>                 err = page_reporting_register(&vb->pr_dev_info);
>                 if (err)
>                         goto out_unregister_oom;

This works for now. However my preference would be to look into seeing
if we can add a value that the host can report that would override the
value you selected here. Then in situations where the host has a
smaller THP page size then the guest it can report the preferred
reporting order via the virtio_balloon interface and have greater
flexibility.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
