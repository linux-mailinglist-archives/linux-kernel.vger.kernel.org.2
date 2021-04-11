Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA5135B2F7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 12:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbhDKKJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 06:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbhDKKJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 06:09:15 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514B3C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 03:08:59 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r22so11474425edq.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 03:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iPjVxr4EIDFwGpM/pEVhF+9F+zdLzGbV3PZiyToJD2U=;
        b=WqbuNhCh0fY6MMNk9U5CNX9k65sqsEs+LaBSID9sUmImFN8fUkN4bI5MY2AAH1A2u2
         ueulFAAqg0B0kWJcXJfEthNPdYyJ8JLNHMyjprdho/N5pC//PJfTuptbq5JoLk2QeTfH
         7yaQoryxNUsOor4UD16UVLy+Cv9hDYcAjR5Vr5qH+5+c7d38S/QDOhgE/MfwblulCTDb
         BQIz1E+OfGpNzOl72UEPOANnkPrIIVg0bTAcb46TwYkCtbPVIbZjFeljcamFO5vubB7v
         4/Yfw3+f/eAI7lkvrhYHC5ZBmd2cCt2HJrXiKdVew2bTLVA1toDjVRIj5ydf3cKNLPF2
         e4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iPjVxr4EIDFwGpM/pEVhF+9F+zdLzGbV3PZiyToJD2U=;
        b=XmUhgaX5zMthWNPZ1fK7CIXRK47i1ZfzVAKaZtmtY2v1dNudD7CWRgxjff2cxYHzt3
         +RCu04pAO5pszhnN4pvDiZ4om+5UfqpdtNDe/ZgCyEHQWp8fVmddSWmjPVeQh6Yi51F2
         Mp8N69CyEJj6cO5z6ohl12LKI/TRIxT+0QPtM1HVwisc8abZ9kWOLjBzqpIA7IVDBAkj
         5ftDn6xhtCS/AApKCGxyyAWLJ8yZk4x3T9VHX64d2CrqBRMjGkbSuxZ5PT3TtN+/7JAf
         8YiO5eBaynhF8EXbKIiLKA5ETtCNdRv9WlVso7R9+/TAzoVnLyM0tCaw2Xdn0brf7B3n
         1aQg==
X-Gm-Message-State: AOAM532VbgeFifMy8cfCd4p03A5kHeYXFX8ik5CBruFdUiFVdogapQOS
        GHTRxbFvQ7WInA/gXrcf92A=
X-Google-Smtp-Source: ABdhPJz97lHWbkc06MstpRcgdrd0lXAVxZ9yz5NPRWF5SBnk5w0id0Q5CdD1zxojPzVZUCxTAk58CA==
X-Received: by 2002:aa7:cb90:: with SMTP id r16mr25432046edt.139.1618135738097;
        Sun, 11 Apr 2021 03:08:58 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id r17sm4479772edt.70.2021.04.11.03.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 03:08:57 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v3 4/4] staging: rtl8723bs: core: Change a controlling expression
Date:   Sun, 11 Apr 2021 12:08:56 +0200
Message-ID: <3322597.vpUxb0oOqP@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.22.394.2104111150010.2854@hadrien>
References: <20210411082908.31876-1-fmdefrancesco@gmail.com> <2796632.fryDJISotm@localhost.localdomain> <alpine.DEB.2.22.394.2104111150010.2854@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, April 11, 2021 11:51:32 AM CEST Julia Lawall wrote:
> On Sun, 11 Apr 2021, Fabio M. De Francesco wrote:
> > On Sunday, April 11, 2021 11:26:41 AM CEST Julia Lawall wrote:
> > > On Sun, 11 Apr 2021, Fabio M. De Francesco wrote:
> > > > Change a controlling expression within an 'if' statement: don't
> > > > compare
> > > > with 'true'.
> > > > 
> > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > ---
> > > > 
> > > > Changes from v2: Rewrite subject in patch 0/4; remove a patch from
> > > > the
> > > > series because it had already been applied (rtl8723bs: core: Remove
> > > > an
> > > > unused variable). Changes from v1: Fix a typo in subject of patch
> > > > 1/5,
> > > > add patch 5/5.>
> > > > 
> > > >  drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > b/drivers/staging/rtl8723bs/core/rtw_cmd.c index
> > > > 32079e0f71d5..600366cb1aeb 100644
> > > > --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > @@ -1507,7 +1507,7 @@ static void rtw_lps_change_dtim_hdl(struct
> > > > adapter *padapter, u8 dtim)>
> > > > 
> > > >  	if (pwrpriv->dtim != dtim)
> > > >  	
> > > >  		pwrpriv->dtim = dtim;
> > > > 
> > > > -	if ((pwrpriv->fw_current_in_ps_mode == true) && (pwrpriv-
> > >
> > >pwr_mode >
> > >
> > > > PS_MODE_ACTIVE)) { +	if ((pwrpriv->fw_current_in_ps_mode) &&
> > > > (pwrpriv->pwr_mode > PS_MODE_ACTIVE)) {
> > > 
> > > The parentheses in the left argument of && can be dropped as well.
> > 
> > What about the parentheses of the right argument? I'm not sure: does
> > '>'
> > have precedence over '&&'? Doesn't it?
> 
> On the right they are not actually needed either:
>
So, I remembered well :)
> 
> https://en.cppreference.com/w/c/language/operator_precedence
> 
Very nice table. Thanks for the link.
>
> But you could look around in the code and see what people typically do.
> Perhaps one might find the parentheses more clear when there is a binary
> operator.  But when there is no binary operator, they could be more
> confusing than useful.
>
When I look around in the code I see a lot of unnecessary parentheses. 
What people typically do is not always the right thing. I prefer to remove 
parentheses where they are redundant.

Thanks for your kind help,

Fabio
>
> julia
> 
> > Thanks,
> > 
> > Fabio
> > 
> > > julia
> > > 
> > > >  		u8 ps_mode = pwrpriv->pwr_mode;
> > > >  		
> > > >  		rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE,
> > 
> > (u8
> > 
> > > >  		*)(&ps_mode));
> > > > 
> > > > --
> > > > 2.31.1
> > > > 
> > > > --
> > > > You received this message because you are subscribed to the Google
> > > > Groups "outreachy-kernel" group. To unsubscribe from this group and
> > > > stop receiving emails from it, send an email to
> > > > outreachy-kernel+unsubscribe@googlegroups.com. To view this
> > > > discussion
> > > > on the web visit
> > > > https://groups.google.com/d/msgid/outreachy-kernel/20210411082908.3
> > > > 187
> > > > 6-5-fmdefrancesco%40gmail.com.




