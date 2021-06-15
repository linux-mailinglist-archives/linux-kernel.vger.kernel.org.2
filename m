Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232E43A73DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhFOC1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:27:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29611 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhFOC1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:27:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623723899; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=7AVFaHjxCJ/6AvhCZOucjSTW7hCiM13UsTsxjJ8QvtU=; b=qIchDMU5MQm82N+7N1P1h9HDurHRmy7DIXlBHCRqqEwQOkmg2wRQ5TrkpJ+7qJd9/kxUqwBj
 chxC8gjWlFxSlnh1GXE6Q7yKNGzJf1bmQfvHEp2Y7jp43SLPG0f2C4hUWHoSxy3ELYCPzCqa
 oE7I9E7wFbqddaZAhTiE1UXt0n0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60c80bc0ed59bf69cce4debb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 02:09:04
 GMT
Sender: sidgup=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 72666C433D3; Tue, 15 Jun 2021 02:09:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from sidgup-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6C7F4C433F1;
        Tue, 15 Jun 2021 02:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6C7F4C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sidgup@codeaurora.org
From:   Siddharth Gupta <sidgup@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, agross@kernel.org
Cc:     Siddharth Gupta <sidgup@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, psodagud@codeaurora.org
Subject: [PATCH 0/2] remoteproc: qcom: Minidump improvements
Date:   Mon, 14 Jun 2021 19:08:48 -0700
Message-Id: <1623722930-29354-1-git-send-email-sidgup@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a fallback mechanism to the minidump flow for
remoteprocs which do not support minidump in its firmware.

Patch 1: Export the base coredump APIs to allow for fallback mechanism.
Patch 2: Fallback to full coredumps when SMEM is not initialized at all.

Siddharth Gupta (2):
  remoteproc: core: Export the rproc coredump APIs
  remoteproc: qcom: Add full coredump fallback mechanism

 drivers/remoteproc/qcom_common.c         | 9 +++++++--
 drivers/remoteproc/qcom_q6v5_pas.c       | 1 +
 drivers/remoteproc/remoteproc_coredump.c | 2 ++
 drivers/remoteproc/remoteproc_internal.h | 4 ----
 include/linux/remoteproc.h               | 4 ++++
 5 files changed, 14 insertions(+), 6 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

