Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF92843AA90
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 04:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhJZC5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 22:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbhJZC5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 22:57:48 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5B8C061220
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 19:55:25 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so15233717ote.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 19:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Ez2FM2W1ucj+BeN5l3HKohFYLr/E/eHfxAGL9YE+Us=;
        b=uPFxd/fIRzayE1+CnnxrH2mQ1ozQKQtZgAQxyiFQgXsE5JZapcz5KNRJmYEFFDbC+a
         Fk3pFeaPYhIjAtY1CXNyfmYivhmyBHXcyZFzYI5PY3zOsnN622cp7Q/475X+LSWzlWNa
         nm6HBFpGjhAccYbAptftX1uhcD/VAAtGB6Vmw8VxV/BlWgxKJyTIsC71ZFe5/qOomsSH
         XHR2Wjzpr+ZFYDQ2FcTV/gXJf8H7yj2q4A8062CwZH4oeoHh8Mb8+/qCzbW9pEplQd07
         rBoyIIf+cKp3bkMF4aCaYInqoTNSlKlNBX39vNE6wKWCeumTna9vRgnPtWXXfuWIsnn0
         UyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Ez2FM2W1ucj+BeN5l3HKohFYLr/E/eHfxAGL9YE+Us=;
        b=6Tvt2NPYxs5YwVcPx9THCRUOhxfHSdI+R5ucws//M7HSw2NNEF/9uuAL1Q+/9YRNu/
         UHBYAj9ZSJXPjfQEI4R49/mVHyeMzmNCgh81q5HZ21glG+RuNbE5ZLw/LVTxM/Gx3VYL
         406m6r/dnxx/KTP70xRBXdXGcXZrwNlpmYacG0w26fyP6gyg9G5uPe9SkANNrgtBXZll
         cPaiQulWJ9h2BOSdfZIfKubRkVcDdC8PEP+kBlRij4Djsb521niR7iDHnvT6+IpP/GRt
         FGYa75bchDNZFthSWJrdhMVNs00TG3uHMlT+wFAlrj4y1gwqmjzGyyR1Lc1GTVVhHvxE
         v4Hw==
X-Gm-Message-State: AOAM533Twd/Ewt1X/7akuW2XAY8hMaIS/y85Tv4aJMUdHULinp2nLLgm
        ja2L+NySaynrGpuILzs2CvdGGg==
X-Google-Smtp-Source: ABdhPJxf7Yn0Li+JyUNsm8Jz6Ju6LrI1GGY9GIvyJtWeaqMQ6OG/0fndr2GtBdY4dMPzI2nkpK4V5w==
X-Received: by 2002:a05:6830:2647:: with SMTP id f7mr16928571otu.124.1635216924753;
        Mon, 25 Oct 2021 19:55:24 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id d8sm3889507otc.51.2021.10.25.19.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 19:55:24 -0700 (PDT)
Date:   Mon, 25 Oct 2021 19:57:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>
Subject: Re: [PATCH v10 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <YXdufoQfnlrDvVVs@ripper>
References: <20211010043912.136640-1-bjorn.andersson@linaro.org>
 <20211010043912.136640-2-bjorn.andersson@linaro.org>
 <1ad508af-f7cb-a88f-07d8-5731c5a45403@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ad508af-f7cb-a88f-07d8-5731c5a45403@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25 Oct 17:37 PDT 2021, Subbaraman Narayanamurthy wrote:

> Hi Bjorn,
> 
> > +#define LPG_RESOLUTION		512
> 
> Just a thought. Having this fixed to 9-bit resolution would require a
> lot of code churn if this driver ends up supporting higher resolution
> PWM later. Would it be possible to have this as a parameter in "struct
> lpg_channel" ?
> 

In earlier revisions I had support for picking 6 vs 9 bit resolution
dynamically, but looked ahead and iirc saw that we only support 9 bit
for the now current generation (it's been a while, so I might
misremember).

The end result was that I ripped that out to simplify the code from the
various heuristics that had been bolted on during the generations.


People seem okay with this version and it meets the need of a large
number of PMICs and use cases, so I would prefer that we land this and
then evolve it based on requirements I haven't yet seen.

> > +static const unsigned int lpg_clk_rates[] = {1024, 32768, 19200000};
> > +static const unsigned int lpg_pre_divs[] = {1, 3, 5, 6};
> > +
> > +static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
> > +{
> > +	unsigned int clk, best_clk = 0;
> > +	unsigned int div, best_div = 0;
> > +	unsigned int m, best_m = 0;
> > +	unsigned int error;
> > +	unsigned int best_err = UINT_MAX;
> > +	u64 best_period = 0;
> > +
> > +	/*
> > +	 * The PWM period is determined by:
> > +	 *
> > +	 *          resolution * pre_div * 2^M
> > +	 * period = --------------------------
> > +	 *                   refclk
> > +	 *
> > +	 * With resolution fixed at 2^9 bits, pre_div = {1, 3, 5, 6} and
> > +	 * M = [0..7].
> > +	 *
> > +	 * This allows for periods between 27uS and 384s, as the PWM framework
> > +	 * wants a period of equal or lower length than requested, reject
> > +	 * anything below 27uS.
> > +	 */
> > +	if (period <= (u64)NSEC_PER_SEC * LPG_RESOLUTION / 19200000)
> > +		return -EINVAL;
> > +
> > +	/* Limit period to largest possible value, to avoid overflows */
> > +	if (period > (u64)NSEC_PER_SEC * LPG_RESOLUTION * 6 * (1 << LPG_MAX_M) / 1024)
> > +		period = (u64)NSEC_PER_SEC * LPG_RESOLUTION * 6 * (1 << LPG_MAX_M) / 2014;
> 
> s/2014/1024 ?
> 

Now that's an interesting typo... I will correct this and submit v11.

Thanks,
Bjorn
