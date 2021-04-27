Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E6736C9A3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbhD0QnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhD0QnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:43:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB4C1613E8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 16:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619541749;
        bh=w6ZEQdx/XPRkgKLCATNcfhwBBvtLOXmp4gH60MEweWw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=owphvuKiEK5kPXrzccOqgGPOhtdqMUJRVBP/Eox2OTYijLeDa0H4cnua/YXnDpfBM
         qNFkOKjhzZ98MzSLv9sSoM2vY4ow9JcFtk6Yp3wKjck5cx2l7F5uC45Tis7zU0+p22
         8TEGI8wsmsrc3DqNkInWJVRppmLcWdLNeh4biXR1SUfQnDH1/X/YrnOvcvAaPI482c
         HcDMM4/QkNyVFzH7vEQqXqg/ZxBCsbp7GG9wXJJvAd54JtXhjbq/qJ3wlbUrkXpoeS
         aIxUt+eENOhbDqsRQbLSSfdxkOQjggrjiy9f1NXV+idRDVxqZdnXNJGsswTbU6+Hc3
         I9SE26xqJjNGg==
Received: by mail-oo1-f54.google.com with SMTP id s1-20020a4ac1010000b02901cfd9170ce2so13185202oop.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:42:29 -0700 (PDT)
X-Gm-Message-State: AOAM530JL3dXF3/BR1Lg/BTXbxvrzO91IjGqKK0/jaCADXNXjPk7Y2x2
        5kWJ+QD2YRLjkH+M47fdJ8OzjIDIqW+Fh10Yk+Y=
X-Google-Smtp-Source: ABdhPJy5J1r+f3DHiJ2kGWLzXvwNXLBtfJDEaF01H+PvNtd0W/UJn4DdS3vmAcpJ50cwhkj3w0PXPNt4LOz8V9BCMXk=
X-Received: by 2002:a4a:db7d:: with SMTP id o29mr18542659ood.45.1619541749073;
 Tue, 27 Apr 2021 09:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-35-gregkh@linuxfoundation.org> <YIg+QUwh+wQze4+Z@kroah.com>
In-Reply-To: <YIg+QUwh+wQze4+Z@kroah.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 27 Apr 2021 18:42:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEYLKJX3DfzPAT78iQMMpXWmEGtBbjQDyfZzTR3pYBxMw@mail.gmail.com>
Message-ID: <CAMj1kXEYLKJX3DfzPAT78iQMMpXWmEGtBbjQDyfZzTR3pYBxMw@mail.gmail.com>
Subject: Re: [PATCH 034/190] Revert "efi/esrt: Fix reference count leak in esre_create_sysfs_entry."
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qiushi Wu <wu000273@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2021 at 18:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 21, 2021 at 02:58:29PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 4ddf4739be6e375116c375f0a68bf3893ffcee21.
> >
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> >
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> >
> > Cc: Qiushi Wu <wu000273@umn.edu>
> > Cc: https
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/firmware/efi/esrt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> > index d5915272141f..e3d692696583 100644
> > --- a/drivers/firmware/efi/esrt.c
> > +++ b/drivers/firmware/efi/esrt.c
> > @@ -181,7 +181,7 @@ static int esre_create_sysfs_entry(void *esre, int entry_num)
> >               rc = kobject_init_and_add(&entry->kobj, &esre1_ktype, NULL,
> >                                         "entry%d", entry_num);
> >               if (rc) {
> > -                     kobject_put(&entry->kobj);
> > +                     kfree(entry);
> >                       return rc;
> >               }
> >       }
> > --
> > 2.31.1
> >
>
> Looks correct so I'm dropping the revert.
>
> greg k-h

Agreed.
