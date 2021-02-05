Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C181731172D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhBEXec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbhBEOWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:22:50 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C0CC0617AA
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:00:12 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d2so4030606pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+hzPa1F4JAM47t70Roqcz7crnnubahY7MUE4gPkyOc=;
        b=kJkmysqYHrZGs3+fpupO+SdH0WNgec3k/1YXBLzsjRhwhvSzX5Id9iqPsT171m5O6c
         Mosq/QNbyUac50Z0p0hPlSQJc7vKSAqT8m9NZF4kzwxa8D+zV80lXgcCOtu1PBc7ooW3
         VAN8E3DhnankzQz81VQF9GJoXXeBaUWnPRd0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+hzPa1F4JAM47t70Roqcz7crnnubahY7MUE4gPkyOc=;
        b=YKzzWOfMG5GfUUEJ70CfZniOgCG5HVy0nzRliLzzmZfGZ0kYz73fsqUxLif+Zqr9iW
         UsO5MFlf87OrvlMIT6gPKwMmhGFhXhC98HYu+Lc6mije2EKmijfaipjP1xRhlrExg06B
         VqQNThyWCK+6Gl7vOhE5q0Ttm1ugvwfcepxFUzxbnczrTBHOg3Swj7LkrWWKEA4gAlDM
         vCAd4syIIrGJgU6QTGZ+B6Tx31a3y8x3fHHmLJp5dRde1mo02hE3Po43OsIeYw2smBzq
         hLz/DLot1HjBchxK6ux2EwIuqnO/rM7+ZJkCM01Vu6j+GLA87iQ7j5gks+XgyZirWAWL
         UduQ==
X-Gm-Message-State: AOAM532eighiNTlZVtlkPc7a0mvn8RiOOGkNUO+mV/amBLcVobjsK58n
        ifp41yL1UxuhX9nKPOn+PFP6/l3zx15ctOpepEpFZ1nce+A=
X-Google-Smtp-Source: ABdhPJxeWoZ0wWAybWqnxwlr/rJLeHQZqg86VDmAb37maDIyniFgAsX0Q0wwTZ+XuU8gjne6pl4QDillngq5h96qu6U=
X-Received: by 2002:a67:c992:: with SMTP id y18mr3353078vsk.7.1612538917519;
 Fri, 05 Feb 2021 07:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20210203124112.1182614-1-mszeredi@redhat.com> <20210203124112.1182614-4-mszeredi@redhat.com>
 <20210204234211.GB52056@redhat.com> <CAJfpegv+dtVZWJ1xmagaZsGfg3p9e0Svj_qFXiWYQ3ROvGPHLg@mail.gmail.com>
In-Reply-To: <CAJfpegv+dtVZWJ1xmagaZsGfg3p9e0Svj_qFXiWYQ3ROvGPHLg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 5 Feb 2021 16:28:26 +0100
Message-ID: <CAJfpegvxb9bfbBpoa6R8UENwL9m6BSU84kr50PBSssUJYc8wFQ@mail.gmail.com>
Subject: Re: [PATCH 03/18] ovl: stack miscattr
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 4:25 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Fri, Feb 5, 2021 at 12:49 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> > > +int ovl_miscattr_set(struct dentry *dentry, struct miscattr *ma)
> > > +{
> > > +     struct inode *inode = d_inode(dentry);
> > > +     struct dentry *upperdentry;
> > > +     const struct cred *old_cred;
> > > +     int err;
> > > +
> > > +     err = ovl_want_write(dentry);
> > > +     if (err)
> > > +             goto out;
> > > +
> > > +     err = ovl_copy_up(dentry);
> > > +     if (!err) {
> > > +             upperdentry = ovl_dentry_upper(dentry);
> > > +
> > > +             old_cred = ovl_override_creds(inode->i_sb);
> > > +             /* err = security_file_ioctl(real.file, cmd, arg); */
> >
> > Is this an comment intended?
>
> I don't remember, but I guess not.  Will fix and test.

Sorry, yes, problem is that there's no file pointer available at this point.

Fix is probably to introduce security_inode_miscattr_perm() hook.

Thanks,
Miklos
