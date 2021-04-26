Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9578036AF14
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 09:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhDZHxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 03:53:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232979AbhDZHnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 03:43:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CB70613C4;
        Mon, 26 Apr 2021 07:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619422811;
        bh=sL2wviUKoZfmwofxZJu5uW934bvydhzmqXTAzeULgFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQkusEYMRW164QCY4dOu7w6isMp2VGeH/CYx94kouy7l4PcYujZCz5YAPD+XuCLmE
         q0cRoTVYn9edR3inakdOgITpsoSLDdvjwtIpZ+HgKYXFIDKLXHRQaVyf1R9uePD9XH
         tc/Xyb3236RHdAxjOpYv9EtbArBkH4EDSHji+rW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Thierry Reding <treding@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 27/36] dmaengine: tegra20: Fix runtime PM imbalance on error
Date:   Mon, 26 Apr 2021 09:30:09 +0200
Message-Id: <20210426072819.715191108@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426072818.777662399@linuxfoundation.org>
References: <20210426072818.777662399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 917a3200b9f467a154999c7572af345f2470aaf4 ]

pm_runtime_get_sync() will increase the runtime PM counter
even it returns an error. Thus a pairing decrement is needed
to prevent refcount leak. Fix this by replacing this API with
pm_runtime_resume_and_get(), which will not change the runtime
PM counter on error.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Acked-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20210409082805.23643-1-dinghao.liu@zju.edu.cn
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/tegra20-apb-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 71827d9b0aa1..b7260749e8ee 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -723,7 +723,7 @@ static void tegra_dma_issue_pending(struct dma_chan *dc)
 		goto end;
 	}
 	if (!tdc->busy) {
-		err = pm_runtime_get_sync(tdc->tdma->dev);
+		err = pm_runtime_resume_and_get(tdc->tdma->dev);
 		if (err < 0) {
 			dev_err(tdc2dev(tdc), "Failed to enable DMA\n");
 			goto end;
@@ -818,7 +818,7 @@ static void tegra_dma_synchronize(struct dma_chan *dc)
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
 	int err;
 
-	err = pm_runtime_get_sync(tdc->tdma->dev);
+	err = pm_runtime_resume_and_get(tdc->tdma->dev);
 	if (err < 0) {
 		dev_err(tdc2dev(tdc), "Failed to synchronize DMA: %d\n", err);
 		return;
-- 
2.30.2



