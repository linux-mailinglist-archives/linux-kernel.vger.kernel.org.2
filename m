Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774C53473E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 09:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhCXIp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 04:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbhCXIpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:45:16 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF63C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 01:45:14 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id s136so5275705vks.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 01:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhT7lfu6P/3gT6Gg14tRPHhEqpMNGcVm3EE4u5owq+s=;
        b=peHbnBR3pIePzrAZMjcifsEkQBojGOrwDnuQWDhUWpzj4w85Z7ehJuErLNCWzjLYQH
         b5ohTRkn6WdZdl4P61CnWhHcE2bgUka8SuMwEhR9hBISYOu100MQGgF8e9+Io1/l4IHD
         PsYJDjwxYA5b+eP/Z7mWPJ78Ld4UfsNSpqep4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhT7lfu6P/3gT6Gg14tRPHhEqpMNGcVm3EE4u5owq+s=;
        b=UpBfTXdEcmZ2fXY9q2ueJZZ9OEi+7vlxMAVg20e4WwexGWYkCP9S1q04qcity5hZjz
         X7RDCXxA9AfoiUDEwSoOkrYFcKPuJXxopv0Xduj83bgWX9BD3oqrcbRPpAlgfy9rSV3f
         Hz6mTXxDS7avAwhw5uNXpGOZuWo9r+exCqrX3sFn43hd+qFcTm2I1EsVzphbat40BOkZ
         ni+mXy4eBfYJCfhCs68x9AGJrhUQ85+fpOPyAx4YVkV2qBm2kDTnS6iHfwY9Og8V3ju1
         XA4zWUvatPhODjQeUu5q/44HvAOF/v5TvZMtasviYHCoX9inmwTjlg+MqT3sdE0yoTh/
         oMnQ==
X-Gm-Message-State: AOAM533lokA4yQ5g/DpJUsLH40imQJ6pfgNmSVJc9lmV0Z9RVS+87gLD
        kXVlxrdLUJ17jXFF1x3Oo5BzkBP2wYH1LUyKmy9pPA==
X-Google-Smtp-Source: ABdhPJw6t3EbCij0cw/geB+IbiuwBERrBfJj3cGhUAeY6YqrDieR4WsbBp4SmyjICHzK0TzFHPudfmL9nLSjnapAOUo=
X-Received: by 2002:a1f:a047:: with SMTP id j68mr825333vke.14.1616575513624;
 Wed, 24 Mar 2021 01:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210322144916.137245-1-mszeredi@redhat.com> <20210322144916.137245-2-mszeredi@redhat.com>
 <YFrH098Tbbezg2hI@zeniv-ca.linux.org.uk>
In-Reply-To: <YFrH098Tbbezg2hI@zeniv-ca.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 Mar 2021 09:45:02 +0100
Message-ID: <CAJfpegvy-bSoorAnPVRUxGjR5s10sJp3qRS0K-O91PcDvLSEPg@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] vfs: add miscattr ops
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 6:03 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Mar 22, 2021 at 03:48:59PM +0100, Miklos Szeredi wrote:
>
> minor nit: copy_fsxattr_{to,from}_user() might be better.
>
> > +int fsxattr_copy_to_user(const struct miscattr *ma, struct fsxattr __user *ufa)
> > +{
> > +     struct fsxattr fa = {
> > +             .fsx_xflags     = ma->fsx_xflags,
> > +             .fsx_extsize    = ma->fsx_extsize,
> > +             .fsx_nextents   = ma->fsx_nextents,
> > +             .fsx_projid     = ma->fsx_projid,
> > +             .fsx_cowextsize = ma->fsx_cowextsize,
> > +     };
>
> That wants a comment along the lines of "guaranteed to be gap-free",
> since otherwise you'd need memset() to avoid an infoleak.

Isn't structure initialization supposed to zero everything not
explicitly initialized?

>
> > +static int ioctl_getflags(struct file *file, void __user *argp)
> > +{
> > +     struct miscattr ma = { .flags_valid = true }; /* hint only */
> > +     unsigned int flags;
> > +     int err;
> > +
> > +     err = vfs_miscattr_get(file_dentry(file), &ma);
>
> Umm...  Just to clarify - do we plan to have that ever called via
> ovl_real_ioctl()?  IOW, is file_dentry() anything other than a way
> to spell ->f_path.dentry here?

Indeed, file_dentry() only makes sense when called from a layer inside
overlayfs.

The one in io_uring() seems wrong also, as a beast needing
file_dentry() should never get out of overlayfs and into io_uring:

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -9297,7 +9297,7 @@ static void __io_uring_show_fdinfo(struct
io_ring_ctx *ctx, struct seq_file *m)
                struct file *f = *io_fixed_file_slot(ctx->file_data, i);

                if (f)
-                       seq_printf(m, "%5u: %s\n", i, file_dentry(f)->d_iname);
+                       seq_printf(m, "%5u: %pD\n", i, f);
                else
                        seq_printf(m, "%5u: <none>\n", i);
        }


Thanks,
Miklos
