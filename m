Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207DD3131E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhBHMMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbhBHLvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:51:22 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49416C06178A;
        Mon,  8 Feb 2021 03:50:12 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bl23so24124693ejb.5;
        Mon, 08 Feb 2021 03:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2hQUMprtetu+UvLxropQiA6dOXEkpGb4/+OXA3Y0o2E=;
        b=QKMeCXB1QLNt7s9DCwOXXLyDLXDCgN2X72vq5cR34jUvunGX4bpBduSNxPcjLmejcv
         TyToD8AWUPl5fClQUJKSlDNUKb/slnnTY8EzIMVN9ams4qqpOQS36XjPwYfq9PNPlJT9
         /TcnA9WJKPd5fIMdbAAWXFDP9QGKpNP4HHqcJZ30ni0nkN+SYbQgkCC1lCCfvXF7RoCE
         UVqxun7bYK26oO9LKR61Sc16rDewwgv8/l48ZH0o+sfkTrPzQaBJgreHmz6UIbXcLbTx
         TVn/Y8GclXvtgCRwxOVRkudEpCT0pX3WysvScSzGEDSD73ymGm1ja1lnMenp3ea8QX3W
         S6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hQUMprtetu+UvLxropQiA6dOXEkpGb4/+OXA3Y0o2E=;
        b=gWOhF3aby/R4p6FBseJ9O3rSeZPTf94MkrcB0yM75SY0Xxay8HCQ61GiiW9hCVoCs0
         yb6+pO1fg0hyYUrJvJDLQGbL7qveiS1/7WUC4qFomE5mFHmuLd9V/oAnGEk/sqY2MLO8
         226G6ii477B/1vW4WHNtONQ0Qp8pPM1IDldj6CXGmxdBQ+DASXJO0viv+D2OdwJdUVKD
         Lh4skSLrHbZUX2AUNnvKBJg/YDGVVInYL9/k4OOUwOaPYXWPjKBdQ6ytlSNKZDNsdDtc
         +K9frtIQJocXAdd/xGu3ldP52zXnjphm+PWgaY8Uzzbc3uRdRrlQgRP+z5GzW4hUdK0o
         +8zA==
X-Gm-Message-State: AOAM532V2J6fAyfliuBeHBOAX/vgYNo4urdftp/fW0NU4pFe+dcaQMZr
        bA+HbiZ45UYstPEFWeH2LQY0hp6xFZZIJ2trqfl+NmgvOECP7g==
X-Google-Smtp-Source: ABdhPJz2U5X6jzPaCYmWdfFZMTHRwfpQcvW+bJl23QVFJ6SreRILEv5d7DOyImgDssJsPUe+ZNpM0f6I0u1JnaUkQmc=
X-Received: by 2002:a17:906:af86:: with SMTP id mj6mr16528360ejb.509.1612785010950;
 Mon, 08 Feb 2021 03:50:10 -0800 (PST)
MIME-Version: 1.0
References: <1612784101-14353-1-git-send-email-konishi.ryusuke@gmail.com>
In-Reply-To: <1612784101-14353-1-git-send-email-konishi.ryusuke@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Mon, 8 Feb 2021 20:50:01 +0900
Message-ID: <CAKFNMok_h7pDFmy-h3DALawpUkTK=diHBUAGGP5eRhpMY2EUQA@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: make splice write available again
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Please send this to upstream.  This fixes a regression of splice() on nilfs2.

Thanks,
Ryusuke Konishi

On Mon, Feb 8, 2021 at 8:35 PM Ryusuke Konishi
<konishi.ryusuke@gmail.com> wrote:
>
> From: Joachim Henke <joachim.henke@t-systems.com>
>
> Since 5.10, splice() or sendfile() to NILFS2 return EINVAL. This was
> caused by commit 36e2c7421f02 ("fs: don't allow splice read/write
> without explicit ops").
>
> This patch initializes the splice_write field in file_operations, like
> most file systems do, to restore the functionality.
>
> Signed-off-by: Joachim Henke <joachim.henke@t-systems.com>
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: stable@vger.kernel.org # 5.10+
> ---
>  fs/nilfs2/file.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
> index 64bc81363c6c..e1bd592ce700 100644
> --- a/fs/nilfs2/file.c
> +++ b/fs/nilfs2/file.c
> @@ -141,6 +141,7 @@ static int nilfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>         /* .release     = nilfs_release_file, */
>         .fsync          = nilfs_sync_file,
>         .splice_read    = generic_file_splice_read,
> +       .splice_write   = iter_file_splice_write,
>  };
>
>  const struct inode_operations nilfs_file_inode_operations = {
> --
> 1.8.3.1
>
