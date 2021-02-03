Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB4530DAC8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhBCNOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbhBCNO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:14:26 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BE9C061786
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 05:13:46 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id k1so2814235vkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 05:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ez1wwjpaco0KteHOLeoyAT6uMeL8hWx9LM1hCKPLS5k=;
        b=D9FhYiM+MxWB+oPASVJaV3YhhH5H/3QdYSGkSeXm2TQgBM9jXVMyGRrIPqy4ZJLQ+i
         zeseRF3cm8dve5ZRousU4uVeiyCDU3xCtMaXoM6zr0cvS/KbkqwAdSNwrkf2fNcUogR5
         yPTQnvbCgNOSXj0K22dpHVnQxUN4vEYRZ8Hnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ez1wwjpaco0KteHOLeoyAT6uMeL8hWx9LM1hCKPLS5k=;
        b=uGOfq46VxPfDlckzhaKPdwIOjSHHexVps1qeHF7LM74/rZXoY2rn4XdFeq9PZhhrBj
         Y6Vx9ywu6sNyq69Ri0YgIwm9Dra8kQIp7jAoXgLzg8eAtnx33mHNHJlTMnWabT6MzUQW
         KGPtzGSslhPFYxamio7Esfc/inMx9KH2x7GmF63Nb2gvCnle+6i6T/zoIJPTiK1cwkuB
         T8Ui19vLsuuFzzNOwqbffX60brQdvVIqF79wjoTdkbJ/hy74+++Hy9cufDSo+NJHShBf
         D6hBwwhagmAz4fVRl/ItspdZvBEa565krBb+Xr1QmpqVLswjnRASGbW42oIiNMJ9o7hE
         EWrw==
X-Gm-Message-State: AOAM533c7gfMquU3D90GqCUcew4Plfrg/ZOAw6kGikBfSe7eEPIzunUX
        OV055ZZYFjd57vbXgdmXHyOvlrixwQiBPDbhfwrZiA==
X-Google-Smtp-Source: ABdhPJzt+IHf9VF9t1mMWS5DdPgpzZxrFk0/8bI1qqnbCCuXze2u3IbFLgPznBEUPWNzmYDwW7+zVrVY5aXGIS+mig0=
X-Received: by 2002:a1f:99c2:: with SMTP id b185mr995265vke.3.1612358025733;
 Wed, 03 Feb 2021 05:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20210203124112.1182614-1-mszeredi@redhat.com> <20210203130501.GY308988@casper.infradead.org>
In-Reply-To: <20210203130501.GY308988@casper.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 3 Feb 2021 14:13:27 +0100
Message-ID: <CAJfpegs3YWybmH7iKDLQ-KwmGieS1faO1uSZ-ADB0UFYOFPEnQ@mail.gmail.com>
Subject: Re: [PATCH 00/18] new API for FS_IOC_[GS]ETFLAGS/FS_IOC_FS[GS]ETXATTR
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Joel Becker <jlbec@evilplan.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Richard Weinberger <richard@nod.at>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 2:08 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Feb 03, 2021 at 01:40:54PM +0100, Miklos Szeredi wrote:
> > This series adds the infrastructure and conversion of filesystems to the
> > new API.
> >
> > Two filesystems are not converted: FUSE and CIFS, as they behave
> > differently from local filesystems (use the file pointer, don't perform
> > permission checks).  It's likely that these two can be supported with minor
> > changes to the API, but this requires more thought.
>
> Why not change the API now?  ie pass the file instead of the dentry?

These are inode attributes we are talking about, not much sense in
passing an open file to the filesystem.  That was/is due to ioctl
being an fd based API.

It would make more sense to convert these filesystems to use a dentry
instead of a file pointer.  Which is not trivial, unfortuantely.

Thanks,
Miklos
