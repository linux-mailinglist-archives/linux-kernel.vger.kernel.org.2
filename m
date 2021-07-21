Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FEA3D0ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhGUH5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:57:36 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:17662 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237120AbhGUHvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:51:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626856238; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=u0eB68z9USKgAkN7oUoq+Fe+a5B5dXU7To/2fji6VaA=; b=cw550//wckXbYV7HpDSkynGoUCfHPiQ94Gc4UFLd4DFqFz4/qLDfnOzH2ewj0XdM6tX3hsMN
 zmIKF/cYXmzIcB4KY6iwBxVZB7qlW9Q/1foDyeIBaHMuoQNYgTyQVpGaCSHTMBvfPp7CVCBF
 PpyG1c9yzgJ8m5VqbVMAjGZ3hEc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60f7db274815712f3a4eb9bd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 08:30:31
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 551AEC43144; Wed, 21 Jul 2021 08:30:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hyd-lnxbld210.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BBEA1C4338A;
        Wed, 21 Jul 2021 08:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BBEA1C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=srivasam@codeaurora.org
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Cc:     Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>
Subject: [PATCH v4 0/2] Qualcomm's lpass device tree changes
Date:   Wed, 21 Jul 2021 14:00:14 +0530
Message-Id: <20210721083016.12950-1-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>

These patches are device tree changes to support audio over DP.
It includes changes of HDMI reg, interrupt and iommu and 
hdmi dai link.
These patches depends on the lpass DP dts node patch:
	https://patchwork.kernel.org/project/linux-arm-msm/patch/1622758940-13485-1-git-send-email-khsieh@codeaurora.org/

Changes Since v3:
  -- Changed DP node name.
Changes Since v2:
  -- Removed obsolete hdmi-jack property.
  -- Updated sound dai cells property
Changes Since v1:
  -- hdmi dai is added in lpass-cpu node.

V Sujith Kumar Reddy (2):
  arm64: dts: qcom: sc7180: Update lpass cpu node for audio over dp
  arm64: dts: qcom: sc7180-trogdor: Add lpass dai link for HDMI

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 17 +++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi         | 16 ++++++++++------
 2 files changed, 27 insertions(+), 6 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

