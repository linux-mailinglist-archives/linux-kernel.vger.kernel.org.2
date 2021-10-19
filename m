Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F18433EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 21:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbhJSTJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 15:09:27 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51050
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231355AbhJSTJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 15:09:26 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0341F40019
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 19:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634670432;
        bh=IHhtpDD/c4GM+dyAw7Uqm0bjhmnwIgmCSyCGp6YU3is=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=I9vaq8Kxfas4X+fb+5jE3U3qZh69r612YvYQ9njYWHhkteigsHpbfkvTdSVgRMF5F
         fqqXerH5BXGJ2ay+YRPbrSk4o+ZnXXgKfslcYrf6SOXhdt2NI28Fna6Q66DCvLZMx/
         aL2dv1BXLLbPXLAkNsgeUwFrSPGLX6ELQS2+NaYq1kMG0d0LCpiOUuaB9TCXLZqTBS
         l28pZFF0WSh8EfG1/PyuTybo8IHkMIUxvafariG7t+bzR2y+Q9XyE6A5sNSpUvEoJj
         aMdF+ir0xOkps3eVD455pHkyN8p2lY1bjFphz8KvBaZgy/New2j88Ojz8472luYz6f
         w2ViuhbgOyGSw==
Received: by mail-pf1-f197.google.com with SMTP id 192-20020a6214c9000000b0044dd26fc75eso448664pfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 12:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IHhtpDD/c4GM+dyAw7Uqm0bjhmnwIgmCSyCGp6YU3is=;
        b=rGiCxBkAMEITWS60OE9Pg1dNYBOExj90GPZ886zoIHRd73iG7yZMCGP+uejpukaPEM
         qdlPsLxg4G0CIuJ0y2t/GQr7I7feJ29IufUE5O4H8/ghrEWqEn1SkbNTA29EXzsBNw4N
         +SV2EC40HSxfSblKIDpMPxoq1Z0VgLN+ZQFf58tmvuo3x1xC3UFoGrzmrurqILlqWGbv
         9saT2CPn2CuGWGfQ7lcz4v41/Q+QQcgaR1d6o93Kj4WfaigU4y1Gr7kpGx9ekKLGoUhA
         xw2qqc+991M2q8BgCbHgkctr643nMlnztFSGZON67Vz6gHjgdTH5M/JhGwNIwYGtviVw
         J0kQ==
X-Gm-Message-State: AOAM5319EW5dcGq50QTCCmVu1tFzgBuWNALaI5eHjAKvDiktjyyhTmEa
        tKh1id0R9TL1g69+BHbpu2BFggUzaelO96X8nlf/XJj7I+mpr43GZew1OZOvoNkHCaPKo+ac33u
        egRMlh1lbKzri/Me+9C7gELtsHGJcLOjc+svYRAHavQ==
X-Received: by 2002:a63:7a13:: with SMTP id v19mr70511pgc.364.1634670430434;
        Tue, 19 Oct 2021 12:07:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXKnuR0/p6MrR7zQlukcDGNWx9AKNMfc6f2mEPmd6KsrmsgQbTqlky7rw/lE+qyPrzzM+m+A==
X-Received: by 2002:a63:7a13:: with SMTP id v19mr70491pgc.364.1634670430221;
        Tue, 19 Oct 2021 12:07:10 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id s52sm1515pfw.4.2021.10.19.12.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 12:07:09 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     dmaengine@vger.kernel.org
Cc:     tim.gardner@canonical.com,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH][linux-next] dmaengine: dw-axi-dmac: Fix uninitialized variable in axi_chan_block_xfer_start()
Date:   Tue, 19 Oct 2021 13:07:01 -0600
Message-Id: <20211019190701.15525-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.1
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

Fix this by clearing the structure which should at least be benign in axi_chan_config_write(). Also fix
what looks like a cut-n-paste error when initializing config.hs_sel_dst.

Fixes: 824351668a413 ("dmaengine: dw-axi-dmac: support DMAX_NUM_CHANNELS > 8")
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 79572ec532ef..f47116e77ea1 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -386,12 +386,13 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 
 	axi_dma_enable(chan->chip);
 
+	memset(&config, 0, sizeof(config));
 	config.dst_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
 	config.src_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
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

