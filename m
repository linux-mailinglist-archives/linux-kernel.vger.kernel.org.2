Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE26935C701
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 15:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbhDLNIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 09:08:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239409AbhDLNIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 09:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618232892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=otGT/idIYaxyQ7GR4T+PhiVlu9+JXsCYqF5tB9i4mYo=;
        b=T1CBMK7sopdEEp0/F2MVuPbc4h5HrjiPqt658NhZbIy8KfFh19XL2cjm4uDRXvryKv7Iaq
        qwq5KZ+y2zDW/dHR2f7hcJUe/NSmEyPAk14EYQDl+XRhD9CD4LWriBh8PDfe9SYroTZzMR
        b44u6wf6d8OkdpC4H6PLfSY+MCjS3Rc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-2_Gg_thiMYecPZ34xKHFBQ-1; Mon, 12 Apr 2021 09:08:08 -0400
X-MC-Unique: 2_Gg_thiMYecPZ34xKHFBQ-1
Received: by mail-qv1-f69.google.com with SMTP id b20so7603727qvf.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 06:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otGT/idIYaxyQ7GR4T+PhiVlu9+JXsCYqF5tB9i4mYo=;
        b=ax+heraVFpsW7YC8yuHDmZ9jUZL1q2lVw6exzrpWE2O5nBhAc+0rLjSZ2+gmG4UKIb
         ey6zJbiqZ+EDxJZMfWsNq83gKH35JWcT3qtKNSX5SBrLCTpBsS+6gjX7aD0uPyWAEoRS
         T424CMuFNVSijao+fNmCYDu5Im0iGBH7jhAGfJ3flE7ziJ1cdEdtt7Cx9nw0nzL6x2TK
         lgC9UQqDmV58BGRueR+jZhzWafQv0Q61uRYvRM98Mum3BYFAIH7G2W+7X0DnxyqbWPTo
         qkcDqvNyWrXYXCuyeG9beLmTOkyVsC35VKbws4DuUuj0bx8+RJWdzW9PZCdrtu1wMYm8
         Z+1A==
X-Gm-Message-State: AOAM5321nA6hCkVOupZaaVlKRBN4uS9Xpc5bt0kgg7l7YrDEvx08AY3D
        mZ7/0Ksqs7NUXeE+On9Vcr1xMHmlGO9LYwQMzL6f7YmUwEuSbR9V5Cim11mPGjEW64qUneds0+1
        wc7zT2cXaMsGaGTWY0epK2tPr11mLrxZGift/MvhN
X-Received: by 2002:a05:622a:18a:: with SMTP id s10mr25054264qtw.237.1618232887805;
        Mon, 12 Apr 2021 06:08:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpDbXPx+FlN6dvGLpYb9ZDLeRek2ScHceimDqA8UHWpGvuZxuyVO1rvL/0EfsADt564xwPyEGhhUOwcZ1L+j4=
X-Received: by 2002:a05:622a:18a:: with SMTP id s10mr25054238qtw.237.1618232887553;
 Mon, 12 Apr 2021 06:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210412214730.2dbbcdff@canb.auug.org.au>
In-Reply-To: <20210412214730.2dbbcdff@canb.auug.org.au>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 12 Apr 2021 15:07:56 +0200
Message-ID: <CAOssrKdAmeVK_uwLCDo_ZT52vOzxSU9X=orgzU6RB088L6OdKA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the vfs tree
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

Fixed fileattr branch pushed to:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git fileattr_v6

Thanks,
Miklos

On Mon, Apr 12, 2021 at 1:47 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the vfs tree, today's linux-next build (htmldocs) produced
> this warning:
>
> Documentation/filesystems/locking.rst:113: WARNING: Malformed table.
> Text in column margin in table line 24.
>
> ============    =============================================
> ops             i_rwsem(inode)
> ============    =============================================
> lookup:         shared
> create:         exclusive
> link:           exclusive (both)
> mknod:          exclusive
> symlink:        exclusive
> mkdir:          exclusive
> unlink:         exclusive (both)
> rmdir:          exclusive (both)(see below)
> rename:         exclusive (all) (see below)
> readlink:       no
> get_link:       no
> setattr:        exclusive
> permission:     no (may not block if called in rcu-walk mode)
> get_acl:        no
> getattr:        no
> listxattr:      no
> fiemap:         no
> update_time:    no
> atomic_open:    shared (exclusive if O_CREAT is set in open flags)
> tmpfile:        no
> fileattr_get:   no or exclusive
> fileattr_set:   exclusive
> ============    =============================================
>
> Introduced by commit
>
>   10a489bbff3e ("vfs: add fileattr ops")
>
> --
> Cheers,
> Stephen Rothwell

