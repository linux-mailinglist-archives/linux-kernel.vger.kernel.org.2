Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21C43DFED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 13:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhJ1LXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 07:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1LXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 07:23:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A6AC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 04:21:19 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w15so23386478edc.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 04:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Op6C5+sI2HRkHLePoE/V+Eu4upF10actJBzQJBisYEY=;
        b=IiBM5elO1GRwsifeUBbzlGsnrdnNe0MMKrHZbQV4qs9ibGLxvC1WEhSJdbrhfpCiCc
         YSPsio769dLE37ClBW2keNGTu0+UnrbdNBhOAda5EJ9wEzyFafnkmx0P82n2IOjgcWQ+
         z9pYjILQIJEsJUL6iW9rzaQsXNmkGsO8/wahUDnNfXMr4noL2A4P5Rq8faTSVHMQLSQR
         KuAfTVH5lx+DTEs3ynk/3AhoXO3QnY1j61cgfrk65sToRFXJPfjCJGx7hkAl5iDy6g22
         lY8r1XtMoexnt5PQsf+fSBKlWnrDv2AFlFxsz0bbgxbeYMZqmpVprOQx/unlC9BTbs/c
         i/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Op6C5+sI2HRkHLePoE/V+Eu4upF10actJBzQJBisYEY=;
        b=1SpO41NzoFbjUekDbxM+j18PEOpluAdv5kUmHr3nY1qdgtRnYsF03y5YS0rH7dXvNB
         JXaU4FxCg6vp0zQyQ8llL1ENBnPY3wV9oRzTr18odhXoOLgx/Ummg69iBO2ND+k88ZkT
         Rg4jS0pq4f/znfzjtwuLo808hTn9ixtgQUe8zl29ct68Yebx+VoZYr1fin39G6YozjJb
         /Fil/pPjSQgDSOQZYEYLGwz1rDYg/gmkA4sp7jmv1XE7zzhYSkITIrrEcfCmBm5H87B0
         YuUwIDQRrD9MjPiOOhrnY8a44npEYCXfJ0FVzxXRz7U+uUTHbuS2ivP1Zsx3TWgAgRZo
         9KhQ==
X-Gm-Message-State: AOAM533IDES+uccqqgvS5VIOKlzQv3/umrTP+B9M0jfTnqf34ks43WJL
        786Z6UqER4qWeCY/b3+Vp8g=
X-Google-Smtp-Source: ABdhPJwO2z7zzpNUKDPjGWnGeh/nQymbrNIcxwE3Qx/2P0UOU7kNvL41RLmv0Efqnm2zTaSNCtdrWg==
X-Received: by 2002:a17:906:16c9:: with SMTP id t9mr4706299ejd.104.1635420077776;
        Thu, 28 Oct 2021 04:21:17 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-54-101.retail.telecomitalia.it. [79.56.54.101])
        by smtp.gmail.com with ESMTPSA id q17sm1148529ejp.106.2021.10.28.04.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 04:21:17 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 4/7] staging: vt6655: Introduce `data` temporary variable
Date:   Thu, 28 Oct 2021 13:21:16 +0200
Message-ID: <2039159.k92FijXA2m@localhost.localdomain>
In-Reply-To: <dc72a4c3539aed70569f66396ed3b51818bc2aea.1635415820.git.karolinadrobnik@gmail.com>
References: <cover.1635415820.git.karolinadrobnik@gmail.com> <dc72a4c3539aed70569f66396ed3b51818bc2aea.1635415820.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 28, 2021 12:35:34 PM CEST Karolina Drobnik wrote:
> Add a variable to store initialization tables. Use this variable
> in AL2230 initialization.
> 
> Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
> ---
>  drivers/staging/vt6655/rf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
> index ea74701917e5..afd202ea3356 100644
> --- a/drivers/staging/vt6655/rf.c
> +++ b/drivers/staging/vt6655/rf.c
> @@ -684,6 +684,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, 
unsigned char rf_type,
>  	unsigned short idx = MISCFIFO_SYNDATA_IDX;
>  	unsigned char init_count = 0;
>  	unsigned char sleep_count = 0;
> +	const unsigned long *data;
>  
>  	VNSvOutPortW(iobase + MAC_REG_MISCFFNDEX, 0);
>  	switch (rf_type) {
> @@ -699,8 +700,9 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, 
unsigned char rf_type,
>  		if (init_count > (MISCFIFO_SYNDATASIZE - sleep_count))
>  			return false;
>  
> +		data = al2230_init_table;
>  		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
> -			MACvSetMISCFifo(priv, idx++, 
al2230_init_table[i]);
> +			MACvSetMISCFifo(priv, idx++, *(data++));

Hi Karolina,

I think you are using redundant parentheses in "* (data ++)" but understand 
that those increments and dereferences are equivalent to "* data ++" 
(according to the C precedence rules).

Some time ago I suggested that you use those redundant parentheses because
Greg Kroah-Hartman had previously explained that he prefers not to see 
"*foo++" because maintainers and reviewers are not required to remember the C 
precedence rules.

I hope my suggestion isn't based on a misunderstanding of what Greg wants 
here and that your patch can be accepted as is.

While we are at it, please notice that Maintainers of different subsystems 
may see this topic from a different point of view and that they might very 
well ask you for removing those redundant parentheses.

I'd suggest to use grep and find out what is preferred in other subsystems, 
when you want to contribute to other parts of Linux.

Thanks,

Fabio

>  		MACvSetMISCFifo(priv, idx++, 
al2230_channel_table0[channel - 1]);
>  		MACvSetMISCFifo(priv, idx++, 
al2230_channel_table1[channel - 1]);
> -- 
> 2.30.2
> 
> -- 
> You received this message because you are subscribed to the Google Groups 
"outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an 
email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/
outreachy-kernel/dc72a4c3539aed70569f66396ed3b51818bc2aea.
1635415820.git.karolinadrobnik%40gmail.com.
> 




