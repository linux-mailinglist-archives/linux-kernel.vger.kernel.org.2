Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA3A40CD58
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 21:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhIOTmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 15:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbhIOTmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 15:42:18 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A08C061766
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 12:40:59 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id x10-20020a056830408a00b004f26cead745so5084630ott.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 12:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=mDzdWtBB1uSsJFNpS+LW0eoU/BmEDcIzioUx3tBX9MQ=;
        b=Ly9kyawmN861/4Wr1C8M9aEGfTfVB+G/JQ7VM6jBRtd5RWpnuD2lPePwRMRuLavd/Z
         l8suHz6HXSPxNA92D6B5fDECCdQZfwfXlT/5HCGbUPotXdK7yhmz23qRgEnePR+XiRHf
         BSt2Q4tYyys9osDsdTtmsmngLHLwlhPe6oNPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=mDzdWtBB1uSsJFNpS+LW0eoU/BmEDcIzioUx3tBX9MQ=;
        b=wIeiior4Wg2DT+9yQx57qrqds5qWzW6/VMunZMo85Fhd4kVquxHJ5zKBpVK1G+yPxf
         Td3mOKE/Q90fW00y4yqam0ZSm9dN9b8XlJ2dC5VSvvrqWeiQYVKWHNCYmsTSyuk1lXI2
         PHDtXqzfYFxRiizqAFEDvJdpmInmIuEKVKL3FdVZhVkpSRoV8v/savBZvu+gTgjbGaY+
         9JaXPcxAOEtGwl7/cHih7HjVDOIzb/LD13zbKk0OEv8lAREYUkRsVzPb7ojaum91px9U
         Cmlkfofilh4CQTwgfqrdteKVg7JwnjiymUemxDn12esyY+qipxQQFxZT9AWakdYZ41SC
         01Ow==
X-Gm-Message-State: AOAM530aQ0cH8j6K3X+wJLpDlYPVVCnJ1oTIz8BHaew0YQnY6Y1XWXVD
        VW2Yun8ArkFsjr+plU0pyV6oXbxNdphfjfzp3FNkkQ==
X-Google-Smtp-Source: ABdhPJwivxhkg8fCpBrYDaYtdYT13Ef9VjmdoM5RJyzQ0CrKUqXreux0XnV6qMdYSvfLig+lS8I5BpdTbzuXMDMwPsI=
X-Received: by 2002:a05:6830:18c7:: with SMTP id v7mr1527419ote.126.1631734858214;
 Wed, 15 Sep 2021 12:40:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Sep 2021 12:40:57 -0700
MIME-Version: 1.0
In-Reply-To: <36fe241f845a27b52509274d007948b1@codeaurora.org>
References: <1629458622-4915-1-git-send-email-okukatla@codeaurora.org>
 <1629458622-4915-4-git-send-email-okukatla@codeaurora.org>
 <CAE-0n51WBdLoJRPs9tWZgdAukJMnkD3V00o7xNYVX77-eToKvw@mail.gmail.com>
 <749157bdb4613ae370adfb7ba055a2a9@codeaurora.org> <36fe241f845a27b52509274d007948b1@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 15 Sep 2021 12:40:57 -0700
Message-ID: <CAE-0n53g=qGoVAMh_me_W0ksp39WUm2CCwAttcAK+Do5nYXq5g@mail.gmail.com>
Subject: Re: [v7 3/3] arm64: dts: qcom: sc7280: Add EPSS L3 interconnect provider
To:     okukatla@codeaurora.org
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        evgreen@google.com, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdtipton@codeaurora.org, sibis@codeaurora.org,
        saravanak@google.com, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        okukatla=codeaurora.org@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting okukatla@codeaurora.org (2021-09-14 23:26:19)
> On 2021-09-15 10:35, okukatla@codeaurora.org wrote:
> > On 2021-09-04 00:36, Stephen Boyd wrote:
> >> Quoting Odelu Kukatla (2021-08-20 04:23:41)
> >>> Add Epoch Subsystem (EPSS) L3 interconnect provider node on SC7280
> >>> SoCs.
> >>>
> >>> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 11 +++++++++++
> >>>  1 file changed, 11 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>> index 53a21d0..cf59b47 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>> @@ -1848,6 +1848,17 @@
> >>>                         };
> >>>                 };
> >>>
> >>> +               epss_l3: interconnect@18590000 {
> >>> +                       compatible = "qcom,sc7280-epss-l3";
> >>> +                       reg = <0 0x18590000 0 1000>,
> >>
> >> Is this supposed to be 0x1000?
> >>
> > No, This is 1000 or 0x3E8.

Wow ok. Why is it the only size that isn't in hex format? Please try to
be consistent and use hex throughout.

> We have mapped only required registers for L3 scaling, 1000/0x3E8 is
> suffice.
> But i will update it to 0x1000 in next revision so that entire clock
> domain region-0 is mapped.

Doesn't that conflict with the cpufreq-hw device?

> >>> +                             <0 0x18591000 0 0x100>,
> >>> +                             <0 0x18592000 0 0x100>,
> >>> +                             <0 0x18593000 0 0x100>;
> >>> +                       clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc
> >>> GCC_GPLL0>;
> >>> +                       clock-names = "xo", "alternate";
> >>> +                       #interconnect-cells = <1>;
> >>> +               };
> >>> +
> >>>                 cpufreq_hw: cpufreq@18591000 {
> >>>                         compatible = "qcom,cpufreq-epss";
> >>>                         reg = <0 0x18591100 0 0x900>,
