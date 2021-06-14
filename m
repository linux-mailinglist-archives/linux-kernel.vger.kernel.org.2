Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799613A6BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhFNQeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:34:00 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:33743 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbhFNQd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:33:59 -0400
Received: by mail-oi1-f179.google.com with SMTP id t140so14969485oih.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M+AF+mCkpp4kl1lOa7pY3pKoyZ9EzI3bIOnjriCC7ec=;
        b=jDHx4M/TAH39G2PaYBua5rrq7uf9nxNWz19BlA8WjwVFX7cjutzxxOlpLEPy3AiSEi
         LPC7X6Hl5TvxU0Nmr8qonCWhylXaVmH+yZu9yQohe0hAt5wi2wqLb0ppa3TPHcYj4FPg
         +xHCZ4ccLdQarlmppKqLZLzEWEpbbjMPJn/U6DL0QUdoyb2lgqqynCsp+RQoCc6U3Ljm
         NDv9jHAXaCwyicXO72hYHY33mUJ5FWeyIlF6QrXbVAuUXwNiSmvB4OWJ0j7pYMynFqnr
         +yYizd+bQihhOJOyAHOAJcsuUOZPX9jxxYyBzEu+XozZYF5RBTGt60ETgOBqfrmuWqSy
         7EXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M+AF+mCkpp4kl1lOa7pY3pKoyZ9EzI3bIOnjriCC7ec=;
        b=LgxpVIqHXOSsT8OakNshPrEILeHq/Jdhh0zMY3iFD+3gBjzImhMBQqVEtpUuNQZiqL
         MSj0COsQF3Pbcwd31dzEjZ0M7CQaDGaqHhEHw+VE4JnqvP92sW18IWVNlF18XkYDnLYD
         Ipc5xOzU2YV57AlME8Qq8ylQdFjPtUeTQeu66jEGKQlyrdXqR/q1nsCPRf7LvXBA1SOa
         giPq/jo1sVxJu/wJy+71HsHrmqoSLbrrp6XjCl9vj+8fUsJfyBqayxxML0yTiCHHZ7be
         iEp+pYt65zeBb2vuqk2RiAgDk5uK4kuBLX4HlRDG8/gR8nnM2QM4RWM7+DoA739leR2u
         Obdw==
X-Gm-Message-State: AOAM5333Bw8w+X8bl45HXXEG8F00gU2vdzjl7bFAE6lCFolEhKI2DfsE
        uwByDcCzyrOwGwX+FP7D5XIF5g==
X-Google-Smtp-Source: ABdhPJzjl6Cfpe9v4eOyRAmwGqbG4q5aSjdR3OUYr6L/+u6Z4Fx5DhToxlH/X+/0dbLsfpVtwKE0xA==
X-Received: by 2002:a05:6808:b11:: with SMTP id s17mr10524824oij.62.1623688256779;
        Mon, 14 Jun 2021 09:30:56 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n7sm3122251oom.37.2021.06.14.09.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 09:30:56 -0700 (PDT)
Date:   Mon, 14 Jun 2021 11:30:54 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     sbhanu@codeaurora.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, vbadigan@codeaurora.org,
        rampraka@codeaurora.org, sayalil@codeaurora.org,
        sartgarg@codeaurora.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, sibis@codeaurora.org,
        okukatla@codeaurora.org, djakov@kernel.org, cang@codeaurora.org,
        pragalla@codeaurora.org, nitirawa@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org
Subject: Re: [PATCH V1] arm64: dts: qcom: sc7180: Added xo clock for eMMC and
 Sd card
Message-ID: <YMeEPg7EPC5E/MfW@builder.lan>
References: <1623309107-27833-1-git-send-email-sbhanu@codeaurora.org>
 <YMLm96edhIYOJF+E@builder.lan>
 <1230be3c7f350b1f33110df2a9744e15@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1230be3c7f350b1f33110df2a9744e15@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Jun 06:55 CDT 2021, sbhanu@codeaurora.org wrote:

> On 2021-06-11 10:00, Bjorn Andersson wrote:
> > On Thu 10 Jun 02:11 CDT 2021, Shaik Sajida Bhanu wrote:
> > 
> > > Added xo clock for eMMC and Sd card.
> > 
> > Was about to push out my branch of patches, but before I do. Can you
> > please describe WHY this is needed?
> > 
> > Regards,
> > Bjorn
> 
> We are making use of this clock in dll register value calculation,
> The default PoR value is also same as calculated value for
> HS200/HS400/SDR104 modes.
> But just not to rely on default register values we need this entry.
> 

That is the perfect thing to include in a commit message!

I rewrote yours and applied the change, but please next time do describe
the "why" of your change.

Regards,
Bjorn

> > 
> > > 
> > > Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sc7180.dtsi | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > index 295844e..5bb6bd4 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > @@ -701,8 +701,9 @@
> > >  			interrupt-names = "hc_irq", "pwr_irq";
> > > 
> > >  			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
> > > -					<&gcc GCC_SDCC1_AHB_CLK>;
> > > -			clock-names = "core", "iface";
> > > +					<&gcc GCC_SDCC1_AHB_CLK>,
> > > +					<&rpmhcc RPMH_CXO_CLK>;
> > > +			clock-names = "core", "iface","xo";
> > >  			interconnects = <&aggre1_noc MASTER_EMMC 0 &mc_virt SLAVE_EBI1 0>,
> > >  					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_EMMC_CFG 0>;
> > >  			interconnect-names = "sdhc-ddr","cpu-sdhc";
> > > @@ -2666,8 +2667,9 @@
> > >  			interrupt-names = "hc_irq", "pwr_irq";
> > > 
> > >  			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
> > > -					<&gcc GCC_SDCC2_AHB_CLK>;
> > > -			clock-names = "core", "iface";
> > > +					<&gcc GCC_SDCC2_AHB_CLK>,
> > > +					<&rpmhcc RPMH_CXO_CLK>;
> > > +			clock-names = "core", "iface", "xo";
> > > 
> > >  			interconnects = <&aggre1_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1
> > > 0>,
> > >  					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
> > > --
> > > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> > > member
> > > of Code Aurora Forum, hosted by The Linux Foundation
> > > 
