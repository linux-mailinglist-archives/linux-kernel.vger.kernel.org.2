Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956A83A444F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhFKOrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:47:53 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:33677 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhFKOru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:47:50 -0400
Received: by mail-vs1-f53.google.com with SMTP id 126so3931691vsi.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 07:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7PvXVENs4UcLiDY3320dR9DN7zBQ45xeDN/rAyFn8JA=;
        b=i5LVNB0DwhGf2ES3OdhAjX+n64FoNUud/WLuGEq8qE8Er+PbPUy9mhs1J9pD0lWRI7
         pEC1Zhm5NVv66PV5FNWT3WSIHOFieg2/cIAzBiqqm/NQDhdXEU816QuGBapZyfrO8u+W
         KC213z6/e2h7YA2fB/mlJbqtbkW4l3Ei3FMbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7PvXVENs4UcLiDY3320dR9DN7zBQ45xeDN/rAyFn8JA=;
        b=B2AUwez+amLgkuVgLO9JonPoFGzmY36+4RoByzZnJdtNHI+k4qECoTPq8avucXvfh4
         jcNCmjJOBi9nwHsiQFz/se4+zQ5LPgqid/HMHe98ittEfuPhffH+HKXl/pgs31TLd1dO
         7hM6hZJpzFEd9FGbSZJagM0Buaz9wgqD7fx85AhicsIc9PZ2RA6CGz7sjh3tiAjUE0os
         aI/zMfPZyTVek3Qr87c8/9wKoFJT8SKWS43VaFHXYpWtBtdTkKJNRD4bauPH6KmygnR6
         tvM42tCed+Ow3reLDQcaUimYCL4q3tIi9D/VsaXfqWbpUiqV0nqxn+1l/63N2tgCiFlx
         FO+A==
X-Gm-Message-State: AOAM533er6Zq1VQQqZcDI+vw2eT+4x2vlAV6XqUAsSkq13y7RfJYE8tu
        iYM/dhvbGNhYq4PkwvL867jbRK7gUcU5/lGIBjGeUtSP1hY=
X-Google-Smtp-Source: ABdhPJxpw1yGLViH5uP4+1r0GCK+sji66nQF20epPTph2zduLFfY6TO0ArXupmFGS9kkFvhdypNtZ62szadvE1aODo0=
X-Received: by 2002:a05:6102:2144:: with SMTP id h4mr9505890vsg.21.1623422677896;
 Fri, 11 Jun 2021 07:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210604161156.408496-1-groug@kaod.org> <20210604161156.408496-7-groug@kaod.org>
 <0d3b4dfb-2474-2200-80d1-39dcbf8f626e@redhat.com> <20210609094547.222fc420@bahia.lan>
In-Reply-To: <20210609094547.222fc420@bahia.lan>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 11 Jun 2021 16:44:27 +0200
Message-ID: <CAJfpegsWL30hfduM1HLwgeruKUJ=rdUgG=wNdFHV9m4entPw=Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] fuse: Switch to fc_mount() for submounts
To:     Greg Kurz <groug@kaod.org>
Cc:     Max Reitz <mreitz@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 at 09:45, Greg Kurz <groug@kaod.org> wrote:
>
> On Tue, 8 Jun 2021 17:51:03 +0200
> Max Reitz <mreitz@redhat.com> wrote:
>
> > On 04.06.21 18:11, Greg Kurz wrote:
> > > fc_mount() already handles the vfs_get_tree(), sb->s_umount
> > > unlocking and vfs_create_mount() sequence. Using it greatly
> > > simplifies fuse_dentry_automount().
> > >
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >   fs/fuse/dir.c | 26 +++++---------------------
> > >   1 file changed, 5 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > > index b88e5785a3dd..fc9eddf7f9b2 100644
> > > --- a/fs/fuse/dir.c
> > > +++ b/fs/fuse/dir.c
> > > @@ -311,38 +311,22 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
> > >     struct fs_context *fsc;
> > >     struct vfsmount *mnt;
> > >     struct fuse_inode *mp_fi = get_fuse_inode(d_inode(path->dentry));
> > > -   int err;
> > >
> > >     fsc = fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry);
> > > -   if (IS_ERR(fsc)) {
> > > -           err = PTR_ERR(fsc);
> > > -           goto out;
> > > -   }
> > > +   if (IS_ERR(fsc))
> > > +           return (struct vfsmount *) fsc;
> >
> > I think ERR_CAST(fsc) would be nicer.
> >
>
> Indeed. I'll fix that if I need to repost.

Fixed.

Thanks,
Miklos
