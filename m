Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC21D435C02
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhJUHnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:43:01 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:27347 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbhJUHm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1634802013; x=1666338013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9v4Qg1ARrtLQXojSgbU9s11IkaQWrSHzHUrMZaSRTSs=;
  b=ofQkHhT8GsVBRzYWZdkDc1kyEhVvIAjDylSfMsSv71Tn0hSmPrX9e5vG
   oPvQPd5TigrodRtkNeCeWfvaMJ42rpubvUQC0Xi2QuGh/QB0kysd0ru1G
   yW0pHB2tWBKWYRyPX30bJnSM1DcwoWsSWzNUCcG+N3h9wBVZ9RV9aVNDf
   w=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Oct 2021 00:40:13 -0700
X-QCInternal: smtphost
Received: from nalasex01c.na.qualcomm.com ([10.47.97.35])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 00:40:13 -0700
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 21 Oct 2021 00:40:09 -0700
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Tao Zhang <quic_taozha@quicinc.com>,
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
Subject: [PATCH 10/10] ARM: dts: msm: Add TPDA and TPDM support to DTS for RB5
Date:   Thu, 21 Oct 2021 15:38:56 +0800
Message-ID: <1634801936-15080-11-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TPDA and TPDM support to DTS for RB5 board. This change is a
sample for validating. After applying this patch, the new TPDM and
TPDA nodes can be observed at the coresight devices path. TPDM and
TPDA hardware can be operated by commands.

List the commands for validating this series patches as below.
echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
cat /dev/tmc_etf0 > /data/etf-tpdm0.bin
echo 0 > /sys/bus/coresight/devices/tpdm0/enable_source
echo 0 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
echo 1 > /sys/bus/coresight/devices/tpdm1/enable_source
echo 1 > /sys/bus/coresight/devices/tpdm1/integration_test
echo 2 > /sys/bus/coresight/devices/tpdm1/integration_test
cat /dev/tmc_etf0 > /data/etf-tpdm1.bin
echo 0 > /sys/bus/coresight/devices/tpdm1/enable_source
echo 0 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
echo 1 > /sys/bus/coresight/devices/tpdm2/enable_source
echo 1 > /sys/bus/coresight/devices/tpdm2/integration_test
echo 2 > /sys/bus/coresight/devices/tpdm2/integration_test
cat /dev/tmc_etf0 > /data/etf-tpdm2.bin
echo 0 > /sys/bus/coresight/devices/tpdm2/enable_source
echo 0 > /sys/bus/coresight/devices/tmc_etf0/enable_sink

If the data from TPDMs can be obtained from the ETF, it means
that the TPDMs verification is successful. At the same time,
since TPDM0, TPDM1 and TPDM2 are all connected to the same
funnel "funnel@6c2d000" and output via different output ports,
it also means that the following patches verification is
successful.
coresight: add support to enable more coresight paths
coresight: funnel: add support for multiple output ports

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 439 +++++++++++++++++++++++
 1 file changed, 439 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 8ac96f8e79d4..bcec8b181e11 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -222,6 +222,445 @@
 		regulator-max-microvolt = <1800000>;
 		regulator-always-on;
 	};
