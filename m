Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9514254A3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbhJGNvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:51:14 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:14389 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241783AbhJGNvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:51:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633614554; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=LJlIsAmhsWWtNJvtDA2z8gf+SVO6RTgCLs6jKSGxJaU=; b=GrfDjRf3Ch8TvBR8uqXWGo9AVk6IJNstDQXwJcoiZMhhOm4NBghCIcVBB4t68XbEjhx8uCpp
 S2ynlKPkOC6GxRoKQOCjnPZkzGyRa9iFCXEnmuHI9nNf5K04afzWBbgjTTIjNv9JqRRdxktX
 wyyOeSR4vUQKCPmVzVR9uE2xi60=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 615efacbff0285fb0ab7bf5e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 07 Oct 2021 13:48:59
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D52C2C4361C; Thu,  7 Oct 2021 13:48:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C796FC4338F;
        Thu,  7 Oct 2021 13:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C796FC4338F
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
Subject: [PATCH 0/3] Add pin control support for lpass sc7280
Date:   Thu,  7 Oct 2021 19:18:36 +0530
Message-Id: <1633614519-26680-1-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to make lpass variant independent pin control
functions common and to add lpass sc7280 pincontrol support.
It also includes dt-bindings for lpass sc7280 lpi compatible. 

Srinivasa Rao Mandadapu (3):
  pinctrl: qcom: Update lpass variant independent functions as generic
  dt-bindings: pinctrl: qcom: Add sc7280 lpass lpi pinctrl compatible
  pinctrl: qcom: Add SC7280 lpass pin configuration

 .../bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml   |  4 +-
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           | 57 +++++++++++++++++++---
 2 files changed, 52 insertions(+), 9 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

