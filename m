Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3963B186B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 13:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFWLIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 07:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhFWLID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:08:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799CBC061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 04:05:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j2so2130111wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 04:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VrP53t654miViEUlN/kTL6ZRv5Lu9b3sPzleMbHOxAg=;
        b=miXC/qassTEiNGUmrnaTmSpxk44/YwQgPgWvxKIZWzbc6/ud2I8hh/KlHfSonaatj0
         DfX6Ex3CF4oj5o9E3CmbSDntRflDnKrFNCYx+zJbWuCng2vs0Vefc7FwFKUv6sMacly1
         oFYSfdIsrmRaFnFwr5jDvt/uN83CgiIKMyOdYVa/tJhs1JhO2zp7y4pvpstroIDjlLHY
         mvfdw6IQV4Q3tJWqPzRUJhbEputWdI2PYNYiTbR1uywcqFt2bsdfaAuS8FOA62/vJz8Z
         jATTuc1XdfgRce33VaQRjYTveAmurmoA2ItrRswilJBeo01kDeQV5lmVQlxtdpFyPm6U
         7IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=VrP53t654miViEUlN/kTL6ZRv5Lu9b3sPzleMbHOxAg=;
        b=OsAWvvBxBmXD3ZJaoCz6CGkSSaMbvwUWECx7qctgh49dZKp0+w0IE8+jCgudLkiw4g
         XmJZV4CQEpHnL9+CBfEKbv3wREvnaTS+hrT8muWJqqIbMP/6tWjHg8o1vfaewDE1Lxr5
         ntaMHvZHjzM0j44pKnOrrqAAtrdHJR9YOPmQp2AGa9awafNwqpI5wKElXIMNngLf8ffJ
         IgZJUS4AOPndaZSXvCmwOC3GBpiXleoDPXvNT4gusGv1v+REtUhbb+Fwd8JCdRjejon5
         4lIil8s037uNWUoHTeS6xGHuqX1YUgi5m2A2BU25MxLxpkcBFG4BtdVg1nTQmHwOZnlq
         cfrw==
X-Gm-Message-State: AOAM531CO8rZs8l9hphZ5IcW26EU0r6S3c3zG5bPAzr7f+bxOihWCaGP
        LqOv/ZwlI6NdqW+mE6O+Uj/NagKMKPFrDcE8
X-Google-Smtp-Source: ABdhPJwCPwjeAazziI/4KWhsI4RYkBAhF3n22UDkt1gDlea6vNmEuEwEMViFylVBZ3sd/gjdovVaeg==
X-Received: by 2002:a5d:5187:: with SMTP id k7mr7660094wrv.395.1624446343898;
        Wed, 23 Jun 2021 04:05:43 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::648])
        by smtp.gmail.com with ESMTPSA id 197sm5963115wmb.20.2021.06.23.04.05.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jun 2021 04:05:43 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dmaengine: xilinx: dpdma: Use kernel type u32 over uint32_t
Date:   Wed, 23 Jun 2021 13:05:39 +0200
Message-Id: <9569008794d519b487348bfeafbfd76c5da5755e.1624446336.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use u32 kernel type instead of uint32_t. Issue is reported by
checkpatch.pl --strict.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/dma/xilinx/xilinx_dpdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 539f1a42ca72..0b67083c95d0 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -1600,7 +1600,7 @@ static struct dma_chan *of_dma_xilinx_xlate(struct of_phandle_args *dma_spec,
 					    struct of_dma *ofdma)
 {
 	struct xilinx_dpdma_device *xdev = ofdma->of_dma_data;
-	uint32_t chan_id = dma_spec->args[0];
+	u32 chan_id = dma_spec->args[0];
 
 	if (chan_id >= ARRAY_SIZE(xdev->chan))
 		return NULL;
-- 
2.32.0

