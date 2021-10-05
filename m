Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822234223F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhJEKzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhJEKzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:55:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07199C061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 03:53:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id g198-20020a1c20cf000000b0030d60cd7fd6so2584053wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 03:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oTS2oBDfu2qK2s9U2SS48/r8vYyQ0sH7yh9TkjSLfg4=;
        b=wtqDN2BUF7B+RsSZ1cv9rGw41+p10e4VjPqj3DoifND0YwO+uY7viRKIpGmwZvTB0r
         DqfxgDCIqJKnJDUGLlVSepXKGwX+/+efSvUYu8Z3PxOHpCMux9G9hgk1ICrp9ODo978a
         zznvAA7JMsJ7ADIqeAZVmWI2bZBs+S5OHjX7ip4R5rAq7vOC5DiTd2fzA1teRF4KBe14
         hV35RWAPtdSN3wHB9kwXMft2BloQfEo1NZVWIbGu8PD8r2Mq0SZBTmr9KK51ZlHr+vHu
         8LGefWt7njELwZZiMAvzDOA0Dc3vPFgxLwSUXsQnFa7zn0CanlW54HFBrUbj9U+moaRR
         CZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oTS2oBDfu2qK2s9U2SS48/r8vYyQ0sH7yh9TkjSLfg4=;
        b=A9oLyIeChI2LG0ict6CVuBSqzn0737RvF1VeVNB82KiRsPEul/pGoK/zvMoUEz8uW9
         vcKlwV/DDIuP6qQwJjw2c5fyviPof+HvpYGbbBYx672cPrZwa6DSlgp8bzL4MK5CZY8U
         AjIh4vAo4x5aYEi4a/W1fE+Vmi8YDIUVKxND0nHxW0ItOZH1ApbVccVRnKqaRfhscjF/
         QRlawYtRoDs3XdkUaDncsJ8Wms8le3jUpEnStFsG5mkW/l+f0n7k/Sd2q5moGHTGN7Hk
         83cWWHU4mikWI5ze8A1q0rEKj/z5EuXm+RRg7V3OWTeL0cqqevOgvS/5ybjRFju/7fYl
         gk9w==
X-Gm-Message-State: AOAM533itIgj1Oq3lqbWWBbiieZIRhUlt45qz4lupFGgU592bX9wAS4h
        fI69SSDcHrgle4Q1HAhM1rIl4Q==
X-Google-Smtp-Source: ABdhPJyixh7+Xhqge46v4VUyw24e//BY5vWBinq6c7+AnLp/aMzF80GlAm88p3o4d1k2Lvi8OuYWgg==
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr2645777wma.26.1633431195487;
        Tue, 05 Oct 2021 03:53:15 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id h15sm9413745wrt.0.2021.10.05.03.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 03:53:14 -0700 (PDT)
Date:   Tue, 5 Oct 2021 11:53:12 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] backlight: qcom-wled: Fix off-by-one maximum with
 default num_strings
Message-ID: <20211005105312.kqiyzoqtzzjxayhg@maple.lan>
References: <20211004192741.621870-1-marijn.suijten@somainline.org>
 <20211004192741.621870-6-marijn.suijten@somainline.org>
 <20211005091947.7msztp5l554c7cy4@maple.lan>
 <20211005100606.faxra73mzkvjd4f6@SoMainline.org>
 <20211005103843.heufyonycnudxnzd@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005103843.heufyonycnudxnzd@maple.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 11:38:43AM +0100, Daniel Thompson wrote:
> On Tue, Oct 05, 2021 at 12:06:06PM +0200, Marijn Suijten wrote:
> > On 2021-10-05 10:19:47, Daniel Thompson wrote:
> > > On Mon, Oct 04, 2021 at 09:27:36PM +0200, Marijn Suijten wrote:
> > > > When not specifying num-strings in the DT the default is used, but +1 is
> > > > added to it which turns wled3 into 4 and wled4/5 into 5 strings instead
> > > > of 3 and 4 respectively, causing out of bounds reads and register
> > > > read/writes.  This +1 exists for a deficiency in the DT parsing code,
> > > > and is simply omitted entirely - solving this oob issue - by allowing
> > > > one extra iteration of the wled_var_cfg function parsing this particular
> > > > property.
> > > > 
> > > > Fixes: 93c64f1ea1e8 ("leds: add Qualcomm PM8941 WLED driver")
> > > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > > > ---
> > > >  drivers/video/backlight/qcom-wled.c | 8 +++-----
> > > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> > > > index 27e8949c7922..66ce77ee3099 100644
> > > > --- a/drivers/video/backlight/qcom-wled.c
> > > > +++ b/drivers/video/backlight/qcom-wled.c
> > > > @@ -1255,17 +1255,17 @@ static const struct wled_var_cfg wled5_ovp_cfg = {
> > > >  
> > > >  static u32 wled3_num_strings_values_fn(u32 idx)
> > > >  {
> > > > -	return idx + 1;
> > > > +	return idx;
> 
> 
> > > >  }
> > > >  
> > > >  static const struct wled_var_cfg wled3_num_strings_cfg = {
> > > >  	.fn = wled3_num_strings_values_fn,
> > > > -	.size = 3,
> > > > +	.size = 4, /* [0, 3] */
> > > 
> > > 0 is not a valid value for this property.
> > 
> > These comments represent the possible loop iterations the DT "cfg
> > parser" runs through, starting at j=0 and running up until and including
> > j=3.  Should I make that more clear or omit these comments entirely?
> 
> The role of wled3_num_strings_values_fn() is to enumerate the list of
> legal values for the property [ 1, 2, 3 ]. Your changes cause the
> enumeration to include a non-legal value so that you can have an
> identity mapping between the symbol and the enumerate value.
> 
> An alternative approach would be to leave the enumeration logic
> alone but set the num_string default to UINT_MAX in all cases:
> 
> -	cfg->num_strings = cfg->num_strings + 1;
> +	if (cfg->num_strings == UINT_MAX)
> +		cfg->num_strings = 

Oops... looks like I missed the cfg->max_string_count here.


> +	else
> +               /* Convert from enumerated to numeric form */
> +		cfg->num_strings = wled3_num_strings_values_fn(
> +						cfg->num_strings);


PS the alternative option is not to treat num-strings as an enumerated
   value at all and just read it directly without using wled_values()...
