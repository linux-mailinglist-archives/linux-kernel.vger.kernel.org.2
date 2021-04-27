Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EA636C634
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbhD0MmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbhD0MmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:42:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F39FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 05:41:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a22-20020a05600c2256b029014294520f18so2439051wmm.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 05:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cZ21gZXRbDQCP1+gWLkdEChswiOAmqFQLs0NT28GXiA=;
        b=bfQbTzMsiGQbeF4gRMmfnfYhqnhq2VAiqm7zF9HzRs+RMIreFhBfdS8CSlbsRJpYsv
         HB+mZZCpcssIHSrrvfKuZuEQ4TZcRQ0OSaQtwwJl5RrzEnuLNpHVvgAqfpibqE1fu7sG
         D1uqj4Og22DtTmTRU6v2z/dCFfQ8exyFVbta3DtxImS+/R3Nm4/garPDtjasgTJDwgnX
         /mhXurr/RkFJv1hi3mwaEp4SRc8DP6piTuvN4xINJJ42iM8uD8W0oX5+LaJX7ehFtYNL
         sjB5j2KbBEYUA6IEQWC/e6v/f7cuC37a1Nld36dvKGEy0HYfQRVEOPRsc+KbSRvukYHA
         E6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cZ21gZXRbDQCP1+gWLkdEChswiOAmqFQLs0NT28GXiA=;
        b=DrkZs93Chm7chnc6oO49N9uXIzpZSDkG0z3Emz9gEra23UV40wi5CmrlCmJx3GkX0h
         FpIQDHmsikCDbYWODkDUUlKfZQ87Y/ZYf5sAcaW0wXPapvM2Rn6UGg1jsUb3YxZ5oYzb
         /dmQ0euZBdURjWZFQBAcjCur0f5LE4a4QIr431VQfeJpSUYBdzLv+0DfFg0lNXcoJ9nH
         RQlrL5x4v+mXpdYv71c8RiXM0kRwaK5kqYTRFtWWIn6mqeHJWxdVCpg9U0s7TRiZUv4D
         Vi6wJ3ntd0c22teQ7TC2M81cJbxBDoAfvKWV4TPTmlqwFu8k9qZkicl2boX+A4zfco7z
         Pcuw==
X-Gm-Message-State: AOAM532aikLcX+Z1SNPC8zabGWN9gvLmWE20D0uwBouF912S+oT+tzjo
        P27+vkn26aiSl22uPVs7E4MuGf4gkveitQ==
X-Google-Smtp-Source: ABdhPJwDcYYwCGKKEg3Fh/OqUBiIvHpEHOgYYu3EEbi5YFG/5oxLc78WjFgsF7eH9VGshV0Mk+dAPg==
X-Received: by 2002:a05:600c:3581:: with SMTP id p1mr24631290wmq.76.1619527298029;
        Tue, 27 Apr 2021 05:41:38 -0700 (PDT)
Received: from agape.jhs ([5.171.81.92])
        by smtp.gmail.com with ESMTPSA id t2sm2668228wmg.38.2021.04.27.05.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 05:41:37 -0700 (PDT)
Date:   Tue, 27 Apr 2021 14:41:35 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 50/50] staging: rtl8723bs: macro DRIVER_PREFIX expands
 to lowercase driver name
Message-ID: <20210427124134.GA1399@agape.jhs>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
 <c986e9a3c9b2f73cb784bd5dc7c877eb9a669c89.1619254603.git.fabioaiuto83@gmail.com>
 <YIfvqU2bEpDSj/hK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIfvqU2bEpDSj/hK@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 01:04:09PM +0200, Greg KH wrote:
> On Sat, Apr 24, 2021 at 11:02:33AM +0200, Fabio Aiuto wrote:
> > macro DRIVER_PREFIX expands to lowercase driver name.
> > 
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/include/rtw_debug.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
> > index 189f02a8300a..3a5b083e95a1 100644
> > --- a/drivers/staging/rtl8723bs/include/rtw_debug.h
> > +++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
> > @@ -7,7 +7,7 @@
> >  #ifndef __RTW_DEBUG_H__
> >  #define __RTW_DEBUG_H__
> >  
> > -#define DRIVER_PREFIX "RTL8723BS: "
> > +#define DRIVER_PREFIX "rtl8723bs: "
> 
> KBUILD_MODNAME should be used here, in the future.

ok, got it

> 
> But really, this shouldn't be needed at all, it's kind of pointless (if
> it is being used, then odds are the places it is being used is wrong...)
> 
> thanks,
> 
> greg k-h

fabio@agape:~/src/git/kernels/staging$ grep -r DRIVER_PREFIX drivers/staging/rtl8723bs/
drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c:	print_hex_dump_debug(DRIVER_PREFIX ": u1H2CRsvdPageParm:", DUMP_PREFIX_NONE,
drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c:	print_hex_dump_debug(DRIVER_PREFIX ": u1H2CMediaStatusRptParm:", DUMP_PREFIX_NONE,
drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c:	print_hex_dump_debug(DRIVER_PREFIX ": u1H2CMacIdConfigParm:", DUMP_PREFIX_NONE,
drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c:	print_hex_dump_debug(DRIVER_PREFIX ": u1H2CRssiSettingParm:", DUMP_PREFIX_NONE,
drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c:	print_hex_dump_debug(DRIVER_PREFIX ": u1H2CPwrModeParm:", DUMP_PREFIX_NONE,
drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c:	print_hex_dump_debug(DRIVER_PREFIX ": u1H2CPsTuneParm:", DUMP_PREFIX_NONE,
drivers/staging/rtl8723bs/hal/hal_com.c:	print_hex_dump_debug(DRIVER_PREFIX ": c2h_evt_read(): ", DUMP_PREFIX_NONE,
drivers/staging/rtl8723bs/hal/hal_com.c:	print_hex_dump_debug(DRIVER_PREFIX ": c2h_evt_read(): Command Content:\n",
drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:	print_hex_dump_debug(DRIVER_PREFIX ": C2HPacketHandler_8723B(): Command Content:\n",
drivers/staging/rtl8723bs/include/rtw_debug.h:#define DRIVER_PREFIX "rtl8723bs: "

When I recently changed the old macro printing hex dump I
decided to keep DRIVER_PREFIX. But I can replace it by
KBUILD_MODNAME.

Thank you,

fabio
