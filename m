Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0F138927B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354669AbhESPY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346703AbhESPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:24:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD42C061761
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:23:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l4so20522536ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2kcMHiUdBh2RX9lqzPjQo7AnDIczfIylBe4oy/anXE4=;
        b=Ozr9QX2vejijzqnJiHLv3IEed5XqEa5tCvrp4GWhBWSBVsToH+RmYdiIwm3uQ8Rd1+
         J9PuijBn2eRbEI1jVMnt5WZfi9ziUoMOy8uc2Q3VD6SCdOC3t9t8qoBn2Q44BZ7jr48e
         F892B/DS76Lcor5RWCGtbq2A8vth6kTdpxuk/rjirPcFFbSRhoZN8miOTdA1a4gxo1zI
         Cj8Wp039/MPhSS4QXTAfFJLdQCGuF65cX8GOrtTFFgaoqT21vCWGJW9hqVlc89YiWNgq
         sj8FkAItA82GtRljXobNcFgKBEJsiwslTzt1OKqLOCeZnCjIHmQN8zEvGocBnYyFVZfL
         5u+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2kcMHiUdBh2RX9lqzPjQo7AnDIczfIylBe4oy/anXE4=;
        b=eZCjVOPpkgzjwpjy/HqhgX0RGnRr1vGVflirmEnrPVhMfve/iDypXLvAN96sMiw49Z
         Hy95NSpUUASPb1xSzYoyxTZ8YL6z6qYlkFYpGcEENmeb7BFJu0Qd2pq86Sup8ifL4UKX
         BdTUj44wqmqvv/Udg8vWcorlCXWcg65wghJ4epv8leJtIXY76dIwHrK46PYCBiNJUsQk
         xIFYKfFBzBwI1yxCpE3xxlBB7cEcC0UQ8e/Fb9e9vEGhYlIKHM6/r6bPOzhjNYy9ajQH
         2al42tgEsc5RiS/pZxgju29qw7YlpTKQ1sdxquH1uJDmlaPJhoA9rqcebZx0bkrTFVFS
         as0w==
X-Gm-Message-State: AOAM5305cN1D7JMpS3zXgkpIGKCa+Tkq0b7Ug/QTB+o7FFDt9oJeqhSo
        NjXeWMQjMgEQArXN6AounNzZLdo2lerzD0eTdUbd
X-Google-Smtp-Source: ABdhPJyfh/Fy9DHSztbus3l4CzHOkkEYqRjXK6/08Yh4J+xdsoExgFRhQ+pqMygupCb94lvG9QjZu3YfmHF5IUWHWmE=
X-Received: by 2002:a17:906:840c:: with SMTP id n12mr13191151ejx.431.1621437782490;
 Wed, 19 May 2021 08:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210519113058.1979817-1-memxor@gmail.com> <20210519113058.1979817-2-memxor@gmail.com>
In-Reply-To: <20210519113058.1979817-2-memxor@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 May 2021 11:22:51 -0400
Message-ID: <CAHC9VhTBcCJ1TfvB-HbzrByroeqfFE-SF_REik9PDSdqmJbuYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: anon_inodes: export anon_inode_getfile_secure helper
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     io-uring@vger.kernel.org, Pavel Emelyanov <xemul@openvz.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 7:37 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> This is the non-fd installing analogue of anon_inode_getfd_secure. In
> addition to allowing LSMs to attach policy to the distinct inode, this
> is also needed for checkpoint restore of an io_uring instance where a
> mapped region needs to mapped back to the io_uring fd by CRIU. This is
> currently not possible as all anon_inodes share a single inode.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  fs/anon_inodes.c            | 9 +++++++++
>  include/linux/anon_inodes.h | 4 ++++
>  2 files changed, 13 insertions(+)

[NOTE: dropping dancol@google as that email is bouncy]

> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index a280156138ed..37032786b211 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -148,6 +148,15 @@ struct file *anon_inode_getfile(const char *name,
>  }
>  EXPORT_SYMBOL_GPL(anon_inode_getfile);

This function should have a comment block at the top similar to
anon_inode_getfile(); in fact you can likely copy-n-paste the bulk of
it to use as a start.

If you don't want to bother respinning, I've got this exact patch
(+comments) in my patchset that I'll post later and I'm happy to
give/share credit if that is important to you.

> +struct file *anon_inode_getfile_secure(const char *name,
> +                                      const struct file_operations *fops,
> +                                      void *priv, int flags,
> +                                      const struct inode *context_inode)
> +{
> +       return __anon_inode_getfile(name, fops, priv, flags, context_inode, true);
> +}
> +EXPORT_SYMBOL_GPL(anon_inode_getfile_secure);

-- 
paul moore
www.paul-moore.com
