Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CC3360ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhDONn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbhDONnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:43:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597DBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 06:42:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id em21-20020a17090b0155b029014e204a81e6so4744657pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 06:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V2FeJYZDww2DdD1lDXHuBLfVqGEAO/xiKgUfUUlkplc=;
        b=Xcz1bPAXSS1KyUCTgQ0sBGmoucVOtgXkHI9HYiqDMycby0xFc+NYG3kuaLxm7alIhg
         0pyfawO0M8+Q0thPzNkp/n0fExZ23ce4pdUdBfycvIUozGKR+HxkcGVNHiStaxRopMMa
         c9vbYZSFJafxvvH0mW+prBPM2hE76tljvwoiF5gLU/L/KJdkCKxHYGkMNmLdM3EnYvr9
         p+N+7DiP9Oy3RSwLkGsl29FEl4BeQhE+rkzwf3OXGa/CRcainKJHq77YRZ3wpThA4BYQ
         NRyo8gZqXiY7Wwy2WGsL/DO4HiRYxhm/ifYDq7o/8/jnKOWSXAL59zwzpjnTDzQl0Mz+
         0KcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V2FeJYZDww2DdD1lDXHuBLfVqGEAO/xiKgUfUUlkplc=;
        b=Etr8bv5KFSL3UC43Q3NlgSlMJb0lBGdCSUxGXwSmcbiO7/bnRmFBcvvRwfrUnbLHX+
         vA8aZlmV09lNuvDP0aM2crY3u14sAVxQ/y8zPeSp+A+OtxLDlDO87bdNUAOty6uxp/qL
         4j1nYzqYpy1ACVsKEh+yYUtTQzc+q5KAAf8tKvlZKgf/0vlPmH97HgFULuw4plqnvwXY
         R+bK+yKhCTmokQad+1bzui0wJFAXpESJGAGnQHpzigD5mhBgFXlqqloB7tbRwXcNJZsS
         Go1Q6Ui+pjQAaC98LNCz8zrYt+sklRo7F9GIctHg5mqoG5Gt7PaIE+LwquiFt073PCSd
         hQTA==
X-Gm-Message-State: AOAM533WM0ijbMvXvwqCcX74M1HT8FDuhPPgKrcZ3mAhona9lrCGGihZ
        CLNdWaQDIL+ziq49SbpyV94=
X-Google-Smtp-Source: ABdhPJzn87a0yL7BPU9C+OUIe3zaAr4YdC6FMnHIDH6L/bQUl0Od5MsehFzNcvP6EBbb3a/lwBq/1w==
X-Received: by 2002:a17:90a:d184:: with SMTP id fu4mr3902551pjb.79.1618494178670;
        Thu, 15 Apr 2021 06:42:58 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id g24sm2715066pgn.18.2021.04.15.06.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 06:42:58 -0700 (PDT)
Date:   Thu, 15 Apr 2021 19:12:47 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [PATCH v2 4/5] staging: rtl8192e: rectified spelling mistake and
 replace memcmp with ether_oui_equal
Message-ID: <YHhC1/R6lrWN57JC@kali>
References: <cover.1618380932.git.mitaliborkar810@gmail.com>
 <eda8d3401f2f7ff7a61137b4935c6ccb09112e52.1618380932.git.mitaliborkar810@gmail.com>
 <YHak+7LA6LdrUyzU@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHak+7LA6LdrUyzU@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:16:59AM +0200, Greg KH wrote:
