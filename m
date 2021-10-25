Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C28439E56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 20:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhJYSTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 14:19:46 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60298
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232840AbhJYSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 14:19:41 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6E03F3F332
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 18:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635185837;
        bh=oCCJcDvPPpYCEpim/tCzuq7YuxbYYlpz5fHWjLFk2qY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=iuMR0PBPtfyPTqB0Y5E7idLBNjwgvuoKNfmgQLEQcdDbnzZ/ggcwsHIt3PN5Bz4Na
         5fpag6GQa9ZSzurKXkXqUK7RpITTxcKW0D2LE6rsqaZq9OEBmMuCEAbCfz7jlTcg8f
         lj6sF9htSKZQLpSdcXSwdQvIa8ouVO0nOdVF3kQHl+w/eS2sQ14Pti/OtijEzEoqfL
         efv6K7cbVfoeefCQR3vhnP9+5pK6i0aZiP0k33vrHRMb+WI4WSolUZDvnrBvCLq6Kg
         pJEBaDc/Xnc9JoNefeFAtAehly5A9mW0kA1rMmkulWR8JRHTK1Lt6Fdtnj5g2TIJkG
         QExFcWCiRBoZg==
Received: by mail-pf1-f199.google.com with SMTP id 2-20020aa79102000000b0044c216dd8ecso6905643pfh.18
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 11:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oCCJcDvPPpYCEpim/tCzuq7YuxbYYlpz5fHWjLFk2qY=;
        b=T6KB5/kgz2qA7hs5pUHRg7e5v2Sg+zej9FFLWPmkdql1edo18c9J09YQCQM+oSe4EU
         5x2g6Aiku8jUUA/NwCWnesZHGhBnnmbmCyqStW3kRBcD2xC6Gl7WPhDhrGG+fYVqDhCy
         AJ8SAGZO2l8QDYGBi6Bvb/J8uUMv9L9Co4M+IJPXXFWdKkAdNIn9iqANkrbS1j7ZEPbf
         1FsgEyeRJfEGmOJwSRZntK6d7HAvARiyTqm4s8Jj7WMvWonhAlyp/8bAo2Jv3eorqlFH
         KZY8ZIqvsIGhIyNlNSqthCsgz6hdhYGbNx6Wd/UQ4yszIJH8HwvBNvPgBJc9tRrTghiw
         OIkg==
X-Gm-Message-State: AOAM532VAq6KBq0HRx157kE3jvqAgAzwJ9mzAiqXn1kIfE4hYPrePzQ1
        fwXwD3g2ILu3WEFrXWbZfE8JGUOk0K4tWHS2rpQIaC2NDcs2Cl9wDcQNlCNaSOzuINJyN70lDac
        9uawhDPd5qq0aGjIck0Yx+oqD6rp2CMXCVhbFes9sqg==
X-Received: by 2002:a05:6a00:22c8:b0:44d:cb37:86e4 with SMTP id f8-20020a056a0022c800b0044dcb3786e4mr20476244pfj.78.1635185835322;
        Mon, 25 Oct 2021 11:17:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3CObGgMZNQaozjZA/TGdwLBc9W8h2QmMpfppjSZMhzt184XyIufQPs/vn8vZR1d/95dpf4A==
X-Received: by 2002:a05:6a00:22c8:b0:44d:cb37:86e4 with SMTP id f8-20020a056a0022c800b0044dcb3786e4mr20476218pfj.78.1635185834990;
        Mon, 25 Oct 2021 11:17:14 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id b8sm19125939pfi.103.2021.10.25.11.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 11:17:14 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     vkoul@kernel.org
Cc:     tim.gardner@canonical.com,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2][linux-next] dmaengine: dw-axi-dmac: Fix uninitialized variable in axi_chan_block_xfer_start()
Date:   Mon, 25 Oct 2021 12:16:56 -0600
Message-Id: <20211025181656.31658-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <YXZBxx8NObaf3x70@matsya>
References: <YXZBxx8NObaf3x70@matsya>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity complains of an uninitialized variable:

5. uninit_use_in_call: Using uninitialized value config.dst_per when calling axi_chan_config_write. [show details]
6. uninit_use_in_call: Using uninitialized value config.hs_sel_src when calling axi_chan_config_write. [show details]
CID 121164 (#1-3 of 3): Uninitialized scalar variable (UNINIT)
7. uninit_use_in_call: Using uninitialized value config.src_per when calling axi_chan_config_write. [show details]
418        axi_chan_config_write(chan, &config);

Fix this by initializing the structure to 0 which should at least be benign in axi_chan_config_write(). Also fix
what looks like a cut-n-paste error when initializing config.hs_sel_dst.

Fixes: 824351668a413 ("dmaengine: dw-axi-dmac: support DMAX_NUM_CHANNELS > 8")
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---

v2 - Use static initializer for 'config'. Drop the memset() call.

---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 79572ec532ef..9a9194da0dcb 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -373,7 +373,7 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 				      struct axi_dma_desc *first)
 {
 	u32 priority = chan->chip->dw->hdata->priority[chan->id];
-	struct axi_dma_chan_config config;
+	struct axi_dma_chan_config config = {};
 	u32 irq_mask;
 	u8 lms = 0; /* Select AXI0 master for LLI fetching */
 
@@ -391,7 +391,7 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 	config.tt_fc = DWAXIDMAC_TT_FC_MEM_TO_MEM_DMAC;
 	config.prior = priority;
 	config.hs_sel_dst = DWAXIDMAC_HS_SEL_HW;
-	config.hs_sel_dst = DWAXIDMAC_HS_SEL_HW;
+	config.hs_sel_src = DWAXIDMAC_HS_SEL_HW;
 	switch (chan->direction) {
 	case DMA_MEM_TO_DEV:
 		dw_axi_dma_set_byte_halfword(chan, true);
-- 
2.33.1

