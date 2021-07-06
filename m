Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E35D3BC6BE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhGFGo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhGFGow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:44:52 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF133C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 23:42:13 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 21so18601725pfp.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 23:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PpGmc45QT32R0wm0g02bbJ9wfXhCNDf+AEu1isgJ9uw=;
        b=tAwdOGH7gjGhKL3gd4Yev8EiNDUWLimEmYoKz0E3x6GE7UuFJramwPnhbrjLCQA0hh
         AORGBdh2/VKPeWel9Mkp6VHk9ca+2V8MHdYdjQHHP2quWlt4odgXRmEG8692gKZ9Xqn1
         rHv2ffMEsozqCLEXdF++zkOUsprIjJU5G/w+CCKvKVh5nQcBlELIqPCRAdtEWpORN5Rl
         Owp63dqV9SOFPHow6MvqqL4aMSkk8lMcOZ36ZLJo8pYqgnDJ0tXIGlftDEBR8UsVQfNs
         ZGvZic1bofxth8I40Gy7mrSvZbfMPdwGkpzWVzDV95L/4zJD+07bYUv7g5U6bk9pVeko
         wcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PpGmc45QT32R0wm0g02bbJ9wfXhCNDf+AEu1isgJ9uw=;
        b=HqYJt1AqMkgV265kpey93jJaa7NfU/+olzMuUWuLAXmt3CzY+eiblQ6lxv++yeO0hj
         IrOZYMMKXog4/Np0Y5qZxdtAFacChT2WybuGssXvxTYQf91jsZye6qMsgaLyN527mr0A
         dmgZE4OvryZpGlQ3+cwUF54albZ1FWKbJ68hyOcITx8OllgrZr/rbf9T6Cz5ZA+0XseY
         0hhAoZlq+epOfs/d1dGUSRF6dXrzTWh8TqJ+bNhePk+sZI9jyPryykzk/FnOp4GmZU6F
         XFLbpzixPIoVQ7pcFfQCgX/OGr+epBM3/PWHw1pcwWbboMX/13lTS9VHFrgETgFxd/H5
         LPUw==
X-Gm-Message-State: AOAM531WGoPrjPiGXYezrCVsKDiCx/sUxMfvh5ERnilYO2MfV59WSECi
        0yE0bKj2drCJeDGGIQsakwE=
X-Google-Smtp-Source: ABdhPJxSWDyxOv+3rgImgZht/D11pytx/MrUzXYBYtvdpLW5VCTPURa1PXne6ctxYsZcxdBRJW93KQ==
X-Received: by 2002:a63:c62:: with SMTP id 34mr13647101pgm.32.1625553733453;
        Mon, 05 Jul 2021 23:42:13 -0700 (PDT)
Received: from ubuntu.localdomain ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id t185sm10664054pfc.1.2021.07.05.23.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 23:42:13 -0700 (PDT)
From:   Gu Shengxian <gushengxian507419@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, Gu Shengxian <gushengxian@yulong.com>
Subject: [PATCH] ASoC: amd: fix spelling mistakes
Date:   Mon,  5 Jul 2021 23:42:07 -0700
Message-Id: <20210706064207.672491-1-gushengxian507419@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gu Shengxian <gushengxian@yulong.com>

Fix some spelling mistakes as follows:
descritor ==> descriptor
descriptore ==> descriptor
contiguos ==> contiguous
initiailize ==> initialize
descriptiors ==> descriptor

Signed-off-by: Gu Shengxian <gushengxian@yulong.com>
---
 sound/soc/amd/acp-pcm-dma.c         | 12 ++++++------
 sound/soc/amd/raven/acp3x-pcm-dma.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 143155a840ac..acb926cb336e 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -156,7 +156,7 @@ static void config_acp_dma_channel(void __iomem *acp_mmio, u8 ch_num,
 	acp_reg_write(priority_level, acp_mmio, mmACP_DMA_PRIO_0 + ch_num);
 }
 
-/* Initialize a dma descriptor in SRAM based on descritor information passed */
+/* Initialize a dma descriptor in SRAM based on descriptor information passed */
 static void config_dma_descriptor_in_sram(void __iomem *acp_mmio,
 					  u16 descr_idx,
 					  acp_dma_dscr_transfer_t *descr_info)
@@ -288,7 +288,7 @@ static void set_acp_to_i2s_dma_descriptors(void __iomem *acp_mmio, u32 size,
 					      &dmadscr[i]);
 	}
 	pre_config_reset(acp_mmio, ch);
-	/* Configure the DMA channel with the above descriptore */
+	/* Configure the DMA channel with the above descriptor */
 	config_acp_dma_channel(acp_mmio, ch, dma_dscr_idx - 1,
 			       NUM_DSCRS_PER_CHANNEL,
 			       ACP_DMA_PRIORITY_LEVEL_NORMAL);
@@ -322,7 +322,7 @@ static void acp_pte_config(void __iomem *acp_mmio, dma_addr_t addr,
 		high |= BIT(31);
 		acp_reg_write(high, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
 
-		/* Move to next physically contiguos page */
+		/* Move to next physically contiguous page */
 		addr += PAGE_SIZE;
 	}
 }
@@ -602,11 +602,11 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
 		acp_reg_write(val, acp_mmio, mmACP_BT_UART_PAD_SEL);
 	}
 
-	/* initiailize Onion control DAGB register */
+	/* initialize Onion control DAGB register */
 	acp_reg_write(ACP_ONION_CNTL_DEFAULT, acp_mmio,
 		      mmACP_AXI2DAGB_ONION_CNTL);
 
-	/* initiailize Garlic control DAGB registers */
+	/* initialize Garlic control DAGB registers */
 	acp_reg_write(ACP_GARLIC_CNTL_DEFAULT, acp_mmio,
 		      mmACP_AXI2DAGB_GARLIC_CNTL);
 
@@ -621,7 +621,7 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
 	acp_reg_write(ACP_SRAM_BASE_ADDRESS, acp_mmio,
 		      mmACP_DMA_DESC_BASE_ADDR);
 
-	/* Num of descriptiors in SRAM 0x4, means 256 descriptors;(64 * 4) */
+	/* Num of descriptors in SRAM 0x4, means 256 descriptors;(64 * 4) */
 	acp_reg_write(0x4, acp_mmio, mmACP_DMA_DESC_MAX_NUM_DSCR);
 	acp_reg_write(ACP_EXTERNAL_INTR_CNTL__DMAIOCMask_MASK,
 		      acp_mmio, mmACP_EXTERNAL_INTR_CNTL);
diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 8148b0d22e88..95e5fa636b0a 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -147,7 +147,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
 		high |= BIT(31);
 		rv_writel(high, rtd->acp3x_base + mmACP_SCRATCH_REG_0 + val
 				+ 4);
-		/* Move to next physically contiguos page */
+		/* Move to next physically contiguous page */
 		val += 8;
 		addr += PAGE_SIZE;
 	}
-- 
2.25.1

