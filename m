Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F4643E10F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJ1Mja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 08:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhJ1Mj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 08:39:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B902C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 05:37:02 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g10so23978550edj.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 05:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SLr4/TnuHibe67bj8qgu1HXsYDnjQOeI4kUtFicodUM=;
        b=Vp13/kU1uMF7hIYXyF+K5W5teumj+0JSIXryVIwzTjc7QMOkHfZOyFTGG9JLL2sNDJ
         rK6JlS7HtH/dNA+K5Rf7x5mQjYGR6S+M0xWfadOGZk/y59dWVoEdTWWaDXstuMl3MrKi
         VqN7qvNLRpWzn9CX2+VhZFr2olh8w73R3QQcZk3KQl2gXHvxUWXiInAQHvRPWEW+/9lP
         gEcDvZb5NxFB79tbwUoIEFOQGjUbrZA1Op2WFuZhBp+CXTmax2VVcrt/6weUuWsm717p
         fw0/S/Mnc0Z8PkQweaIRp9DZCxfLQSkAWXtnt2ckcatpuIt76BM3AkbXtTBbZ5V2HEwU
         Kj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SLr4/TnuHibe67bj8qgu1HXsYDnjQOeI4kUtFicodUM=;
        b=sWD8F3UVgnfEQIxAHzh53rvEGe4vZH+KO/W2Af6Jh8P82yg730KNh7QIUBO57kFTX0
         jrrrjG2VZbo4/BVJDlRc8CFMp2yspwletxa/qNkVhh9lwFGqfEra2zN4sVl/TWxLIsAl
         G4L75fHqM9kyahimCd2OucFLyfuLqXIGsGd+cjbv7NUfqPxbmFEnCW8g704j93eujErb
         O8/w0Ze21pLjWqeVgbvkY2oYxTGCvW1UY+sFDKAn8YNVOCJqyvFLyOYunAwf4X1GKcSB
         ZHXCPGGNuBKdGqpD1tC72bBucSHYoLjfD6d0q7Jjs44OeeVZLpALTxLcP6nq+PBSlE2v
         DzgA==
X-Gm-Message-State: AOAM5332r2JoMSi4faJM+M2IR+ancdldUD9L6DI5ifgoxIBKWYJGpAkg
        0nlsX47a/OMeKiXWaDNTNy4=
X-Google-Smtp-Source: ABdhPJxNLKB6efA6LY1H6WKs7qec+/IU0ErVxxUVKcftBYYm6ph6GxjvZ96Z+tffWqafuIFyGYeDkg==
X-Received: by 2002:a17:906:3a0e:: with SMTP id z14mr5245835eje.55.1635424620813;
        Thu, 28 Oct 2021 05:37:00 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-54-101.retail.telecomitalia.it. [79.56.54.101])
        by smtp.gmail.com with ESMTPSA id s16sm1675021edd.32.2021.10.28.05.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 05:37:00 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 5/7] staging: vt6655: Rewrite conditional in AL7320 initialization
Date:   Thu, 28 Oct 2021 14:36:59 +0200
Message-ID: <1683328.aCfAWUeHFl@localhost.localdomain>
In-Reply-To: <948406a3e7d23f1cdf866aa4448d9428bdd32512.1635415820.git.karolinadrobnik@gmail.com>
References: <cover.1635415820.git.karolinadrobnik@gmail.com> <948406a3e7d23f1cdf866aa4448d9428bdd32512.1635415820.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 28, 2021 12:35:35 PM CEST Karolina Drobnik wrote:
> Use conditional operator to determine which table for AL7320
> initialization should be used. Use `data` temporary value to
> store this value.
> 
> Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
> ---
>  drivers/staging/vt6655/rf.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
> index afd202ea3356..af4eb7eb8e7d 100644
> --- a/drivers/staging/vt6655/rf.c
> +++ b/drivers/staging/vt6655/rf.c
> @@ -716,13 +716,10 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, 
unsigned char rf_type,
>  		if (init_count > (MISCFIFO_SYNDATASIZE - sleep_count))
>  			return false;
>  
> -		if (channel <= CB_MAX_CHANNEL_24G) {
> -			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
> -				MACvSetMISCFifo(priv, idx++, 
al7230_init_table[i]);
> -		} else {
> -			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
> -				MACvSetMISCFifo(priv, idx++, 
al7230_init_table_a_mode[i]);
> -		}
> +		data = (channel <= CB_MAX_CHANNEL_24G) ?
> +			al7230_init_table : 
al7230_init_table_a_mode;

As far as I know by reading some Greg K-H's replies to other developers, this 
"<test> ? <true> : <false>" style is not well accepted here.

I'd prefer to see an explicit "if-else" statement because with that style you 
sacrifice readability and gain nothing here.

> +		for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
> +			MACvSetMISCFifo(priv, idx++, *(data++));

Again, as Julia pointed out, "*data++" and "*(data++)" are syntactically 
correct instructions but are not required here. I'm also pretty sure that, by 
not reusing that index, you're adding additional unnecessary instructions to 
the resulting assembly code (unless the compiler is able to optimize it).

"*foo++" and the like are powerful and compact instructions, but you should 
use them in other, more suitable contexts.

Thanks,

Fabio


>  
>  		MACvSetMISCFifo(priv, idx++, 
al7230_channel_table0[channel - 1]);
>  		MACvSetMISCFifo(priv, idx++, 
al7230_channel_table1[channel - 1]);
> -- 
> 2.30.2
> 
> -- 
> You received this message because you are subscribed to the Google Groups 
"outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an 
email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/
outreachy-kernel/
948406a3e7d23f1cdf866aa4448d9428bdd32512.1635415820.git.karolinadrobnik%40gmail.com.
> 




