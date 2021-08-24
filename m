Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10533F5A61
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 11:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbhHXJEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 05:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbhHXJES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 05:04:18 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C655C061757;
        Tue, 24 Aug 2021 02:03:34 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u22so43891288lfq.13;
        Tue, 24 Aug 2021 02:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tww6XVE62J265ghFTkVGXgkg5lbz4z++5Ad3DbvV2v0=;
        b=j5rQGC/VUVcFs01zA0bPZ+6T6p53CUNuDWeYLpl/I18ETzkRCMfJanVwuehBYAd/ST
         9pTFsE6vXjh6hb2Q/UpvLFiRaVlQ3FYXbaRPPWhi1jm4G2PvCgLxFKWjeA7+hwELZet2
         J6psJziUUYzpJq//CVVtEQwWBHGyHqYy3Ibcg+RxmmRkyOv+m1HRljpzEuR0N1bOvxlB
         RuQE2V5FpaVw30AeTdkHzcrg1BlTn6POuJ0vb1jTWcdbYgYixLupXbOyEsF4tJk+rHCO
         ZIXFgwfobIOrSDXyveYMI6cuRHdxIoLit91NnSU2lh1GJ1hjM+r0Wd0lqdzEV0cZ/bvZ
         V1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tww6XVE62J265ghFTkVGXgkg5lbz4z++5Ad3DbvV2v0=;
        b=Tix4v+Sksk5Bbp7Bd0ZT8vlj5qMxRc/MjF+UZWdSP1GkRckt7TsAxh03NvV2NqzKzT
         T16WzdGoJF7F8H8/8QpRKA75+KKY+hiBEDSf90foybp4/4/lI37bfXDanEOw5sbtpUH6
         YNebg7RUuQ0W3xkMZHkZASDHlE2hERVUnEP5xbj7Ig7pZrsFiDgXr8TiWqgRUJ9ihlcg
         yD0WGbzU4KDSoLWgFN39yGFUScKJWJcGKnXVIBfJBQ1XIgJ6lkNNsq9aXCOKfdNzYsne
         15HdE6LRGXredUez7WxQC+6n4k4HYhqE2qWpxmyHclnkZkBl6c1mx1D8yoLUDA4VEMbH
         5faA==
X-Gm-Message-State: AOAM5331AM0tHZ7rQRrsXzLhkVDNMMT6+D9U6qxI1/4tecfK2/lJHyKP
        uYsAUr8t1xEMviKaur2aEmo=
X-Google-Smtp-Source: ABdhPJwykt2xAx+PCjTM/YKA46NLFqqW/T+1ErGDhcJCcfeJxT2tJwGzItdj5OLURNVHE8BFKccbAw==
X-Received: by 2002:ac2:4c45:: with SMTP id o5mr2392789lfk.177.1629795812382;
        Tue, 24 Aug 2021 02:03:32 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id p1sm733035lfs.10.2021.08.24.02.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 02:03:31 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:03:30 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/3] fs/ntfs3: Fix error code in indx_add_allocate()
Message-ID: <20210824090330.fmuif7e4kku2nrli@kari-VirtualBox>
References: <20210824074932.GA13096@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824074932.GA13096@kili>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 10:49:32AM +0300, Dan Carpenter wrote:
> Return -EINVAL if ni_find_attr() fails.  Don't return success.
> 
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Good catch. It seems it is like 50/50 if this should be -ENOENT. I
just check what we do else where where !ni_find_attr().

But either way:
Reviewed-by: Kari Argillander <kari.argillander@gmail.com>

> ---
>  fs/ntfs3/index.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 6aa9540ece47..07d6dee0a4ba 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -1499,6 +1499,7 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
>  	alloc = ni_find_attr(ni, NULL, NULL, ATTR_ALLOC, in->name, in->name_len,
>  			     NULL, &mi);
>  	if (!alloc) {
> +		err = -EINVAL;
>  		if (bmp)
>  			goto out2;
>  		goto out1;
> -- 
> 2.20.1
> 
> 
