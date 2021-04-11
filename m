Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0503F35B32C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 12:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhDKKal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 06:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKKaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 06:30:39 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EB8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 03:30:22 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id bx20so10379126edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 03:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x3r2FyLHyY3w2SLbIC95IxoZj7WakC/+ymJzKCDyFVo=;
        b=IF/DORTrw1iddbeufjNoavKZSL4pP53ubatlXQ7IGCwxjq3FE64a3JJPA1huLYvKwT
         WXTOA7cdsQA9Q4TVFQz7zRkZsxWrvjTAWzbmMfdLym7n1xYQ1nJOjDRXPipEHXQab3nL
         jsbR6UD5CndtKfZe9TYJfaaAMNFz5EDly5AMUmixX2P3ohFjyQ3gV8ZWO8DjCEY/EQrV
         B0w+xTTxz9aCgddXvwQQXPocbf++gL1nn9ZtzXx/FnmNFFLEA0DSoPIZTig+8h51G1+F
         HCwpdmNYza7efmpRLAkCTg+cKRCNPxWb1LAKfCwp1RSsHpQ7g+fHAXB3OpjyJhEFEGaI
         X5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x3r2FyLHyY3w2SLbIC95IxoZj7WakC/+ymJzKCDyFVo=;
        b=E08KKVv+MI5JZObDf7B+VpDnsRGFYxs5XaGOujpbUnAWGUsR8wXjoLQ8fEV34epS5y
         maBZN0a7rxvi6KtqR+MogBIAlZGC7IArpNufpM2iFbSK1UfdNnCsKBKyReF1EgeSRoOH
         17iesNQXfKTiL8Uap+3ibI7vNICrILCTIazcfrBCsyzkd6RLLvZTZhSdj96NLlKznqnL
         rh8qMFaUtFwl80DTNeLp66KhKt7kEEBmSQgjLyUGAvLR+2YPO9KnCOjAZ1zyK1XbfeF4
         r3uqc6C/Y+RLTwJBKYJMgkjfe2wxUprdiIYs2XqpupD4kuHl5uM2TR9+RP6FB/bxzmbR
         n4LA==
X-Gm-Message-State: AOAM5303H3mdfiHWQ4WHA6xiQd6pKa6atdwM1qW/T9XvrnecAxSG2cFX
        Sc+Olf+6AY0T8ihrdmrYLns=
X-Google-Smtp-Source: ABdhPJxoIfJKouP2d4+1Rsnw5/pBAJEIPg7uLRuGFyUMaBpdSseXfXnhEBJwgq+OhEXoEO6qSNyS6A==
X-Received: by 2002:aa7:dcc7:: with SMTP id w7mr24482602edu.255.1618137021184;
        Sun, 11 Apr 2021 03:30:21 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id ay3sm4499894edb.2.2021.04.11.03.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 03:30:20 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v3 4/4] staging: rtl8723bs: core: Change a controlling expression
