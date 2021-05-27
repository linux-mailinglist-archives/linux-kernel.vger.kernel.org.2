Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E31393004
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbhE0NrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbhE0NrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:47:21 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE16C061574;
        Thu, 27 May 2021 06:45:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a25so878949edr.12;
        Thu, 27 May 2021 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uz4JiPh2mkktY6ONKOwk6wNsblTCy+bn5Eg1MPFuJRQ=;
        b=tii8EUBiYfnHQlXnEiyPGmcAemLKeSVonfxJJlE8kmpWYW4H8QWzdpIEH9p6tv495U
         pU28A2qZroVl8qu305uOoJWln5qbh/zqYc7w+60/1ytjtsEDQHXRLu2NCTuoaWjNq+vq
         QkZ5EWFwH59yeKTZI1OEGO3758YEfIaxzx4rFKAXejZPM5H9SxlwUdU1zzF44CQoYlfx
         FRWGVIfsUYB4a0Rjg6jUvPoDfN/L6WhqB+qDpht5oAPTsPqg9/fRgO+kQ8Re3hEACIdC
         HuYY1P+Rv8vX8xQEOdPDwwzkj90Ph1I3ZkJr3RX7Y1nUZAr8coFiE86AWJ6Y1rmhlADp
         Whdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uz4JiPh2mkktY6ONKOwk6wNsblTCy+bn5Eg1MPFuJRQ=;
        b=nvu07vZ7gm6WbxJkeq/zGY6B4BeOrgzmIVuSkcG8TYtj4Hfim9OQVkb5R9pjyH5VTJ
         LliG45js1drD8VYYB1fsp4hsv1BQ9DUeW4vMGyuIeu7lbMVz41csvfv14CgTe+XyFefT
         Ba0GKmbuftwsGAcNcUCOklSLOtUa9+DC4GEhOVyTjZE8Gwxd6t9VJPKCyLeY9tQkGYUj
         Cm5MYAKSFg5loKrlAZdi5Sa8RoWzHybmYhKzC4faKKoCJUba/Rc0q+28O43w1f7MjgmF
         RLYG7NsCD3kRqTnXzonx/fq8kUbeEidWVP7YXjyj9uU3Yaic2jAHowvCk1aFUCy/Ioyf
         B3zg==
X-Gm-Message-State: AOAM530ynnwPzLEWCB3cLHexgR4k9j2Tu0JDYf6CVy75m7EoZAXQDk4p
        xYidZEkyYOinJGvFXhjU0g4=
X-Google-Smtp-Source: ABdhPJxvfo409sxjk47TCXCwzT2oD8Z/0787fzvIb3u1rUtHxcqRi+NpmleKyh/Jh3UrG5cDLiItAg==
X-Received: by 2002:aa7:c24d:: with SMTP id y13mr4170373edo.155.1622123145454;
        Thu, 27 May 2021 06:45:45 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id l22sm1015204ejk.67.2021.05.27.06.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 06:45:44 -0700 (PDT)
Date:   Thu, 27 May 2021 16:45:42 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/6] clk: actions: Fix AHPPREDIV-H-AHB clock chain on Owl
 S500 SoC
Message-ID: <20210527134542.GC1300160@BV030612LT>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
 <58225ced4893018792d581c0476a0f1c70e08907.1615221459.git.cristian.ciocaltea@gmail.com>
 <20210316054547.GD1798@thinkpad>
 <20210316185014.GD1111731@BV030612LT>
 <20210526101230.GD10723@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526101230.GD10723@work>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 03:42:30PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 16, 2021 at 08:50:14PM +0200, Cristian Ciocaltea wrote:
> > On Tue, Mar 16, 2021 at 11:15:47AM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Mar 08, 2021 at 07:18:29PM +0200, Cristian Ciocaltea wrote:
> > > > There are a few issues with the setup of the Actions Semi Owl S500 SoC's
> > > > clock chain involving AHPPREDIV, H and AHB clocks:
> > > > 
> > > > * AHBPREDIV clock is defined as a muxer only, although it also acts as
> > > >   a divider.
> > > > * H clock is defined as a standard divider, although the raw value zero
> > > >   is not supported.
> > > 
> > > What do you mean by not supported? The datasheet lists "0" as the valid divisor
> > > value for divide by 1.
> > 
> > Unfortunately CMU_BUSCLK1 is not documented in my S500 Datasheet
> > (Version: 1.6, 2016-03-07). Do you have a newer (or a more official)
> > one?
> > 
> 
> Yes I do have a newer version of the datasheet (v1.8) and there I can
> see the divisor 0.

I got an updated datasheet (v1.9) and I confirm dividing by 1 is valid.

> > The reference xapp-le code snipped is:
> > 
> > static struct owl_div divider_H_CLK = {
> >     .type = DIV_T_NATURE,
> >     .range_from = 1,  /* reserve H_CLK divsor 1 */
> >     .range_to = 3,
> >     .reg = &divbit_H_CLK,
> > };
> > 
> > Not sure why divisor 1 has been reserved..
> > 
> 
> It is not as per the datasheet. Did you run into any issues with this?
> Else I'd suggest to keep it as it is.

I reverted the changes (please see v2) and did not encounter any issues
so far, so let's ignore the vendor driver implementation.

Thanks for the review,
Cristi

> Thanks,
> Mani
> 
> > Thanks,
> > Cristi
> > 
> > > Rest looks good to me.
> > > 
> > > Thanks,
> > > Mani
> > > 
> > [...]
