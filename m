Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B18A3A64D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbhFNL3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:29:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235705AbhFNLOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:14:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0836E6120E;
        Mon, 14 Jun 2021 10:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623667759;
        bh=GYnBavskh1K21ICisCRLOl5jmMjynEhXhWNdlUbVhYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6Cvkif1LQ9itMD0Bb8rIcMyaeYhnt6O3utoYRfB5SqTJB7SwFYgVCtEE91xBQpbK
         W3fH4FJs+Bz7gZgs37iAaapWLmxG41Bi5LijhPwx/Fu67yQPUnF6d1OSC5UmztWqEm
         PrKBZlZr693irZFNjaewpk9aB32vOCjXzPuW7l8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.12 030/173] scsi: hisi_sas: Drop free_irq() of devm_request_irq() allocated irq
Date:   Mon, 14 Jun 2021 12:26:02 +0200
Message-Id: <20210614102659.151131206@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614102658.137943264@linuxfoundation.org>
References: <20210614102658.137943264@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 7907a021e4bbfa29cccacd2ba2dade894d9a7d4c ]

irqs allocated with devm_request_irq() should not be freed using
free_irq(). Doing so causes a dangling pointer and a subsequent double
free.

Link: https://lore.kernel.org/r/20210519130519.2661938-1-yangyingliang@huawei.com
Reported-by: Hulk Robot <hulkci@huawei.com>
Acked-by: John Garry <john.garry@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 4580e081e489..b21246b1ba99 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -4799,14 +4799,14 @@ hisi_sas_v3_destroy_irqs(struct pci_dev *pdev, struct hisi_hba *hisi_hba)
 {
 	int i;
 
-	free_irq(pci_irq_vector(pdev, 1), hisi_hba);
-	free_irq(pci_irq_vector(pdev, 2), hisi_hba);
-	free_irq(pci_irq_vector(pdev, 11), hisi_hba);
+	devm_free_irq(&pdev->dev, pci_irq_vector(pdev, 1), hisi_hba);
+	devm_free_irq(&pdev->dev, pci_irq_vector(pdev, 2), hisi_hba);
+	devm_free_irq(&pdev->dev, pci_irq_vector(pdev, 11), hisi_hba);
 	for (i = 0; i < hisi_hba->cq_nvecs; i++) {
 		struct hisi_sas_cq *cq = &hisi_hba->cq[i];
 		int nr = hisi_sas_intr_conv ? 16 : 16 + i;
 
-		free_irq(pci_irq_vector(pdev, nr), cq);
+		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, nr), cq);
 	}
 	pci_free_irq_vectors(pdev);
 }
-- 
2.30.2



