Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEC2424166
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhJFPfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhJFPfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:35:12 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5C4C061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 08:33:20 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id 66so3336204vsd.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OXGlnNe1yWBSvNniecAJQ/P9MoZJY33TkoAKPrbYOnw=;
        b=hA1vk31Bhomcl0BX+2n4o1WOeiN/pLWbs/c79v0uZf04LtAu686+SXWgXbe/RDCfJo
         kfC8USdT7zxYZS2Jo9c0t57CZzmdZQt8Ydtax4fNW4v3ehrYS23mMWo/TbevMVGvt00q
         x6WbVkjN6p1MKRQ4u7UHz9vDf0OIYuEGqbt9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OXGlnNe1yWBSvNniecAJQ/P9MoZJY33TkoAKPrbYOnw=;
        b=gm1dYS/CQYx9N2H2Uy5pjrvORTnQOSrvkQv7G60SqAvz/y0xRsMjwux71OXI3sR5dX
         8VYRQm0Vvj7D9lp0RcsbsofmJfzc/uxWnBW0FUQIuQwYzp6oqzuE/f9WLdfBBxoLn2S1
         JoIH06O4O2UZ/I3App5N7DRdznGEeXX2bv78TZb2DMkzvlVK3qcY3cg807BN/1zImLTF
         mbF52Kss/crcd2arGHjtp2pn17BrCHDvaqGc4wO0gzUODm6tESLy9+iPo9aTBbyax5k/
         eKEwD9sI+tJ9QYu/W9++ZHPeRSUajtvToNouhJV510ZWbBCdRTYuy3MdmmVUQgZ3ahxA
         Fovw==
X-Gm-Message-State: AOAM530Kegix3koCmcW9r0QKvD9m3YCj9RDLRq19eKoIzNtTCVtyjTtY
        dHrcl7SPT7TrCMxlWbisdOb6UWEdVpggp15iyewbxA==
X-Google-Smtp-Source: ABdhPJwiOjGX+elH6RoLYAfpIz6u9FQCAwQ90zgFM4YeOO/PwbB6PfGge44MGahOyC2VIBg+9pkmElcw9HXzY6DUn7A=
X-Received: by 2002:a67:c284:: with SMTP id k4mr6631340vsj.24.1633534399452;
 Wed, 06 Oct 2021 08:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210923130814.140814-1-cgxu519@mykernel.net> <20210923130814.140814-4-cgxu519@mykernel.net>
In-Reply-To: <20210923130814.140814-4-cgxu519@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 6 Oct 2021 17:33:08 +0200
Message-ID: <CAJfpegvh9if1tZOdnzn87JmDBZC0XBzf63NoOydkCGyX4ssaag@mail.gmail.com>
Subject: Re: [RFC PATCH v5 03/10] ovl: implement overlayfs' ->evict_inode operation
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sept 2021 at 15:08, Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> Implement overlayfs' ->evict_inode operation,
> so that we can clear dirty flags of overlayfs inode.
>
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  fs/overlayfs/super.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 51886ba6130a..2ab77adf7256 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -406,11 +406,18 @@ static int ovl_remount(struct super_block *sb, int *flags, char *data)
>         return ret;
>  }
>
> +static void ovl_evict_inode(struct inode *inode)
> +{
> +       inode->i_state &= ~I_DIRTY_ALL;
> +       clear_inode(inode);

clear_inode() should already clear the dirty flags; the default
eviction should work fine without having to define an ->evict_inode.
What am I missing?

Thanks,
Miklos
