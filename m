Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C2B439B70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbhJYQYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbhJYQYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:24:48 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298CBC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:22:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bq11so11159026lfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NV5xGjeuKgWRl/AhpoxwqkehlRrug/Db58M9ZBXGaY0=;
        b=DxHEufieywRogdN+zRT2Fvd7AcyLJXan+k4lp9oZ6i708wTKTUuJdVkvgg7/+/foHJ
         rGDfbQuoBHCnzKQ215OYOSvUW4nAmRr3T+cHnzwRx/QtHi2W8zV/NDWEJyRy5lEji6U1
         29Hl/HibXnAKbge6wMjYtB88UZ2tUJlUkM7rToz25BGieSiK1/hECzVB9eL4QpVuQ4pE
         dbKWR1Oax2GOuFXBd0BESbEvyuJA8/GT19mYEhR6NjtzBnqIIMe4nZ+vXWuHVSIjTyzM
         qJvxy4nqC70GCi618+64IJpYylEdB0B5mmiyfYRSgBOjQpld26p5qmnLdvCyFpppizcI
         nf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NV5xGjeuKgWRl/AhpoxwqkehlRrug/Db58M9ZBXGaY0=;
        b=ae5CE8xZnDiYkCpMUABXRkuFXiQAR1avJab6zVqVrDN2n+1TZT9XDvFLhCvI7tBgeU
         PY3N6Yv6q9FgLrvGcd/XG4rjHc4rvj1o2FBcz7/shaKAuzCOcw9nRF7QoOpDgx4bM/00
         FMBEIJvHDG9jfquPsAl7wgm1d0J4ZBqKVU0iZEBITfoqgAA07ZBx6aK2+50NJ1S1alwB
         2I3nzyxMhHKNxl7/TqoY+rC0FATRRnjRiShUgREXCtv3g2DGiC8M33THGn4SboPEFD5a
         QeuZNFXH64LaqPayJTPz84Bsypw4+HFBH0qZOcA2mRgUy3FwincQqKWnRaNgA6dZus00
         2/bg==
X-Gm-Message-State: AOAM530syalElz5wjJ8Q+R4tw5JVPS4wTsdQVEax81fXO3//SXbKtLhB
        kFDrZLvbEClBi/jOFyrK97cbNZfb/kxGhs+g3R4MSFUprO4=
X-Google-Smtp-Source: ABdhPJyk5EwgLvFQId0G03B/U7FsCuwXAyPOZPL/tvQaV4OJEzm0ikoyJwxvaOHigrg/xqXAuIaDx9z1Bl4RI6Ck488=
X-Received: by 2002:a05:6512:1056:: with SMTP id c22mr18504309lfb.26.1635178944474;
 Mon, 25 Oct 2021 09:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211014190503.717830-1-daeho43@gmail.com> <e8b106fb-2878-2fa9-788f-965eef179a85@kernel.org>
 <CACOAw_yupuz+Xx-z9V0UaExuARHd8H9rruWCa2yj5-mgkeuUtQ@mail.gmail.com> <3ddb4013-8d63-7c00-6fdd-1f21752bd60c@kernel.org>
In-Reply-To: <3ddb4013-8d63-7c00-6fdd-1f21752bd60c@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 25 Oct 2021 09:22:13 -0700
Message-ID: <CACOAw_wjhr8j=-qEDHP_H+_7cTh_ep7Wix4=JC+5x5zp-zpUFA@mail.gmail.com>
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

On Fri, Oct 22, 2021 at 8:32 AM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/10/22 0:44, Daeho Jeong wrote:
> > There is a deadlock between sb_internal lock (sb_start_intwrite()) and
> > dquot related lock.
> > It's because we call f2fs_truncate(), which eventually calls
> > dquot_initialize(), while holding sb_internal lock.
> > So, I called dquot_initialize() in advance to make the 2nd calling of
> > it in f2fs_truncate() ineffective.
> > This is similar with the thing in f2fs_evict_inode() in inode.c
>
> Well, if dquot_initialize() fails in f2fs_drop_inode(), will we still run
> into deadlock?
>

Do you think the same issue is in f2fs_evict_inode() in inode.c?
In fact, I picked up the idea from here.

        err = dquot_initialize(inode);
        if (err) {
                err = 0;
                set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
        }

        f2fs_remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
        f2fs_remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
        f2fs_remove_ino_entry(sbi, inode->i_ino, FLUSH_INO);

        sb_start_intwrite(inode->i_sb);
        set_inode_flag(inode, FI_NO_ALLOC);
        i_size_write(inode, 0);
retry:
        if (F2FS_HAS_BLOCKS(inode))
                err = f2fs_truncate(inode);
