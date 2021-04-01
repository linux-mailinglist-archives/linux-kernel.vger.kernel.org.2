Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1C2351938
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhDARwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbhDARk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:40:56 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E48C022583
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 08:15:41 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id m11so1678442pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ww076wtEw/l52B1eQC1HZmnMQQ8Ebtr9JfK+3ViX3so=;
        b=tF+Bf0zSHiNRZEzbvax45HKx5XasDVc4mTeR8Z3f5KOhpxLF17YeyipN6Mnk2MEho2
         dIy2iXo7LwjVg0CYNSwMxpVJMpz0INw6mgFNFWDKvTcXRhEiv6IaE/tgrRyuLuuHakLr
         9mxUK0wM+O4SVQOusVcdbIoRK689kFxwmzBSTqZmkR6XL0O/dqF0j9iga4Xh67Vj2s86
         /xsy6fLZg+0LuawDYPkxWkh0BiCSHlUhcKuW82dbBmgjOMHhjPChWXn9q7xh49G6l+ch
         aDHeoIzlmBCObxHRlsK5dxeeV4nlRtEdxcC60DDZc+FRNUAy4Bh1U67sZnjTAGYQ7YQ3
         z4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ww076wtEw/l52B1eQC1HZmnMQQ8Ebtr9JfK+3ViX3so=;
        b=ipT9jiCS58pvgpcEdXrr/exQNY+2BPlNzffnKnaua8sRYhaafZGKHqhdiRtSZzcNBU
         fILgweHjro7VH1aCaGFPDCtL4C6pawkRhdQc8GD7U4J2oC1UQHIUuVIxm7B8uYOProJ4
         5FpgBya8BZoE357UFtFQN8uyJCXyPxbt4YThFnVckpqvQ5nFCiWqeEQfZyrZ3gOU31CA
         y26s2+Z1sVnyI+oRPm3twK59/8geKHcqE9tzW55ScOAep20arNJsN+dKv2GtCsOdWyjU
         5d0HoqCzrh0qwLwjCKK2+VsBzfHm3oHeOrURj5UA4WKYL8ll97OrnsMW2e3wWOifqaW8
         QuFw==
X-Gm-Message-State: AOAM530gIQeKlYtrBeJHV65IBLlK6N2oQJ0cE1QNS21+d31FWTwx1b1A
        +XDCl0YnrZ8RdkOxzW+bbXjN
X-Google-Smtp-Source: ABdhPJy3tSsSELJHLBsot1ilaqec0UUD358hycDfpgPt8GVfk7MyEPHq1NQy/QE8vIhIyquNpGL4vw==
X-Received: by 2002:a62:27c7:0:b029:204:7b11:3222 with SMTP id n190-20020a6227c70000b02902047b113222mr7788418pfn.34.1617290140491;
        Thu, 01 Apr 2021 08:15:40 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.138])
        by smtp.gmail.com with ESMTPSA id 35sm5652769pgr.14.2021.04.01.08.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:15:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v9 4/4] mtd: rawnand: qcom: Add missing nand_cleanup() in error path
Date:   Thu,  1 Apr 2021 20:45:08 +0530
Message-Id: <20210401151508.143075-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401151508.143075-1-manivannan.sadhasivam@linaro.org>
References: <20210401151508.143075-1-manivannan.sadhasivam@linaro.org>
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

