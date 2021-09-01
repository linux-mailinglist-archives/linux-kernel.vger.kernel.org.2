Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6AE3FD7F7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 12:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbhIAKrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 06:47:42 -0400
Received: from foss.arm.com ([217.140.110.172]:36034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231903AbhIAKrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 06:47:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 303671042;
        Wed,  1 Sep 2021 03:46:44 -0700 (PDT)
Received: from [10.57.92.220] (unknown [10.57.92.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FD723F766;
        Wed,  1 Sep 2021 03:46:42 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8250: Add Coresight support
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>
References: <1629365324-5891-1-git-send-email-quic_taozha@quicinc.com>
 <1629365324-5891-3-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <053c8907-3ad2-0d94-6afa-2328cffe57a8@arm.com>
Date:   Wed, 1 Sep 2021 11:46:41 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1629365324-5891-3-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2021 10:28, Tao Zhang wrote:
> Add the basic coresight components found on Qualcomm SM8250 Soc. The
> basic coresight components include ETF, ETMs,STM and the related
> funnels.
> 

The changes look good. One question though,

Are there any sinks at all ? (TMC-ETR ?).

Kind regards
Suzuki

> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 442 ++++++++++++++++++++++-
>   1 file changed, 438 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index 8ac96f8e79d4..9c8f87d80afc 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -222,11 +222,445 @@
>   		regulator-max-microvolt = <1800000>;
>   		regulator-always-on;
>   	};
> -};
>   
> -&adsp {
> -	status = "okay";
> -	firmware-name = "qcom/sm8250/adsp.mbn";
> +	stm@6002000 {
> +		compatible = "arm,coresight-stm", "arm,primecell";
> +		reg = <0 0x06002000 0 0x1000>,
> +		      <0 0x16280000 0 0x180000>;
> +		reg-names = "stm-base", "stm-stimulus-base";
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				stm_out: endpoint {
> +					remote-endpoint =
> +					  <&funnel0_in7>;
> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@6041000 {
> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +		reg = <0 0x06041000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				funnel0_out: endpoint {
> +					remote-endpoint =
> +					  <&merge_funnel_in0>;
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
> +				funnel0_in7: endpoint {
> +					remote-endpoint = <&stm_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@6042000 {
> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +		reg = <0 0x06042000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				funnel2_out: endpoint {
> +					remote-endpoint =
> +					  <&merge_funnel_in2>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@4 {
> +				reg = <4>;
> +				funnel2_in5: endpoint {
> +					remote-endpoint =
> +					  <&apss_merge_funnel_out>;
> +				};
> +			};
> +		};
> +	};
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
> +					remote-endpoint=
> +						<&merg_funnel_out>;
> +				};
> +			};
> +		};
> +
> +	};
> +
> +	funnel@6045000 {
> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +		reg = <0 0x06045000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				merg_funnel_out: endpoint {
> +					remote-endpoint = <&swao_funnel_in7>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				merge_funnel_in0: endpoint {
> +					remote-endpoint =
> +					  <&funnel0_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				merge_funnel_in2: endpoint {
> +					remote-endpoint =
> +					  <&funnel2_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etf@6b05000 {
> +		compatible = "arm,coresight-tmc", "arm,primecell";
> +		reg = <0 0x06b05000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		in-ports {
> +			port {
> +				etf_in: endpoint {
> +					remote-endpoint =
> +					  <&merge_funnel_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7040000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07040000 0 0x1000>;
> +
> +		cpu = <&CPU0>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm0_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in0>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7140000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07140000 0 0x1000>;
> +
> +		cpu = <&CPU1>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm1_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in1>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7240000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07240000 0 0x1000>;
> +
> +		cpu = <&CPU2>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm2_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in2>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7340000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07340000 0 0x1000>;
> +
> +		cpu = <&CPU3>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm3_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in3>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7440000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07440000 0 0x1000>;
> +
> +		cpu = <&CPU4>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm4_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in4>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7540000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07540000 0 0x1000>;
> +
> +		cpu = <&CPU5>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm5_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in5>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7640000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07640000 0 0x1000>;
> +
> +		cpu = <&CPU6>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm6_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in6>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7740000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07740000 0 0x1000>;
> +
> +		cpu = <&CPU7>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm7_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in7>;
> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@7800000 {
> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +		reg = <0 0x07800000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				apss_funnel_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_merge_funnel_in>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				apss_funnel_in0: endpoint {
> +					remote-endpoint =
> +					  <&etm0_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				apss_funnel_in1: endpoint {
> +					remote-endpoint =
> +					  <&etm1_out>;
> +				};
> +			};
> +
> +			port@2 {
> +				reg = <2>;
> +				apss_funnel_in2: endpoint {
> +					remote-endpoint =
> +					  <&etm2_out>;
> +				};
> +			};
> +
> +			port@3 {
> +				reg = <3>;
> +				apss_funnel_in3: endpoint {
> +					remote-endpoint =
> +					  <&etm3_out>;
> +				};
> +			};
> +
> +			port@4 {
> +				reg = <4>;
> +				apss_funnel_in4: endpoint {
> +					remote-endpoint =
> +					  <&etm4_out>;
> +				};
> +			};
> +
> +			port@5 {
> +				reg = <5>;
> +				apss_funnel_in5: endpoint {
> +					remote-endpoint =
> +					  <&etm5_out>;
> +				};
> +			};
> +
> +			port@6 {
> +				reg = <6>;
> +				apss_funnel_in6: endpoint {
> +					remote-endpoint =
> +					  <&etm6_out>;
> +				};
> +			};
> +
> +			port@7 {
> +				reg = <7>;
> +				apss_funnel_in7: endpoint {
> +					remote-endpoint =
> +					  <&etm7_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@7810000 {
> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +		reg = <0 0x07810000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				apss_merge_funnel_out: endpoint {
> +					remote-endpoint =
> +					  <&funnel2_in5>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			port {
> +				apss_merge_funnel_in: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_out>;
> +				};
> +			};
> +		};
> +	};
>   };
>   
>   &apps_rsc {
> 

