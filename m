Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4322344514F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 10:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhKDJrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 05:47:51 -0400
Received: from foss.arm.com ([217.140.110.172]:45562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231293AbhKDJrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 05:47:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 884091063;
        Thu,  4 Nov 2021 02:45:11 -0700 (PDT)
Received: from [10.57.56.48] (unknown [10.57.56.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 998903F719;
        Thu,  4 Nov 2021 02:45:09 -0700 (PDT)
Subject: Re: [PATCH 10/10] ARM: dts: msm: Add TPDA and TPDM support to DTS for
 RB5
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
 <1634801936-15080-11-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a372fe18-e1c8-57cd-8986-b4d6dbca091b@arm.com>
Date:   Thu, 4 Nov 2021 09:45:08 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1634801936-15080-11-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2021 08:38, Tao Zhang wrote:
> Add TPDA and TPDM support to DTS for RB5 board. This change is a
> sample for validating. After applying this patch, the new TPDM and
> TPDA nodes can be observed at the coresight devices path. TPDM and
> TPDA hardware can be operated by commands.
> 
> List the commands for validating this series patches as below.
> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
> echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
> echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
> cat /dev/tmc_etf0 > /data/etf-tpdm0.bin
> echo 0 > /sys/bus/coresight/devices/tpdm0/enable_source
> echo 0 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> echo 1 > /sys/bus/coresight/devices/tpdm1/enable_source
> echo 1 > /sys/bus/coresight/devices/tpdm1/integration_test
> echo 2 > /sys/bus/coresight/devices/tpdm1/integration_test
> cat /dev/tmc_etf0 > /data/etf-tpdm1.bin
> echo 0 > /sys/bus/coresight/devices/tpdm1/enable_source
> echo 0 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> echo 1 > /sys/bus/coresight/devices/tpdm2/enable_source
> echo 1 > /sys/bus/coresight/devices/tpdm2/integration_test
> echo 2 > /sys/bus/coresight/devices/tpdm2/integration_test
> cat /dev/tmc_etf0 > /data/etf-tpdm2.bin
> echo 0 > /sys/bus/coresight/devices/tpdm2/enable_source
> echo 0 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> 



> If the data from TPDMs can be obtained from the ETF, it means
> that the TPDMs verification is successful. At the same time,


How can we decode the TPDM trace ? Is there a public decoder
available ?

> since TPDM0, TPDM1 and TPDM2 are all connected to the same
> funnel "funnel@6c2d000" and output via different output ports,
> it also means that the following patches verification is
> successful.
> coresight: add support to enable more coresight paths
> coresight: funnel: add support for multiple output ports
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 439 +++++++++++++++++++++++
>   1 file changed, 439 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index 8ac96f8e79d4..bcec8b181e11 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -222,6 +222,445 @@


> +
> +	funnel@6b04000 {
> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +		arm,primecell-periphid = <0x000bb908>;
> +
> +		reg = <0 0x6b04000 0 0x1000>;
> +		reg-names = "funnel-base";
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				merge_funnel_out: endpoint {
> +					remote-endpoint =
> +						<&etf_in>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@7 {
> +				reg = <7>;
> +				swao_funnel_in7: endpoint {

> +					slave-mode;

This is obsolete, with the new in-ports/out-ports construct.

Suzuki
