Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE0D36E7C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbhD2JRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhD2JRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:17:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B522C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:16:27 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i3so51984454edt.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pns6JVw1tsF1/qIxAMsi+w1qWpoEsDD9F2ufA8tB/tE=;
        b=LcICwlVTNEWQJ/kXzV3Qf010nnyK82+SA0OXfpGqqw86m6XUQ13LPjKjye6jQ/rh4z
         OrLA2NkxjZz8deFsSQW6xG2OxR3qnTDtxlQErrUDH4Dx3hGsfpICuqPJafaRrsKmrDmn
         9U/pS3PGwc/p9zxrt9ILSwlKKhHctgm3rqtP5H7bxXbaU6+rIPXbmcARxB8Zd3lAsBXn
         l+n7i1T1ulzV0Xx//OAoixznSOaEot/nrXI2YP0d2wpzqcDE41o68iXBi9B5Dze0ECn3
         kBqe9rE2DDWQyrL5jO+QkUhMhteM1RfOmrrlzQt9cBg6rcGn3oOZyoMKbsos1APdd7a3
         HkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pns6JVw1tsF1/qIxAMsi+w1qWpoEsDD9F2ufA8tB/tE=;
        b=ia0r08F7wSw1nn8CkZMH2yS+f1M5qFPCYxFTb1kTK7r0hnG5pL4AUiWAmoewQ9VsFo
         XURFhvIjNJL2MG8fmelWCMDoU3g6Uy+joFP7Lv8/IfbOlrxMGpAixOtSCHc74P2rudtQ
         FWc7t+jUH9YvxkCtJsIbbJA+rkOzbSN/IT2sBldEKBgMpCGQGAUbGLGBmQDNCyoW/3Cs
         BNVCcCYUNJ3bYdWqCbXll9vDOAvAdzlm2Qgfw2ncj5Nc+Cd2GYljnSE76RMtleOL300Y
         P4hdy8Q0iZf8TxZqEbR1GeXemMql4M1aRTqx31OfWqSzR2VnKjcW9/ylEsDJloZ5F/bG
         Ngmw==
X-Gm-Message-State: AOAM532NIKMj0faQ83i1s0jEXlbQqYB1v7dsjuq1fePPcwXCfm/bcbAp
        iR1wY3DC358uhFWVy/IjNsyCpyD+5pCVGQ==
X-Google-Smtp-Source: ABdhPJxjSCuoBN3SsqvGYK1hxB2DnMzqSLY8VA/cbtvx2pFCJQg5OGzEbwKGFlo953NBo2N9x55OOQ==
X-Received: by 2002:aa7:c30c:: with SMTP id l12mr13555061edq.217.1619687786148;
        Thu, 29 Apr 2021 02:16:26 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id a22sm1881378edu.14.2021.04.29.02.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 02:16:25 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 1/2] staging: rtl8723bs: hal: Remove set but unused variables
