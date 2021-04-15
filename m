Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0D4360B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhDOODA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhDOOC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:02:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1D83611F1;
        Thu, 15 Apr 2021 14:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618495356;
        bh=XRsRg3co/qXNTEemU4be90+r3j3XGshoPO5iz6aG/Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njEKST7WIQ+YXvKO7UEXRZ7HTyTpZE7c2nzjJHA0gUEgR/A03f2tSwOw0cLwnNEza
         SgPs65rjNCi+y2GO254Z1fHbEUdK1sKBo7mGyE0usMQQhwdD/cmDZ+p6eUsdbuTfGg
         UWpusx1czSfAT1GPUUpQmPTasJWSiHitXJ7zQUdw=
Date:   Thu, 15 Apr 2021 16:02:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [PATCH v2 4/5] staging: rtl8192e: rectified spelling mistake and
 replace memcmp with ether_oui_equal
Message-ID: <YHhHeVP3dXBhQ+9J@kroah.com>
References: <cover.1618380932.git.mitaliborkar810@gmail.com>
 <eda8d3401f2f7ff7a61137b4935c6ccb09112e52.1618380932.git.mitaliborkar810@gmail.com>
 <YHak+7LA6LdrUyzU@kroah.com>
 <YHhC1/R6lrWN57JC@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHhC1/R6lrWN57JC@kali>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 07:12:47PM +0530, Mitali Borkar wrote:
