Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4018A3433B7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 18:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhCUR2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 13:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhCUR16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 13:27:58 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B24C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 10:27:57 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k8so11517268iop.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 10:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6zm0aiiO73U4b8eE9BfMLdrO9fYZI85feI/kWWq6N+0=;
        b=ODKt5GlH0QYUbBjSA0VzWTIrTFU7hNZx4Trf723HnKNdyxS7hrEYsCUB5+uKs7tX5E
         QE1i5iGdkIOJfxBdXIg1C1i6ZeWpSMYwZn1dHRYh5OytXv30xGhxU/Z+VW75q1NpznpI
         8mvur6kDTaWexnhsYokgiRWkbdVDRf9pvz6XkvP8RIzoJUXR+maNsnlHrbh8uJiStFej
         Q6nrhgNJqM9YY9fK8AGn3JbRNiYHqY0DqRvnCxtXqYqbZ9FhPf48uWJgM1auugstu0mc
         n272BTDpxEGQu80J8vl+j8+7N2DvZ9Nsa/UXBUQnVIo0prREbCQyoUTVVougJl6+qKod
         WnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6zm0aiiO73U4b8eE9BfMLdrO9fYZI85feI/kWWq6N+0=;
        b=fJ/lbWrIXHXGIiB1Vc5A8urcPrgdO0aUIn6fOJJesivYewE9zJrrpEPm+lciWo0JE/
         Vp/BItPricH7n+QsFKy10/ngJqYp+sRJNpT8dct/rfXvIH75vEXs2sjSTBMaML4s1hhY
         Uqt7Ado1VSMF/1rzAuxD/B/fYBR3V66v28zzbq8TyP/cENn1ExVH5xmnMCohR7SVsYka
         Xn5oTIOvH2J7bDbqn1tGomkCm0bi3HaH7ris897WUphrYqfeapJG+IXsv6bFvrs/hVcA
         JBO4C1OpxL7YyQWjZbjYjoceo77XigQ8mDRfGNLSNrgf1510hbkPtFujyjAVgnw5D+HO
         LtZA==
X-Gm-Message-State: AOAM533ZthNw2qs/HT09jt4ulUZWiui4pxk253+CP/4DFvsEI2mEW8W/
        yYaJk2+6xL+Mb+gKLQN9+OxhbxYSmwcBK2jA+eqAGIxY
X-Google-Smtp-Source: ABdhPJw8hFlwEyVE+neX6S01GcwG0x51SBVyZUZnXE+zOIURumHfftQt2i5MNfVCK7WrZCXNUioDdwMMiy6RYRI6yWg=
X-Received: by 2002:a05:6638:2bb:: with SMTP id d27mr8072342jaq.98.1616347677213;
 Sun, 21 Mar 2021 10:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210320162939.32707-1-yashsri421@gmail.com>
In-Reply-To: <20210320162939.32707-1-yashsri421@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sun, 21 Mar 2021 18:27:46 +0100
Message-ID: <CAKXUXMxU_7YBqyEeip5kpN5LpYmtR0MFF4QbdtOebxJHC1pkTA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix incorrect kernel-doc comment syntax in files
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     anton@tuxera.com, linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Corbet <corbet@lwn.net>,
        linux-ntfs-dev@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 5:29 PM Aditya Srivastava <yashsri421@gmail.com> wrote:
