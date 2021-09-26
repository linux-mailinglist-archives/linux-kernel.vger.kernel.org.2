Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25EC418820
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 12:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhIZKh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 06:37:56 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:54518 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhIZKhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 06:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1632652578; x=1664188578;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=xjIlH6huUBUtPHOqwVDeMhWoi9SPzuIyzYgqU2usCVw=;
  b=ZR9azYZcnkxa1FZTR77g4gvZEkuKzkic/iZV+IqBzAPXJl7tvt74anyF
   52hKsengHn58YAitx3tk13MSx1HOOlOOlSWOMWE7VGD4YGJjfZQMfouI0
   8w71GzwvIgJ8EvQ2+0m8U4gTmc6wbpIEDyqxBu+U1m01wQjWZg+nRV4K9
   U=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 Sep 2021 03:36:18 -0700
X-QCInternal: smtphost
Received: from nalasex01c.na.qualcomm.com ([10.47.97.35])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 03:36:17 -0700
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Sun, 26 Sep 2021 03:36:13 -0700
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
Subject: [PATCH] coresight: etm4x: avoid build failure with unrolled loops
Date:   Sun, 26 Sep 2021 18:35:50 +0800
Message-ID: <1632652550-26048-1-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang-12 fails to build the etm4x driver with -fsanitize=array-bounds,
where it decides to unroll certain loops in a way that result in a
C variable getting put into an inline assembly.

Search this build failure and find this is a known issue and there
has been a mail thread discussing it.
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210429145752.3218324-1-arnd@kernel.org/
According to the modification suggestions of this mail thread,
coresight infrastucture has already provided another API that
can replace the function that caused the error.

Used here "csdev_access_read32" to replace the original API
"etm4x_relaxed_read32".

This patch applies to coresight/next
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index f58afbab6e6d..0bca8e2be070 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -797,7 +797,7 @@ static void etm4_disable_hw(void *info)
 	/* read back the current counter values */
 	for (i = 0; i < drvdata->nr_cntr; i++) {
 		config->cntr_val[i] =
-			etm4x_relaxed_read32(csa, TRCCNTVRn(i));
+			csdev_access_read32(csa, TRCCNTVRn(i));
 	}
 
 	coresight_disclaim_device_unlocked(csdev);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

