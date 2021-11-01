Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D000B441B0C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 13:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhKAMVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 08:21:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51640 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbhKAMU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 08:20:59 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8389421961;
        Mon,  1 Nov 2021 12:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635769105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Aad6eh3RU/jGafrYnv3On/vgmZ9qPNQxMpxL+Nx8Lzc=;
        b=0vFPtW958C77sXHu+rUEfymZVys8hqpi+fT6CapDyOl1XkgmMrcqvwGxb1voP/pvczJXmr
        uPDFnCxLutLMvDoOQ8Ry4I52cPaQ780yjlHt74Abx7o7t98sV5vY6c4aoJ1GyFleqr21oI
        gw4XZBWP/8rM1S0tbOBzVtX85rjsnhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635769105;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Aad6eh3RU/jGafrYnv3On/vgmZ9qPNQxMpxL+Nx8Lzc=;
        b=ajSWBlxyyKSz01mEMrvxFBOB+GrD65gCqgVPtIzYL45WjfhH3DqygalgQ3tgRp/94GD9To
        nJb400vOtuUmjDBA==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 31ACDA3B84;
        Mon,  1 Nov 2021 12:18:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8EF341E0922; Mon,  1 Nov 2021 13:18:19 +0100 (CET)
Date:   Mon, 1 Nov 2021 13:18:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     cgel.zte@gmail.com
Cc:     jack@suse.cz, zhang.mingyu@zte.com.cn, krisman@collabora.com,
        amir73il@gmail.com, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] samples: remove duplicate include in fs-monitor.c
Message-ID: <20211101121819.GD21679@quack2.suse.cz>
References: <20211101075152.35780-1-zhang.mingyu@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101075152.35780-1-zhang.mingyu@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01-11-21 07:51:52, cgel.zte@gmail.com wrote:
> From: Zhang Mingyu <zhang.mingyu@zte.com.cn>
> 
> 'sys/types.h' included in 'samples/fanotify/fs-monitor.c'
> is duplicated.It is also included on 15 line.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>

Thanks. I've added the patch to my tree.

									Honza

> ---
>  samples/fanotify/fs-monitor.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/samples/fanotify/fs-monitor.c b/samples/fanotify/fs-monitor.c
> index a0e44cd31e6f..0a5f742a77a8 100644
> --- a/samples/fanotify/fs-monitor.c
> +++ b/samples/fanotify/fs-monitor.c
> @@ -12,7 +12,6 @@
>  #include <sys/fanotify.h>
>  #include <sys/types.h>
>  #include <unistd.h>
> -#include <sys/types.h>
>  
>  #ifndef FAN_FS_ERROR
>  #define FAN_FS_ERROR		0x00008000
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
