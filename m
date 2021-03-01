Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A0F329C39
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 12:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380334AbhCBBuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 20:50:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241709AbhCAT2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:28:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5672764F16;
        Mon,  1 Mar 2021 17:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614620943;
        bh=gMSNn9tMPspDTuCyI1ctQlZGGgm3lYEuGaVKkrylgYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n7MocY0EZGhqntbEdp7+9wBmtRJtA8Gc2pyD98JQgCa7P+soWgQrE4yFkIPnx2RnZ
         w5N3aD13nKzlzdJKTl4vsxwluEUTU1p90n/qfW4SqJRrNUbg4RHFSWr62rGxMJd6js
         gzmOeXjXz7M9MPuUfRADggDkTAWObhjPhs8t1+kM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhang Qilong <zhangqilong3@huawei.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.11 306/775] HSI: Fix PM usage counter unbalance in ssi_hw_init
Date:   Mon,  1 Mar 2021 17:07:54 +0100
Message-Id: <20210301161216.743812788@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161201.679371205@linuxfoundation.org>
References: <20210301161201.679371205@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qilong <zhangqilong3@huawei.com>

[ Upstream commit aa57e77b3d28f0df07149d88c47bc0f3aa77330b ]

pm_runtime_get_sync will increment pm usage counter
even it failed. Forgetting to putting operation will
result in reference leak here. We fix it by replacing
it with pm_runtime_resume_and_get to keep usage counter
balanced.

Fixes: b209e047bc743 ("HSI: Introduce OMAP SSI driver")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hsi/controllers/omap_ssi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 7596dc1646484..44a3f5660c109 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -424,7 +424,7 @@ static int ssi_hw_init(struct hsi_controller *ssi)
 	struct omap_ssi_controller *omap_ssi = hsi_controller_drvdata(ssi);
 	int err;
 
-	err = pm_runtime_get_sync(ssi->device.parent);
+	err = pm_runtime_resume_and_get(ssi->device.parent);
 	if (err < 0) {
 		dev_err(&ssi->device, "runtime PM failed %d\n", err);
 		return err;
-- 
2.27.0



