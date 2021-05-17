Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9974D382862
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbhEQJd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbhEQJd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:33:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F594C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:32:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i17so5594298wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkqFPuA0uZSuPyNJGbU9i0+vowe6h+gPxqK2cczVgGA=;
        b=im+lowk+biZ+GcBAQMHpMKBLjqWT2ihFxKVei4dNptf0flVMa6dorsfsSD/IgIQODs
         qmb5iYF1hyvW3tQt8SOoSmlPHBzO60aO/nn9mSOmk8zNQFwAhle4wJBI4uO4F43702PA
         05f8fGykWU4jEGTz7ND8ULkrvw/67aPtTy7jSZQ08XghX3ZmwtpSW82GI3kjazbxcdv4
         vxC68xq4nx9HttTdpspWrN4h8qAlEt5EGI9iHMVUsLUbPl/M8KePYiUQF9aY8tFPBHZH
         BCYDg33sQJvJBP73BsHw3XbDVrCDC1b2/k0cwKr0iJMXw2ucqgsCY8JeZFLM/K3U6HGW
         s/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkqFPuA0uZSuPyNJGbU9i0+vowe6h+gPxqK2cczVgGA=;
        b=RMPe0Ey6WX9HHdzPJY0AhwIkFTHD/wifl6C8uZA9eQFvK+HgvY1gZeTdG2Oo6k2Eps
         NrZlMA0i04jIfKzV/ilJ+OgTSa+qZjfdFSNc6uhgwMrmlb2jMvwPach2G9iV6pnoNUzc
         CKd7mKgAjSzILVVKDlGSU2NhCMHC1bUiwtwXUTraoqYGGXwbooofIL4McYhHpJyhSwKl
         iznoFPOFkR9wE9J6oe3O7HWDIgE9H1OpmOlv8c7+NbKnBKnSb8PZJSWMz3NAv/F0dzR5
         vBbxRWs15xYL6msYC5DXpMbtChF3led/VWk/TYTtlMOJGhbghabKIEeuVgETskovlw8h
         tnGA==
X-Gm-Message-State: AOAM531PN8ZSQqVyz7dV1XnVz2qyTVCPNk4aQjwDitnxMt5t/prC3Xex
        BGWGdbvYqpkl9hhCiEfhlMZogw==
X-Google-Smtp-Source: ABdhPJzJ7jXrALft97QvqB2fiQCWTNJ6EmPBsHCWB1lM9p3yVoIT9jpBvWBQY1a53r8RUGxPIeErMQ==
X-Received: by 2002:a05:6000:10d1:: with SMTP id b17mr2668310wrx.281.1621243959786;
        Mon, 17 May 2021 02:32:39 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id u6sm13796695wml.6.2021.05.17.02.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:32:39 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srinivas.kandagatla@linaro.org, srini@kernel.org
Cc:     aghayal@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: qcom-spmi-sdam: add missing MODULE_DEVICE_TABLE
Date:   Mon, 17 May 2021 10:32:34 +0100
Message-Id: <20210517093234.9433-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix module loading by adding missing MODULE_DEVICE_TABLE.

Fixes: 40ce9798794f ("nvmem: add QTI SDAM driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qcom-spmi-sdam.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
index 4fcb63507ecd..8499892044b7 100644
--- a/drivers/nvmem/qcom-spmi-sdam.c
+++ b/drivers/nvmem/qcom-spmi-sdam.c
@@ -166,6 +166,7 @@ static const struct of_device_id sdam_match_table[] = {
 	{ .compatible = "qcom,spmi-sdam" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, sdam_match_table);
 
 static struct platform_driver sdam_driver = {
 	.driver = {
-- 
2.21.0

