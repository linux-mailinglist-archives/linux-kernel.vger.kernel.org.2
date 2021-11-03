Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A57444386
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhKCObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhKCObI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:31:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268B9C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 07:28:32 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g10so9970151edj.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 07:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0dPJtFsyQmx1p6zgLfme+3ti9DkyTZvAvvBGtLbYdUw=;
        b=XKKLOi0EP2zhoFQEdvUxsEl0GUqiZLKWEXa3QTuIe8X+s8kFkyaFGgVgnSoEvyryY+
         a6DxAQBN4E8ThfV7Yq9LKkqaFGfe8oBBK3RyJUVOuiSBfSo1ke2dTl96prEHYHhiXDox
         uZDbVF1RD3A7Ojh/NIW2hLpU2EsmIea09GOkIGfEkmEncV1ARUCiqcEacXrl1Rgf2d/0
         xytLGqxoI6n+i0GZ7TUbaZE/MsYaWolqRestYCgNPjgOaOOpyefGFzoJP+jaRdkLQKzo
         Oh9ja1POHBCHQVMOWJKq1NtZsSAXXUvx1dFRrILn0qkUDOp7GSRFfHwXGwoy80hTKmHr
         bt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0dPJtFsyQmx1p6zgLfme+3ti9DkyTZvAvvBGtLbYdUw=;
        b=ziOYK2vvIZ0LA/iWC1lP7JWowE+waqp1XcHHcBtYxoZki6QsEKM8FEm+CRH4WfdObE
         gs2YxorOTvgSX9CvMtU3GlKs2auH1sp3OJ/WQkb/0vuI3eq2OQduH721gz30ocBQntVW
         xh0NxlmN0LDJVXVTpBzVN9/TOzxfm5EvsUAz110i6xgdEJmuF8ajngvgTap92WO+++bl
         Rhu6F7dH0LCb1cLkcW5Ix3GiMjmtYU0jK+pCmK1K9nxcfTi4rzcFJerFqmFB1q4nuOTx
         mEOsnLwgzwPlt1T8Ok7JgCoQSsoNTw9K5fSAhMan7OjcHzdb/Y27MGv4fGMNYqKTROld
         w+sg==
X-Gm-Message-State: AOAM532EtkwxVWaw43XGav6bzhBInnGADsaOiYvAo/2AVl5QkouVKM1K
        /RHrEzu3JnSsy2QT06ksJQwNC002/Lkilse0/Qs=
X-Google-Smtp-Source: ABdhPJyu6KVua4hozKtPkElw96jMvIoioFwAnl4EBS5UWHOnxCk3X2Mq1knuXwDctANVuGKs7IsBxvbK5q+HDyGPA14=
X-Received: by 2002:a17:906:3f87:: with SMTP id b7mr45813086ejj.172.1635949706385;
 Wed, 03 Nov 2021 07:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211103142228.1235864-1-mudongliangabcd@gmail.com>
In-Reply-To: <20211103142228.1235864-1-mudongliangabcd@gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Wed, 3 Nov 2021 22:28:00 +0800
Message-ID: <CAD-N9QVXNUEsHVaWUjT2eg9MLTX6SXru7JZm_z7PFQO=KPPg=A@mail.gmail.com>
Subject: Re: [PATCH] fs: f2fs: fix UAF in f2fs_available_free_memory
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 10:22 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> f2fs_fill_super
> -> f2fs_build_segment_manager
>    -> create_discard_cmd_control
>       -> f2fs_start_discard_thread
>
> It invokes kthread_run to create a thread and run issue_discard_thread.
>
> However, if f2fs_build_node_manager fails, the control flow goes to
> free_nm and calls f2fs_destroy_node_manager. This function will free
> sbi->nm_info. However, if issue_discard_thread accesses sbi->nm_info
> after the deallocation, but before the f2fs_stop_discard_thread, it will
> cause UAF(Use-after-free).

This UAF only can be triggered in a small time window. Even if
syzkaller generates a reproducer, it is hard to reproduce.

>
> -> f2fs_destroy_segment_manager
>    -> destroy_discard_cmd_control
>       -> f2fs_stop_discard_thread
>
> Fix this by switching the order of f2fs_build_segment_manager
> and f2fs_build_node_manager.
>
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  fs/f2fs/super.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 78ebc306ee2b..1a23b64cfb74 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4135,18 +4135,18 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>         }
>
>         /* setup f2fs internal modules */
> -       err = f2fs_build_segment_manager(sbi);
> -       if (err) {
> -               f2fs_err(sbi, "Failed to initialize F2FS segment manager (%d)",
> -                        err);
> -               goto free_sm;
> -       }
>         err = f2fs_build_node_manager(sbi);
>         if (err) {
>                 f2fs_err(sbi, "Failed to initialize F2FS node manager (%d)",
>                          err);
>                 goto free_nm;
>         }
> +       err = f2fs_build_segment_manager(sbi);
> +       if (err) {
> +               f2fs_err(sbi, "Failed to initialize F2FS segment manager (%d)",
> +                        err);
> +               goto free_sm;
> +       }

I am not very familiar with this filesystem. If the building of node
manager is based on segment manager,
we can ignore this patch and try to think up other solutions to fix this bug.

>
>         /* For write statistics */
>         sbi->sectors_written_start = f2fs_get_sectors_written(sbi);
> @@ -4351,10 +4351,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>         sbi->node_inode = NULL;
>  free_stats:
>         f2fs_destroy_stats(sbi);
> -free_nm:
> -       f2fs_destroy_node_manager(sbi);
>  free_sm:
>         f2fs_destroy_segment_manager(sbi);
> +free_nm:
> +       f2fs_destroy_node_manager(sbi);
>         f2fs_destroy_post_read_wq(sbi);
>  stop_ckpt_thread:
>         f2fs_stop_ckpt_thread(sbi);
> --
> 2.25.1
>
