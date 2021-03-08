Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DC4331164
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhCHOzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhCHOze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:55:34 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF60C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 06:55:33 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v13so15119118edw.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 06:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XWoEzbGml88OxuqmQAcHOjUJ4xDFJxJMYhsbSvaYG8g=;
        b=CoZuzgDrGpFtj904f5wOt4pdQ3n8fg5dy/GPRYq1rjTInXfpz2xhI8+8Vv5wPkV1Wo
         wFX3oGQAjFIvlBNmhZJ6fvY9t8B76uKfz9sUj97rgWhDoIbGS6iSPrjfUOlCwHUfbIq2
         K2xcYmyB0aJUZyDJKKQ7UH544n9eeotYnTRliWp+P5UoX8W6F0lJnEflhgMhQNkWhd/s
         jHmpOQSIJXngWEOS0/6cemKhknyqXFEoxIrmGi11LpEyqZFY4UFQrV6uMwKSNbTfyNYK
         y71Ayez3+y21aI3oCrN+NZrk0zuVw2hZTTO0N+2evfe6jGpnUg8nBLo9mqvI+E7W5rOb
         npUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XWoEzbGml88OxuqmQAcHOjUJ4xDFJxJMYhsbSvaYG8g=;
        b=SVmJ0mfjgAPJHXJLw6HemCUimuW96fIk3vTsSTgkAt/b90jpRYlS5eCKfsf/AygJbY
         NZaRmIWAsci73iTKnQ19SeiNHqnpzWj5ITqRgqKNWg2FMsN/2UMcIhssoEE6ye7uR0Xf
         v+b5UE4aPxl2Q46r5dXn0/zuZH1VDsxb73KpU0Tb73gclmNTF4BMcuoc3TCUD92Tqr0h
         Rf84W3O0QIAL2MFTFqVsFwbpyxukjbVYuVZIWIWhYRhRHwBDBZthf8mfgA+XXAmnlZfW
         1gBd+hZ033WnwZSiYqOb5D/u5XelAMOqvWB38A29UOXqAp4Aal6noPzUPsWHs1nL4pxE
         c00w==
X-Gm-Message-State: AOAM533qP/dykBdtccHSNLdvdB+zPo4OKhFywaOVh1ktBF/XZk+hKr1d
        YFaiWWfGSOyR0FE2LV5y8eDC2UjU445GkJE2
X-Google-Smtp-Source: ABdhPJwUcJ3SUmtLrEEaeqoD1Jfg434VvxyQqtPpgiiJeOCIL6JkqcZQQAQ8evRVIMOkpgIhXEKA1w==
X-Received: by 2002:aa7:c1d5:: with SMTP id d21mr21943395edp.167.1615215332510;
        Mon, 08 Mar 2021 06:55:32 -0800 (PST)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id bt14sm7411234edb.92.2021.03.08.06.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 06:55:32 -0800 (PST)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, elder@kernel.org,
        johan@kernel.org, vireshk@kernel.org, rmfrfs@gmail.com,
        f.fainelli@gmail.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 05/10] spi: spi-tegra20-flash: don't check 'delay_usecs' field for spi transfer
Date:   Mon,  8 Mar 2021 16:54:57 +0200
Message-Id: <20210308145502.1075689-6-aardelean@deviqon.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210308145502.1075689-1-aardelean@deviqon.com>
References: <20210308145502.1075689-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'delay_usecs' field was handled for backwards compatibility in case
there were some users that still configured SPI delay transfers with
this field.

They should all be removed by now. So we can remove the 'delay_usecs'
handling in this driver.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/spi/spi-tegra20-sflash.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index cfb7de737937..2888d8a8dc6d 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -341,8 +341,7 @@ static int tegra_sflash_transfer_one_message(struct spi_master *master,
 			goto exit;
 		}
 		msg->actual_length += xfer->len;
-		if (xfer->cs_change &&
-		    (xfer->delay_usecs || xfer->delay.value)) {
+		if (xfer->cs_change && xfer->delay.value) {
 			tegra_sflash_writel(tsd, tsd->def_command_reg,
 					SPI_COMMAND);
 			spi_transfer_delay_exec(xfer);
-- 
2.29.2

