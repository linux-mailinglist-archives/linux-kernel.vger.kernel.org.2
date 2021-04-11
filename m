Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7241B35B2E3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 11:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbhDKJri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 05:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbhDKJrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 05:47:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DBFC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 02:47:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g5so8667257ejx.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 02:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XozUfb+e6qIS1vLWDOC/iivsBt2km9C9PhK3hcJC5xs=;
        b=KvOXvRRngaPQLi1Wz6ip5Jc8rllLF5JlsreEs3+v7nMaU5leW6KWcbStR988uW2GmT
         KUs5Cpe19ZPUxZEnXdbYu4LclbHf0YNPT2QCAYW4GAzG8ZDU8ypx9dRTVqXVN0SD2fC3
         OYuZiMgIZTt/xma4C5XcW3IGa0QzG5YioJATc971N4LKg+5vlwjz9VidukGDRGVnQ+N2
         NksxzXV5Knx5oyfc5PHEI4WbCOfW1xn7Eu3ODnaW/NqpPKLNWJC/7VHK2I5LTu78Uwqt
         0RR3ZFujbta/hYWBPjNQA5AutlSRfmOaGlHkv/IMkJg6pq9ZV4i3cKC9zv9Za0TSZbUP
         m90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XozUfb+e6qIS1vLWDOC/iivsBt2km9C9PhK3hcJC5xs=;
        b=ENChFdwVpD+i4zl0rMDKYNOEeHObN52AuWXdD0euUc3O3EP1mwuLjlYVON6oyOVYk5
         SF8k40X2HcxNUEx164fZmVp//zdJFW8BYR//1lvLf1KqLbag/DV33ljwcBzh1Hcb26WI
         x2k9kLenPqvg9EAPJl18D4BYyQKn3ZZonAUESs9SIez1eBHDHr9P6SOsTtTk1lQWjj4R
         iN4D1CW1OBQ8jKv6T+VM3iEkWqzxceY0RpQ3eVZs3yapzICqMb8NhScJaCOsEOrsyWck
         mIMGotID4TatqkqG+1brOAG+n5DBLUMI7giVirNH5qOpVMTebEnxfV52O/9bB/q+gKdU
         k6yA==
X-Gm-Message-State: AOAM533pjKHv+dC7y9lsCIvP9gZA8QDzdfAR2w9iVC/wm87W7d77+0YO
        NokSPGL9VAD8rt/BhWEyUNk=
X-Google-Smtp-Source: ABdhPJzxZsDnB2LWupjebkZy0TBiTrvjEYgK0OszcrcofKiF3wDjGlP9n010S5BYHaS7VDBwTfApsg==
X-Received: by 2002:a17:906:5052:: with SMTP id e18mr17901882ejk.112.1618134436229;
        Sun, 11 Apr 2021 02:47:16 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id by25sm3817951ejc.49.2021.04.11.02.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 02:47:15 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v3 4/4] staging: rtl8723bs: core: Change a controlling expression
Date:   Sun, 11 Apr 2021 11:47:14 +0200
Message-ID: <2796632.fryDJISotm@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.22.394.2104111125310.2854@hadrien>
References: <20210411082908.31876-1-fmdefrancesco@gmail.com> <20210411082908.31876-5-fmdefrancesco@gmail.com> <alpine.DEB.2.22.394.2104111125310.2854@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, April 11, 2021 11:26:41 AM CEST Julia Lawall wrote:
> On Sun, 11 Apr 2021, Fabio M. De Francesco wrote:
> > Change a controlling expression within an 'if' statement: don't compare
> > with 'true'.
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > Changes from v2: Rewrite subject in patch 0/4; remove a patch from the
> > series because it had already been applied (rtl8723bs: core: Remove an
> > unused variable). Changes from v1: Fix a typo in subject of patch 1/5,
> > add patch 5/5.> 
> >  drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > b/drivers/staging/rtl8723bs/core/rtw_cmd.c index
> > 32079e0f71d5..600366cb1aeb 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > @@ -1507,7 +1507,7 @@ static void rtw_lps_change_dtim_hdl(struct
> > adapter *padapter, u8 dtim)> 
> >  	if (pwrpriv->dtim != dtim)
> >  	
> >  		pwrpriv->dtim = dtim;
> > 
> > -	if ((pwrpriv->fw_current_in_ps_mode == true) && (pwrpriv-
>pwr_mode >
> > PS_MODE_ACTIVE)) { +	if ((pwrpriv->fw_current_in_ps_mode) &&
> > (pwrpriv->pwr_mode > PS_MODE_ACTIVE)) {
> The parentheses in the left argument of && can be dropped as well.
>
What about the parentheses of the right argument? I'm not sure: does '>' 
have precedence over '&&'? Doesn't it?

Thanks,

Fabio
> 
> julia
> 
> >  		u8 ps_mode = pwrpriv->pwr_mode;
> >  		
> >  		rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, 
(u8
> >  		*)(&ps_mode));
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
> > https://groups.google.com/d/msgid/outreachy-kernel/20210411082908.3187
> > 6-5-fmdefrancesco%40gmail.com.




