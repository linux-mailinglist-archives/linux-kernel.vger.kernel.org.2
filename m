Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6EF375BC0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbhEFTeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:34:14 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:11886 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbhEFTeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:34:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620329591; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=6hsvNiLm6snfgYT1gETxO981lyXB3iHndDKxbMsOxfE=; b=Gwzb63SBYfcyUpy2tBHtekgeU3tK8s1fYE02fOevYu6Vy818fYzWK0n46wuBnabz88VQXrq/
 Hf1FNTgiSOb4OOJ69t2corPMVzj0VO9+cSujyBdEkdxj+L1Obd6DJWxcm9K2ib+G65pp7p5M
 ZxwM+m7OaLbfDaYsltM6ohdXMcw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60944460febcffa80f056b8c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 06 May 2021 19:32:48
 GMT
Sender: bbhatt=qti.qualcomm.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5BBF3C43148; Thu,  6 May 2021 19:32:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3785C433D3;
        Thu,  6 May 2021 19:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3785C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=pass (p=none dis=none) header.from=qti.qualcomm.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=pass smtp.mailfrom=bbhatt@qti.qualcomm.com
From:   Bhaumik Bhatt <bbhatt@qti.qualcomm.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, linux-wireless@vger.kernel.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org,
        Bhaumik Bhatt <bbhatt@qti.qualcomm.com>
Subject: [PATCH v4 0/6] BHI/BHIe improvements for MHI power purposes
Date:   Thu,  6 May 2021 12:32:19 -0700
Message-Id: <1620329545-32328-1-git-send-email-bbhatt@qti.qualcomm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series improves the power up behavior by allowing MHI host driver to
set BHI and/or BHIe offsets early on in the preparation phase and fail pre-power
up if offsets are not found or not within a limited MMIO region. This also
allows MHI host to clean up the offsets in the unprepare after power down phase.

Going forward, controllers will be required to specify a reg_len field which
will be used to check whether the BHI/BHIe offsets are in range or not.

This series has been tested on X86_64 architecture with the PCI generic driver
as controller and an SDX55 device.

v4:
-Added reviewed-by tags
-Updated range check patch to include BHI/e offsets in the error message

v3:
-Added reviewed-by tags
-Updated order of reg_len in mhi_controller structure documentation

v2:
-Added reviewed-by tags
-Moved reg_len entry in mhi_controller structure to allow for a packed struct

Bhaumik Bhatt (6):
  bus: mhi: core: Set BHI/BHIe offsets on power up preparation
  bus: mhi: core: Set BHI and BHIe pointers to NULL in clean-up
  bus: mhi: Add MMIO region length to controller structure
  ath11k: set register access length for MHI driver
  bus: mhi: pci_generic: Set register access length for MHI driver
  bus: mhi: core: Add range checks for BHI and BHIe

 drivers/bus/mhi/core/init.c           | 61 ++++++++++++++++++++++++-----------
 drivers/bus/mhi/core/pm.c             | 28 +++-------------
 drivers/bus/mhi/pci_generic.c         |  1 +
 drivers/net/wireless/ath/ath11k/mhi.c |  1 +
 include/linux/mhi.h                   |  2 ++
 5 files changed, 50 insertions(+), 43 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

