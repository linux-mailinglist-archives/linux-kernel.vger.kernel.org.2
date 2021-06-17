Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222EB3ABB30
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 20:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhFQSKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 14:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhFQSKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 14:10:54 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C94CC061760
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 11:08:46 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u11so7488106oiv.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 11:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZWAtKejhgz7UVc2zxEARtNZRO1cFJMdr53epcTcnzQU=;
        b=SmXNfNN2GaeN/N9ZSUYywQZRxGS1n0N3xvZ9k20jD/BQxh/8cpcWPHrfQ4V0PBbsLw
         7pG7rMJxSCTKe4/c0KWbQzAiQvGRd3P5jTfMElHq8h+N9/XxlzRCeA/li264bWpoulP8
         W5iq9X83wZjEhb3EMAgTYTszLcWT/wy/qT3anZD7LVMbacfbAdnGyPfSot69Ce0p6uLe
         JcBS07LfKiLpYxMuW7DbxUnAjVmluJ6l4sETLGuTnkU2VP+esxiJlTejCn5z0pcQkKIi
         Vnov8GzWZvbXq2/MWj3kI5ZJg2uRnFY2OyJooAGoBQ17cD0aVUR94WMg+dOCpCL69pUm
         301g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZWAtKejhgz7UVc2zxEARtNZRO1cFJMdr53epcTcnzQU=;
        b=uRzSV+JkM0Q+ofFNfbuwKG9+UQIB5JX6u+wDifRJrWTlAFetJimQOLvztW3dGQr+ya
         bJ6FYBrbRSobninDA72MNgxar8tM9EkRxlZgmxDR8y6QePisC94xD2gOlupQ1nzQAdVM
         BENW4xIPTqDY1B9bKzOBQe++BSaghVZCmazyuR5FMZ+icJy1HX//bL8Gp93k2LcwHSsW
         dKYb2hGlptAErizBoz9lgXSopI5gEPpE1FtMo1afn0oTXS/txDok8+7BPbQZ+vDt2zkZ
         Wth/r8hOxFHmbLi/1z8V8KD2+SaLl5+gonMrSdoex6dypIJqpDnE+ZPi+xcxdlIIZ+gU
         rmBg==
X-Gm-Message-State: AOAM531UDCLObUV7e3JpV70krb8juY4ou4xkYv0xKZMDy66x63ujepLy
        pUg54OySFTIXasiunwwMtg4S5px79rce5Q==
X-Google-Smtp-Source: ABdhPJxzYhs5dxvu+rAjh/dDCuwN000ZxS95j0d7tuw6JhuGYHb0ckK49VOQdB3Jwk6DvH7y19F7PQ==
X-Received: by 2002:aca:d54f:: with SMTP id m76mr11073112oig.178.1623953325492;
        Thu, 17 Jun 2021 11:08:45 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o20sm371996ook.40.2021.06.17.11.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 11:08:44 -0700 (PDT)
Date:   Thu, 17 Jun 2021 13:08:43 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] arch: arm64: dts: qcom: Add support for SM6125
Message-ID: <YMuPqwzeG/UgnJAA@builder.lan>
References: <20210613080522.25230-1-martin.botka@somainline.org>
 <YMlF/aPn+253UIHn@builder.lan>
 <ZIPSUQ.3JME0AID86CV1@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIPSUQ.3JME0AID86CV1@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16 Jun 08:01 CDT 2021, Martin Botka wrote:

> 
> 
> On Tue, Jun 15 2021 at 07:29:49 PM -0500, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > On Sun 13 Jun 03:05 CDT 2021, Martin Botka wrote:
> > 
> > >  This commits adds the Device tree file for SM6125 SoC.
> > > 
> > >  Signed-off-by: Martin Botka <martin.botka@somainline.org>
> > 
> > Thanks for your work on this Martin, just spotted a few minor finishing
> > touches below.
> 
> :)
> 
> > 
> > >  ---
> > >  Changes in V2:
> > >  Update compatibles for mailbox & pinctrl
> > >  Changes in V3:
> > >  Fix reg for sdhci1
> > >  Replace hc_mem with hc and core_mem with core
> > >   arch/arm64/boot/dts/qcom/sm6125.dtsi | 603
> > > +++++++++++++++++++++++++++
> > >   1 file changed, 603 insertions(+)
> > >   create mode 100644 arch/arm64/boot/dts/qcom/sm6125.dtsi
> > > 
> > >  diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > > b/arch/arm64/boot/dts/qcom/sm6125.dtsi
[..]
> > >  +			sdc2_state_off: sdc2-off {
> > 
> > This should be common between all boards (except possibly the cd line),
> > so this is okay to share here.
> 
> Do you want me to move the cd as well or
> do you want it to stay in here?
> 

While the pin assignment typically follows the reference design, in my
view it's just any random GPIO and hence better suited to live in the
board file.

Regards,
Bjorn
