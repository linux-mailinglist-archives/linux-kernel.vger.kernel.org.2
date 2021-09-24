Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2AC416FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 12:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245517AbhIXKFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 06:05:41 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:41214 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245408AbhIXKFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 06:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1632477848; x=1664013848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZZELcawGMEhGBmqKIMHdWQDvBzpBI3IfZNheEWzMpKw=;
  b=OcWVY5js+aCCL1453HbTwmiPa8n/9FCyZP3UAuFm6FtQdHUa6Xu6Y975
   4vtvTkH3OlsubVvAlGjN2x7gucRwwBB5+JmaYmbivGZWkUO71TcEG6mvc
   Vmzr0IAZRn5RkiJJdO+IJfh/oP0e6ck0CBvizchSbWKSeMAvTyykYQJAY
   A=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 24 Sep 2021 03:04:08 -0700
X-QCInternal: smtphost
Received: from nalasex01c.na.qualcomm.com ([10.47.97.35])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 03:04:06 -0700
Received: from taozha-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Fri, 24 Sep 2021 03:04:03 -0700
Date:   Fri, 24 Sep 2021 18:04:00 +0800
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        "Leo Yan" <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm8250: Add Coresight support
Message-ID: <20210924100359.GA10261@taozha-gv.ap.qualcomm.com>
References: <1631515214-13653-1-git-send-email-quic_taozha@quicinc.com>
 <1631515214-13653-3-git-send-email-quic_taozha@quicinc.com>
 <57e2a1d8-15ec-0381-2b7d-95bbda7503ae@arm.com>
 <20210923092428.GA12869@taozha-gv.ap.qualcomm.com>
 <c9dea7c5-79c9-90a8-ad72-caa4c728a4b0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c9dea7c5-79c9-90a8-ad72-caa4c728a4b0@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 10:36:28AM +0100, Suzuki K Poulose wrote:
> On 23/09/2021 10:24, Tao Zhang wrote:
> >On Tue, Sep 21, 2021 at 05:35:37PM +0100, Suzuki K Poulose wrote:
> >>Hi Tao
> >>
> >>Are there no sinks at all on this platform ? I had this question on the
> >>previous series. How is CoreSight useful on this platform otherwise ?
> >>
> >>On 13/09/2021 07:40, Tao Zhang wrote:
> >ETF/ETR are the sinks on this target. And I have added the ETF to this
> >device tree file. Since the ETR needs SMMU support on this target and
> >SMMU has not been supported for now. I will add the ETR to device tree
> >later if the SMMU is ready for this platform.
> 
> Thanks. That is fine. Btw, these sort of additional information could be
> added to the cover letter to give a better picture of what you are trying to
> do and why.
> 
Sure. I will update this to the cover letter.
> >>>Add the basic coresight components found on Qualcomm SM8250 Soc. The
> >>>basic coresight components include ETF, ETMs,STM and the related
> >>>funnels.
> >>>
> >>>Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> >>>---
> >>>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 442 ++++++++++++++++++++++-
> >>>  1 file changed, 438 insertions(+), 4 deletions(-)
> >>>
> >>>diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> >>>index 8ac96f8e79d4..9c8f87d80afc 100644
> >>>--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> >>>+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> >>>@@ -222,11 +222,445 @@
> >>>  		regulator-max-microvolt = <1800000>;
> >>>  		regulator-always-on;
> >>>  	};
> >>>-};
> >>>-&adsp {
> >>>-	status = "okay";
> >>>-	firmware-name = "qcom/sm8250/adsp.mbn";
> >>
> >>Unrelated change ? Please keep it separate from the CoreSight changes.
> >>
> >>Suzuki
> >I combined this change and ETM pid change into one seies because the ETM
> >pid change validation needs ETM support. If there is no ETM
> >configuration in the device tree, ETM pid change can not be verified.
> >Do you think it would be better to separate them? Do I need to resubmit
> >to separate them into two separate patches?
> 
> No, I am asking about the lines removed above. i.e,
> 
>  -&adsp {
>  -	status = "okay";
>  -	firmware-name = "qcom/sm8250/adsp.mbn";
> 
> It doesn't seem to be added back in the patch. So that means, the DT
> lost those lines, without any mention of that in the description of
> the patch. Moreover, the lines do not look like they were anything to
> do with CoreSight. This is why I mentioned they look like "unrelated".
> 
> Suzuki
Yes, you are right. This is a mistake. This part of code should not be removed.
I will update the patch and resubmit it.

Best,
Tao
