Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9274A3F1628
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 11:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbhHSJ36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:29:58 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:64046 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237216AbhHSJ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1629365354; x=1660901354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=zNFv1wn/ObmGv6CzAPmLPa9bvv2i64Yo0s3nkvHg45I=;
  b=pRJQ+nlvFO83alFLCJdiqCMg+teLFytaLyOPYYbptU0uL1LAEKdmWQ0C
   S2lbqU3d1qf8WIt3G2x/ruXJc+EUIQwAkW217WmVePdcfxzDh2LsHhKoz
   YwUi0wr00B1wO1ETT/Z0Pzb8Pg3s6dmso3Z/nc9wlR7YAEL0VvavjtSUO
   c=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 19 Aug 2021 02:29:13 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 02:29:11 -0700
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.15; Thu, 19 Aug 2021 02:29:11 -0700
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.858.15; Thu, 19 Aug 2021 02:29:07 -0700
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
        Yuanfang Zhang <quic_yuanfang@quicinc.com>
Subject: [PATCH 2/2] arm64: dts: qcom: sm8250: Add Coresight support
Date:   Thu, 19 Aug 2021 17:28:44 +0800
Message-ID: <1629365324-5891-3-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629365324-5891-1-git-send-email-quic_taozha@quicinc.com>
References: <1629365324-5891-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03h.na.qualcomm.com (10.85.0.50) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the basic coresight components found on Qualcomm SM8250 Soc. The
basic coresight components include ETF, ETMs,STM and the related
funnels.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 442 ++++++++++++++++++++++-
 1 file changed, 438 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 8ac96f8e79d4..9c8f87d80afc 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -222,11 +222,445 @@
 		regulator-max-microvolt = <1800000>;
 		regulator-always-on;
 	};
-};
 
-&adsp {
-	status = "okay";
-	firmware-name = "qcom/sm8250/adsp.mbn";
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
 
 &apps_rsc {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