+
+	stm@6002000 {
+		compatible = "arm,coresight-stm", "arm,primecell";
+		reg = <0 0x06002000 0 0x1000>,
+		      <0 0x16280000 0 0x180000>;
+		reg-names = "stm-base", "stm-stimulus-base";
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				stm_out: endpoint {
+					remote-endpoint =
+					  <&funnel0_in7>;
+				};
+			};
+		};
+	};
+
+	funnel@6041000 {
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+		reg = <0 0x06041000 0 0x1000>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				funnel0_out: endpoint {
+					remote-endpoint =
+					  <&merge_funnel_in0>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@7 {
+				reg = <7>;
+				funnel0_in7: endpoint {
+					remote-endpoint = <&stm_out>;
+				};
+			};
+		};
+	};
+
+	funnel@6042000 {
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+		reg = <0 0x06042000 0 0x1000>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				funnel2_out: endpoint {
+					remote-endpoint =
+					  <&merge_funnel_in2>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@4 {
+				reg = <4>;
+				funnel2_in5: endpoint {
+					remote-endpoint =
+					  <&apss_merge_funnel_out>;
+				};
+			};
+		};
+	};
+
+	funnel@6b04000 {
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+		arm,primecell-periphid = <0x000bb908>;
+
+		reg = <0 0x6b04000 0 0x1000>;
+		reg-names = "funnel-base";
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				merge_funnel_out: endpoint {
+					remote-endpoint =
+						<&etf_in>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@7 {
+				reg = <7>;
+				swao_funnel_in7: endpoint {
+					slave-mode;
+					remote-endpoint=
+						<&merg_funnel_out>;
+				};
+			};
+		};
+
+	};
+
+	funnel@6045000 {
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+		reg = <0 0x06045000 0 0x1000>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				merg_funnel_out: endpoint {
+					remote-endpoint = <&swao_funnel_in7>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				merge_funnel_in0: endpoint {
+					remote-endpoint =
+					  <&funnel0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				merge_funnel_in2: endpoint {
+					remote-endpoint =
+					  <&funnel2_out>;
+				};
+			};
+		};
+	};
+
+	etf@6b05000 {
+		compatible = "arm,coresight-tmc", "arm,primecell";
+		reg = <0 0x06b05000 0 0x1000>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		in-ports {
+			port {
+				etf_in: endpoint {
+					remote-endpoint =
+					  <&merge_funnel_out>;
+				};
+			};
+		};
+	};
+
+	etm@7040000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x07040000 0 0x1000>;
+
+		cpu = <&CPU0>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+		arm,coresight-loses-context-with-cpu;
+
+		out-ports {
+			port {
+				etm0_out: endpoint {
+					remote-endpoint =
+					  <&apss_funnel_in0>;
+				};
+			};
+		};
+	};
+
+	etm@7140000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x07140000 0 0x1000>;
+
+		cpu = <&CPU1>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+		arm,coresight-loses-context-with-cpu;
+
+		out-ports {
+			port {
+				etm1_out: endpoint {
+					remote-endpoint =
+					  <&apss_funnel_in1>;
+				};
+			};
+		};
+	};
+
+	etm@7240000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x07240000 0 0x1000>;
+
+		cpu = <&CPU2>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+		arm,coresight-loses-context-with-cpu;
+
+		out-ports {
+			port {
+				etm2_out: endpoint {
+					remote-endpoint =
+					  <&apss_funnel_in2>;
+				};
+			};
+		};
+	};
+
+	etm@7340000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x07340000 0 0x1000>;
+
+		cpu = <&CPU3>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+		arm,coresight-loses-context-with-cpu;
+
+		out-ports {
+			port {
+				etm3_out: endpoint {
+					remote-endpoint =
+					  <&apss_funnel_in3>;
+				};
+			};
+		};
+	};
+
+	etm@7440000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x07440000 0 0x1000>;
+
+		cpu = <&CPU4>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+		arm,coresight-loses-context-with-cpu;
+
+		out-ports {
+			port {
+				etm4_out: endpoint {
+					remote-endpoint =
+					  <&apss_funnel_in4>;
+				};
+			};
+		};
+	};
+
+	etm@7540000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x07540000 0 0x1000>;
+
+		cpu = <&CPU5>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+		arm,coresight-loses-context-with-cpu;
+
+		out-ports {
+			port {
+				etm5_out: endpoint {
+					remote-endpoint =
+					  <&apss_funnel_in5>;
+				};
+			};
+		};
+	};
+
+	etm@7640000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x07640000 0 0x1000>;
+
+		cpu = <&CPU6>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+		arm,coresight-loses-context-with-cpu;
+
+		out-ports {
+			port {
+				etm6_out: endpoint {
+					remote-endpoint =
+					  <&apss_funnel_in6>;
+				};
+			};
+		};
+	};
+
+	etm@7740000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x07740000 0 0x1000>;
+
+		cpu = <&CPU7>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+		arm,coresight-loses-context-with-cpu;
+
+		out-ports {
+			port {
+				etm7_out: endpoint {
+					remote-endpoint =
+					  <&apss_funnel_in7>;
+				};
+			};
+		};
+	};
+
+	funnel@7800000 {
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+		reg = <0 0x07800000 0 0x1000>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				apss_funnel_out: endpoint {
+					remote-endpoint =
+					  <&apss_merge_funnel_in>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				apss_funnel_in0: endpoint {
+					remote-endpoint =
+					  <&etm0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				apss_funnel_in1: endpoint {
+					remote-endpoint =
+					  <&etm1_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+				apss_funnel_in2: endpoint {
+					remote-endpoint =
+					  <&etm2_out>;
+				};
+			};
+
+			port@3 {
+				reg = <3>;
+				apss_funnel_in3: endpoint {
+					remote-endpoint =
+					  <&etm3_out>;
+				};
+			};
+
+			port@4 {
+				reg = <4>;
+				apss_funnel_in4: endpoint {
+					remote-endpoint =
+					  <&etm4_out>;
+				};
+			};
+
+			port@5 {
+				reg = <5>;
+				apss_funnel_in5: endpoint {
+					remote-endpoint =
+					  <&etm5_out>;
+				};
+			};
+
+			port@6 {
+				reg = <6>;
+				apss_funnel_in6: endpoint {
+					remote-endpoint =
+					  <&etm6_out>;
+				};
+			};
+
+			port@7 {
+				reg = <7>;
+				apss_funnel_in7: endpoint {
+					remote-endpoint =
+					  <&etm7_out>;
+				};
+			};
+		};
+	};
+
+	funnel@7810000 {
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+		reg = <0 0x07810000 0 0x1000>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				apss_merge_funnel_out: endpoint {
+					remote-endpoint =
+					  <&funnel2_in5>;
+				};
+			};
+		};
+
+		in-ports {
+			port {
+				apss_merge_funnel_in: endpoint {
+					remote-endpoint =
+					  <&apss_funnel_out>;
+				};
+			};
+		};
+	};
 };
 
 &adsp {
-- 
2.17.1