> On Wed, Apr 14, 2021 at 10:16:59AM +0200, Greg KH wrote:
> > On Wed, Apr 14, 2021 at 12:26:01PM +0530, Mitali Borkar wrote:
> > > Added a generic function of static inline bool in
> > > include/linux/etherdevice.h to replace memcmp with
> > > ether_oui_equal throughout the execution.
> > > Corrected the misspelled words in this file.
> > > 
> > > Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> > > ---
> > >  
> > > Changes from v1:- Rectified spelling mistake and replaced memcmp with
> > > ether_oui_equal.
> > > 
> > >  drivers/staging/rtl8192e/rtl819x_HTProc.c | 48 +++++++++++------------
> > >  include/linux/etherdevice.h               |  5 +++
> > >  2 files changed, 29 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> > > index ec6b46166e84..ce58feb2af9a 100644
> > > --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> > > +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> > > @@ -43,7 +43,7 @@ u16 MCS_DATA_RATE[2][2][77] = {
> > >  	 810, 720, 810, 900, 900, 990} }
> > >  };
> > >  
> > > -static u8 UNKNOWN_BORADCOM[3] = {0x00, 0x14, 0xbf};
> > > +static u8 UNKNOWN_BROADCOM[3] = {0x00, 0x14, 0xbf};
> > >  
> > >  static u8 LINKSYSWRT330_LINKSYSWRT300_BROADCOM[3] = {0x00, 0x1a, 0x70};
> > >  
> > > @@ -146,16 +146,16 @@ bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
> > >  	bool			retValue = false;
> > >  	struct rtllib_network *net = &ieee->current_network;
> > >  
> > > -	if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
> > > -	    (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
> > > -	    (memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
> > > -	    (memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
> > > -	    (memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
> > > +	if ((ether_oui_equal(net->bssid, BELKINF5D8233V1_RALINK) == 0) ||
> > > +	    (ether_oui_equal(net->bssid, BELKINF5D82334V3_RALINK) == 0) ||
> > > +	    (ether_oui_equal(net->bssid, PCI_RALINK) == 0) ||
> > > +	    (ether_oui_equal(net->bssid, EDIMAX_RALINK) == 0) ||
> > > +	    (ether_oui_equal(net->bssid, AIRLINK_RALINK) == 0) ||
> > >  	    (net->ralink_cap_exist))
> > >  		retValue = true;
> > > -	else if (!memcmp(net->bssid, UNKNOWN_BORADCOM, 3) ||
> > > -		 !memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
> > > -		 !memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ||
> > > +	else if (ether_oui_equal(net->bssid, UNKNOWN_BROADCOM) ||
> > > +		 ether_oui_equal(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM) ||
> > > +		 ether_oui_equal(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM) ||
> > >  		 (net->broadcom_cap_exist))
> > >  		retValue = true;
> > >  	else if (net->bssht.bd_rt2rt_aggregation)
> > > @@ -179,26 +179,26 @@ static void HTIOTPeerDetermine(struct rtllib_device *ieee)
> > >  			pHTInfo->IOTPeer = HT_IOT_PEER_92U_SOFTAP;
> > >  	} else if (net->broadcom_cap_exist) {
> > >  		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
> > > -	} else if (!memcmp(net->bssid, UNKNOWN_BORADCOM, 3) ||
> > > -		 !memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
> > > -		 !memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3)) {
> > > +	} else if (ether_oui_equal(net->bssid, UNKNOWN_BROADCOM) ||
> > > +		   ether_oui_equal(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM) ||
> > > +		   ether_oui_equal(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM)) {
> > >  		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
> > > -	} else if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
> > > -		 (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
> > > -		 (memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
> > > -		 (memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
> > > -		 (memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
> > > -		  net->ralink_cap_exist) {
> > > +	} else if ((ether_oui_equal(net->bssid, BELKINF5D8233V1_RALINK) == 0) ||
> > > +		   (ether_oui_equal(net->bssid, BELKINF5D82334V3_RALINK) == 0) ||
> > > +		   (ether_oui_equal(net->bssid, PCI_RALINK) == 0) ||
> > > +		   (ether_oui_equal(net->bssid, EDIMAX_RALINK) == 0) ||
> > > +		   (ether_oui_equal(net->bssid, AIRLINK_RALINK) == 0) ||
> > > +		   net->ralink_cap_exist) {
> > >  		pHTInfo->IOTPeer = HT_IOT_PEER_RALINK;
> > >  	} else if ((net->atheros_cap_exist) ||
> > > -		(memcmp(net->bssid, DLINK_ATHEROS_1, 3) == 0) ||
> > > -		(memcmp(net->bssid, DLINK_ATHEROS_2, 3) == 0)) {
> > > +		   (ether_oui_equal(net->bssid, DLINK_ATHEROS_1) == 0) ||
> > > +		   (ether_oui_equal(net->bssid, DLINK_ATHEROS_2) == 0)) {
> > >  		pHTInfo->IOTPeer = HT_IOT_PEER_ATHEROS;
> > > -	} else if ((memcmp(net->bssid, CISCO_BROADCOM, 3) == 0) ||
> > > -		  net->cisco_cap_exist) {
> > > +	} else if ((ether_oui_equal(net->bssid, CISCO_BROADCOM) == 0) ||
> > > +		   net->cisco_cap_exist) {
> > >  		pHTInfo->IOTPeer = HT_IOT_PEER_CISCO;
> > > -	} else if ((memcmp(net->bssid, LINKSYS_MARVELL_4400N, 3) == 0) ||
> > > -		  net->marvell_cap_exist) {
> > > +	} else if ((ether_oui_equal(net->bssid, LINKSYS_MARVELL_4400N) == 0) ||
> > > +		   net->marvell_cap_exist) {
> > >  		pHTInfo->IOTPeer = HT_IOT_PEER_MARVELL;
> > >  	} else if (net->airgo_cap_exist) {
> > >  		pHTInfo->IOTPeer = HT_IOT_PEER_AIRGO;
> > > diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
> > > index 2e5debc0373c..6a1a63168319 100644
> > > --- a/include/linux/etherdevice.h
> > > +++ b/include/linux/etherdevice.h
> > > @@ -87,6 +87,11 @@ static inline bool is_link_local_ether_addr(const u8 *addr)
> > >  #endif
> > >  }
> > >  
> > > +static inline bool ether_oui_equal(const u8 *addr, const u8 *oui)
> > > +{
> > > +return addr[0] == oui[0] && addr[1] == oui[1] && addr[2] == oui[2];
> > > +}
> > 
> > Staging drivers are stand-alone, we can not add code outside of the
> > driver directory in these patches, sorry.
> > 
> Okay Sir. When I tried to add static inline bool line in current file, it
> showed errors which I was not able to rectify,

What errors was shown?

What did you do to try to fix it?

There should not be any need to add this to a kernel-wide header file
for a tiny staging driver.

thanks,

greg k-h
