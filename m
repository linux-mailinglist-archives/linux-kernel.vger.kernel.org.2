Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE9E450320
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbhKOLJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:09:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237740AbhKOLId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:08:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3149263211;
        Mon, 15 Nov 2021 11:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636974333;
        bh=Vm0BiVCLcXT5Yv+VDKPr/Fj2l1VsoJGwsoRLlXTyZNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cN2ctFF5YiTQ/uW9YDh+x3Rax6z9InvLJ6WWJKCfh6uNBm/9756Cnhl0LTndAs1Rd
         GmugymJSihtJoim211o2bvDJ1wTNSQyW6IdMlEkHosxzinf5WcMwNpnIHqOhH+cYg2
         KGnVYqOoScV9Qhfs0wOiUjlhxt9sgMXsIZi1yHUIcmzRfxo4NIfBDYtixo5vCXbVA4
         XCGQvH71tcin+cgZNgBcXeVLiVgAarEQZfDTA5jV2FXWCDZBtpqFeGHk1QX5MjKieb
         u1rvCViIoIAQ/8MlmWf8B3Iw7oJ+nNCPu+nVQjh4bYRNHmOhuKpzOKBj6xhYYf6n6p
         KCe5UVOVPMxxQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 6/7] habanalabs: skip PLL freq fetch
Date:   Mon, 15 Nov 2021 13:05:20 +0200
Message-Id: <20211115110521.783103-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211115110521.783103-1-ogabbay@kernel.org>
References: <20211115110521.783103-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Getting the used PLL index with which to send the CPUPU packet relies on
the CPUCP info packet.

In case CPU queues are not enabled getting the PLL index will issue an
error and in some ASICs will also fail the driver load.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 5 +++++
 drivers/misc/habanalabs/goya/goya.c   | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index aed55db368d7..465540d064b6 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -881,6 +881,11 @@ static int gaudi_fetch_psoc_frequency(struct hl_device *hdev)
 	int rc;
 
 	if (hdev->asic_prop.fw_security_enabled) {
+		struct gaudi_device *gaudi = hdev->asic_specific;
+
+		if (!(gaudi->hw_cap_initialized & HW_CAP_CPU_Q))
+			return 0;
+
 		rc = hl_fw_cpucp_pll_info_get(hdev, HL_GAUDI_CPU_PLL, pll_freq_arr);
 
 		if (rc)
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 7b3683f2a6dc..2347de2f426a 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -739,6 +739,11 @@ static void goya_fetch_psoc_frequency(struct hl_device *hdev)
 	int rc;
 
 	if (hdev->asic_prop.fw_security_enabled) {
+		struct goya_device *goya = hdev->asic_specific;
+
+		if (!(goya->hw_cap_initialized & HW_CAP_CPU_Q))
+			return;
+
 		rc = hl_fw_cpucp_pll_info_get(hdev, HL_GOYA_PCI_PLL,
 				pll_freq_arr);
 
-- 
2.25.1

