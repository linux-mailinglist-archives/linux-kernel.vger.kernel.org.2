Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC428443E37
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhKCIRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:17:11 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:48706 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230352AbhKCIRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635927273; x=1667463273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ox2Rw8EKFEDNw5s+iCfrTBJMmfVW7w7YGZI8QrkQzrQ=;
  b=ihdTjEz8t1SBYnETwfqqHoOIr4eVQUgjX9nR8UZQgMrYrUxw57qucKA5
   6QufCwW/a51UZSbJbh1xCPl6nORGjRDk2LdIQz12Ike/XeEX/jP36W9Z6
   mkcKaEwI73nDdPALT8ZuHAtqTbec6JMVyTB3yGeksGSHe4D5b5n/83d0F
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Nov 2021 01:14:33 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 01:14:33 -0700
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 3 Nov 2021 01:14:32 -0700
Received: from taozha-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 3 Nov 2021 01:14:28 -0700
Date:   Wed, 3 Nov 2021 16:14:25 +0800
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Subject: Re: [PATCH 10/10] ARM: dts: msm: Add TPDA and TPDM support to DTS
 for RB5
Message-ID: <20211103081424.GA19916@taozha-gv.ap.qualcomm.com>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
 <1634801936-15080-11-git-send-email-quic_taozha@quicinc.com>
 <20211102180239.GB325436@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211102180239.GB325436@p14s>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 12:02:39PM -0600, Mathieu Poirier wrote:
> On Thu, Oct 21, 2021 at 03:38:56PM +0800, Tao Zhang wrote:
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
> > If the data from TPDMs can be obtained from the ETF, it means
> > that the TPDMs verification is successful. At the same time,
> > since TPDM0, TPDM1 and TPDM2 are all connected to the same
> > funnel "funnel@6c2d000" and output via different output ports,
> 
> Where is "funnel@6c2d000" in this patch?
>
Hi Mathieu,

