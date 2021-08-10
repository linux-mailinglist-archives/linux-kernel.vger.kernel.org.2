Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610AD3E8357
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhHJS5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhHJS5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:57:21 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F44C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 11:56:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x27so20892546lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 11:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5J8TNSHzverklWCIf6vRYydGxpzdFZnm4R0kskdp9cc=;
        b=ndautaOoQT38CMmBdyfavMBZQUrg4llGLquOvj3ILSUjkPPYbfklhyWsnujm3oeuRe
         f9IzYajcg7Y1Unc2VFiYw+v2O5d059adb6UQ/chnQ50HQlwUPNHmkI+V0r/qWJHWxGcx
         +UiNPb6e4jgWnwA76Jp6kE9fW+owItNRsZYgVncNN92BQr2PYDi4DC5QS7OGRpllpqHQ
         KHx3FECO1R+SyjtFH55pJDHgT5TJn9pXovWEeCRFpibD7ewlW+WOhZvBuDJYClcZx4aV
         5bj/H88uu3p8vzO/Vm113dRyqgx9Pk9/HjmWi7pRjwRPw4IQWN3uQW36y3z6bgaQ6SOB
         eKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5J8TNSHzverklWCIf6vRYydGxpzdFZnm4R0kskdp9cc=;
        b=QRMP+MwNlzWQ9C4Vw96cJyHt3OuUQDgihX1HJsmDtb4QMkj/GVdVoVxCfv/4V/6jtZ
         hRUSMAbyUg3QuxfO+THRD0xg7c3URfn7+vHGI1GGBdwBb3JFq6rMZoOH5rhFx88dymgp
         MEAFccrrlwsxIxTSUisNHVkvdwUtPpm83B/uYhhFGVtzisD0aIMGsNDq4nc1Rel3+GvP
         +iLIsHBe2QGzEBGcwancDBs73Z73uU7cQoio7Kh7PLrXSMTxac8g8UHC2btTPH5jBjkG
         hJoDPIK+j1YyayaF1fyAplcUXbevzPH0Xw7fBivIUErDxk95dLr8QntrB6UsihsbGpMj
         4rdw==
X-Gm-Message-State: AOAM531SSdDd3a/lN3BbyV+J741Xr9EBRUu+wFfZ6cIc5T/XbfVCrYAh
        FPPpD3tpXw0NsfiIapFwLR3bvtDxZltmk3LIGmh3Yw==
X-Google-Smtp-Source: ABdhPJwiqBhRvlH8/uuFuNBs8e9nbzelvuQvFY1dIv6HDEfvgTFOIGeW4ZQ6fABsspcNorfg54oPNZND463/mV7PV+U=
X-Received: by 2002:ac2:531c:: with SMTP id c28mr24026257lfh.74.1628621817084;
 Tue, 10 Aug 2021 11:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210810020441.62806-1-qiuxi1@huawei.com>
In-Reply-To: <20210810020441.62806-1-qiuxi1@huawei.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 10 Aug 2021 20:56:30 +0200
Message-ID: <CAG48ez0NQd1h8PvJbHmXsPu+K1s-fw97RXZiU4hRJ8U0MT7qaA@mail.gmail.com>
Subject: Re: [PATCH 1/1] coredump: fix memleak in dump_vma_snapshot()
To:     QiuXi <qiuxi1@huawei.com>
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, xiekunxun@huawei.com,
        young.liuyang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 4:04 AM QiuXi <qiuxi1@huawei.com> wrote:
> dump_vma_snapshot() allocs memory for *vma_meta, when dump_vma_snapshot()
> returns -EFAULT, the memory will be leaked, so we free it correctly.

The change itself looks reasonable to me.

> Fixes: a07279c9a8cd7 ("binfmt_elf, binfmt_elf_fdpic: use a VMA list snapshot")
> Cc: stable@vger.kernel.org # v5.10

But I think this shouldn't be "Cc: stable". The patch only removes a
memory leak in a WARN_ON() path, and that WARN_ON() path can only be
taken if there is a kernel bug; if we reach this branch, there's a
good chance that kernel memory corruption has already occurred.


> Signed-off-by: QiuXi <qiuxi1@huawei.com>
> ---
>  fs/coredump.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 07afb5ddb1c4..19fe5312c10f 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1127,8 +1127,10 @@ int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
>
>         mmap_write_unlock(mm);
>
> -       if (WARN_ON(i != *vma_count))
> +       if (WARN_ON(i != *vma_count)) {
> +               kvfree(*vma_meta);
>                 return -EFAULT;
> +       }
>
>         *vma_data_size_ptr = vma_data_size;
>         return 0;
> --
> 2.12.3
>
