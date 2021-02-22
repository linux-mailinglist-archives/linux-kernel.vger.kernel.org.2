Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6BA320F36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 02:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhBVBlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 20:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhBVBlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 20:41:10 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75181C061786
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 17:40:30 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z5so2455952pfe.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 17:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Pmfn8f/i9TumuS4aSYkIvZo4/H99mKopifdoxhuUtdg=;
        b=T60i5xmqABV5ARr6WaanBLU2cGHolVYLPmE8mrIYt8SPrVLMMpkuxwYiviwuc+L/u/
         C2gaolDpezEK6fLu0XlDVV8E0WMSwzTrsCT/Wshcx36Yjszf+UlIJRa4va6+DbG31ldw
         14kfSmTnvfkgCJYqH1/jrOwaHT8u6AA+kA3TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Pmfn8f/i9TumuS4aSYkIvZo4/H99mKopifdoxhuUtdg=;
        b=dwnjswAAtBlljtku3/b3sr+Kuap/tqagbe4gBRUvc1qUO9NLlVESm2J3R5LjVB0moZ
         z+sSMukTOGgoG1JilEadtGS7G7I4otV70VgCX5swUCCuLtJJ3XMxZfYm/gUG6vBhJ1ZC
         q7ocrAP3WpVsV/gOFt+Sz4cr1JX6qfp6imU+3HUDgXjIBsj9Yg5CZRQjlGvUEXNSva9g
         3vgoGHBXb/EI0yar4FgFw0RYck/kZ4fFDk0sFd5gbyMe0v3tRiUqOFyDYkI4rXMgdr72
         mMafoqTEyHTHhRHaHS1+FOtUJUAL8ca2AH8Ml926LFaR2IgtDpwUTc4A7O8Pg2eHccUs
         Xp7g==
X-Gm-Message-State: AOAM533Y6y0UaJvNKO4gDW9hrqAfAcDjrnIbl7fzAYwnJlg1ZrRANpQt
        V7GQzlDBejUzU/qzzyFw9hWwjjUcscvGS6kz
X-Google-Smtp-Source: ABdhPJxtyPWEO8BWjW1Faie4bC1Bqwm2iJDW3XPcs1fWp5czZ1Gt1y7cs6vsAEeh8RmiztWxGvI7Ww==
X-Received: by 2002:a65:6a4b:: with SMTP id o11mr17970000pgu.138.1613958030061;
        Sun, 21 Feb 2021 17:40:30 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-c141-3594-a9dc-6972.static.ipv6.internode.on.net. [2001:44b8:1113:6700:c141:3594:a9dc:6972])
        by smtp.gmail.com with ESMTPSA id v1sm19889837pfi.99.2021.02.21.17.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 17:40:29 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Yang Li <yang.lee@linux.alibaba.com>, mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH] powerpc: use ARRAY_SIZE instead of division operation
In-Reply-To: <1613808853-78381-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1613808853-78381-1-git-send-email-yang.lee@linux.alibaba.com>
Date:   Mon, 22 Feb 2021 12:40:26 +1100
Message-ID: <87blccq3qt.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

> This eliminates the following coccicheck warning:
> ./arch/powerpc/boot/mktree.c:130:31-32: WARNING: Use ARRAY_SIZE
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/powerpc/boot/mktree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/boot/mktree.c b/arch/powerpc/boot/mktree.c
> index dc603f3..0b2def5 100644
> --- a/arch/powerpc/boot/mktree.c
> +++ b/arch/powerpc/boot/mktree.c
> @@ -127,7 +127,7 @@ int main(int argc, char *argv[])
>  			exit(5);
>  		}
>  		cp = tmpbuf;
> -		for (i = 0; i < sizeof(tmpbuf) / sizeof(unsigned int); i++)
> +		for (i = 0; i < ARRAY_SIZE(tmpbuf); i++)

Unfortunately this breaks the build - see
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/1613808853-78381-1-git-send-email-yang.lee@linux.alibaba.com/

This is because 'boot/mktree.c' is a userspace program without access to
the usual kernel headers.

It might be best to get coccicheck to exclude all of
'arch/powerpc/boot/' as I believe everything in that directory is
compiled differently to the rest of the kernel (see the Makefile), but
maybe just blacklisting boot/mktree.c would be sufficient.

Kind regards,
Daniel

>  			cksum += *cp++;
>  		if (write(out_fd, tmpbuf, sizeof(tmpbuf)) != sizeof(tmpbuf)) {
>  			perror("boot-image write");
> -- 
> 1.8.3.1
