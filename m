Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B53F1624
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 11:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbhHSJ3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:29:43 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:24693 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229745AbhHSJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1629365345; x=1660901345;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=wgeBz6o5CgIvbNiys9Pw8pFmqTjwkqbhs9qM4rtqslg=;
  b=ZM6fb4rJlPdDMWjJabLv/Oh4GPzzEg9kfN3pVXVbqZOdVjoEkOYYMkb8
   VYSVZPmLSsccynxQD17qTPk0PXDA53kou4PEGSI/95m4szjmfOmgZw/0h
   8MWHuTgfGxeWbOeOJ75U6Tboc9zDqI7Hn7nE9zyVGKXGaRdc+hsmAJsjm
   k=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Aug 2021 02:29:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 02:29:05 -0700
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.15; Thu, 19 Aug 2021 02:29:04 -0700
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.858.15; Thu, 19 Aug 2021 02:29:01 -0700
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
Subject: [PATCH 0/2] Add Coresight support for RB5 board
Date:   Thu, 19 Aug 2021 17:28:42 +0800
Message-ID: <1629365324-5891-1-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03h.na.qualcomm.com (10.85.0.50) To
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

