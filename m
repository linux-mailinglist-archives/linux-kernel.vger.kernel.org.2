Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9C2439B89
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhJYQeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbhJYQeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:34:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE038C061745;
        Mon, 25 Oct 2021 09:31:43 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j9so10780745lfu.7;
        Mon, 25 Oct 2021 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K2/lOC6/LqWyTGvmfoO3NeC8xnrcp4rPFFaNpGVoIdo=;
        b=cH3DdrvsyZVv2dZHErJ0g7HkPbYb77gzKzKaMSjXi7ay38j4U8toZsm8hEaOuJSx8I
         8ViqVYxpj7sdvSIYUdteZ7JYldD4gn3PhN2j5UyQa8Hy6hzTDkjRsm+fsQolKzdWy/y7
         HdU5q9/3r/oHuhBVUvkhw673povlzXAezIyrfAcUkL9pXxhi/Qqa74SQykbvl9ImuX9J
         eWXXopwq2KtWkxs84BrawlRTCrZNpv0C/UbR/QGt/WmmnRXHu+w7tTm06qbD2jhI/7PA
         ZMyULMDHij1OzhITmKHcQ5Kus7SXVU9vn5BvBwCafGW1RyYagzhpS4JK6WZotyuxhu/q
         d/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K2/lOC6/LqWyTGvmfoO3NeC8xnrcp4rPFFaNpGVoIdo=;
        b=WmDZQg/xQAIVt8hFPVsyisAikOWmC4eIxj1rk3jpzJtV4HHZXgH5ej3G8mNwY+GK5U
         U4fqQvN8wzqeqoMxp9qSqtoT842+WRjcYu5YHG285rSCxEM8CJIPmaoe4ZClfKEUCuJq
         FnBHJZ8o4H7jjGD/etM6pHTmlfbBzKsN7MTmsudIZfaBFxE1I33/wVWlYFV35dqZPbcN
         IC8d8PX9FYyEyFzkxmCC+mklCa0mzxTjaqr8UkEyddzgJbNibiQQ6sR56XCfu57/mrSM
         NQCbjCziYZvGh9bjZ9sZ8IvWbRezO2iIoFcselt4PlLcSfsNX8dqzDjCbNNS1Ba/xm8m
         JMrA==
X-Gm-Message-State: AOAM532iqJfP3lPRd6uc7F3dMUMMfjR039Zi0IeAX9k6rljxNv/y1aYa
        RfRmNH9+bB6eIxxhwtHsJE8xUYpZSN2zeQ==
X-Google-Smtp-Source: ABdhPJzBbWzlPhzHVIUrlsGQ4PsY6PiSgSrG/pibm9ADaZ5UvxOEW0T4ZYyX39C+/UZoQIRIttIdyg==
X-Received: by 2002:a05:6512:2291:: with SMTP id f17mr18108567lfu.253.1635179502034;
        Mon, 25 Oct 2021 09:31:42 -0700 (PDT)
Received: from localhost.localdomain (public-gprs234586.centertel.pl. [31.60.63.155])
        by smtp.gmail.com with ESMTPSA id i18sm656576lfu.269.2021.10.25.09.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 09:31:41 -0700 (PDT)
From:   Janusz Dziedzic <janusz.dziedzic@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-soc@vger.kernel.org, Alex Elder <elder@linaro.org>,
        Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH] soc: qcom: qmi: add a prompt to QCOM_QMI_HELPERS
Date:   Mon, 25 Oct 2021 18:31:21 +0200
Message-Id: <20211025163121.2189630-1-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Elder <elder@linaro.org>

Add a prompt to the "tristate" attribute in the Kconfig file in
which QCOM_QMI_HELPERS is defined; I find it doesn't get selected
without it.

We need it in OpenWRT project, when using WiFi backports
and build ath11k driver. While ath11k driver depends on
QCOM_QMI_HELPERS we need way to enable this option in
our kernel.

Signed-off-by: Alex Elder <elder@linaro.org>
Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 drivers/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index fe3c486ae32d..16fb8e286015 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -92,7 +92,7 @@ config QCOM_PDR_HELPERS
 	select QCOM_QMI_HELPERS
 
 config QCOM_QMI_HELPERS
-	tristate
+	tristate "Qualcomm QMI Helpers"
 	depends on NET
 
 config QCOM_RMTFS_MEM
-- 
2.25.1

