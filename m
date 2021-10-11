Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303784299BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 01:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbhJKXPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 19:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbhJKXPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 19:15:50 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12285C06174E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 16:13:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y12so60723422eda.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 16:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VbHSYrxIuWvs0WJBrmp3gTDxQKx1zfn+nzTO7mNWaVk=;
        b=itYqBqk/BbhezM+FrU0bqtpt7TVkTsnOlEnVf7LPROk5Gs56SEczMpDVYj7Ew0owsg
         /2KUf5rE+tGmdcDTOxjVljFOhirLFgZuR92L90VfEf3FeZr4QtLdXPQa/+hMq8R8+Va3
         ulFBkwApEM6UCC0qR8Q8xlDLqFK3oJ8wfDBvP0zW0sgWjswZAWNT5M78UUcppLKrssLw
         Dh/6+v7ss2gL3V5p4cqWTlAqtHQZoRXESpeXTOIx5gadKqX6LbDMXpkJ2K1l1BOcipPl
         p/v4k8sizpiTM3g9AyYGqTeO48hSSFxqiJuF7Vd2kLEefnjvK8poz2ruCCL3o5cYOzoj
         GiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VbHSYrxIuWvs0WJBrmp3gTDxQKx1zfn+nzTO7mNWaVk=;
        b=jxLBbbY2vgZUoNluNhufEBjMWAk9sZPysf3uYLqPcfguueNDR5oyEHMO7SI7wpdbVk
         1LLv/xIKdMW2YMfrZajIpLIuonFscNwXyJQkbuZjGJnoHvhLzEF/ge6vSG8T92EXmFmt
         mgFFVmEF0XgYaOI83e/AHsKigHJBWyvwzsLZbO+y7U/96Vx/aLzrSGf14X11EoJ18W9X
         s3RGXe6xXxzprgRVDEA5Z6knf+BvJ8buOXfDCuH4SZ9eDJkPpc76XMliXkCE2z3RkjdY
         tEMyTsAjftxRgPq6/jGkNSBPk5QSdy+21UBLjGUP7iV/i38n43OZ3ViRznawjcCkhG/M
         KS6g==
X-Gm-Message-State: AOAM530CuS7NHjs+tIt+A19/6R/48FJjcIyrfLoGqvFfVoCw5njU9G+8
        DABjFK0u2y6rTTZ9MLiuVAVOX0ckiAzu9XU8Zw7Q
X-Google-Smtp-Source: ABdhPJwhqjv2XrohTdGULsJcB8Ip/3qpy7Zyd6bqoAsdC1P3tLpO4/GcKMk+kfnC97uBV3UyTX4VndlbkrXIls21COw=
X-Received: by 2002:a05:6402:5114:: with SMTP id m20mr45667014edd.256.1633994025809;
 Mon, 11 Oct 2021 16:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211011190204.123934-1-dave@stgolabs.net>
In-Reply-To: <20211011190204.123934-1-dave@stgolabs.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 11 Oct 2021 19:13:34 -0400
Message-ID: <CAHC9VhQngdvJCDWtguSH8EXwYhgeQwG8Zbp5jA3bheNVCZaigA@mail.gmail.com>
Subject: Re: [PATCH] selinux: consilidate comments from inode_doinit_with_dentry
 wrt !dentry
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 3:02 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> Instead of having the same big comment twice for the same scenario,
> just have it in out_invalid.
>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  security/selinux/hooks.c | 30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)

Hi Davidlohr,

Thanks for the patch, but I think the comment is a bit more
discoverable/helpful when it is integrated into the main flow of the
code and not the error handling at the bottom.  However, if you wanted
to change the second instance to refer to the prior instance I think
that would be okay.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e7ebd45ca345..0e0013cc7ba8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1502,18 +1502,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>                         if (!dentry)
>                                 dentry = d_find_any_alias(inode);
>                 }
> -               if (!dentry) {
> -                       /*
> -                        * this is can be hit on boot when a file is accessed
> -                        * before the policy is loaded.  When we load policy we
> -                        * may find inodes that have no dentry on the
> -                        * sbsec->isec_head list.  No reason to complain as these
> -                        * will get fixed up the next time we go through
> -                        * inode_doinit with a dentry, before these inodes could
> -                        * be used again by userspace.
> -                        */
> +               if (!dentry)
>                         goto out_invalid;
> -               }
>
>                 rc = inode_doinit_use_xattr(inode, dentry, sbsec->def_sid,
>                                             &sid);
> @@ -1559,15 +1549,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>                                 if (!dentry)
>                                         dentry = d_find_any_alias(inode);
>                         }
> -                       /*
> -                        * This can be hit on boot when a file is accessed
> -                        * before the policy is loaded.  When we load policy we
> -                        * may find inodes that have no dentry on the
> -                        * sbsec->isec_head list.  No reason to complain as
> -                        * these will get fixed up the next time we go through
> -                        * inode_doinit() with a dentry, before these inodes
> -                        * could be used again by userspace.
> -                        */
>                         if (!dentry)
>                                 goto out_invalid;
>                         rc = selinux_genfs_get_sid(dentry, sclass,
> @@ -1607,6 +1588,15 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>         return rc;
>
>  out_invalid:
> +       /*
> +        * This is can be hit on boot when a file is accessed
> +        * before the policy is loaded.  When we load policy we
> +        * may find inodes that have no dentry on the
> +        * sbsec->isec_head list.  No reason to complain as these
> +        * will get fixed up the next time we go through
> +        * inode_doinit with a dentry, before these inodes could
> +        * be used again by userspace.
> +        */
>         spin_lock(&isec->lock);
>         if (isec->initialized == LABEL_PENDING) {
>                 isec->initialized = LABEL_INVALID;
> --
> 2.26.2

-- 
paul moore
www.paul-moore.com
