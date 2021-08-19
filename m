Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9073F200A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 20:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhHSSma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 14:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHSSm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:42:29 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4ACC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:41:52 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z2so15014445lft.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WPfU/kDrGLSLP4a4zrY/H26g0hCkNQbnAALaNtp7Yh0=;
        b=Jk/u76anpcQfoOSuTdGiptbbA1dN+K9x5YFv+HcAeRiMRY5+vkrZjudnHEZJ5Y2NAR
         aoFePFlIQhNZAijKIDX3O/mtMvkBEJVmzKght92UK0xz9aKSTqx8rCDjT36B4a1Ut08R
         itEtdtE/JWV0xJKkD3L2SKwXT0Z1rL0leO9pjE9jFvhiFd/zf6ZdCaqJAay+AWm2l/g8
         U3bcIFAYe4bO81l+Ngwdb2HNLvWnMFK7ffl8ZD6To95fjMcvhPc8kmhLRF9K3/m2ePHd
         69UvUeJtw331OzXCLtKzX3uxCB6O74+BHrvYyyExufXoEoEVll49irXwRYWKDRqfQjvH
         9yIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WPfU/kDrGLSLP4a4zrY/H26g0hCkNQbnAALaNtp7Yh0=;
        b=UZ9FXTjy/kiaVvAyF0HXwCGCAY5WjztHdtljn2BhGXfhPxYpF71ECYLQl2DH/e5Ye9
         mRDaIZaP5sMX0zwZ5M8x1oryOrTFWWOHQZaYb6YIz9ATJPVFA58bsv+eD7MBYZgKJS8v
         A0EiG7Fo7vCAXYw+06YMyhXGpybLC4/56z2LO0tDtqXPi6Ir/eF30oGWOINSEr6mfE6A
         sYs1RJok4jYS62fQwFsfZxV4mAuIwGEV55/50eU3f4yIfrROe4Yzk+MVGj7SHAi9od0q
         pQh3TOJllYe+1dmfUlX+SUrV2pzxvqf8qzcQ4PD3JxZqEcF+0+f0OUP452HaQ/JngFRf
         aQ7g==
X-Gm-Message-State: AOAM533Wen4yV8dZMoI8RlOkv9Wl4dy2WTMtRlgJE6nmSf93dnPsolNj
        tWDkKRh+5xhY/hQI3qaf8PTeXY1AYkwvWHC0b104N7Xi1Vg=
X-Google-Smtp-Source: ABdhPJz6qsT6m8I+SuJr93y19YjZt8bjQzOgjEpYuL0VsMGG9vxrR+abU+TNDpzoojtGPe2uE8mRDPXnLRlww98FKVY=
X-Received: by 2002:ac2:4573:: with SMTP id k19mr11429688lfm.622.1629398510690;
 Thu, 19 Aug 2021 11:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210808215234.1939266-1-daeho43@gmail.com>
In-Reply-To: <20210808215234.1939266-1-daeho43@gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 19 Aug 2021 11:41:39 -0700
Message-ID: <CACOAw_xhft1SxJCBSOQ50mQpT3QwKcijJ49wOF5tzVDGdJ=Z+g@mail.gmail.com>
Subject: Re: [PATCH] f2fs-tools: change fiemap print out format
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping this?

