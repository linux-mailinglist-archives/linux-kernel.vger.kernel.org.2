Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BE13CE8A4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 19:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356991AbhGSQpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 12:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346630AbhGSP0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:26:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3B5D6008E;
        Mon, 19 Jul 2021 16:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626710806;
        bh=RyTWkYiz8/bjS5nvdqHkHs7YseMfsXdxWE1N1pudK0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IsIMV7V4+NfSnKCRfXtY9mR4cFUgWDfKpVUs63k6FiN4tjXtwFSm/Ox1j5a6rMEgD
         uu/fA8urH6Vvy6IXlNHns4l5qzwlfoA0WfmQOFkDqA+Q5udB9tMnzAl809jTgaqs1c
         PHWtLceWlmlBCjq636k+o9eAyOeA9L1OcrR1paL4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ohad Sharabi <osharabi@habana.ai>,
        Oded Gabbay <ogabbay@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.13 115/351] habanalabs: check if asic secured with asic type
Date:   Mon, 19 Jul 2021 16:51:01 +0200
Message-Id: <20210719144948.282953491@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210719144944.537151528@linuxfoundation.org>
References: <20210719144944.537151528@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

[ Upstream commit 190ec49710a9fe0d5e9e36fe1a2fa864c048484f ]

Fix issue in which the input to the function is_asic_secured was device
PCI_IDS number instead of the asic_type enumeration.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index d15b912a347b..91bcaaed5cd6 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -309,7 +309,7 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 
 	if (pdev)
 		hdev->asic_prop.fw_security_disabled =
-				!is_asic_secured(pdev->device);
+				!is_asic_secured(hdev->asic_type);
 	else
 		hdev->asic_prop.fw_security_disabled = true;
 
-- 
2.30.2



