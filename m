Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3CD3E194F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhHEQP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhHEQPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:15:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6385C0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 09:15:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so12799991pji.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 09:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rEg1BTCMGoRn0sjT3rWRNvHqW2LLrM0T5szYW+iprlY=;
        b=JeySS7sbmS28Oav7betiVjBrAJfEXz59ZQYfOpmK1BIP4wTxeWcTPwIoEpmFlC09DF
         rbWKjGUpowb+0LbpjNn5vITPzDzxcWs0S/r9mrYuq96fFbuQu3KzHqoI4u9De7IL7Jvs
         nSXt1j0MdcvtfEvJ2l/mKCUUMgFZ2rEN9MeZQX+ADKPIj6qRP4sJlewmGiF7TEk8RQ/a
         retiI4410BAKlfZSLIR3R5vhs/IlPxB6QTl7vYhseT+ggiXZVkgwOyg3d2ZiTJxFsqso
         EglMHVeuXVWvstLFr8v5Mn7Y6gZEvE9BMv4IqnTVfWITZmwiYum5VyWqhDTC02DvqtCF
         Reew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rEg1BTCMGoRn0sjT3rWRNvHqW2LLrM0T5szYW+iprlY=;
        b=O25u9ae9oUbmLoq8e3vjFF5rvUcwe8ydES0CBVbuAlz2nQguTFUJ1Hm6jaZx7MzSD2
         FrSpyHnP6l7TvO4pO6SFz36OVZB4OgoOcUht5bFFma27+6Yr9XaL9wepnfg7ONq8Zj8n
         gO030qCaWnWuC+4caJJalSFPiL7tR2DUtec/d1VL4hur0PmF+e769A4Ay7DkF0B9mlX8
         /oAimR4PIbfSnNzV7TwwwjqSAjw21XExFCIi5CONfeBZx1nL/EmXbfRR56ft4q4HxYXj
         yLesdrdipG0iNj+zDYp8yxpFKOrQG2iXDK681DDJYvUZJrB/xg0aQQt4BvFUhhAB93s2
         2+dQ==
X-Gm-Message-State: AOAM533JjkpRjPeDS7AedcREN/D2CTG6P8quO6iK2UYs+spxbJC1LAct
        DUzcwDxLNsC1MAPUYkPYc/KOJA==
X-Google-Smtp-Source: ABdhPJyKLIfgIfNToEP9h1rMAx3XgFEHEXDEu9ACbcrjUhWRC7r4z1IJzJr2ZOY+2Xn5CCrJoNVmVA==
X-Received: by 2002:a65:6099:: with SMTP id t25mr48063pgu.85.1628180109269;
        Thu, 05 Aug 2021 09:15:09 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id q17sm8753280pgd.39.2021.08.05.09.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 09:15:08 -0700 (PDT)
Date:   Thu, 5 Aug 2021 10:15:06 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-remoteproc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, ohad@wizery.com
Subject: Re: [PATCH v3 2/2] remoteproc: meson-mx-ao-arc: Add a driver for the
 AO ARC remote procesor
Message-ID: <20210805161506.GA3205691@p14s>
References: <20210717234859.351911-1-martin.blumenstingl@googlemail.com>
 <20210717234859.351911-3-martin.blumenstingl@googlemail.com>
 <20210728175823.GA2766167@p14s>
 <CAFBinCB0-bAa7Y+YhscczarGrGuio37F8vRyfW6U2DiiDAvr-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCB0-bAa7Y+YhscczarGrGuio37F8vRyfW6U2DiiDAvr-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 11:03:57PM +0200, Martin Blumenstingl wrote:
> Hi Mathieu,
> 
> thanks for taking the time to look into this!
> 
> (I will address any of your comments that I am not mentioning in this
> email anymore. Thanks a lot for the suggestions!)
> 
> On Wed, Jul 28, 2021 at 7:58 PM Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
> [...]
> > > +     writel(FIELD_PREP(AO_REMAP_REG0_REMAP_AHB_SRAM_BITS_17_14_FOR_ARM_CPU,
> > > +                            priv->sram_pa >> 14),
> > Indentation problem
> The idea here is to align priv->sram_pa with AO_REMAP_REG0... which
> are both arguments to FIELD_PREP

Right, this is what I would have expected.  When I applied the patch on my side
"priv->sram_pa ..." was aligned wiht the 'M' of "AO_REMAP_ ...".  

> Maybe using something like this will make that easier to read:
>     tmp = FIELD_PREP(AO_REMAP_REG0_REMAP_AHB_SRAM_BITS_17_14_FOR_ARM_CPU,
>                                      priv->sram_pa >> 14);
>     writel(tmp, priv->remap_base + AO_REMAP_REG0);

I think the main problem is that
AO_REMAP_REG0_REMAP_AHB_SRAM_BITS_17_14_FOR_ARM_CPU is simply too long.  I
suggest making is shorter and add a comment to describe exactly what it does.

> 
> What do you think: leave it as is or use a separate variable?
> 
> [...]
> > > +     usleep_range(10, 100);
> >
> > I've seen this kind of mysterious timeouts in other patchset based vendor trees.
> > You likely don't know why it is needed so I won't ask.
> unfortunately this is also the case here
> 
> [...]
> > > +     priv->arc_reset = devm_reset_control_get_exclusive(dev, NULL);
> > > +     if (IS_ERR(priv->arc_reset)) {
> >
> > Function __reset_control_get() in __devm_reset_control_get() can return NULL so
> > this should be IS_ERR_OR_NULL().
> The logic in there is: return optional ? NULL : ERR_PTR(-...);

Ok, so you meant to do that.  And I just checked reset_control_reset() and it does
account for a NULL parameter.  I'm good with this one but add a comment to
make sure future readers don't think you've omitted to properly deal with the
NULL return value.

> I am requesting a mandatory reset line here, so reset core will never
> return NULL
> See also [0]

Indeed, I've read that too.  Nonetheless __reset_control_get() can return NULL
by way of __reset_control_get_from_lookup().

> 
> For this reason I am not planning to change this
> 
> [...]
> > This driver is squeaky clean. With the above:
> >
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> awesome, thank you!
> 
> 
> Best regards,
> Martin
> 
> 
> [0] https://elixir.bootlin.com/linux/v5.14-rc4/source/include/linux/reset.h#L227
