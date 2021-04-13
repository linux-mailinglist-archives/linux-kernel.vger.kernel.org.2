Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC06935E7A7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhDMUjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhDMUjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:39:04 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC18AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:38:42 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id l131so13273863oih.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sOciReA7WbfMclN/SHnVrQLizTrxYQXx4oJ9xPZtlVM=;
        b=Sghs9ai+aAAqxFOGtL+gun8IX7DUGA+FJ6xTCZOLmoxq35iz7NhVEn/c+HMVRRHgaE
         e68Vs8t3Xfi8BTC+PGl0juP0I3VwMEbDtfWhlZ2lOEyuvfDdgHePEkMw6nkHZMoRmGzv
         GcGvKHZFBEzunM1pKnRWj2S8DPObiKsJy31HFg4pLL+jb7WV3KKHxTYZcPl70U3qgwvx
         hYXJ5gam3WJI3JeLmdgsVJjxt7o4pphAAHD+0+9U2SRMghi9+uFwxDVvKOiHLjmDMi9Z
         jtIFBBRWaMfQUz6n20A5iL/qGm8JcAxMzljgUEYhOciibLsgThENs2rJ7kHvy3fHyQgb
         cCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sOciReA7WbfMclN/SHnVrQLizTrxYQXx4oJ9xPZtlVM=;
        b=tGb/RzDd1L4B/8x+Wd2Sn0ZOPLEzr0pwKTJdq7Emiarys0DYbaZELkb3dL7QY9uATM
         BqZk7EYbNut14RAc+/1hO/yTIDRKjdLN0n7SwNDZokY6p2+PZ/fp+Vjq1oSLab0z+Dm0
         VnZDhZHczLVapplLe4ks7AR2dkwJRNVWNggUiCLBSNpLiX7nVCX479NXbnUBwL1XwAzG
         rUAk3EJZ55OrZm1O/cViqyX7pSM5fANXDg8O05hanRSPP8I9UvCp13FOcTX0aOzwtuKS
         p6Hp/RZCpgfkWIPY4oUm6WBkV9GvZbzOWOCXdxKyByQBFX5PeRZaeTUVQrWoau1fF5hK
         WepQ==
X-Gm-Message-State: AOAM533an8yr3w6gRLacxWJVn3pdi9uVZtmkHlMvwiLrEn3EypFVPrko
        E8XX7uogvZ7yOAdYSXHfXEXn/xJWSiWG0w==
X-Google-Smtp-Source: ABdhPJwHLZMHoZ+xdKwp4Mg/gL11qS+u0P4YNMz7b6FAXqhoK1OPeWn7XZFEY5GybFjGThyV8gZEsg==
X-Received: by 2002:a05:6808:bd6:: with SMTP id o22mr1349359oik.129.1618346321957;
        Tue, 13 Apr 2021 13:38:41 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n13sm3586803otk.61.2021.04.13.13.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 13:38:41 -0700 (PDT)
Date:   Tue, 13 Apr 2021 15:38:39 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] crypto: qce: Add mode for rfc4309
Message-ID: <20210413203839.GR1538589@yoga>
References: <20210225182716.1402449-1-thara.gopinath@linaro.org>
 <20210225182716.1402449-4-thara.gopinath@linaro.org>
 <20210405223247.GC904837@yoga>
 <39683997-42ad-bd91-0c31-a9e982e0ba61@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39683997-42ad-bd91-0c31-a9e982e0ba61@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13 Apr 14:30 CDT 2021, Thara Gopinath wrote:

> 
> 
> On 4/5/21 6:32 PM, Bjorn Andersson wrote:
> > On Thu 25 Feb 12:27 CST 2021, Thara Gopinath wrote:
> > 
> > > rf4309 is the specification that uses aes ccm algorithms with IPsec
> > > security packets. Add a submode to identify rfc4309 ccm(aes) algorithm
> > > in the crypto driver.
> > > 
> > > Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> > > ---
> > >   drivers/crypto/qce/common.h | 7 +++++--
> > >   1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/crypto/qce/common.h b/drivers/crypto/qce/common.h
> > > index 3bc244bcca2d..3ffe719b79e4 100644
> > > --- a/drivers/crypto/qce/common.h
> > > +++ b/drivers/crypto/qce/common.h
> > > @@ -51,9 +51,11 @@
> > >   #define QCE_MODE_CCM			BIT(12)
> > >   #define QCE_MODE_MASK			GENMASK(12, 8)
> > > +#define QCE_MODE_CCM_RFC4309		BIT(13)
> > > +
> > >   /* cipher encryption/decryption operations */
> > > -#define QCE_ENCRYPT			BIT(13)
> > > -#define QCE_DECRYPT			BIT(14)
> > > +#define QCE_ENCRYPT			BIT(14)
> > > +#define QCE_DECRYPT			BIT(15)
> > 
> > Can't we move these further up, so that next time we want to add
> > something it doesn't require that we also move the ENC/DEC bits?
> 
> Yes I will change it to BIT(30) and BIT(31)
> 
> > 
> > >   #define IS_DES(flags)			(flags & QCE_ALG_DES)
> > >   #define IS_3DES(flags)			(flags & QCE_ALG_3DES)
> > > @@ -73,6 +75,7 @@
> > >   #define IS_CTR(mode)			(mode & QCE_MODE_CTR)
> > >   #define IS_XTS(mode)			(mode & QCE_MODE_XTS)
> > >   #define IS_CCM(mode)			(mode & QCE_MODE_CCM)
> > > +#define IS_CCM_RFC4309(mode)		((mode) & QCE_MODE_CCM_RFC4309)
> > 
> > While leaving room for the typical macro issues, none of the other
> > macros wrap the argument in parenthesis. Please follow the style of the
> > driver, and perhaps follow up with a cleanup patch that just wraps them
> > all in parenthesis?
> 
> This does throw up a checkpatch warning if I don't wrap "mode" in
> parenthesis. How about I keep this for now and I will follow up with a clean
> up for rest of the macros later ?
> 

I don't have a problem with this approach.

Regards,
Bjorn

> > 
> > Regards,
> > Bjorn
> > 
> > >   #define IS_ENCRYPT(dir)			(dir & QCE_ENCRYPT)
> > >   #define IS_DECRYPT(dir)			(dir & QCE_DECRYPT)
> > > -- 
> > > 2.25.1
> > > 
> 
> -- 
> Warm Regards
> Thara
