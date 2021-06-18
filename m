Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18FA3AC9E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 13:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbhFRLby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 07:31:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51346 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233159AbhFRLbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 07:31:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624015782; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=71O0EH5WcchJDFoozRa29bOwZCDQa5INUojIx8UHm7E=; b=UYQeVfHqeNzyh61Y9t0QZm9w0alPozI4CFa2mkqqDS7yVQpAe0LgpXhhr+7A4KnVGD596ke0
 Q1Q2GE7Tr+n7+ixD0aNa6p7tovjgMa2/FcCeFYmkhdtEfuM3LmWjdBgQTCxLM3bhgGs/G+XB
 znfTMS7qiT+y7blMxY3D0pPDsqU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60cc8387f726fa418836441d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Jun 2021 11:29:11
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E3806C4360C; Fri, 18 Jun 2021 11:29:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from okukatla1-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE0C9C433F1;
        Fri, 18 Jun 2021 11:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE0C9C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=okukatla@codeaurora.org
From:   Odelu Kukatla <okukatla@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com
Cc:     sboyd@kernel.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>
Subject: [V4 0/3] Add L3 provider support for SC7280
Date:   Fri, 18 Jun 2021 16:58:51 +0530
Message-Id: <1624015734-16778-1-git-send-email-okukatla@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Epoch Subsystem (EPSS) L3 provider support on SM7280 SoCs.

v4:
 - Addressed review comments (Rob Herring)
 
Depends on: https://lore.kernel.org/patchwork/cover/1418814/
 
Odelu Kukatla (3):
  dt-bindings: interconnect: Add EPSS L3 DT binding on SC7280
  interconnect: qcom: Add EPSS L3 support on SC7280
  arm64: dts: qcom: sc7280: Add EPSS L3 interconnect provider

 .../bindings/interconnect/qcom,osm-l3.yaml         |   9 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   9 ++
 drivers/interconnect/qcom/osm-l3.c                 | 135 ++++++++++++++++-----
 drivers/interconnect/qcom/sc7280.h                 |  10 ++
 include/dt-bindings/interconnect/qcom,osm-l3.h     |  10 +-
 5 files changed, 142 insertions(+), 31 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

