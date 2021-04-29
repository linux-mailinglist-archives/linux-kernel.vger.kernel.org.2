Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38D136E87C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240311AbhD2KQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240306AbhD2KQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:16:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F3DC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 03:15:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g10so9936012edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 03:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=25ndHCz+X94ohhtLq4HJyXNxXOZ8od+mYUdpWBt4/ic=;
        b=J+SLskxXQrg0iHNvdPF75ucVX97uGG9Ef+g4DVYiD7lgmiNuRzN1VaOe2R3gp8cAIB
         ot5W6hbJ3uJL/s5AmZZqUcwtygtBUMvr4eYSwg362FluLSCSIHd18aAusP9DsFhOgAeN
         tc+HoWfGaNHDiw/Jb8IH7aGJV0tzUuL+oGDy/65hqJWRyikwMP3vhmLeS78eiW69L8Uh
         1gGGbbkZjret72tN+Ef+HgBcWkk/VAb2h/UZrHdD1RKom+lymHifWxAR7WCE7teNo/Na
         d3PsBN9+caL0PSevMGwDxKneQmKpnFFwSBiCco+LrquIFHwnta/HyqnwW/nYI+osRf69
         IM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=25ndHCz+X94ohhtLq4HJyXNxXOZ8od+mYUdpWBt4/ic=;
        b=px0TXroSmdRCwBjuetdFY/hoEYt+VlP6r0z5sBLjKl7Zu3WoS3SMhriYJN2BMsPKVF
         xDktwI4agivXi9ZjPhqwJQt7QAWDRUQk5X7LH4B+IqgYvrpatxqck/hwtzoRaBsDXqKw
         lXkpcmZmxVOgeU/miW1Pqm+EoXBiBjCdgRvFYnDTuGqSIzO7d161K60McHDYGQu1FPw+
         AWxZPlxOKR7XScVwBvKWxB0jsllZa14Qf2YOOPUqoDwZ6A/1LWhkRpeRYxaIk3A4gmZU
         kNv/3hiyCAEg59Y7YhdfWTFVkGALdEIs1GyE5amCdCUZNyR4oYu6nngBrQ/xm9I+C79O
         +CWA==
X-Gm-Message-State: AOAM530VJvR1rw0I3cTa47M+oMC1xwvrWAOOLPtx3Hp0jxHlZ0BnwpCY
        /s6166VqjZlIXUG9xapjXIQ=
X-Google-Smtp-Source: ABdhPJyNQchIwOeJgi3THa6gEtWcN/6fQ0E6WXL8k3RM68G8HblrIiIA6EO++zrI+C2LdgmJNESXQA==
X-Received: by 2002:aa7:cc98:: with SMTP id p24mr17047726edt.187.1619691342277;
        Thu, 29 Apr 2021 03:15:42 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id i19sm1501301ejd.114.2021.04.29.03.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 03:15:41 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 1/2] staging: rtl8723bs: hal: Remove set but unused variables
