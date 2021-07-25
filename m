Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3F33D4B1A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 05:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhGYCXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 22:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhGYCXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 22:23:30 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D53C061760
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 20:04:01 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u10so6786311oiw.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 20:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i41MjxNBGnyelNR6Z6r7QRVZ7cIT7dJr7P2wEnNvkN4=;
        b=xUiQueEb0Mm6puORxMN7ixcknmUUW7+ty+PZyzjcQPvpupXPffuQt4ijgFFkrC6QSU
         CCjoELE1Z8Dt7Dg4wncEY04J0XdCaIP3u3QULzICX/fphldn+YvY3I6n1ZqbSg13dMe6
         8msM6VYTW4ammgtJ/Xdrv7E9Zl+Oz+KDtkLPgJEbUlWUcagKP56aoQ6p6bksHvPhUROj
         3QMOtYVKQRnYGLFRPyg5ClvHHbxHrxO829i7B7r2IqoYsPYiI8HRMgUDXaIvbpSFhGpA
         Ya1nyfigcwJtWKnMZPT0MuQeblptluXHEEfh1joHXjyFK4klMbV/bbYksPf2zK0lSrUv
         MN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i41MjxNBGnyelNR6Z6r7QRVZ7cIT7dJr7P2wEnNvkN4=;
        b=b1PjNOvwK/KkkpUGHf8SU6uqiImUyTIdmPIdX/Y8tUbuG5gxFoBJFkrakmO1wD/Hf4
         CIZwCQGMxTFD/JuZDbAHHhxWPovHJqDXsiSMUU0yHSdyJo+Oy94JJM8nWsCel/ad9Pix
         +fbGK+eGmST/92Yr9PLTTk13uylMo+94IkkGqJDcQXmpRsltildBwevhFvjHyrowpJl2
         o48g5gJVcDFyFhSdBf+gQBD2KBfVNR4jvY4ZB8EygFU+qQWm/vHZ9Ygz+6e883XvYugJ
         oXtjtVc/AYKvqFte/wGiYvhndm52YpihNpQoySPtS/9Yfff+/C/VDbdzdoI696MVyAB7
         KQEQ==
X-Gm-Message-State: AOAM530g8cqfz2IAngYB5Z4UGDo8r/5niN8jxGnDkN2NDluuVHhEVVd4
        4vRswmtR+I9WOvTgTTMQ1vtIt0MwGx0j3Q==
X-Google-Smtp-Source: ABdhPJx8yltFDhA0miTyRRKekdr4v45UgoxLBmNRVd7x4VzkGSI+Z0nicX86cSIo7Ajo+Tn+k+xcnQ==
X-Received: by 2002:aca:5c0a:: with SMTP id q10mr5076341oib.11.1627182241092;
        Sat, 24 Jul 2021 20:04:01 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w35sm3389048ott.80.2021.07.24.20.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 20:04:00 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: blacklist Qualcomm sc8180x in cpufreq-dt-platdev
Date:   Sat, 24 Jul 2021 20:02:14 -0700
Message-Id: <20210725030214.3942250-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SC8180x platform uses the qcom-cpufreq-hw driver, so
it in the cpufreq-dt-platdev driver's blocklist.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bef7528aecd3..9d5a38a91f10 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -139,6 +139,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,qcs404", },
 	{ .compatible = "qcom,sc7180", },
 	{ .compatible = "qcom,sc7280", },
+	{ .compatible = "qcom,sc8180x", },
 	{ .compatible = "qcom,sdm845", },
 
 	{ .compatible = "st,stih407", },
-- 
2.29.2

