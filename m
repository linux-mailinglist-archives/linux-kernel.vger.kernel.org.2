Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5519932BDF4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385031AbhCCQk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:40:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234646AbhCCMHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:07:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25F056148E;
        Wed,  3 Mar 2021 12:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614773195;
        bh=LLxjeivOlnK1I7vYA6dpUWq+M3OE00MAiU+GvR9rVkw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z+88v9hVHb+j/C2U4QnnFuccsYx5jaACZhOdi+OYHwU1YtvPpCp3DNVi2LkE7YUzP
         k2Z5vb4+LcLBMBcUITBSolwj/7WgFXrRdv/iLBqFSafvGXYu5p2mp8DjLjyjXDL6IW
         sb0eDDDNODDZCf5DkS2agbmV3oWcjobcSvsfiXLsipE2hmxM2f24v23GG3sguCiQ9p
         vflSJLt59flFjGlwnY7MxAzt1UL0YEc1q5XQW4DPXDN97n7Az/Id16p4bg3T2DoBH5
         Jigge6niBpce7I3on/cyQcVgsAcSmnpNeVjmylfFYY8gHHNE7P/0XzjmK5lyfu9Is7
         n/MuDd86q7+jA==
Received: by mail-lj1-f171.google.com with SMTP id p15so19380061ljc.13;
        Wed, 03 Mar 2021 04:06:35 -0800 (PST)
X-Gm-Message-State: AOAM53196E/mXouBRXKeLX37VL0cVOE9D6npZIxgF8nj3AW+3YI5LSW9
        /UVQaVBH0GQGKde2BinzIV1g/ukXVJQr9br9WzQ=
X-Google-Smtp-Source: ABdhPJztGn+/1FbW6Bs9appTQ/KNmSvi+QrDcPxVpPJOWvSNN5ODcWjU5SY+33uadcXTnhFyhcJM6tN63331W1ItBBY=
X-Received: by 2002:a2e:994e:: with SMTP id r14mr15169293ljj.115.1614773193338;
 Wed, 03 Mar 2021 04:06:33 -0800 (PST)
MIME-Version: 1.0
References: <20210303080410.178702-1-zhang.yunkai@zte.com.cn>
In-Reply-To: <20210303080410.178702-1-zhang.yunkai@zte.com.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 3 Mar 2021 20:06:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRGyOV_14TjHrW6FAXAE0h56Nos+3PbaAOu_WHSQyTasw@mail.gmail.com>
Message-ID: <CAJF2gTRGyOV_14TjHrW6FAXAE0h56Nos+3PbaAOu_WHSQyTasw@mail.gmail.com>
Subject: Re: [PATCH] module: remove duplicate include in arch/csky/kernel/entry.S
To:     menglong8.dong@gmail.com
Cc:     linux-csky@vger.kernel.org, zhang.yunkai@zte.com.cn,
        jiulong@linux.alibaba.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx, looks good for me.

On Wed, Mar 3, 2021 at 4:04 PM <menglong8.dong@gmail.com> wrote:
>
> From: Zhang Yunkai <zhang.yunkai@zte.com.cn>
>
> 'asm/setup.h' included in 'arch/csky/kernel/entry.S' is duplicated.
>
> Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> ---
>  arch/csky/kernel/entry.S | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
> index c1bd7a6b4ab6..00e3c8ebf9b8 100644
> --- a/arch/csky/kernel/entry.S
> +++ b/arch/csky/kernel/entry.S
> @@ -9,7 +9,6 @@
>  #include <asm/unistd.h>
>  #include <asm/asm-offsets.h>
>  #include <linux/threads.h>
> -#include <asm/setup.h>
>  #include <asm/page.h>
>  #include <asm/thread_info.h>
>
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