Date:   Sun, 11 Apr 2021 12:30:19 +0200
Message-ID: <4476737.Uq5WOKsIPT@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.22.394.2104111209230.2854@hadrien>
References: <20210411082908.31876-1-fmdefrancesco@gmail.com> <3322597.vpUxb0oOqP@localhost.localdomain> <alpine.DEB.2.22.394.2104111209230.2854@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, April 11, 2021 12:10:17 PM CEST Julia Lawall wrote:
> On Sun, 11 Apr 2021, Fabio M. De Francesco wrote:
> > On Sunday, April 11, 2021 11:51:32 AM CEST Julia Lawall wrote:
> > > On Sun, 11 Apr 2021, Fabio M. De Francesco wrote:
> > > > On Sunday, April 11, 2021 11:26:41 AM CEST Julia Lawall wrote:
> > > > > On Sun, 11 Apr 2021, Fabio M. De Francesco wrote:
> > > > > > Change a controlling expression within an 'if' statement: don't
> > > > > > compare
> > > > > > with 'true'.
> > > > > > 
> > > > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > > > ---
> > > > > > 
> > > > > > Changes from v2: Rewrite subject in patch 0/4; remove a patch
> > > > > > from
> > > > > > the
> > > > > > series because it had already been applied (rtl8723bs: core:
> > > > > > Remove
> > > > > > an
> > > > > > unused variable). Changes from v1: Fix a typo in subject of
> > > > > > patch
> > > > > > 1/5,
> > > > > > add patch 5/5.>
> > > > > > 
> > > > > >  drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > > > b/drivers/staging/rtl8723bs/core/rtw_cmd.c index
> > > > > > 32079e0f71d5..600366cb1aeb 100644
> > > > > > --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > > > +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > > > @@ -1507,7 +1507,7 @@ static void
> > > > > > rtw_lps_change_dtim_hdl(struct
> > > > > > adapter *padapter, u8 dtim)>
> > > > > > 
> > > > > >  	if (pwrpriv->dtim != dtim)
> > > > > >  	
> > > > > >  		pwrpriv->dtim = dtim;
> > > > > > 
> > > > > > -	if ((pwrpriv->fw_current_in_ps_mode == true) && (pwrpriv-
> > > > >
> > > > >pwr_mode >
> > > > >
> > > > > > PS_MODE_ACTIVE)) { +	if ((pwrpriv->fw_current_in_ps_mode) 
&&
> > > > > > (pwrpriv->pwr_mode > PS_MODE_ACTIVE)) {
> > > > > 
> > > > > The parentheses in the left argument of && can be dropped as
> > > > > well.
> > > > 
> > > > What about the parentheses of the right argument? I'm not sure:
> > > > does
> > > > '>'
> > > > have precedence over '&&'? Doesn't it?
> > > 
> > > On the right they are not actually needed either:
> > So, I remembered well :)
> > 
> > > https://en.cppreference.com/w/c/language/operator_precedence
> > 
> > Very nice table. Thanks for the link.
> > 
> > > But you could look around in the code and see what people typically
> > > do.
> > > Perhaps one might find the parentheses more clear when there is a
> > > binary
> > > operator.  But when there is no binary operator, they could be more
> > > confusing than useful.
> > 
> > When I look around in the code I see a lot of unnecessary parentheses.
> > What people typically do is not always the right thing. I prefer to
> > remove parentheses where they are redundant.
> 
> Not sure I was clear.  This driver seems to be very enthusiastic about
> parentheses.  But perhaps check in other more mature parts of the
> kernel.
>
Sorry, I thought you were specifically referring to that file.

I've run "grep" in ./kernel/locking and others mature parts of Linux. 
You're right: experienced authors use parentheses when there are binary 
operators. Therefore, I'll leave that right hand argument as is within 
parentheses.

Thanks again,

Fabio
> 
> julia
> 
> > Thanks for your kind help,
> > 
> > Fabio
> > 
> > > julia
> > > 
> > > > Thanks,
> > > > 
> > > > Fabio
> > > > 
> > > > > julia
> > > > > 
> > > > > >  		u8 ps_mode = pwrpriv->pwr_mode;
> > > > > >  		
> > > > > >  		rtw_hal_set_hwreg(padapter, 
HW_VAR_H2C_FW_PWRMODE,
> > > > 
> > > > (u8
> > > > 
> > > > > >  		*)(&ps_mode));
> > > > > > 
> > > > > > --
> > > > > > 2.31.1
> > > > > > 
> > > > > > --
> > > > > > You received this message because you are subscribed to the
> > > > > > Google
> > > > > > Groups "outreachy-kernel" group. To unsubscribe from this group
> > > > > > and
> > > > > > stop receiving emails from it, send an email to
> > > > > > outreachy-kernel+unsubscribe@googlegroups.com. To view this
> > > > > > discussion
> > > > > > on the web visit
> > > > > > https://groups.google.com/d/msgid/outreachy-kernel/202104110829
> > > > > > 08.3
> > > > > > 187
> > > > > > 6-5-fmdefrancesco%40gmail.com.




