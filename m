Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798433603EB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhDOIJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhDOIJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:09:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74585C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:09:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id 12so22388458wrz.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r539wDRoUWCqGE4SMxekTv81fGTU0T4K3IYbNHZC8fM=;
        b=LdsMB4uUMPJGGMruUYIA0HpfSRGJ/+96JTWnPcrQAAb9p/738p/JAvLfgnmA+1xcSA
         SoUku4zBsB77mForVKah3mG71Vbv/WXzPpYauK2D8wKqEQofYR5qAzdQ7PSVRNBgSH6B
         GGOc7gObavuCuT7+VfQFp3h6MVU48THMA7JbosrGiVnVJIFH3OvhxDFnvpmLRmcg7VdE
         cTf1EFMTz90+5nSh2fPU6lyF5N8p2pKgzFB55a3cs3kZpJP93fLJw0xMdiZKOF7bH9xj
         EWsLfhMG5E34b4sTDlOrQUW4FGoZ5SHOmyxT+CWaTexjgxe8TggbqBkeqiq2F2+5mGZv
         8xwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r539wDRoUWCqGE4SMxekTv81fGTU0T4K3IYbNHZC8fM=;
        b=Ve8xE4FMU6WAFo3RfKlZtUWY81xxhNCZTEGIxMYynT47PDxrH1kbLeOKi7h+Jwi81L
         wCQMiX3UviWoUCRGNmGFDKAMqrlz1rAMXUUKj5Pfiol5+05O1yZR86MQw4jkLcLQOIiP
         KFXvUjB0a3HF/3mBU8LLQnXe/Cq40k7zWYqkPxA6jSon49ZPRMKvQmugjFRZfbGyJztT
         Xm50aae1XhEtIMjX9fOagch8hSL9lenZIl6gGhS2mRQJ2bIUCOWis8uv9NAYMAOxDxOz
         Yb7YOG0f49XRTFpZavdnkSvd0pLNCvRjR5fsIMzAibe70blWumTGPnlUYb/0fkT0FNcT
         u1lA==
X-Gm-Message-State: AOAM533w2QLfXBQPBf3kFklhPjU5lvUaVYpqeiN1/Hb+aVnAkFN7pZ8o
        wgfti15/jidsoK7UfLm6uTg=
X-Google-Smtp-Source: ABdhPJyPTKVMUbDHaz7Bdx/2kTDguSlQ6LWNgr/7PZLSe/reNzX6dXd3pLbXDwkx7qQxhKb42ypluQ==
X-Received: by 2002:a05:6000:1249:: with SMTP id j9mr2041670wrx.416.1618474172189;
        Thu, 15 Apr 2021 01:09:32 -0700 (PDT)
Received: from agape.jhs ([5.171.72.223])
        by smtp.gmail.com with ESMTPSA id d5sm2248845wrx.0.2021.04.15.01.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 01:09:31 -0700 (PDT)
Date:   Thu, 15 Apr 2021 10:09:29 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 15/57] staging: rtl8723bs: core: rtw_security: Demote
 non-conformant kernel-doc header
Message-ID: <20210415080928.GA1431@agape.jhs>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
 <20210414181129.1628598-16-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414181129.1628598-16-lee.jones@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 07:10:47PM +0100, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  from drivers/staging/rtl8188eu/core/rtw_security.c:10:
>  drivers/staging/rtl8188eu/core/rtw_security.c:478: warning: Function parameter or member 'p1k' not described in 'phase1'
>  drivers/staging/rtl8188eu/core/rtw_security.c:478: warning: Function parameter or member 'tk' not described in 'phase1'
>  drivers/staging/rtl8188eu/core/rtw_security.c:478: warning: Function parameter or member 'ta' not described in 'phase1'
>  drivers/staging/rtl8188eu/core/rtw_security.c:517: warning: Function parameter or member 'rc4key' not described in 'phase2'
>  drivers/staging/rtl8188eu/core/rtw_security.c:517: warning: Function parameter or member 'tk' not described in 'phase2'
>  drivers/staging/rtl8188eu/core/rtw_security.c:517: warning: Function parameter or member 'p1k' not described in 'phase2'
>  drivers/staging/rtl8723bs/core/rtw_security.c:1937: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/staging/rtl8723bs/core/rtw_security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> index 9587d89a6b24e..60b724729900e 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -1921,7 +1921,7 @@ const u8 rcons[] = {
>  	/* for 128-bit blocks, Rijndael never uses more than 10 rcon values */
>  };
>  
> -/**
> +/*
>   * Expand the cipher key into the encryption key schedule.
>   *
>   * @return	the number of rounds for the given cipher key size.
> -- 
> 2.27.0
> 
> 

Hi,

did you mean 'demote' in subject line?

thank you, 

fabio
