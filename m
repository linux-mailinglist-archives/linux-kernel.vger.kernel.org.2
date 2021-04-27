Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89C136CB56
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbhD0SzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbhD0SzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:55:16 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2FCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 11:54:30 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id d15so18143140ljo.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 11:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yPFimr3gWw7Jb8pUUshKa57KI8HC4i9N5TDaJMgan8c=;
        b=Vxhki8lggKUqdFDQ6eIME/t1w216q7NYR8YXdlh83bNCmievHFJ2KZzm1xLcUbOzvX
         e5EFqL3S3XC/ku0z5FV7YGwMQe+gmv6mXWY6NK9A8SLs4L3CgMn7lanF369p5IvX/wP+
         cVELa+9rHfODxiUiv6vwOq3AFIDnelHyK+zAKiyhNh1rEhcd0XRiEBV6uCg3CfRgnwrT
         IGzwKlMhSvON8Fls70IESsAel3rAffgnqhwEiBaYZarsi2ZqqdjojMD1pvwTBCQleLJM
         WjnaDedTcdOnnTZV4Gq9PdWwWsu8dhGu/FCHve5kn8fKUnCkjTvzcamU7L50DG/cI9Rl
         uYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yPFimr3gWw7Jb8pUUshKa57KI8HC4i9N5TDaJMgan8c=;
        b=WUYeMKDOBTKY5KYgqXOSVvXwWipzGimwBHnzO4cyaXmVMwiXsPpW4PW9jlhCZVvEVH
         pescflY/FLCNbczBDvwSc4Nr2uBbvPk8jroi9Kjmk77+D/RU/Xm/B3aL27hy3nXfiQLr
         a/oaftcBynA3BF7+j7T6Y8RXCMciEi1f31ROOPekS/3UpV/vedSOagp+Ak+ZXdVxbvmo
         a88alXx6VqWvWlaxLVtqdgYWiFoBN4LsUI9GU/3DuZDuKo3j3pB0F7ASBVGIPVyS3XMe
         xnFJhi0o/taKt4cF/8mZ3l2XRSGA5k37KUfw85owWI9lNiS+KpE4zrAYfbQxwEPEAtYV
         Z/mQ==
X-Gm-Message-State: AOAM5301nEpB01M6S2zmBd4HGCZ502II2cokGSXlnjJ3imEZEFVPtEpS
        hrP3aBF81QWSWMURMwjN8uTiptUFXMQQubTvvfzlrw==
X-Google-Smtp-Source: ABdhPJzHoLqRICL71ALIa24JJ1ebX1XyXWU9+ppH6h0if4Nj6EWpZQVUCgVq195FmPDCVGbBfP91SypPMgyjoKhxDIk=
X-Received: by 2002:a2e:9015:: with SMTP id h21mr17225853ljg.233.1619549668748;
 Tue, 27 Apr 2021 11:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <1619345754-32875-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1619345754-32875-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Apr 2021 11:54:17 -0700
Message-ID: <CAKwvOd=-NdUHevj9eBtKmihL8D0BSVyiOr9pMUNMYTWm1Y=KGg@mail.gmail.com>
Subject: Re: [PATCH] fs/ntfs: drop unneeded assignment in ntfs_perform_write()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-ntfs-dev@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Huckleberry <nhuck15@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 3:16 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> It is not required to initialize the local variable idx in
> ntfs_perform_write(), the value is never actually read from
> it.
>
> make clang-analyzer on x86_64 allyesconfig reports:
>
> fs/ntfs/file.c:1781:15: warning: Although the value stored to 'idx' is
> used in the enclosing expression, the value is never actually read from
> 'idx'
>
> Simplify the code and remove unneeded assignment to make clang-analyzer
> happy.

Thank you for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Is there someplace where I can learn more about "Abaci Robot?"  I'm
happy to see it running clang-analyzer. :)

>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/ntfs/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index e5aab26..e39a26f 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -1774,11 +1774,11 @@ static ssize_t ntfs_perform_write(struct file *file, struct iov_iter *i,
>         last_vcn = -1;
>         do {
>                 VCN vcn;
> -               pgoff_t idx, start_idx;
> +               pgoff_t start_idx;
>                 unsigned ofs, do_pages, u;
>                 size_t copied;
>
> -               start_idx = idx = pos >> PAGE_SHIFT;
> +               start_idx = pos >> PAGE_SHIFT;
>                 ofs = pos & ~PAGE_MASK;
>                 bytes = PAGE_SIZE - ofs;
>                 do_pages = 1;
> --
> 1.8.3.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/1619345754-32875-1-git-send-email-yang.lee%40linux.alibaba.com.



-- 
Thanks,
~Nick Desaulniers
