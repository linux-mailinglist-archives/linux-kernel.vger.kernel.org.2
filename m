Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EA836D4C7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 11:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbhD1J3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 05:29:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:41870 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230113AbhD1J3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:29:46 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13S9QCZ2015184;
        Wed, 28 Apr 2021 09:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=lHWeZ3BeUXe3URXXKdQUDpz+De+l/11yY0u61rYxOJk=;
 b=Qa7YUJi+iB20JVWjfT80f1u1f0IOdz4ysepM+BkpYwJ/cZNOi0ODxnF51sgUVChpL5i2
 eryrb58mu+tIyAEXal/6SfHQzH0rXxrTq20e7TPkjHEyCDU48sL7C+EE5YoVcHI4rSp0
 QEryHir3elqcgZtgrY38kwCdb5+sOU1OWXzoGiEmLeQNDqoOQL+56CyA58nCF5fblBbB
 cyUhIjuCnje8NOlLTTwIMIv9zUToAaGtjJYLh+y2MKexGZwU+0L/TWuEx2PYIdFZbu80
 oVCRmqCqFHDTNLLP+XBrlen8OkOf8ZDwNrX77jpTA730ZXg+8qS1AqtL8Do2M9M7y5ef UA== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3874kn0166-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 09:28:51 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13S9Pl5Y102139;
        Wed, 28 Apr 2021 09:28:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3848ey8y00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 09:28:50 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13S9SoYB110347;
        Wed, 28 Apr 2021 09:28:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3848ey8xyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 09:28:50 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13S9SmEx014503;
        Wed, 28 Apr 2021 09:28:48 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Apr 2021 09:28:47 +0000
Date:   Wed, 28 Apr 2021 12:28:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/49] staging: rtl8723bs: replace DBG_871X_SEL log macro
 with netdev_dbg()
Message-ID: <20210428092842.GQ1981@kadam>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
 <9e6a1e4dc8962bfd58375be98619c76e8e28febe.1619189489.git.fabioaiuto83@gmail.com>
 <0a68fbfffba4cc801814e3af1e3a7571928c1921.camel@perches.com>
 <20210423165249.GA1419@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210423165249.GA1419@agape.jhs>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: 9y6pfSdCoWfa2bZxVf9gO_UJlX3sfjNB
X-Proofpoint-ORIG-GUID: 9y6pfSdCoWfa2bZxVf9gO_UJlX3sfjNB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 06:52:49PM +0200, Fabio Aiuto wrote:
> On Fri, Apr 23, 2021 at 08:27:58AM -0700, Joe Perches wrote:
> > On Fri, 2021-04-23 at 16:57 +0200, Fabio Aiuto wrote:
> > > replace DBG_871X_SEL log macro with the net device driver
> > > recommended netdev_dbg().
> > > 
> > > This macro by default does a raw printk, and the alternative
> > > behaviour, never triggered is a seq_print() call.
> > []
> > > diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
> > []
> > > @@ -23,9 +23,10 @@ void mac_reg_dump(void *sel, struct adapter *adapter)
> > >  	for (i = 0x0; i < 0x800; i += 4) {
> > >  		if (j%4 == 1)
> > >  			netdev_dbg(adapter->pnetdev, "0x%03x", i);
> > > -		DBG_871X_SEL(sel, " 0x%08x ", rtw_read32(adapter, i));
> > > +		netdev_dbg(adapter->pnetdev, " 0x%08x ",
> > > +			   rtw_read32(adapter, i));
> > >  		if ((j++)%4 == 0)
> > > -			DBG_871X_SEL(sel, "\n");
> > > +			netdev_dbg(adapter->pnetdev, "\n");
> > >  	}
> > 
> > This makes a mess of the output as each netdev_dbg call
> > is a separate line.
> > 
> > Dumping 1000 register lines into output logs seems impolite
> > at best, even for debugging.
> > 
> > This _might_ be rewritten to something like:
> > 
> > void dump_4_regs(struct adapter *adapter, int offset)
> > {
> > 	u32 reg[4];
> > 	int i;
> > 
> > 	for (i = 0; i < 4; i++)
> > 		reg[i] = rtw_read32(adapter, offset + i);
> > 
> > 	netdev_dbg(adapter->pnetdev, "0x%03x 0x%08x 0x%08x 0x%08x 0x%08x\n",
> > 		   i, reg[0], reg[1], reg[2], reg[3]);
> > }
> > 
> > void mac_reg_dump(...)
> > {
> > 	...
> > 
> > 	for (i = 0; i < 0x800; i += 4)
> > 		dump_4_regs(adapter, i);
> > 
> > 
> > 
> 
> interesting, sure that will be matter of another patch series,
> the ugly output was already there, old macro used to wrap a raw
> printk...

The raw printk doesn't automatically add a new line at the end but a
netdev_dbg() does.  (You're still supposed to add a manual \n to those
but if you don't the lower layers will do it automatically.)

regards,
dan carpenter
