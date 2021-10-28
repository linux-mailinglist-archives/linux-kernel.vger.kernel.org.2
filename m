Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD97843E072
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhJ1MEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 08:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhJ1MEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 08:04:53 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75877C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 05:02:26 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id h11so10310371ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7JVpBTwxX7UXyXk0IveCqm6QwI/eFfNAsaUhv2IBFUs=;
        b=TqErJFnw43FiumbqTgEdhrUynkg0qW1u0k3asGZbSb1BwJsB4FXiaXxCDY/Ons/poo
         cabA9l0L2imyIjpqra+wkr6iIPvz9ZvtoLJQfHPFwac0w0yk6LW1JqbCh5FyCmVs8yMz
         DEZANqOqSVvecfK40owktaDw976ZVMFelQNNZSiW6mZTR5ZxF1uOxGmabKn4Ml6BZlls
         AzSomEwz00pK5vz/YVDVhkZkuykPSJMqoIgsq7w0BFVsXiMGF9c/o2gaO6VdN+EcPHSW
         Bs1YIRJplq3vE7JHNG+VWmR3d2LJXCKNHxIHKFWs+jhqx4oD479qBVzZYw+lAnNkN8N4
         X0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7JVpBTwxX7UXyXk0IveCqm6QwI/eFfNAsaUhv2IBFUs=;
        b=8IjP0ByK3JfoMd3x/oBB2GzQ/+vKg0AzN95j3Ic1+uvKJie4hmkeIt5KCnB6uXCzEo
         ldFJlkJ9x7JVKNUuZ0HrORjRFyUOXoj1PLsO5wSgJgEAUpvbFH+Z+9hye/MpKsi9bphq
         odP3KfIDhS0NjfRmtWC7xwim/YRvLqOaAjt5q84sQpAxTiyWwI6+uRBb/PbbCA00o2Y2
         Gb1aDIOQIn43b6/uexGLJqH7/yljvaWI5th7IWhjBlCMK2nRxXsmIxBJx6vTW6J2Wn60
         BcMtubfzt7uw4sMadC261wSD58kZo7zagoAsSdNIToEb1KinVMe8L++vfLOsU8pxP2ew
         GPiQ==
X-Gm-Message-State: AOAM5338MuHDH7iL8Y062G+Dz1xN6p6GaNuC3AYusEqeDmF80S8VmQiv
        mbg8xNQblAtl73P589VAtBE=
X-Google-Smtp-Source: ABdhPJziX61Xz6mcaSeGjSH6G2UeXGVWU3mHlQYloIOTvrHMq5OfemBOwjJwJPgRD60QXIgkbw92kQ==
X-Received: by 2002:a2e:b5b3:: with SMTP id f19mr4226196ljn.423.1635422543462;
        Thu, 28 Oct 2021 05:02:23 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id q6sm293435lfg.188.2021.10.28.05.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 05:02:23 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 28 Oct 2021 14:02:20 +0200
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, urezki@gmail.com,
        deng.changcheng@zte.com.cn, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] lib/test_vmalloc.c: use swap() to make code cleaner
Message-ID: <20211028120220.GA1907@pc638.lan>
References: <20211028111443.15744-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028111443.15744-1-deng.changcheng@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 11:14:43AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Use swap() in order to make code cleaner. Issue found by coccinelle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  lib/test_vmalloc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> index e14993bc84d2..cf41fd6df42a 100644
> --- a/lib/test_vmalloc.c
> +++ b/lib/test_vmalloc.c
> @@ -393,7 +393,7 @@ static struct test_driver {
>  static void shuffle_array(int *arr, int n)
>  {
>  	unsigned int rnd;
> -	int i, j, x;
> +	int i, j;
>  
>  	for (i = n - 1; i > 0; i--)  {
>  		get_random_bytes(&rnd, sizeof(rnd));
> @@ -402,9 +402,7 @@ static void shuffle_array(int *arr, int n)
>  		j = rnd % i;
>  
>  		/* Swap indexes. */
> -		x = arr[i];
> -		arr[i] = arr[j];
> -		arr[j] = x;
> +		swap(arr[i], arr[j]);
>  	}
>  }
>  
> -- 
> 2.25.1

Makes sense to me: Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Vlad Rezki
