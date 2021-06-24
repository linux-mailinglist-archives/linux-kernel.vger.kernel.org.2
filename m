Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6923B3701
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 21:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhFXTb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 15:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhFXTb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 15:31:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84682C061574;
        Thu, 24 Jun 2021 12:29:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hz1so11260391ejc.1;
        Thu, 24 Jun 2021 12:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l0vCZVJmlxeZsHP1JHZxI0c+0Gn87IYlynAirE52ORE=;
        b=HWs70M2rMsBn+n0I+yCR6V0lcXTcc5lOy9y+1P1OuFVoXbPbE+pa7mAROQTLu8I6i0
         +5Ch4iiHXSMBd6U/AlKh/M82F+UAIJIHUl8DFDb2qpfERlWuKqrVtQg2bSEcGX0ZQQQs
         ZEweBw6cGsdvqbKKMibmup65JwEyyfhopU6G8Yq6RW2Dgbc6T/ZB0GfXxzGbfJs73eUU
         PNvYUMQ/wEgujB3FCkM9qby/sfU1b2nGqnb4z3qemiXfZuxmLfKCx7kyQrMBOLFQg1bk
         Z3UR8+nFp1/tPw6XrZ0cqCYnprT/LqnYL7ZerZU9qH4J/dnwMLrbh1zg5MxHEglYro38
         gRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l0vCZVJmlxeZsHP1JHZxI0c+0Gn87IYlynAirE52ORE=;
        b=Sm3NJ4aDapMW/L2hEJ98pNuNTTuRrq7s4/HtTasyJyp3wdHtpAqFFBQW70BRsgvO18
         IEMi2A445ftnwLJ1OsIDmSz6WFhUmut79jpsclcJOBsKK/eKCAoSv5HBdaPdJHk+p4Dz
         IKLeTvbFpZRw2QHtiXgA7QoToFEkL/m3zaJ4eZPhrA2giyleTdIDzIF0oo4U3VgygPUH
         aCeKz4zVC/m7Xzu+YUDVNMufkBKLaeRc1yGRH3C7lNwhVVsUuqrOCi3FW6HIHsWsXvIq
         Lt/JCyCIFgkYmuohgdXFMs9zJ8qvJjW+Oiyj1Es3tmKPe+ppHkst05gV5p5/jx9THynr
         dbuA==
X-Gm-Message-State: AOAM530OoxzYbfVrM8EpY+7uwBp4guYdols4JrsHf4heMias0rLWRXaG
        ULbQQACpIPyElgGWxZrn+W9krCmWNU7VsgzjrW0=
X-Google-Smtp-Source: ABdhPJxIan0loZsBJnWMG+041AAK3GFfFqb3bxdtvzCHrXU4hHTdpydPiGhW4eBn/UxiCFR6PViKPB+0ltwcK0c+P4g=
X-Received: by 2002:a17:906:2844:: with SMTP id s4mr6760586ejc.263.1624562974956;
 Thu, 24 Jun 2021 12:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210612140559.20022-1-paskripkin@gmail.com>
In-Reply-To: <20210612140559.20022-1-paskripkin@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 25 Jun 2021 04:29:22 +0900
Message-ID: <CAKFNMokV7WC_6LVBKJ2mN26w91ZT=rfLvzD5v4cYahHH2ZUWpQ@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix memory leak in nilfs_sysfs_delete_device_group
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Vyacheslav Dubeyko <Vyacheslav.Dubeyko@hgst.com>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sat, Jun 12, 2021 at 11:06 PM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> My local syzbot instance hit memory leak in nilfs2.
> The problem was in missing kobject_put() in
> nilfs_sysfs_delete_device_group().
>
> kobject_del() does not call kobject_cleanup() for
> passed kobject and it leads to leaking duped
> kobject name if kobject_put() was not called.
>
> Fail log:
>
> BUG: memory leak
> unreferenced object 0xffff8880596171e0 (size 8):
>   comm "syz-executor379", pid 8381, jiffies 4294980258 (age 21.100s)
>   hex dump (first 8 bytes):
>     6c 6f 6f 70 30 00 00 00                          loop0...
>   backtrace:
>     [<ffffffff81a2c656>] kstrdup+0x36/0x70 mm/util.c:60
>     [<ffffffff81a2c6e3>] kstrdup_const+0x53/0x80 mm/util.c:83
>     [<ffffffff83ccc698>] kvasprintf_const+0x108/0x190 lib/kasprintf.c:48
>     [<ffffffff83e99926>] kobject_set_name_vargs+0x56/0x150 lib/kobject.c:289
>     [<ffffffff83e99fd9>] kobject_add_varg lib/kobject.c:384 [inline]
>     [<ffffffff83e99fd9>] kobject_init_and_add+0xc9/0x160 lib/kobject.c:473
>     [<ffffffff8304e840>] nilfs_sysfs_create_device_group+0x150/0x800 fs/nilfs2/sysfs.c:999
>     [<ffffffff830159f6>] init_nilfs+0xe26/0x12b0 fs/nilfs2/the_nilfs.c:637
>
> Fixes: da7141fb78db ("nilfs2: add /sys/fs/nilfs2/<device> group")
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>

This fix looks correct to me.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi

> ---
>  fs/nilfs2/sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
> index 303d71430bdd..9c6c0e2e5880 100644
> --- a/fs/nilfs2/sysfs.c
> +++ b/fs/nilfs2/sysfs.c
> @@ -1053,6 +1053,7 @@ void nilfs_sysfs_delete_device_group(struct the_nilfs *nilfs)
>         nilfs_sysfs_delete_superblock_group(nilfs);
>         nilfs_sysfs_delete_segctor_group(nilfs);
>         kobject_del(&nilfs->ns_dev_kobj);
> +       kobject_put(&nilfs->ns_dev_kobj);
>         kfree(nilfs->ns_dev_subgroups);
>  }
>
> --
> 2.32.0
>