> On Wed, Apr 14, 2021 at 12:26:01PM +0530, Mitali Borkar wrote:
> > Added a generic function of static inline bool in
> > include/linux/etherdevice.h to replace memcmp with
> > ether_oui_equal throughout the execution.
> > Corrected the misspelled words in this file.
> > 
> > Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> > ---
> >  
> > Changes from v1:- Rectified spelling mistake and replaced memcmp with
> > ether_oui_equal.
> > 
> >  drivers/staging/rtl8192e/rtl819x_HTProc.c | 48 +++++++++++------------
> >  include/linux/etherdevice.h               |  5 +++
> >  2 files changed, 29 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> > index ec6b46166e84..ce58feb2af9a 100644
> > --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> > +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> > @@ -43,7 +43,7 @@ u16 MCS_DATA_RATE[2][2][77] = {
> >  	 810, 720, 810, 900, 900, 990} }
> >  };
> >  
> > -static u8 UNKNOWN_BORADCOM[3] = {0x00, 0x14, 0xbf};
> > +static u8 UNKNOWN_BROADCOM[3] = {0x00, 0x14, 0xbf};
> >  
> >  static u8 LINKSYSWRT330_LINKSYSWRT300_BROADCOM[3] = {0x00, 0x1a, 0x70};
> >  
> > @@ -146,16 +146,16 @@ bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
> >  	bool			retValue = false;
> >  	struct rtllib_network *net = &ieee->current_network;
> >  
> > -	if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
> > -	    (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
> > -	    (memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
> > -	    (memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
> > -	    (memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
> > +	if ((ether_oui_equal(net->bssid, BELKINF5D8233V1_RALINK) == 0) ||
> > +	    (ether_oui_equal(net->bssid, BELKINF5D82334V3_RALINK) == 0) ||
> > +	    (ether_oui_equal(net->bssid, PCI_RALINK) == 0) ||
> > +	    (ether_oui_equal(net->bssid, EDIMAX_RALINK) == 0) ||
> > +	    (ether_oui_equal(net->bssid, AIRLINK_RALINK) == 0) ||
> >  	    (net->ralink_cap_exist))
> >  		retValue = true;
> > -	else if (!memcmp(net->bssid, UNKNOWN_BORADCOM, 3) ||
> > -		 !memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
> > -		 !memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ||
> > +	else if (ether_oui_equal(net->bssid, UNKNOWN_BROADCOM) ||
> > +		 ether_oui_equal(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM) ||
> > +		 ether_oui_equal(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM) ||
> >  		 (net->broadcom_cap_exist))
> >  		retValue = true;
> >  	else if (net->bssht.bd_rt2rt_aggregation)
> > @@ -179,26 +179,26 @@ static void HTIOTPeerDetermine(struct rtllib_device *ieee)
> >  			pHTInfo->IOTPeer = HT_IOT_PEER_92U_SOFTAP;
> >  	} else if (net->broadcom_cap_exist) {
> >  		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
> > -	} else if (!memcmp(net->bssid, UNKNOWN_BORADCOM, 3) ||
> > -		 !memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
> > -		 !memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3)) {
> > +	} else if (ether_oui_equal(net->bssid, UNKNOWN_BROADCOM) ||
> > +		   ether_oui_equal(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM) ||
> > +		   ether_oui_equal(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM)) {
> >  		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
> > -	} else if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
> > -		 (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
> > -		 (memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
> > -		 (memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
> > -		 (memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
> > -		  net->ralink_cap_exist) {
> > +	} else if ((ether_oui_equal(net->bssid, BELKINF5D8233V1_RALINK) == 0) ||
> > +		   (ether_oui_equal(net->bssid, BELKINF5D82334V3_RALINK) == 0) ||
> > +		   (ether_oui_equal(net->bssid, PCI_RALINK) == 0) ||
> > +		   (ether_oui_equal(net->bssid, EDIMAX_RALINK) == 0) ||
> > +		   (ether_oui_equal(net->bssid, AIRLINK_RALINK) == 0) ||
> > +		   net->ralink_cap_exist) {
> >  		pHTInfo->IOTPeer = HT_IOT_PEER_RALINK;
> >  	} else if ((net->atheros_cap_exist) ||
> > -		(memcmp(net->bssid, DLINK_ATHEROS_1, 3) == 0) ||
> > -		(memcmp(net->bssid, DLINK_ATHEROS_2, 3) == 0)) {
> > +		   (ether_oui_equal(net->bssid, DLINK_ATHEROS_1) == 0) ||
> > +		   (ether_oui_equal(net->bssid, DLINK_ATHEROS_2) == 0)) {
> >  		pHTInfo->IOTPeer = HT_IOT_PEER_ATHEROS;
> > -	} else if ((memcmp(net->bssid, CISCO_BROADCOM, 3) == 0) ||
> > -		  net->cisco_cap_exist) {
> > +	} else if ((ether_oui_equal(net->bssid, CISCO_BROADCOM) == 0) ||
> > +		   net->cisco_cap_exist) {
> >  		pHTInfo->IOTPeer = HT_IOT_PEER_CISCO;
> > -	} else if ((memcmp(net->bssid, LINKSYS_MARVELL_4400N, 3) == 0) ||
> > -		  net->marvell_cap_exist) {
> > +	} else if ((ether_oui_equal(net->bssid, LINKSYS_MARVELL_4400N) == 0) ||
> > +		   net->marvell_cap_exist) {
> >  		pHTInfo->IOTPeer = HT_IOT_PEER_MARVELL;
> >  	} else if (net->airgo_cap_exist) {
> >  		pHTInfo->IOTPeer = HT_IOT_PEER_AIRGO;
> > diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
> > index 2e5debc0373c..6a1a63168319 100644
> > --- a/include/linux/etherdevice.h
> > +++ b/include/linux/etherdevice.h
> > @@ -87,6 +87,11 @@ static inline bool is_link_local_ether_addr(const u8 *addr)
> >  #endif
> >  }
> >  
> > +static inline bool ether_oui_equal(const u8 *addr, const u8 *oui)
> > +{
> > +return addr[0] == oui[0] && addr[1] == oui[1] && addr[2] == oui[2];
> > +}
> 
> Staging drivers are stand-alone, we can not add code outside of the
> driver directory in these patches, sorry.
> 
Okay Sir. When I tried to add static inline bool line in current file, it
showed errors which I was not able to rectify, but when I added that
line to include/linux/etherdevice.h file, and replaced memcmp with
ether_oui_equal, it worked fine.
I may be wrong in application. May I know how to resolve this?

> And as Dan said, this is wrong formatting, did you run checkpatch.pl on
> your changes?
>
Yes Sir, I ran checkpatch.pl, on both files, it showed no errors
against the changes I made.

> thanks,
> 
> greg k-h
