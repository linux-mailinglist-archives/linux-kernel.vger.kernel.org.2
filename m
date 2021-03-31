Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F1A34DD87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhC3B27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:28:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60386 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230482AbhC3B2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:28:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617067720; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=W0CeRTRi7xkYCGy0/MQcTApz1UF8CSVp9Uuh60jOJ9w=; b=qzvxGHokjuwoo0vLVQhZ4kVUJb5kGK8ondLwyUwN8hc1OXomqh0cxxhJcilJafFTR2wh6xQB
 rkDag+iQ/rP1Sf2kVom5Ld9mHw63eOknYjYuwwqmvWDUOq93wJCKCGpVTt3tQ8sUj7tu5xkv
 5LBsz8VwMY46k2Qt9MO/ZcaPvCU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60627ebe04a1954ec3157dba (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 30 Mar 2021 01:28:30
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10CADC43464; Tue, 30 Mar 2021 01:28:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 13A6EC43461;
        Tue, 30 Mar 2021 01:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13A6EC43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        loic.poulain@linaro.org, abickett@codeaurora.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v1 0/7] MHI Emergency download and flash programmer support
Date:   Mon, 29 Mar 2021 18:28:17 -0700
Message-Id: <1617067704-28850-1-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow handling EDL mode after SYS_ERROR occurs by reading the execution
environment post handling and move to power on reset state to accommodate the
scenario.
Handle EDL mode properly and wait for ready instead of just exiting from the
firmware load.
Allow use of the Flash Programmer execution environment as a mission mode
use case for a blank NAND power up scenario.
Always attempt a wait for MHI ready state as device could be waiting for the
host to do so after pass through execution environment is seen.
Introduce patch to improve state awareness and aid in debugging.

This patch series was tested on x86_64 architecture.

Bhaumik Bhatt (6):
  bus: mhi: core: Rely on accurate method to determine EDL mode
  bus: mhi: core: Wait for ready after an EDL firmware download
  bus: mhi: core: Handle EDL mode entry appropriately
  bus: mhi: core: Identify Flash Programmer as a mission mode use case
  bus: mhi: core: Wait for MHI READY state in most scenarios
  bus: mhi: core: Improve state strings for debug messages

Carl Yin (1):
  bus: mhi: core: Add support for Flash Programmer execution environment

 drivers/bus/mhi/core/boot.c     | 13 +++++++------
 drivers/bus/mhi/core/init.c     | 34 ++++++++++++++++++----------------
 drivers/bus/mhi/core/internal.h |  4 +++-
 drivers/bus/mhi/core/main.c     |  3 +++
 drivers/bus/mhi/core/pm.c       | 28 +++++++++++++++++++++++++---
 include/linux/mhi.h             |  4 +++-
 6 files changed, 59 insertions(+), 27 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

