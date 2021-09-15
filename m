Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC08F40C7F1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 17:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbhIOPOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 11:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbhIOPOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:14:03 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F05C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 08:12:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g14so2999841pfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wsSC3ElljOcNuAZkoNqFxs8B8LwK8+PsifC2X+pKq7Y=;
        b=zHdY0vpXi3Pehr90PDksje3KtwyZby9zVYvErd1f3eV5Pa9SrhfiiLDYEiY78DN8yp
         e+495euySl52T9t+V2t4jh8/xuSmCkhO4oBtKFUoZ0obPPedm3f4F9cTiTzk+XpcVyFV
         TsOUUcNlJxeXnsA5+TvASjwcGHl1k2GevSoClqzJcupRErVWzaXoMB0sL+rktxgLL8gH
         LfZ6yYjipI18Z4+FkklOwqTJP+adgJPBLx9WQhMza19gSgVJhIuLnYf0m6YaZk+J5OFA
         F1ybeX/Ylw1Ahvmf2uw/50ayrfzkakqMLGceTESq3nqCaWU1WarJwdJfmN9qZOofXSJ8
         ieVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wsSC3ElljOcNuAZkoNqFxs8B8LwK8+PsifC2X+pKq7Y=;
        b=gXREwHmvcF5A2UgxIeAWClsrZuzqjnHpxk1hzYW4SF9Af7MqKaA+8unhgOGMcGdr2S
         jSiGzQQ2QcynMBxJgjt3cV0m1VgTlxsaRTpIpKW57pYqCoYjfcL/RGd3yK0SwJc/OeGx
         QdKfgPjp7hSwx0QboI+dQP7HINGWqBtl//CPGKrak7uhL+Ih2HVMXs6AHMBb5d2hQvZH
         2LFo0mXlt3bhWJCS8WcAoTZxUMMuZB2RF023tAmxHKZUhYqrFtgf9+EZjJdAxfakBCRs
         Lat0/K/v6GjpWm4MoWyQTvTLE2u2fPjrj6kRc9dE576egttcAZDxKpDmDsyrZeQAw7ZO
         4CiA==
X-Gm-Message-State: AOAM530/1njTq+GFMPcFMtijpIkJBf48uKXMnWgiFW3qSW0km9zRMtA1
        ssspg/4bNie6FxRosQQ1spFmBQ==
X-Google-Smtp-Source: ABdhPJyGqBLjcp/KUd3ds6sWYN6mT2/YPk+mfHPuNRq4EgjEc+zEcs0+PCVfueU9CI7jAVkKj02vEw==
X-Received: by 2002:a62:1c85:0:b0:440:3583:9fda with SMTP id c127-20020a621c85000000b0044035839fdamr455092pfc.0.1631718763504;
        Wed, 15 Sep 2021 08:12:43 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id u10sm92513pjf.46.2021.09.15.08.12.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Sep 2021 08:12:42 -0700 (PDT)
Date:   Wed, 15 Sep 2021 23:12:37 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] clk: qcom: smd-rpm: Add rate hooks for
 clk_smd_rpm_branch_ops
Message-ID: <20210915151236.GF25255@dragon>
References: <20210914025554.5686-1-shawn.guo@linaro.org>
 <20210914025554.5686-2-shawn.guo@linaro.org>
 <YUFgmdhYK/p2v1LS@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUFgmdhYK/p2v1LS@ripper>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 07:55:21PM -0700, Bjorn Andersson wrote:
> On Mon 13 Sep 19:55 PDT 2021, Shawn Guo wrote:
> 
> > On QCM2290 platform, the clock xo_board runs at 38400000, while the
> > child clock bi_tcxo needs to run at 19200000.  That said,
> > clk_smd_rpm_branch_ops needs the capability of setting rate. Add rate
> > hooks into clk_smd_rpm_branch_ops to make it possible.
> > 
> 
> Most platforms has a crystal oscillator ticking at 38.4MHz feeding the
> PMIC (represented by the rpmcc and its "xo" parent) and out comes the
> bi_tcxo with a fixed 19.2MHz rate.

Yeah, but all those platforms are running clk-rpmh driver, I think.

> Is there a problem with the way sdm660_bi_tcxo is defined in this
> regard?

There is no problem if xo clock is 19.2MHz, but for platforms with
38.4MHz xo, bi_tcxo will be seen as 38.4MHz in clock tree, while we
expect it to be 19.2MHz.

Shawn
