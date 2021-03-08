Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87963331167
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhCHOzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhCHOzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:55:36 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D155C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 06:55:36 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ox4so5341103ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 06:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dk38R2BEd68k0sRStLee7izJxfsp+PQHJm3HaMXnM6A=;
        b=ahfVV+tRIbM8ON7yRS/IM1epTuYYGywi+Koj8gByhh6/R1lwaQ5Pw36i8kwDwuLGiH
         Zhe3ULECmQI4x2Sv26GgkMNikMu0NKpw9wH/+bEzk9cOyPTDEJKDaQl48hmfleXFxiY/
         HqKi1fbZREQRxRXLrf4wLVdw9j2H0zT4YyInNGcWX1HheMd0lgaCLgW2a2l5Drgv8cGg
         DwQ+8QSmU8dYKHDNmufkE+jrJQhYzVnFrjZ3CjYxEDkivdQcf1O2c0NidPpdwQ+5kded
         1c8KcAXjYGVsyacm6BcVE9r1A0mYP6ZegtHntXkWZgsJCilpA7j0s0D/ER+03VaYFGxt
         aIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dk38R2BEd68k0sRStLee7izJxfsp+PQHJm3HaMXnM6A=;
        b=lZPn9M6VKMQOiOuKSku4EL9jWSl8eTJuQgxt58Y9Un7S9l5lIGU8tQdouMJMg/yz09
         b1Qehporj4DfSQionjqUkA6Nfa6JvB0NQKKBvCM+5xVCJqcwKfaBQTI9VWI6Ob/Dbf30
         poVK0J4GiIvEb2S/4Wztbrmn6v33A/qlxQYLmVghk43zop3VWwEvSTWpcUzy5vmfwrOK
         W9mjsBqyLF+cRKrsQfUK8KCCEL4jHpdqqRQlIMkldztxG0Hv4ZxF15PGaGPpks9+FnAc
         xXEEjmdRW1AjsKY7xvYZn8uDX9E9+ov04ZkzeXhdPEA2bypTRqF3oYl8sK2TE+8S/8wJ
         VGMA==
X-Gm-Message-State: AOAM530KveipxR2n8oCPRL32KTP3JcmHkxnazjtS/QPfvaqf97I3U95X
        FzGsfJu8LzoMTLCfYkOnhkunKA==
X-Google-Smtp-Source: ABdhPJz1X+Yvv3Gf60Ux6dslZLHmcGo2s75ffNy+pTDMIK2LHvMuhKrswzHu65RuNVsJWclcjcnmIQ==
X-Received: by 2002:a17:906:7150:: with SMTP id z16mr15048608ejj.103.1615215335290;
        Mon, 08 Mar 2021 06:55:35 -0800 (PST)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id bt14sm7411234edb.92.2021.03.08.06.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 06:55:34 -0800 (PST)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, elder@kernel.org,
        johan@kernel.org, vireshk@kernel.org, rmfrfs@gmail.com,
        f.fainelli@gmail.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 07/10] spi: spi-falcon: remove check for 'delay_usecs'
Date:   Mon,  8 Mar 2021 16:54:59 +0200
Message-Id: <20210308145502.1075689-8-aardelean@deviqon.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210308145502.1075689-1-aardelean@deviqon.com>
References: <20210308145502.1075689-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'delay_usecs' field is being removed from the spi_transfer struct.
This change removes it from the SPI Falcon driver.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/spi/spi-falcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index d3336a63f462..a7d4dffac66b 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -377,7 +377,7 @@ static int falcon_sflash_xfer_one(struct spi_master *master,
 
 		m->actual_length += t->len;
 
-		WARN_ON(t->delay_usecs || t->delay.value || t->cs_change);
+		WARN_ON(t->delay.value || t->cs_change);
 		spi_flags = 0;
 	}
 
-- 
2.29.2

