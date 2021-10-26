Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B8843B8B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbhJZR7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbhJZR7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:59:13 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE370C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:56:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bi35so498558lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXHfZ86odio1b4QPRjCoCHQLyWLuNFoC6/YMvOwKHbk=;
        b=iSryYreFEEivvuynGghPKji0V27StpxuxQV81oxzdKf7oPUM82JVS5MutIo+tu0jFV
         L+VfHnxo/J+4VSjBHMziRFkse0SiEpcXYeLNR3WNLL/KSyVTiRihRjZzTDzcWKd/V1Sn
         agEHLEzzT/2rHIdhJY8NpiIcG6kZG2LgYZV08mn+Hc8bpXuyCXauRJR6rOKe7U2T+son
         gF+GWZvW3RnffEzPZZN4b3sKKS+8N2Np/tML8o5Kmta+8FxHQYaaCVlolVuOemfd3Rp6
         D0djKcWReIheSG1A5UICHh47rrjiBtzBp4MqDGlPAkbo9f6tqiea0X60V9TNE9Z6Bu28
         Bp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXHfZ86odio1b4QPRjCoCHQLyWLuNFoC6/YMvOwKHbk=;
        b=rNWysTkoZ639whZ+t3Vuk+sU6gG6cobfsi+6g+yWkbB2VmWyUEdcC5UCaCWnAWv8cQ
         vqKVB/pd6JEWUUdnBZlIIHC74Js3bcjmdQ7Jzje2Ujc28ZUKX0w/x+eBUltJ77uUnKCZ
         Euc/82U7EW/vLUf0RVcg9prvALMfhZCAADzXcq+ButaRrNZyiwlPErV5QWwH/i5pEbid
         NoD86nx79FRM+uYCzrnSUQAHqqVuLzNRsy/TRbuC4pEEiQzIe1oLV5kMAGLHNSK5h26u
         EGBMpwzZYUFetA+Dv7WUfoh2kQN5K2nqIGpiBPrxsbpokeWl1xbBgxNGCFPZ8UivMoJQ
         M5IA==
X-Gm-Message-State: AOAM531t/y8a5XpBxuiMVZORECaXc01C0MKf/+hLuuoty03xtaUoSexg
        t8/gP4xWFZpiENueXL8gbwZEvGiwoXbpGhDHr+I=
X-Google-Smtp-Source: ABdhPJxd9EPqnGWJhhp7pr+ysGJmauvoQPXQHrcaTI4Vg6ZicUI/FwgvLc3Z9OiQooRf7CHujdCFr3QEQ1xvPm6l1k8=
X-Received: by 2002:a19:6742:: with SMTP id e2mr23660988lfj.568.1635271007226;
 Tue, 26 Oct 2021 10:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211014190503.717830-1-daeho43@gmail.com> <e8b106fb-2878-2fa9-788f-965eef179a85@kernel.org>
 <CACOAw_yupuz+Xx-z9V0UaExuARHd8H9rruWCa2yj5-mgkeuUtQ@mail.gmail.com>
 <3ddb4013-8d63-7c00-6fdd-1f21752bd60c@kernel.org> <CACOAw_wjhr8j=-qEDHP_H+_7cTh_ep7Wix4=JC+5x5zp-zpUFA@mail.gmail.com>
 <c93106ef-b567-b973-7241-ea2fcef84855@kernel.org>
In-Reply-To: <c93106ef-b567-b973-7241-ea2fcef84855@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 26 Oct 2021 10:56:36 -0700
Message-ID: <CACOAw_xOOcoTCYnxtSq9Sqn0aUvt=F_6UgUwWeh9RkS5Oj-RDg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove circular locking between
 sb_internal and fs_reclaim
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, I doubt the problem may also happen in f2fs_evict_inode() with below
> callpath:
>
> - evict_inode
>   - dquot_initialize failed
>   - sb_start_intwrite
>   - f2fs_truncate
>    - dquot_initialize lock dqio_sem
>
> How about this?
>

Got it~
Then we need this in both f2fs_evict_inode() and f2fs_drop_inode().

Thanks,

> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> old mode 100644
> new mode 100755
> index b24b9bc..0e49593
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -728,6 +728,7 @@ enum {
>       FI_ENABLE_COMPRESS,    /* enable compression in "user" compression mode */
>       FI_COMPRESS_RELEASED,    /* compressed blocks were released */
>       FI_ALIGNED_WRITE,    /* enable aligned write */
> +    FI_QUOTA_INIT_FAIL,    /* inidicate failed to initialize quota in drop_inode()/evict_inode() */
>       FI_MAX,            /* max flag, never be used */
>   };
>
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> old mode 100644
> new mode 100755
> index 13deae0..2fb53f54
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -789,9 +789,11 @@ int f2fs_truncate(struct inode *inode)
>           return -EIO;
>       }
>
> -    err = dquot_initialize(inode);
> -    if (err)
> -        return err;
> +    if (!is_inode_flag_set(inode, FI_QUOTA_INIT_FAIL)) {
> +        err = dquot_initialize(inode);
> +        if (err)
> +            return err;
> +    }
>
>       /* we should check inline_data size */
>       if (!f2fs_may_inline_data(inode)) {
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> old mode 100644
> new mode 100755
> index 1213f15..16cf50c
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -758,6 +758,7 @@ void f2fs_evict_inode(struct inode *inode)
>       if (err) {
>           err = 0;
>           set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
> +        set_inode_flag(inode, FI_QUOTA_INIT_FAIL);
>       }
>
>       f2fs_remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
> @@ -770,6 +771,8 @@ void f2fs_evict_inode(struct inode *inode)
>   retry:
>       if (F2FS_HAS_BLOCKS(inode))
>           err = f2fs_truncate(inode);
> +    if (is_inode_flag_set(inode, FI_QUOTA_INIT_FAIL))
> +        clear_inode_flag(inode, FI_QUOTA_INIT_FAIL);
>
>       if (time_to_inject(sbi, FAULT_EVICT_INODE)) {
>           f2fs_show_injection_info(sbi, FAULT_EVICT_INODE);
>
> Thanks,
>
>
> > In fact, I picked up the idea from here.
> >
> >          err = dquot_initialize(inode);
> >          if (err) {
> >                  err = 0;
> >                  set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
> >          }
> >
> >          f2fs_remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
> >          f2fs_remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
> >          f2fs_remove_ino_entry(sbi, inode->i_ino, FLUSH_INO);
> >
> >          sb_start_intwrite(inode->i_sb);
> >          set_inode_flag(inode, FI_NO_ALLOC);
> >          i_size_write(inode, 0);
> > retry:
> >          if (F2FS_HAS_BLOCKS(inode))
> >                  err = f2fs_truncate(inode);
> >
