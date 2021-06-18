Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7583AD4CC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 00:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhFRWHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 18:07:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:10734 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234833AbhFRWHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 18:07:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624053926; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=tBkgcop7LumEJk9jlag3805wCR8MkDxckjO0Jc5rOzI=; b=laP1wNlEYDJOJAzGhglChdUnyVWVntVSzhzgm53rx2cJhAZPVZuAwKm7TqT1o0di2ewo7B2f
 V0xtqat0hvtsSc/fsqn1Lg1vGdWb0sW4U5ZFj4KZ04FnEEtoUM+7Nz6E0QbTgq1e0SIhDmZo
 Ic5C53fHgr2unmWJ0ZO3C/DAQRc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60cd189de27c0cc77fa11a26 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Jun 2021 22:05:17
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1F448C4323A; Fri, 18 Jun 2021 22:05:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C940C43460;
        Fri, 18 Jun 2021 22:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C940C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v2] MHI event ring priority updates
Date:   Fri, 18 Jun 2021 15:05:02 -0700
Message-Id: <1624053903-24653-1-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Event ring priorities have remained out of use and are set to 1 by default.
This series brings about an enum entry expanding use of the priority field by
adding high priority tasklet scheduling to the menu.

In some cases, tasklet scheduling delays can be a nuisance. An example would be
ath11k adding a610f3c65d3b ("bus: mhi: Wait for M2 state during system resume")
in response to it. This issue can be potentially avoided if the controller uses
a dedicated event ring for control packets with high priority tasklet scheduling
in place.

There are no functional changes added to the controller (pci_generic or ath11k)
drivers with this series and the only changes there are use of the enum in place
of a harcoded value of "1". In the future, controllers can opt in to have any
event ring scheduled in high priority.

Tested on: X86_64 architecture with SDX65 on Ubuntu 18.04 distribution.

v2:
-Remove enum and update kernel doc for priority simplifying the implementation
-Drop patches for controller changes as they become unnecessary
-Merge adding and enabling of support patches

Hemant Kumar (1):
  bus: mhi: core: Add support for processing priority of event ring

 drivers/bus/mhi/core/init.c | 3 +--
 drivers/bus/mhi/core/main.c | 9 +++++++--
 include/linux/mhi.h         | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

