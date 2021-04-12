Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B81D35C3C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbhDLKXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238442AbhDLKX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:23:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB12C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:23:09 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id bx20so13244873edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aDYfwXOX7CXJC5km5DlusEFEF+Nl5xWOkbGcpQvebPk=;
        b=dpot/PDuWTxI0+YsjLFgYLzDEj6vgBZZXMNrC5eNX2r5KNR9iKUMwbnVJ3BjT1vNex
         wSvgO0xYpng6v2cvxlxxCRq11pcF/DE7hoSDUMbKXRYT5KekR45y2Nq3ysC2ZIpwD60A
         x+KcjDBwQquu8oosqncOGLRy67S0T+CGgm5HKD0eYbk3vjCK16gkdUWxSGGMFA3Gw2th
         ddF2dtSOkIIa4diivQ++lhGNuGwicsn/6RariSY8/whcfMdjuc+3Z34zZ9WM2DMKn7WP
         fzyFLCHBvMhd4M8K/hPezvjDvD0xXIUs4cBCHSOoMqUHN0fT7ioOasbstn/+FxMfg4Ey
         Q+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aDYfwXOX7CXJC5km5DlusEFEF+Nl5xWOkbGcpQvebPk=;
        b=PxizssdnFnryEZ17hctixHwwh4bO1Lm87Su1hBiIlYInnrcw4Ze0oj67Tdq0AjNezk
         csLZf+jjMfDjpO8qrtGxxxgRfbLUsvIEblcDUFU+ZQDectQ1SI1cTbxdW0RFyC5eOUAV
         mXQsEnwzNTBoveptIrDFPGdALwCULEV2sjYWG9QS7DubvTRERht8ULFvJfXvf677eYwh
         AedpGZcC67mDHUHXjlV0sYTIhSYK8pSiTXldN3EuUW4h9Ij+JMmg0Q+kxvqXCaRkzc6o
         O3RGL+7FS924F292v0EY427WIIAvXOjyPbo+g7z596Xqqv1p04FnWw2uvHDJphUs4uMd
         4Fjw==
X-Gm-Message-State: AOAM5334+CeWZdd5uESl2Mmkmv602EVfR656lo+ZdKQ4gmBi1OnUiEVX
        LMI3jB9cvAjMPgD8QmNM+Ho=
X-Google-Smtp-Source: ABdhPJzcBYWukqy9abedu05uFLTelTQXauXhdaT4/d0FJPiqlSsW5qbhAnCE5YHP5PV2lJdpDCi/2g==
X-Received: by 2002:a05:6402:2691:: with SMTP id w17mr21565207edd.81.1618222988753;
        Mon, 12 Apr 2021 03:23:08 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id w13sm6134925edc.81.2021.04.12.03.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 03:23:08 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8192u: Remove variable set but not used
Date:   Mon, 12 Apr 2021 12:23:07 +0200
Message-ID: <269706412.I7xuoi7Q6o@linux.local>
In-Reply-To: <YHQTY4fGJfsdSjXL@kroah.com>
References: <20210411174143.31618-1-fmdefrancesco@gmail.com> <YHQTY4fGJfsdSjXL@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 12, 2021 11:31:15 AM CEST Greg KH wrote:
> On Sun, Apr 11, 2021 at 07:41:43PM +0200, Fabio M. De Francesco wrote:
> > Remove variable "int ret" which is instantiated but not used.
> > 
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
> 
> Did you test-build this patch?
>
Sorry, I don't know why I forgot to test it.
I realized that this morning when I read a message from the kernel test 
robot.
I'll be more careful with future patches.

Thanks,

Fabio




