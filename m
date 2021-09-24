Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334C7416FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 12:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245537AbhIXKIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 06:08:22 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:60921 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245458AbhIXKIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 06:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1632478008; x=1664014008;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=qP5VfjwaQq42BNKUbcnuVAphpsb5x+ovpSEyhK/MJH8=;
  b=lwlBL+VbpWyTIwUPheOUdMpBFYGyhXFGiMXte2lqUmxDtiMVvzh5Vm4o
   Oy568o23oJsNIqabx2BC64k+gRp8V1wN4+6Kq3Rx3RptyDrdXQonIiCpl
   DKz/pV47HAMjEtn1H5tWvlh4S3rshC7/ygrrFSEpdLVMnq9AQANqVm5gY
   o=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 24 Sep 2021 03:06:48 -0700
X-QCInternal: smtphost
Received: from nalasex01c.na.qualcomm.com ([10.47.97.35])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 03:06:47 -0700
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Fri, 24 Sep 2021 03:06:43 -0700
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
Subject: [PATCH v2 0/2] Add Coresight support for RB5 board
Date:   Fri, 24 Sep 2021 18:06:19 +0800
Message-ID: <1632477981-13632-1-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds Coresight support for SM8250 Soc on RB5 board.
It is composed of two elements.
a) Add ETM PID for Kryo-5XX.
b) Add coresight support to DTS for RB5.

Changes since V2:
- Add the comment "Cortex-A77" for Kryo-5XX ETM PID.
- Correct the errors in the patch "Add Coresight support for RB5
board" v1 version, and the adsp-related configuration should not
be deleted.

Changes since V1:
- Add ETM PID for Kryo-5XX.
- Add coresight supoort to device tree for RB5. ETM verification
and use of Coresight components need Coresight support in device
tree. Since the ETR sink needs SMMU support, and SMMU has not
been enabled on RB5. ETR is not added to this patch, and it will
be added once SMMU is enabled on RB5. ETF sink has been added to
the device tree for RB5.

This series applies to coresight/next
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Tao Zhang (2):
  coresight: etm4x: Add ETM PID for Kryo-5XX
  arm64: dts: qcom: sm8250: Add Coresight support

 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      | 442 +++++++++++++++++-
 .../coresight/coresight-etm4x-core.c          |   1 +
 2 files changed, 439 insertions(+), 4 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

