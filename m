Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59F13FD774
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 12:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbhIAKQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 06:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhIAKQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 06:16:29 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DDEC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 03:15:33 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id i28so3963015ljm.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 03:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/fuYYQPwwc9lxu6aFrHWoaVfahwS83ADwA1H13S65uQ=;
        b=cTYyTaa9U4T1VroyNRDbBR5WRh600i20UnSu+9qEJBXgH3CbcdT1w048vVlecB8T49
         ogFWax2OJ2uKK1K/JCxLQi/gxtAITz1UG+5RcvZ+AsaN7UhBit68VH9h7RFPm8FdUIRU
         1c/Mb3PxnE5aqSvIwXOOb4uJqDm5k3nLawA3crIL2Xz8XbbKvb+Tb/WXA4zXnBQrH8JG
         i2cMEL8+mztS08lcKv/SNcUnZ3w74yyounnSnq5OMlxuePJS87PGlktCwYcr0cvPdGkq
         pkUwf3n3DlFhjTX5uAaLucObbLZ/G4CKe0hFPm3KIekKojMaskhGM0MNqlPCaNnjM1H3
         3pLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/fuYYQPwwc9lxu6aFrHWoaVfahwS83ADwA1H13S65uQ=;
        b=dRSZJRWubpkQ11V5jjOzJgr5luDR7iCyzfVyP69DX7NgHDYxREkGkscy/Z5emLHlx5
         Ili+TtAHY+9PPF+c4Y6kKtMwKBM5nmj7ed3LId9MMiT0WHBmiMS9ZF+M8j3iJKXv3Zyy
         cbw/3uuDqiPlaVqWOWS+Rjvd8Ve3ellddGABaAUB+J/mIfLte6zWTuYBY/4q++MRnLL7
         cVTJruhM3brIGaqatHPOgr9RghbCYTOps+jA3JsuR+bJY8xaOJDumME72FEZN5sYR2Vt
         HUYw3xfjflUeaWxOF8VtlObkhU7LzP54rlooXafX8RinOLCATLRBMNiQzJHrUaiSBWkd
         n8pg==
X-Gm-Message-State: AOAM531j6SYmWsBHunCeiJqbljVkg8yFTQDUb0QOnyVObH2zTMQIq8UT
        x/4dAYMSttqc1auFVGT3MYU=
X-Google-Smtp-Source: ABdhPJwE6iYU6bK2hCoigwhmMO/AUPiQWZQUyYPZ0HTdh6kZ7Zuqt3DtV7EKE0ya3YtEYuSMSVvjPw==
X-Received: by 2002:a2e:1556:: with SMTP id 22mr28517413ljv.253.1630491331375;
        Wed, 01 Sep 2021 03:15:31 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.229.213])
        by smtp.gmail.com with UTF8SMTPSA id r199sm1653509lff.266.2021.09.01.03.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 03:15:30 -0700 (PDT)
Message-ID: <dc7771f0-e4db-ee5c-a66d-b5db5f26a59d@gmail.com>
Date:   Wed, 1 Sep 2021 13:15:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] sysv: use BUILD_BUG_ON instead of runtime check
Content-Language: en-US
To:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org
References: <20210813123020.22971-1-paskripkin@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20210813123020.22971-1-paskripkin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/21 15:30, Pavel Skripkin wrote:
> There was runtime checks about sizes of struct v7_super_block
> and struct sysv_inode. If one of these checks fail kernel will panic.
> Since these values are known on complite time let's use BUILD_BUG_ON(),
> because it's standard mechanism for validation checking at build time
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>   fs/sysv/super.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/sysv/super.c b/fs/sysv/super.c
> index cc8e2ed155c8..d1def0771a40 100644
> --- a/fs/sysv/super.c
> +++ b/fs/sysv/super.c
> @@ -474,10 +474,8 @@ static int v7_fill_super(struct super_block *sb, void *data, int silent)
>   	struct sysv_sb_info *sbi;
>   	struct buffer_head *bh;
>   
> -	if (440 != sizeof (struct v7_super_block))
> -		panic("V7 FS: bad super-block size");
> -	if (64 != sizeof (struct sysv_inode))
> -		panic("sysv fs: bad i-node size");
> +	BUILD_BUG_ON(sizeof(struct v7_super_block) != 440);
> +	BUILD_BUG_ON(sizeof(struct sysv_inode) != 64);
>   
>   	sbi = kzalloc(sizeof(struct sysv_sb_info), GFP_KERNEL);
>   	if (!sbi)
> 

Hi, David and Alexander!


Maybe, this one can go through one of your trees? I didn't find any sysv 
related trees, so..

Lore link to the patch: 
https://lore.kernel.org/lkml/20210813123020.22971-1-paskripkin@gmail.com/



Thank you!


With regards,
Pavel Skripkin
