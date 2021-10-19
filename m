Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C893E433442
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbhJSLCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 07:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbhJSLCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:02:15 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA55C061746
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 04:00:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n40-20020a05600c3ba800b0030da2439b21so2290938wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 04:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=LRkSXvKU2H3yNWwYA1Dskm2+OrbMFIykkcsNX7x6JHY=;
        b=Zt2uGQFq89/yImCzTMOWBObDDJ+N0WvJuq2vzZdU7jm5QFQ2bWNIwpcpk8ntJm4ObN
         c32YtN4Q6/M5U1hWk1mk1q1NMyyNhngTCvObm87r56pGDyZZISgO8okr84/D8n+jCrlo
         d6zbLFYEIedMaf832hRSwdhxMtj6LSCM0yFOadMoZiupMSHA/IWjs10H3i2rcY+wJeGh
         ZnVfasLZ+BrlNdMBQ9FAgJg7MLwz41pM8ZUz1W7vSZMQEQEBpjJ87ewcogAAhov6qLb3
         03Xb5ahEFx2wR7J9gYU2PRQONGhN6VOo/ZFKoMhR9IBkrA6jc3RLJRsaniZZGaFOc9Tw
         wgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LRkSXvKU2H3yNWwYA1Dskm2+OrbMFIykkcsNX7x6JHY=;
        b=VFd7onBW6OZSC2EDt3KG1Lk87ejUEMl1oMBAR7gu+3jVS7AmPLM1y0xXhvRnQLJ5/v
         0IBoygKCwTTgyktvz26zp+wbKgOH+20b+i3MLFw5OvH/z30QmhOAlCNLZwrpng/o9WUr
         PR2/0aaCGNieD16jMeXCdsUtQIbGf5cpojhdg34xpnosnlorhKOxEjdQwQt8fOpFnTXI
         tX0ofHew7jQKvcgLV5wdyPV4z+Qlfg6bv7Xn/CXjcIBTbnSaMyucjaFdzKBf2P4sIzBk
         tfCyEU6/6nW2lnonIhKUeLy1YDfBGOKW1G3gTL3W7cg7eamDpF3O4dVoFKeKCsSifJnq
         6rcQ==
X-Gm-Message-State: AOAM533cZq4uN8r7WwfA6VrdJmR/HXMZBQ0E5vuloblhhQccjGm8lM4d
        SVxB7hCo2xyfu6gIbX4QFWg=
X-Google-Smtp-Source: ABdhPJwgtsT9xA/ypF8QJmoBh1ux1sOfUKyjGJHXsWAnhKW7ahbqyu4PvzrB9hSizgmpl2IS5SYkTw==
X-Received: by 2002:a7b:cf03:: with SMTP id l3mr5210548wmg.25.1634641201313;
        Tue, 19 Oct 2021 04:00:01 -0700 (PDT)
Received: from ?IPv6:2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62? ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id v3sm15097529wrg.23.2021.10.19.04.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 04:00:00 -0700 (PDT)
Message-ID: <810a4e29b0c54520a30cae4d37fde0a59ea3d83b.camel@gmail.com>
Subject: Re: [PATCH] staging: vt6655: Fix line wrapping in rf.c file
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Joe Perches <joe@perches.com>, Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 19 Oct 2021 11:59:56 +0100
In-Reply-To: <84f3c940fedb961e6e7e88d47c3d15e598bc32c3.camel@perches.com>
References: <20211018150526.9718-1-karolinadrobnik@gmail.com>
         <YW2O3wC8wMEKS3Ub@kroah.com>
         <84f3c940fedb961e6e7e88d47c3d15e598bc32c3.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you very much for your comments.

On Mon, 2021-10-18 at 17:12 +0200, Greg KH wrote:
> Also, these are all just fine as-is for now.  A better way to make
> these lines smaller is to use better variable and function names 
> that are shorter and make sense :)

I have v2 ready but I'm not sure, given the Joe's patch, if my solution
is a satisfactory one. I didn't jump on such refactoring as I'm still
learning about the codebase/process and didn't want to muddle the
waters (...more than I do already).

Greg, what would you prefer? Should I back up with my patch, pick
something else and let Joe's patch be merged?


Also, I have a question about the patch if that's ok :)

On Mon, 2021-10-18 at 22:56 -0700, Joe Perches wrote:
> Maybe some refactoring like:
> ---
>  drivers/staging/vt6655/rf.c | 38
> ++++++++++++++++++--------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rf.c
> b/drivers/staging/vt6655/rf.c
> index 0dae593c6944f..7beb0cd5a62df 100644
> --- a/drivers/staging/vt6655/rf.c
> +++ b/drivers/staging/vt6655/rf.c
> @@ -680,16 +680,19 @@ bool RFvWriteWakeProgSyn(struct vnt_private
> *priv, unsigned char byRFType,
>                          u16 uChannel)
>  {
>         void __iomem *iobase = priv->PortOffset;
> -       int   ii;
> +       int i;
> +       unsigned short idx = MISCFIFO_SYNDATA_IDX;
>         unsigned char byInitCount = 0;
>         unsigned char bySleepCount = 0;
> +       const unsigned long *data;
>  
> +       uChannel--;
>         VNSvOutPortW(iobase + MAC_REG_MISCFFNDEX, 0);

I see that you introduced `uChannel--` to further tidy up the lines
with `[uChannel - 1]`. In general, is there anything wrong with
indexing like `i - 1`? What's the preference here? DRY things up as
much as possible?

I'm asking because when I was reading this line, at first, it wasn't
clear to me why we could decrement it (example though: "Was this
modified earlier? Do we need to "correct" it?").


Thanks,
Karolina


