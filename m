Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9B3A7158
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 23:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbhFNVc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 17:32:58 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:44585 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbhFNVc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 17:32:57 -0400
Received: by mail-wm1-f43.google.com with SMTP id m41-20020a05600c3b29b02901b9e5d74f02so751728wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nP5tGlZH8Co2bbVnolPJO1v0bwhg1y8GoH8zpay9l8k=;
        b=DpuwwGwnVdKNlO8r1bg5yYIOSh5ebGwucBJUU9jYkGbyAEkj/hkWOJFZocZCUxD5es
         Hin96InEZF1JLzgEqX6hyOlGWqgwEUQvmfgmzSRZdo3mBQA7AUuPhETnR5KW2ZGR95Uy
         gmhEL2b26Xyij1CDaMHnqGsxn5D2EXF90yh83ebZI4YiB6zHI2kjRF/8kyjlhhqW/6B5
         vCST/lzojhKxywnnb2Adf0V1DLTf1MJ/gMYtLoy9BaaDNmXz4q9TzHXeCMEc0ahFPRd+
         w6ooBCto3b999VDYcdHNfIn8kjRXNrQZRTlzMMi1iP3hi5wMj+oRXGANHa8hSFUtoGNi
         +6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nP5tGlZH8Co2bbVnolPJO1v0bwhg1y8GoH8zpay9l8k=;
        b=oiAEdhJweN2ODOlnbnYeNYgh4gWjVcotQm1e8B+m6dJg2HrOwSqBZSiv2MmKauFW0Q
         9Tsw44JysuEfqEz3qw8lOyn6Lb8I7eu4F7MfL8ge4zOPHytKas1KfaVwJeOsBrOanGYL
         4Tr+5bcDiuMjgCxuqVP58KEoTWkK1cMfzvN9XYht0hcXmWi4e1mUMp5H6KmpH5elUQAZ
         DjiomuBtx90tdacEzr/9XyRJymx/KLs4XP3i80oTJveY5nfvKAM3JG/jNyq+1GIA8BUx
         d03QVlC3ltfVvWVuvLj59F8N3TT/hVL8aeReIctNHhhDV0nrLl7nAlICRMhTzudHfZtQ
         vqRQ==
X-Gm-Message-State: AOAM531iyM3Fg4McSHGSq+nhIt5ML4x98/piAhz1wD14lKTq+Nzf7n95
        uTKfE5WJxfHIqBHETf5eOe+dPA==
X-Google-Smtp-Source: ABdhPJyVjpmmNe9DyFFeIse3WWTe6e+s+HD4VSTsnhU0IDUncTVPAsl0HTW2Qdzo+NLqF/0WbaBx3Q==
X-Received: by 2002:a05:600c:190f:: with SMTP id j15mr12011635wmq.37.1623706187441;
        Mon, 14 Jun 2021 14:29:47 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id j34sm469020wms.19.2021.06.14.14.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 14:29:46 -0700 (PDT)
Date:   Mon, 14 Jun 2021 22:29:44 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        insafonov@gmail.com, linux@roeck-us.net, straube.linux@gmail.com,
        liushixin2@huawei.com, gustavoars@kernel.org,
        christophe.jaillet@wanadoo.fr, yepeilin.cs@gmail.com,
        martin@kaiser.cx, simon.fodin@gmail.com, romain.perier@gmail.com,
        apais@linux.microsoft.com, mh12gx2825@gmail.com
Subject: Re: [PATCH 1/3] staging: rtl8188eu: convert DBG_88E calls in
 core/rtw_efuse.c
Message-ID: <YMfKSCtA86Rg5e6O@equinox>
References: <20210613224147.1045-1-phil@philpotter.co.uk>
 <20210613224147.1045-2-phil@philpotter.co.uk>
 <20210614065019.GK1955@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614065019.GK1955@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 09:50:19AM +0300, Dan Carpenter wrote:
