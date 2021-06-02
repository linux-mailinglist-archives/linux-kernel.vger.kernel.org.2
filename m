Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D739639862A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhFBKTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhFBKTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:19:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A76C061756
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f2so1685457wri.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PRiZwQegLpypubO5RDSe3DP9cu33cnkzeqlprh/CdBE=;
        b=ZUfSZ4r0ekbkpPypl3sk1km/yceuPaZX/SY6m3/ZXJ0hdoag99pOdEO8woYlHrGcay
         HCEyu3A9jwOj9rCZzIKhMsCvDO/kzr2Ic/4nbO27wnUZV3htekju4sNnUs+k74DFYjud
         lqP/ilTWQBHCnfFvLrpaWcv4R3HCMTZ2X7M/gx6/Nn2mulCd7hmZFyRoFgB8WYteA9Ss
         dx4NyxcZvuqSDrB606jkskMBbITNsmNc8HeIxDfsx0VOu4Y1ni96TKkOxxdtKRv57Vo1
         5Lf5wsq8t3MnSRHHSaEmgaFOzLCTht+k+dEO0XLXPGe5hG4xSYmPUkxVnsGKsPwgYo5z
         jwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PRiZwQegLpypubO5RDSe3DP9cu33cnkzeqlprh/CdBE=;
        b=YYGGpbaS7kUECF3JwxCYWgKDs09acz+kJZJk4S8XT7UjLVrzcPg9FahqxSDIWENcMY
         lkMKZ7pYc3xp7W6No7SXUXbcHbq9EYkmGVI4wQ26XIEsuTmdX31oHKlpwXbVLawIX5fE
         pOVrsVXjKSXVtWcVua+vXmmAvt45Y9a08pl7hM1//Mn1bU5SqA0vpz3PNMIjbpQZ7IXD
         xld3WIKpQk/08nS0JrDJYsRL5J5K9HL+K8m5/Sp0JXAPpeXSWMht16ITrgVKCb/5mtAM
         vLa7qXAJdCilZ3J3nHJVywiNuZO5AkWhUGZ/vonIyKqW4iXsHGj/pr2Dy4zaAQ7/+aJ5
         g3MQ==
X-Gm-Message-State: AOAM530xk6CAVkVEmnSF7JPACk9XDZg4sEogBO2z/d+WoFiMOFaik68m
        FDU9zxtwPM1wnrxIgSsqcQbpHA==
X-Google-Smtp-Source: ABdhPJyuqmvlr5+2IkzIX35PecGhQyKutFppvcuVEeUcNmlIAib4OdjJW/cMx5u/U616oGKIkq9ssw==
X-Received: by 2002:a5d:5271:: with SMTP id l17mr25855771wrc.142.1622629056202;
        Wed, 02 Jun 2021 03:17:36 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andre Hedrick <andre@linux-ide.org>,
        "Christopher J. Reimer" <reimer@doe.carleton.ca>,
        Benoit Poulot-Cazajous <poulot@chorus.fr>,
        Christian Brunner <chb@muc.de>,
        Robert Bringman <rob@mars.trion.com>, linux-ide@vger.kernel.org
Subject: [PATCH 02/21] ide: ide-dma: Document ide_dma_unmap_sg()'s missing 'cmd' param
Date:   Wed,  2 Jun 2021 11:17:03 +0100
Message-Id: <20210602101722.2276638-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/ide-dma.c:165: warning: Function parameter or member 'cmd' not described in 'ide_dma_unmap_sg'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: "Christopher J. Reimer" <reimer@doe.carleton.ca>
Cc: Benoit Poulot-Cazajous <poulot@chorus.fr>
Cc: Christian Brunner <chb@muc.de>
Cc: Robert Bringman <rob@mars.trion.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/ide-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index 6f344654ef229..a02d02ad9ea23 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -153,6 +153,7 @@ static int ide_dma_map_sg(ide_drive_t *drive, struct ide_cmd *cmd)
 /**
  *	ide_dma_unmap_sg	-	clean up DMA mapping
  *	@drive: The drive to unmap
+ *	@cmd: The IDEcommand
  *
  *	Teardown mappings after DMA has completed. This must be called
  *	after the completion of each use of ide_build_dmatable and before
-- 
2.31.1

