Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB38835AA50
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 04:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhDJC0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 22:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDJC0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 22:26:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10ACC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 19:25:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ep1-20020a17090ae641b029014d48811e37so4083746pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 19:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tRxserF1kmYtyXKOVcZo2cxB5e2oiDqXxMhGx+qb4IE=;
        b=F5lFTt3U3onbYaIlDdSmB46f8guOx+gRe+kZHWp07pu3+yZDYockBr2vbQ7hAeNTS4
         Fzs0quiCYHKBowNI+wv8sS178SXa6NQZfLWC1FHWYKO9+/R/c2KMn9ZMpUJnfkhld2zA
         5BHVMN/gg7H6P05qMhcJ5jIx6IrI8QNb+cR9HViVjX3EXBOFH2JYAtbb4J4vpAlEfME6
         YF6kJX/7SvnFI5unlVfQVmjf6+AQNSxZQxrFHaU3031kdysT8zONzp9FiPxQ/mxuBCBa
         047kHruZEzYYfNSPqww1MKLpiriz9ZNKrDQ/T8Dl3dR3QHhwqBe4BBDmWRHL4F2UUZo8
         xSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tRxserF1kmYtyXKOVcZo2cxB5e2oiDqXxMhGx+qb4IE=;
        b=qpcznUWz/FJh2rxYZSLIJQpK8UwzFLi9X7KP4D1/YWJ+maE8TCYMoRk6b07JqVabj0
         h9JmO3CPwvDQNChrF+02f2dFZ/+pjEFNabpvSSrSaGbOrOgVojb3O56CMHcgGURv3kvU
         0D4sbBDkfEXntEo8bJyuBsTSkLXPhc6PCiresIWrLyV1ZEk3YqhGDyI47mlkQrEvAM5J
         7GJTY3ZarC6hSz2Aq1//7LThh90NAu0DDE4NDrKeD09LZmW1sMhdFUYkYwzVXeFQe3EN
         Qhaoy4nU1g1JxSAfqOTPHs5Z6mwDzvjJYLajoDNVymqBaAlLqWJT2REWkjgWNiyoyeWy
         HJ9w==
X-Gm-Message-State: AOAM530mBSOd//TRUJCeDujP7AJbuoHidrYANGTfdiv9tQsmtBxLVuuQ
        dkm3yMcNuTOAD7kAj18ABic=
X-Google-Smtp-Source: ABdhPJz7lM/gsqRZlDLJ+6SkN81Sx32KSGrMytlIcd/YtLBZ92T+CGsrCPI1usz47hXSPlkj5IMO8g==
X-Received: by 2002:a17:90b:4b87:: with SMTP id lr7mr15623594pjb.5.1618021556083;
        Fri, 09 Apr 2021 19:25:56 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id d2sm3844630pgp.47.2021.04.09.19.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 19:25:55 -0700 (PDT)
Date:   Sat, 10 Apr 2021 07:55:49 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        mitali_s@me.iitr.ac.in
Subject: Re: [PATCH 4/6] staging: rtl8192e: matched alignment with open
 parenthesis
Message-ID: <YHEMrQdEFpXgmMh/@kali>
References: <YHEA2Te3Hik5J39t@kali>
 <f5fe04d62b22eb5e09c299e769d9b9d8917f119c.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5fe04d62b22eb5e09c299e769d9b9d8917f119c.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 07:07:09PM -0700, Joe Perches wrote:
> On Sat, 2021-04-10 at 07:05 +0530, Mitali Borkar wrote:
> > Matched the alignment with open parenthesis to meet linux kernel coding
> > style.
> > Reported by checkpatch.
> []
> > diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> []
> > @@ -154,7 +154,7 @@ bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
> >  	    (net->ralink_cap_exist))
> >  		retValue = true;
> >  	else if (!memcmp(net->bssid, UNKNOWN_BORADCOM, 3) ||
> > -		!memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
> > +		 !memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
> >  		!memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ||
> >  		(net->broadcom_cap_exist))
> 
> checkpatch is a stupid script.
> Look further at the code not just at what checkpatch reports.
> Align all the contination lines, not just the first one.
>
Sir, I have aligned them in last patch of this patchset.

> It might be sensible to add a generic function like
> 
> static inline bool ether_oui_equal(const u8 *addr, const u8 *oui)
> {
> 	return addr[0] == oui[0] && addr[1] == oui[1] && addr[2] == oui[2];
> }	
> 
> to include/linux/etherdevice.h
> 
> (Maybe use & instead of && if it's speed sensitive)
> 
> so this would read
> 
> 	else if (ether_oui_equal(net->bssid, UNKNOWN_BORADCOM) ||
> 		 ether_oui_equal(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM) ||
> 		 ether_oui_equal(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM) ||
> 		 net->broacom_cap_exist)
> 
> and it'd also be good to correct the typo of UNKNOWN_BORADCOM globally.
>
I will look into this.

> > @@ -654,13 +654,13 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
> >  	pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
> >  
> > 
> >  	memset((void *)(&(pHTInfo->SelfHTCap)), 0,
> > -		sizeof(pHTInfo->SelfHTCap));
> > +	       sizeof(pHTInfo->SelfHTCap));
> 
> Doesn't need casts or parentheses.
> 
> 	memset(&pHTInfo->SelfHTCap, 0, sizeof(pHTInfo->SelfHCap));
> 
Ok Sir, i am on it.

> >  	memset((void *)(&(pHTInfo->SelfHTInfo)), 0,
> > -		sizeof(pHTInfo->SelfHTInfo));
> > +	       sizeof(pHTInfo->SelfHTInfo));
> 
> etc...
> 
> > @@ -815,7 +815,7 @@ void HTUseDefaultSetting(struct rtllib_device *ieee)
> >  		HTFilterMCSRate(ieee, ieee->Regdot11TxHTOperationalRateSet,
> >  				ieee->dot11HTOperationalRateSet);
> >  		ieee->HTHighestOperaRate = HTGetHighestMCSRate(ieee,
> > -					   ieee->dot11HTOperationalRateSet,
> > +							       ieee->dot11HTOperationalRateSet,
> >  					   MCS_FILTER_ALL);
> 
> multi line statement alignment etc...
>
Sir, I have aligned this patch 6/6
> 
