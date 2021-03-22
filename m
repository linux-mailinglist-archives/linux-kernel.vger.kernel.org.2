Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E07344646
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhCVNyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhCVNxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:53:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC7DC061574;
        Mon, 22 Mar 2021 06:53:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ce10so21394502ejb.6;
        Mon, 22 Mar 2021 06:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jX+u5Il9FFhVYVkW7pqj87Zsgj9Bh++s3plZJeOI0WY=;
        b=hk+rgIeZOPySzG9QtpoGzMDEqiX2FMsNn4x3rUJDuDx5L2WaUSALAlEamYlUEaQlgb
         122ANDd3eRDzVT0Ts0BLOM7Kvva6Cm5e+WuyM/8bx8PYu7yjkDLnodqUYR9sy2KAdqkv
         4RC8BV3lJWIfECmh7BjSvJYNiX8+dwm2unJAYl+vj2Fe+yg9gMxTD3U6n2nTnj+gYJoK
         KCtJ+n7uFUIqqM1LMeXqUqXpO2oTFskbTdFqn2dOd4dFwGlcZOIBO0eJMp5nraY0wWWk
         7HekceiaqNoc/nduHmntKFQ/MaUqqOmdYumClqvAQhKhjZQlORZPCgMIW3AtqisExNpB
         /Adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jX+u5Il9FFhVYVkW7pqj87Zsgj9Bh++s3plZJeOI0WY=;
        b=jfpl0LBU5EUAb5Jnf1zHV/XtuGU4BjoT4qhYrHaaVHzeKxSFUjuShZHUf9vEuhtsjt
         TIZrIa5aP1MDGufF7e9u7fuc6shLMbAxZjpgs4z+vWO5i4JqEHhpZXDxUwOidiAdOwdz
         kIdncX22+DPbfYSemPlKhunmQkgtCB4CFxWyl8BmkAfePetg86OYLZ1GZDMWn7/9lIE9
         cucmFLuy4ByEi/XyL8fyrwXl7MLylNH9kqEM5gizjCL3DVhijJ4IOkL0lPh92u+WdwTX
         TsqAc0uXUuecuRGD5wa4yCCAugkIM14sRvL0N8ad3tfXWZi7xfpq4z98md4rgI3NAd4l
         ccNA==
X-Gm-Message-State: AOAM533BUm9LJyIvxQkjn2J9LvZ9gbvMWOjVgVn0ZBZFMwV7NQj+iCfH
        NeRNnhMazPnxw2jp3UTt6P1dNr7fWstSKA+DBKQ=
X-Google-Smtp-Source: ABdhPJxkeZ7V6qpSEcD74vXBI62+IR3JRYPyq9TL1I8FFDD5uz7YVBVvWyuAMW6uHWzFdj4fWXlZW8S1q927HDHleI4=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr19483582ejq.1.1616421225620;
 Mon, 22 Mar 2021 06:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210318113233.473329-1-liu.xuzhi@zte.com.cn>
In-Reply-To: <20210318113233.473329-1-liu.xuzhi@zte.com.cn>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Mon, 22 Mar 2021 22:53:31 +0900
Message-ID: <CAKFNMo=ME1jw3ZexLjP4MkU3AzHJebjiDB+WhZ_25CTYdm6C8g@mail.gmail.com>
Subject: Re: [PATCH] fs/nilfs2: fix misspellings using codespell tool
To:     menglong8.dong@gmail.com
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Liu xuzhi <liu.xuzhi@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied, thank you.

Ryusuke Konishi

On Thu, Mar 18, 2021 at 8:32 PM <menglong8.dong@gmail.com> wrote:
>
> From: Liu xuzhi <liu.xuzhi@zte.com.cn>
>
> Two typos are found out by codespell tool \
> in 2217th and 2254th lines of segment.c:
>
> $ codespell ./fs/nilfs2/
> ./segment.c:2217 :retured  ==> returned
> ./segment.c:2254: retured  ==> returned
>
> Fix two typos found by codespell.
>
> Signed-off-by: Liu xuzhi <liu.xuzhi@zte.com.cn>
> ---
>  fs/nilfs2/segment.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index cd4da9535aed..686c8ee7b29c 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -2214,7 +2214,7 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err)
>   * nilfs_construct_segment - construct a logical segment
>   * @sb: super block
>   *
> - * Return Value: On success, 0 is retured. On errors, one of the following
> + * Return Value: On success, 0 is returned. On errors, one of the following
>   * negative error code is returned.
>   *
>   * %-EROFS - Read only filesystem.
> @@ -2251,7 +2251,7 @@ int nilfs_construct_segment(struct super_block *sb)
>   * @start: start byte offset
>   * @end: end byte offset (inclusive)
>   *
> - * Return Value: On success, 0 is retured. On errors, one of the following
> + * Return Value: On success, 0 is returned. On errors, one of the following
>   * negative error code is returned.
>   *
>   * %-EROFS - Read only filesystem.
> --
> 2.25.1
>
