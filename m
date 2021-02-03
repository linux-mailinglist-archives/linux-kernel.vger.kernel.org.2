Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D5430DC67
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhBCOOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhBCOOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:14:21 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0853EC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:13:41 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id i12so10171433vsq.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oU/93QWt8YD3nG8PHbG11kP76EWEDbpdRCYhJ3RyBck=;
        b=CygF7dll1G/EwG+5W21ESZpamAdSlACPUFFLe2p4fkqUqTCWph28NUWHtSaiWo3Rxz
         176M5KpldgkGY8hxk7MapWqHFed12+0rnJQEYCAeYkExDwgVm0A3cm50zNQHtoyGCNLN
         HaeaVLW1ZeZtSqfZOSi4e1NCP9cWgSGl0mr6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oU/93QWt8YD3nG8PHbG11kP76EWEDbpdRCYhJ3RyBck=;
        b=VokfGHpQtJUNObuoHm/7O+ZAWj70wohegXltNVKYUUWIyg4gPkVnsHUG+76irjMA0q
         q+8Iwi6wR7d1tAfGtOrqaH4DRdIdSm2j+bM/DIXks8vSTpDJIMnPpJwEYF6HRQjrQLgz
         GJyIBtLSxDNZ6GyF3rUPVTcXiVPhu9ftBgBE38hCFYN/C0PwPgJn5xavqXQVnycsH7uf
         d9CAMaYnnH9aPLSxY1I0Sj12nF/AWm2QfNZJlXACPWvKlfAUxZySXdR+8InXHVUuVSjO
         qkjEVIcUzJXBz9SVBvBcC7DNPXbj9BXdd8nvu5HLNT4+Fd7LPypgPz9B9+4y1/o5CHRL
         rdZQ==
X-Gm-Message-State: AOAM531Z5tukZzhuBl9ZAVF5disTlaFuY1CCVHDBGk6zrATG95LJAxtl
        9fBTrFDdOcUlPm79Pzu/iEX5Q+2ovGsLv70VqJ+Q4g==
X-Google-Smtp-Source: ABdhPJxlAevD2fHZxIrX0U8Fn6wG9CNNASVAX+XdxlFkf+8NhyoTK/DaYvyPKuoYvls2PXAUx9+TV01qLOO4lMFYwgU=
X-Received: by 2002:a67:ea05:: with SMTP id g5mr1576931vso.47.1612361620214;
 Wed, 03 Feb 2021 06:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20210203124112.1182614-1-mszeredi@redhat.com> <20210203130501.GY308988@casper.infradead.org>
 <CAJfpegs3YWybmH7iKDLQ-KwmGieS1faO1uSZ-ADB0UFYOFPEnQ@mail.gmail.com> <20210203135827.GZ308988@casper.infradead.org>
In-Reply-To: <20210203135827.GZ308988@casper.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 3 Feb 2021 15:13:29 +0100
Message-ID: <CAJfpegvHFHcCPtyJ+w6uRx+hLH9JAT46WJktF_nez-ZZAria7A@mail.gmail.com>
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

On Wed, Feb 3, 2021 at 2:58 PM Matthew Wilcox <willy@infradead.org> wrote:

> Network filesystems frequently need to use the credentials attached to
> a struct file in order to communicate with the server.  There's no point
> fighting this reality.

IDGI.  Credentials can be taken from the file and from the task.  In
this case every filesystem except cifs looks at task creds. Why are
network filesystem special in this respect?

Thanks,
Miklos
