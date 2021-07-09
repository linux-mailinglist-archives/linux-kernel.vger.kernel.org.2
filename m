Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962983C2A35
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 22:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhGIURn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 16:17:43 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:38692 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGIURm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 16:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1625861699; x=1657397699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wgo+omebJYEWKZ79ff1dd/pFYzm25o7WjIkM4InncOU=;
  b=zfaGQSs2aySBeF4F4WYR38bqZOTlsnw/a3oPOhC/ZyWubTHrzK/jQS+E
   0bipohzwj98jYKD+UIkWdZqt66pdZq1vNumyhIIJDOWN6+0ru+qQqRYkw
   gXboQ1KXRqjKkbcSyxJ7sFT+ArNuZkM2sPmnpsp1qwNgtzLkAlDtKbnG4
   Q=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 09 Jul 2021 13:14:58 -0700
X-QCInternal: smtphost
Received: from nalasexr03e.na.qualcomm.com ([10.49.195.114])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Jul 2021 13:14:58 -0700
Received: from vamslank1-linux.qualcomm.com (10.80.80.8) by
 nalasexr03e.na.qualcomm.com (10.49.195.114) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Fri, 9 Jul 2021 13:14:57 -0700
From:   <quic_vamslank@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <alexandre.belloni@bootlin.com>, <viresh.kumar@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
        <mani@kernel.org>, Vamsi krishna Lanka <quic_vamslank@quicinc.com>
Subject: [PATCH 1/2] ARM: configs: qcom_defconfig: Enable SDX65 GCC driver
Date:   Fri, 9 Jul 2021 13:14:40 -0700
Message-ID: <20210709201441.21078-2-quic_vamslank@quicinc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210709201441.21078-1-quic_vamslank@quicinc.com>
References: <20210709201441.21078-1-quic_vamslank@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03e.na.qualcomm.com (10.85.0.48) To
 nalasexr03e.na.qualcomm.com (10.49.195.114)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vamsi krishna Lanka <quic_vamslank@quicinc.com>

Enable Qualcomm SDX65 GCC driver for clock support.

Signed-off-by: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 3f36887e8333..8409d240ad7b 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -227,6 +227,7 @@ CONFIG_MDM_LCC_9615=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
 CONFIG_SDX_GCC_55=y
+CONFIG_SDX_GCC_65=y
 CONFIG_MSM_IOMMU=y
 CONFIG_ARM_SMMU=y
 CONFIG_HWSPINLOCK=y
-- 
2.32.0

