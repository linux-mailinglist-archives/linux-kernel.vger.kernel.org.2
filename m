Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3245F3F1ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhHSRR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:17:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:33554 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229981AbhHSRRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:17:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629393403; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=9OrzBDI9aonJAy5nn5cFhKWv9b0xLY+sStEgxrDvSeg=; b=NTlkBnitX2bFPsV89HNyJstCvc09Yy0k17P718fPzRhECKCJ7PWxTwDMUmMcElBKNalCqvlI
 /XayBr3UFR7+h3qQepHDE5ugxfeIyp09aP1S6vLNerP0RXipaaA9DOVkpV1k7YtcwPSFbGrN
 d+BUFqwzsmBeoTBFOFPQnqAGN94=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 611e91d466ff1079045f1840 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 19 Aug 2021 17:16:04
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A7BADC4338F; Thu, 19 Aug 2021 17:16:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C431CC4338F;
        Thu, 19 Aug 2021 17:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C431CC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        quic_jhugo@quicinc.com, Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v2 0/2] MHI MMIO register write updates
Date:   Thu, 19 Aug 2021 10:15:52 -0700
Message-Id: <1629393354-20769-1-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of MHI MMIO writes, the register field write function needs to do reads
before writes are performed. Propagate read failures such that callers are made
aware of those and can take appropriate action instead of running blind.

Optimizing the MMIO initialization function to use mhi_write_reg() in most cases
should also be done to improve design.

These patches were tested on X86_64 architecture with Ubuntu 18.04 and SDX65
attach.

v2:
-Fix testbot reported missing set of changes from pm.c

Bhaumik Bhatt (2):
  bus: mhi: core: Bail on writing register fields if read fails
  bus: mhi: core: Optimize and update MMIO register write method

 drivers/bus/mhi/core/boot.c     | 25 ++++++++++-----
 drivers/bus/mhi/core/init.c     | 70 +++++++++++++++++++++++------------------
 drivers/bus/mhi/core/internal.h |  7 +++--
 drivers/bus/mhi/core/main.c     |  9 ++++--
 drivers/bus/mhi/core/pm.c       | 18 ++++++++---
 5 files changed, 80 insertions(+), 49 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

