Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4C631173C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhBEXlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhBEOUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:20:10 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249BBC061D73
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:56:47 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id i12so3827575vsq.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JwvNzK6nDq5Er9R9/mIvhs7c3RrwWuEVZBZei4KWYqY=;
        b=FMNnzyNhGvGrRmFsvBh607EIWOmz7XwcD84qO4dbG0OfIZQ0Ly+R721iqPk5P8MV86
         5bW3X9IDgkObEdvoef79Va2EZHc1DurM//VSGsQ+T7xfQX+MFVNr23ufVGXse+lWb45b
         CjihLHzKNQJElOM/0y5B6qcBDRhSH7swANtjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JwvNzK6nDq5Er9R9/mIvhs7c3RrwWuEVZBZei4KWYqY=;
        b=fjw7O37YBBYQRGfdnzgn3g/je5odV6LyFqqSuduPUuGgLcp8PekyhKaPkXRgJDP+yO
         Ira9PB6aGFJrUfJso3Fydr+r7pWjsZJzWatniRbc5Q0mqbC+e8X5VeC/XVpV0aS5KmdQ
         8VCZM8nV7CeSLJU5kAy3MNlGj4S92RxM925Gz8w3eYARtk4bLZnlxRmahsK+wiW1v1jX
         GQPbgLjY9ByZQf0YglTzjLcLEcld8LKaQuUEaEnXFR4e39fsS8HsAhX888n4c+37ILG3
         XjjkCbuDTYNtoD49BbNwDfo3zgoKHTkjUTc+2XGin6OQVKJiHNfLIhdZLdAT6+rGDIUW
         meVg==
X-Gm-Message-State: AOAM533q08ScdfPn+mUpONctSSiQ8tiYkaUYVAxQJZ1+j/nuPsjiTbbA
        6WSd4uW41zUWpQTV7wrpsHDCrC62fxcaqC9KyLBR1b3te6k=
X-Google-Smtp-Source: ABdhPJxpiAIajbp/96HYuphp6BimXqFpSrJVysECPVTL0775RsCWnYLm38EXKrqHWjQJX0xMQP5kjhre7scrOTH2TCo=
X-Received: by 2002:a67:a404:: with SMTP id n4mr3263723vse.0.1612538770907;
 Fri, 05 Feb 2021 07:26:10 -0800 (PST)
MIME-Version: 1.0
References: <20210203124112.1182614-1-mszeredi@redhat.com> <20210203124112.1182614-4-mszeredi@redhat.com>
 <20210204234211.GB52056@redhat.com>
In-Reply-To: <20210204234211.GB52056@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 5 Feb 2021 16:25:59 +0100
Message-ID: <CAJfpegv+dtVZWJ1xmagaZsGfg3p9e0Svj_qFXiWYQ3ROvGPHLg@mail.gmail.com>
Subject: Re: [PATCH 03/18] ovl: stack miscattr
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 12:49 AM Vivek Goyal <vgoyal@redhat.com> wrote:

> > +int ovl_miscattr_set(struct dentry *dentry, struct miscattr *ma)
> > +{
> > +     struct inode *inode = d_inode(dentry);
> > +     struct dentry *upperdentry;
> > +     const struct cred *old_cred;
> > +     int err;
> > +
> > +     err = ovl_want_write(dentry);
> > +     if (err)
> > +             goto out;
> > +
> > +     err = ovl_copy_up(dentry);
> > +     if (!err) {
> > +             upperdentry = ovl_dentry_upper(dentry);
> > +
> > +             old_cred = ovl_override_creds(inode->i_sb);
> > +             /* err = security_file_ioctl(real.file, cmd, arg); */
>
> Is this an comment intended?

I don't remember, but I guess not.  Will fix and test.

Thanks,
Miklos
