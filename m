Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE9443509
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 19:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhKBSFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 14:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbhKBSFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 14:05:18 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C721C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 11:02:43 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id n23so117627pgh.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 11:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YjVBlkBZ6ZfHDc6ki4fgAdDTZuACPnzk/vffaPzIa9Y=;
        b=JVQNvZlAD5EMBcU12sm/AsHMSUJGpPtlslxp7WZTAyAql/YuOStrTd9D/sIX+q1To0
         shm+yMPgfIb7wD5xnSotDrydn3X30mjCFE4FXi3V5PVnc8v/SaTO+A0Ecubs/7PHUte3
         japb9wFHgD+F5EHuB4zmy3/aMpOvcKunePzMssHEvnXSrVRbbZkFqxn9x/49OIvZUdo3
         zEPvP+g59XNrw2iSA+0iLC06vDohk4a6E/htSzFknFdbgixU+RygcmKKqq/rBDiHmt5c
         KBSgmBOH5dVfGajA3AGPPjq0yzFKvnFdDO30dLgKqelLiji7AlrdtQ/ZXgMXIkFeyku4
         o82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YjVBlkBZ6ZfHDc6ki4fgAdDTZuACPnzk/vffaPzIa9Y=;
        b=QxzgbHMCOo6wAOjQr0/Mwl75JrpsTJNX3D4H+sa+5D74hVF2eTycc6S8jPZZy4NEfD
         HJxT3aKU/FclqViJLlFSBKx8tCzlq0owvsT4pwTZHAO2ECZzU81PPN7CpugW+UykR9nf
         Qr5gnmjMgN2PmgqSyLEQtPvUN5QszJPI/RUtC0YSGE9Unnf+61WCa0qAKr1+z0FXmsp+
         4PAyHZWHD3ZDh7LE6Sb6M8r9dZKtXQJ8CX4C21rYneYmwhCbLqVHVh7ijPk2+TqjYbWk
         2cSBW1QSBzQkqmox61aleO6T5SH1USkKJrHsnzEQZVRu3aQSZl0S8dr+HpeTZrRgy+sL
         DSzw==
X-Gm-Message-State: AOAM531OJRVxf6xrR8t6dx+CSc33sgI2oZEHp2ywUll/1w/rX+dFRwU5
        b25Mg89NPpu2SVMq8V0220S/8A==
X-Google-Smtp-Source: ABdhPJwCAH0O3lbCV+Ub8bGPMVBSC3UKUQDTkxyp+aIm8PuH8fNRDFQGcW+gQORSv7SRhDSiIlC/QQ==
X-Received: by 2002:aa7:8294:0:b0:44c:c0b:d94c with SMTP id s20-20020aa78294000000b0044c0c0bd94cmr37929576pfm.24.1635876162821;
        Tue, 02 Nov 2021 11:02:42 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id m4sm3113550pjl.11.2021.11.02.11.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 11:02:41 -0700 (PDT)
Date:   Tue, 2 Nov 2021 12:02:39 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Subject: Re: [PATCH 10/10] ARM: dts: msm: Add TPDA and TPDM support to DTS
 for RB5
Message-ID: <20211102180239.GB325436@p14s>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
 <1634801936-15080-11-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634801936-15080-11-git-send-email-quic_taozha@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 03:38:56PM +0800, Tao Zhang wrote:
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
> since TPDM0, TPDM1 and TPDM2 are all connected to the same
> funnel "funnel@6c2d000" and output via different output ports,

Where is "funnel@6c2d000" in this patch?

> it also means that the following patches verification is
> successful.
> coresight: add support to enable more coresight paths
> coresight: funnel: add support for multiple output ports
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 439 +++++++++++++++++++++++
>  1 file changed, 439 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index 8ac96f8e79d4..bcec8b181e11 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -222,6 +222,445 @@
>  		regulator-max-microvolt = <1800000>;
>  		regulator-always-on;
>  	};
> +
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

Which of the above introduces TPDM and TPDA devices?

More comments to come tomorrow.

Thanks,
Mathieu

>  };
>  
>  &adsp {
> -- 
> 2.17.1
> 
