Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC50446960
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 21:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhKEUEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 16:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhKEUEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 16:04:21 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F06C061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 13:01:41 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id k24so16789674ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 13:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwqxqNONZ3nCcXRzI2pRNIMYNqvPW1JqDX8ccOMQAOo=;
        b=cNTdYA8k53vnPjLAG/Ja74NhguL/6mBPtbcxEWWpKkZOBcFlUWJ0F+o3AqrSfaredo
         UmHsK6489n7iftCUHjEpEvQ64Is/sdNcBf+nZay45joT1Nb5Zgp0PZfjG/zyf2fNdwie
         eywGZl6+wInFHO+ISbNXtW1BOJSsUlWjrlvJHsz960+Lm/26ydNIJpE76HWYW8RWYcBe
         g7yXDPCSx6IdGGlckfRhL6WL4YdEjK73jm4DaxSLsAk+a39i6dESjUG8L8++dl/PzvgF
         ewKD0EEnk+4+bYlGwNBx2+q1dRQii9yetfdW5MpSmRklqQbvH1VyX4G6VDKrPM4HVkVs
         AT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwqxqNONZ3nCcXRzI2pRNIMYNqvPW1JqDX8ccOMQAOo=;
        b=SCUMtWwhlj1mq4PbJxYVhKWBF3JLp5fcd7CMFXCEqQZvJOPaCSuZpZ7g55PaWcjUqN
         cGFvMtqon1tCMBmHrje1hgtZi8D7rnAhE3f75n+3SYn8OooWNnPsZ20GpoEmGUraXRNN
         xyy5oR8rz1o9NvndsW0v+DlciuenqRHKNaV0g4bIwetYRuws1UopMDsxc+HfVB9OYXhG
         q+zK73Q5qvaP8tQfNBjAzPgyk8NksCQa7wKq2Qjp1VREMULAyFH1O1QeTw9CqHXl7pCH
         gVw1+ZrbDWbi+l89CkKH/XSHShyr7aAOI06ArE8WKgYNLvOqSk5Pn4l1tI8Wkd55YP/U
         yYSA==
X-Gm-Message-State: AOAM533vuxcYTR+8njsvvkJtCTP1srA4M4sVzy9k7rP6DQngdjnAjG4D
        UhCGk86yAuT+wT5Frk1YxoyQsZcYrTA6hxlgeO9Rew==
X-Google-Smtp-Source: ABdhPJxnvx97oqO4dIcK7JFQQMoCaYKM9aEVRtH3xs/Z7YbqDBrU4HID2OT/pLc1k4htBHp2XbsPNTItWa1k8539ZE4=
X-Received: by 2002:a2e:3102:: with SMTP id x2mr7143024ljx.62.1636142499158;
 Fri, 05 Nov 2021 13:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211105155704.3293957-1-nathan@kernel.org>
In-Reply-To: <20211105155704.3293957-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Nov 2021 13:01:27 -0700
Message-ID: <CAKwvOdkGArbV+EPJkZjEn2eOdU8JRbADp9nD7dGpKyBkCpT89A@mail.gmail.com>
Subject: Re: [PATCH] NFS: Avoid using error uninitialized in nfs_lookup()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 8:57 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns:
>
> fs/nfs/dir.c:1772:6: error: variable 'error' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (fhandle == NULL || fattr == NULL)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/nfs/dir.c:1801:44: note: uninitialized use occurs here
>         trace_nfs_lookup_exit(dir, dentry, flags, error);
>                                                   ^~~~~
> fs/nfs/dir.c:1772:2: note: remove the 'if' if its condition is always false
>         if (fhandle == NULL || fattr == NULL)
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/nfs/dir.c:1772:6: error: variable 'error' is used uninitialized whenever '||' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (fhandle == NULL || fattr == NULL)
>             ^~~~~~~~~~~~~~~
> fs/nfs/dir.c:1801:44: note: uninitialized use occurs here
>         trace_nfs_lookup_exit(dir, dentry, flags, error);
>                                                   ^~~~~
> fs/nfs/dir.c:1772:6: note: remove the '||' if its condition is always false
>         if (fhandle == NULL || fattr == NULL)
>             ^~~~~~~~~~~~~~~~~~
> fs/nfs/dir.c:1754:11: note: initialize the variable 'error' to silence this warning
>         int error;
>                  ^
>                   = 0
> 2 errors generated.
>
> Add a label to skip the call to trace_nfs_lookup_exit() when the call to
> nfs_alloc_fhandle() or nfs_alloc_fattr_with_label() fails because
> trace_nfs_lookup_enter() has not been called at that point so tracing
> the exit does not make sense.
>
> Fixes: 8d3df1d0387e ("NFS: Remove the label from the nfs4_lookup_res struct")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1498
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  fs/nfs/dir.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 8de99f426183..1c978a7cf730 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1770,7 +1770,7 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
>         fhandle = nfs_alloc_fhandle();
>         fattr = nfs_alloc_fattr_with_label(NFS_SERVER(dir));
>         if (fhandle == NULL || fattr == NULL)
> -               goto out;
> +               goto out_no_trace;
>
>         dir_verifier = nfs_save_change_attribute(dir);
>         trace_nfs_lookup_enter(dir, dentry, flags);
> @@ -1799,6 +1799,7 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
>         nfs_set_verifier(dentry, dir_verifier);
>  out:
>         trace_nfs_lookup_exit(dir, dentry, flags, error);
> +out_no_trace:
>         nfs_free_fattr(fattr);
>         nfs_free_fhandle(fhandle);
>         return res;
>
> base-commit: cb66e0e973daa668dadd43441f877377a1b7b1ff
> --
> 2.34.0.rc0
>
>


-- 
Thanks,
~Nick Desaulniers
