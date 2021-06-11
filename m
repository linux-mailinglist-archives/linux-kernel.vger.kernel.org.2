Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6C03A3E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhFKIg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:36:57 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:44029 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhFKIgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:36:52 -0400
Received: by mail-wr1-f46.google.com with SMTP id r9so5098230wrz.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wGhzKvasLTNrZKMLqsM/L0imOceeXRRJYOj6hGcxaUU=;
        b=D6uRNwdM7vwdmqXt5WczYiD9vESpIT5wMt08EPNi4HVegReMizZPwhR+xwN6cnX3S6
         sEhp5Sc9r0qDC2qPjdc/7Fbyvr/y4zE0z4TsiDVCLfZf+1KUk56Rn47B4C0SB+Gc72Pn
         VTA743xynr/rtu7/m+LQ62Ki5Nob61AIfpkb+zj2X9X60MzTBIYNXGziWePXmpq2SG9A
         gA5qZFQMPuD/5XJWIbvgcsow2re5fbctVh3lx9PxKNPTBaBW49H86aqCGqDMUSDqWF+6
         p33lkjR5WRnOvfbXPVl1ZS1GvKGzpcTDfkFzcPQ9LL1wmd5OYi2ns+t/0nhpshox9L1d
         4oaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGhzKvasLTNrZKMLqsM/L0imOceeXRRJYOj6hGcxaUU=;
        b=to3Qe6eEm2QfaVxrB8WlpJD0NHd/mZ6Av8iODMn1vzzx+oUGSntEVrOWxKAxn82GaB
         I+EBsEjdXVt95+34GAeEOqbdFH5BuDbk+G2Y7VCpoD/Pv4QWmZCdK8eJ0N/AGHb2ER2W
         0L9pqc8gct9jgXLVeCC61fR85Rz+8sz0BTXysfnegV3BD7usnD+QzsqfA0T/+8E8YXoH
         q2u1qVLeJ9QeXq/dMhmDrXKZHs7gu6wiGbt/4w8TPE4R+PU4NAr39bZ/cZU10iA/7jIO
         oOUyEIPl1ccGRjPZ0u1wgOiycBfh4sIGBx0UDJGANzHJ0rulPecQe+e0ODDRQqOaKODW
         MgRw==
X-Gm-Message-State: AOAM530iZtXq1YT4rG/AB+CsPY+iWWtd76Y5+JH9S6UPKKLf6xRZwCoq
        B6e8kdP8p3wu2Zjkta378tVdzA==
X-Google-Smtp-Source: ABdhPJzcTiMNPK6Dk/8mi+2614lUqyetjTO9w6zY/Zp6LK9FRFzgNXNBzazPeCodEQ0b1EYgS8TW8w==
X-Received: by 2002:a5d:4a4b:: with SMTP id v11mr2777247wrs.246.1623400434089;
        Fri, 11 Jun 2021 01:33:54 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n42sm11547428wms.29.2021.06.11.01.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 01:33:53 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Bixuan Cui <cuibixuan@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/9] nvmem: sprd: Add missing MODULE_DEVICE_TABLE
Date:   Fri, 11 Jun 2021 09:33:40 +0100
Message-Id: <20210611083348.20170-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bixuan Cui <cuibixuan@huawei.com>

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sprd-efuse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index 59523245db8a..5d394559edf2 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -425,6 +425,7 @@ static const struct of_device_id sprd_efuse_of_match[] = {
 	{ .compatible = "sprd,ums312-efuse", .data = &ums312_data },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sprd_efuse_of_match);
 
 static struct platform_driver sprd_efuse_driver = {
 	.probe = sprd_efuse_probe,
-- 
2.21.0

