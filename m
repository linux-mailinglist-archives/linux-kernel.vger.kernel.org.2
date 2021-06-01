Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476D7396FE1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhFAJHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbhFAJGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:06:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8066C06138B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 02:05:06 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j14so13421964wrq.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 02:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cfPWMsQvRPfNVKIAADzVe8mEf5Pc8quR6RTV6Z/PEWg=;
        b=yjf+zo5MAbUzbHCr8324XpoNfWrXBvuB8ILKCxW5ahL2YCfbsKMNug6Scq2Bdbw5JT
         N5ZUXlSfXsmBa45hj2pibdGR+rf5bBNO5+iiZ+0oifSxWVMcqAFePEUpC6Cey1jG2czX
         /4v8Kv97JIhb9LbjD+iOcwukTAQHWrWrAPKrnXgwUa/tTkxb16Ue87ezYA6DViPtoUxC
         +R0E04s9YG2DMDh4XzgRo61OUPaw6jP7s/fqfkAo2HFTa42ogxe0MKCGZG1b+KgunHHa
         Bbndy8EdViKKY4O9/BE1uQP4D/ff5W98cMChYTKTziSO6W7TwaA/vOxKNe7cZImP+eVA
         5l7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cfPWMsQvRPfNVKIAADzVe8mEf5Pc8quR6RTV6Z/PEWg=;
        b=JHjo0ySvmtl8gyweLoqhr4lxDEcXHJhgeiR27aIndMTwFj5wic6UN9q9cMDXF5Y0HW
         n72gj+6+b01O+IxHf54wXrVghZ53nPmM1SCO91TRQr8gFrQn5piXw3j15HwmGGOdLpBh
         /9T8nmgV9AGIEb/l91hJeRcKvFqkikUBTPhAWV8ceCTM20Sgn4TnZxwRmsr2F5spzjtb
         lEQhOlGddeFEFrEnJLFOg7j5TCxWmAwxSbS/3EgrOJsbKeJdcC69mByPbIisxYb38PSd
         nx38INFwwixReCHA+N2zC83SeUKgro+HB7xG6xa4YIZrg+OASz5GsmAun9UWrdEE7dr+
         eyTQ==
X-Gm-Message-State: AOAM530KsKP/fIT0NKj7f/CzKabwNRTdbTepiQAYV5b/Ec6HOnuWDRbz
        UdciLj+WGMnj9Eisim/Q293/jQ==
X-Google-Smtp-Source: ABdhPJx6Rot4PuH9Aw9rhVyJn/gfoQKGs50kZl/qg3QDffy3IA3/9JMdXstAO+2xcL+zUTTZlXsiPQ==
X-Received: by 2002:a05:6000:1447:: with SMTP id v7mr7555824wrx.252.1622538305456;
        Tue, 01 Jun 2021 02:05:05 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id r7sm1867129wmq.3.2021.06.01.02.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:05:05 -0700 (PDT)
Date:   Tue, 1 Jun 2021 10:05:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH 02/15] leds: leds-gpio-register: Supply description for
 param 'id'
Message-ID: <20210601090503.GY543307@dell>
References: <20210528090629.1800173-1-lee.jones@linaro.org>
 <20210528090629.1800173-3-lee.jones@linaro.org>
 <20210528094118.xw53q46i676wx6gb@pengutronix.de>
 <20210528095531.GO543307@dell>
 <20210528103532.5n6zzr26hqglvz2p@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210528103532.5n6zzr26hqglvz2p@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021, Uwe Kleine-König wrote:

> Hey Lee,
> 
> On Fri, May 28, 2021 at 10:55:31AM +0100, Lee Jones wrote:
> > On Fri, 28 May 2021, Uwe Kleine-König wrote:
> > > On Fri, May 28, 2021 at 10:06:16AM +0100, Lee Jones wrote:
> > > > diff --git a/drivers/leds/leds-gpio-register.c b/drivers/leds/leds-gpio-register.c
> > > > index b9187e71e0cf2..de3f12c2b80d7 100644
> > > > --- a/drivers/leds/leds-gpio-register.c
> > > > +++ b/drivers/leds/leds-gpio-register.c
> > > > @@ -11,6 +11,7 @@
> > > >  /**
> > > >   * gpio_led_register_device - register a gpio-led device
> > > >   * @pdata: the platform data used for the new device
> > > > + * @id: platform ID
> > > >   *
> > > 
> > > Given that id is the first parameter and pdata the second I suggest to
> > > swap the order here and describe id first.
> > 
> > That's super picky.
> > 
> > I can do it as a follow-up patch if you *really* care about it.
> 
> I'd say introducing the one-line description for id now in the "wrong"
> location and then reordering as a followup is ridiculus. But having said
> that: I don't care at all.

It's only "wrong" according to you.

I see these presented in a different order to their counterparts all
the time.  I do however appreciate that it does make more sense and
is easier on the eye, which is why I am more than happy to rectify.

With regards to the follow-up scenario, it makes far less sense for an
already merged patch in a history tree to be reverted, or for history
to be unnecessarily re-written for something as trivial as this.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