Date:   Thu, 29 Apr 2021 12:15:40 +0200
Message-ID: <4187627.69DiqvND7d@linux.local>
In-Reply-To: <YIqECQk/1Zb4JRjb@kroah.com>
References: <20210428113346.28305-1-fmdefrancesco@gmail.com> <20210429082552.GC1409@agape.jhs> <YIqECQk/1Zb4JRjb@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 29, 2021 12:01:45 PM CEST Greg Kroah-Hartman wrote:
> On Thu, Apr 29, 2021 at 10:25:53AM +0200, Fabio Aiuto wrote:
> > On Thu, Apr 29, 2021 at 09:44:47AM +0200, Fabio M. De Francesco wrote:
> > > On Thursday, April 29, 2021 9:26:20 AM CEST Fabio Aiuto wrote:
> > > > Hi Fabio,
> > > > 
> > > > On Wed, Apr 28, 2021 at 01:33:45PM +0200, Fabio M. De Francesco wrote:
> > > > > Removed four set but unused variables. Issue detected by gcc.
> > > > > 
> > > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > > ---
> > > > > 
> > > > >  drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 5 -----
> > > > >  1 file changed, 5 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > > > > b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c index
> > > 
> > > 082448557b53..96cb4426a0f4
> > > 
> > > > > 100644
> > > > > --- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > > > > +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > > > > @@ -3900,14 +3900,11 @@ u8 GetHalDefVar8723B(struct adapter 
*padapter,
> > > 
> > > enum
> > > 
> > > > > hal_def_variable variable, v>
> > > > > 
> > > > >  			u32 cmd;
> > > > >  			u32 ra_info1, ra_info2;
> > > > >  			u32 rate_mask1, rate_mask2;
> > > > > 
> > > > > -			u8 curr_tx_rate, curr_tx_sgi, hight_rate,
> > > 
> > > lowest_rate;
> > > 
> > > > >  			cmd = 0x40000100 | mac_id;
> > > > >  			rtw_write32(padapter,
> > > 
> > > REG_HMEBOX_DBG_2_8723B, cmd);
> > > 
> > > > >  			msleep(10);
> > > > >  			ra_info1 = rtw_read32(padapter, 0x2F0);
> > > > > 
> > > > > -			curr_tx_rate = ra_info1&0x7F;
> > > > > -			curr_tx_sgi = (ra_info1>>7)&0x01;
> > > > > 
> > > > >  			cmd = 0x40000400 | mac_id;
> > > > >  			rtw_write32(padapter,
> > > 
> > > REG_HMEBOX_DBG_2_8723B, cmd);
> > > 
> > > > > @@ -3916,8 +3913,6 @@ u8 GetHalDefVar8723B(struct adapter *padapter, 
enum
> > > > > hal_def_variable variable, v>
> > > > > 
> > > > >  			ra_info2 = rtw_read32(padapter, 0x2F4);
> > > > >  			rate_mask1 = rtw_read32(padapter, 0x2F8);
> > > > >  			rate_mask2 = rtw_read32(padapter, 0x2FC);
> > > > > 
> > > > > -			hight_rate = ra_info2&0xFF;
> > > > > -			lowest_rate = (ra_info2>>8)  & 0xFF;
> > > > > 
> > > > >  		}
> > > > >  		break;
> > > > 
> > > > rate_mask{1,2} and ra_info{1,2} seems to be unused as well.
> > > > 
> > > > thank you,
> > > > 
> > > > fabio
> > > 
> > > Hello Fabio,
> > > 
> > > I'm not sure about it: rtw_read32 calls a pointer to a function. I'm 
don't
> > > know drivers programming, however that function looks like an 
implementation
> > > of a read() system call. So I wouldn't be so sure to remove those calls.
> > > 
> > > Could calling a (*read) method have side effects on subsequent read()? I 
mean:
> > > could it update some internal data structure? If not I can remove the
> > > variables you mentioned above and the calls to read32.
> > > 
> > > I'm looking forward to read your reply.
> > > 
> > > Thanks,
> > > 
> > > Fabio
> > 
> > hi Fabio,
> > 
> > rtw_read32 is a macro wrapping _rtw_read32() defined as follows (in core/
rtw_io.c):
> > 
> > u32 _rtw_read32(struct adapter *adapter, u32 addr)
> > {
> > 
> >         u32 r_val;
> >         /* struct       io_queue        *pio_queue = (struct io_queue
> >         *)adapter->pio_queue; */
> >         struct io_priv *pio_priv = &adapter->iopriv;
> >         struct  intf_hdl                *pintfhdl = &(pio_priv->intf);
> >         u32 (*_read32)(struct intf_hdl *pintfhdl, u32 addr);
> >         
> >         _read32 = pintfhdl->io_ops._read32;
> >         
> >         r_val = _read32(pintfhdl, addr);
> >         return rtw_le32_to_cpu(r_val);
> > 
> > }
> > 
> > the actual read seems to be performed by the handler contained in
> > 
> > 	pintfhdl->io_ops._read32;
> > 
> > so:
> > 
> > $ grep -r '\b_read32' drivers/staging/rtl8723bs/
> > 
> > drivers/staging/rtl8723bs/hal/sdio_ops.c:	ops->_read32 = 
&sdio_read32;
> > 
> > this is the place where _read32 is stored with sdio_read32 reference...
> > 
> > drivers/staging/rtl8723bs/core/rtw_io.c:	u32 (*_read32)(struct 
intf_hdl *pintfhdl, u32
> > addr); drivers/staging/rtl8723bs/core/rtw_io.c:	_read32 = pintfhdl-
>io_ops._read32;
> > ...
> > 
> > if you check it in hal/sdio_ops.c, nothing is written, just reads are
> > performed (and it's not odd, for a read function isn't supposed to write
> > something under the hood ;)).
> 
> Yes, but many types of hardware _REQUIRE_ reads to do something.  So
> "read that does nothing" is a requirement for some operations.
> 
> As an example, a write is only guaranteed to have been finished if you
> do a read of the same location back from it on some hardware busses.
> The bus can reorder things, but a write/read of the same location can
> not be reordered.
> 
> Sometimes you have to do reads multiple times to get things to "stick".
> 
> Other times reading from a location changes a state in the hardware
> (horrid but HW designers aren't the brightest at times...)
> 
> So you can NOT just remove reads without knowing that the hardware does
> not require this.  This is an issue where GCC "warnings" mean nothing as
> gcc does not actually know what hardware does, or does not, do for many
> things.
> 
> thanks,
> 
> greg k-h
>
Just to be sure... does it mean that v1 can be applied as-is?

Thanks,

Fabio




