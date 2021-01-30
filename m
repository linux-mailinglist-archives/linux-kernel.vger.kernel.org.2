Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DE7309770
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 18:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhA3R6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 12:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhA3R6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 12:58:34 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3932C0613D6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 09:57:53 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id a77so13857809oii.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 09:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uJmNgXIJjv7e9QEtfn932MJG6jZkrOHVgpMadmGinqI=;
        b=xUFDctmqvZ4PHFLKCU2wUelD5SaFkaTXWfJVswiOQuweNjuTI95vcVI4JqcrTnCVeB
         VGPW/hN9oMKUehnIiYxwNWi1cwKxlEBs2CggRwIdPvrSsQPL78zo5j21d8ETxbhocCc6
         rjKlVxTqwGSvRySSxYZopvsT7GiR8rfXz98S71jI6U8bC3KRbTX5+3FbmPC5R8lCpnJJ
         CB7WQJxf9+UFf+gxWqxzJxRjz8rqGXpRZSmZuygCLn1nGT0JZobehBE973oog9iCN38r
         N626+DqsYMUBfA9XHGpEQNp54ButcPs+0I911/v2PoBL8i2TDJj08CJ17AOpiKgEUWww
         AP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uJmNgXIJjv7e9QEtfn932MJG6jZkrOHVgpMadmGinqI=;
        b=I7Kbd9evuWzkuK0murl6X2x+knOboQNVp3OhBBCjvmbhu8zrWKE//hinC91BZz8HPl
         C6yVO7+eHijnxsxlg2dV5gnZViLpzGUe/+Cza4iRYH0qcOtrTwKop0V6SXpPlMbGxVus
         VvwnLMQMQlU+gBauINcUBHa8mcajMVS6Kpz7RYT+5oN8snto4qmZ4RuH9KnuTPYEiEt0
         KApcQQpim8KuEMbfryueFdznTxoJJEYw3bbiqkSk3XYeNRXU4nlCljlZFqS1S2be2HXk
         Ule+u/2f1y3Kal0h7RAkwsqnCVU7E+YSKrGjB3yEoe/SknXaGLn+e/NfTG4BXLVtYYAd
         s0GA==
X-Gm-Message-State: AOAM531VsQPMT8/e9BGu1Y3B+nYnhF59XetkcWw7jSyKGG0dI/uFT3Zk
        xPLYcIyusdIyTRkJ7AR+tXlLVg==
X-Google-Smtp-Source: ABdhPJy8bJG6hnLhtnscpC2zqKrCZnTmSRirOuwCdixgYC/spMeh70jFllDmX1gLI9uvPpfBMgXVag==
X-Received: by 2002:a05:6808:20f:: with SMTP id l15mr6210675oie.53.1612029473422;
        Sat, 30 Jan 2021 09:57:53 -0800 (PST)
Received: from elm (162-237-133-238.lightspeed.rcsntx.sbcglobal.net. [162.237.133.238])
        by smtp.gmail.com with ESMTPSA id z4sm3112393ooz.5.2021.01.30.09.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 09:57:53 -0800 (PST)
Date:   Sat, 30 Jan 2021 11:57:51 -0600
From:   Tyler Hicks <code@tyhicks.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] ecryptfs: use DEFINE_MUTEX() for mutex lock
Message-ID: <20210130175751.GC58096@elm>
References: <20201224132233.30852-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224132233.30852-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-24 21:22:33, Zheng Yongjun wrote:
> mutex lock can be initialized automatically with DEFINE_MUTEX()
> rather than explicitly calling mutex_init().
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

This looks good to me. I've pushed the patch to the eCryptfs next
branch:

 https://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git/log/?h=next

Thanks for the cleanup!

Tyler

> ---
>  fs/ecryptfs/crypto.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index 0681540c48d9..be906b9bbb11 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -1590,11 +1590,10 @@ ecryptfs_process_key_cipher(struct crypto_skcipher **key_tfm,
>  
>  struct kmem_cache *ecryptfs_key_tfm_cache;
>  static struct list_head key_tfm_list;
> -struct mutex key_tfm_list_mutex;
> +DEFINE_MUTEX(key_tfm_list_mutex);
>  
>  int __init ecryptfs_init_crypto(void)
>  {
> -	mutex_init(&key_tfm_list_mutex);
>  	INIT_LIST_HEAD(&key_tfm_list);
>  	return 0;
>  }
> -- 
> 2.22.0
> 
