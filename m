Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E948347C97
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbhCXP3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbhCXP2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:28:48 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFAEC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:28:47 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id 124so11548890vsg.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NHvGbYgx7b1RA6FmsOP8tSsmUCY02pADy0trvYTHY0=;
        b=Ni17SpFn+MHIRNHkQruS/T4D01kccEYuS1VGVWvhUFGIxPF6cNunGVKej99/TTv66N
         rRd+2IuFUYYcFogK6OpwCrATkxASKiQuF9SdJFvNj0g4bxP/xo8MHb+Qe9m9yzSWzHIO
         6uc060B+dkyTBVeT9pRvxFq54f7Y/id0AzsOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NHvGbYgx7b1RA6FmsOP8tSsmUCY02pADy0trvYTHY0=;
        b=RmIod9O8IxBY7fDDYbcUByf6ytUw9dd1zeo7t16IMfuBAYGm7k0hE3gHj+12jE6eOc
         lo70EhVjR4xTCE4h5qv9aBLzmGHE2qjPN60JGPOWhKlTQWcG5ix3Y8PMJQL7d8KvEPN3
         5Lohi3Qf7DJlGYcA9LIuaO00TZpxNHUQtgVjuBTeGPM4LEc5D5a9LzpY0GQQmd275qVB
         bHv1A4D4c+8KBqMQiX0JK3wmDzpBgYBOso+0t5D95jKl3bm25EHmDoHhE/5wDW4dIkPF
         I/YttRjfPWPewltZJLhC/09zwTiUa+BRZakeCcjXLTHrLy/nK3/jj3865fzdfldTSesh
         WGmA==
X-Gm-Message-State: AOAM531bvi5211+LAtF6ascU25uv/yceoTRScGzbbbYtzhqCBlB/5zns
        1H0efHtCEw3Vcq3uinHwogPwlJvYv1RpvpDENEflvw==
X-Google-Smtp-Source: ABdhPJypo5mguqcKmrfbRVTfusFg40r0RpKqq+WuMf/7hd202BJ0Yn8umi/XUbsZiZBgnu/Q/FMMigyFtCADvMstGFw=
X-Received: by 2002:a67:8793:: with SMTP id j141mr2327094vsd.7.1616599726875;
 Wed, 24 Mar 2021 08:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210202040830.26043-1-huangjianan@oppo.com>
In-Reply-To: <20210202040830.26043-1-huangjianan@oppo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 Mar 2021 16:28:35 +0100
Message-ID: <CAJfpegsbORd5hDhnth5qY1aP-6AZDMe9f9+CyWVhvpEmHPnuwQ@mail.gmail.com>
Subject: Re: [fuse-devel] [PATCH] fuse: avoid deadlock when write fuse inode
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     linux-kernel@vger.kernel.org, guoweichao@oppo.com,
        zhangshiming@oppo.com, linux-fsdevel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        =?UTF-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 5:41 AM Huang Jianan via fuse-devel
<fuse-devel@lists.sourceforge.net> wrote:
>
> We found the following deadlock situations in low memory scenarios:
> Thread A                         Thread B
> - __writeback_single_inode
>  - fuse_write_inode
>   - fuse_simple_request
>    - __fuse_request_send
>     - request_wait_answer
>                                  - fuse_dev_splice_read
>                                   - fuse_copy_fill
>                                    - __alloc_pages_direct_reclaim
>                                     - do_shrink_slab
>                                      - super_cache_scan
>                                       - shrink_dentry_list
>                                        - dentry_unlink_inode
>                                         - iput_final
>                                          - inode_wait_for_writeback

On what kernel are you seeing this?

I don't see how it can happen on upstream kernels, since there's a
"write_inode_now(inode, 1)" call in fuse_release() and nothing can
dirty the inode after the file has been released.

Thanks,
Miklos
