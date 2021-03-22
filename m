Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DB634486F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhCVO76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhCVO73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:59:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A5EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:59:28 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u9so21794814ejj.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=No5jFTwqb7R4XEIA0KwymYpb1QXCwuzqTxyB4+G0aGY=;
        b=O3sI829zJ3dW1jsbnduLDFP9c6zb9ejbEXZGmLBvrzqSV+kp5bdKHiD0/gD/cek0fH
         sIVjjWU/zE/7vGEwYkeDY5QHX7WXAxAWK5su6meTaovNQjMNV/bvpAxjZ2HKFcin1cce
         m0dnsqMXlBCL9bBcHO6p6sOBdOccxShc11yP5EHzsdLk1/UZ2mWSkp1S99VvFWIYap4W
         Gkku+DeKNBtX1fiSjUrEV+8UFO08ACst2ZNFnKxjfjBVGBXT4pfn96JcZDJHuLsEzBzf
         Hwsx4/sNIAKchsxyMuA9RvH5U3DkVF8ae/d/jLXpUX0LMaKw7L25Bxee46E9TsnFD0h4
         IyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=No5jFTwqb7R4XEIA0KwymYpb1QXCwuzqTxyB4+G0aGY=;
        b=Qh/ScNYo+FvKR8YheTSBjGwEHSi+16WfIEMrPDgZmjI3+lEQ6erfD6KaSNHPR9khxz
         XTRleZGsxHJFkAORsfQXmQW4vWz7PYsgmijsY2VWVlBww+EfahjJwVEkUwHw/ZGSddHJ
         yC6a6gaJ/M/ub8qSh3rSDth3W6Q1lsWr2clxcSVWBtN5kznwG+NLIHpXIiyjW0QhaKFE
         lNQ6bq40fPvFShPjMv20LVSUhlq+7jw42kdJOaTMdeczlSyjeCT4Pijlnu3v0D4bP7V2
         7jD55IIE46/Gm39nZz1UeS1BaHNEf77K0Gz167Cb8CuPenAy3DfAC03bkDT/u4HDhSxI
         Chgw==
X-Gm-Message-State: AOAM532u9sRe2VdIYndqI/YBuawtC2cjB5btm3r68LERJpraE6R6ou5Q
        M0pT8cO/jBIeTyAywdQmGswZSA==
X-Google-Smtp-Source: ABdhPJxRcSsJ5gnR/GnQhgbaFvHOK6SjhZGsq4eesH9bgWpGyVLZRcTCcgl2m4tZO0jK/C0OyVc/zA==
X-Received: by 2002:a17:906:8308:: with SMTP id j8mr121126ejx.339.1616425167159;
        Mon, 22 Mar 2021 07:59:27 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id rs24sm9797693ejb.75.2021.03.22.07.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:59:26 -0700 (PDT)
Date:   Mon, 22 Mar 2021 14:59:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <20210322145925.GY2916463@dell>
References: <20210308212952.20774-1-andreas@kemnade.info>
 <20210310094821.GB701493@dell>
 <20210311184033.GJ4962@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210311184033.GJ4962@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021, Mark Brown wrote:

> On Wed, Mar 10, 2021 at 09:48:21AM +0000, Lee Jones wrote:
> 
> > Could you take a look at this for me please:
> 
> > > +static int regmap_ignore_write(void *context,
> > > +			       unsigned int reg, unsigned int val)
> > > +
> > > +{
> > > +	struct regmap *regmap = context;
> > > +
> > > +	regmap_write(regmap, reg, val);
> > > +
> > > +	return 0;
> > > +}
> 
> If there were more users it'd be better to have this in the core so that
> problems we can detect like cache stuff if that's used but if it's just
> one broken device it's probably not worth it, this seems like something
> you'd have to try to end up with and which is going to cause timeout
> problems with a lot of I2C controllers which would tank performance
> enough that people would notice.

So Yoda, is this to go into the core, or stay where it is?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
