Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BBB3A5D43
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 08:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhFNGxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 02:53:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49146 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232096AbhFNGxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 02:53:11 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E6oYKb015802;
        Mon, 14 Jun 2021 06:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=6TxtYVbVeN40PyX2z0lSuHmK/znkiN1r2HxaM/JDI8E=;
 b=EtKWoTpZNqHvX6O7FkHqI3ZJ+nlLjDDtmx6UVcMtz/agX/vEACHDvsewOD2YoP+/3Sp+
 N2R6NhaHw7PMyRxkEgzu59EDTHPpHkdPRWsBYmX0RYh4ILwGLjpCRp7WIq2v2hO29ho4
 twffcc9BPCGmFz2AU2B2rME4WMX43Oblha+/tK1BD/+5yPekfqWIo4cHwqasJ0FAA5cb
 O+Ctb7Z7NYXRocXTC/jEOZHVVeRWAOc67saLBz3zTCcmAC+OIZ1eQ+8mkgIndnnNaYD5
 sezkGNc1/w1Yg+vDasFLtjDll4TKWohr8AQGS+BS0QwNozu8C52qFQdKK1QUNLIXjRz4 0g== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 395nsar5kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 06:50:34 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15E6mq4b103874;
        Mon, 14 Jun 2021 06:50:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 394j1sr6vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 06:50:33 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15E6oWlI107503;
        Mon, 14 Jun 2021 06:50:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 394j1sr6ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 06:50:32 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15E6oTH2029541;
        Mon, 14 Jun 2021 06:50:29 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 13 Jun 2021 23:50:28 -0700
Date:   Mon, 14 Jun 2021 09:50:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        insafonov@gmail.com, linux@roeck-us.net, straube.linux@gmail.com,
        liushixin2@huawei.com, gustavoars@kernel.org,
        christophe.jaillet@wanadoo.fr, yepeilin.cs@gmail.com,
        martin@kaiser.cx, simon.fodin@gmail.com, romain.perier@gmail.com,
        apais@linux.microsoft.com, mh12gx2825@gmail.com
Subject: Re: [PATCH 1/3] staging: rtl8188eu: convert DBG_88E calls in
 core/rtw_efuse.c
Message-ID: <20210614065019.GK1955@kadam>
References: <20210613224147.1045-1-phil@philpotter.co.uk>
 <20210613224147.1045-2-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210613224147.1045-2-phil@philpotter.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: PQPSBgZy1pfrK3gxTF83Riqc2ioIc4pc
X-Proofpoint-ORIG-GUID: PQPSBgZy1pfrK3gxTF83Riqc2ioIc4pc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 11:41:45PM +0100, Phillip Potter wrote:
> Convert all calls to the DBG_88E macro in core/rtw_efuse.c into
> netdev_dbg calls. The DBG_88E macro is unnecessary, as visibility of
> debug messages can be controlled more precisely by just using debugfs.
> It is important to keep these messages still, as they are displayable
> via a kernel module parameter when using DBG_88E.
> 

These are not 100% dead code like the previous debug macros but I think
we are better off doing another mass delete.

> Also modify efuse_phymap_to_logical function signature to pass through
> a struct net_device pointer, so that we can use it to call netdev_dbg
> in this function too.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/staging/rtl8188eu/core/rtw_efuse.c | 27 ++++++++++++++--------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
> index 9bb3ec0cd62f..019796c0f1af 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
> @@ -72,7 +72,7 @@ static void efuse_power_switch(struct adapter *pAdapter, u8 write, u8 pwrstate)
>  }
>  
>  static void
> -efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
> +efuse_phymap_to_logical(struct net_device *dev, u8 *phymap, u16 _offset, u16 _size_byte, u8 *pbuf)
>  {
>  	u8 *efuseTbl = NULL;
>  	u8 rtemp8;
> @@ -92,7 +92,7 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
>  		      sizeof(void *) + EFUSE_MAX_WORD_UNIT * sizeof(u16),
>  		      GFP_KERNEL);
>  	if (!tmp) {
> -		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
> +		netdev_dbg(dev, "alloc eFuseWord fail!\n");

This print is pointless and wrong.  It shouldn't be a debug printk it
should be an error message.  But kcalloc() already has an error message
built in and adding an additional warning here will lead to a checkpatch
complaint.

>  		goto eFuseWord_failed;
>  	}
>  	for (i = 0; i < EFUSE_MAX_SECTION_88E; i++)
> @@ -113,7 +113,9 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
>  		efuse_utilized++;
>  		eFuse_Addr++;
>  	} else {
> -		DBG_88E("EFUSE is empty efuse_Addr-%d efuse_data =%x\n", eFuse_Addr, rtemp8);
> +		netdev_dbg(dev,
> +			   "EFUSE is empty efuse_Addr-%d efuse_data =%x\n",
> +			   eFuse_Addr, rtemp8);

I don't know enough to say if this is useful or not, but I'm really
skeptical.

>  		goto exit;
>  	}
>  
> @@ -220,7 +222,7 @@ static void efuse_read_phymap_from_txpktbuf(
>  	if (bcnhead < 0) /* if not valid */
>  		bcnhead = usb_read8(adapter, REG_TDECTRL + 1);
>  
> -	DBG_88E("%s bcnhead:%d\n", __func__, bcnhead);
> +	netdev_dbg(adapter->pnetdev, "bcnhead:%d\n", bcnhead);

The only caller is efuse_ReadEFuse() and bcnhead is always zero.  All
these checks and debug code can be deleted.

>  
>  	usb_write8(adapter, REG_PKT_BUFF_ACCESS_CTRL, TXPKT_BUF_SELECT);
>  
> @@ -232,8 +234,10 @@ static void efuse_read_phymap_from_txpktbuf(
>  		usb_write8(adapter, REG_TXPKTBUF_DBG, 0);
>  		start = jiffies;
>  		while (!(reg_0x143 = usb_read8(adapter, REG_TXPKTBUF_DBG)) &&
> -		       jiffies_to_msecs(jiffies - start) < 1000) {
> -			DBG_88E("%s polling reg_0x143:0x%02x, reg_0x106:0x%02x\n", __func__, reg_0x143, usb_read8(adapter, 0x106));
> +			jiffies_to_msecs(jiffies - start) < 1000) {
> +			netdev_dbg(adapter->pnetdev,
> +				   "polling reg_0x143:0x%02x, reg_0x106:0x%02x\n",
> +				   reg_0x143, usb_read8(adapter, 0x106));

This is the wrong place to put debug code.  If the loop timesout it will
print a thousand messages.  See?  So far whenever we can understand the
code enough to say, then it's totally rubbish.

Just do a mass delete.  You won't ever regret it.

>  			usleep_range(1000, 2000);
>  		}
>  

regards,
dan carpenter

