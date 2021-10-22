Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEEE437BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhJVRRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhJVRRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:17:05 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB8BC061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:14:47 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id d21-20020a9d4f15000000b0054e677e0ac5so5154006otl.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=khihIRBEDwfkgoT9XzW4kObgxI4RYFVX0d5V9aipBkI=;
        b=JDzt2sgU2asdNcC2nctv1gQBaMXlCEYffS5ssU/Bhl7jtz1udhOlWYAbaY9MgQPnmC
         9WPcfPdlElKtgv/Ds+SNc1X3RLhGQxd1X9uHVsrAePxPYezIJntxfN3D7kzuR/oTH6gy
         hLwjKqsFCm6KKCjFhh16ZrDXiCzMgCoQosMHBukz5O4Xm3faQpoA3PsgIi0CpA3Vr+Ow
         aF+lgfRPShuK2+mE4DZTRnud06RvFCZHTW1tzxq25MO2a3RH7vFnQmj/YhlpTQMjddbQ
         3GE6JpDn1YfmndPhoglUiXkoFx57eGjkL9RfUl8Jw6tuh/CUCGiOahFYvpMrJ6tQUZ45
         qcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=khihIRBEDwfkgoT9XzW4kObgxI4RYFVX0d5V9aipBkI=;
        b=vC1esgGsoXio0lxW6Eb9Jj3zQcwe51XoxJlRdVoLQw3msYQ+HB7zJIuKvQJLTsKwns
         lFnWWSLVDISoCKhtTpn11kBiZIYfHXZ5ezFiKip95kdDcQiY2tRlpk6f3JIDKNWId8iz
         4yCfYlumwP+40KLHF4thEkTNr/X8tuN/SFyb+WBBzq8ILcIFObtSao00pjiCewPPACp4
         ortvx9adF7udn+Q/PqZrRaUd+9zA2TCfbt8eNyPeowKR2VL+S4+juy5YYEhZEYdZp+VE
         VltF8Tln832MWII5xzIHGHVYrD/v8H+J1YRbrLHsG/4pasYnMhPCGfvi738zlDjL2jUt
         LTGQ==
X-Gm-Message-State: AOAM532QfWxgzrfdqHOS98CMi1IUKeXBMR0waDCBcVwCQLsb2LiZfGfZ
        c8vQbo/MkpR0tZuxXC1tKXBs7w==
X-Google-Smtp-Source: ABdhPJyUurLqXmz/k4ajla41wyPVwPizzTYqnndr7ozwJjgTBnhA4qlZm4eBgUKwrA4WcgYLFUDcdQ==
X-Received: by 2002:a05:6830:2b11:: with SMTP id l17mr946819otv.298.1634922887137;
        Fri, 22 Oct 2021 10:14:47 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id p14sm1522495oov.0.2021.10.22.10.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:14:46 -0700 (PDT)
Date:   Fri, 22 Oct 2021 10:16:28 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        abhinavk@codeaurora.org, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 2/2] phy: qcom: Introduce new eDP PHY driver
Message-ID: <YXLx7EV7ZiMIxauO@ripper>
References: <20211016232128.2341395-1-bjorn.andersson@linaro.org>
 <20211016232128.2341395-2-bjorn.andersson@linaro.org>
 <YXGmJFoeXwtTvl7p@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXGmJFoeXwtTvl7p@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21 Oct 10:40 PDT 2021, Vinod Koul wrote:

> On 16-10-21, 16:21, Bjorn Andersson wrote:
> > Many recent Qualcomm platforms comes with native DP and eDP support.
> > This consists of a controller in the MDSS and a QMP-like PHY.
> > 
> > While similar to the well known QMP block, the eDP PHY only has TX lanes
> > and the programming sequences are slightly different. Rather than
> > continuing the trend of parameterize the QMP driver to pieces, this
> > introduces the support as a new driver.
> > 
> > The registration of link and pixel clocks are borrowed from the QMP
> > driver. The non-DP link frequencies are omitted for now.
> > 
> > The eDP PHY is very similar to the dedicated (non-USB) DP PHY, but only
> > the prior is supported for now.
> 
> since this is QMP phy, pls add an explanation why common QMP driver
> is not used here?
> 

Looked at this again, doesn't the second paragraph answer that?

> > +static int qcom_edp_phy_init(struct phy *phy)
> > +{
[..]
> > +	writel(0x00, edp->edp + DP_PHY_AUX_CFG0);
> > +	writel(0x13, edp->edp + DP_PHY_AUX_CFG1);
> > +	writel(0x24, edp->edp + DP_PHY_AUX_CFG2);
> > +	writel(0x00, edp->edp + DP_PHY_AUX_CFG3);
> > +	writel(0x0a, edp->edp + DP_PHY_AUX_CFG4);
> > +	writel(0x26, edp->edp + DP_PHY_AUX_CFG5);
> > +	writel(0x0a, edp->edp + DP_PHY_AUX_CFG6);
> > +	writel(0x03, edp->edp + DP_PHY_AUX_CFG7);
> > +	writel(0x37, edp->edp + DP_PHY_AUX_CFG8);
> > +	writel(0x03, edp->edp + DP_PHY_AUX_CFG9);
> 
> In qmp phy we use a table for this, that looks very elegant and I am
> sure next rev will have different magic numbers, so should we go the
> table approach here on as well..?
> 

Comparing the v3 and v4 USB/DP combo phy and this, the only number that
differs is CFG_AUX2 and CFG_AUX8.

CFG_AUX8 is 0x37 for eDP and 0xb7 for DP and AUX_CFG2 seems better to
mask together, but I don't fully understand the content yet.

I did check two other platforms and they have the same sequence, except
one additional bit in AUX_CFG2. There also seem to be a few additional
permutations of this value, so I don't think tables are the solution.


So I think it's better if we leave this as proposed and then
parameterize the two individual entries as needed when we go forward -
or determine that I missed something.

Regards,
Bjorn
