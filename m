Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2CC435BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhJUHly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:41:54 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:3753 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUHlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1634801977; x=1666337977;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RUc7e+MvXtnwyAuEbv459EKnJ6/1ZeaOqslZdxNvcUg=;
  b=akCAtMT0AIYbmpuNkpsbgZyKtkIU+Ao53/5Xa4UodadhNXryVuN16hHq
   DgnboZYNwEK2aaVu4f2VfnAB1rvxGAgbQDqX6VrirOe1sPgW4+88JAKMU
   N3Dmi8mEbwq2c/OvknADaT8cUBWO0PoVWqvaetXzE25hp0t4mlBtkX3Ln
   s=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Oct 2021 00:39:36 -0700
X-QCInternal: smtphost
Received: from nalasex01c.na.qualcomm.com ([10.47.97.35])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 00:39:35 -0700
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 21 Oct 2021 00:39:31 -0700
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
Subject: [PATCH 00/10] Add support for TPDM and TPDA
Date:   Thu, 21 Oct 2021 15:38:46 +0800
Message-ID: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the trace performance monitoring and
diagnostics hardware (TPDM and TPDA). It is composed of two major
elements.
a) Changes for original coresight framework to support for TPDM and TPDA.
b) Add driver code for TPDM and TPDA.

Introduction of changes for original coresight framework
a) Support TPDM as new coresight source.
Since only STM and ETM are supported as coresight source originally.
TPDM is a newly added coresight source. We need to change
the original way of saving coresight path to support more types source
for coresight driver.
The following patch is to add support more coresight sources.
coresight: add support to enable more coresight paths

b) To support multi-port input and multi-port output for funnels
In some cases, different TPDM hardware will be connected to the same
funnel, but eventually they need to be linked to different TPDAs or
funnels. This requires funnel to support multi-port input and multi-port
output, and can specify which input port corresponds to which output port.
Use property “label” in the funnel’s configuration to point out from
which input port to which output port.
The following patch is to support multi-port input and multi-port output
for funnels.
coresight: funnel: add support for multiple output ports

Introduction of TPDM and TPDA
TPDM - The trace performance monitoring and diagnostics monitor or TPDM in
short serves as data collection component for various dataset types
specified in the QPMDA(Qualcomm performance monitoring and diagnostics
architecture) spec. The primary use case of the TPDM is to collect data
from different data sources and send it to a TPDA for packetization,
timestamping and funneling.
The following patch is to add driver for TPDM.
Coresight: Add driver to support Coresight device TPDM
Coresight: Enable BC and GPR for TPDM driver
Coresight: Add interface for TPDM BC subunit
Coresight: Enable and add interface for TPDM TC subunit
Coresight: Enable DSB subunit for TPDM
Coresight: Enable CMB subunit for TPDM

TPDA - The trace performance monitoring and diagnostics aggregator or
TPDA in short serves as an arbitration and packetization engine for the
performance monitoring and diagnostics network as specified in the QPMDA
(Qualcomm performance monitoring and diagnostics architecture)
specification. The primary use case of the TPDA is to provide
packetization, funneling and timestamping of Monitor data as specified
in the QPMDA specification.
The following patch is to add driver for TPDA.
coresight: Add driver to support Coresight device TPDA

The last patch of this series is a device tree modification, which add
the TPDM and TPDA configuration to device tree for validating.
ARM: dts: msm: Add TPDA and TPDM configuration to device

Once this series patches are applied properly, the tpdm and tpda nodes
should be observed at the coresight path /sys/bus/coresight/devices
e.g.
/sys/bus/coresight/devices # ls -l | grep tpd
tpda0 -> ../../../devices/platform/soc@0/6004000.tpda/tpda0
tpdm0 -> ../../../devices/platform/soc@0/6844000.lpass.tpdm/tpdm0

We can use the commands are similar to the below to validate TPDMs.
Enable coresight sink first.
echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
The test data will be collected in the coresight sink which is enabled.

This series applies to coresight/next
https://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git?h=next

Tao Zhang (10):
  coresight: add support to enable more coresight paths
  coresight: funnel: add support for multiple output ports
  Coresight: Add driver to support Coresight device TPDM
  Coresight: Enable BC and GPR for TPDM driver
  Coresight: Add interface for TPDM BC subunit
  Coresight: Enable and add interface for TPDM TC subunit
  Coresight: Enable DSB subunit for TPDM
  Coresight: Enable CMB subunit for TPDM
  coresight: Add driver to support Coresight device TPDA
  ARM: dts: msm: Add TPDA and TPDM support to DTS for RB5

 .../bindings/arm/coresight-tpda.yaml          |  169 +
 .../bindings/arm/coresight-tpdm.yaml          |   86 +
 MAINTAINERS                                   |    6 +
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  439 ++
 drivers/hwtracing/coresight/Kconfig           |   18 +
 drivers/hwtracing/coresight/Makefile          |    2 +
 drivers/hwtracing/coresight/coresight-core.c  |  175 +-
 .../hwtracing/coresight/coresight-platform.c  |    8 +
 drivers/hwtracing/coresight/coresight-tpda.c  |  828 ++++
 drivers/hwtracing/coresight/coresight-tpdm.c  | 4253 +++++++++++++++++
 include/linux/coresight.h                     |    2 +
 11 files changed, 5928 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpda.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
 create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c

-- 
2.17.1

