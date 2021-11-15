Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7571045061A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhKON6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:58:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50499 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231839AbhKON5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636984487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1oW9sD+2AlinVXXOjh9UHbzKRCqNVMJhsj45Nv42XRs=;
        b=Y4TlIsIa9PHMNeORU9X2sWAJFVAnugczd9NXCJxl7cN1EcJcRdgC+yCVziyS0EwSiji1vy
        g1zUMtlcNARr/7BpNr4DQPUbEf19iktaOMy/L9cSDCK0Fgi+7WrSJYzSD3fBbQR6m+gpRW
        l9sUQsKyMV2O1+MkTGOSObiERxPoHZE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-Dnf6hWRAN7S7o8dz9wekmA-1; Mon, 15 Nov 2021 08:54:46 -0500
X-MC-Unique: Dnf6hWRAN7S7o8dz9wekmA-1
Received: by mail-qk1-f200.google.com with SMTP id w2-20020a3794020000b02903b54f40b442so11085337qkd.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:54:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1oW9sD+2AlinVXXOjh9UHbzKRCqNVMJhsj45Nv42XRs=;
        b=N8BzhlhJfiQzo6O+ZGC1xaoOCs2l1mKJcUO3NP93REsAhi+ugz/QYCoQDg0agWydMv
         F2aTObsjko/JByKglm77xLCgj8EBlGuJDp09UIs7r0G0GGVS9oE14s2b13aR4q/khcQ9
         IAUZqq+dtll4JWtWZFuw41rnO8p081ysbM3caI1g1xNjA9NvMO1qvbvBjZog011zbzuZ
         tOTmRpDuPScZT+QNwM2RFQ3cOELxOAFzEBorppKHZGo0b4pRodHv80j+poYZBDEomhEh
         njYON6bFlrNyPaxe0WPKVfXlk9QZ+L+dehqdyal55z8bKgUC4wQl5TDmuWX1jfVXp1ho
         XqmQ==
X-Gm-Message-State: AOAM530eaAbE7Aup+v1zVEOq14JmvfObA/2XMMy/xgreeEuyPrndjDSZ
        yHcTJvLzuAbNqtbZq3LB6TlDX+60AFt+0gVfrrHMKZdiDOhglX/ZUwxK42kMRwfUL9vOa6B0SrM
        l0V9HO1ZrVfk6bvflEfDFnkTv1QU6N+lYvk7Ccvur
X-Received: by 2002:a05:622a:54d:: with SMTP id m13mr40084051qtx.33.1636984486253;
        Mon, 15 Nov 2021 05:54:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTm8JYuDG6GEhTO5KI4SZG6p+GRfwe8qHsK3jkuxd72OMJUQDzywaCHfaBzK0+pYhBcm1jJnOYdBWlrDtl7dM=
X-Received: by 2002:a05:622a:54d:: with SMTP id m13mr40084027qtx.33.1636984486058;
 Mon, 15 Nov 2021 05:54:46 -0800 (PST)
MIME-Version: 1.0
References: <20210816125444.082226187@linuxfoundation.org> <20210816125447.013365592@linuxfoundation.org>
In-Reply-To: <20210816125447.013365592@linuxfoundation.org>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 15 Nov 2021 14:54:35 +0100
Message-ID: <CAOssrKe5S4AGUD+TUT2AkeWo-7Cjfbw4vX-d3bPi6xfNOVY-CA@mail.gmail.com>
Subject: Re: [PATCH 5.13 089/151] ovl: fix deadlock in splice write
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
        syzbot <syzbot+579885d1a9a833336209@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Looks like upstream commit b91b6b019fd ("ovl: fix deadlock in splice
write") needs to be added to linux-5.4.y.

The reason is that commit 82a763e61e2b ("ovl: simplify file splice")
was backported to v5.4.155, and the above commit fixes this.

Applies cleanly and I reviewed that the backport is correct.

Thanks,
Miklos

On Mon, Aug 16, 2021 at 3:13 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Miklos Szeredi <mszeredi@redhat.com>
>
> [ Upstream commit 9b91b6b019fda817eb52f728eb9c79b3579760bc ]
>
> There's possibility of an ABBA deadlock in case of a splice write to an
> overlayfs file and a concurrent splice write to a corresponding real file.
>
> The call chain for splice to an overlay file:
>
>  -> do_splice                     [takes sb_writers on overlay file]
>    -> do_splice_from
>      -> iter_file_splice_write    [takes pipe->mutex]
>        -> vfs_iter_write
>          ...
>          -> ovl_write_iter        [takes sb_writers on real file]
>
> And the call chain for splice to a real file:
>
>  -> do_splice                     [takes sb_writers on real file]
>    -> do_splice_from
>      -> iter_file_splice_write    [takes pipe->mutex]
>
> Syzbot successfully bisected this to commit 82a763e61e2b ("ovl: simplify
> file splice").
>
> Fix by reverting the write part of the above commit and by adding missing
> bits from ovl_write_iter() into ovl_splice_write().
>
> Fixes: 82a763e61e2b ("ovl: simplify file splice")
> Reported-and-tested-by: syzbot+579885d1a9a833336209@syzkaller.appspotmail.com
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/overlayfs/file.c | 47 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 4d53d3b7e5fe..d081faa55e83 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -392,6 +392,51 @@ out_unlock:
>         return ret;
>  }
>
> +/*
> + * Calling iter_file_splice_write() directly from overlay's f_op may deadlock
> + * due to lock order inversion between pipe->mutex in iter_file_splice_write()
> + * and file_start_write(real.file) in ovl_write_iter().
> + *
> + * So do everything ovl_write_iter() does and call iter_file_splice_write() on
> + * the real file.
> + */
> +static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
> +                               loff_t *ppos, size_t len, unsigned int flags)
> +{
> +       struct fd real;
> +       const struct cred *old_cred;
> +       struct inode *inode = file_inode(out);
> +       struct inode *realinode = ovl_inode_real(inode);
> +       ssize_t ret;
> +
> +       inode_lock(inode);
> +       /* Update mode */
> +       ovl_copyattr(realinode, inode);
> +       ret = file_remove_privs(out);
> +       if (ret)
> +               goto out_unlock;
> +
> +       ret = ovl_real_fdget(out, &real);
> +       if (ret)
> +               goto out_unlock;
> +
> +       old_cred = ovl_override_creds(inode->i_sb);
> +       file_start_write(real.file);
> +
> +       ret = iter_file_splice_write(pipe, real.file, ppos, len, flags);
> +
> +       file_end_write(real.file);
> +       /* Update size */
> +       ovl_copyattr(realinode, inode);
> +       revert_creds(old_cred);
> +       fdput(real);
> +
> +out_unlock:
> +       inode_unlock(inode);
> +
> +       return ret;
> +}
> +
>  static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>  {
>         struct fd real;
> @@ -603,7 +648,7 @@ const struct file_operations ovl_file_operations = {
>         .fadvise        = ovl_fadvise,
>         .flush          = ovl_flush,
>         .splice_read    = generic_file_splice_read,
> -       .splice_write   = iter_file_splice_write,
> +       .splice_write   = ovl_splice_write,
>
>         .copy_file_range        = ovl_copy_file_range,
>         .remap_file_range       = ovl_remap_file_range,
> --
> 2.30.2
>
>
>

