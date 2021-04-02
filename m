Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829D2352C1A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbhDBPCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 11:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbhDBPCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 11:02:09 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80546C061793
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 08:02:07 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id nh5so600918pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ww076wtEw/l52B1eQC1HZmnMQQ8Ebtr9JfK+3ViX3so=;
        b=ybrJ/XWa/mCxIE3noK0GCj+uKoLYgbMhcMQgqAAFk3B5fG/hCSYv/F1qtTUUcWn2Mu
         KxjVFEXJv/ORf4CfApwFggSqAln5Z3+I3OeriRpumvglfjwXC6h7dhcMnPmo07QJ/+ZG
         wwHjxZZb0wehKDxWPQ3AgMwikrdDxH05aNo11bZYQFDvjaEI1ie62PbcR0VTcNg5pz5n
         cAwjmX45Pn+yiGFbwQ3PqPvCRzA/Won4h4uiO+pCtAc2G9jgY63mG50TtcT9rQuodYpf
         XLU5cPfAZmlgju7jpwNLZsdsq3RtrSCd+icLLJESKQcSj5RD+fFev/lCAQ92Dm7dekXh
         GtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ww076wtEw/l52B1eQC1HZmnMQQ8Ebtr9JfK+3ViX3so=;
        b=rpU+dzSIS8l77d/FZwqEmsLDiJeqrigckfGS64QoNdi8nFCcKzuYZLVc3gFlrbkPBA
         hnCkPJRoiBiHSEF+6bEmVJ7NzsR0kthCJfxsY/teJ6/ZIFL2ZqSr7qU3CmBkoJMz7Sf/
         YJC+26e+Nz3bm/fuMSvEnk94868LKDvuKsq9t6BgTHhllbuhok7GVMT4UyELqcNT79Vb
         6bHpLdQt+1viIVXUNTziNMBY5UB04Y/287wlJq59kFf9Y2+2AEVuhQjEqOkKkdcP7m98
         IjcpdubslCMLkZFE2I/9SOGL40EYGu5d2JW3aRrMW2+aAsCSLm5byflU8SGAn7wiulCC
         ealw==
X-Gm-Message-State: AOAM532p/zng8XftrE7RIH5jkWyzRvILjJP5y0jVe1qnDMBC0tJhRkCW
        2wl46LTV6yBiPJfqG+TxQlI+
X-Google-Smtp-Source: ABdhPJxz13FLUMPQqOofA5mU/CiwuDuOWUytmngYWZcm28AENSnwG/TOkh7u7d7f6fDaW5lwBooosw==
X-Received: by 2002:a17:90a:c249:: with SMTP id d9mr14444710pjx.104.1617375725992;
        Fri, 02 Apr 2021 08:02:05 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.174])
        by smtp.gmail.com with ESMTPSA id x7sm8773647pff.12.2021.04.02.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 08:02:05 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v11 4/4] mtd: rawnand: qcom: Add missing nand_cleanup() in error path
Date:   Fri,  2 Apr 2021 20:31:28 +0530
Message-Id: <20210402150128.29128-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210402150128.29128-1-manivannan.sadhasivam@linaro.org>
References: <20210402150128.29128-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing nand_cleanup() in the alloc_bam_transaction() error path
to cleanup the resources properly.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 87c23bb320bf..fe74cf3aece5 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2882,6 +2882,7 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 		if (!nandc->bam_txn) {
 			dev_err(nandc->dev,
 				"failed to allocate bam transaction\n");
+			nand_cleanup(chip);
 			return -ENOMEM;
 		}
 	}
-- 
2.25.1

