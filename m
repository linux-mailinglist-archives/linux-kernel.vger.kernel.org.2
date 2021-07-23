Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D083F3D36EE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 10:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbhGWH7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 03:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234386AbhGWH7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 03:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627029593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0R6geRNUNQC0kRoF+lSv0pifLg2KS6M6ylGJCMhofy4=;
        b=IF4/l2ffsAVJmuw29rHktc4SwMyJ4y0K0BcSlO2tua+9Rx7EaPkkM5FhCmO+okA/6oW0sX
        yWOLuOvbyQCjf8p5QkNb2TUkxD0yZTib2yDJSgiSYfvokeQ6LHwvmdxXdFQY3qOCDp5KNv
        5SvV5y0q9g7lB/Ue0IfhnsaZipA8h8U=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-2zxfhNhtMIOcjlQq-hERDw-1; Fri, 23 Jul 2021 04:39:51 -0400
X-MC-Unique: 2zxfhNhtMIOcjlQq-hERDw-1
Received: by mail-yb1-f197.google.com with SMTP id r1-20020a0569021541b029054df41d5cceso1004386ybu.18
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 01:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0R6geRNUNQC0kRoF+lSv0pifLg2KS6M6ylGJCMhofy4=;
        b=NDqwBNcCRCyk238jQ34VWf5OAbnlWhm1ug3GXBW7ctKD/O/UWMoIlNiJTMZzCFCHMh
         QEWymU2KChnb8tlyFucXvPoGP1ijg7DUUD3zjiYKCGPEnBR2w4c1aWapG+X0JurdbHFa
         yOyvtEM1gsBKAxLBbkgbqCq5ZfPKWVgKRAqdsFVbNxUDZUyvfNHK/YpW3eVTQiYxuu+e
         cpcRrM0lGqoHI0dkaPG2zDQXQMVmMwSXaq5IN4vsGHgCG3fHXsB2ktyhX0Uhmr6xxw/z
         vlcsjCDEs82471N1S05p+ELiJQ7740qjV3pJQJ1aXQAbSpVxbMF4YZ7ri3v3aHc/6vXP
         vzew==
X-Gm-Message-State: AOAM532lwJ6guuKsn6W2OzAKwKtfCvE2wiqyThPsN14z81/p52KdSRWJ
        ClMRxfba8+wSArc9I5byoOt59d0SRcY2HeVnrUCyyD6+Yguwvi9jCPUnNu4+gc7IahjigcpqkXJ
        3K0q1f+eVh5AbrmYCXKQRaMx3xsYbs/ZojSjMMOzA
X-Received: by 2002:a25:ad06:: with SMTP id y6mr4824944ybi.439.1627029591446;
        Fri, 23 Jul 2021 01:39:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoipMlzBA/c+4YtmIWldiJukH66ZNqDaJOTH+DaPJOdlJ6BqCck6ROt8is3ynzWvQ2IC9DyGQaGkkj7dNqS/Y=
X-Received: by 2002:a25:ad06:: with SMTP id y6mr4824924ybi.439.1627029591301;
 Fri, 23 Jul 2021 01:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210624152515.1844133-1-omosnace@redhat.com>
In-Reply-To: <20210624152515.1844133-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 23 Jul 2021 10:39:40 +0200
Message-ID: <CAFqZXNtb-VdL9f8Ntg3RLZtP0x-7ZgEP1D0qL9fWCM7SPWcHXQ@mail.gmail.com>
Subject: Re: [RFC PATCH] userfaultfd: open userfaultfds with O_RDONLY
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <roc@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 5:25 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Since userfaultfd doesn't implement a write operation, it is more
> appropriate to open it read-only.
>
> When userfaultfds are opened read-write like it is now, and such fd is
> passed from one process to another, SELinux will check both read and
> write permissions for the target process, even though it can't actually
> do any write operation on the fd later.
>
> Inspired by the following bug report, which has hit the SELinux scenario
> described above:
> https://bugzilla.redhat.com/show_bug.cgi?id=1974559
>
> Reported-by: Robert O'Callahan <roc@ocallahan.org>
> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> I marked this as RFC, because I'm not sure if this has any unwanted side
> effects. I only ran this patch through selinux-testsuite, which has a
> simple userfaultfd subtest, and a reproducer from the Bugzilla report.
>
> Please tell me whether this makes sense and/or if it passes any
> userfaultfd tests you guys might have.
>
>  fs/userfaultfd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 14f92285d04f..24e14c36068f 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -986,7 +986,7 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *new,
>         int fd;
>
>         fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, new,
> -                       O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
> +                       O_RDONLY | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
>         if (fd < 0)
>                 return fd;
>
> @@ -2088,7 +2088,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>         mmgrab(ctx->mm);
>
>         fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, ctx,
> -                       O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
> +                       O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
>         if (fd < 0) {
>                 mmdrop(ctx->mm);
>                 kmem_cache_free(userfaultfd_ctx_cachep, ctx);
> --
> 2.31.1

Ping? Any comments on this patch?

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

