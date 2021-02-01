Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE1730AB82
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhBAPey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhBAOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:41:28 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2D6C0617AA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:39:52 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i9so13408578wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bku/TZDwGiY5vuh8zroI/7gSSOC7kKg9Wo8De+jk1lQ=;
        b=XCEabafGuemjP1gHa/5Xw5MSj0MuP0PquR4NvFr1yb8kbn3KLr8XI51ghFUwxjmjtb
         EMCfX9DQ2UCxv1vxTyJHuDfrHPoONZ2KQblr2bZtBHkGBLDokAW8foKVYhpMotiuRXUC
         7ZqdxGZUINgl233YDbGXfPeXCqnvaW0smpv9zfiJlxemAW4xYidNk24MIdbEkMxKJEux
         RzwSsopK79UNjf/BwZkkvQfq/3BrqE7BM5ALD568moghnjCvDK92ydVS+aK8KCsZOkoJ
         muswkVkTtJZXJlZBobBcOASS68KtGdceyC1xoRV/GZkDor+g5XPsIRX5L0IvzEU8eQmL
         8Jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bku/TZDwGiY5vuh8zroI/7gSSOC7kKg9Wo8De+jk1lQ=;
        b=kXeTEGL00WCG6z3N/ypOijTbnEfzIhyxCnIixQUgKAxWIpeffZlWTRmhayRo/kD9Q1
         IeDN3eIeKxInh356h90YvKDzTGjEqFuzEcLSaWDzDhG+oDoidPoUy6ebxWCU4GUVy2C7
         rkHSiVK76l07fxjT4UcWNiz7Y2R5amNKDXTmKjp+d6QjOw15+euW6N/l3zxpkf7IQ8WT
         M1D7JbIpRMgcFlXdB2RVxcC4FzlDWwPWHZWkA/GwwUK5yQeIntMilPTtxDuAUsIN9izU
         nC0G5X4IaH8HFcyz1mWue3dYIq4bzY3wzg/f/MYSLJHTXiaCBOOXg12FUgBa7TrWxJ8J
         z2Eg==
X-Gm-Message-State: AOAM533V+rVSIYfEHqHgazmM4UpW1HRHKm7xq9FjviT4O6axxHZfoUKT
        Hx0PCRiRq4KTjEUo2HDVvY6IHnzL8vcPkB2i
X-Google-Smtp-Source: ABdhPJx00o3B7KG5YWycXJnUp+FrSSgY1g5OgGjWmWV4YzRws8GYDs6sikt6/4gGY6Wdo6s34X5ILA==
X-Received: by 2002:a1c:7914:: with SMTP id l20mr15820968wme.85.1612190391549;
        Mon, 01 Feb 2021 06:39:51 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>, linux-ide@vger.kernel.org
Subject: [PATCH 07/20] ata: pata_hpt366: Provide missing description for 'hpt366_filter()'s 'mask' param
Date:   Mon,  1 Feb 2021 14:39:27 +0000
Message-Id: <20210201143940.2070919-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_hpt366.c:200: warning: Function parameter or member 'mask' not described in 'hpt366_filter'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_hpt366.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 2574d6fbb1ad3..06b7c4a9ec954 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -192,6 +192,7 @@ static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
 /**
  *	hpt366_filter	-	mode selection filter
  *	@adev: ATA device
+ *	@mask: Current mask to manipulate and pass back
  *
  *	Block UDMA on devices that cause trouble with this controller.
  */
-- 
2.25.1

