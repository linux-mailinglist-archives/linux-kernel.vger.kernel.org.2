Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6943714E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhECMCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233823AbhECMBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:01:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87307613BC;
        Mon,  3 May 2021 12:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043232;
        bh=TdZsPlFBVqMnAfLKJQ8OM63qnGU5Wz/rs1giFv4+tfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BKkn85nzWKuGpNW20gA1g5WqYHdusjuPMXDXeJtqZYLxm/jOykxfINJ8HuNYlwi7j
         OsWV940rEsIxxziofYTydHCsAnHWrGX+DmRcCs9vFbX+Z8ZmhnbaFvpztE4HAra06D
         GwYukLtBvRHWnvTea8okAhkm0+O2sDnLnExCmc3I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Sinan Kaya <okaya@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 51/69] dmaengine: qcom_hidma: comment platform_driver_register call
Date:   Mon,  3 May 2021 13:57:18 +0200
Message-Id: <20210503115736.2104747-52-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phillip Potter <phil@philpotter.co.uk>

Place a comment in hidma_mgmt_init explaining why success must
currently be assumed, due to the cleanup issue that would need to
be considered were this module ever to be unloadable or were this
platform_driver_register call ever to fail.

Cc: Sinan Kaya <okaya@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/qcom/hidma_mgmt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index fe87b01f7a4e..62026607f3f8 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -418,6 +418,20 @@ static int __init hidma_mgmt_init(void)
 		hidma_mgmt_of_populate_channels(child);
 	}
 #endif
+	/*
+	 * We do not check for return value here, as it is assumed that
+	 * platform_driver_register must not fail. The reason for this is that
+	 * the (potential) hidma_mgmt_of_populate_channels calls above are not
+	 * cleaned up if it does fail, and to do this work is quite
+	 * complicated. In particular, various calls of of_address_to_resource,
+	 * of_irq_to_resource, platform_device_register_full, of_dma_configure,
+	 * and of_msi_configure which then call other functions and so on, must
+	 * be cleaned up - this is not a trivial exercise.
+	 *
+	 * Currently, this module is not intended to be unloaded, and there is
+	 * no module_exit function defined which does the needed cleanup. For
+	 * this reason, we have to assume success here.
+	 */
 	platform_driver_register(&hidma_mgmt_driver);
 
 	return 0;
-- 
2.31.1

