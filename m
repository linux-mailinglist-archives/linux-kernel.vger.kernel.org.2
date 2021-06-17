Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1AF3ABB90
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 20:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhFQS1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 14:27:02 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:58920 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233477AbhFQS0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 14:26:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623954254; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=XOkVVyqd8Az2zXdTOo6sO6aCl4Tah5j7RJ/EfOfUj+w=; b=SSrVRq1cMz1A7kA6Yfj0WHRsGPSSWpGbXSPD/dM0tMbO+ERGaWgAB3Bnvvwzk0O8kFIqqtyJ
 g4Ogz2cbeMeKiQCxdvYadSjxEbZCq5EJ4CKrFZm1zoT2gkuwR1XfrxCszrMlXLL81u5CAF2v
 buV+2GYr6tz/Fbu+QFrGnwmDelU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60cb9348abfd22a3dc117877 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Jun 2021 18:24:08
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E350AC43143; Thu, 17 Jun 2021 18:24:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49519C4360C;
        Thu, 17 Jun 2021 18:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49519C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        loic.poulain@linaro.org, Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH] bus: mhi: pci_generic: Apply no-op for wake using inband wake support flag
Date:   Thu, 17 Jun 2021 11:23:53 -0700
Message-Id: <1623954233-32092-1-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices such as SDX24 do not have the provision for inband wake
doorbell in the form of channel 127. Newer devices such as SDX55
or SDX65 have it by default. Ensure the functionality is used
based on this such that device wake stays held when a client
driver uses mhi_device_get() API or the equivalent debugfs entry.

Fixes: e3e5e6508fc1 ("bus: mhi: pci_generic: No-Op for device_wake operations")
Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/pci_generic.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
index d84b743..31360a2 100644
--- a/drivers/bus/mhi/pci_generic.c
+++ b/drivers/bus/mhi/pci_generic.c
@@ -32,6 +32,7 @@
  * @edl: emergency download mode firmware path (if any)
  * @bar_num: PCI base address register to use for MHI MMIO register space
  * @dma_data_width: DMA transfer word size (32 or 64 bits)
+ * @no_inband_wake: Devices without inband wake support (such as sdx24)
  */
 struct mhi_pci_dev_info {
 	const struct mhi_controller_config *config;
@@ -40,6 +41,7 @@ struct mhi_pci_dev_info {
 	const char *edl;
 	unsigned int bar_num;
 	unsigned int dma_data_width;
+	bool no_inband_wake;
 };
 
 #define MHI_CHANNEL_CONFIG_UL(ch_num, ch_name, el_count, ev_ring) \
@@ -242,7 +244,8 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx65_info = {
 	.edl = "qcom/sdx65m/edl.mbn",
 	.config = &modem_qcom_v1_mhiv_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
-	.dma_data_width = 32
+	.dma_data_width = 32,
+	.no_inband_wake = false
 };
 
 static const struct mhi_pci_dev_info mhi_qcom_sdx55_info = {
@@ -251,7 +254,8 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx55_info = {
 	.edl = "qcom/sdx55m/edl.mbn",
 	.config = &modem_qcom_v1_mhiv_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
-	.dma_data_width = 32
+	.dma_data_width = 32,
+	.no_inband_wake = false
 };
 
 static const struct mhi_pci_dev_info mhi_qcom_sdx24_info = {
@@ -259,7 +263,8 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx24_info = {
 	.edl = "qcom/prog_firehose_sdx24.mbn",
 	.config = &modem_qcom_v1_mhiv_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
-	.dma_data_width = 32
+	.dma_data_width = 32,
+	.no_inband_wake = true
 };
 
 static const struct mhi_channel_config mhi_quectel_em1xx_channels[] = {
@@ -301,7 +306,8 @@ static const struct mhi_pci_dev_info mhi_quectel_em1xx_info = {
 	.edl = "qcom/prog_firehose_sdx24.mbn",
 	.config = &modem_quectel_em1xx_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
-	.dma_data_width = 32
+	.dma_data_width = 32,
+	.no_inband_wake = true
 };
 
 static const struct mhi_channel_config mhi_foxconn_sdx55_channels[] = {
@@ -339,7 +345,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
 	.edl = "qcom/sdx55m/edl.mbn",
 	.config = &modem_foxconn_sdx55_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
-	.dma_data_width = 32
+	.dma_data_width = 32,
+	.no_inband_wake = false
 };
 
 static const struct pci_device_id mhi_pci_id_table[] = {
@@ -640,9 +647,12 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mhi_cntrl->status_cb = mhi_pci_status_cb;
 	mhi_cntrl->runtime_get = mhi_pci_runtime_get;
 	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
-	mhi_cntrl->wake_get = mhi_pci_wake_get_nop;
-	mhi_cntrl->wake_put = mhi_pci_wake_put_nop;
-	mhi_cntrl->wake_toggle = mhi_pci_wake_toggle_nop;
+
+	if (info->no_inband_wake) {
+		mhi_cntrl->wake_get = mhi_pci_wake_get_nop;
+		mhi_cntrl->wake_put = mhi_pci_wake_put_nop;
+		mhi_cntrl->wake_toggle = mhi_pci_wake_toggle_nop;
+	}
 
 	err = mhi_pci_claim(mhi_cntrl, info->bar_num, DMA_BIT_MASK(info->dma_data_width));
 	if (err)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

