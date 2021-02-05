Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819293108C8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhBEKNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhBEKJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:09:53 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FB6C06178B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 02:09:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id p15so6968103wrq.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 02:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fHMnPUMcdXUqu+570hjeKhQiTLfkIWlof5K/iTtz3V8=;
        b=hFAFmfXciurO3DOzZhQ9WDsc1AZIH5rPt5WZqvg9H/fEZlyYd27/dKIYgUp7Dsv0l9
         6CxOweQ/zJ1BGMQN/cVMF8CDE2Vt3kf5Rn/P8cPzX4P0DoPBa8FRf2sw5i8KKY9OlZCJ
         MPZSBUMrHHy2WFdxZb2qbcFVbuEQEFoEE/PF4iaUQb6q1mmvngnoZk2XgK0AWUBpX0Lp
         gEuPqGNOp+/CUSer98NmbhBAFMpJnmKII7MlSceZoqZDvLuxeNplRtQai1kNQG09Pk7A
         gbisP6bGp53KgOHZVnE3dVc9eSKJw44sPvdKEudC/de0SPNfkKzpU3MCUMwVIZAC1n5g
         y/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fHMnPUMcdXUqu+570hjeKhQiTLfkIWlof5K/iTtz3V8=;
        b=WnmbJkm06Rj52Qryu1uZxlWbRtnEMUoeF/WK9plg0i052gtgdQLA0NEzOGvZWsfu4h
         81oISIK5+Id9TWvlrKhrl0Sni+ZRElnS2Yyyh0meZ/+T8trQM7hUhHeY5oYeJdHXZyrC
         pPgUnb3Q/gtU4yZwt9zQjlZYKtnr/MQBoFzpg788oEUjmteiHOLam74OJpT45dap9Ova
         71XMQjahL6nh79vihYupMdEfg3TS9pdscwNJeWijDqrZmFGG51bqz91Ezgz7VLO1OyVU
         ViWesWp8HtCkMtixkjykX3C1hVAsGP+kyfQzWw5JcqAm4X273gNUxizKkdLPh78wDLT+
         Iemg==
X-Gm-Message-State: AOAM533lUAqUMTFqOcy+4zEMkabLhFrt0r75j1OwNfnw0EpEEiQpxcQQ
        IHamddb1IjIaW8xvuITKOVHVnA==
X-Google-Smtp-Source: ABdhPJxbYzK4w00vHl1O/MUiSLOGBNrSM8Ces8gLQVkcMQzAD6HPt2uXWmwY8U0jiynYNTdmW6JTwA==
X-Received: by 2002:adf:902a:: with SMTP id h39mr4101947wrh.147.1612519745850;
        Fri, 05 Feb 2021 02:09:05 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id g16sm8067738wmi.30.2021.02.05.02.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 02:09:05 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] nvmem: Kconfig: Correct typo in NVMEM_RMEM
Date:   Fri,  5 Feb 2021 10:08:52 +0000
Message-Id: <20210205100853.32372-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210205100853.32372-1-srinivas.kandagatla@linaro.org>
References: <20210205100853.32372-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

s/drivers/driver/ as the configuration selects a single driver.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index fecc19b884bf..75d2594c16e1 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -273,7 +273,7 @@ config SPRD_EFUSE
 config NVMEM_RMEM
 	tristate "Reserved Memory Based Driver Support"
 	help
-	  This drivers maps reserved memory into an nvmem device. It might be
+	  This driver maps reserved memory into an nvmem device. It might be
 	  useful to expose information left by firmware in memory.
 
 	  This driver can also be built as a module. If so, the module
-- 
2.21.0