> On Sun, Jun 13, 2021 at 11:41:45PM +0100, Phillip Potter wrote:
> > Convert all calls to the DBG_88E macro in core/rtw_efuse.c into
> > netdev_dbg calls. The DBG_88E macro is unnecessary, as visibility of
> > debug messages can be controlled more precisely by just using debugfs.
> > It is important to keep these messages still, as they are displayable
> > via a kernel module parameter when using DBG_88E.
> > 
> 
> These are not 100% dead code like the previous debug macros but I think
> we are better off doing another mass delete.
> 
> > Also modify efuse_phymap_to_logical function signature to pass through
> > a struct net_device pointer, so that we can use it to call netdev_dbg
> > in this function too.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >  drivers/staging/rtl8188eu/core/rtw_efuse.c | 27 ++++++++++++++--------
> >  1 file changed, 17 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
> > index 9bb3ec0cd62f..019796c0f1af 100644
> > --- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
> > +++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
> > @@ -72,7 +72,7 @@ static void efuse_power_switch(struct adapter *pAdapter, u8 write, u8 pwrstate)
> >  }
> >  
> >  static void
> > -efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
> > +efuse_phymap_to_logical(struct net_device *dev, u8 *phymap, u16 _offset, u16 _size_byte, u8 *pbuf)
> >  {
> >  	u8 *efuseTbl = NULL;
> >  	u8 rtemp8;
> > @@ -92,7 +92,7 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
> >  		      sizeof(void *) + EFUSE_MAX_WORD_UNIT * sizeof(u16),
> >  		      GFP_KERNEL);
> >  	if (!tmp) {
> > -		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
> > +		netdev_dbg(dev, "alloc eFuseWord fail!\n");
> 
> This print is pointless and wrong.  It shouldn't be a debug printk it
> should be an error message.  But kcalloc() already has an error message
> built in and adding an additional warning here will lead to a checkpatch
> complaint.
> 
> >  		goto eFuseWord_failed;
> >  	}
> >  	for (i = 0; i < EFUSE_MAX_SECTION_88E; i++)
> > @@ -113,7 +113,9 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
> >  		efuse_utilized++;
> >  		eFuse_Addr++;
> >  	} else {
> > -		DBG_88E("EFUSE is empty efuse_Addr-%d efuse_data =%x\n", eFuse_Addr, rtemp8);
> > +		netdev_dbg(dev,
> > +			   "EFUSE is empty efuse_Addr-%d efuse_data =%x\n",
> > +			   eFuse_Addr, rtemp8);
> 
> I don't know enough to say if this is useful or not, but I'm really
> skeptical.
> 
> >  		goto exit;
> >  	}
> >  
> > @@ -220,7 +222,7 @@ static void efuse_read_phymap_from_txpktbuf(
> >  	if (bcnhead < 0) /* if not valid */
> >  		bcnhead = usb_read8(adapter, REG_TDECTRL + 1);
> >  
> > -	DBG_88E("%s bcnhead:%d\n", __func__, bcnhead);
> > +	netdev_dbg(adapter->pnetdev, "bcnhead:%d\n", bcnhead);
> 
> The only caller is efuse_ReadEFuse() and bcnhead is always zero.  All
> these checks and debug code can be deleted.
> 
> >  
> >  	usb_write8(adapter, REG_PKT_BUFF_ACCESS_CTRL, TXPKT_BUF_SELECT);
> >  
> > @@ -232,8 +234,10 @@ static void efuse_read_phymap_from_txpktbuf(
> >  		usb_write8(adapter, REG_TXPKTBUF_DBG, 0);
> >  		start = jiffies;
> >  		while (!(reg_0x143 = usb_read8(adapter, REG_TXPKTBUF_DBG)) &&
> > -		       jiffies_to_msecs(jiffies - start) < 1000) {
> > -			DBG_88E("%s polling reg_0x143:0x%02x, reg_0x106:0x%02x\n", __func__, reg_0x143, usb_read8(adapter, 0x106));
> > +			jiffies_to_msecs(jiffies - start) < 1000) {
> > +			netdev_dbg(adapter->pnetdev,
> > +				   "polling reg_0x143:0x%02x, reg_0x106:0x%02x\n",
> > +				   reg_0x143, usb_read8(adapter, 0x106));
> 
> This is the wrong place to put debug code.  If the loop timesout it will
> print a thousand messages.  See?  So far whenever we can understand the
> code enough to say, then it's totally rubbish.
> 
> Just do a mass delete.  You won't ever regret it.
> 
> >  			usleep_range(1000, 2000);
> >  		}
> >  
> 
> regards,
> dan carpenter
> 

Dear Dan,

Thank you for this, and your other feedback. Mass delete works for me, I
shall get started :-)

Regards,
Phil
