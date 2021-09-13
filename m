Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2FD4084D8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbhIMGlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:41:53 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:36446 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbhIMGlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1631515237; x=1663051237;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=IAgIRzNJHlKHPkz0Dwdy1vz4XDAtqCcz4zOFFeBrqD8=;
  b=EmvaSAuaSjKaka2WCYRMyEQo6fcXkXT0rvR1KdO79ho1wBeBKE4DgWv/
   gbysUAXQkVvIsgt5jHHLvk/y9UIptGMvVUowiUiqj8Nb4a5SIbj6fJ69e
   h9mDE1HRlIduKYwjFiEtGP4eD/qUWb9sO12Qz+7KNghhCbPCAifu3HXJU
   g=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 12 Sep 2021 23:40:36 -0700
X-QCInternal: smtphost
Received: from nalasex01c.na.qualcomm.com ([10.47.97.35])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2021 23:40:36 -0700
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Sun, 12 Sep 2021 23:40:32 -0700
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
Date:   Mon, 13 Sep 2021 14:40:12 +0800
Message-ID: <1631515214-13653-1-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds Coresight support for SM8250 Soc on RB5 board.
It is composed of two elements.
a) Add ETM PID for Kryo-5XX.
b) Add coresight support to DTS for RB5.

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

