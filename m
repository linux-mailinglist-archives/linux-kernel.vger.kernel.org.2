Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AF634450A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhCVNLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbhCVM4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:56:43 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1BEC061765
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:56:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e7so19132764edu.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jhMUMt47Qy3l4R1BzGhFrfV0S7KiLdr2F6jiJY4dFDk=;
        b=RgQ4iWT/PdFY/iZlFFqrrqi0NsFDqfJiPcx0MjPK+u4+kuaUEphxou0541X5gcuUMF
         B1ktR9sSf14DUUjdS0rW5w8wD+s/VdKafMEEQkRi7aQWYV5b5KfGZKTxQFTRDbe4o9Et
         ur3xdFTJjIxTzwcLMX32ZEz2BPQpN2lTEVU5C9FfagnQu9Kt63lX/o86KUyNJwwWmEVL
         9bqHchQm4AdOxvd75FJJlUYz8uV18VlRatZEQpudO8zj/lY5caWi7L9K4mB4eOTosnB6
         LfBOCquCbcDg8ikAMQEK37kKzWb5ncNrB45oh05JRRwL74UXV0fId213OdlAHLDmpyIm
         mZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jhMUMt47Qy3l4R1BzGhFrfV0S7KiLdr2F6jiJY4dFDk=;
        b=JRVSn6eqwRE4DhMjbjvRGc3aOdNreYrsd3wMusTDpt/I4wHdQda6P/9NAXHGf4GkyA
         xwCQ1L3zRK88/0nO0J8qHcawFPTFGjfSASSXJjjfIZujF3HavIGuSsMV4Ee408uP7enj
         2k/O2c4myj4HIcv3DlvlXTxN4lMHY+LodF56x4+dCLAaicsDJ9nqq/i+APiEsRB77adN
         EaMnw2btRbNpw10KT94dWRIg0mVnwKXKYbitEYXmJl5GxKABR3L+n8QFwNhZjwqw3m7U
         VtNOq5NPqkbbzZcXoSE4kw4OJlAkosUp8EuvfwvTU8VNbBruR+e0tXu0rdXckbZtq0tp
         mlWg==
X-Gm-Message-State: AOAM5302+pF+D1xKg5ULju9Hc1xl/PP3X7VhNWMhi7VP092MqDSzlp+Y
        ruhlZsSr6R+8jBDznypqQexCQw==
X-Google-Smtp-Source: ABdhPJySqR19DC/hCxF0a+sQiHHOwFj/hBIjXHAzej6vqyeDzzJ7iRwppliBGYzEkkTG1KvIeKN+xQ==
X-Received: by 2002:aa7:cf17:: with SMTP id a23mr26254551edy.30.1616417800851;
        Mon, 22 Mar 2021 05:56:40 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id l18sm9686234ejk.86.2021.03.22.05.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 05:56:40 -0700 (PDT)
Date:   Mon, 22 Mar 2021 12:56:38 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     vilhelm.gray@gmail.com, alexandre.torgue@foss.st.com,
        mcoquelin.stm32@gmail.com, olivier.moysan@foss.st.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] mfd: stm32-timers: avoid clearing auto reload register
Message-ID: <20210322125638.GP2916463@dell>
References: <1614793895-10504-1-git-send-email-fabrice.gasnier@foss.st.com>
 <ce30adb7-fe58-6b56-9cc9-3f19692b56c2@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce30adb7-fe58-6b56-9cc9-3f19692b56c2@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021, Fabrice Gasnier wrote:

> On 3/3/21 6:51 PM, Fabrice Gasnier wrote:
> > The ARR register is cleared unconditionally upon probing, after the maximum
> > value has been read. This initial condition is rather not intuitive, when
> > considering the counter child driver. It rather expects the maximum value
> > by default:
> > - The counter interface shows a zero value by default for 'ceiling'
> >   attribute.
> > - Enabling the counter without any prior configuration makes it doesn't
> >   count.
> > 
> > The reset value of ARR register is the maximum. So Choice here
> > is to backup it, and restore it then, instead of clearing its value.
> > It also fixes the initial condition seen by the counter driver.
> > 
> > Fixes: d0f949e220fd ("mfd: Add STM32 Timers driver")
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > ---
> >  drivers/mfd/stm32-timers.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Hi,
> 
> It's just a gentle reminder to review this patch.

Looks like this was either dropped, or didn't make it into my queue.

It's on the list now, I will deal with it soon.

> > diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
> > index add6033..44ed2fc 100644
> > --- a/drivers/mfd/stm32-timers.c
> > +++ b/drivers/mfd/stm32-timers.c
> > @@ -158,13 +158,18 @@ static const struct regmap_config stm32_timers_regmap_cfg = {
> >  
> >  static void stm32_timers_get_arr_size(struct stm32_timers *ddata)
> >  {
> > +	u32 arr;
> > +
> > +	/* Backup ARR to restore it after getting the maximum value */
> > +	regmap_read(ddata->regmap, TIM_ARR, &arr);
> > +
> >  	/*
> >  	 * Only the available bits will be written so when readback
> >  	 * we get the maximum value of auto reload register
> >  	 */
> >  	regmap_write(ddata->regmap, TIM_ARR, ~0L);
> >  	regmap_read(ddata->regmap, TIM_ARR, &ddata->max_arr);
> > -	regmap_write(ddata->regmap, TIM_ARR, 0x0);
> > +	regmap_write(ddata->regmap, TIM_ARR, arr);
> >  }
> >  
> >  static int stm32_timers_dma_probe(struct device *dev,
> > 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
