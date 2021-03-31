Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D27634F824
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 06:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhCaEzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 00:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbhCaEzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 00:55:18 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ABAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 21:55:18 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d13so6206118lfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 21:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWM2i/Jx+bgof7D8MVRWvlYvDcBJTZI4MpLJfBGFFVk=;
        b=VT3ZzBbYHwc1X0kR4cjMxXLUu6aCOb5AUG3Qb1EuY5hFuqGu3AzdnYXaJQmMPlOZuD
         OiHResEevDsvjTP2KRTX4qaiSLOoAFWHj3xoAX0DECTimqJ75wj3ON6f8qJkNvvolYcw
         cVxX+mTAoDM18OqFxORXJYuJn/4lYaSVXSg0UmOs7mggZNVm7yYgMEqsAUA0K4sf/zug
         XFMtT+2iWaY5uCtG4zIttrPkSpeQKNOVbq0eoUuz9eBCg7ERmwV88KPLk+j4kqZMF9qy
         qFHOd+31boZPFnqTWfbejArZjMstg6LFPTcBW5iR0vSWMiqSmMzGYg7QUaPWLpiV91J6
         KA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWM2i/Jx+bgof7D8MVRWvlYvDcBJTZI4MpLJfBGFFVk=;
        b=mB/phHmjDz4bg1QVUms19Ila1gtxtkmge2Dn04c6MS/4u/Mi4fay/ZAWR0LTcAYdqb
         JRTv541z47POzJHRg5rwkIJ3haoTIcICBZJYX/3feplmBq4uG/aXLvTTIjBHfalE/vhC
         cEcZOdzgQznpQroybQpwe5WHx5I9r2koG+Yq+9X2ubKlOYRoKsqSFMt3D+VMSXHVupbl
         3V5ECcHo1ICqqL3fwtfOSV7LUU+T2vNzUG+luu4m5JryqgWthD+96/Wy48SSsBCLG2X0
         tRSwx8p3Ly/E78yzvmbggABlthSVT6a2k60h8nXtXq72g2nfL9lrBpk2uBE17fWUUQcs
         s8+w==
X-Gm-Message-State: AOAM533Z5u+GBkKS9/IFPUKGM8FAvGADXd+sUg+fGwml5ykxrq88/Rbr
        EYosApBfTKLtss8m+b1FJwpe9Z2iFjdBdeKOExk=
X-Google-Smtp-Source: ABdhPJyt8sVTIXnZKzCxMyktj5iNCSIX8kBZeQPZb/A4JrasC+CsaiAvX5n/u9azIgLNBWQnUL4w2BDyEIOb8vr2skM=
X-Received: by 2002:a19:b81:: with SMTP id 123mr1027890lfl.553.1617166516732;
 Tue, 30 Mar 2021 21:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210330134537.423447-1-joel@jms.id.au>
In-Reply-To: <20210330134537.423447-1-joel@jms.id.au>
From:   Lei YU <mine260309@gmail.com>
Date:   Wed, 31 Mar 2021 12:55:05 +0800
Message-ID: <CAARXrtn8bq9X5nDVYrGDxT4O8xWknb0nErG_SjZRUZbbk5nguA@mail.gmail.com>
Subject: Re: [PATCH] jffs2: Hook up splice_write callback
To:     Joel Stanley <joel@jms.id.au>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        "William A . Kennington III" <wak@google.com>,
        linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 9:45 PM Joel Stanley <joel@jms.id.au> wrote:
>
> overlayfs using jffs2 as the upper filesystem would fail in some cases
> since moving to v5.10. The test case used was to run 'touch' on a file
> that exists in the lower fs, causing the modification time to be
> updated. It returns EINVAL when the bug is triggered.
>
> A bisection showed this was introduced in v5.9-rc1, with commit
> 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops").
> Reverting that commit restores the expected behaviour.
>
> Some digging showed that this was due to jffs2 lacking an implementation
> of splice_write. (For unknown reasons the warn_unsupported that should
> trigger was not displaying any output).
>
> Adding this patch resolved the issue and the test now passes.
>
> Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  fs/jffs2/file.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
> index f8fb89b10227..4fc8cd698d1a 100644
> --- a/fs/jffs2/file.c
> +++ b/fs/jffs2/file.c
> @@ -57,6 +57,7 @@ const struct file_operations jffs2_file_operations =
>         .mmap =         generic_file_readonly_mmap,
>         .fsync =        jffs2_fsync,
>         .splice_read =  generic_file_splice_read,
> +       .splice_write = iter_file_splice_write,
>  };
>
>  /* jffs2_file_inode_operations */
> --
> 2.30.2
>

Verified on g220a openbmc system that the patch fixes the issue.

Tested-by: Lei YU <yulei.sh@bytedance.com>
