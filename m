Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E021735B686
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 20:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbhDKSM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 14:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhDKSMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 14:12:25 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C61EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 11:12:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g17so11610273edm.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V/wlowhj303jApNXvbAfUSmOBTZkKuUYqGVds57LCTI=;
        b=A9wVVuPP9QzIZGi01P+Ix15Olu+Wg/P6UPwE4eFpS+HpjKKn8yv+Ph/NPwsz12QDXU
         2wWZccgzNDt0DIY/aZ7BxPEP6GZplNpzSMyeONhPZS03L1neT5xbYlm8i9KB3i+Qk4R7
         pHH6a0n3Mrug+Rh2pFIpegy3MeK426Ra//74u0okBzHbENxErvwlJ1S0xfy4lhbputpc
         inB6kxdtxeu2VEnXtgPv8c6biyzzIx4YkLcL+JBM4Afhs40zbLdMfnkTiIFnJWnWcVsI
         8Y/vs5irgIFU3WMk12ZaWS3/LNRMR24I0oIjgFXhYOzXsA/v5KJVK8ySM0A08P1kQePU
         uFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V/wlowhj303jApNXvbAfUSmOBTZkKuUYqGVds57LCTI=;
        b=kb1oZcPQNUCEEugmsblJjhNafJoImJ0Lfmvusbev2fQY0nt8GQv+40MQoC55yZN7ka
         m29mPCbViMGtSZ5ZjGJUUwNNqJ9sOURevCZrMkJLCr6WibESi+l77kjtMtl+MCzx/M1R
         4xEEXifpguNCdoxZjqE3K1Oke6EL0+hpIvJMRLfDVlqLGh9y+drn7hi8VjgjLgfYdTBt
         6aZRVSgHE9ZWAzHmEyZ8S3cVLpW0AICCAr9VqJHG8pX7WjbnX1A/QBzzWADNaSZ7zJqL
         V1cdx8XYNJaPVb4i5+Lb7iJwNhswK/WEg98NmjfC4ym50LuLV8mF3ACoRG4V4RqMIy8l
         Ebng==
X-Gm-Message-State: AOAM531X4/gEdjtqbP+6tFEXxOfPQtvy7x4DYlqbjd1HsnmDhUAJEj/L
        /Tr9NYjHwm0Rl9GlhWvgjYg=
X-Google-Smtp-Source: ABdhPJxtWLdz9z2XyE9YzKLQtrudYlc7HQ2kHvEU114bqJLOSo3Ng3hg2bGm0rOJl2gdPwORJV2DmQ==
X-Received: by 2002:a50:8711:: with SMTP id i17mr26938506edb.352.1618164727342;
        Sun, 11 Apr 2021 11:12:07 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id bs10sm5039043edb.8.2021.04.11.11.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 11:12:06 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8192u: Remove variable set but not used
Date:   Sun, 11 Apr 2021 20:12:05 +0200
Message-ID: <2836382.q67jgZTtOx@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.22.394.2104111943230.11703@hadrien>
References: <20210411174143.31618-1-fmdefrancesco@gmail.com> <alpine.DEB.2.22.394.2104111943230.11703@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, April 11, 2021 7:43:57 PM CEST Julia Lawall wrote:
> On Sun, 11 Apr 2021, Fabio M. De Francesco wrote:
> > Remove variable "int ret" which is instantiated but not used.
> 
> instantiated -> declared?  I thought instantiated could mean initialized,
> but that doesn't seem to be the case.
> 
> julia
Please, help me to remind...

If a local variable is declared but not set to any value, does it take 
space on the stack?

If I understand your message, it does not. Therefore it is only declared 
but no memory is allocated for it (i.e., it is not instantiated). Right?

If you confirm I've understood this topic, I can send a v2 patch.

Thanks for your review,

Fabio
> 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> >  drivers/staging/rtl8192u/r8192U_core.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/staging/rtl8192u/r8192U_core.c
> > b/drivers/staging/rtl8192u/r8192U_core.c index
> > f48186a89fa1..30055de66239 100644
> > --- a/drivers/staging/rtl8192u/r8192U_core.c
> > +++ b/drivers/staging/rtl8192u/r8192U_core.c
> > @@ -902,7 +902,6 @@ static void rtl8192_hard_data_xmit(struct sk_buff
> > *skb, struct net_device *dev,> 
> >  				   int rate)
> >  
> >  {
> >  
> >  	struct r8192_priv *priv = (struct r8192_priv 
*)ieee80211_priv(dev);
> > 
> > -	int ret;
> > 
> >  	unsigned long flags;
> >  	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb +
> >  	MAX_DEV_ADDR_SIZE); u8 queue_index = tcb_desc->queue_index;
> > 
> > --
> > 2.31.1
> > 
> > --
> > You received this message because you are subscribed to the Google
> > Groups "outreachy-kernel" group. To unsubscribe from this group and
> > stop receiving emails from it, send an email to
> > outreachy-kernel+unsubscribe@googlegroups.com. To view this discussion
> > on the web visit
> > https://groups.google.com/d/msgid/outreachy-kernel/20210411174143.3161
> > 8-1-fmdefrancesco%40gmail.com.




