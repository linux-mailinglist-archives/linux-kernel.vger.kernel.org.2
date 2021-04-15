Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5967E360B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhDOOEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbhDOOE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:04:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BE8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:04:05 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id n38so16140184pfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5XPT6W5he0UfMYjZNPGLkFire9o8RBMsN2S/bCzx5Ng=;
        b=cleochVxryEm6n+xPLdbi6rWCiJMx6jse9wDAZ2S6KURoNsWa8shkEYnqJ3kerW42j
         aEoddADtBA7Je9fqWlaPShWFbBRSsrqjiFJlKDF1d95merOtepfBt0qOsNOw/vsfS5nL
         tu+zjwAb4PDxVVsaJHws0sN7ld6LlZna6zZlwi3a/wwPIzmb22qvQIBBZKDUv5hhbZqB
         hnNDSD+Wfd0Ps9LdLRQx30WNR/orJZjOCiDSB8EI8TvwtgE69qaWXUiKCJ9R/+O3XSYH
         hbEZo9IJAzM7u9euVsmHGqSqZfPUS9MGhxZqOwNBnq8LDgTrRP3+lD6I8CqpAIOTRW0f
         3tdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5XPT6W5he0UfMYjZNPGLkFire9o8RBMsN2S/bCzx5Ng=;
        b=R4iWfQrEyzL+BkwPdua1rRd8ulglPmG+QqISq4hJpcephLyKzg/gkL5sZPxY0wFxQO
         jbhJ3DBgnV/35akekWG5e6hnB0KMQiZVvhniT6sQt3z0qRtcF2fltWTUgMCHUQZs4YNv
         Lcnhnild8sVpDNVbnFvFlOyDIto+P+y8b9oY4XDMxUNNnxIUIwFHMx6bDx+yE2XRmHxo
         y5kL6oAQkZ/IeDXYj5I9iB6TNdhN754socb06Hc3NAksV2xo+LLfS4G30LIiobgQeDJ+
         u+KV5XTRGzisyoCiqnNLWz8+tDjGF6fkYAbHmhNPJsKI/X2I1UPvGl0eTfNssyXjG344
         axEQ==
X-Gm-Message-State: AOAM533G7dFitc9xD4mayaTKMSHUw1WC4/Vkofm3bM5LHMfIf2UmokNm
        vpBYmYFqXEWgyhAgM2ewPKw=
X-Google-Smtp-Source: ABdhPJyMP6bMC6WgV254N+iBiedsV3xkfAipyYakF41kVP+RuG4kDZOc8dkzUNLtk5qCeK+hGhw2xA==
X-Received: by 2002:a62:52c7:0:b029:255:e78e:5069 with SMTP id g190-20020a6252c70000b0290255e78e5069mr3227022pfb.45.1618495444989;
        Thu, 15 Apr 2021 07:04:04 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id y187sm2330633pfb.109.2021.04.15.07.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 07:04:04 -0700 (PDT)
Date:   Thu, 15 Apr 2021 19:33:56 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, davem@davemloft.net, kuba@kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [PATCH v2 4/5] staging: rtl8192e: rectified spelling mistake and
 replace memcmp with ether_oui_equal
Message-ID: <YHhHzF6A2Syfbxpi@kali>
References: <cover.1618380932.git.mitaliborkar810@gmail.com>
 <eda8d3401f2f7ff7a61137b4935c6ccb09112e52.1618380932.git.mitaliborkar810@gmail.com>
 <20210414075525.GR6021@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414075525.GR6021@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:55:25AM +0300, Dan Carpenter wrote:
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
>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This is networking code and not staging code, but the netdev mailing
> list isn't CC'd.
>
I didn't knew mail id then, I will look into this,

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
> 
> Please pull this spelling fix into its own patch.
> 
Okay Sir.

> [ snip ]
> 
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
> The indenting is messed up on this.
>
OKay Sir, I am looking into this.

> regards,
> dan carpenter
> 