On Sun, Aug 8, 2021 at 2:52 PM Daeho Jeong <daeho43@gmail.com> wrote:
>
> From: Daeho Jeong <daehojeong@google.com>
>
> Given fiemap way to print out extents in the kernel, we can correctly
> print the layout of each file in a unit of extent, not block. So, I
> changed fiemap print out way like below.
>
> Fiemap: offset = 0 len = 60
>         logical addr.    physical addr.   length           flags
> 0       0000000000000000 00000020032df000 0000000000004000 00001008
> 1       0000000000004000 00000020032e0000 0000000000004000 00001008
> 2       0000000000008000 00000020032e1000 0000000000004000 00001008
> 3       000000000000c000 00000020032e2000 0000000000004000 00001008
>
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  tools/f2fs_io/f2fs_io.c | 53 ++++++++++++++++++++++++++---------------
>  1 file changed, 34 insertions(+), 19 deletions(-)
>
> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> index 42dbd60..0d2948e 100644
> --- a/tools/f2fs_io/f2fs_io.c
> +++ b/tools/f2fs_io/f2fs_io.c
> @@ -731,11 +731,11 @@ static void do_randread(int argc, char **argv, const struct cmd_desc *cmd)
>  #if defined(HAVE_LINUX_FIEMAP_H) && defined(HAVE_LINUX_FS_H)
>  static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
>  {
> -       unsigned count, i;
> -       int fd;
> -       __u64 phy_addr;
> -       struct fiemap *fm = xmalloc(sizeof(struct fiemap) +
> -                       sizeof(struct fiemap_extent));
> +       unsigned int i;
> +       int fd, extents_mem_size;
> +       u64 start, length;
> +       u32 mapped_extents;
> +       struct fiemap *fm = xmalloc(sizeof(struct fiemap));
>
>         if (argc != 4) {
>                 fputs("Excess arguments\n\n", stderr);
> @@ -743,26 +743,41 @@ static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
>                 exit(1);
>         }
>
> -       fm->fm_start = atoi(argv[1]) * F2FS_BLKSIZE;
> -       fm->fm_length = F2FS_BLKSIZE;
> -       fm->fm_extent_count = 1;
> -       count = atoi(argv[2]);
> +       memset(fm, 0, sizeof(struct fiemap));
> +       start = atoi(argv[1]) * F2FS_BLKSIZE;
> +       length = atoi(argv[2]) * F2FS_BLKSIZE;
> +       fm->fm_start = start;
> +       fm->fm_length = length;
>
>         fd = xopen(argv[3], O_RDONLY | O_LARGEFILE, 0);
>
> -       printf("Fiemap: offset = %08"PRIx64" len = %d\n",
> -                               (u64)fm->fm_start / F2FS_BLKSIZE, count);
> -       for (i = 0; i < count; i++) {
> -               if (ioctl(fd, FS_IOC_FIEMAP, fm) < 0)
> -                       die_errno("FIEMAP failed");
> +       printf("Fiemap: offset = %"PRIu64" len = %"PRIu64"\n",
> +                               start / F2FS_BLKSIZE, length / F2FS_BLKSIZE);
> +       if (ioctl(fd, FS_IOC_FIEMAP, fm) < 0)
> +               die_errno("FIEMAP failed");
> +
> +       mapped_extents = fm->fm_mapped_extents;
> +       extents_mem_size = sizeof(struct fiemap_extent) * mapped_extents;
> +       free(fm);
> +       fm = xmalloc(sizeof(struct fiemap) + extents_mem_size);
>
> -               phy_addr = fm->fm_extents[0].fe_physical / F2FS_BLKSIZE;
> -               printf("%llu: %llu\n", fm->fm_start / F2FS_BLKSIZE, phy_addr);
> +       memset(fm, 0, sizeof(struct fiemap));
> +       memset(fm->fm_extents, 0, extents_mem_size);
> +       fm->fm_start = start;
> +       fm->fm_length = length;
> +       fm->fm_extent_count = mapped_extents;
>
> -               if (fm->fm_extents[0].fe_flags & FIEMAP_EXTENT_LAST)
> -                       break;
> +       if (ioctl(fd, FS_IOC_FIEMAP, fm) < 0)
> +               die_errno("FIEMAP failed");
>
> -               fm->fm_start += F2FS_BLKSIZE;
> +       printf("\t%-17s%-17s%-17s%s\n", "logical addr.", "physical addr.", "length", "flags");
> +       for (i = 0; i < fm->fm_mapped_extents; i++) {
> +               printf("%d\t%.16llx %.16llx %.16llx %.8x\n", i,
> +                   fm->fm_extents[i].fe_logical, fm->fm_extents[i].fe_physical,
> +                   fm->fm_extents[i].fe_length, fm->fm_extents[i].fe_flags);
> +
> +               if (fm->fm_extents[i].fe_flags & FIEMAP_EXTENT_LAST)
> +                       break;
>         }
>         printf("\n");
>         free(fm);
> --
> 2.32.0.605.g8dce9f2422-goog
>
