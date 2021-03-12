Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36D733823D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 01:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhCLAZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 19:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhCLAZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 19:25:01 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CD5C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 16:25:01 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 101-20020a9d04ee0000b02901b506659320so548513otm.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 16:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1NdVDO8ItlMTPJ18SNyK+a0RilkRcKjF6X4ql5zLmpY=;
        b=dq/tD7Q6nCcXhNnPLw75gtYBUQCPqIIf+xTOtGP+ZPbjePnfFTOFM7J/J8bLzn100p
         en8p+dm5oReTmzl51zW9M/2rwrS8OW7fIsFSnUtyJqXN15d3T/1DdbEITWDuyYOyufNG
         oj294EHCofLeXtAxy45QYfuUqcPr9atCsIWTQ5LkSPz097zp0E6CiT3Oi30XC+4R5kSe
         b+9UeaYxq4I5NEJBUCMVW91xUmWcEr0/28keLe7hlqlAlhaKJDA4b4Ve9Zlu3ReGJ2Kd
         +62Zl5lTHP1ytqN26pN5ZzQ3w+qj8t9T6xdwILNzes5gbYZDgHgNqd9u9ySnFO7MnSTF
         1RrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1NdVDO8ItlMTPJ18SNyK+a0RilkRcKjF6X4ql5zLmpY=;
        b=kY+X6B6WCACFepedjaMCQz+rcQRvvJvIVd208wwqokkOKt/yWSyC2zV/fWJu+PAu3U
         rqrd9arLZVVCP74wIO/jb6IKk3EBTm9CHXWn6MFzYdYKRQ0H7YWx5jeRJ+T4Ym4sdhXj
         qmCBMj/QKDcj03cWF5HwfpDY492xTQUAjePq6HXSs9yiVX9Btep6iJXxNBFA2vWJhGpx
         Boa6uEfyI81sZFVMY0UCHYnUEZElDaB93UHf46JeymiaKHW/53SQZ+LLUp2YjEMVBgef
         moekIdezzoZ3aH0sDXLLeLyr5Xjo86EIRomuhjH/UGZHYrDd4xrZaD8JcEG4cjI7znsV
         cgww==
X-Gm-Message-State: AOAM5324L27EQldqZ+mU288i30w4pkCBOxgQKpCqwGKJMPQhRjQ8xcsA
        PP6OamXzs+M0tv1wci9gOKUvBg==
X-Google-Smtp-Source: ABdhPJz8SpM7A7ak878knDZAj+Ib7M0pHjwDoejGS8p9TdOLItD2ub3FrSrxElPGH2+O/D8fz3nk3w==
X-Received: by 2002:a9d:788:: with SMTP id 8mr1277709oto.197.1615508700963;
        Thu, 11 Mar 2021 16:25:00 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r20sm1016527otd.26.2021.03.11.16.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 16:25:00 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: qcom_q6v5_mss: Provide errors for firmware-name parsing
Date:   Thu, 11 Mar 2021 16:26:05 -0800
Message-Id: <20210312002605.3273255-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Failing to read the "firmware-name" DT property without informing the
developer is annoying, add some helpful debug prints.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 66106ba25ba3..15abfbba78d2 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1661,8 +1661,10 @@ static int q6v5_probe(struct platform_device *pdev)
 	mba_image = desc->hexagon_mba_image;
 	ret = of_property_read_string_index(pdev->dev.of_node, "firmware-name",
 					    0, &mba_image);
-	if (ret < 0 && ret != -EINVAL)
+	if (ret < 0 && ret != -EINVAL) {
+		dev_err(&pdev->dev, "unable to read mba firmware-name\n");
 		return ret;
+	}
 
 	rproc = rproc_alloc(&pdev->dev, pdev->name, &q6v5_ops,
 			    mba_image, sizeof(*qproc));
@@ -1680,8 +1682,10 @@ static int q6v5_probe(struct platform_device *pdev)
 	qproc->hexagon_mdt_image = "modem.mdt";
 	ret = of_property_read_string_index(pdev->dev.of_node, "firmware-name",
 					    1, &qproc->hexagon_mdt_image);
-	if (ret < 0 && ret != -EINVAL)
+	if (ret < 0 && ret != -EINVAL) {
+		dev_err(&pdev->dev, "unable to read mpss firmware-name\n");
 		goto free_rproc;
+	}
 
 	platform_set_drvdata(pdev, qproc);
 
-- 
2.29.2

