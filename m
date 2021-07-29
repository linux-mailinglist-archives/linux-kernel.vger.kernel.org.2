Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D013A3D9CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 06:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhG2Erb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 00:47:31 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:4049 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbhG2Er3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 00:47:29 -0400
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 28 Jul 2021 21:47:27 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 28 Jul 2021 21:47:27 -0700
X-QCInternal: smtphost
Received: from minint-dvc2thc.qualcomm.com (HELO sartgarg-linux.qualcomm.com) ([10.206.24.245])
  by ironmsg02-blr.qualcomm.com with ESMTP; 29 Jul 2021 10:16:59 +0530
Received: by sartgarg-linux.qualcomm.com (Postfix, from userid 2339771)
        id 5DECB35F9; Thu, 29 Jul 2021 10:16:58 +0530 (IST)
From:   Sarthak Garg <sartgarg@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     vbadigan@codeaurora.org, stummala@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sarthak Garg <sartgarg@codeaurora.org>
Subject: [PATCH V2 0/2] Introduce max_timeout_count in sdhci_host for vendor
Date:   Thu, 29 Jul 2021 10:16:39 +0530
Message-Id: <1627534001-17256-1-git-send-email-sartgarg@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626444182-2187-3-git-send-email-sartgarg@codeaurora.org>
References: <1626444182-2187-3-git-send-email-sartgarg@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce max_timeout_count in sdhci_host_struct to let vendor's modify
the max timeout value as per their needs.

Sahitya Tummala (1):
  mmc: sdhci-msm: Use maximum possible data timeout value

Sarthak Garg (1):
  mmc: sdhci: Introduce max_timeout_count variable in sdhci_host

 drivers/mmc/host/sdhci-msm.c |  3 +++
 drivers/mmc/host/sdhci.c     | 15 +++++++++------
 drivers/mmc/host/sdhci.h     |  1 +
 3 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.7.4

