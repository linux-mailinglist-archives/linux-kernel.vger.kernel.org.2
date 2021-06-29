Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59563B79C9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 23:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbhF2VQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 17:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbhF2VQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 17:16:27 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4995FC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 14:13:59 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u11so431427oiv.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U74U+iEn5Am5+kX3N0VS9opfa7Yy7NUE/0AOkeeLZSE=;
        b=lh/WrrXMroWGGnIqlMGVQxW+VoxGnNc+tj6xNgIhRuotpvHEdNQe08qn92E8yCYIIO
         i+TlkPSaRSi0Yflyaw8nIY6aFzSdwE7ilTSAZRu+JGWJMPcgHSFs9Ft8c8Qef9d16/ML
         6bPEUmYNYLvDFbNbdqx50gM70+5OIeiZIyzWYtjQeqAnFPg5RQuVnVHWk2zDn/lpd8nA
         FCqTpcKPOdVVg3sqsWJIMX1NhVIN0p38+oXinZ4rLJocqxmWVcIPsHc2AVOIzhIVkab4
         5QA8zMA3uWoLcBbc8pXqghUTsKMF3+DrWsiCZkFq8KsStl/xBuceD73aR7a/Rt7f/1nf
         aU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U74U+iEn5Am5+kX3N0VS9opfa7Yy7NUE/0AOkeeLZSE=;
        b=NnVpR1P+JQOVrBLnc4XqeN8yDV/hJ47KOV66uOql4k4DZwRgcm3rmE7u1Rd/3unRSk
         zX5rLUE6utBWf6Qs+1/v8bqvMDQKymLknCltp6SpVV7nPKcPYsWGE5cr6HcSk+k2CI/u
         /xQvJowaiT+KXlVrz6z86xUU8SOncqan5ENyCssr1AqsldPhy2PXAHt9Tk1vKuDuuguI
         2TK48Fsqe0rptTrgDLOc4HDyn0QMqO0f7T2C9jYm1+jkmJn2x1Fc5gwZgTMBiFmMHFT4
         Mgc8oxO8B3j94BbdNICZDfXMZCwWl+heAAgesb9Rdi79LiDfYUd9b+U+xkcBg1ercTKX
         2/pw==
X-Gm-Message-State: AOAM532XxSUt2mmiV15S6vLu3rxkWNLG0F8I7rELosHldNEMPmYTQ4kc
        mBbq6ClZIYq6wrTf3NczxylC3w==
X-Google-Smtp-Source: ABdhPJz74smIKy3vpdkAtG9TjzPJN8VOtP7iUper90rhSA1q4NycNiwb0I47lYywHVlKsY0x3xUltA==
X-Received: by 2002:a05:6808:1451:: with SMTP id x17mr633681oiv.55.1625001238673;
        Tue, 29 Jun 2021 14:13:58 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x5sm2292665oto.63.2021.06.29.14.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 14:13:58 -0700 (PDT)
Date:   Tue, 29 Jun 2021 16:13:56 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gdsc: Ensure regulator init state matches
 GDSC state
Message-ID: <YNuNFNZm7qRpD/eG@yoga>
References: <20210625225414.1318338-1-bjorn.andersson@linaro.org>
 <162494849279.2516444.9302337933628102536@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162494849279.2516444.9302337933628102536@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29 Jun 01:34 CDT 2021, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2021-06-25 15:54:14)
> > As GDSCs are registered and found to be already enabled
> > gdsc_toggle_logic() will be invoked for votable GDSCs and ensure that
> > the vote is matching the hardware state. Part of this the related
> > regulator will be enabled.
> > 
> > But for non-votable GDSCs the regulator and GDSC status will be out of
> > sync and as the GDSC is later disabled regulator_disable() will face an
> > unbalanced enable-count, or something might turn off the supply under
> > the feet of the GDSC.
> > 
> > So ensure that the regulator is enabled even for non-votable GDSCs.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 37416e554961 ("clk: qcom: gdsc: Handle GDSC regulator supplies")
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/clk/qcom/gdsc.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> > index 51ed640e527b..f7e7759cdb90 100644
> > --- a/drivers/clk/qcom/gdsc.c
> > +++ b/drivers/clk/qcom/gdsc.c
> > @@ -359,10 +359,17 @@ static int gdsc_init(struct gdsc *sc)
> >  
> >         /*
> >          * Votable GDSCs can be ON due to Vote from other masters.
> > -        * If a Votable GDSC is ON, make sure we have a Vote.
> > +        * If a Votable GDSC is ON, make sure we have a Vote. If
> > +        * non-votable, ensure that the supply is kept enabled (as
> > +        * is done by gdsc_enable).
> >          */
> > -       if ((sc->flags & VOTABLE) && on)
> > +       if ((sc->flags & VOTABLE) && on) {
> >                 gdsc_enable(&sc->pd);
> > +       } else if (on) {
> > +               ret = regulator_enable(sc->rsupply);
> > +               if (ret < 0)
> > +                       return ret;
> 
> Looking at this makes me think we've messed something up with
> gdsc_enable() being called or cherry-picking the regulator enable (and
> other stuff in this gdsc_init()) out of the enable path. Maybe we should
> have a followup patch that replaces the gdsc_enable() with
> gdsc_toggle_logic(sc, GDSC_ON) so that we know it isn't doing anything
> else during init like asserting a reset when presumably all we want to
> do is toggle the enable bit to assert our vote.
> 
> And I notice that we already call gdsc_toggle_logic() in gdsc_init(), so
> then we'll have a double regulator_enable() in the case of PWRSTS_ON?
> And then if the flag is ALWAYS_ON we'll call regulator_enable() yet
> again, but luckily only if it isn't on initially, phew! This code is
> quite twisted.
> 
> It would be super nice to make it more like
> 
> 	if (on) {
> 		/* It was on in hardware, sync kernel state */
> 		regulator_enable();
> 
> 		if (votable)
> 			write bit, why do any wait?
> 
> 		if (retain ff)
> 			write bit
> 	} else if (always_on) {
> 		/* Force on */
> 		gdsc_enable();
> 		on = true;
> 	}
> 
> 	if (on || ...)
> 

This does look cleaner, I will dig through the logic here once more
before figuring out what to do for v2.

Thanks,
Bjorn

> > +       }
> >  
> >         /*
> >          * Make sure the retain bit is set if the GDSC is already on, otherwise
