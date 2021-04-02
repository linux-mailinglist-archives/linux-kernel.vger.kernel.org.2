Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D9D353058
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbhDBUfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBUfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:35:46 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC58BC061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 13:35:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id j25so4247214pfe.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 13:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bYNefTtueRtbK9O76WmEEWHha/LaZSXchRlV45JIZY8=;
        b=ECzeFdIxkBHD3YuCPbITfi9978+nZyYdB2UVcft7Fw5RKrXyQLUz9marixQu3+5aui
         Fgijkbi2pQCLb6wq23xYFNjKmrJxj6s4Qvkq4DRJ3VFJMxo5C02xxeQ2os/qLQNKyzqE
         IWNIujy4eiu4ixYhTF43C8aUNJHDCUSs7h7vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bYNefTtueRtbK9O76WmEEWHha/LaZSXchRlV45JIZY8=;
        b=Q2jS7CXqL2+FhrWfSG+NTP+xF5b1W34IkUpYWXDA708XLTcReUCEkJfZLaO5Xw+HYu
         dybRXB2BMzpsPeAisUH8nu497GPck6y+/GG+Su1VMHaWQEtz3xKhQz+wLgRrTSanhMro
         HaBvzhTIhh4di5wP/oVub5EfQXLNzqBUxCAayd2mocTzYiilKiGYqZOyBczxfiwVCS2i
         QxlgHVzYP4RWLAxCn246inbHZLsZh4S9C4B9TH+3nitJ8oAMGpdxL+Wrgt+S7/nVWTvu
         uUWMlVjxsHptfsm1TSjzEq2pjOM9GRij655QpK+Ws/b3D5VUkJbyyZbHV7krHOvMtLtJ
         1OeQ==
X-Gm-Message-State: AOAM5328GzCTyo8T+B4GAUc9PRrjQX28dFqxjteaSgPutwSk3vbgib1M
        1q/AvaIcEOtlEZa8E7GpAxGAPQ==
X-Google-Smtp-Source: ABdhPJxTz7TYSh6p4CoKhJAPlT3l2XcEh6VEdLMIe6/tWCfwXt3SK7RLev4FROoopZ5UmHf/w9E0xQ==
X-Received: by 2002:a62:8ccc:0:b029:1f6:c5e2:69ff with SMTP id m195-20020a628ccc0000b02901f6c5e269ffmr13801935pfd.46.1617395742219;
        Fri, 02 Apr 2021 13:35:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:581c:e04f:7c08:c602])
        by smtp.gmail.com with UTF8SMTPSA id h18sm5277415pgj.51.2021.04.02.13.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 13:35:41 -0700 (PDT)
Date:   Fri, 2 Apr 2021 13:35:40 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [PATCH V2 1/5] arm64: dts: qcom: pm7325: Add PMIC peripherals
 for pm7325
Message-ID: <YGeAHKOq65WBr9Yr@google.com>
References: <1617268396-1837-1-git-send-email-skakit@codeaurora.org>
 <1617268396-1837-2-git-send-email-skakit@codeaurora.org>
 <YGdV+un4bGcF6jJH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGdV+un4bGcF6jJH@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 10:35:54AM -0700, Matthias Kaehlcke wrote:
> On Thu, Apr 01, 2021 at 02:43:12PM +0530, satya priya wrote:
> 
> > subject: arm64: dts: qcom: pm7325: Add PMIC peripherals for pm7325
> 
> nit: maybe just 'arm64: dts: qcom: Add pm7325 support/.dtsi' or similar?
> 
> > Add temp-alarm and GPIO support for pm7325.
> 
> nit: it's more than that, you are adding the .dtsi for the PMIC itself.
> 
> > Signed-off-by: satya priya <skakit@codeaurora.org>
> > ---
> >  arch/arm64/boot/dts/qcom/pm7325.dtsi | 53 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/pm7325.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/pm7325.dtsi b/arch/arm64/boot/dts/qcom/pm7325.dtsi
> > new file mode 100644
> > index 0000000..1e0848a
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/pm7325.dtsi
> > @@ -0,0 +1,53 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +// Copyright (c) 2021, The Linux Foundation. All rights reserved.
> > +
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/spmi/spmi.h>
> > +
> > +&spmi_bus {
> > +	pm7325: pmic@1 {
> > +		compatible = "qcom,pm7325", "qcom,spmi-pmic";
> 
> I saw the patches that add the compatible strings for the GPIOs, but
> can't find those that add the strings for the PMICs themselves. Could
> you provide a link if they have been sent already?
> 
> > +		reg = <0x1 SPMI_USID>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		pm7325_temp_alarm: temp-alarm@a00 {
> > +			compatible = "qcom,spmi-temp-alarm";
> > +			reg = <0xa00>;
> > +			interrupts = <0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> > +			#thermal-sensor-cells = <0>;
> > +		};
> > +
> > +		pm7325_gpios: gpios@8800 {
> > +			compatible = "qcom,pm7325-gpio", "qcom,spmi-gpio";
> > +			reg = <0x8800>;
> > +			gpio-controller;
> > +			gpio-ranges = <&pm7325_gpios 0 0 10>;

The GPIO enumeration is a bit confusing. The pm7325 has GPIO_01 to
GPIO_10, however IIUC they are mapped such that under Linux
enumeration starts with 0. I guess it makes sense to start with 0 and
it's done consistently for 'qcom,spmi-gpio', but it's something that must
be taken into account when using/configuring those GPIOs.