>
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> There are certain files in fs/ntfs which follow this syntax, but the
> content inside does not comply with kernel-doc.
> Such lines were probably not meant for kernel-doc parsing, but are parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warnings from kernel-doc.
>
> E.g., presence of kernel-doc like comment in the header for
> fs/ntfs/attrib.c, causes these unexpected warnings by kernel-doc:
> "warning: Incorrect use of kernel-doc format:  * ntfs_map_runlist_nolock - map (a part of) a runlist of an ntfs inode"
> "warning: Function parameter or member 'ni' not described in 'ntfs_map_runlist_nolock'"
> "warning: Function parameter or member 'vcn' not described in 'ntfs_map_runlist_nolock'"
> "warning: Function parameter or member 'ctx' not described in 'ntfs_map_runlist_nolock'"
> "warning: expecting prototype for c(). Prototype was for ntfs_map_runlist_nolock() instead"
>
> Similarly for other files too.
>
> Provide a simple fix by replacing such occurrences with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
>
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> * Applies perfectly on next-20210319
>
>  fs/ntfs/aops.c     | 2 +-
>  fs/ntfs/aops.h     | 2 +-
>  fs/ntfs/attrib.c   | 2 +-
>  fs/ntfs/compress.c | 8 ++++----
>  fs/ntfs/dir.c      | 4 ++--
>  fs/ntfs/inode.c    | 2 +-
>  fs/ntfs/mft.c      | 2 +-
>  fs/ntfs/runlist.c  | 2 +-
>  8 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
> index bb0a43860ad2..1024cdec136a 100644
> --- a/fs/ntfs/aops.c
> +++ b/fs/ntfs/aops.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/**
> +/*
>   * aops.c - NTFS kernel address space operations and page cache handling.
>   *
>   * Copyright (c) 2001-2014 Anton Altaparmakov and Tuxera Inc.
> diff --git a/fs/ntfs/aops.h b/fs/ntfs/aops.h
> index f0962d46bd67..2dcd46befdff 100644
> --- a/fs/ntfs/aops.h
> +++ b/fs/ntfs/aops.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-or-later */
> -/**
> +/*
>   * aops.h - Defines for NTFS kernel address space operations and page cache
>   *         handling.  Part of the Linux-NTFS project.
>   *
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index d563abc3e136..2911c04a33e0 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/**
> +/*
>   * attrib.c - NTFS attribute operations.  Part of the Linux-NTFS project.
>   *
>   * Copyright (c) 2001-2012 Anton Altaparmakov and Tuxera Inc.
> diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> index d2f9d6a0ee32..014dbd079ad5 100644
> --- a/fs/ntfs/compress.c
> +++ b/fs/ntfs/compress.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/**
> +/*
>   * compress.c - NTFS kernel compressed attributes handling.
>   *             Part of the Linux-NTFS project.
>   *
> @@ -18,7 +18,7 @@
>  #include "debug.h"
>  #include "ntfs.h"
>
> -/**
> +/*
>   * ntfs_compression_constants - enum of constants used in the compression code

here this one should probably be prefixed with enum; then, it should
be valid kernel-doc.

>   */
>  typedef enum {
> @@ -41,12 +41,12 @@ typedef enum {
>         NTFS_MAX_CB_SIZE        = 64 * 1024,
>  } ntfs_compression_constants;
>
> -/**
> +/*
>   * ntfs_compression_buffer - one buffer for the decompression engine
>   */
>  static u8 *ntfs_compression_buffer;
>
> -/**
> +/*
>   * ntfs_cb_lock - spinlock which protects ntfs_compression_buffer
>   */
>  static DEFINE_SPINLOCK(ntfs_cb_lock);
> diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
> index cd96083a12c8..518c3a21a556 100644
> --- a/fs/ntfs/dir.c
> +++ b/fs/ntfs/dir.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/**
> +/*
>   * dir.c - NTFS kernel directory operations. Part of the Linux-NTFS project.
>   *
>   * Copyright (c) 2001-2007 Anton Altaparmakov
> @@ -17,7 +17,7 @@
>  #include "debug.h"
>  #include "ntfs.h"
>
> -/**
> +/*
>   * The little endian Unicode string $I30 as a global constant.
>   */
>  ntfschar I30[5] = { cpu_to_le16('$'), cpu_to_le16('I'),
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index f5c058b3192c..4277d0fd7d88 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/**
> +/*
>   * inode.c - NTFS kernel inode handling.
>   *
>   * Copyright (c) 2001-2014 Anton Altaparmakov and Tuxera Inc.
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index 0d62cd5bb7f8..d197d402933a 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/**
> +/*
>   * mft.c - NTFS kernel mft record operations. Part of the Linux-NTFS project.
>   *
>   * Copyright (c) 2001-2012 Anton Altaparmakov and Tuxera Inc.
> diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
> index 97932fb5179c..0d448e9881f7 100644
> --- a/fs/ntfs/runlist.c
> +++ b/fs/ntfs/runlist.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/**
> +/*
>   * runlist.c - NTFS runlist handling code.  Part of the Linux-NTFS project.
>   *
>   * Copyright (c) 2001-2007 Anton Altaparmakov
> --
> 2.17.1
>
