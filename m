Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CED400287
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 17:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349681AbhICPrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 11:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbhICPrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:47:48 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85312C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 08:46:48 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id k17so3549736pls.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sqqe0m+lG2gnGk/qc8Vy/PEugdCzsPQEHtnGYob2kwI=;
        b=jYQUzs5eoeHViiY6eSMLM1li3JAQtUU6Xmmw+m08JVIAA7TL9OzMz8lvQ3dTh20YRP
         L8FTyBupdXpXkOPVReMJ3O1NZleiGPOQRCppqNMScGzem3X4AiCukawmV8fbpWfBYWRp
         zx5USfjXXlZvPqTFnYbNjyKhgM6GMiEMStuv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sqqe0m+lG2gnGk/qc8Vy/PEugdCzsPQEHtnGYob2kwI=;
        b=GqQjiwGgSgH9Bm96RitSPFUI40DUoux7hoEyc6WFMgmcLnfef0gCssO+vg8J9jxGE/
         Pn4cS3T7kBCvukL2yragkRywaHAX3LIvl23nr/13iF3OJ1+rBngmm6E/3fh1ZFIO2qiW
         6C6oF78Hfr9m3e8jx0JJGuC/bYm8G5VlgR5cVmUJ4AM8uj+4weQz2P1LYvSAwEZq2pNZ
         GwFRBsHOnl9Kwn0CiVlXooLxcnT7kaQsJebDR0VdoL39J2Cc8FXIrv/vLtv4GE7WGqt3
         81e9YPqII++jFmq7AA2NpBsGuB9enA8Ho0ajXP1neCRs0f8Kw8O8lnl/Dcle6X33H/S5
         We9g==
X-Gm-Message-State: AOAM532SeZiR/RrH+8lfsSOeIpznwDMkB6jz+csutD4XSroh9dsZZfV9
        xEGexQr7E+QsKRpdMmVlmD7qlQ==
X-Google-Smtp-Source: ABdhPJxvbyEuZMwtiZCbKL6+/BSvy2w0L8i7C/gN4t5Bif7KwFFgeSD5LQo+OhnWncNrBDJM4gQxEw==
X-Received: by 2002:a17:90a:dc03:: with SMTP id i3mr10283922pjv.163.1630684008001;
        Fri, 03 Sep 2021 08:46:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:80b3:9f00:3170:fd8b])
        by smtp.gmail.com with UTF8SMTPSA id d4sm5537757pfv.21.2021.09.03.08.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 08:46:47 -0700 (PDT)
Date:   Fri, 3 Sep 2021 08:46:45 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     rajpat@codeaurora.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org
Subject: Re: [PATCH V5 1/7] arm64: dts: sc7280: Add QSPI node
Message-ID: <YTJDZRw1D444JCNt@google.com>
References: <1628754078-29779-1-git-send-email-rajpat@codeaurora.org>
 <1628754078-29779-2-git-send-email-rajpat@codeaurora.org>
 <YRUdccjvf+ivbqor@google.com>
 <d271d1dafe56cbb58d35a63ec6944b14@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d271d1dafe56cbb58d35a63ec6944b14@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 06:29:41PM +0530, rajpat@codeaurora.org wrote:
> On 2021-08-12 18:39, Matthias Kaehlcke wrote:
> > On Thu, Aug 12, 2021 at 01:11:12PM +0530, Rajesh Patil wrote:
> > > From: Roja Rani Yarubandi <rojay@codeaurora.org>
> > > 
> > > Add QSPI DT node and qspi_opp_table for SC7280 SoC.
> > > 
> > > Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> > > Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 62
> > > ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 62 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > index 53a21d0..f8dd5ff 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > @@ -415,6 +415,25 @@
> > >  		method = "smc";
> > >  	};
> > > 
> > > +	qspi_opp_table: qspi-opp-table {
> > > +		compatible = "operating-points-v2";
> > > +
> > > +		opp-75000000 {
> > > +			opp-hz = /bits/ 64 <75000000>;
> > > +			required-opps = <&rpmhpd_opp_low_svs>;
> > > +		};
> > > +
> > > +		opp-150000000 {
> > > +			opp-hz = /bits/ 64 <150000000>;
> > > +			required-opps = <&rpmhpd_opp_svs>;
> > > +		};
> > > +
> > > +		opp-300000000 {
> > > +			opp-hz = /bits/ 64 <300000000>;
> > > +			required-opps = <&rpmhpd_opp_nom>;
> > > +		};
> > > +	};
> > > +
> > 
> > From v3:
> > 
> > roja> Can we move this "qspi_opp_table" to / from /soc?
> > 
> > bjorn> If you have made a proper attempt to convince Rob and Mark that
> > bjorn> a child "opp-table" in a SPI master is not a SPI device - and the
> > bjorn> conclusion is that this is not a good idea...then yes it should
> > live
> > bjorn> outside /soc.
> > 
> > I didn't see a follow up on this, was such an attempt made? Is there a
> > link to the discussion?
> 
> For now I am keeping qspi_opp_table  and qup_opp_table outside the SoC and
> posting V6.
> I will continue the discussion with DT folks and once concluded I will
> update as required.

Do you have a link to that discussion so that people can follow along or
chime in?
