Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D373DD312
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhHBJjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:39:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:63731 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232973AbhHBJjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:39:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627897162; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=uST3NOJNGheH9ALjSEre859keLTmPnCjJbd5bFRbXP4=; b=Vg/87v9v/y1FSo6vT1Rjxx4pjnCpIy0wBRG0hU+qvNsNat/TGxOLUv6IAIIWOgyVVeEXARIr
 p6qwckbHTEkVsUMZiGjpLpDM2x7PY02Su3t/A1y7u/EGPBNmL52vwGiIDDm9zDrYEqa9sdA7
 mM7hzQwjMp0JP8rk7nb+uC1cdwI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6107bd499771b05b249b8ea9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 02 Aug 2021 09:39:21
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 14020C4360C; Mon,  2 Aug 2021 09:39:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1ACCBC433D3;
        Mon,  2 Aug 2021 09:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1ACCBC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, skakit@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 0/2] Add DT files for sc7280 IDP2 board
Date:   Mon,  2 Aug 2021 15:09:03 +0530
Message-Id: <1627897145-28020-1-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IDP2 board based off sc7280 SoC is derived from the existing
IDP platform, but has some differences like
* on board Embedded controller and H1 secure microprocessor
* PMIC changes (some pmic functionality handled by EC)
* MDP/Display power grid changes
* USB configuration changes

To handle the differences, all common functionality is now moved to
sc7280-idp.dtsi, which is included in both sc7280-idp and sc7280-idp2
dts files.

Additional functionality differences in IDP2 as listed above will be
added by subsequent patches, this series just makes sure we have the
split done to handle the commonalities and differences.

Rajendra Nayak (2):
  dt-bindings: arm: qcom: Document qcom,sc7280-idp2 board
  arm64: dts: qcom: sc7280-idp: Add device tree files for IDP2

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 arch/arm64/boot/dts/qcom/sc7280-idp.dts            | 352 +--------------------
 .../dts/qcom/{sc7280-idp.dts => sc7280-idp.dtsi}   |  48 +--
 arch/arm64/boot/dts/qcom/sc7280-idp2.dts           |  24 ++
 5 files changed, 30 insertions(+), 396 deletions(-)
 copy arch/arm64/boot/dts/qcom/{sc7280-idp.dts => sc7280-idp.dtsi} (87%)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-idp2.dts

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

