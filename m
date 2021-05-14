Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8332A3809C0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhENMk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:40:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33229 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232812AbhENMk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620995985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EQQwhvgtwZyH320vXDMEGHFsETuo+DlrHUQlvvoka5g=;
        b=bgKZybPV4Rw+uMdJrnjZl7EFfIg8enVFhI2+HZiL53B3jfX/Qh3UE/UJc9wen0UsaBcciy
        D/P3M49QwVE3PFiXFELJuWsCNpdWTp8lF1xPkq/3qvmamOuWU6xJxHrgq6TU6FzrhjAxTS
        eAg0vHIoLHdXF6pCeBK3smMc1qzavaQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-eqwb1aeVPpO7rUJsFMItxw-1; Fri, 14 May 2021 08:39:43 -0400
X-MC-Unique: eqwb1aeVPpO7rUJsFMItxw-1
Received: by mail-qv1-f71.google.com with SMTP id w62-20020a0ca4440000b02901ebcd69b1a8so6205651qvw.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EQQwhvgtwZyH320vXDMEGHFsETuo+DlrHUQlvvoka5g=;
        b=aMPFslbiH1UVe9CEDhi1OyOM4xtfX0uMyqIvRS2U+ZWwVVZt/QJytmmy4MuF8sBDGF
         D75fht9Hy8t9cF0qPROkLZPAYWnjeiYRZ6pWQyvI6MdO5Fj0pZNsYDpEC9OBsHtnbriW
         TajNXHpF3EXBVWxOANb9OD59A+uWTtZmZ/KBkyeFIhS6E3TCwt+AUSwWrCyLt+3/EZXK
         HEl9yNF1EVK9AEPBmMRi+Pt1KlP3jP7H/6rSw61CkjPPSpQ/TBjJ2BofMt5ekoVd2wcE
         3c5s05dBuNyM3uvcNUpTezKOQLsTdT9+LFUbL0S3jLrOgSv1a26R2m5Hzx/1wNHWu3bX
         1PmA==
X-Gm-Message-State: AOAM531uh71M12vvelFKVgMEuBs7T7biO4fZNOMQgjylPvFOuwvfQxdL
        Q70e/8PxvJWHBYGLtrKlNSp3kYnsI6YvZywZckm+wCk5QJfp2W3Y57Y9DIAcW7ZIP4t4hTJb912
        EwEzwMlPAfqgnVsTJ7luNmCcK
X-Received: by 2002:a37:6554:: with SMTP id z81mr44338690qkb.472.1620995982971;
        Fri, 14 May 2021 05:39:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwANspRqzw7nWKx7YLHmSb/WHwtLfQCVEIkilF2AyBk0QH3sdSQPKDOYHKj0XSfECGrpsDU9g==
X-Received: by 2002:a37:6554:: with SMTP id z81mr44338680qkb.472.1620995982818;
        Fri, 14 May 2021 05:39:42 -0700 (PDT)
Received: from bfoster ([98.216.211.229])
        by smtp.gmail.com with ESMTPSA id z187sm4650871qkb.129.2021.05.14.05.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:39:42 -0700 (PDT)
Date:   Fri, 14 May 2021 08:39:40 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: Remove redundant assignment to busy
Message-ID: <YJ5vjIKWtrulwO6M@bfoster>
References: <1620903078-58184-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620903078-58184-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 06:51:18PM +0800, Jiapeng Chong wrote:
> Variable busy is set to false, but this value is never read as it is
> overwritten or not used later on, hence it is a redundant assignment
> and can be removed.
> 
> Clean up the following clang-analyzer warning:
> 
> fs/xfs/libxfs/xfs_alloc.c:1679:2: warning: Value stored to 'busy' is
> never read [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---

Part of me wonders whether it would be better to still initialize the
variable where it's defined, assuming that would quiet the code analyzer
(?). Not a big deal either way:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/libxfs/xfs_alloc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> index 82b7cbb..ae46fe6 100644
> --- a/fs/xfs/libxfs/xfs_alloc.c
> +++ b/fs/xfs/libxfs/xfs_alloc.c
> @@ -1676,7 +1676,6 @@ struct xfs_alloc_cur {
>  	cnt_cur = xfs_allocbt_init_cursor(args->mp, args->tp, args->agbp,
>  		args->agno, XFS_BTNUM_CNT);
>  	bno_cur = NULL;
> -	busy = false;
>  
>  	/*
>  	 * Look for an entry >= maxlen+alignment-1 blocks.
> -- 
> 1.8.3.1
> 

