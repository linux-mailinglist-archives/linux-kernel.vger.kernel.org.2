Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564153A3E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhFKIfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhFKIfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:35:54 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6638DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:33:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a11so5101092wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lkqFPuA0uZSuPyNJGbU9i0+vowe6h+gPxqK2cczVgGA=;
        b=K4+JD6aTx/6uKsckuneQkWKqpwLQHDK2Dehx1P49WjwfkoyWSmnxKNoX4AulYaj1jy
         7HugJaCq6xOWnCS9x58YUH3rQHH8ID2l1JFJ9CFunP8nBP6gCmdNDTnO30b8QE2nWVQK
         x42BWkk/UeRhbDOuwZYvkCVuy332scoAqfp7xseHGqa4IhdyM7JYIoWvjhPknXAhaV60
         tdVXLk1JC+T7FLgu6G3c0zE9lP1Z4y7gFmSBMKh1R+5ZqqRsE8/8FZznaux39FQI33Y9
         JAIMkD8WCBrS2ik3z5M8E6abQ/Wv1Z4dzxqIr2mk7t/JmJMh2pIjCrnm6FQUXbvrjypx
         Rdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lkqFPuA0uZSuPyNJGbU9i0+vowe6h+gPxqK2cczVgGA=;
        b=uL9xvJ+KxjHk+UIeIGY7qEU785qHRyS4zKOs2+z3bnJAP/I8r3MhqHSZb3AJetnxL9
         KPwfU/Vuo7TkcKSoi9B4+Jd85mi0AtR8KsO5tQN9smrzZcveUGrLip5/tyysePTNkOgV
         G3FRiUAssyVMCa1QJpXPf+78E4VAZCnCxZBuYFjAp9plOmFqBS2ZrVSA3Uqf0eCquizz
         vftWt3k/SthbIbXt9FWac8VXJHCxsEWV8u7zwAWt8ykM1aSND6HVDhg2cvTq1yjyiX8I
         6slyRFngqc88Ydf5qDpuRgofvfQVsZaF5IC7sQei4luU9V5X8dXxHTDNAMbB+fYXvrf/
         g7UA==
X-Gm-Message-State: AOAM530rH9QQDxQ0nS90J4/LZ0lCFVxYi4GEBwfwMydi4JPH49Tk5mDV
        GRuq0r/liTdZBR0UoVpdcD9gFw==
X-Google-Smtp-Source: ABdhPJz0N1rnU0Kspi2h5Ns/OZK2Bbv06rnmX9DdyTVmfZFyrwcAquaYq1ZKPlYw6bbbBA1l5I63BA==
X-Received: by 2002:a05:6000:cb:: with SMTP id q11mr2706957wrx.13.1623400435056;
        Fri, 11 Jun 2021 01:33:55 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n42sm11547428wms.29.2021.06.11.01.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 01:33:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/9] nvmem: qcom-spmi-sdam: add missing MODULE_DEVICE_TABLE
Date:   Fri, 11 Jun 2021 09:33:41 +0100
Message-Id: <20210611083348.20170-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
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

