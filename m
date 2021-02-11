Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA69319227
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhBKSW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhBKSKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 13:10:50 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E36C061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 10:10:05 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id a11so2743299vsm.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 10:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PiqXp2PbyEiLqS8FHKk3htkQdFQdzlKYkDOHu8k3JOY=;
        b=Xwo0pQ/f5+8iKK+3IOQfRxyVQJDRmzL9FuHu6PLz2yP8e7qMghKrHEILpI0ueSUELL
         qLQP+k/taSHnOl+aCP9FAcKdaHaqNuM2Y0MbiH3ftlR6xwt3ShjVfB6Me0mOBmbrbzmh
         w7R8HlwGXbKheEgD49bYLpZlV1T1S/3FQy2YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PiqXp2PbyEiLqS8FHKk3htkQdFQdzlKYkDOHu8k3JOY=;
        b=VVskqBuWeMfkdb59oWcSZe3yy7dY+wnvmQTPY+/YPitgGf2My2J3EkBPB6zlxePejg
         sFZWvye5PdUMcXEFk2sNX5fQoNA1ZCkw8K1VdDsQAEVKVvGum8FIXjtJn0eftvVvzIjy
         GL6E3XyslfvD6/13i2mDiBE53r8UriibG8H7mWjnvdAwdPrSlaX/oRW1PQelctcuWbJe
         Dy14eSMxUa2y2wLFG27HEWLPsDAmIs6TKdD52CNU3GzypQP83hhMWd5q0E7V1zaY8utI
         pz48zPQllt7DN2iw1wY5i+pJU4xRMLFLBur6Q/34d0nVHufnVXfACXbBgSb39Zi36TUC
         +7GA==
X-Gm-Message-State: AOAM530zBQbqLezWesWNsxHhkZ5mwOsYmHPGGoTAakAFDcMUHDiifpWU
        9/p6MoFE4LAHZp9dJmrR5yLO1rBLcJ2gZz9SQXLrNA==
X-Google-Smtp-Source: ABdhPJyHOEeRdFv75UmPbMUvtaY9AXLINWJbxpsMnuvldfZD44vuzuAkibShiFvDwpEnT685yjb/SXeJuQxYZ5RvPZw=
X-Received: by 2002:a67:c992:: with SMTP id y18mr6591996vsk.7.1613067004890;
 Thu, 11 Feb 2021 10:10:04 -0800 (PST)
MIME-Version: 1.0
References: <20210124232007.21639-1-richard@nod.at> <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com>
 <563952295.378372.1612881357746.JavaMail.zimbra@nod.at> <1923896038.379134.1612901174023.JavaMail.zimbra@nod.at>
 <CAJfpegufojx4q_CfR6L-fzSyQw9QXJZKy5xKVZZWaepADkL=Kw@mail.gmail.com> <CAJfpegv-UDcgzkFiZXdoif2qjws5_xXh2bQSNbNdviQHhxzZHA@mail.gmail.com>
In-Reply-To: <CAJfpegv-UDcgzkFiZXdoif2qjws5_xXh2bQSNbNdviQHhxzZHA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 11 Feb 2021 19:09:53 +0100
Message-ID: <CAJfpegsbVWPGKe-bLvM=00EHe-PC_QgJ9umxCf1gFtUQge6_cg@mail.gmail.com>
Subject: Re: [PATCH 0/8] MUSE: Userspace backed MTD v3
To:     Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ron Minnich <rminnich@google.com>, sven <sven@narfation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:16 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, Feb 10, 2021 at 11:12 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > But this is just a start.  From the big structures still left in
> > <net/fuse.h> CUSE only uses the following fields:
> >
> > fc: .minor, max_read, max_write, rcu, release, initialized, num_waiting
> > fm: .fc
> > ff: .fm
> > fud: .fc
> >
> > Dealing with the last 3 is trivial:  create and alloc function for the
> > fm, and create accessor functions for the accessed fields.
> >
> > Dealing with fc properly is probably a bit more involved, but does not
> > seem to be too compex at first glance.
> >
> > Do you want to take a stab at cleaning this up further?
>
> On second thought, I'll finish this off, since I know the internal API better.
>

Pushed to

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#fs_fuse_split

There's still room for improvement, but I guess this can wait after
MUSE integration.

Thanks,
Miklos
