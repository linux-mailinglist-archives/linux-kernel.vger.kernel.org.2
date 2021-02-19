Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C2931F5FC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 09:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhBSIlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 03:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhBSIlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 03:41:14 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B488DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 00:40:33 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id t15so1608056ual.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 00:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KAX4LYl0kG8JmUeTzz+wEYqEQj0XL2YyaDiep9J2YS8=;
        b=gd/7FyckxK787QDZNsZVd1QllF5rpLh64V2h2mv5C+8wsia4dfy1uM3w2MoG50n4cI
         4N2ZTX8/CsqKCmT5oZnH2SKk8ICiBcJ4a0TyxUth24i6SmxTnVOSzXuUHOlVTkEW1oP2
         T6+IHONQVolDO0REMDZI9A2ijbKT/e6jCzD4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KAX4LYl0kG8JmUeTzz+wEYqEQj0XL2YyaDiep9J2YS8=;
        b=GCHirI8fupMPCnsq7uQ3+t+FXwjbjkT5WIfEkkbnOv2wsw9TdWtelzDiSRrwDS/dHr
         V3W/Dnp0dJEUbJ+UrKEL04Ut4iMk+huGt956lt+8v3rvs3HP4hd1UNookwy/LSVPG+0n
         aJrfczm9obeN0Qj5RkoC8YFGaTt+UqyfEb+cC3tSM3AAtMUtYCqvRD8Fnva+o8dH6Okj
         zH7+S4XqWwBp9GpM+DfxFtYNram/SvFsHRMTxM02Qf26qLrM5sKywoCRiqn572Tr4AJY
         FuUyBoVfOL2ftTXO6b1gCuytfNdjDAZKK5U7O++ZJPidBkHAFczDZHxMnBShP9n6eupt
         OyIw==
X-Gm-Message-State: AOAM530xKU8LeTK8I6VGdMA/Hn/NZiAnGMCM06cqbLpckhdbqw5nXLAY
        aWk9R6w0IiXlAQxYGfaAzkmOLE1soA/qEswZvOGdvA==
X-Google-Smtp-Source: ABdhPJzJH+5GI9QWwC1IyLsbDQuQfFymjQa1dh4IP0OeySwY17q+wAUhAUf8XUPUqrbpG/3gI3rWoc04RvisEarqvio=
X-Received: by 2002:ab0:5963:: with SMTP id o32mr6378901uad.11.1613724032852;
 Fri, 19 Feb 2021 00:40:32 -0800 (PST)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com> <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
In-Reply-To: <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 19 Feb 2021 09:40:21 +0100
Message-ID: <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 3/8] fuse: Definitions and ioctl for passthrough
To:     Peng Tao <bergwolf@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 8:05 AM Peng Tao <bergwolf@gmail.com> wrote:
>
> On Wed, Feb 17, 2021 at 9:41 PM Miklos Szeredi <miklos@szeredi.hu> wrote:

> > What I think would be useful is to have an explicit
> > FUSE_DEV_IOC_PASSTHROUGH_CLOSE ioctl, that would need to be called
> > once the fuse server no longer needs this ID.   If this turns out to
> > be a performance problem, we could still add the auto-close behavior
> > with an explicit FOPEN_PASSTHROUGH_AUTOCLOSE flag later.
> Hi Miklos,
>
> W/o auto closing, what happens if user space daemon forgets to call
> FUSE_DEV_IOC_PASSTHROUGH_CLOSE? Do we keep the ID alive somewhere?

Kernel would keep the ID open until explicit close or fuse connection
is released.

There should be some limit on the max open files referenced through
ID's, though.   E.g. inherit RLIMIT_NOFILE from mounting task.

Thanks,
Miklos
