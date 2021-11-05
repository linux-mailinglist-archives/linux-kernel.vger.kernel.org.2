Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AB844606E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhKEIKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:10:19 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:54297 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231590AbhKEIKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636099659; x=1667635659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e+EAw8a3Iw36rX9s0rmMRPvR1rewtX3f6M8O/rTcgZc=;
  b=dtZ8jB6VZyiaVU25k/p+VIaIKI6YZVU0m4HKVqMJAfi51nXuYWTGQ/hq
   mNTE47cIjpWX4rn+7I9GreveTl2oa7M6TzN8sW0F8FJbOdBdFPXoaDW/T
   sFPbcOL01McKlWXkdEWVvkXZTx33JhYV0dCY6cPN4CwzYCVcJIh5Zg/RA
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Nov 2021 01:07:38 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 01:07:38 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Fri, 5 Nov 2021 01:07:38 -0700
Received: from jinlmao-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Fri, 5 Nov 2021 01:07:34 -0700
Date:   Fri, 5 Nov 2021 16:07:31 +0800
From:   Jinlong <quic_jinlmao@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
CC:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Subject: Re: [PATCH 10/10] ARM: dts: msm: Add TPDA and TPDM support to DTS
 for RB5
Message-ID: <20211105080726.GA25738@jinlmao-gv.ap.qualcomm.com>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
 <1634801936-15080-11-git-send-email-quic_taozha@quicinc.com>
 <a372fe18-e1c8-57cd-8986-b4d6dbca091b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a372fe18-e1c8-57cd-8986-b4d6dbca091b@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review, Suzuki.  

On Thu, Nov 04, 2021 at 09:45:08AM +0000, Suzuki K Poulose wrote:
> On 21/10/2021 08:38, Tao Zhang wrote:
> > Add TPDA and TPDM support to DTS for RB5 board. This change is a
> > sample for validating. After applying this patch, the new TPDM and
> > TPDA nodes can be observed at the coresight devices path. TPDM and
> > TPDA hardware can be operated by commands.
> > 
> > List the commands for validating this series patches as below.
> > echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> > echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
> > echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
> > echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
> > cat /dev/tmc_etf0 > /data/etf-tpdm0.bin
> > echo 0 > /sys/bus/coresight/devices/tpdm0/enable_source
> > echo 0 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> > echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> > echo 1 > /sys/bus/coresight/devices/tpdm1/enable_source
> > echo 1 > /sys/bus/coresight/devices/tpdm1/integration_test
> > echo 2 > /sys/bus/coresight/devices/tpdm1/integration_test
> > cat /dev/tmc_etf0 > /data/etf-tpdm1.bin
> > echo 0 > /sys/bus/coresight/devices/tpdm1/enable_source
> > echo 0 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> > echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> > echo 1 > /sys/bus/coresight/devices/tpdm2/enable_source
> > echo 1 > /sys/bus/coresight/devices/tpdm2/integration_test
> > echo 2 > /sys/bus/coresight/devices/tpdm2/integration_test
> > cat /dev/tmc_etf0 > /data/etf-tpdm2.bin
> > echo 0 > /sys/bus/coresight/devices/tpdm2/enable_source
> > echo 0 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> > 
> 
> 
> 
> > If the data from TPDMs can be obtained from the ETF, it means
> > that the TPDMs verification is successful. At the same time,
> 
> 
> How can we decode the TPDM trace ? Is there a public decoder
> available ?
> 

There is an internal tool on PC host to parse the TPDM trace. 

> > since TPDM0, TPDM1 and TPDM2 are all connected to the same
> > funnel "funnel@6c2d000" and output via different output ports,
> > it also means that the following patches verification is
> > successful.
> > coresight: add support to enable more coresight paths
> > coresight: funnel: add support for multiple output ports
> > 
> > Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> > ---
> >   arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 439 +++++++++++++++++++++++
> >   1 file changed, 439 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > index 8ac96f8e79d4..bcec8b181e11 100644
> > --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > @@ -222,6 +222,445 @@
> 
> 
> > +
> > +	funnel@6b04000 {
> > +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> > +		arm,primecell-periphid = <0x000bb908>;
> > +
> > +		reg = <0 0x6b04000 0 0x1000>;
> > +		reg-names = "funnel-base";
> > +
> > +		clocks = <&aoss_qmp>;
> > +		clock-names = "apb_pclk";
> > +
> > +		out-ports {
> > +			port {
> > +				merge_funnel_out: endpoint {
> > +					remote-endpoint =
> > +						<&etf_in>;
> > +				};
> > +			};
> > +		};
> > +
> > +		in-ports {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			port@7 {
> > +				reg = <7>;
> > +				swao_funnel_in7: endpoint {
> 
> > +					slave-mode;
> 
> This is obsolete, with the new in-ports/out-ports construct.
> 

We will check and update.

> Suzuki
