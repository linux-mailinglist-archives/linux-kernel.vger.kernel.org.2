Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5714636E636
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbhD2Hpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238725AbhD2Hph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:45:37 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8440C06138D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 00:44:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c22so13735552edn.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 00:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xtVs7TfEmRwzWAmFYNn/1ie8SKDyEvQHZvznz6h8vCk=;
        b=Y909H3kAJY9TbcLOqwZb+b99Qt94slgkmDVCFE5B9rjyqVApOqWz24sjWpYXtfrC/8
         /5+GjpCs40X15b4cjR6xJBgya95knjs9b4E81MUep63ejLOxfpc/oWeVX9uT/9j+U3x+
         v8itdaKF0IlnXED/AZjbsodSj/1FNLuFw+vBUDYtO3qmecnhw3woArEgakKkrRtZi+sl
         NlM1PkpFGrrNRprNx3T+ykjtw09AzTWkHXNisXK79cS730tTnnssQHbyES34DIP08Swv
         /VrcliBYYCeZINaVvDLTRVqgVJP4FGgDxtiNnwVjJfIFShau1MepNYJXsxp542cLSpup
         SM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xtVs7TfEmRwzWAmFYNn/1ie8SKDyEvQHZvznz6h8vCk=;
        b=UBl+jR3meqw3MjbMsjlc1pOP+TZYWe889phTkr4xx9xsPR4rmJ8bbb/Pe6O4XCQ02O
         ittwcolWWnwWP6MkP6WHHEuLbTt2v6d+P1IBf4rRCNjiey+X6Z3bLfrmwO3N63Htcbvc
         3Ar++hi1uEstxfHJnRwBzaW/qFzJax82lHcB4DLXoKIyYjNiQlOTMoLvV5odmTjQyuRC
         fNyj6ZMFu9CUKkeC23gPHECyxH5qc60W8t6GFp+wVYj/Jv+GDVPB4AcL2ocFTmC33nu1
         GBK1wZ2o4dk2NVhDBVZgPx4mMmsrWty1vryCyWoou6McmZC2f2W7FNpzF0CiAD30W47U
         dsKw==
X-Gm-Message-State: AOAM533FgAGprno7BVs3islZ22bBYKk+zFT8Dv2eeJfPPqrc4ut/anDv
        ykIVxIGNkC5O3M7BDflrf7M=
X-Google-Smtp-Source: ABdhPJyrrKaRA/ZmvW0BJRd6lzmh1vhY8zJhiqjTuGkuRYZjR/4UuAzmvwhWcOdaDKjo/S5PTTBHzA==
X-Received: by 2002:aa7:c454:: with SMTP id n20mr16907847edr.138.1619682289384;
        Thu, 29 Apr 2021 00:44:49 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id j7sm1731173edv.40.2021.04.29.00.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 00:44:48 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 1/2] staging: rtl8723bs: hal: Remove set but unused variables
Date:   Thu, 29 Apr 2021 09:44:47 +0200
Message-ID: <8266064.IJzC9MfcRG@linux.local>
In-Reply-To: <20210429072619.GB1409@agape.jhs>
References: <20210428113346.28305-1-fmdefrancesco@gmail.com> <20210428113346.28305-2-fmdefrancesco@gmail.com> <20210429072619.GB1409@agape.jhs>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 29, 2021 9:26:20 AM CEST Fabio Aiuto wrote:
> Hi Fabio,
> 
> On Wed, Apr 28, 2021 at 01:33:45PM +0200, Fabio M. De Francesco wrote:
> > Removed four set but unused variables. Issue detected by gcc.
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> >  drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c index 
082448557b53..96cb4426a0f4
> > 100644
> > --- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > @@ -3900,14 +3900,11 @@ u8 GetHalDefVar8723B(struct adapter *padapter, 
enum
> > hal_def_variable variable, v> 
> >  			u32 cmd;
> >  			u32 ra_info1, ra_info2;
> >  			u32 rate_mask1, rate_mask2;
> > 
> > -			u8 curr_tx_rate, curr_tx_sgi, hight_rate, 
lowest_rate;
> > 
> >  			cmd = 0x40000100 | mac_id;
> >  			rtw_write32(padapter, 
REG_HMEBOX_DBG_2_8723B, cmd);
> >  			msleep(10);
> >  			ra_info1 = rtw_read32(padapter, 0x2F0);
> > 
> > -			curr_tx_rate = ra_info1&0x7F;
> > -			curr_tx_sgi = (ra_info1>>7)&0x01;
> > 
> >  			cmd = 0x40000400 | mac_id;
> >  			rtw_write32(padapter, 
REG_HMEBOX_DBG_2_8723B, cmd);
> > 
> > @@ -3916,8 +3913,6 @@ u8 GetHalDefVar8723B(struct adapter *padapter, enum
> > hal_def_variable variable, v> 
> >  			ra_info2 = rtw_read32(padapter, 0x2F4);
> >  			rate_mask1 = rtw_read32(padapter, 0x2F8);
> >  			rate_mask2 = rtw_read32(padapter, 0x2FC);
> > 
> > -			hight_rate = ra_info2&0xFF;
> > -			lowest_rate = (ra_info2>>8)  & 0xFF;
> > 
> >  		}
> >  		break;
> 
> rate_mask{1,2} and ra_info{1,2} seems to be unused as well.
> 
> thank you,
> 
> fabio
>
Hello Fabio,

I'm not sure about it: rtw_read32 calls a pointer to a function. I'm don't 
know drivers programming, however that function looks like an implementation 
of a read() system call. So I wouldn't be so sure to remove those calls. 

Could calling a (*read) method have side effects on subsequent read()? I mean: 
could it update some internal data structure? If not I can remove the 
variables you mentioned above and the calls to read32.

I'm looking forward to read your reply.

Thanks,

Fabio