Sorry, the TPDM/TPDA related code in the device tree was omitted in this submission.
We will add them to device tree in the next version.
Paste this funnel configuration below for you review first. 
funnel@6c2d000 {
    compatible = "arm,coresight-dynamic-funnel", "arm,primecell";

    reg = <0 0x6c2d000 0 0x1000>;
    reg-names = "funnel-base";

    clocks = <&aoss_qmp>;
    clock-names = "apb_pclk";

    out-ports {
        #address-cells = <1>;
        #size-cells = <0>;
        port@2 {
            reg = <2>;
            tpdm_mm_out_tpda9: endpoint {
                remote-endpoint =
                    <&tpda_9_in_tpdm_mm>;
                label = <&tpdm_mm>;
            };
        };

        port@3 {
            reg = <3>;
            funnel_dl_center_out_tpda_10: endpoint {
                remote-endpoint =
                    <&tpda_10_in_funnel_dl_center>;
                label = <&tpdm_lpass>;
            };
        };

        port@7 {
            reg = <7>;
            tpdm_turing_out_tpda14: endpoint {
                remote-endpoint =
                    <&tpda_14_in_tpdm_turing>;
                label = <&tpdm_turing>;
            };
        };
    };

    in-ports {
        #address-cells = <1>;
        #size-cells = <0>;

        port@15 {
            reg = <2>;
            funnel_dl_center_in_funnel_dl_mm: endpoint {
                slave-mode;
                remote-endpoint =
                <&funnel_dl_mm_out_funnel_dl_center>;
            };
        };

        port@16 {
            reg = <3>;
            funnel_dl_center_in_funnel_lpass: endpoint {
                slave-mode;
                remote-endpoint =
                <&funnel_lpass_out_funnel_dl_center>;
            };
        };

        port@18 {
            reg = <5>;
            funnel_dl_center_in_funnel_compute: endpoint {
                slave-mode;
                remote-endpoint =
                <&funnel_compute_out_funnel_dl_center>;
            };
        };
    };
};
> > it also means that the following patches verification is
> > successful.
> > coresight: add support to enable more coresight paths
> > coresight: funnel: add support for multiple output ports
> > 
> > Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 439 +++++++++++++++++++++++
> >  1 file changed, 439 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > index 8ac96f8e79d4..bcec8b181e11 100644
> > --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > @@ -222,6 +222,445 @@
> >  		regulator-max-microvolt = <1800000>;
> >  		regulator-always-on;
> >  	};
> > +
> > +	stm@6002000 {
> > +		compatible = "arm,coresight-stm", "arm,primecell";
> > +		reg = <0 0x06002000 0 0x1000>,
> > +		      <0 0x16280000 0 0x180000>;
> > +		reg-names = "stm-base", "stm-stimulus-base";
> > +
> > +		clocks = <&aoss_qmp>;
> > +		clock-names = "apb_pclk";
> > +
> > +		out-ports {
> > +			port {
> > +				stm_out: endpoint {
> > +					remote-endpoint =
> > +					  <&funnel0_in7>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	funnel@6041000 {
> > +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> > +		reg = <0 0x06041000 0 0x1000>;
> > +
> > +		clocks = <&aoss_qmp>;
> > +		clock-names = "apb_pclk";
> > +
> > +		out-ports {
> > +			port {
> > +				funnel0_out: endpoint {
> > +					remote-endpoint =
> > +					  <&merge_funnel_in0>;
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
> > +				funnel0_in7: endpoint {
> > +					remote-endpoint = <&stm_out>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	funnel@6042000 {
> > +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> > +		reg = <0 0x06042000 0 0x1000>;
> > +
> > +		clocks = <&aoss_qmp>;
> > +		clock-names = "apb_pclk";
> > +
> > +		out-ports {
> > +			port {
> > +				funnel2_out: endpoint {
> > +					remote-endpoint =
> > +					  <&merge_funnel_in2>;
> > +				};
> > +			};
> > +		};
> > +
> > +		in-ports {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			port@4 {
> > +				reg = <4>;
> > +				funnel2_in5: endpoint {
> > +					remote-endpoint =
> > +					  <&apss_merge_funnel_out>;
> > +				};
> > +			};
> > +		};
> > +	};
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
> > +					slave-mode;
> > +					remote-endpoint=
> > +						<&merg_funnel_out>;
> > +				};
> > +			};
> > +		};
> > +
> > +	};
> > +
> > +	funnel@6045000 {
> > +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> > +		reg = <0 0x06045000 0 0x1000>;
> > +
> > +		clocks = <&aoss_qmp>;
> > +		clock-names = "apb_pclk";
> > +
> > +		out-ports {
> > +			port {
> > +				merg_funnel_out: endpoint {
> > +					remote-endpoint = <&swao_funnel_in7>;
> > +				};
> > +			};
> > +		};
> > +
> > +		in-ports {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			port@0 {
> > +				reg = <0>;
> > +				merge_funnel_in0: endpoint {
> > +					remote-endpoint =
> > +					  <&funnel0_out>;
> > +				};
> > +			};
> > +
> > +			port@1 {
> > +				reg = <1>;
> > +				merge_funnel_in2: endpoint {
> > +					remote-endpoint =
> > +					  <&funnel2_out>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	etf@6b05000 {
> > +		compatible = "arm,coresight-tmc", "arm,primecell";
> > +		reg = <0 0x06b05000 0 0x1000>;
> > +
> > +		clocks = <&aoss_qmp>;
> > +		clock-names = "apb_pclk";
> > +
> > +		in-ports {
> > +			port {
> > +				etf_in: endpoint {
> > +					remote-endpoint =
> > +					  <&merge_funnel_out>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	etm@7040000 {
> > +		compatible = "arm,coresight-etm4x", "arm,primecell";
> > +		reg = <0 0x07040000 0 0x1000>;
> > +
> > +		cpu = <&CPU0>;
> > +
> > +		clocks = <&aoss_qmp>;
> > +		clock-names = "apb_pclk";
> > +		arm,coresight-loses-context-with-cpu;
> > +
> > +		out-ports {
> > +			port {
> > +				etm0_out: endpoint {
> > +					remote-endpoint =
> > +					  <&apss_funnel_in0>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	etm@7140000 {
> > +		compatible = "arm,coresight-etm4x", "arm,primecell";
> > +		reg = <0 0x07140000 0 0x1000>;
> > +
> > +		cpu = <&CPU1>;
> > +
> > +		clocks = <&aoss_qmp>;
> > +		clock-names = "apb_pclk";
> > +		arm,coresight-loses-context-with-cpu;
> > +
> > +		out-ports {
> > +			port {
> > +				etm1_out: endpoint {
> > +					remote-endpoint =
> > +					  <&apss_funnel_in1>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	etm@7240000 {
> > +		compatible = "arm,coresight-etm4x", "arm,primecell";
> > +		reg = <0 0x07240000 0 0x1000>;
> > +
> > +		cpu = <&CPU2>;
> > +
> > +		clocks = <&aoss_qmp>;
> > +		clock-names = "apb_pclk";
> > +		arm,coresight-loses-context-with-cpu;
> > +
> > +		out-ports {
> > +			port {
> > +				etm2_out: endpoint {
> > +					remote-endpoint =
> > +					  <&apss_funnel_in2>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	etm@7340000 {
> > +		compatible = "arm,coresight-etm4x", "arm,primecell";
> > +		reg = <0 0x07340000 0 0x1000>;
> > +
> > +		cpu = <&CPU3>;
> > +
> > +		clocks = <&aoss_qmp>;
> > +		clock-names = "apb_pclk";
> > +		arm,coresight-loses-context-with-cpu;
> > +
> > +		out-ports {
> > +			port {
> > +				etm3_out: endpoint {
> > +					remote-endpoint =
> > +					  <&apss_funnel_in3>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	etm@7440000 {
> > +		compatible = "arm,coresight-etm4x", "arm,primecell";
> > +		reg = <0 0x07440000 0 0x1000>;
> > +
> > +		cpu = <&CPU4>;
> > +
> > +		clocks = <&aoss_qmp>;
> > +		clock-names = "apb_pclk";
> > +		arm,coresight-loses-context-with-cpu;
> > +
> > +		out-ports {
> > +			port {
> > +				etm4_out: endpoint {
> > +					remote-endpoint =
> > +					  <&apss_funnel_in4>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	etm@7540000 {
> > +		compatible = "arm,coresight-etm4x", "arm,primecell";
> > +		reg = <0 0x07540000 0 0x1000>;
> > +
> > +		cpu = <&CPU5>;
> > +
> > +		clocks = <&aoss_qmp>;
> > +		clock-names = "apb_pclk";
> > +		arm,coresight-loses-context-with-cpu;
> > +
> > +		out-ports {
> > +			port {
> > +				etm5_out: endpoint {
> > +					remote-endpoint =
> > +					  <&apss_funnel_in5>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	etm@7640000 {
> > +		compatible = "arm,coresight-etm4x", "arm,primecell";
> > +		reg = <0 0x07640000 0 0x1000>;
> > +
> > +		cpu = <&CPU6>;
> > +
> > +		clocks = <&aoss_qmp>;
> > +		clock-names = "apb_pclk";
> > +		arm,coresight-loses-context-with-cpu;
> > +
> > +		out-ports {
> > +			port {
> > +				etm6_out: endpoint {
> > +					remote-endpoint =
> > +					  <&apss_funnel_in6>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	etm@7740000 {
> > +		compatible = "arm,coresight-etm4x", "arm,primecell";
> > +		reg = <0 0x07740000 0 0x1000>;
> > +
> > +		cpu = <&CPU7>;
> > +
> > +		clocks = <&aoss_qmp>;
> > +		clock-names = "apb_pclk";
> > +		arm,coresight-loses-context-with-cpu;
> > +
> > +		out-ports {
> > +			port {
> > +				etm7_out: endpoint {
> > +					remote-endpoint =
> > +					  <&apss_funnel_in7>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	funnel@7800000 {
> > +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> > +		reg = <0 0x07800000 0 0x1000>;
> > +
> > +		clocks = <&aoss_qmp>;
> > +		clock-names = "apb_pclk";
> > +
> > +		out-ports {
> > +			port {
> > +				apss_funnel_out: endpoint {
> > +					remote-endpoint =
> > +					  <&apss_merge_funnel_in>;
> > +				};
> > +			};
> > +		};
> > +
> > +		in-ports {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			port@0 {
> > +				reg = <0>;
> > +				apss_funnel_in0: endpoint {
> > +					remote-endpoint =
> > +					  <&etm0_out>;
> > +				};
> > +			};
> > +
> > +			port@1 {
> > +				reg = <1>;
> > +				apss_funnel_in1: endpoint {
> > +					remote-endpoint =
> > +					  <&etm1_out>;
> > +				};
> > +			};
> > +
> > +			port@2 {
> > +				reg = <2>;
> > +				apss_funnel_in2: endpoint {
> > +					remote-endpoint =
> > +					  <&etm2_out>;
> > +				};
> > +			};
> > +
> > +			port@3 {
> > +				reg = <3>;
> > +				apss_funnel_in3: endpoint {
> > +					remote-endpoint =
> > +					  <&etm3_out>;
> > +				};
> > +			};
> > +
> > +			port@4 {
> > +				reg = <4>;
> > +				apss_funnel_in4: endpoint {
> > +					remote-endpoint =
> > +					  <&etm4_out>;
> > +				};
> > +			};
> > +
> > +			port@5 {
> > +				reg = <5>;
> > +				apss_funnel_in5: endpoint {
> > +					remote-endpoint =
> > +					  <&etm5_out>;
> > +				};
> > +			};
> > +
> > +			port@6 {
> > +				reg = <6>;
> > +				apss_funnel_in6: endpoint {
> > +					remote-endpoint =
> > +					  <&etm6_out>;
> > +				};
> > +			};
> > +
> > +			port@7 {
> > +				reg = <7>;
> > +				apss_funnel_in7: endpoint {
> > +					remote-endpoint =
> > +					  <&etm7_out>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	funnel@7810000 {
> > +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> > +		reg = <0 0x07810000 0 0x1000>;
> > +
> > +		clocks = <&aoss_qmp>;
> > +		clock-names = "apb_pclk";
> > +
> > +		out-ports {
> > +			port {
> > +				apss_merge_funnel_out: endpoint {
> > +					remote-endpoint =
> > +					  <&funnel2_in5>;
> > +				};
> > +			};
> > +		};
> > +
> > +		in-ports {
> > +			port {
> > +				apss_merge_funnel_in: endpoint {
> > +					remote-endpoint =
> > +					  <&apss_funnel_out>;
> > +				};
> > +			};
> > +		};
> > +	};
> 
> Which of the above introduces TPDM and TPDA devices?
> 
> More comments to come tomorrow.
> 
> Thanks,
> Mathieu
> 
> >  };
Hi Mathieu,

We will add TPDM/TPDA related code to the device tree in the next verison.

Best,
Tao
> >  
> >  &adsp {
> > -- 
> > 2.17.1
> > 