Date:   Thu, 29 Apr 2021 11:16:24 +0200
Message-ID: <2336223.vu2A7xvVi3@linux.local>
In-Reply-To: <20210429082552.GC1409@agape.jhs>
References: <20210428113346.28305-1-fmdefrancesco@gmail.com> <8266064.IJzC9MfcRG@linux.local> <20210429082552.GC1409@agape.jhs>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 29, 2021 10:25:53 AM CEST Fabio Aiuto wrote:
> On Thu, Apr 29, 2021 at 09:44:47AM +0200, Fabio M. De Francesco wrote:
> > On Thursday, April 29, 2021 9:26:20 AM CEST Fabio Aiuto wrote:
> > > Hi Fabio,
> > > 
> > > On Wed, Apr 28, 2021 at 01:33:45PM +0200, Fabio M. De Francesco wrote:
> > > > Removed four set but unused variables. Issue detected by gcc.
> > > > 
> > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > ---
> > > > 
> > > >  drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 5 -----
> > > >  1 file changed, 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > > > b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c index
> > 
> > 082448557b53..96cb4426a0f4
> > 
> > > > 100644
> > > > --- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > > > +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > > > @@ -3900,14 +3900,11 @@ u8 GetHalDefVar8723B(struct adapter *padapter,
> > 
> > enum
> > 
> > > > hal_def_variable variable, v>
> > > > 
> > > >  			u32 cmd;
> > > >  			u32 ra_info1, ra_info2;
> > > >  			u32 rate_mask1, rate_mask2;
> > > > 
> > > > -			u8 curr_tx_rate, curr_tx_sgi, hight_rate,
> > 
> > lowest_rate;
> > 
> > > >  			cmd = 0x40000100 | mac_id;
> > > >  			rtw_write32(padapter,
> > 
> > REG_HMEBOX_DBG_2_8723B, cmd);
> > 
> > > >  			msleep(10);
> > > >  			ra_info1 = rtw_read32(padapter, 0x2F0);
> > > > 
> > > > -			curr_tx_rate = ra_info1&0x7F;
> > > > -			curr_tx_sgi = (ra_info1>>7)&0x01;
> > > > 
> > > >  			cmd = 0x40000400 | mac_id;
> > > >  			rtw_write32(padapter,
> > 
> > REG_HMEBOX_DBG_2_8723B, cmd);
> > 
> > > > @@ -3916,8 +3913,6 @@ u8 GetHalDefVar8723B(struct adapter *padapter, 
enum
> > > > hal_def_variable variable, v>
> > > > 
> > > >  			ra_info2 = rtw_read32(padapter, 0x2F4);
> > > >  			rate_mask1 = rtw_read32(padapter, 0x2F8);
> > > >  			rate_mask2 = rtw_read32(padapter, 0x2FC);
> > > > 
> > > > -			hight_rate = ra_info2&0xFF;
> > > > -			lowest_rate = (ra_info2>>8)  & 0xFF;
> > > > 
> > > >  		}
> > > >  		break;
> > > 
> > > rate_mask{1,2} and ra_info{1,2} seems to be unused as well.
> > > 
> > > thank you,
> > > 
> > > fabio
> > 
> > Hello Fabio,
> > 
> > I'm not sure about it: rtw_read32 calls a pointer to a function. I'm don't
> > know drivers programming, however that function looks like an 
implementation
> > of a read() system call. So I wouldn't be so sure to remove those calls.
> > 
> > Could calling a (*read) method have side effects on subsequent read()? I 
mean:
> > could it update some internal data structure? If not I can remove the
> > variables you mentioned above and the calls to read32.
> > 
> > I'm looking forward to read your reply.
> > 
> > Thanks,
> > 
> > Fabio
> 
> hi Fabio,
> 
> rtw_read32 is a macro wrapping _rtw_read32() defined as follows (in core/
rtw_io.c):
>
Hi Fabio,

Thanks a lot for your reply.

However, There is something less than clear to me... how did you find that 
rtw_read32 is a macro wrapping _rtw_read32()? I mean: I knew that, in vim, one 
can go to the definition of something by using ctrl-] key.

If I do that on rtw_read32 it takes me to a static definition of it in 
drivers/net/wireless/realtek/rtw88/hci.h. This is a one line function:

static inline void rtw_write32(struct rtw_dev *rtwdev, u32 addr, u32 val)
{       
        rtwdev->hci.ops->write32(rtwdev, addr, val);
}

When I use ctrl-] on write32() it takes me to struct rtw_hci_ops in drivers/
net/wireless/realtek/rtw88/hci.h.

After that I wanted to find where the member (*read32)() is assigned but I 
don't know where and how to grep it: I tried "grep -rn "\bwrite32\b=" drivers/
staging/rtl8723bs/" but I found nothing...

Can you please explain what I'm doing wrong in following the path I mentioned 
above and how you find out that macro?

Thanks for your time,

Fabio 
> 
> u32 _rtw_read32(struct adapter *adapter, u32 addr)
> {
>         u32 r_val;
>         /* struct       io_queue        *pio_queue = (struct io_queue
> *)adapter->pio_queue; */ struct io_priv *pio_priv = &adapter->iopriv;
>         struct  intf_hdl                *pintfhdl = &(pio_priv->intf);
>         u32 (*_read32)(struct intf_hdl *pintfhdl, u32 addr);
> 
>         _read32 = pintfhdl->io_ops._read32;
> 
>         r_val = _read32(pintfhdl, addr);
>         return rtw_le32_to_cpu(r_val);
> 
> }
> 
> the actual read seems to be performed by the handler contained in
> 
> 	pintfhdl->io_ops._read32;
> 
> so:
> 
> $ grep -r '\b_read32' drivers/staging/rtl8723bs/
> 
> drivers/staging/rtl8723bs/hal/sdio_ops.c:	ops->_read32 = 
&sdio_read32;
> 
> this is the place where _read32 is stored with sdio_read32 reference...
> 
> drivers/staging/rtl8723bs/core/rtw_io.c:	u32 (*_read32)(struct 
intf_hdl *pintfhdl, u32
> addr); drivers/staging/rtl8723bs/core/rtw_io.c:	_read32 = pintfhdl-
>io_ops._read32;
> ...
> 
> if you check it in hal/sdio_ops.c, nothing is written, just reads are
> performed (and it's not odd, for a read function isn't supposed to write
> something under the hood ;)).
> 
> I think those variables could be easily removed as W=1 gcc suggests.
> 
> thank you,
> 
> fabio




