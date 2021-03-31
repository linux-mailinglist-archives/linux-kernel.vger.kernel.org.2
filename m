Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEB0344D73
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhCVRep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhCVReP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:34:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FDFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:34:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so11439732pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZTfII6POCNEluodQz5yotvd4hAEczwlgR5GMdEQuM9g=;
        b=NrXGkWPvPj1VDmcE/Bhd1ob9aZ9YrpEvkFWIIevqDjjkAGNNoLgTXgnQHZGUDgiAlP
         M48kGLiH2xn8V35tX7BJxHostmFj4z+trzF+fp/DQq5SWrxnhPQRl/ylBOiCu//YPeKb
         Tm6qIHZzuBiAoYtfFTX1AGY1+A9i3G82dVufU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZTfII6POCNEluodQz5yotvd4hAEczwlgR5GMdEQuM9g=;
        b=m6Gx5shWSKoyBxZ7HWM9iLVnnhoc70cdWzb8N8zbh5g+ABlL2orV5+bV1XTYjW94LR
         lPUxXQLnMY8gSqsGRo1V4WFKELg93KUKJZylxGkAslu2tjrMD6JJLp5H1rD5mgaO8zcK
         eUbWE+w5ZronTZ36qgSuo9vlMR45vjQIpRMC3MoRh5rauIXnBBY01lgjl3ARboOKriBt
         +lMAZhZQyfwcGOh1Cfj+ExaCa9gJZ/LhTDpY0YZ/+P6A0po+IWRGTL3XUQX+ZAMzcW3m
         n/KZzZ67Jot21/kU2r3UqN/ipAGS3bFNQTIJi8c3H9XNVTElsRhPXRQg/gZY3mTUfVeN
         SVcg==
X-Gm-Message-State: AOAM5320ct6qXGrAcMFbJVhykl6ngEv1L03FOu+v+Qtr37cfkDWf+Jx4
        oBJT52AGMGokTMk1s7go572DYg==
X-Google-Smtp-Source: ABdhPJw0JVZpXnjW6w3DDhmfW6r16VQLiVQxAlehOivNyGBgs+NxcwyQfFsq4hcOOT0meTD+9hFscQ==
X-Received: by 2002:a17:902:ec91:b029:e6:90aa:24de with SMTP id x17-20020a170902ec91b02900e690aa24demr627493plg.63.1616434452979;
        Mon, 22 Mar 2021 10:34:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:90a9:b908:f93a:2f78])
        by smtp.gmail.com with UTF8SMTPSA id j3sm13644972pfi.74.2021.03.22.10.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 10:34:12 -0700 (PDT)
Date:   Mon, 22 Mar 2021 10:34:10 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     skakit@codeaurora.org
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add PMIC peripherals for SC7280
Message-ID: <YFjVEjcx36J97hVW@google.com>
References: <1615459229-27573-1-git-send-email-skakit@codeaurora.org>
 <YEvR1kDm32tE7mK3@google.com>
 <4dc784eb3c00a9805141148732476838@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4dc784eb3c00a9805141148732476838@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Satya,

On Mon, Mar 22, 2021 at 06:50:47PM +0530, skakit@codeaurora.org wrote:
> Hi Matthias,
> 
> On 2021-03-13 02:10, Matthias Kaehlcke wrote:
> > Hi Satya,
> > 
> > On Thu, Mar 11, 2021 at 04:10:29PM +0530, satya priya wrote:
> > > Add PM7325/PM8350C/PMK8350/PMR735A peripherals such as PON,
> > > GPIOs, RTC and other PMIC infra modules for SC7280.
> > > 
> > > Signed-off-by: satya priya <skakit@codeaurora.org>
> > > ---
> > > This patch depends on base DT and board files for SC7280 to merge
> > > first
> > > https://lore.kernel.org/patchwork/project/lkml/list/?series=487403
> > > 
> > >  arch/arm64/boot/dts/qcom/pm7325.dtsi  |  60 ++++++++++++++++++++
> > >  arch/arm64/boot/dts/qcom/pm8350c.dtsi |  60 ++++++++++++++++++++
> > >  arch/arm64/boot/dts/qcom/pmk8350.dtsi | 104
> > > ++++++++++++++++++++++++++++++++++
> > >  arch/arm64/boot/dts/qcom/pmr735a.dtsi |  60 ++++++++++++++++++++
> > >  arch/arm64/boot/dts/qcom/sc7280.dtsi  |   8 +++
> > >  5 files changed, 292 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/qcom/pm7325.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/qcom/pm8350c.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/qcom/pmk8350.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/qcom/pmr735a.dtsi
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/pm7325.dtsi
> > > b/arch/arm64/boot/dts/qcom/pm7325.dtsi
> > > new file mode 100644
> > > index 0000000..393b256
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/qcom/pm7325.dtsi
> > > @@ -0,0 +1,60 @@
> > 
> > ...
> > 
> > > +		polling-delay-passive = <100>;
> > > +		polling-delay = <0>;
> > 
> > Are you sure that no polling delay is needed? How does the thermal
> > framework
> > detect that the temperatures is >= the passive trip point and that it
> > should
> > start polling at 'polling-delay-passive' rate?
> > 
> 
> As the temp-alarm has interrupt support, whenever preconfigured threshold
> violates it notifies thermal framework, so I think the polling delay is not
> needed here.

From the documentation I found it's not clear to me how exactly these
interrupts work. Is a single interrupt triggered when the threshold is
violated or are there periodic (?) interrupts as long as the temperature
is above the stage 0 threshold?

Why is 'polling-delay-passive' passive needed if there are interrupts? Maybe
to detect that the zone should transition from passive to no cooling when the
temperature drops below the stage 0 threshold?
