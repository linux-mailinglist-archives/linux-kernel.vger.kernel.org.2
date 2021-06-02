Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD38C39863E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhFBKUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbhFBKTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:19:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57D1C06134B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so1380002wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5jQZgJxLSK97kuij2epKKmjGvDzAp1XS69EVQaGkB+E=;
        b=bI/Id/J3vE+NpunaijQxocoJVdgJYwNjSXzd39GknOcYqzeVoEtr5PF9IRtaZSL1GF
         KIDxwvDXXDXDGjhAAJqKZnd0S/6Zs/ARBaH5p8v9W3AgWLB9SRg0wmT/rmrvo1AS6FWG
         JwM1Nnft7kWRMZ07XcPks8lcCKy98Gf1n2WIvp0nmtzXoU91fxGGs+YukkyDm7Ci96FX
         9HZRlUIeLKL1YG96yaoW9CxhWwF2Xqn9cc9GWa9bwKenw/wNMArfrpZ6rUzJKQlVKYPE
         7R2U9f+yvvnzSXpkXdtL3nZxg8Dy0mUsO9WMyTXA6VMjju/7xu7I3kbxWFB9puESmZwW
         gMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5jQZgJxLSK97kuij2epKKmjGvDzAp1XS69EVQaGkB+E=;
        b=AlVURCzm+SNQlDM1ZFDUS0fnq43af+rKOW26mrNo3Ysg3ieac38zS4C53sSdMXoBu0
         YlmxTwk/3CQBVpJfGe9X+rLvCtwMDOi8DW+tPRW7IdvcW5ECHdaDzWxevslEDvX8OKky
         ZSpej5y3np1LIf9joux0aFrkRMQ1RJwzXu5NnPnRsw+gnJ+rS6RaXPr0v6Bzc+0/Fp0g
         UCvTcmcvByWg4CoSIfhvCmojmweZ28mtjyp+Tch4O1gMbmCtRB0NgJJWeVCTCgaA/xeV
         nXYnTtDBchBykAI+wJZe190H13ZnnmH1VCHgjfH+adefG+utgQWkS1LgMYs4+1m7lhT8
         qrzg==
X-Gm-Message-State: AOAM532VdmruLm7vgq4YJd0kQOWmyVAHeswslCaguEMFmQK3FBB0AIl0
        C0S2XeMMacX8FW7928DWMa4zAw==
X-Google-Smtp-Source: ABdhPJzWreFQP4zXN2JQs++LA7F3tdEPIobN3r9eUGUZA2C1/ySjJZUxwndWSVJdLTuVNfCsWNlMlA==
X-Received: by 2002:a1c:5452:: with SMTP id p18mr18527827wmi.176.1622629065245;
        Wed, 02 Jun 2021 03:17:45 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Subject: [PATCH 12/21] ide: it821x: Fix a couple of incorrectly documented functions
Date:   Wed,  2 Jun 2021 11:17:13 +0100
Message-Id: <20210602101722.2276638-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/it821x.c:362: warning: expecting prototype for it821x_dma_read(). Prototype was for it821x_dma_start() instead
 drivers/ide/it821x.c:384: warning: expecting prototype for it821x_dma_write(). Prototype was for it821x_dma_end() instead

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/it821x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/it821x.c b/drivers/ide/it821x.c
index aad746007330c..e7c965c3703e5 100644
--- a/drivers/ide/it821x.c
+++ b/drivers/ide/it821x.c
@@ -346,7 +346,7 @@ static void it821x_tune_udma(ide_drive_t *drive, u8 mode_wanted)
 }
 
 /**
- *	it821x_dma_read	-	DMA hook
+ *	it821x_dma_start	-	DMA hook
  *	@drive: drive for DMA
  *
  *	The IT821x has a single timing register for MWDMA and for PIO
@@ -372,7 +372,7 @@ static void it821x_dma_start(ide_drive_t *drive)
 }
 
 /**
- *	it821x_dma_write	-	DMA hook
+ *	it821x_dma_end	-	DMA hook
  *	@drive: drive for DMA stop
  *
  *	The IT821x has a single timing register for MWDMA and for PIO
-- 
2.31.1

