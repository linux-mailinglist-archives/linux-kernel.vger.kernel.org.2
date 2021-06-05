Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E213939C7A2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 12:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhFELAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 07:00:07 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:44560 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhFELAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 07:00:06 -0400
Received: by mail-ej1-f54.google.com with SMTP id c10so18363295eja.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 03:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zAatdENmuWE02Wtsxbg8mDmM1A4UzbS0ayK3fAB0kuU=;
        b=QRzUFfvktn6832GH3Cgb1IZd4jkQ3iW3CBqqsfsYp5wj+KAP5/ZWcsgc1EsZ9v3MOE
         YBuCId8GG9V566GoRbK+L8casmhcrIO3g2fXcCF4m7UKGL2mVRWHoA7lXV395TMmAnB9
         trtOXqRTQBssi74ghwYsn8tqsePeyVyrYBVvAS0LyHxKZxmKYT8ifG67hIKNuOkB4HcW
         R3pTZp0qbgdQgjHI3cOcwq7FPDgz/khDq4MbPqxhsu3dZqePos6vzpfIRI//D2CdVuoZ
         FdMOr+O9yhKG3p3z9SXHi1bMDdPv0c4WhGOKe1jG46MXTjjsDSOSzm62uXG5AAeIUYeH
         2SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zAatdENmuWE02Wtsxbg8mDmM1A4UzbS0ayK3fAB0kuU=;
        b=X9/EBsPFTV0fd9SEvEVplzdg6yyeECyEWaOnxf/8R7EgiYvbjUPak/kyhnLyZpC4wJ
         37x1/c7r0oN4mEMxrDTnWy8qci+IwtkfpfcSIS8lXGaevIKPeoNZsakG1TDzE6xD5fnD
         VmyUsykT13AMM4aF0F84cE2n5IoYcxEpWZC73Lr+XYfWNZuzRJsyT70qVX228kipsq0P
         UJH4+9c47JmgCMviGDVJNKP21VV3HBbsAkJxs1yx5vmGiMi3eqFpGaKir7DZ2azqdtto
         MvR2zyAxZ8da2ySdu8ef5J9LgQpkU9bdjI5E/hLe/0O3EhmtXtbm4o+vrcWtFC7eftlJ
         +MIg==
X-Gm-Message-State: AOAM530InlOkZRhtYVLBoBYbhfuo+FuwVxeF4AIIQuZBEyskbepco6Wh
        vkoTgchEZCEVH9tEOgBEKsOwiw==
X-Google-Smtp-Source: ABdhPJz6UJTClZacEqO4c79WzEZSxkEyGAYFFnKB76Jha8aR7zWTqaip6ExYHD2hO5EdgFxK8jAdcg==
X-Received: by 2002:a17:906:174e:: with SMTP id d14mr8679223eje.397.1622890637819;
        Sat, 05 Jun 2021 03:57:17 -0700 (PDT)
Received: from PackardBell (192038129059.mbb.telenor.dk. [192.38.129.59])
        by smtp.googlemail.com with ESMTPSA id z19sm3824023edr.77.2021.06.05.03.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 03:57:17 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id 1555d0a1;
        Sat, 5 Jun 2021 10:57:14 +0000 (UTC)
Date:   Sat, 5 Jun 2021 12:57:14 +0200
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] clk: qcom: smd-rpm: Add support for MSM8226 RPM
 clocks
Message-ID: <20210605105714.GA13168@PackardBell>
References: <20210502122027.9351-1-bartosz.dudziak@snejp.pl>
 <20210502122027.9351-5-bartosz.dudziak@snejp.pl>
 <162261964337.4130789.14816345669886604238@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162261964337.4130789.14816345669886604238@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 12:40:43AM -0700, Stephen Boyd wrote:
> Quoting Bartosz Dudziak (2021-05-02 05:20:27)
> > Add rmp smd clocks, PMIC and bus clocks which are required on MSM8226
> > for clients to vote on.
> > 
> > Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
> > ---
> >  drivers/clk/qcom/clk-smd-rpm.c | 74 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> > 
> > diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> > index 0e1dfa8948..bf73942e86 100644
> > --- a/drivers/clk/qcom/clk-smd-rpm.c
> > +++ b/drivers/clk/qcom/clk-smd-rpm.c
> > @@ -406,6 +406,79 @@ static const struct clk_ops clk_smd_rpm_branch_ops = {
> >         .unprepare      = clk_smd_rpm_unprepare,
> >  };
> >  
> > +/* msm8226 */
> 
> This doesn't apply anymore. Can you resend just this one patch please?
> And base it on clk-next which I will push out shortly. Ideally a bunch
> of clks can be reused instead of redefined.
> 
> > +DEFINE_CLK_SMD_RPM(msm8226, pnoc_clk, pnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 0);
> > +DEFINE_CLK_SMD_RPM(msm8226, snoc_clk, snoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 1);

I have send v2 of this one patch. I have reused the clocks from MSM8974 because
after the change my code happened to be the exacly same as msm8974_clks struct.

