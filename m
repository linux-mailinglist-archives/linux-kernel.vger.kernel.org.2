Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB2A3F7EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 01:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhHYXMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 19:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhHYXMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 19:12:38 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01837C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 16:11:52 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id h133so1688154oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 16:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QtXruHF4bnU6OyDGPGjhakaBMSfcI7KwDzUGtKN2MR0=;
        b=LSQ+Qs6HQ2tLgxADlDiknTiMlunVRVb2oTaqttGBCOLAy9cTuB2yKsogtfZ8PG903O
         h5M4uHZCfTCPEuGn7ae6aRomz+teFyOfwAahWuOVl0gm1XPoAx+WvuUlkgUfrzsn0Id7
         CFrxc8Q0QMTEBu528ANT70QfY/opiUACSIL1COUemir8eKja0ZTWsAzP7Oa07wR0hm1a
         nLkMWdmsttzoVcCUK3Qb8RLDR6lRWrUQ0Zj9YaiEgYAJ7ztDcSfp5MR4FZhS1DY6ygcR
         WA5rYjmlAuOugXKoPtKAfIFNkysDmGpBisdF8/Fayee8kQNXGIRAvBgw9C1nOlVy0aO6
         +GZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QtXruHF4bnU6OyDGPGjhakaBMSfcI7KwDzUGtKN2MR0=;
        b=MjGE0ZEzOWt0XgzXJfy5OuMrJElcYSTvmh4HgV5Y+7lmcCU1XJ0PpVW44gjgoh7QFD
         8fXrLer5yMgTO+3rs2C3oiPr5KBAT5VuBB9bTFTW2L8+DUbGsAcKpt6wYn+i+NDTNxAH
         rlDwQ+xm9sJxCOfHqUip4gJ2t/ua4OJ/eF/ByIcIjZFNQ3OuHp8zpfi8by2R0tvQAIZm
         DsawZGMBCps5BsExD7oUTrERBoWw6bB/Y8dVEIYGAVL/jKR5UbUQp6TaCzuEEXCPL7MY
         1GVuca948/kjetfepfCd5nZWQ1CUQPac/fuE3bQixgfgwZDklL6UcUuIhc+VUPoCVZxW
         T3oA==
X-Gm-Message-State: AOAM532WoNmEwz0qSVfX+t48UIZ00VWLjEw6vF1RD9Byyc/ieyDfY5Gf
        tRvjgImfDmwW9q7wnkAmuRgErA==
X-Google-Smtp-Source: ABdhPJwWtrUIdXOLEe63DVJX0W3pVBZSObgJ/P3jgP1myOd0+jMUDpnSf5bYJKY/guCKP8rvzghCnA==
X-Received: by 2002:a05:6808:21a5:: with SMTP id be37mr326536oib.172.1629933111367;
        Wed, 25 Aug 2021 16:11:51 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l67sm265529otl.3.2021.08.25.16.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:11:50 -0700 (PDT)
Date:   Wed, 25 Aug 2021 18:11:48 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     sbillaka@codeaurora.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robdclark@gmail.com, seanpaul@chromium.org,
        kalyan_t@codeaurora.org, abhinavk@codeaurora.org,
        dianders@chromium.org, khsieh@codeaurora.org,
        mkrishn@codeaurora.org
Subject: Re: [PATCH v1 1/2] drm/msm/dp: Add support for SC7280 eDP
Message-ID: <YSbONPNITH6dIECr@builder.lan>
References: <1628726882-27841-1-git-send-email-sbillaka@codeaurora.org>
 <1628726882-27841-2-git-send-email-sbillaka@codeaurora.org>
 <CAE-0n52=mR0Zt8UZ3vOM-nt0UJszcFhi-eYfzDtD0bt3zhNA_Q@mail.gmail.com>
 <0b2aa426c8f511a29143f2a1117fe9a2@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b2aa426c8f511a29143f2a1117fe9a2@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12 Aug 19:28 CDT 2021, sbillaka@codeaurora.org wrote:

> On 2021-08-12 06:11, Stephen Boyd wrote:
> > Quoting Sankeerth Billakanti (2021-08-11 17:08:01)
[..]
> > > +static int dp_parser_gpio(struct dp_parser *parser)
> > > +{
> > > +       struct device *dev = &parser->pdev->dev;
> > > +       int ret;
> > > +
> > > +       parser->panel_bklt_gpio = devm_gpiod_get(dev, "panel-bklt",
> > > +                       GPIOD_OUT_HIGH);
> > > +       if (IS_ERR(parser->panel_bklt_gpio)) {
> > > +               ret = PTR_ERR(parser->panel_bklt_gpio);
> > > +               parser->panel_bklt_gpio = NULL;
> > > +               DRM_ERROR("%s: cannot get panel-bklt gpio, %d\n",
> > > __func__, ret);
> > > +               goto fail;
> > > +       }
> > > +
> > > +       parser->panel_pwm_gpio = devm_gpiod_get(dev, "panel-pwm",
> > > GPIOD_OUT_HIGH);
> > > +       if (IS_ERR(parser->panel_pwm_gpio)) {
> > > +               ret = PTR_ERR(parser->panel_pwm_gpio);
> > > +               parser->panel_pwm_gpio = NULL;
> > > +               DRM_ERROR("%s: cannot get panel-pwm gpio, %d\n",
> > > __func__, ret);
> > > +               goto fail;
> > > +       }
> > > +
> > > +       DRM_INFO("gpio on");
> > > +fail:
> > > +       return 0;
> > > +}
> > 
> > Don't we have pwm backlight drivers like
> > drivers/video/backlight/pwm_bl.c to support this? This sort of thing
> > doesn't belong in the dp driver.
> 
> Okay. I will explore it.
> 

I proposed that we attach a drm_panel and allow that to control the
(pwm-)backlight. Here's the link for the DP patch:

https://lore.kernel.org/linux-arm-msm/20210726231351.655302-1-bjorn.andersson@linaro.org/

Regards,
Bjorn
