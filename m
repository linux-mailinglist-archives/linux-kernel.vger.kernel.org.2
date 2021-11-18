Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C42455BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344924AbhKRMy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 07:54:27 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:34044 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344885AbhKRMwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:52:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637239763; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=/6NjAs9R9Ro7zWxt9z3NLZSF6WGCXEfxrkRVeyeZ1EE=; b=SovQcPgjNj2dmqtb5PByICNsRLzWVXkS7qQNHDK7JlRLJq4P3IKfANx5uD7kkJqVd0LZL14D
 EmBT9zwR8WGg2M6+xeWRVR8zvIJPexZQ13PxYqjhHnA9yNv45ozvn1+qwaInCHSAmKUjWGQo
 GPzUyO0dCKTkIeyf8yfEZFmAxIk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 61964bb55bbbed1f70318c4a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Nov 2021 12:48:53
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 580AFC43619; Thu, 18 Nov 2021 12:48:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA612C4338F;
        Thu, 18 Nov 2021 12:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org BA612C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: [PATCH v5 00/10] Add support for audio on SC7280 based targets
Date:   Thu, 18 Nov 2021 18:18:24 +0530
Message-Id: <1637239714-11211-1-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to add support for Audio over wcd codec,
digital mics, through digital codecs and without ADSP.
This patch set depends on:
	-- https://patchwork.kernel.org/project/alsa-devel/list/?series=570161
	-- https://patchwork.kernel.org/project/alsa-devel/list/?series=572615
	-- https://patchwork.kernel.org/project/alsa-devel/list/?series=559677

Changes Since V4:
    -- Remove unused variable in lpass-sc7280 platform driver.
Changes Since V3:
    -- Remove redundant power domain controls. As power domains can be configured from dtsi.
Changes Since V2:
    -- Split lpass sc7280 cpu driver patch and create regmap config patch.
    -- Create patches based on latest kernel tip.
    -- Add helper function to get dma control and lpaif handle.
    -- Remove unused variables.
Changes Since V1:
    -- Typo errors fix
    -- CPU driver readable/writable apis optimization.
    -- Add Missing config patch
    -- Add Common api for repeated dmactl initialization.

Srinivasa Rao Mandadapu (10):
  ASoC: qcom: Move lpass_pcm_data structure to lpass header
  ASoC: qcom: lpass: Add dma fields for codec dma lpass interface
  ASoC: qcom: Add register definition for codec rddma and wrdma
  ASoC: qcom: Add lpass CPU driver for codec dma control
  ASoC: qcom: Add helper function to get dma control and lpaif handle
  ASoC: qcom: Add support for codec dma driver
  ASoC: qcom: Add regmap config support for codec dma driver
  ASoC: dt-bindings: Add SC7280 sound card bindings
  ASoC: qcom: lpass-sc7280: Add platform driver for lpass audio
  ASoC: qcom: SC7280: Update config for building codec dma drivers

 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  |  69 ++-
 sound/soc/qcom/Kconfig                             |  13 +
 sound/soc/qcom/Makefile                            |   4 +
 sound/soc/qcom/common.c                            |  39 ++
 sound/soc/qcom/common.h                            |   1 +
 sound/soc/qcom/lpass-cdc-dma.c                     | 195 ++++++++
 sound/soc/qcom/lpass-cpu.c                         | 245 +++++++++-
 sound/soc/qcom/lpass-lpaif-reg.h                   | 103 ++++-
 sound/soc/qcom/lpass-platform.c                    | 513 ++++++++++++++++++---
 sound/soc/qcom/lpass-sc7280.c                      | 416 +++++++++++++++++
 sound/soc/qcom/lpass.h                             | 150 ++++++
 11 files changed, 1669 insertions(+), 79 deletions(-)
 create mode 100644 sound/soc/qcom/lpass-cdc-dma.c
 create mode 100644 sound/soc/qcom/lpass-sc7280.c

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

